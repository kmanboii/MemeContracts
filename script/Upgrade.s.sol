// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ITransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "../src/MCV2_Bond.sol";

contract UpgradeScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address proxyAddress = 0xDa601604ECd1Cb5f12e4522f1138D5419DaF0eE0;
        address proxyAdminAddress = 0xAC3B671B948e2E5c83E25781339De01D4bAb77A7;

        vm.startBroadcast(deployerPrivateKey);

        // Deploy new implementation
        MCV2_Bond newImplementation = new MCV2_Bond();

        // Get ProxyAdmin instance
        ProxyAdmin proxyAdmin = ProxyAdmin(proxyAdminAddress);

        // Upgrade proxy to new implementation
        proxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(proxyAddress),
            address(newImplementation),
            // abi.encodeWithSignature("reinitialize()"),
            ""
        );

        vm.stopBroadcast();

        console.log("New implementation deployed to:", address(newImplementation));
        console.log("Proxy upgraded at:", proxyAddress);
    }
}
