-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    FinalReward = {
        Type = "Seed",
        Value = "Severed Spine",
        Quantity = 1
    },
    SecondaryRewards = { {
            Type = "Seed Pack",
            Value = "Spooky Chest",
            Quantity = 5,
            Chance = 50
        }, {
            Type = "Egg",
            Value = "Spooky Egg",
            Quantity = 3,
            Chance = 10
        }, {
            Type = "Seed Pack",
            Value = "Halloween Gear Box",
            Quantity = 3,
            Chance = 10
        } },
    SmallRewards = { {
            Type = "Currency",
            Value = "CandyCorn",
            Quantity = 50,
            Chance = 15
        } }
};