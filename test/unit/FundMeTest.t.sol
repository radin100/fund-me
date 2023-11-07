// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("buba");
    uint256 constant SEND_VALUES = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        fundMe = new DeployFundMe().run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinUsdFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testIsOwner() public {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testVersion() public {
        assertEq(fundMe.getVersion(), 4);
    }

    function testFailsFunds() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundData() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUES}();

        uint256 amountFunded = fundMe.getAdressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUES);
    }

    function testFundUpdadesArray() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUES}();

        address userAddress = fundMe.getFunder(0);

        assertEq(userAddress, USER);
    }

    // function testOnlyOwnerWithdraw() public {
    //     vm.expectRevert();
    //     vm.prank(USER);
    //     fundMe.withdraw();
    // }
}
