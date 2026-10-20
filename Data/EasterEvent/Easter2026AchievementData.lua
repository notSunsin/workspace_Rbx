-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "EASTER_2026",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Easter 2026 Statue",
            Quantity = 1
        }, {
            Type = "Seed Pack",
            Value = "Easter Seed Pack",
            Quantity = 5
        }, {
            Type = "Egg",
            Value = "Golden Egg",
            Quantity = 3
        } },
    Quests = {
        {
            Id = "Easter_2026_Harvest_100_Easter_Candy_Carrot",
            Display = "Harvest 100 Easter Candy Carrots",
            Type = "Harvest",
            Target = 100,
            Arguments = { "Easter Candy Carrot" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Easter_2026_Harvest_75_Easter_Chocolate_Berry",
            Display = "Harvest 75 Easter Chocolate Berries",
            Type = "Harvest",
            Target = 75,
            Arguments = { "Easter Chocolate Berry" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Easter_2026_Harvest_45_Easter_Gumball",
            Display = "Harvest 45 Easter Gumball",
            Type = "Harvest",
            Target = 45,
            Arguments = { "Easter Gumball" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Easter_2026_Harvest_20_Easter_Liquorice",
            Display = "Harvest 20 Easter Liquorice",
            Type = "Harvest",
            Target = 20,
            Arguments = { "Easter Liquorice" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Easter_2026_Plant_10_Easter_Sugar_Melon",
            Display = "Plant 10 Easter Sugar Melons",
            Type = "Plant",
            Target = 10,
            Arguments = { "Easter Sugar Melon" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Easter_2026_Plant_7_Easter_Chocolate_Coconut",
            Display = "Plant 7 Easter Chocolate Coconuts",
            Type = "Plant",
            Target = 7,
            Arguments = { "Easter Chocolate Coconut" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Easter_2026_Plant_4_Easter_Gummy_Cactus",
            Display = "Plant 4 Easter Gummy Cactus",
            Type = "Plant",
            Target = 4,
            Arguments = { "Easter Gummy Cactus" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Easter_2026_Plant_Sour_Lemon",
            Display = "Plant 1 Sour Lemon",
            Type = "Plant",
            Target = 1,
            Arguments = { "Sour Lemon" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Easter_2026_Harvest_25_Candy",
            Display = "Harvest 25 Candy Trait Plants",
            Type = "HarvestTrait",
            Target = 25,
            Arguments = { "Candy" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Easter_2026_Harvest_50_Choc_Mutation",
            Display = "Harvest 50 Plants with the Choc mutation",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Choc" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Easter_2026_Gift_1_Eggfruit",
            Display = "Sell 1 Eggfruit",
            Type = "Sell",
            Target = 1,
            Arguments = { "Eggfruit" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Easter_2026_Obtain_Beaver",
            Display = "Obtain a Beaver",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Beaver" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Easter_2026_Obtain_Gummy_Bear",
            Display = "Obtain a Gummy Bear",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Gummy Bear" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Easter_2026_Obtain_Hootsie_Roll",
            Display = "Obtain a Hootsie Roll",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Hootsie Roll" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Easter_2026_Hatch_12_Springtide_Egg",
            Display = "Hatch 12 Springtide Eggs",
            Type = "HatchEgg",
            Target = 12,
            Arguments = { "Springtide Egg" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Easter_2026_Hatch_20_Golden_Egg",
            Display = "Hatch 20 Golden Eggs",
            Type = "HatchEgg",
            Target = 20,
            Arguments = { "Golden Egg" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Easter_2026_Open_15_Easter_Seed_Pack",
            Display = "Open 15 Easter Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Easter Seed Pack", "Exotic Easter Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        }
    }
};