-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    Quests.EarnSheckles:Use({
        Target = 1500
    }),
    Quests.Plant:Use({
        Target = 3,
        Arguments = { "Monoblooma" }
    }),
    Quests.Plant:Use({
        Target = 20,
        Arguments = { "Tomato" }
    }),
    Quests.Plant:Use({
        Target = 15,
        Arguments = { "Bamboo" }
    }),
    Quests.Plant:Use({
        Target = 1,
        Arguments = { "Mango" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Bunny", "10" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Golden Lab", "10" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Shiba Inu", "10" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Bamboo" }
    }),
    Quests.Harvest:Use({
        Target = 25,
        Arguments = { "Apple" }
    }),
    Quests.Harvest:Use({
        Target = 5,
        Arguments = { "Dragon Fruit" }
    }),
    Quests.HarvestMutation:Use({
        Target = 10,
        Arguments = { "Tranquil" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Moonlit" }
    }),
    Quests.Craft:Use({
        Target = 1,
        Arguments = { "Gear", "Reclaimer" }
    }),
    Quests.Craft:Use({
        Target = 1,
        Arguments = { "Gear", "Mutation Spray Chilled" }
    })
};
local u2 = { QuestRewards["Seed Pack"]:Use({
        Amount = 1,
        Type = "Zen Seed Pack"
    }), QuestRewards.Currency:Use({
        Type = "Chi",
        Amount = 10
    }), QuestRewards.Egg:Use({
        Type = "Zen Egg",
        Amount = 1
    }) };

return {
    Type = "Zen",
    CustomData = {
        PossibleQuests = u1,
        PossibleRewards = u2
    },

    Display = function(p3) -- Line: 109, Name: Display
        return "Zen Event Quests";
    end,

    Generate = function(p4, p5) -- Line: 113, Name: Generate
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