// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Sofamon.sol";

contract SofamonTest is Test {
    using stdStorage for StdStorage;

    Sofamon private nft;

    function setUp() public {
        // Deploy NFT contract
        nft = new Sofamon();
    }
}