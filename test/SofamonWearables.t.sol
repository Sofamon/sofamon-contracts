// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SofamonWearables.sol";

contract SofamonWearablesTest is Test {
    using stdStorage for StdStorage;

    SofamonWearables private wearables;

    function setUp() public {
        // Deploy NFT contract
        wearables = new SofamonWearables();
    }
}