// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {ISignatureTransfer} from "@uniswap/permit2/src/interfaces/ISignatureTransfer.sol";

interface MCV2_ICommonToken {
    function totalSupply() external view returns (uint256);
    function mintByBond(address to, uint256 amount) external;
    function burnByBond(address account, uint256 amount) external;

    function decimals() external view returns (uint8);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function transfer(address to, uint256 value) external returns (bool);
}
