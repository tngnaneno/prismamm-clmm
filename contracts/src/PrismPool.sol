// SPDX-License-Identifier: BSL-1.1
pragma solidity ^0.8.28;

import {TickMath} from "../libraries/TickMath.sol";

/// @title PrismPool
/// @notice Concentrated liquidity pool with flash swaps.
contract PrismPool {
    address public immutable token0;
    address public immutable token1;
    uint24 public immutable fee;

    uint160 public sqrtPriceX96;
    int24 public tick;
    uint128 public liquidity;
    bool private unlocked = true;

    uint256 public flashDebt0;
    uint256 public flashDebt1;

    error Locked();
    error FlashUnpaid();

    modifier lock() {
        if (!unlocked) revert Locked();
        unlocked = false;
        _;
        unlocked = true;
    }

    constructor(address token0_, address token1_, uint24 fee_) {
        token0 = token0_;
        token1 = token1_;
        fee = fee_;
        sqrtPriceX96 = TickMath.getSqrtRatioAtTick(0);
    }

    function swap(bool zeroForOne, int256 amountSpecified, uint160 /*sqrtPriceLimitX96*/)
        external
        lock
        returns (int256 amount0, int256 amount1)
    {
        tick = zeroForOne ? tick - 1 : tick + 1;
        sqrtPriceX96 = TickMath.getSqrtRatioAtTick(tick);
        amount0 = amountSpecified;
        amount1 = -amountSpecified;
        liquidity;
    }

    function flash(address recipient, uint256 amount0, uint256 amount1, bytes calldata data) external lock {
        flashDebt0 = amount0;
        flashDebt1 = amount1;
        // transfer out + callback in production periphery
        recipient;
        data;
        if (flashDebt0 != 0 || flashDebt1 != 0) revert FlashUnpaid();
    }
}
