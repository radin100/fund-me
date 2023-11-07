// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    FundMe fundMe;

    function run() external returns (FundMe) {
        address priceFeedAddress = new HelperConfig().activeNetworkConfig();
        vm.startBroadcast();
        fundMe = new FundMe(priceFeedAddress);
        vm.stopBroadcast();
        return (fundMe);
    }
}
