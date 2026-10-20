-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    Quests.Harvest:Use({
        Target = 20,
        Arguments = { "Corn" }
    }),
    Quests.Harvest:Use({
        Target = 25,
        Arguments = { "Apple" }
    }),
    Quests.Harvest:Use({
        Target = 1,
        Arguments = { "Pumpkin" }
    }),
    Quests.Plant:Use({
        Target = 3,
        Arguments = { "Turnip" }
    }),
    Quests.Plant:Use({
        Target = 2,
        Arguments = { "Parsley" }
    }),
    Quests.Plant:Use({
        Target = 1,
        Arguments = { "Meyer Lemon" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Parsley" }
    }),
    Quests.Harvest:Use({
        Target = 5,
        Arguments = { "Turnip" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Salmon", "10" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Chipmunk", "10" }
    }),
    Quests.TriggerFallBloom:Use({
        Target = 1,
        Arguments = {}
    }),
    Quests.HatchEgg:Use({
        Target = 1,
        Arguments = { "Fall Egg" }
    }),
    Quests.OpenSeedPack:Use({
        Target = 1,
        AnyArguments = true,
        Arguments = { "Autumn Seed Pack", "Exotic Autumn Seed Pack", "Rainbow Exotic Autumn Seed Pack" }
    }),
    Quests.OpenCrate:Use({
        Target = 1,
        Arguments = { "Autumn Crate" }
    }),
    Quests.WaterPlants:Use({
        Target = 10,
        Arguments = {}
    }),
    Quests.SubmitHarvestSpiritFruit:Use({
        Target = 10,
        Arguments = {}
    }),
    Quests.UseMapleLeafCharm:Use({
        Target = 1,
        Arguments = {}
    }),
    Quests.UseMapleSyrup:Use({
        Target = 1,
        Arguments = {}
    }),
    Quests.FeedAnyPet:Use({
        Target = 3,
        Arguments = {}
    }),
    Quests.FeedAnyPetFood:Use({
        Target = 1,
        Arguments = { "Soup" }
    }),
    Quests.PlaceObject:Use({
        Target = 3,
        Arguments = { "Basic Sprinkler" }
    }),
    Quests.PlaceObject:Use({
        Target = 2,
        Arguments = { "Advanced Sprinkler" }
    }),
    Quests.PlaceObject:Use({
        Target = 1,
        Arguments = { "Godly Sprinkler" }
    }),
    Quests.PlaceObject:Use({
        Target = 1,
        Arguments = { "Maple Sprinkler" }
    }),
    Quests.PlaceObject:Use({
        Target = 1,
        Arguments = { "Bonfire" }
    })
};
local u2 = { QuestRewards["Fall Energy"]:Use({
        Amount = 20,
        Type = "Fall Energy"
    }) };

return {
    Type = "Fall",
    CustomData = {
        PossibleQuests = u1,
        PossibleRewards = u2
    },

    Display = function(p3) -- Line: 166, Name: Display
        return "Fall Event Quests";
    end,

    Generate = function(p4, p5) -- Line: 170, Name: Generate
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