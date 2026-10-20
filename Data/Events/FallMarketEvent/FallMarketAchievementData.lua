-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "FALL",
            Quantity = 1
        }, {
            Type = "Seed Pack",
            Value = "Fall Seed Pack",
            Quantity = 5
        }, {
            Type = "Egg",
            Value = "Fall Egg",
            Quantity = 5
        }, {
            Type = "Cosmetic",
            Value = "Fall Market Cart",
            Quantity = 1
        } },
    Quests = {
        {
            Id = "Fall_Event_Harvest_10_Fall_Plants",
            Display = "Harvest 10 Fall Mutated Plants",
            Type = "HarvestMutation",
            Target = 10,
            Arguments = { "Fall" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fall_Event_Harvest_50_Fall_Plants",
            Display = "Harvest 50 Fall Mutated Plants",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Fall" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fall_Event_Harvest_100_Fall_Plants",
            Display = "Harvest 100 Fall Mutated Plants",
            Type = "HarvestMutation",
            Target = 100,
            Arguments = { "Fall" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Fall_Event_Plant_Pumpkin",
            Display = "Plant 5 Carnival Pumpkin",
            Type = "Plant",
            Target = 5,
            Arguments = { "Carnival Pumpkin" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fall_Event_Plant_Autumn_Shroom",
            Display = "Plant 10 Autumn Shroom",
            Type = "Plant",
            Target = 10,
            Arguments = { "Autumn Shroom" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fall_Event_Plant_Speargrass",
            Display = "Plant 3 Speargrass",
            Type = "Plant",
            Target = 3,
            Arguments = { "Speargrass" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Fall_Event_Plant_Auburn_Pine",
            Display = "Plant 1 Auburn Pine",
            Type = "Plant",
            Target = 1,
            Arguments = { "Auburn Pine" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Fall_Event_Plant_Peach",
            Display = "Plant 1 Golden Peach",
            Type = "Plant",
            Target = 1,
            Arguments = { "Golden Peach" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Fall_Event_Hatch_5_Fall_Eggs",
            Display = "Hatch 5 Fall Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 5,
            Arguments = { "Fall Egg", "Premium Fall Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fall_Event_Hatch_15_Fall_Eggs",
            Display = "Hatch 15 Fall Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Fall Egg", "Premium Fall Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fall_Event_Hatch_30_Fall_Eggs",
            Display = "Hatch 30 Fall Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Fall Egg", "Premium Fall Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                }, {
                    Type = "Gear",
                    Value = "Small Treat",
                    Quantity = 3
                }, {
                    Type = "Gear",
                    Value = "Small Toy",
                    Quantity = 3
                } }
        },
        {
            Id = "Fall_Event_A_Grizzly_Bear",
            Display = "Obtain a Grizzly Bear",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Grizzly Bear" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Fall_Event_A_Badger",
            Display = "Obtain a Badger",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Badger" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Fall_Event_A_Chipmunk",
            Display = "Obtain a Chipmunk",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Chipmunk" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Fall_Event_A_Red_Squirrel",
            Display = "Obtain a Red Squirrel",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Red Squirrel" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fall_Event_A_Salmon",
            Display = "Obtain a Salmon",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Salmon" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fall_Event_A_Mallard",
            Display = "Obtain a Mallard",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Mallard" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fall_Event_A_Sugar_Glider",
            Display = "Obtain an Sugar Glider",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Sugar Glider" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 120
                } }
        },
        {
            Id = "Fall_Event_A_Space Squirrel",
            Display = "Obtain a Space Squirrel",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Space Squirrel" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 1000
                } }
        }
    }
};