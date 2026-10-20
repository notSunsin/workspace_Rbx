-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local TeamEventHelper = require(ReplicatedStorage.Modules.TeamEventHelper);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local EventShopData = require(ReplicatedStorage.Data.EventShopData);
local Item_Module = require(ReplicatedStorage.Item_Module);
local u1 = { "Easter Seed Pack", "Exotic Easter Seed Pack" };

local function scale(p2: number) -- Line: 28
    local math_floor_ret = math.floor(p2 * 1 + 0.5);

    return math.max(1, math_floor_ret);
end;

local function bestPackChance(p3: string) -- Line: 32
    -- upvalues: u1 (copy), SeedPackData (copy)
    local v4 = 0;

    for _, v in u1 do
        local v5 = SeedPackData.Packs[v];

        if v5 and v5.Items then
            for _, v2 in v5.Items do
                if v2.Type == "Seed" and (v2.RewardId and "Easter " .. v2.RewardId == p3) then
                    local v6 = tonumber(v2.Chance) or 0;

                    if v4 < v6 then
                        v4 = v6;
                    end;
                end;
            end;
        end;
    end;

    return v4;
end;

local function shopExpectedPerCycle(p7: string) -- Line: 47
    -- upvalues: EventShopData (copy)
    local v8 = EventShopData["Easter Seed Shop"];

    if v8 then
        v8 = v8[p7];
    end;

    return not (v8 and (v8.StockChance and v8.StockAmount)) and 0 or (v8.StockAmount[1] + v8.StockAmount[2]) / 2 / v8.StockChance;
end;

local function acquisitionScore(p9: string) -- Line: 55
    -- upvalues: bestPackChance (copy), EventShopData (copy)
    local v10 = bestPackChance(p9);
    local v11 = EventShopData["Easter Seed Shop"];

    if v11 then
        v11 = v11[p9];
    end;

    return v10 + (not (v11 and (v11.StockChance and v11.StockAmount)) and 0 or (v11.StockAmount[1] + v11.StockAmount[2]) / 2 / v11.StockChance) * 100;
end;

local function curveFraction(p12: number, p13: number) -- Line: 67
    local v14 = math.max(0, p12) / p13;
    local math_sqrt_ret = math.sqrt(v14);

    return math.min(1, math_sqrt_ret);
end;

local function plantTargetsForScore(p15: number) -- Line: 71
    local v16 = math.max(0, p15) / 600;
    local math_sqrt_ret = math.sqrt(v16);
    local v17 = math.min(1, math_sqrt_ret) * 100 + 0.5;
    local math_floor_ret = math.floor(v17);
    local math_max_ret = math.max(3, math_floor_ret);
    local v18 = {};
    local math_floor_ret2 = math.floor(math_max_ret * 0.1 + 0.5);
    local math_max_ret2 = math.max(1, math_floor_ret2);
    local math_floor_ret3 = math.floor(math_max_ret2 * 1 + 0.5);
    v18.Easy = math.max(1, math_floor_ret3);
    local math_floor_ret4 = math.floor(math_max_ret * 0.35 + 0.5);
    local math_max_ret3 = math.max(1, math_floor_ret4);
    local math_floor_ret5 = math.floor(math_max_ret3 * 1 + 0.5);
    v18.Medium = math.max(1, math_floor_ret5);
    local math_floor_ret6 = math.floor(math_max_ret * 1 + 0.5);
    v18.Hard = math.max(1, math_floor_ret6);

    return v18;
end;

local function canDoWeightQuests(p19: number) -- Line: 89
    return p19 >= 30;
end;

local function valThresholdForPercentile(p20: number, p21: number?) -- Line: 107
    local v22 = (not p21 or p21 <= 0) and 0 or 1 / p21;

    return p20 <= v22 and 1.4 or math.clamp(1.4 - 0.7 * (p20 - v22) / (1 - v22), 0.7, 1.4);
end;

local function fmtWeight(p23: number) -- Line: 118
    if p23 < 10 then
        return string.format("%.1f", p23);
    end;

    local math_floor_ret = math.floor(p23 + 0.5);

    return tostring(math_floor_ret);
