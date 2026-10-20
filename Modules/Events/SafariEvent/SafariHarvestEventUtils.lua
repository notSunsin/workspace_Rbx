-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SafariEventRewardData = require(ReplicatedStorage.Data.Events.SafariEvent.SafariEventRewardData);

return {
    GenerateReward = function(p1: table, p2: number, p3: table) -- Line: 9, Name: GenerateReward
        local v4 = 0;
        local v5 = nil;

        for i, v in p3 do
            if i <= p2 and v4 <= i then
                v5 = v;
                v4 = i;
            end;
        end;

        if not v5 then
            warn("SafariEventRewardData:GenerateReward | Could not find valid reward data");

            return nil;
        end;

        local TotalOdds = v5.TotalOdds;

        if not TotalOdds then
            TotalOdds = 0;

            for _, v in v5 do
                TotalOdds = TotalOdds + v.Chance;
            end;
        end;

        local v6 = Random.new():NextNumber(0, TotalOdds);
        local v7 = 0;

        for _, v in v5 do
            v7 = v7 + v.Chance;

            if v6 <= v7 then
                return v;
            end;
        end;

        return nil;
    end,

    IsUnlockedInEventShop = function(p8: table, p9: number, p10: string) -- Line: 50, Name: IsUnlockedInEventShop
        -- upvalues: SafariEventRewardData (copy)
        local v11 = SafariEventRewardData.MilestoneUnlockData.EventShopUnlocks[p10];

        return not v11 and true or v11 <= p9;
    end,

    GetEventShopChanceTierByValue = function(p12: table, p13: number) -- Line: 58, Name: GetEventShopChanceTierByValue
        -- upvalues: SafariEventRewardData (copy)
        local v14 = nil;

        for i, v in SafariEventRewardData.MilestoneUnlockData.EventShopChanceIncreases do
            if v <= p13 then
                v14 = i;
            end;
        end;

        return v14;
    end,

    PickRandom = function(p15, p16) -- Line: 69, Name: PickRandom
        local v17 = 0;

        for _, v in p16 do
            v17 = v17 + (v.Chance or 1);
        end;

        local v18 = Random.new():NextNumber() * v17;
        local v19 = 0;

        for _, v in p16 do
            v19 = v19 + (v.Chance or 1);

            if v18 <= v19 then
                return v;
            end;
        end;
    end
};