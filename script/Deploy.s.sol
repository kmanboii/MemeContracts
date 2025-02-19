// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "../src/MCV2_Bond.sol"; // Replace with your actual contract

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Get constructor parameters from environment
        address tokenImplementation = 0x60aB0701D125878E1f9310D6C98b02BBCe436fde;
        address protocolBeneficiary = 0x69C63C82Fb8C822e10E5E5115D7A7786C206d7A4;
        uint256 creationFee = 0;
        uint256 maxSteps = 500;
        address permit2 = 0x000000000022D473030F116dDEE9F6B43aC78BA3;
        address paymentToken = 0x2cFc85d8E48F8EAB294be644d9E25C3030863003;
        address initialOwner = 0xA317391921DC20fF1AB2c06071C3f55DC09d96Bd;

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy the implementation contract
        MCV2_Bond implementation = new MCV2_Bond();

        // 2. Prepare initialization data
        bytes memory initData = abi.encodeWithSelector(
            MCV2_Bond.initialize.selector,
            tokenImplementation,
            protocolBeneficiary,
            creationFee,
            maxSteps,
            permit2,
            paymentToken,
            initialOwner
        );

        // 3. Deploy TransparentUpgradeableProxy
        TransparentUpgradeableProxy proxy =
            new TransparentUpgradeableProxy(address(implementation), initialOwner, initData);

        vm.stopBroadcast();

        console.log("Implementation deployed to:", address(implementation));
        console.log("Proxy deployed to:", address(proxy));
    }
}