end;

local v24 = {};
local v25 = { "Candy Blossom 2026" };
local v26 = {
    ["Easter Eggfruit"] = true,
    ["Easter Egg Melon"] = true
};

local function weightTargetsForScore(p27: number, p28: string) -- Line: 123
    -- upvalues: Item_Module (copy)
    local v29 = Item_Module.Return_Data(p28);

    if not (v29 and v29[2]) then
        return nil;
    end;

    local v30 = v29[2];
    local v31 = v29[4];
    local v32 = (not v31 or v31 <= 0) and 0 or 1 / v31;
    local v33 = v32 >= 0.35 and 1.4 or math.clamp(1.4 - 0.7 * (0.35 - v32) / (1 - v32), 0.7, 1.4);
    local v34 = (not v31 or v31 <= 0) and 0 or 1 / v31;
    local v35 = v34 >= 0.18 and 1.4 or math.clamp(1.4 - 0.7 * (0.18 - v34) / (1 - v34), 0.7, 1.4);
    local v36 = math.max(0, p27) / 600;
    local math_sqrt_ret = math.sqrt(v36);
    local math_min_ret = math.min(1, math_sqrt_ret);
    local v37 = {};
    local math_floor_ret = math.floor(math_min_ret * 8 + 0.5);
    v37.Medium = math.max(1, math_floor_ret);
    local math_floor_ret2 = math.floor(math_min_ret * 20 + 0.5);
    v37.Hard = math.max(1, math_floor_ret2);
    local v38 = v30 * v33;
    local v39;

    if v38 >= 10 then
        local math_floor_ret3 = math.floor(v38 + 0.5);
        v39 = tostring(math_floor_ret3);
    else
        v39 = string.format("%.1f", v38);
    end;

    v37.HeavyMed = v39;
    local v40 = v30 * v35;
    local v41;

    if v40 >= 10 then
        local math_floor_ret3 = math.floor(v40 + 0.5);
        v41 = tostring(math_floor_ret3);
    else
        v41 = string.format("%.1f", v40);
    end;

    v37.HeavyHard = v41;

    return v37;
end;

local function harvestTargetsForScore(p42: number) -- Line: 80
    local v43 = math.max(0, p42) / 400;
    local math_sqrt_ret = math.sqrt(v43);
    local v44 = math.min(1, math_sqrt_ret) * 100 + 0.5;
    local math_floor_ret = math.floor(v44);
    local math_max_ret = math.max(5, math_floor_ret);
    local v45 = {};
    local math_floor_ret2 = math.floor(math_max_ret * 0.25 + 0.5);
    local math_max_ret2 = math.max(1, math_floor_ret2);
    local math_floor_ret3 = math.floor(math_max_ret2 * 1 + 0.5);
    v45.Easy = math.max(1, math_floor_ret3);
    local math_floor_ret4 = math.floor(math_max_ret * 0.65 + 0.5);
    local math_max_ret3 = math.max(1, math_floor_ret4);
    local math_floor_ret5 = math.floor(math_max_ret3 * 1 + 0.5);
    v45.Medium = math.max(1, math_floor_ret5);
    local math_floor_ret6 = math.floor(math_max_ret * 1 + 0.5);
    v45.Hard = math.max(1, math_floor_ret6);

    return v45;
end;

for _, v in u1 do
    local v46 = SeedPackData.Packs[v];

    if v46 and v46.Items then
        for _, v2 in v46.Items do
            if v2.Type == "Seed" and v2.RewardId then
                v24["Easter " .. v2.RewardId] = true;
            end;
        end;
    end;
end;

local v47 = EventShopData["Easter Seed Shop"];

if v47 then
    for i, v in v47 do
        if v.ItemType == "Seed" then
            v24[i] = true;
        end;
    end;
end;

for _, v in v25 do
    v24[v] = true;
end;

local v48 = {};

for i in v24 do
    if not v26[i] then
        table.insert(v48, i);
    end;
end;

table.sort(v48);
local u49 = {};
local u50 = {};
local u51 = {};

