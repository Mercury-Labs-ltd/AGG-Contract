// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";
import "./TimeLock.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract AGGToken is ERC20Pausable, Ownable, TimeLock {
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) ERC20(_name, _symbol) {
        _mint(msg.sender, _initialSupply);
    }

    function burn(uint256 _amount) public onlyOwner {
        _burn(msg.sender, _amount);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal override(ERC20Pausable) whenNotPaused notLocked {
        super._beforeTokenTransfer(_from, _to, _amount);
    }
}
