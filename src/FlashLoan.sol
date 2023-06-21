// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "@aave-v3-core/contracts/flashloan/interfaces/IFlashLoanSimpleReceiver.sol";
import "@aave-v3-core/contracts/mocks/tokens/MintableERC20.sol";

contract FlashLoan is IFlashLoanSimpleReceiver {

  event FlashLoanReceived();

  address constant public POOL_ADDRESS = 0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08;
  address constant public POOL_ADDRESS_PROVIDER = 0x0496275d34753A48320CA58103d5220d394FF77F;

  address constant public ASSET = 0x68194a729C2450ad26072b3D33ADaCbcef39D574;
  uint256 constant public AMOUNT = 10 ether;
  uint256 constant public ALLOWANCE = 50 ether;

  function flashloan() external {
    IPool(POOL_ADDRESS).flashLoanSimple(address(this), ASSET, AMOUNT, "", 0);
  }

  function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address initiator,
    bytes calldata params
  ) external override returns (bool) {
    emit FlashLoanReceived();
    MintableERC20(ASSET).increaseAllowance(POOL_ADDRESS, ALLOWANCE);
    return true;
  }

  function ADDRESSES_PROVIDER() external view override returns (IPoolAddressesProvider) {
    return IPoolAddressesProvider(POOL_ADDRESS_PROVIDER);
  }

  function POOL() external view override returns (IPool) {
    return IPool(POOL_ADDRESS);
  }
}
