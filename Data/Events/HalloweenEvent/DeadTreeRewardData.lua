-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local DeepClone = require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    StockItem = "Weeping Branch",
    Rewards = {
        {
            Type = "Currency",
            Value = "CandyCorn",
            Quantity = 50,
            Chance = 45
        },
        {
            Type = "Gear",
            Value = "Harvest Tool",
            Quantity = 15,
            Chance = 40
        },
        {
            Type = "Gear",
            Value = "Godly Sprinkler",
            Quantity = 3,
            Chance = 40
        },
        {
            Type = "Gear",
            Value = "Witch\'s Broom",
            Quantity = 10,
            Chance = 35
        },
        {
            Type = "Gear",
            Value = "Suspicious Soup",
            Quantity = 5,
            Chance = 35
        },
        {
            Type = "Gear",
            Value = "Reclaimer",
            Quantity = 3,
            Chance = 30
        },
        {
            Type = "Gear",
            Value = "Silver Fertilizer",
            Quantity = 1,
            Chance = 25
        },
        {
            Type = "Crate",
            Value = "Pumpkin Crate",
            Quantity = 1,
            Chance = 20
        },
        {
            Type = "Crate",
            Value = "Spooky Crate",
            Quantity = 1,
            Chance = 20
        },
        {
            Type = "Seed Pack",
            Value = "Halloween Gear Box",
            Quantity = 1,
            Chance = 20
        },
        {
            Type = "Egg",
            Value = "Spooky Egg",
            Quantity = 1,
            Chance = 18
        },
        {
            Type = "Currency",
            Value = "CandyCorn",
            Quantity = 100,
            Chance = 15
        },
        {
            Type = "Gear",
            Value = "Master Sprinkler",
            Quantity = 2,
            Chance = 10
        },
        {
            Type = "Gear",
            Value = "Medium Treat",
            Quantity = 1,
            Chance = 9
        },
        {
            Type = "Gear",
            Value = "Medium Toy",
            Quantity = 1,
            Chance = 9
        },
        {
            Type = "Gear",
            Value = "Gold Fertilizer",
            Quantity = 2,
            Chance = 8
        },
        {
            Type = "Gear",
            Value = "Levelup Lollipop",
            Quantity = 1,
            Chance = 6
        },
        {
            Type = "Gear",
            Value = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 5
        },
        {
            Type = "Gear",
            Value = "Rainbow Fertilizer",
            Quantity = 1,
            Chance = 5
        },
        {
            Type = "Seed",
            Value = "Weeping Branch",
            Quantity = 1,
            Chance = 2
        }
    },

    PickRandom = function(p1: table, p2: userdata?) -- Line: 135, Name: PickRandom
        -- upvalues: DeepClone (copy), RunService (copy)
        local v3 = DeepClone(p1.Rewards);
        local v4 = 0;

        for _, v in v3 do
            if RunService:IsServer() and (p2 and v.Value == "Weeping Branch") then
                local PlayerDataAsync = require(game.ServerScriptService.Modules.DataService):GetPlayerDataAsync(p2);

                if not PlayerDataAsync then
                    return;
                end;

                v.Chance = v.Chance + PlayerDataAsync.HalloweenEventData.DeadTree.WeepingSeedBonusChance;
            end;

            v4 = v4 + (v.Chance or 1);
        end;

        table.sort(v3, function(p5, p6) -- Line: 154
            return (p5.Chance or 1) > (p6.Chance or 1);
        end);
        local v7 = math.random() * v4;
        local v8 = 0;

        for _, v in v3 do
            v8 = v8 + (v.Chance or 1);

            if v7 <= v8 then
                return v;
            end;
        end;
    end
};