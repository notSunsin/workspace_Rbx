-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);

local function jelly(p1: number) -- Line: 15
    -- upvalues: QuestRewards (copy)
    return QuestRewards.Currency:Use({
        Type = "RoyalJelly",
        Amount = p1
    });
end;

local function GetQuestsConfig() -- Line: 37
    -- upvalues: GameConfigController (copy)
    return GameConfigController:GetConfig("BeeEventQuestData");
end;

local function buildPool(p2: table) -- Line: 41
    -- upvalues: Quests (copy), jelly (copy)
    local v3 = {};

    for _, v in p2 do
        local v4 = Quests[v.Quest];
        local v5 = {
            Target = v.Target,
            Arguments = v.Arguments,
            Rewards = { jelly(v.Jelly) }
        };
        table.insert(v3, v4:Use(v5));
    end;

    return v3;
end;

return {
    Type = "BeeEvent",
    IsIndividual = true,

    Display = function(p6) -- Line: 60, Name: Display
        return "Bee Event Quests";
    end,

    Generate = function(p7, p8) -- Line: 64, Name: Generate
        -- upvalues: GameConfigController (copy), buildPool (copy)
        local Config = GameConfigController:GetConfig("BeeEventQuestData");
        local v9 = buildPool(Config.Easy);
        local v10 = buildPool(Config.Medium);
        local v11 = buildPool(Config.Hard);
        local Random_new_ret = Random.new();

        return {
            Quests = { v9[Random_new_ret:NextInteger(1, #v9)], v10[Random_new_ret:NextInteger(1, #v10)], v11[Random_new_ret:NextInteger(1, #v11)] },
            Rewards = type(p8) ~= "function" and {} or p8({
                type = "rewards"
            })
        };
    end
};