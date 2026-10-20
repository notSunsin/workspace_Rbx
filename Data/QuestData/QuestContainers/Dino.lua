-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    Quests.Plant:Use({
        Target = 100,
        Arguments = { "Carrot" }
    }),
    Quests.Plant:Use({
        Target = 10,
        Arguments = { "Watermelon" }
    }),
    Quests.Plant:Use({
        Target = 5,
        Arguments = { "Pumpkin" }
    }),
    Quests.Plant:Use({
        Target = 25,
        Arguments = { "Bamboo" }
    }),
    Quests.Plant:Use({
        Target = 1,
        Arguments = { "Mango" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Dog", "10" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Golden Lab", "10" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Bunny", "10" }
    }),
    Quests.Harvest:Use({
        Target = 50,
        Arguments = { "Strawberry" }
    }),
    Quests.Harvest:Use({
        Target = 150,
        Arguments = { "Blueberry" }
    }),
    Quests.Harvest:Use({
        Target = 25,
        Arguments = { "Apple" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Coconut" }
    }),
    Quests.Harvest:Use({
        Target = 5,
        Arguments = { "Dragon Fruit" }
    }),
    Quests.Craft:Use({
        Target = 1,
        Arguments = { "Gear", "Lightning Rod" }
    }),
    Quests.Craft:Use({
        Target = 1,
        Arguments = { "Gear", "Mutation Spray Amber" }
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
    Type = "Dino",
    CustomData = {
        PossibleQuests = u1,
        PossibleRewards = u2
    },

    Display = function(p3) -- Line: 104, Name: Display
        return "Dino Event Quests";
    end,

    Generate = function(p4, p5) -- Line: 108, Name: Generate
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