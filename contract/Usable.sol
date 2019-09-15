pragma solidity >=0.4.24 <=0.5.6;


library Access {
    struct Role {
        mapping (address => bool) roles;
    }

    function add(Role storage role, address account) internal {
        require(!exists(role, account), "minter: account already");
        role.roles[account] = true;
    }

    function remove(Role storage role, address account) internal {
        require(exists(role, account), "minter: account does not minter");
        role.roles[account] = false;
    }

    function exists(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "minter: account is zero");
        return role.roles[account];
    }
}


contract Usable {
    using Access for Access.Role;
    Access.Role private _minters;

    event MinterAdd(address indexed account);
    event MinterRemove(address indexed account);

    constructor () internal {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() {
        require(_minters.exists(msg.sender), "Caller does not minters");
        _;
    }

    function addMinter(address account) external onlyMinter {
        _addMinter(account);
    }

    function removeMinter(address account) external {
        _removeMinter(account);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdd(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemove(account);
    }

}