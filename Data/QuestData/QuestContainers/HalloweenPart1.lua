-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    Quests.Plant:Use({
        Target = 10,
        Arguments = { "Pumpkin" }
    }),
    Quests.Harvest:Use({
        Target = 5,
        Arguments = { "Pumpkin" }
    }),
    Quests.Plant:Use({
        Target = 3,
        Arguments = { "Great Pumpkin" }
    }),
    Quests.Harvest:Use({
        Target = 1,
        Arguments = { "Great Pumpkin" }
    }),
    Quests.HarvestMutation:Use({
        Target = 10,
        Arguments = { "Ghostly" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Ghostly" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Bat", "25" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Bone Dog", "20" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Spider", "15" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Black Cat", "10" }
    }),
    Quests.GrowPetToAge:Use({
        Target = 1,
        Arguments = { "Headless Horseman", "5" }
    }),
    Quests.HatchEgg:Use({
        Target = 10,
        Arguments = { "Spooky Egg" }
    }),
    Quests.SubmitWitchsCauldron:Use({
        Target = 25
    }),
    Quests.SubmitWitchsCauldron:Use({
        Target = 10
    }),
    Quests.SubmitWitchsCauldron:Use({
        Target = 5
    }),
    Quests.SubmitJackoLantern:Use({
        Target = 25
    }),
    Quests.SubmitJackoLantern:Use({
        Target = 10
    }),
    Quests.SubmitJackoLantern:Use({
        Target = 5
    }),
    Quests.EarnEventCurrency:Use({
        Target = 25,
        Arguments = { "CandyCorn" }
    }),
    Quests.EarnEventCurrency:Use({
        Target = 10,
        Arguments = { "CandyCorn" }
    }),
    Quests.EarnEventCurrency:Use({
        Target = 5,
        Arguments = { "CandyCorn" }
    })
};
local u2 = { QuestRewards["Seed Pack"]:Use({
        Amount = 1,
        Type = "Zen Seed Pack"
    }), QuestRewards.Currency:Use({
        Type = "CandyCorn",
        Amount = 100
    }), QuestRewards.Egg:Use({
        Type = "Zen Egg",
        Amount = 1
    }) };

return {
    DisplayName = "Halloween",
    Type = "HalloweenPart1",
    CustomData = {
        PossibleQuests = u1,
        PossibleRewards = u2
    },

    Display = function(p3) -- Line: 145, Name: Display
        return "Ghoul Garden Quests";
    end,

    Generate = function(p4, p5) -- Line: 149, Name: Generate
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