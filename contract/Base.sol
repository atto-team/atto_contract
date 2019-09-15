pragma solidity >=0.4.24 <=0.5.6;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC20/IERC20.sol";


contract BaseToken is IERC20 {
    using SafeMath for uint256;

    bytes private _name;
    bytes private _symbol;
    uint8 private _decimals;

    constructor() internal {
        _name = bytes("NineMonsters");
        _symbol = bytes("NMP");
        _decimals = 18;
    }

    function name() public view returns (string memory) {
        return string(_name);
    }

    function symbol() public view returns (string memory) {
        return string(_symbol);
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function unit(uint256 amount) internal returns (uint256) {
        return amount * (10 ** uint256(decimals()));
    }

}


