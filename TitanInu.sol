// ------------------------------------------------------------------------------------------------------
// Titan Inu token contract
//
// Symbol           : TITAN
// Name             : Titan Inu
// Total supply     : 1e12
// Decimals         : 9
// Owner account    :
//
// SPDX-License-Identifier: UNLICENSED
// ------------------------------------------------------------------------------------------------------


pragma solidity ^0.8.4;

// ------------------------------------------------------------------------------------------------------
// Contract: Context 
// abstract contract used in place of msg.sender for security purposes can also be used with msg.data
// ------------------------------------------------------------------------------------------------------
abstract contract Context {
    /**
    * @dev Returns the address of the current owner.
    */
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

// ------------------------------------------------------------------------------------------------------
// Interface: IERC20
// required to implement this interface by ERC20 standards for fungible tokens
// ------------------------------------------------------------------------------------------------------
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// ------------------------------------------------------------------------------------------------------
// Library: SafeMath
// Library used in blockchain transactions to avoid number errors
// ------------------------------------------------------------------------------------------------------
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if(a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// ------------------------------------------------------------------------------------------------------
// Contract: Ownable
// Basic access control mechanism that grants exclusive access to specific functions
// ------------------------------------------------------------------------------------------------------
contract Ownable is Context {
    address private _owner;
    address private _previousOwner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}


contract TitanInu is Context, IERC20, Ownable {
    using SafeMath for uint256;
    mapping(address => uint256) private _rOwned;
    mapping(address => uint256) private _tOwned;
    mapping (address => mapping (address => uint256)) private _allowances;

    string private _name = 'Titan Inu';
    string private _symbol = 'TITAN';
    uint8 private _decimals = 9;

    uint256 private constant MAX = ~uint256(0);
    uint256 private _tTotal = 1e12 * 10**9;
    uint256 private _rTotal = (MAX - (MAX % _tTotal));
    uint256 private _tFeeTotal;
    
    bool private inSwap = false;
    modifier lockTheSwap {
        inSwap = true;
        _;
        inSwap = false;
    }
    constructor(address payable FeeAddress, address payable marketingWalletAddress) {
         _FeeAddress = FeeAddress;
        _marketingWalletAddress = marketingWalletAddress;
        _rOwned[_msgSender()] = _rTotal;
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[FeeAddress] = true;
        _isExcludedFromFee[marketingWalletAddress] = true;
    }

     function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
         
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {

    }

    function allowance(address owner, address spender) external view returns (uint256) {

    }

    function approve(address spender, uint256 amount) external returns (bool) {

    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {

    }
}