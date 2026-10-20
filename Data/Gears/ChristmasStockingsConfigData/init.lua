-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);
local v1 = game:GetService("RunService"):IsStudio();
local IsDev = require(ReplicatedStorage.Modules.IsDev);

return {
    REWARD_FILL_TIME = v1 and 20 or (IsDev and 1800 or 43200),
    GEAR_LIFETIME = v1 and 120 or (IsDev and 3660 or 604860),
    RewardSets = {
        DEFAULT = require(script.StockingRewardData)
    },

    PickRandom = function(p2) -- Line: 23, Name: PickRandom
        local v3 = 0;

        for _, v in p2 do
            v3 = v3 + (v.Chance or 1);
        end;

        local v4 = Random.new():NextNumber() * v3;
        local v5 = 0;

        for _, v in p2 do
            v5 = v5 + (v.Chance or 1);

            if v4 <= v5 then
                return v;
            end;
        end;
    end
};