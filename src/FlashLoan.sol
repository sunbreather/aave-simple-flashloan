// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@aave-v3-core/contracts/flashloan/interfaces/IFlashLoanSimpleReceiver.sol";

contract FlashLoan is IFlashLoanSimpleReceiver {

  address constant public POOL_ADDRESS = 0x02c3e5420527D75c1c864a58D6a2A73B0EfbfA4D;
  address constant public POOL_ADDRESS_PROVIDER = 0x0496275d34753A48320CA58103d5220d394FF77F;

  address[] public assets = [0xD0dF82dE051244f04BfF3A8bB1f62E1cD39eED92];
  uint256[] public amounts = [10 ether];
  uint256[] public modes = [0];

  function flashloan() external {
    IPool(POOL_ADDRESS).flashLoan(address(this), assets, amounts, modes, address(this), "", 0);
  }

  function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address initiator,
    bytes calldata params
  ) external override returns (bool) {
    return true;
  }

  function ADDRESSES_PROVIDER() external view override returns (IPoolAddressesProvider) {
    return IPoolAddressesProvider(POOL_ADDRESS_PROVIDER);
  }

  function POOL() external view override returns (IPool) {
    return IPool(POOL_ADDRESS);
  }
}
