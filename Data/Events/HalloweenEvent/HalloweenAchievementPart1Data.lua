-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "PUMPKIN",
            Quantity = 1
        } },
    Quests = {
        {
            Id = "Halloween_EventP1_Harvest_10_Ghostly_Plants",
            Display = "Harvest 10 Ghostly Mutated Plants",
            Type = "HarvestMutation",
            Target = 10,
            Arguments = { "Ghostly" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP1_Harvest_25_Ghostly_Plants",
            Display = "Harvest 25 Ghostly Mutated Plants",
            Type = "HarvestMutation",
            Target = 25,
            Arguments = { "Ghostly" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Harvest_50_Ghostly_Plants",
            Display = "Harvest 50 Ghostly Mutated Plants",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Ghostly" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_10_Pumpkin",
            Display = "Plant 10 Pumpkin",
            Type = "Plant",
            Target = 10,
            Arguments = { "Pumpkin" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_15_Bloodred_Mushroom",
            Display = "Plant 15 Bloodred Mushroom",
            Type = "Plant",
            Target = 15,
            Arguments = { "Bloodred Mushroom" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_10_Jack_O_Lantern",
            Display = "Plant 10 Jack-O-Lantern",
            Type = "Plant",
            Target = 10,
            Arguments = { "Jack O Lantern" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_7_Ghoul_Root",
            Display = "Plant 7 Ghoul Root",
            Type = "Plant",
            Target = 7,
            Arguments = { "Ghoul Root" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_5_Chicken_Feed",
            Display = "Plant 5 Chicken Feed",
            Type = "Plant",
            Target = 5,
            Arguments = { "Chicken Feed" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_3_Seer_Vine",
            Display = "Plant 3 Seer Vine",
            Type = "Plant",
            Target = 3,
            Arguments = { "Seer Vine" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Plant_2_Poison_Apple",
            Display = "Plant 2 Poison Apple",
            Type = "Plant",
            Target = 2,
            Arguments = { "Poison Apple" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Hatch_5_Spooky_Eggs",
            Display = "Hatch 5 Spooky Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 5,
            Arguments = { "Spooky Egg", "Premium Spooky Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP1_Hatch_15_Spooky_Eggs",
            Display = "Hatch 15 Spooky Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Spooky Egg", "Premium Spooky Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP1_Hatch_30_Spooky_Eggs",
            Display = "Hatch 30 Spooky Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Spooky Egg", "Premium Spooky Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Halloween_EventP1_A_Bat",
            Display = "Obtain a Bat",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Bat" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Halloween_EventP1_A_Bone Dog",
            Display = "Obtain a Bone Dog",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Bone Dog" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Halloween_EventP1_A_Spider",
            Display = "Obtain a Spider",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Spider" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP1_A_Black_Cat",
            Display = "Obtain an Black Cat",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Black Cat" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 120
                } }
        },
        {
            Id = "Halloween_EventP1_A_Pumpkin_Rat",
            Display = "Obtain a Pumpkin Rat",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Pumpkin Rat" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Halloween_EventP1_A_Ghost_Bear",
            Display = "Obtain a Ghost Bear",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Ghost Bear" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Halloween_EventP1_A_Wolf",
            Display = "Obtain a Wolf",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Wolf" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP1_A_Reaper",
            Display = "Obtain a Reaper",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Reaper" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 120
                } }
        },
        {
            Id = "Halloween_EventP1_Earn_10_Candy_Corn",
            Display = "Earn 10 Candy Corn",
            Type = "EarnSpecialCurrency",
            Target = 10,
            Arguments = { "CandyCorn" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Halloween_EventP1_Earn_25_Candy_Corn",
            Display = "Earn 25 Candy Corn",
            Type = "EarnSpecialCurrency",
            Target = 25,
            Arguments = { "CandyCorn" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP1_Earn_100_Candy_Corn",
            Display = "Earn 100 Candy Corn",
            Type = "EarnSpecialCurrency",
            Target = 100,
            Arguments = { "CandyCorn" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Halloween_EventP1_Get_Jumpscared_1",
            Display = "Beware the Consequences of the Jack-o-Lantern!",
            Type = "HP1_GetJumpscared",
            Target = 1,
            Arguments = {},
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 25
                } }
        }
    }
};