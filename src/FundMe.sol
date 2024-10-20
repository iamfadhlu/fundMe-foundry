// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__Unauthorized();
error FundMe__Failed();
error FundMe__Insufficient_Funds();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MIN_USD = 5e18;
    address[] private s_funders;
    address private immutable i_owner;
    AggregatorV3Interface private s_priceFeed;
    mapping(address funder => uint256 amountFunded) private s_addressToAmountFunded;
    mapping(address funder => uint256 contributionCount) private s_contributionCount;

    constructor(address _priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function fund() public payable {
        if (!(msg.value.getConversionRate(s_priceFeed) >= MIN_USD)) revert FundMe__Insufficient_Funds();
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_contributionCount[msg.sender] += 1;
    }

    function withdraw() public onlyOwner {
        uint256 fundersLength = s_funders.length;
        for (uint256 funderIndex = 0; funderIndex < fundersLength; funderIndex++) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        if (callSuccess != true) revert FundMe__Failed();
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__Unauthorized();
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
    function getAddressToAmountFunded(address fundingAddress) external view returns (uint) {
        return s_addressToAmountFunded[fundingAddress];
    }
    function getFunder(uint256 funder_index) external view returns(address) {
        return s_funders[funder_index];
    }
    function getOwner() external view returns(address){
        return i_owner;
    }
}
