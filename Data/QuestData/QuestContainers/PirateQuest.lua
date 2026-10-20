-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);

local function getConfig() -- Line: 18
    -- upvalues: GameConfigController (copy)
    return GameConfigController:GetConfig("PirateQuestConfig");
end;

local function tideTokens(p1: number) -- Line: 23
    -- upvalues: QuestRewards (copy), GameConfigController (copy)
    return QuestRewards.Currency:Use({
        Type = GameConfigController:GetConfig("PirateQuestConfig").REWARD_CURRENCY or "TideTokens",
        Amount = p1
    });
end;

local function buildPool(p2: table, p3: number) -- Line: 30
    -- upvalues: Quests (copy), tideTokens (copy)
    local v4 = {};

    for _, v in p2 do
        local v5 = Quests[v.Quest];

        if v5 then
            local v6 = {
                Target = v.Target,
                Arguments = v.Arguments,
                Rewards = { tideTokens(p3) }
            };
            table.insert(v4, v5:Use(v6));
        else
            warn((`PirateQuest | unknown quest type "{tostring(v.Quest)}"`));
        end;
    end;

    return v4;
end;

local v7 = {
    Type = "PirateQuest",
    IsIndividual = true
};
local GlobalUpdateTime = game:GetService("ReplicatedFirst"):WaitForChild("GlobalUpdateTime");

function v7.ExpiresAt(p8) -- Line: 63
    -- upvalues: GlobalUpdateTime (copy)
    local Value = GlobalUpdateTime.Value;

    return Value > 1785616200 and 1785616200 or Value;
end;

function v7.Display(p9) -- Line: 71
    return "Pirate Quests";
end;

function v7.Generate(p10, p11) -- Line: 75
    -- upvalues: GameConfigController (copy), buildPool (copy)
    local v12 = type(p11) == "table" and p11 and p11 or {};
    local Random_new_ret = Random.new((v12.Period or 0) * 1000003 + (v12.UserId or 0) + (v12.Salt or 0) * 7777771);
    local Config = GameConfigController:GetConfig("PirateQuestConfig");
    local v13 = Config.TIER_REWARDS or {
        Easy = 5,
        Medium = 15,
        Hard = 30
    };
    local v14 = buildPool(Config.Quests.Easy, v13.Easy);
    local v15 = buildPool(Config.Quests.Medium, v13.Medium);
    local v16 = buildPool(Config.Quests.Hard, v13.Hard);
    local u17 = {};

    local function pickExcluding(p18: table) -- Line: 96
        -- upvalues: u17 (copy), Random_new_ret (copy)
        if #p18 == 0 then
            return nil;
        end;

        local v19 = {};

        for _, v in p18 do
            if not u17[v.Type] then
                table.insert(v19, v);
            end;
        end;

        if #v19 > 0 then
            p18 = v19;
        end;

        local v20 = p18[Random_new_ret:NextInteger(1, #p18)];

        if v20 then
            u17[v20.Type] = true;
        end;

        return v20;
    end;

    local v21 = {};
    local v22 = pickExcluding(v14);

    if v22 then
        table.insert(v21, v22);
    end;

    local v23 = pickExcluding(v15);

    if v23 then
        table.insert(v21, v23);
    end;

    local v24 = pickExcluding(v16);

    if v24 then
        table.insert(v21, v24);
    end;

    return {
        Quests = v21,
        Rewards = {}
    };
end;

return v7;