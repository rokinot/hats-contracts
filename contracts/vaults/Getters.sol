// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "./Base.sol";

contract Getters is Base {
    // GET INFO for UI

    function pendingReward(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo storage pool = poolInfos[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        uint256 rewardPerShare = pool.rewardPerShare;

        if (block.number > pool.lastRewardBlock && pool.totalShares > 0) {
            uint256 reward = rewardController.poolReward(_pid, pool.lastRewardBlock);
            rewardPerShare += (reward * 1e12 / pool.totalShares);
        }
        return user.shares * rewardPerShare / 1e12 - user.rewardDebt;
    }

    function getBountyLevels(uint256 _pid) external view returns(uint256[] memory) {
        return bountyInfos[_pid].bountyLevels;
    }

    function getNumberOfPools() external view returns (uint256) {
        return poolInfos.length;
    }
}