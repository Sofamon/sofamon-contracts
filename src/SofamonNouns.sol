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
import "@openzeppelin/contracts/access/Ownable.sol";
import "solmate/tokens/ERC721.sol";
import "solmate/utils/LibString.sol";
import "solmate/utils/SafeTransferLib.sol";

error DoesNotExist();
error NoTokensLeft();
error NotEnoughETH();
error NoEthBalance();

contract SofamonNouns is ERC721, Ownable {
    uint256 public constant TOTAL_SUPPLY = 10000;
    uint256 public constant PRICE_PER_MINT = 0 ether;

    uint256 public totalSupply;
    string public baseURI;

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    event setLevel(
        address indexed owner,
        uint256 indexed id,
        uint16 indexed level
    );

    /*//////////////////////////////////////////////////////////////
                             ERC721 LEVEL STORAGE
    //////////////////////////////////////////////////////////////*/
    mapping(uint256 => uint16) public levelOf;

    function getLevelOf(uint256 id) public view virtual returns (uint16) {
        require(_ownerOf[id] != address(0), "NOT MINTED");
        return levelOf[id];
    }

    function setLevelOf(uint256 id, uint16 level) public virtual {
        require(_ownerOf[id] == msg.sender, "NOT OWNER");
        levelOf[id] = level;
        emit setLevel(msg.sender, id, level);
    }

    /*///////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    constructor(string memory _name, string memory _symbol)
        payable
        ERC721(_name, _symbol)
    {}

    /*///////////////////////////////////////////////////////////////
                               MINT FUNCTION
    //////////////////////////////////////////////////////////////*/
    function _mint(address to, uint256 id) internal virtual override {
        require(to != address(0), "INVALID_RECIPIENT");

        require(_ownerOf[id] == address(0), "ALREADY_MINTED");

        // Counter overflow is incredibly unrealistic.
        unchecked {
            _balanceOf[to]++;
        }

        _ownerOf[id] = to;
        levelOf[id] = 0;

        emit Transfer(address(0), to, id);
    }

    function mint(uint16 amount) external payable {
        if (totalSupply + amount >= TOTAL_SUPPLY) revert NoTokensLeft();
        if (msg.value < amount * PRICE_PER_MINT) revert NotEnoughETH();

        unchecked {
            for (uint16 index = 0; index < amount; index++) {
                _mint(msg.sender, totalSupply++);
            }
        }
    }

    /*///////////////////////////////////////////////////////////////
                               TOKEN URI
    //////////////////////////////////////////////////////////////*/
    function setURI(string memory _baseURI) public onlyOwner {
        baseURI = _baseURI;
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (_ownerOf[id] == address(0)) {
            revert DoesNotExist();
        }

        return strConcat(baseURI, LibString.toString(id));
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

    /*///////////////////////////////////////////////////////////////
                            ETH WITHDRAWAL
    //////////////////////////////////////////////////////////////*/
    function withdraw() external onlyOwner {
        if (address(this).balance == 0) revert NoEthBalance();
        SafeTransferLib.safeTransferETH(msg.sender, address(this).balance);
    }
}