local function points() -- Line: 196
    -- upvalues: QuestRewards (copy), TeamEventHelper (copy)
    return QuestRewards.TeamEventPoints:Use({
        Type = "TeamEventPoints",
        Amount = 1,
        EventName = TeamEventHelper.CurrentEvent
    });
end;

for _, v in v48 do
    local v52 = bestPackChance(v);
    local v53 = EventShopData["Easter Seed Shop"];

    if v53 then
        v53 = v53[v];
    end;

    local v54 = v52 + (not (v53 and (v53.StockChance and v53.StockAmount)) and 0 or (v53.StockAmount[1] + v53.StockAmount[2]) / 2 / v53.StockChance) * 100;
    local v55 = harvestTargetsForScore(v54);
    local Harvest = Quests.Harvest;
    local v56 = {
        Target = v55.Easy,
        Arguments = { v },
        Rewards = { points() }
    };
    table.insert(u51, Harvest:Use(v56));
    local Harvest2 = Quests.Harvest;
    local v57 = {
        Target = v55.Medium,
        Arguments = { v },
        Rewards = { points() }
    };
    table.insert(u50, Harvest2:Use(v57));
    local Harvest3 = Quests.Harvest;
    local v58 = {
        Target = v55.Hard,
        Arguments = { v },
        Rewards = { points() }
    };
    table.insert(u49, Harvest3:Use(v58));

    if v54 >= 30 then
        local v59 = weightTargetsForScore(v54, v);

        if v59 then
            local HarvestTargetWithWeight = Quests.HarvestTargetWithWeight;
            local v60 = {};
            local math_floor_ret = math.floor(v59.Medium * 1 + 0.5);
            v60.Target = math.max(1, math_floor_ret);
            v60.Arguments = { v59.HeavyMed, v };
            v60.Rewards = { points() };
            table.insert(u50, HarvestTargetWithWeight:Use(v60));
            local HarvestTargetWithWeight2 = Quests.HarvestTargetWithWeight;
            local v61 = {};
            local math_floor_ret2 = math.floor(v59.Hard * 1 + 0.5);
            v61.Target = math.max(1, math_floor_ret2);
            v61.Arguments = { v59.HeavyHard, v };
            v61.Rewards = { points() };
            table.insert(u49, HarvestTargetWithWeight2:Use(v61));
        end;
    end;
end;

