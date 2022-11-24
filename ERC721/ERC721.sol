//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./IERC165.sol";
import "./IERC721.sol";
import "./IERC721Receiver.sol";
import "./IERC721Metadata.sol";
import "./Address.sol";
import "./String.sol";

contract ERC721 is  IERC721, IERC721Metadata{

    using Address for address;//使用Address库给address，可以判断地址是否为合约
    using Strings for uint256;//使用Strings给uint，可以转换成字符串

    string public override name;

    string public override symbol;

    mapping(uint => address) private _owners;

    mapping(address => uint) private _balances;

    mapping(uint => address) private _tokenApprovals;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    //实现IERC165接口supportsInterface
    //函数参数bytes array mapping struct需要声明是否memory，bytes4不需要 定长
    function supportsInterface(bytes4  interfaceId) external pure override returns (bool) {
        return (
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId
        );
    }
    
    //实现IERC721的balanceOf，利用_balances变量查询owner地址的balance
    function balanceOf(address owner) external view override returns (uint) {
        require( owner != address(0), "owner = zero address");
        return _balances[owner];
    }

    //实现IERC721的ownerOf，利用_owners变量查询tokenId的owner
    function ownerOf(uint tokenId) public view override returns (address owner) {
        owner = _owners[tokenId];
        require( owner != address(0), "token doesnot exist");
    }

    //实现IERC721的isApprovedForAll，利用_operatorApprovals变量查询owner地址是否将所持NFT批量授权给了operator地址
    function isApprovedForAll(address owner, address operator) external view override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    //实现IERC721的setApprovalForAll,将持有的所有代币全部授权给operator地址
    function setApprovalForAll(address operator, bool approved) external override {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    //实现IERC721的getApproved，利用_tokenApprovals变量查询tokenId的授权地址
    function getApproved(uint tokenId) external view override returns (address) {
        require(_owners[tokenId] != address(0), "token doesnot exist");
        return _tokenApprovals[tokenId];
    }

    //授权函数，通过调整_tokenApprovals，授权to地址操作tokenId，同时释放approval事件
    function _approve(address owner, address to, uint tokenId) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    //实现IERC721的approve,将tokenId授权给to地址
    function approve(address to, uint tokenId) external override {
        address owner = _owners[tokenId];
        require( msg.sender == owner || _operatorApprovals[owner][msg.sender], "not owner nor approved for all");
        _approve(owner, to, tokenId);
    } 

    //查询spender地址是否可以使用tokenId（它是owner或被授权地址）
    function _isApprovedOrOwner(address owner, address spender, uint tokenId) private view returns(bool) {
        return (
            spender == owner ||
            _tokenApprovals[tokenId] == spender ||
            _operatorApprovals[owner][spender]
        );
    }

    //转账函数，通过调整_balances和_owners变量将tokenId从from转账给to，并且释放Transfer事件
    //条件：tokenId被from拥有；to地址不能为0地址
    function _transfer(address owner, address from, address to, uint tokenId) private {
        require(from == owner, "not owner");
        require(to != address(0), "transfer to the zero address");

        _approve(owner, address(0), tokenId);

        _balances[to] += 1;
        _balances[to] -= 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    //实现IERC721的transferFrom，非安全转账，不建议使用。调用_transfer函数
    function transferFrom(address from, address to, uint tokenId) external override {
        address owner = ownerOf(tokenId);
        require( _isApprovedOrOwner(owner, msg.sender, tokenId), "not owner nor approved");
        _transfer(owner, from, to, tokenId);
    }

    //安全转账，安全的将tokenId代币从from转到to，会检查合约接收者是否了解ERC721协议，以防止代币被永久锁定。
    //调用了_transfer和_checkOnERC721Received函数
    //条件：from和to不能是0地址；tokenId代币必须存在，并且被from拥有；如果to是合约地址，还需要支持IERC721-onERC721Received
    function _safeTransfer(address owner, address from, address to, uint tokenId, bytes memory _data) private {
        
        require( _checkOnERC721Received(from, to, tokenId, _data),  "not Receiver");
       _transfer(owner, from, to, tokenId);
    }

    //实现IERC721的safeTransferFrom，安全转账，调用了_safeTransfer函数
    function safeTransferFrom( address from, address to, uint tokenId, bytes memory _data) public override {
        address owner = ownerOf(tokenId);
        require( _isApprovedOrOwner(owner, msg.sender, tokenId), "not owner nor approved");
        _safeTransfer(owner, from, to, tokenId, _data);
    }

    //safeTransferFrom的重载函数
    function safeTransferFrom( address from, address to, uint tokenId) external override {
        safeTransferFrom(from, to, tokenId, "");
    }

    //铸造函数，通过调整_balances和_owners变量来铸造tokenId并转账给to，同时释放Transfer事件
    //mint函数内部调用，实际使用需要开发人员重写，加上一些条件
    //条件：tokenId不存在；to地址不能是0地址
    function _mint(address to, uint tokenId) internal virtual {
        require( to != address(0), "mint to zero address!");
        require( _owners[tokenId] == address(0), "token already minted");

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    //销毁函数，通过调整_balances和_owners变量来销毁tokenId，同时释放Transfer事件
    //条件：tokenId存在。
    function _burn(uint tokenId) internal virtual {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner, "not owner of token");

        _approve(owner, address(0), tokenId);
        _balances[owner] -= 1;
        delete _owners[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }

    //_checkOnERC721Received函数用于在to为合约的时候调用IERC721Receiver-onERC721Received,以防tokenId被一不小心转入黑洞
    function _checkOnERC721Received(address from, address to, uint tokenId, bytes memory _data) private returns (bool) {
        if (to.isContract()) {
            return IERC721Receiver(to).onERC721Received(msg.sender,from,tokenId,_data) == IERC721Receiver.onERC721Received.selector;
        } else {
            return true;
        }
    } 

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_owners[tokenId] != address(0), "Token Not Exist");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }
}