//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MyShop{
    IERC20 public tokenTAO;
    address owner;
    
    // TAO: 0x7BA1e78BCd5D6Bab7f93A3B1Ac300F936EA7B517
    // MyShop: 0x0297536360F36340682ADA49189366a479Bc03D9
    // Account 1: 0xa79709d4e9c30D4C56829cfE2E3FAF0d2aeC60f1
    // Account 2: 0x43A65223Db0CE89C00402cb023BACe75a954d63e

    constructor(){
        owner = msg.sender;
        tokenTAO = IERC20(0x7BA1e78BCd5D6Bab7f93A3B1Ac300F936EA7B517);
    }

    // hàm này dùng để cài lại token khác thay cho TAO (line 16)
    // ví dụ shop muốn đổi từ TAO sang SHIBA
    function updateToken(address newAddress) public{
        tokenTAO = IERC20(newAddress);
    }

    function buyToken() public payable{
        // tỉ lệ qui đổi khi mua TAO do mình qui định,
        // còn qui đổi từ BNB sang TAO sẽ dùng qui tắc tam suất
        // 1 BNB            = 1,000 Finney
        // 0.01 BNB         = 100 TAO
        // 1 BNB(wei)       = 100,000 TAO
        //  xxx BNB(wei)    = ?
        tokenTAO.transfer(msg.sender, msg.value * 10000);
    }

    function sellToken(uint tokenAmt) public {
        // create request for sender approval
        tokenTAO.transferFrom(msg.sender, address(this), tokenAmt);
        // after sender approval, call transfer()
        // 1 BNB(wei)       = 10,000 TAO
        //  xxx BNB(wei)    = tokenAmt
        payable(msg.sender).transfer(tokenAmt/10000);

        /*
        before sell
        1.8039 BNB
        91000 TAO

        sell tokenAmt = 100 Finney (100000000000000000000 wei)
        [remind]
        go to TAO address -> approve tokenAmt for Shop address

        after sell
        1.8128 BNB
        90900 TAO
        */
    }

}