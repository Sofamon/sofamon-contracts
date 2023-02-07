// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Shimeji.sol";

contract ShimejiTest is Test {
    using stdStorage for StdStorage;

    Shimeji private nft;

    function setUp() public {
        // Deploy NFT contract
        nft = new Shimeji();
    }
}