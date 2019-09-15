pragma solidity >=0.4.24 <=0.5.6;

import "./Base.sol";
import "./Usable.sol";

contract NMP is BaseToken, Usable {
    uint256 private _totalSupply;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function allowance(address sender, address spender) public view returns (uint256) {
        return _allowances[sender][spender];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "amount from exceeds allowance"));
        return true;
    }

    function mint(address account, uint256 amount) public onlyMinter returns (bool) {
        _mint(account, amount);
        return true;
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) public onlyMinter {
        _burn(account, amount);
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "transfer: sender to address(0)");
        require(recipient != address(0), "transfer: recipient to address(0)");

        _balances[sender] = _balances[sender].sub(amount, "transfer: amount from exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "mint: mint to address(0)");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "burn: burn to address(0)");

        _balances[account] = _balances[account].sub(amount, "burn: amount from exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
    }

    function _approve(address sender, address spender, uint256 value) internal {
        require(sender != address(0), "approve: sender to address(0)");
        require(spender != address(0), "approve: spender to address(0)");

        _allowances[sender][spender] = value;
        emit Approval(sender, spender, value);
    }

}