local PlantWithTrait = Quests.PlantWithTrait;
local v62 = {
    Target = 50,
    Arguments = { "Easter" },
    Rewards = { points() }
};
table.insert(u51, PlantWithTrait:Use(v62));
local PlantWithTrait2 = Quests.PlantWithTrait;
local v63 = {
    Target = 100,
    Arguments = { "Easter" },
    Rewards = { points() }
};
table.insert(u50, PlantWithTrait2:Use(v63));
local PlantWithTrait3 = Quests.PlantWithTrait;
local v64 = {
    Target = 200,
    Arguments = { "Easter" },
    Rewards = { points() }
};
table.insert(u49, PlantWithTrait3:Use(v64));
local OpenSeedPack = Quests.OpenSeedPack;
local v65 = {
    Target = 3,
    Arguments = { "Easter Seed Pack" },
    Rewards = { points() }
};
table.insert(u51, OpenSeedPack:Use(v65));
local OpenSeedPack2 = Quests.OpenSeedPack;
local v66 = {
    Target = 7,
    Arguments = { "Easter Seed Pack" },
    Rewards = { points() }
};
table.insert(u50, OpenSeedPack2:Use(v66));
local OpenSeedPack3 = Quests.OpenSeedPack;
local v67 = {
    Target = 12,
    Arguments = { "Easter Seed Pack" },
    Rewards = { points() }
};
table.insert(u49, OpenSeedPack3:Use(v67));
local OpenSeedPack4 = Quests.OpenSeedPack;
local v68 = {
    Target = 1,
    Arguments = { "Exotic Easter Seed Pack" },
    Rewards = { points() }
};
table.insert(u50, OpenSeedPack4:Use(v68));
local OpenSeedPack5 = Quests.OpenSeedPack;
local v69 = {
    Target = 2,
    Arguments = { "Exotic Easter Seed Pack" },
    Rewards = { points() }
};
table.insert(u49, OpenSeedPack5:Use(v69));
local EarnEventCurrency = Quests.EarnEventCurrency;
local v70 = {
    Target = 5000,
    Arguments = { "ChocCoins" },
    Rewards = { points() }
};
table.insert(u51, EarnEventCurrency:Use(v70));
local EarnEventCurrency2 = Quests.EarnEventCurrency;
local v71 = {
    Target = 7500,
    Arguments = { "ChocCoins" },
    Rewards = { points() }
};
table.insert(u50, EarnEventCurrency2:Use(v71));
local EarnEventCurrency3 = Quests.EarnEventCurrency;
local v72 = {
    Target = 20000,
    Arguments = { "ChocCoins" },
    Rewards = { points() }
};
table.insert(u49, EarnEventCurrency3:Use(v72));
local HatchEgg = Quests.HatchEgg;
local v73 = {
    Target = 3,
    Arguments = { "Golden Egg" },
    Rewards = { points() }
};
table.insert(u51, HatchEgg:Use(v73));
local HatchEgg2 = Quests.HatchEgg;
local v74 = {
    Target = 6,
    Arguments = { "Golden Egg" },
    Rewards = { points() }
};
table.insert(u50, HatchEgg2:Use(v74));
local HatchEgg3 = Quests.HatchEgg;
local v75 = {
    Target = 10,
    Arguments = { "Golden Egg" },
    Rewards = { points() }
};
table.insert(u49, HatchEgg3:Use(v75));
local HatchEgg4 = Quests.HatchEgg;
local v76 = {
    Target = 2,
    Arguments = { "Springtide Egg" },
    Rewards = { points() }
};
table.insert(u51, HatchEgg4:Use(v76));
local HatchEgg5 = Quests.HatchEgg;
local v77 = {
    Target = 4,
    Arguments = { "Springtide Egg" },
    Rewards = { points() }
};
table.insert(u50, HatchEgg5:Use(v77));
local HatchEgg6 = Quests.HatchEgg;
local v78 = {
    Target = 8,
    Arguments = { "Springtide Egg" },
    Rewards = { points() }
};
table.insert(u49, HatchEgg6:Use(v78));
local BuyGoldenEgg = Quests.BuyGoldenEgg;
local v79 = {
    Target = 3,
    Arguments = {},
    Rewards = { points() }
};
table.insert(u51, BuyGoldenEgg:Use(v79));
local BuyGoldenEgg2 = Quests.BuyGoldenEgg;
local v80 = {
    Target = 6,
    Arguments = {},
    Rewards = { points() }
};
table.insert(u50, BuyGoldenEgg2:Use(v80));
local BuyGoldenEgg3 = Quests.BuyGoldenEgg;
local v81 = {
    Target = 10,
    Arguments = {},
    Rewards = { points() }
};
table.insert(u49, BuyGoldenEgg3:Use(v81));
local Craft = Quests.Craft;
local v82 = {
    Target = 1,
    Arguments = { "Seed", "Egg Melon" },
    Rewards = { points() }
};
table.insert(u51, Craft:Use(v82));
local Craft2 = Quests.Craft;
local v83 = {
    Target = 2,
    Arguments = { "Seed", "Egg Melon" },
    Rewards = { points() }
};
table.insert(u50, Craft2:Use(v83));
local Craft3 = Quests.Craft;
local v84 = {
    Target = 3,
    Arguments = { "Seed", "Egg Melon" },
    Rewards = { points() }
};
table.insert(u49, Craft3:Use(v84));
local PlaceObject = Quests.PlaceObject;
local v85 = {
    Target = 2,
    Arguments = { "Chocolate Sprinkler" },
    Rewards = { points() }
};
table.insert(u51, PlaceObject:Use(v85));
local PlaceObject2 = Quests.PlaceObject;
local v86 = {
    Target = 4,
    Arguments = { "Chocolate Sprinkler" },
    Rewards = { points() }
};
table.insert(u50, PlaceObject2:Use(v86));
local PlaceObject3 = Quests.PlaceObject;
local v87 = {
    Target = 7,
    Arguments = { "Chocolate Sprinkler" },
    Rewards = { points() }
};
table.insert(u49, PlaceObject3:Use(v87));
local v88 = {
    ["Easter Egg Melon"] = true
};
local v89 = {
    ["Gummy Bear"] = {
        Hard = 1
    }
};

