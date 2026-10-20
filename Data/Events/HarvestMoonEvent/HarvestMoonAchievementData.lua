-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "HARVESTMOON",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Harvest Moon Statue",
            Quantity = 1
        }, {
            Type = "Egg",
            Value = "Moon Egg",
            Quantity = 5
        }, {
            Type = "Crate",
            Value = "Harvest Crate",
            Quantity = 3
        } },
    Quests = {
        {
            Id = "Harvest_Moon_Mutate_Pet_Bountiful",
            Display = "Obtain Bountiful mutation on a pet",
            Type = "MutateAnyPet",
            Target = 1,
            Arguments = { "Bountiful" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Mutate_Pet_Threshing",
            Display = "Obtain Threshing mutation on a pet",
            Type = "MutateAnyPet",
            Target = 1,
            Arguments = { "Threshing" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Satify_Wise_Owl",
            Display = "Submit 100 plants to the Wise Owl",
            Type = "SatisfyCraving",
            Target = 100,
            Arguments = { "Wise Owl" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Harvest_Moonbeam_Plants",
            Display = "Harvest 100 Moonbeam Plants",
            Type = "HarvestMutation",
            Target = 100,
            Arguments = { "Moonbeam" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Harvest_Lunar_Lily",
            Display = "Harvest 50 Lunar Lilies",
            Type = "Harvest",
            Target = 50,
            Arguments = { "Lunar Lily" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Harvest_Starry_Strawberry",
            Display = "Harvest 30 Starry Strawberries",
            Type = "Harvest",
            Target = 30,
            Arguments = { "Starry Strawberry" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Sell_Fennel",
            Display = "Sell 15 Fennel",
            Type = "Sell",
            Target = 15,
            Arguments = { "Fennel" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Mutated_Crescent_Reed",
            Display = "Harvest 10 Mutated Crescent Reeds",
            Type = "HarvestCropWithAnyMutation",
            Target = 10,
            Arguments = { "Crescent Reed" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Earn_Moon_Coins",
            Display = "Earn 1500 Moon Coins",
            Type = "EarnSpecialCurrency",
            Target = 1500,
            Arguments = { "MoonCoins" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Harvest_Moon_Mutate_Pet_Lunarbound",
            Display = "Obtain Lunarbound mutation on a pet",
            Type = "MutateAnyPet",
            Target = 1,
            Arguments = { "Lunarbound" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Mutate_Pet_Starry",
            Display = "Obtain Starry mutation on a pet",
            Type = "MutateAnyPet",
            Target = 1,
            Arguments = { "Starry" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Hatch_Moon_Eggs",
            Display = "Hatch 10 Moon Eggs",
            Type = "HatchEgg",
            AnyArgumentsMatch = true,
            Target = 10,
            Arguments = { "Moon Egg", "Premium Moon Egg", "Starry Premium Moon Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Open_Moon_Chests",
            Display = "Open 10 Moon Chests",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 10,
            Arguments = { "Moon Chest", "Exotic Moon Chest", "Rainbow Exotic Moon Chest" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Obtain_Harvest_Golem",
            Display = "Obtain a Harvest Golem",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Harvest Golem" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Harvest_Wheatcap",
            Display = "Harvest 25 Wheatcap",
            Type = "Harvest",
            Target = 25,
            Arguments = { "Wheatcap" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Harvest_Harvest_Melon",
            Display = "Sell 10 Harvest Melon",
            Type = "Sell",
            Target = 10,
            Arguments = { "Harvest Melon" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Harvest_Moonbeam_Astral_Grape",
            Display = "Harvest a Moonbeam mutated Astral Grape",
            Type = "HarvestCropWithMutation",
            Target = 1,
            Arguments = { "Astral Grape", "Moonbeam" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Obtain_Vampire_Squid",
            Display = "Obtain a Vampire Squid",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Vampire Squid" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Gift_Moongrain_Meadow",
            Display = "Gift a Moongrain Meadow",
            Type = "Gift",
            Target = 1,
            Arguments = { "Moongrain Meadow" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Harvest_Moon_Summon_Harvest_Moon",
            Display = "Summon the Harvest Moon 15 times",
            Type = "SummonHarvestMoon",
            Target = 15,
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Harvest_Moon_Mutate_Lunar_Moth_Lunarbound",
            Display = "Obtain Lunarbound mutation on a Lunar Moth",
            Type = "MutatePet",
            Target = 1,
            Arguments = { "Lunar Moth", "Lunarbound" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Harvest_Moon_Mutate_Wheat_Crow_Threshing",
            Display = "Obtain Threshing mutation on a Wheat Crow",
            Type = "MutatePet",
            Target = 1,
            Arguments = { "Wheat Crow", "Threshing" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Harvest_Moon_Obtain_Night_Horse",
            Display = "Obtain a Night Horse",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Night Horse" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        }
    }
};