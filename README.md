# FundMe Solidity Project

Welcome to the **FundMe** project, a smart contract application built using Solidity for Ethereum networks. This repository contains contracts that allow users to fund a common wallet, and the contract owner to withdraw funds. The project showcases best practices in Solidity development, including the use of price feeds and various patterns for secure contract interactions.

## Features

- **Fund and Withdraw Mechanism**: Users can fund the contract with Ether, and the owner can withdraw all funds.
- **Price Feed Integration**: Utilizes Chainlink price feeds to convert Ether to USD, ensuring a minimum funding requirement.
- **Multi-Network Support**: Configured to work on different Ethereum networks (Sepolia, Mainnet, and local Anvil).
- **Mock Price Feed**: A mock implementation for testing purposes, allowing local deployments without actual price feed data.
- **Robust Testing**: Comprehensive tests for functionalities including funding, withdrawals, and access control.

## Smart Contracts Overview

1. **FundMe.sol**: The main contract that manages fund deposits, withdrawals, and price conversion using Chainlink's Aggregator interface.
2. **DeployFundMe.sol**: A deployment script that initializes the FundMe contract with the appropriate price feed based on the active network.
3. **HelperConfig.sol**: Contains configuration settings for various networks, helping to dynamically fetch the correct price feed.
4. **Interactions.s.sol**: Contains scripts for interacting with the deployed FundMe contract (funding and withdrawing).
5. **MockV3Aggregator.sol**: A mock price feed contract used for local testing to simulate price feed data.

## Refactoring

The project has undergone several refactoring steps to enhance code readability and efficiency:

- **Error Handling**: Custom error messages for revert conditions were introduced to save gas and provide clearer context when transactions fail.
- **Using Structs for Configuration**: The network configurations were encapsulated in a struct to make it easier to manage and extend.
- **Modifiers**: Used `onlyOwner` modifier to simplify access control for owner-only functions.
- **Comments and Documentation**: Added comments throughout the codebase to improve clarity and understanding of the contract logic.

## Getting Started

To get started with the FundMe project:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/fundme.git
   cd fundme
   ```

2. **Install Dependencies**:
   Make sure you have [Foundry](https://foundryrs.com/) installed. Then run:
   ```bash
   forge install
   ```

3. **Deploy the Contract**:
   You can deploy the contract using:
   ```bash
   forge script script/DeployFundMe.s.sol
   ```

4. **Run Tests**:
   To ensure everything works as expected, run the tests:
   ```bash
   forge test
   ```

## Contributing

We welcome contributions to improve the FundMe project! If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---
