-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local Config = require(ReplicatedStorage.Modules.GameConfigController):GetConfig("HarvestMoonQuestsConfig");
local u1 = {
    EarnMoonCoins = {
        Type = "EarnEventCurrency",
        Arguments = { "MoonCoins" }
    },
    OpenHarvestMoonCrate = {
        Type = "OpenCrate",
        Arguments = { "Moon Crate" }
    },
    OpenHarvestMoonEgg = {
        Type = "HatchEgg",
        Arguments = { "Moon Egg" }
    },
    CraftHarvestMoonItem = {
        Type = "Craft"
    },
    HarvestPlant = {
        Type = "Harvest"
    }
};

local function buildPool(p2: table) -- Line: 31
    -- upvalues: u1 (copy), Quests (copy)
    local v3 = {};

    for _, v in p2 do
        local v4 = u1[v.Quest];
        local v5;

        if v4 then
            v5 = v4.Type;
        else
            v5 = v.Quest;
        end;

        local v6 = Quests[v5];

        if v6 then
            local v7 = {
                Target = v.Target
            };
            local Arguments = v.Arguments;

            if Arguments then
                v4 = Arguments;
            elseif v4 then
                v4 = v4.Arguments;
            end;

            v7.Arguments = v4;
            table.insert(v3, v6:Use(v7));
        else
            warn((`HarvestMoonQuests | unknown quest type "{tostring(v.Quest)}" -> "{tostring(v5)}"`));
        end;
    end;

    return v3;
end;

return {
    DisplayName = "Harvest Moon",
    Type = "HarvestMoonQuests",
    IsIndividual = true,

    Display = function(p8) -- Line: 55, Name: Display
        -- upvalues: Config (copy)
        return Config.DISPLAY_NAME or "Harvest Moon Quests";
    end,

    Generate = function(p9, p10) -- Line: 59, Name: Generate
        -- upvalues: buildPool (copy), Config (copy)
        local v11 = type(p10) == "table" and p10 and p10 or {};
        local Random_new_ret = Random.new((v11.Period or 0) * 1000003 + (v11.UserId or 0) + (v11.Salt or 0) * 7777771);
        local v12 = buildPool(Config.Quests.Easy);
        local v13 = buildPool(Config.Quests.Medium);
        local v14 = buildPool(Config.Quests.Hard);
        local u15 = {};

        local function pickExcluding(p16: table) -- Line: 73
            -- upvalues: u15 (copy), Random_new_ret (copy)
            if #p16 == 0 then
                return nil;
            end;

            local v17 = {};

            for _, v in p16 do
                if not u15[v.Type] then
                    table.insert(v17, v);
                end;
            end;

            if #v17 > 0 then
                p16 = v17;
            end;

            local v18 = p16[Random_new_ret:NextInteger(1, #p16)];

            if v18 then
                u15[v18.Type] = true;
            end;

            return v18;
        end;

        local v19 = {};
        local v20 = pickExcluding(v12);

        if v20 then
            table.insert(v19, v20);
        end;

        local v21 = pickExcluding(v13);

        if v21 then
            table.insert(v19, v21);
        end;

        local v22 = pickExcluding(v14);

        if v22 then
            table.insert(v19, v22);
        end;

        return {
            Quests = v19,
            Rewards = {}
        };
    end
};