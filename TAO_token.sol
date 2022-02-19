//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token_TAO is ERC20{
    constructor() ERC20("TAO TOKEN", "TAO"){
        _mint(msg.sender, 100000*10**18); // wei of 100k = 100k x 10 mũ 18
        
    }
}