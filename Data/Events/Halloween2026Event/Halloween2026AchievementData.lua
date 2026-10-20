-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "HALLOWEEN_2026",
            Quantity = 1
        }, {
            Type = "Egg",
            Value = "Haunted Egg",
            Quantity = 5
        }, {
            Type = "Seed Pack",
            Value = "Haunted Seed Pack",
            Quantity = 5
        }, {
            Type = "Cosmetic",
            Value = "Ghoul Garden Statue",
            Quantity = 1
        } },
    Quests = {
        {
            Id = "Halloween2026_Fill_Cauldron_Easy",
            Display = "Fill the Cauldron 30 times",
            Type = "H2026_FillCauldron",
            Target = 30,
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Open_Seedpacks_Easy",
            Display = "Open 15 Haunted Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Haunted Seed Pack", "Exotic Haunted Seed Pack", "Rainbow Exotic Haunted Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Earn_CandyCorn_Easy",
            Display = "Earn 250 Candy Corn",
            Type = "EarnSpecialCurrency",
            AnyArgumentsMatch = true,
            Target = 250,
            Arguments = { "CandyCorn" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Easy_1",
            Display = "Harvest 200 Candy Corn Carrot",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 200,
            Arguments = { "Candy Corn Carrot", "Halloween Candy Corn Carrot" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Easy_2",
            Display = "Harvest 240 Spider Shrub",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 240,
            Arguments = { "Spider Shrub", "Halloween Spider Shrub" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Easy_3",
            Display = "Harvest 280 Pumpkin Lantern",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 280,
            Arguments = { "Pumpkin Lantern", "Halloween Pumpkin Lantern" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Easy_4",
            Display = "Harvest 320 Candy Cluster",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 320,
            Arguments = { "Candy Cluster", "Halloween Candy Cluster" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween2026_Feed_Black_Cat_Medium",
            Display = "Feed the Black Cat 15 times",
            Type = "H2026_FeedBlackCat",
            Target = 15,
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Get_Treats_Medium",
            Display = "Get Treats from Scream-ven 10 times",
            Type = "H2026_GetTreats",
            Target = 10,
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Open_Seedpacks_Medium",
            Display = "Open 30 Haunted Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Haunted Seed Pack", "Exotic Haunted Seed Pack", "Rainbow Exotic Haunted Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Earn_CandyCorn_Medium",
            Display = "Earn 500 Candy Corn",
            Type = "EarnSpecialCurrency",
            AnyArgumentsMatch = true,
            Target = 500,
            Arguments = { "CandyCorn" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Hatch_Eggs_Medium",
            Display = "Hatch 15 Haunted Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Haunted Egg", "Premium Haunted Egg", "Ghostly Premium Haunted Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Medium_1",
            Display = "Harvest 100 Witch\'s Broom",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 100,
            Arguments = { "Witch\'s Broom", "Halloween Witch\'s Broom" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Medium_2",
            Display = "Harvest 120 Webberry",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 120,
            Arguments = { "Webberry", "Halloween Webberry" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Medium_3",
            Display = "Harvest 140 Blood Kiwi",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 140,
            Arguments = { "Blood Kiwi", "Halloween Blood Kiwi" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Medium_4",
            Display = "Harvest 160 Fang Root",
            Type = "Harvest",
            AnyArgumentsMatch = true,
            Target = 160,
            Arguments = { "Fang Root", "Halloween Fang Root" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Obtain_Pet_Medium_1",
            Display = "Obtain a Skull Snail",
            Type = "ObtainPet",
            AnyArgumentsMatch = true,
            Target = 1,
            Arguments = { "Skull Snail", "Ghostly Skull Snail" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween2026_Fill_Cauldron_Hard",
            Display = "Fill the Cauldron 60 times",
            Type = "H2026_FillCauldron",
            Target = 60,
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Get_Treats_Hard",
            Display = "Get Treats from Scream-ven 25 times",
            Type = "H2026_GetTreats",
            Target = 25,
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Earn_CandyCorn_Hard",
            Display = "Earn 1000 Candy Corn",
            Type = "EarnSpecialCurrency",
            AnyArgumentsMatch = true,
            Target = 1000,
            Arguments = { "CandyCorn" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Feed_Black_Cat_Hard",
            Display = "Feed the Black Cat 30 times",
            Type = "H2026_FeedBlackCat",
            Target = 30,
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Hatch_Eggs_Hard",
            Display = "Hatch 30 Haunted Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Haunted Egg", "Premium Haunted Egg", "Ghostly Premium Haunted Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Harvest_Plant_Hard_1",
            Display = "Harvest 50 Haunted Hallow",
            Type = "Harvest",
            Target = 50,
            AnyArgumentsMatch = true,
            Arguments = { "Haunted Hallow", "Halloween Haunted Hallow" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Obtain_Pet_Hard_1",
            Display = "Obtain a Lantern Wisp",
            Type = "ObtainPet",
            AnyArgumentsMatch = true,
            Target = 1,
            Arguments = { "Lantern Wisp", "Ghostly Lantern Wisp" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Obtain_Pet_Hard_2",
            Display = "Obtain a Eyeball Monster",
            Type = "ObtainPet",
            AnyArgumentsMatch = true,
            Target = 1,
            Arguments = { "Eyeball Monster" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween2026_Obtain_Pet_Hard_3",
            Display = "Obtain a Haunted Knight",
            Type = "ObtainPet",
            AnyArgumentsMatch = true,
            Target = 1,
            Arguments = { "Haunted Knight", "Ghostly Haunted Knight" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        }
    }
};