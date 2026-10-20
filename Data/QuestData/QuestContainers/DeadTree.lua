-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    Quests.Plant:Use({
        Target = 10,
        Arguments = { "Bloodred Mushroom" }
    }),
    Quests.Harvest:Use({
        Target = 5,
        Arguments = { "Pumpkin" }
    }),
    Quests.Harvest:Use({
        Target = 2,
        Arguments = { "Jack O Lantern" }
    }),
    Quests.Harvest:Use({
        Target = 1,
        Arguments = { "Banesberry" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Corn" }
    }),
    Quests.WaterPlants:Use({
        Target = 30,
        Arguments = {}
    }),
    Quests.HarvestMutation:Use({
        Target = 10,
        Arguments = { "Spooky" }
    }),
    Quests.HarvestMutation:Use({
        Target = 10,
        Arguments = { "Vamp" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Moonlit" }
    }),
    Quests.OpenSeedPack:Use({
        Target = 3,
        Arguments = { "Halloween Gear Box" }
    }),
    Quests.EatSuspiciousSoup:Use({
        Target = 3,
        Arguments = {}
    }),
    Quests.TravelWitchesBroom:Use({
        Target = 250,
        Arguments = {}
    }),
    Quests.OpenCrate:Use({
        Target = 1,
        Arguments = { "Pumpkin Crate" }
    }),
    Quests.OpenCrate:Use({
        Target = 1,
        Arguments = { "Spooky Crate" }
    }),
    Quests.FeedAnyPet:Use({
        Target = 15,
        Arguments = {}
    }),
    Quests.HatchEgg:Use({
        Target = 1,
        Arguments = { "Spooky Egg" }
    }),
    Quests.AgePetWithTrait:Use({
        Target = 10,
        Arguments = { "Halloween" }
    }),
    Quests.SellAnyPlant:Use({
        Target = 40,
        Arguments = {}
    }),
    Quests.SellPlant:Use({
        Target = 10,
        Arguments = { "Pumpkin" }
    }),
    Quests.SellPlant:Use({
        Target = 25,
        Arguments = { "Corn" }
    }),
    Quests.SellPlant:Use({
        Target = 5,
        Arguments = { "Bloodred Mushroom" }
    }),
    Quests.SellPlant:Use({
        Target = 1,
        Arguments = { "Jack O Lantern" }
    }),
    Quests.EarnSheckles:Use({
        Target = 500000
    }),
    Quests.SpendCurrency:Use({
        Target = 50,
        Arguments = { "CandyCorn" }
    }),
    Quests.SpendCurrency:Use({
        Target = 500000,
        Arguments = { "Sheckles" }
    })
};
local u2 = {};

return {
    Type = "DeadTree",
    CustomData = {
        PossibleQuests = u1,
        PossibleRewards = u2
    },
    EventConfig = {
        HalloweenEvent = 2
    },

    Display = function(p3) -- Line: 173, Name: Display
        return "Dead Tree Quests";
    end,

    Generate = function(p4, p5) -- Line: 177, Name: Generate
        -- upvalues: u1 (copy), u2 (copy)
        local table_create_ret = table.create(1);
        local v6;

        if type(p5) == "function" then
            v6 = p5({
                type = "quests"
            });
        else
            v6 = table.clone(u1);
        end;

        local Random_new_ret = Random.new();
        Random_new_ret:Shuffle(v6);
        table_create_ret[1] = table.remove(v6, 1) or u1[Random_new_ret:NextInteger(1, #u1)];
        local v7 = {
            Quests = table_create_ret
        };
        local v8;

        if type(p5) == "function" then
            v8 = p5({
                type = "rewards"
            });
        else
            v8 = { u2[Random_new_ret:NextInteger(1, #u2)] };
        end;

        v7.Rewards = v8;

        return v7;
    end
};