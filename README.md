# PrismAMM

**Concentrated-liquidity AMM (CLMM) for EVM L2s**

PrismAMM is a Uniswap V3–class concentrated liquidity protocol optimized for L2 gas patterns, with flash swaps, gauge emissions, and a full periphery for integrators.

[![License: BSL 1.1](https://img.shields.io/badge/license-BSL%201.1-blue)](./LICENSE)
[![AMM](https://img.shields.io/badge/CLMM-tick%20based-a855f7)](#amm)
[![Periphery](https://img.shields.io/badge/router%20%2B%20NFT%20positions-0ea5e9)](#periphery)

---

## Why PrismAMM

| Benefit | Detail |
|--------|--------|
| **Capital efficiency** | LPs concentrate liquidity around the active price — higher fee income per dollar |
| **Predictable swap math** | Tick/bitmap design with audited-style invariants and fuzz targets |
| **Flash swaps** | Atomic undercollateralized borrows for liquidators & arb keepers |
| **L2-first gas** | Packed structs, sparse tick arrays, calldata-efficient router |
| **Gauge-ready** | Optional emissions & bribes module for sustainable liquidity |
| **Integrator periphery** | Quoter, router, position NFT, and TypeScript SDK |

### Compared to a constant-product pool

Concentrated liquidity lets LPs act like a series of limit orders across a price range. Traders get tighter spreads near mid; LPs earn more when they actively manage ranges.

---

## Core components

| Contract | Purpose |
|----------|---------|
| `PrismPool` | CLMM pool, swaps, flash |
| `PrismFactory` | Pool create / fee tiers |
| `PositionNFT` | ERC-721 LP positions |
| `SwapRouter` | Exact-in / exact-out |
| `Quoter` | Off-chain simulation helper |
| `GaugeController` | Emissions (optional) |

---

## Quick start

```bash
npm run server
```

Open **http://localhost:3003**

---

## Fee tiers

| Tier | Typical pairs |
|------|----------------|
| 0.01% | Stable / correlated |
| 0.05% | Blue-chip majors |
| 0.30% | Standard volatiles |
| 1.00% | Long-tail assets |

---

## Security posture

- CEI-style flash accounting  
- Locked reentrancy on pool mutations  
- Oracle/TWAP helpers that discourage single-block manipulation for downstream protocols  

---

## License

Business Source License 1.1 — see `LICENSE`.
