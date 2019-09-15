pragma solidity >=0.4.24 <=0.5.6;

contract Exchangeable {

    address private _owner;

    event Exchange(address indexed account, uint256 value);

    constructor() internal {
        _owner = msg.sender;
    }

    function exchange() public payable {
        _exchange(msg.sender, msg.value);
    }

    function _exchange(address account, uint256 amount) internal {
        uint compensate = unit(amount * 10);
        _owner.transfer(amount);
        _balances[account] = _balances[account].add(compensate);
        emit Exchange(account, amount);
    }

}