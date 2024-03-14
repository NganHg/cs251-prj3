// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
    // DO NOT MODIFY ABOVE THIS
    // ADD YOUR CONTRACT CODE BELOW
    mapping(address => mapping(address => uint32)) private _IOUList;
    mapping(address => uint32) private _totalOwned;
    function lookup(
        address debtor,
        address creditor
    ) public view returns (uint32) {
        return _IOUList[debtor][creditor];
    }

    function getTotalOwed(address debter) public view returns (uint32) {
        return _totalOwned[debter];
    }

    function add_IOU(address debter, address creditor, uint32 amount) public {
        _IOUList[debter][creditor] += amount;
        _totalOwned[debter] += amount;
    }

    function reduceIOU(address[] memory path, uint32 amount) public {
        for (uint256 i = 0; i < path.length - 1; i++) {
            _IOUList[path[i]][path[i + 1]] -= amount;
            _totalOwned[path[i]] -= amount;
        }
        _IOUList[path[path.length - 1]][path[0]] -= amount;
        _totalOwned[path[path.length - 1]] -= amount;
    }
}
