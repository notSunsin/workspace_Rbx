-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local Config = require(ReplicatedStorage.Modules.GameConfigController):GetConfig("SummerQuestConfig");

local function buildPool(p1: table) -- Line: 17
    -- upvalues: Quests (copy)
    local v2 = {};

    for _, v in p1 do
        local v3 = Quests[v.Quest];

        if v3 then
            table.insert(v2, v3:Use({
                Target = v.Target,
                Arguments = v.Arguments
            }));
        else
            warn((`SummerQuest | unknown quest type "{tostring(v.Quest)}"`));
        end;
    end;

    return v2;
end;

return {
    Type = "SummerQuest",
    IsIndividual = true,

    Display = function(p4) -- Line: 38, Name: Display
        return "Summer Quests";
    end,

    Generate = function(p5, p6) -- Line: 42, Name: Generate
        -- upvalues: buildPool (copy), Config (copy)
        local v7 = type(p6) == "table" and p6 and p6 or {};
        local Random_new_ret = Random.new((v7.Period or 0) * 1000003 + (v7.UserId or 0) + (v7.Salt or 0) * 7777771);
        local v8 = buildPool(Config.Quests.Easy);
        local v9 = buildPool(Config.Quests.Medium);
        local v10 = buildPool(Config.Quests.Hard);
        local u11 = {};

        local function pickExcluding(p12: table) -- Line: 61
            -- upvalues: u11 (copy), Random_new_ret (copy)
            if #p12 == 0 then
                return nil;
            end;

            local v13 = {};

            for _, v in p12 do
                if not u11[v.Type] then
                    table.insert(v13, v);
                end;
            end;

            if #v13 > 0 then
                p12 = v13;
            end;

            local v14 = p12[Random_new_ret:NextInteger(1, #p12)];

            if v14 then
                u11[v14.Type] = true;
            end;

            return v14;
        end;

        local v15 = {};
        local v16 = pickExcluding(v8);

        if v16 then
            table.insert(v15, v16);
        end;

        local v17 = pickExcluding(v9);

        if v17 then
            table.insert(v15, v17);
        end;

        local v18 = pickExcluding(v10);

        if v18 then
            table.insert(v15, v18);
        end;

        return {
            Quests = v15,
            Rewards = {}
        };
    end
};