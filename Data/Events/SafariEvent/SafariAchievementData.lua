-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "SAFARISANCTUARY",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Safari Shipping Container",
            Quantity = 1
        }, {
            Type = "Egg",
            Value = "Safari Egg",
            Quantity = 5
        }, {
            Type = "Seed Pack",
            Value = "Safari Seed Pack",
            Quantity = 5
        }, {
            Type = "Crate",
            Value = "Safari Crate",
            Quantity = 3
        }, {
            Type = "Crate",
            Value = "Savannah Crate",
            Quantity = 3
        } },
    Quests = {
        {
            Id = "Safari_Harvest_Harvest_10_Mirage_Plants",
            Display = "Harvest 10 Mirage Mutated Plants",
            Type = "HarvestMutation",
            Target = 10,
            Arguments = { "Mirage" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Safari_Harvest_Harvest_25_Arid_Plants",
            Display = "Harvest 25 Arid Mutated Plants",
            Type = "HarvestMutation",
            Target = 25,
            Arguments = { "Arid" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Harvest_50_Lush_Plants",
            Display = "Harvest 50 Lush Mutated Plants",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Lush" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Safari_Harvest_Plant_25_Orange_Delight",
            Display = "Plant 25 Orange Delight",
            Type = "Plant",
            Target = 25,
            Arguments = { "Orange Delight" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Safari_Harvest_Plant_10_Protea",
            Display = "Plant 10 Protea",
            Type = "Plant",
            Target = 10,
            Arguments = { "Protea" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Plant_20_Daisy",
            Display = "Plant 20 Daisy",
            Type = "Plant",
            Target = 20,
            Arguments = { "Daisy" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Safari_Harvest_Plant_7_Bamboo_Tree",
            Display = "Plant 7 Bamboo Tree",
            Type = "Plant",
            Target = 7,
            Arguments = { "Bamboo Tree" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Plant_5_Amberfruit_Shrub",
            Display = "Plant 5 Amberfruit Shrub",
            Type = "Plant",
            Target = 5,
            Arguments = { "Amberfruit Shrub" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Safari_Harvest_Harvest_10_Baobab",
            Display = "Harvest 10 Baobab",
            Type = "Harvest",
            Target = 10,
            Arguments = { "Baobab" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Safari_Harvest_Harvest_15_Castor_Bean",
            Display = "Harvest 15 Castor Bean",
            Type = "Harvest",
            Target = 15,
            Arguments = { "Castor Bean" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Safari_Harvest_Harvest_5_Java_Banana",
            Display = "Harvest 5 Java Banana",
            Type = "Harvest",
            Target = 5,
            Arguments = { "Java Banana" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Open_10_Safari_Seed_Pack",
            Display = "Open 10 Safari Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 10,
            Arguments = { "Safari Seed Pack", "Exotic Safari Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Safari_Harvest_Open_30_Safari_Seed_Pack",
            Display = "Open 30 Safari Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Safari Seed Pack", "Exotic Safari Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Open_60_Safari_Seed_Pack",
            Display = "Open 60 Safari Seed Packs",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 60,
            Arguments = { "Safari Seed Pack", "Exotic Safari Seed Pack" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Safari_Harvest_Hatch_5_Safari_Eggs",
            Display = "Hatch 5 Safari Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 5,
            Arguments = { "Safari Egg", "Premium Safari Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Safari_Harvest_Hatch_15_Safari_Eggs",
            Display = "Hatch 15 Safari Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 15,
            Arguments = { "Safari Egg", "Premium Safari Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Hatch_30_Safari_Eggs",
            Display = "Hatch 30 Safari Eggs",
            Type = "HatchEggs",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Safari Egg", "Premium Safari Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Safari_Harvest_Oxpecker",
            Display = "Obtain an Oxpecker",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Oxpecker" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Safari_Harvest_Zebra",
            Display = "Obtain a Zebra",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Zebra" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Safari_Harvest_Giraffe",
            Display = "Obtain a Giraffe",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Giraffe" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Safari_Harvest_Rhino",
            Display = "Obtain a Rhino",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Rhino" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Safari_Harvest_Gecko",
            Display = "Obtain a Gecko",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Gecko" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Safari_Harvest_Hyena",
            Display = "Obtain 2 Hyena",
            Type = "ObtainPet",
            Target = 2,
            Arguments = { "Hyena" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Safari_Harvest_Cape_Buffalo",
            Display = "Obtain a Cape Buffalo",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Cape Buffalo" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        }
    }
};