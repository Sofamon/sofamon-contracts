// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "solmate/tokens/ERC1155.sol";
import "solmate/utils/LibString.sol";

contract SofamonWearables is ERC1155, Ownable {
    using ECDSA for bytes32;

    string public baseMetadataURI;

    constructor() ERC1155() {}

    function setURI(string memory baseMetadataURI_) public onlyOwner {
        baseMetadataURI = baseMetadataURI_;
    }

    function uri(uint256 id) public view override returns (string memory) {
        return strConcat(baseMetadataURI, LibString.toString(id));
    }

    function strConcat(string memory _a, string memory _b)
        internal
        pure
        returns (string memory)
    {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ab = new string(_ba.length + _bb.length);
        bytes memory bab = bytes(ab);
        uint256 k = 0;
        for (uint256 i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
        for (uint256 i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
        return string(bab);
    }

    function mint(
        uint256 tokenId,
        uint256 amount,
        address to
    ) public {
        _mint(to, tokenId, amount, "");
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
