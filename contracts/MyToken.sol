// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract MyToken {
  // Token metadata
  string public name = "My Token";
  string public symbol = "MTK";
  uint8 public decimals = 18;
  uint256 public totalSupply;

  // Balances for each account
  mapping(address => uint256) public balanceOf;

  // Owner of account approves the transfer of an amount to another account
  mapping(address => mapping(address => uint256)) public allowance;

  // Events as per ERC-20 standard
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  // Constructor to initialize the token
  constructor() {
    // Calculate total supply with decimals: 1,000,000 tokens * 10^18
    totalSupply = 1000000 * (10 ** uint256(decimals));
    // Assign all tokens to the deployer
    balanceOf[msg.sender] = totalSupply;
    // Emit initial transfer event from address(0) to deployer
    emit Transfer(address(0), msg.sender, totalSupply);
  }

  // Transfer tokens from msg.sender to a recipient
  function transfer(address _to, uint256 _value) public returns (bool success) {
    require(_to != address(0), "Cannot transfer to zero address");
    require(balanceOf[msg.sender] >= _value, "Insufficient balance");

    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;

    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  // Approve a spender to spend tokens on behalf of msg.sender
  function approve(address _spender, uint256 _value) public returns (bool success) {
    require(_spender != address(0), "Cannot approve zero address");

    allowance[msg.sender][_spender] = _value;

    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  // Transfer tokens from one address to another using allowance
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(_from != address(0), "Cannot transfer from zero address");
    require(_to != address(0), "Cannot transfer to zero address");
    require(balanceOf[_from] >= _value, "Insufficient balance");
    require(allowance[_from][msg.sender] >= _value, "Insufficient allowance");

    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;
    allowance[_from][msg.sender] -= _value;

    emit Transfer(_from, _to, _value);
    return true;
  }
}