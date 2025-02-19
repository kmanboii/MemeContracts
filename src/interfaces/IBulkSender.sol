// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IBulkSender {
    function feePerRecipient() external view returns (uint256);

    function sendERC1155(address token, address[] calldata recipients, uint256[] calldata amounts) external payable;

    function sendERC20(address token, address[] calldata recipients, uint256[] calldata amounts) external payable;
}
