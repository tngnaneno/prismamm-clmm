// SPDX-License-Identifier: BSL-1.1
pragma solidity ^0.8.28;

/// @title PrismFactory
contract PrismFactory {
    mapping(address => mapping(address => mapping(uint24 => address))) public getPool;
    address[] public allPools;

    event PoolCreated(address indexed token0, address indexed token1, uint24 fee, address pool);

    function createPool(address tokenA, address tokenB, uint24 fee) external returns (address pool) {
        require(tokenA != tokenB, "identical");
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(getPool[token0][token1][fee] == address(0), "exists");
        // Production: deploy PrismPool via create2
        pool = address(uint160(uint256(keccak256(abi.encode(token0, token1, fee, block.timestamp)))));
        getPool[token0][token1][fee] = pool;
        getPool[token1][token0][fee] = pool;
        allPools.push(pool);
        emit PoolCreated(token0, token1, fee, pool);
    }
}
