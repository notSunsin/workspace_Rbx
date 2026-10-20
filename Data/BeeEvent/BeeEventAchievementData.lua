-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "BIZZYBEE_2026",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Bee Event 2026 Statue",
            Quantity = 1
        }, {
            Type = "Seed Pack",
            Value = "Hive Seed Pack",
            Quantity = 5
        }, {
            Type = "Crate",
            Value = "Hive Crate",
            Quantity = 5
        } },
    Quests = {
        {
            Id = "Honey_2026_Harvest_Honey_Plants",
            Display = "Harvest 500 Honey Plants",
            Type = "HarvestCropWithTrait",
            AnyArgumentsMatch = true,
            Target = 500,
            Arguments = { "Honey" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Honey_2026_Harvest_Pollinated_Poor",
            Display = "Harvest 200 Poor Pollinated Plants",
            Type = "HarvestMutation",
            AnyArgumentsMatch = true,
            Target = 200,
            Arguments = { "Pollinated_Poor" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Harvest_Pollinated_Fair",
            Display = "Harvest 150 Fair Pollinated Plants",
            Type = "HarvestMutation",
            AnyArgumentsMatch = true,
            Target = 150,
            Arguments = { "Pollinated_Fair" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Harvest_Pollinated_Good",
            Display = "Harvest 100 Good Pollinated Plants",
            Type = "HarvestMutation",
            AnyArgumentsMatch = true,
            Target = 100,
            Arguments = { "Pollinated_Good" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Harvest_Pollinated_Godly",
            Display = "Harvest 50 Godly Pollinated Plants",
            Type = "HarvestMutation",
            AnyArgumentsMatch = true,
            Target = 50,
            Arguments = { "Pollinated_Godly" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Compress_Honey",
            Display = "Compress 1000kgs worth of Plants",
            Type = "CompressHoney",
            Target = 1000,
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Hatch_Bee_Eggs",
            Display = "Hatch 300 Bee Eggs",
            Type = "HatchBeeEggAny",
            Target = 300,
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Hatch_Mythical_Bee_Eggs",
            Display = "Hatch 10 Mythical Bee Eggs",
            Type = "HatchBeeEgg",
            Target = 10,
            Arguments = { "Mythical Bee Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Obtain_Baby_Bee",
            Display = "Obtain a Baby Bee",
            Type = "ObtainBee",
            Target = 1,
            Arguments = { "Baby Bee" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Obtain_Panic_Bee",
            Display = "Obtain a Panic Bee",
            Type = "ObtainBee",
            Target = 1,
            Arguments = { "Panic Bee" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Obtain_Illusion_Bee",
            Display = "Obtain an Illusion Bee",
            Type = "ObtainBee",
            Target = 1,
            Arguments = { "Illusion Bee" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Earn_Honey_Coins",
            Display = "Earn 1,000,000 Honey Coins",
            Type = "EarnSpecialCurrency",
            Target = 1000000,
            Arguments = { "HoneyCoins" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Open_Honey_Hive_Seed_Pack",
            Display = "Open 15 Honey Hive Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Honey Hive Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Plant_Birds_of_Paradise",
            Display = "Plant 3 Birds of Paradise",
            Type = "Plant",
            AnyArgumentsMatch = true,
            Target = 3,
            Arguments = { "Honey Birds of Paradise", "Birds of Paradise" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Plant_Hive_Petal",
            Display = "Plant a Hive Petal",
            Type = "Plant",
            AnyArgumentsMatch = true,
            Target = 1,
            Arguments = { "Honey Hive Petal", "Hive Petal" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Incubate_Honey_Seeds",
            Display = "Incubate 50 Honey Seeds",
            Type = "IncubateHoneySeedAny",
            Target = 50,
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Incubate_Honey_Pollenvine",
            Display = "Incubate 1 Honey Pollenvine",
            Type = "IncubateHoneySeed",
            Target = 1,
            Arguments = { "Honey Pollenvine" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Hatch_Hive_Egg",
            Display = "Hatch 50 Hive Eggs (of any type)",
            Type = "HatchEgg",
            AnyArgumentsMatch = true,
            Target = 50,
            Arguments = { "Hive Egg", "Premium Hive Egg", "Rainbow Premium Hive Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Obtain_Elemental_Bee",
            Display = "Obtain an Elemental Bee",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Elemental Bee" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Convert_To_Jelly",
            Display = "Convert 5 Seeds to Jelly",
            Type = "ConvertToJellyAny",
            Target = 5,
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Convert_Plant_To_Jelly",
            Display = "Convert Coneflower to Jelly",
            Type = "ConvertToJelly",
            Target = 1,
            Arguments = { "Coneflower" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Honey_2026_Earn_Royal_Jelly",
            Display = "Earn 1000 Royal Jelly",
            Type = "EarnSpecialCurrency",
            Target = 1000,
            Arguments = { "RoyalJelly" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        }
    }
};