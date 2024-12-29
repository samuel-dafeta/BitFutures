# BitFutures: Decentralized Bitcoin Price Prediction Market

A decentralized prediction market smart contract built on Stacks, allowing users to stake STX tokens to predict Bitcoin price movements.

## Overview

BitFutures enables users to:

- Participate in prediction markets for BTC price movements
- Stake STX tokens on "up" or "down" predictions
- Win proportional rewards from the total stake pool
- Claim winnings automatically after market resolution

## Features

- **Decentralized Markets**: Create and participate in prediction markets without intermediaries
- **Transparent Execution**: All market operations are verifiable on-chain
- **Secure Staking**: Built-in safeguards for stake management
- **Oracle Integration**: Price resolution through trusted oracle
- **Fee Mechanism**: Sustainable platform fees for long-term maintenance
- **Owner Controls**: Administrative functions for market management

## Technical Architecture

### Core Components

1. **Market Management**

   - Market creation with configurable parameters
   - Automatic market ID assignment
   - Start/end block validation
   - Price tracking (start and end prices)

2. **Prediction System**

   - Binary predictions (up/down)
   - Minimum stake requirements
   - Balance verification
   - Stake pooling

3. **Resolution Mechanism**
   - Oracle-based price resolution
   - Automatic winner determination
   - Proportional reward distribution
   - Platform fee handling

### Data Structures

#### Markets Map

```clarity
{
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool
}
```

#### User Predictions Map

```clarity
{
    prediction: (string-ascii 4),
    stake: uint,
    claimed: bool
}
```

## Public Functions

### `create-market`

Creates a new prediction market.

```clarity
(create-market (start-price uint) (start-block uint) (end-block uint))
```

### `make-prediction`

Places a stake on a market prediction.

```clarity
(make-prediction (market-id uint) (prediction (string-ascii 4)) (stake uint))
```

### `resolve-market`

Resolves a market with the final price.

```clarity
(resolve-market (market-id uint) (end-price uint))
```

### `claim-winnings`

Claims winnings from a resolved market.

```clarity
(claim-winnings (market-id uint))
```

## Administrative Functions

### `set-oracle-address`

Updates the oracle address.

```clarity
(set-oracle-address (new-address principal))
```

### `set-minimum-stake`

Updates the minimum stake requirement.

```clarity
(set-minimum-stake (new-minimum uint))
```

### `set-fee-percentage`

Updates the platform fee percentage.

```clarity
(set-fee-percentage (new-fee uint))
```

### `withdraw-fees`

Withdraws accumulated platform fees.

```clarity
(withdraw-fees (amount uint))
```

## Security Features

1. **Access Control**

   - Owner-only administrative functions
   - Oracle-only market resolution
   - User-specific claim verification

2. **Safety Checks**

   - Balance verification
   - Market timing validation
   - Double-claim prevention
   - Parameter validation

3. **Error Handling**
   - Comprehensive error codes
   - Safe unwrapping of optional values
   - Transaction rollback on failures

## Configuration

- Default minimum stake: 1 STX
- Platform fee: 2%
- Oracle address: Configurable by owner
- Market timing: Flexible block-based windows

## Error Codes

- `err-owner-only (u100)`: Unauthorized access
- `err-not-found (u101)`: Resource not found
- `err-invalid-prediction (u102)`: Invalid prediction value
- `err-market-closed (u103)`: Market not active
- `err-already-claimed (u104)`: Winnings already claimed
- `err-insufficient-balance (u105)`: Insufficient funds
- `err-invalid-parameter (u106)`: Invalid parameter value

## Best Practices for Integration

1. **Market Creation**

   - Set reasonable block windows
   - Use accurate price data
   - Verify oracle availability

2. **Making Predictions**

   - Check market status
   - Verify sufficient balance
   - Account for minimum stake

3. **Claiming Winnings**
   - Wait for market resolution
   - Verify winning prediction
   - Handle failed claims

## License

MIT License
