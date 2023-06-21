// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/FlashLoan.sol";

contract FlashLoanTest is Test {
    event FlashLoanReceived();

    FlashLoan public flashLoan;

    address constant public ASSET = 0x68194a729C2450ad26072b3D33ADaCbcef39D574;
    uint256 constant public AMOUNT = 10 ether;

    function setUp() public {
        flashLoan = new FlashLoan();
        deal(ASSET, address(flashLoan), AMOUNT);
    }

    function testFlashLoan() public {
        vm.expectEmit(false, false, false, false);
        emit FlashLoanReceived();
        flashLoan.flashloan();
    }
}