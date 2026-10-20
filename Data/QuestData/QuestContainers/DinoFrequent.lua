-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    Quests.Plant:Use({
        Target = 10,
        Arguments = { "Stonebite" }
    }),
    Quests.Plant:Use({
        Target = 3,
        Arguments = { "Boneboo" }
    }),
    Quests.Plant:Use({
        Target = 100,
        Arguments = { "Carrot" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Raptor", "15" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Iguanodon", "15" }
    }),
    Quests.Harvest:Use({
        Target = 500,
        Arguments = { "Strawberry" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Paradise Petal" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Bone Blossom" }
    }),
    Quests.Craft:Use({
        Target = 1,
        Arguments = { "Seed", "Amber Spine" }
    }),
    Quests.Craft:Use({
        Target = 3,
        Arguments = { "Seed", "Horsetail" }
    })
};
local u2 = { QuestRewards["Seed Pack"]:Use({
        Amount = 1,
        Type = "Ancient Seed Pack"
    }), QuestRewards["Cosmetic Crate"]:Use({
        Type = "Dino Crate",
        Amount = 1
    }), QuestRewards.Egg:Use({
        Type = "Dinosaur Egg",
        Amount = 1
    }) };

return {
    Type = "DinoFrequent",
    CustomData = {
        PossibleQuests = u1,
        PossibleRewards = u2
    },

    Display = function(p3) -- Line: 86, Name: Display
        return "Dino Event Quests";
    end,

    Generate = function(p4, p5) -- Line: 90, Name: Generate
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