local function buyTargetsForExpectedStock(p90: number) -- Line: 288
    return p90 >= 5 and {
        Easy = 5,
        Medium = 15,
        Hard = 30
    } or (p90 >= 1.5 and {
        Easy = 2,
        Medium = 4,
        Hard = 8
    } or (p90 >= 0.5 and {
        Easy = 1,
        Medium = 2,
        Hard = 4
    } or (p90 >= 0.15 and {
        Easy = 1,
        Medium = 2,
        Hard = 3
    } or (p90 >= 0.06 and {
        Medium = 1,
        Hard = 2
    } or (p90 >= 0.025 and {
        Hard = 1
    } or nil)))));
end;

local v91 = EventShopData["Easter Seed Shop"];

if v91 and Quests.BuyEventShopItem then
    for i, v in v91 do
        if not v88[i] and (v.StockChance and v.StockAmount) then
            local v92 = buyTargetsForExpectedStock((v.StockAmount[1] + v.StockAmount[2]) / 2 / v.StockChance);

            if v92 then
                local v93 = v89[i];
                local v94 = v93 and {
                    Easy = v93.Easy or v92.Easy,
                    Medium = v93.Medium or v92.Medium,
                    Hard = v93.Hard or v92.Hard
                } or v92;
                local v95 = { "Easter Seed Shop", i };

                if v94.Easy then
                    local BuyEventShopItem = Quests.BuyEventShopItem;
                    local v96 = {};
                    local math_floor_ret = math.floor(v94.Easy * 1 + 0.5);
                    v96.Target = math.max(1, math_floor_ret);
                    v96.Arguments = v95;
                    v96.Rewards = { points() };
                    table.insert(u51, BuyEventShopItem:Use(v96));
                end;

                if v94.Medium then
                    local BuyEventShopItem = Quests.BuyEventShopItem;
                    local v97 = {};
                    local math_floor_ret = math.floor(v94.Medium * 1 + 0.5);
                    v97.Target = math.max(1, math_floor_ret);
                    v97.Arguments = v95;
                    v97.Rewards = { points() };
                    table.insert(u50, BuyEventShopItem:Use(v97));
                end;

                if v94.Hard then
                    local BuyEventShopItem = Quests.BuyEventShopItem;
                    local v98 = {};
                    local math_floor_ret = math.floor(v94.Hard * 1 + 0.5);
                    v98.Target = math.max(1, math_floor_ret);
                    v98.Arguments = v95;
                    v98.Rewards = { points() };
                    table.insert(u49, BuyEventShopItem:Use(v98));
                end;
            end;
        end;
    end;
end;

return {
    Type = "EasterTraining",
    IsIndividual = true,

    Display = function(p99) -- Line: 333, Name: Display
        return "Team Event Quests";
    end,

    Generate = function(p100, p101) -- Line: 337, Name: Generate
        -- upvalues: u51 (copy), u50 (copy), u49 (copy)
        local v102 = {};
        local Random_new_ret = Random.new();
        local table_clone_ret = table.clone(u51);
        local table_clone_ret2 = table.clone(u50);
        local table_clone_ret3 = table.clone(u49);
        local v103 = table_clone_ret[Random_new_ret:NextInteger(1, #table_clone_ret)];
        local v104 = table_clone_ret2[Random_new_ret:NextInteger(1, #table_clone_ret2)];
        local v105 = table_clone_ret3[Random_new_ret:NextInteger(1, #table_clone_ret3)];
        table.insert(v102, v103);
        table.insert(v102, v104);
        table.insert(v102, v105);

        return {
            Quests = v102,
            Rewards = type(p101) ~= "function" and {} or p101({
                type = "rewards"
            })
        };
    end
};