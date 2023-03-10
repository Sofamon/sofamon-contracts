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

    SofamonNouns private nouns;

    function setUp() public {
        // Deploy NFT contract
        nouns = new SofamonNouns("SOFANOUNS", "SOFA");
    }
}