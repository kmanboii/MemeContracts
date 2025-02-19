// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/UnoRouter.sol"; // Replace with your actual contract

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address permit2 = 0x000000000022D473030F116dDEE9F6B43aC78BA3;
        address initialOwner = 0xA317391921DC20fF1AB2c06071C3f55DC09d96Bd;
        address[] memory swapTargets = new address[](1);
        swapTargets[0] = 0x000000000022D473030F116dDEE9F6B43aC78BA3;

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy the implementation contract
        UnoRouter implementation = new UnoRouter(initialOwner, swapTargets, ISignatureTransfer(permit2));

        vm.stopBroadcast();

        console.log("UnoRouter deployed to:", address(implementation));
    }
}
