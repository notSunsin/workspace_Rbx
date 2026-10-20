-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local AchievementsData = require(ReplicatedStorage.Data.AchievementsData);
local AchievementsController = require(ReplicatedStorage.Modules.AchievementsControllers.AchievementsController);
local u10 = {
    GetRewardString = function(p1: table) -- Line: 10, Name: GetRewardString
        -- upvalues: ItemNameFinder (copy)
        local v2 = {};

        for _, v in p1 do
            local v3 = v.Quantity or 1;
            local v4 = `{ItemNameFinder(v.Value, v.Type)}{v3 <= 1 and "" or ` x{v3}`}`;
            table.insert(v2, v4);
        end;

        return table.concat(v2, ", ");
    end,

    CalculateSetProgress = function(p5, p6, p7) -- Line: 24, Name: CalculateSetProgress
        -- upvalues: AchievementsData (copy)
        local v8 = 0;
        local v9 = 0;

        for _, v in AchievementsData.Seasons[p5].Sets[p6].Quests do
            local Id = v.Id;
            v8 = v8 + 1;

            if p7[Id] and v.Target <= p7[Id].Progress then
                v9 = v9 + 1;
            end;
        end;

        return v9, v8;
    end
};

function u10.CalculateSeasonProgress(p11, p12) -- Line: 42
    -- upvalues: AchievementsData (copy), u10 (copy)
    local v13 = 0;

    for i, _ in AchievementsData.Seasons[p11].Sets do
        local v14, _ = u10.CalculateSetProgress(p11, i, p12[i].Quests);
        v13 = v13 + v14;
    end;

    return v13;
end;

function u10.CheckForUnclaimed(p15, p16) -- Line: 53
    -- upvalues: DataService (copy), AchievementsData (copy), AchievementsController (copy)
    local Quests = DataService:GetData().Achievements.Seasons[`Season_{p15}`].Sets[p16].Quests;

    for i, v in AchievementsData.Seasons[p15].Sets[p16].Quests do
        if Quests[v.Id] and (Quests[v.Id].Progress >= v.Target and not AchievementsController:IsClaimed("Quest", { p15, p16, i })) then
            return true;
        end;
    end;

    return false;
end;

function u10.GetHighestSetOrder(p17: table, p18: number) -- Line: 70
    -- upvalues: AchievementsData (copy)
    local v19 = AchievementsData.Seasons[p18];

    if v19 then
        local v20 = 0;

        for _, v in v19.Sets do
            if v.Order and v20 < v.Order then
                v20 = v.Order;
            end;
        end;

        return v20;
    end;

    warn((`No AchievementData: {p18}`));
end;

return u10;