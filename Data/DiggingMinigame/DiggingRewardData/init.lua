-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);

return {
    RewardSets = {
        DEFAULT = require(script.DefaultDigRewardData),
        HalloweenEvent = require(script.HalloweenDigRewardData),
        Christmas = require(script.ChristmasDigRewardData)
    },

    PickRandom = function(p1) -- Line: 14, Name: PickRandom
        local v2 = 0;

        for _, v in p1 do
            v2 = v2 + (v.Chance or 1);
        end;

        local v3 = Random.new():NextNumber() * v2;
        local v4 = 0;

        for _, v in p1 do
            v4 = v4 + (v.Chance or 1);

            if v3 <= v4 then
                return v;
            end;
        end;
    end
};