// SPDX-License-Identifier: UNLICENSED
/*
███████╗ ██████╗ ███████╗ █████╗ ███╗   ███╗ ██████╗ ███╗   ██╗
██╔════╝██╔═══██╗██╔════╝██╔══██╗████╗ ████║██╔═══██╗████╗  ██║
███████╗██║   ██║█████╗  ███████║██╔████╔██║██║   ██║██╔██╗ ██║
╚════██║██║   ██║██╔══╝  ██╔══██║██║╚██╔╝██║██║   ██║██║╚██╗██║
███████║╚██████╔╝██║     ██║  ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║
╚══════╝ ╚═════╝ ╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
*/
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SofamonNouns.sol";

contract SofamonNounsTest is Test {
    using stdStorage for StdStorage;

    SofamonNouns private nft;

    function setUp() public {
        // Deploy NFT contract
        nft = new SofamonNouns("SOFANOUNS", "SOFA");
    }
}