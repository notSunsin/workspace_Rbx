-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Trove);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.QuestData);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
require(ReplicatedStorage.Data.QuestData.Types);
local _ = Players.LocalPlayer;

return {
    GetQuest = function(p1: table, p2: string) -- Line: 30, Name: GetQuest
        -- upvalues: Quests (copy)
        return Quests[p2];
    end,

    GetRewardInfo = function(p3: table, p4: string) -- Line: 34, Name: GetRewardInfo
        -- upvalues: QuestRewards (copy)
        return QuestRewards[p4];
    end,

    GetContainerFromId = function(p5: table, p6: string) -- Line: 38, Name: GetContainerFromId
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if not Data then
            return nil;
        end;

        local v7 = tostring(p6);

        return Data.QuestContainers[v7];
    end,

    GetQuestFromId = function(p8: table, p9: string) -- Line: 47, Name: GetQuestFromId
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if not Data then
            return nil;
        end;

        local v10 = tostring(p9);

        for _, v in Data.QuestContainers do
            for _, v2 in v.Quests do
                if tostring(v2.Id) == v10 then
                    return v2;
                end;
            end;
        end;

        return nil;
    end
};