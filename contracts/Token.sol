// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Token {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    //Events - events are fired when a transfer or an approval happens
    event Transfer(address indexed from, address indexed to, uint256 value); 
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor (string memory _name, string memory _symbol, uint _decimals, uint _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply;
    }

    //checks before transfer if the sender has the amount of tokens they want to send
    function transfer(address _to, uint256 _value) external returns(bool success) {
        require(balanceOf[msg.sender] >= _value);
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        // checks if address is valid and begins with 0x
        require(_to != address(0));
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(_from, _to, _value);
    }

}

// 1000000000000000000000000