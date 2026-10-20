-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "CANDYCANE",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Snow Globe",
            Quantity = 1
        }, {
            Type = "Seed Pack",
            Value = "Santa\'s Surprise Present",
            Quantity = 5
        }, {
            Type = "Crate",
            Value = "Christmas Crate",
            Quantity = 5
        } },
    Quests = {
        {
            Id = "Christmas_Event_Harvest_10_Ornamented_Plants",
            Display = "Harvest 10 Ornamented Mutated Plants",
            Type = "HarvestMutation",
            Target = 10,
            Arguments = { "Ornamented" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Christmas_Event_Harvest_25_Arctic_Plants",
            Display = "Harvest 25 Arctic Mutated Plants",
            Type = "HarvestMutation",
            Target = 25,
            Arguments = { "Arctic" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Harvest_50_Snowy_Plants",
            Display = "Harvest 50 Snowy Mutated Plants",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Snowy" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Christmas_Event_Plant_25_Cookie_Stack",
            Display = "Plant 25 Cookie Stack",
            Type = "Plant",
            Target = 25,
            Arguments = { "Cookie Stack" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Christmas_Event_Plant_20_Poinsettia",
            Display = "Plant 20 Poinsettia",
            Type = "Plant",
            Target = 20,
            Arguments = { "Poinsettia" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Christmas_Event_Plant_15_Antlerbloom",
            Display = "Plant 15 Antlerbloom",
            Type = "Plant",
            Target = 15,
            Arguments = { "Antlerbloom" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Plant_7_Holly_Berry",
            Display = "Plant 7 Holly Berry",
            Type = "Plant",
            Target = 7,
            Arguments = { "Holly Berry" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Christmas_Event_Plant_5_Gift_Berry",
            Display = "Gift 1 Gift Berry",
            Type = "Gift",
            Target = 1,
            Arguments = { "Gift Berry" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Christmas_Event_Harvest_10_Frosty_Bite",
            Display = "Harvest 10 Frosty Bite",
            Type = "Harvest",
            Target = 10,
            Arguments = { "Frosty Bite" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Harvest_10_Cryo_Rose",
            Display = "Harvest 10 Cryo Rose",
            Type = "Harvest",
            Target = 10,
            Arguments = { "Cryo Rose" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Harvest_10_Bush_Flake",
            Display = "Harvest 10 Bush Flake",
            Type = "Harvest",
            Target = 10,
            Arguments = { "Bush Flake" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Harvest_10_Rosemary",
            Display = "Harvest 10 Rosemary",
            Type = "Harvest",
            Target = 10,
            Arguments = { "Rosemary" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Harvest_5_Cryoshard",
            Display = "Harvest 5 Cryoshard",
            Type = "Harvest",
            Target = 5,
            Arguments = { "Cryoshard" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Harvest_3_Frostwing",
            Display = "Harvest 3 Frostwing",
            Type = "Harvest",
            Target = 3,
            Arguments = { "Frostwing" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Open_10_Presents",
            Display = "Open 10 Presents",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 10,
            Arguments = { "Bad Present", "Normal Present", "Rare Present", "Christmas Present", "Santa\'s Surprise Present", "Common Gift", "Rare Gift", "Mythical Gift", "Gold Gift", "Rainbow Gift" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Christmas_Event_Open_30_Presents",
            Display = "Open 30 Presents",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 30,
            Arguments = { "Bad Present", "Normal Present", "Rare Present", "Christmas Present", "Santa\'s Surprise Present", "Common Gift", "Rare Gift", "Mythical Gift", "Gold Gift", "Rainbow Gift" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Open_60_Presents",
            Display = "Open 60 Presents",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 60,
            Arguments = { "Bad Present", "Normal Present", "Rare Present", "Christmas Present", "Santa\'s Surprise Present", "Common Gift", "Rare Gift", "Mythical Gift", "Gold Gift", "Rainbow Gift" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Christmas_Event_Gift_Rat",
            Display = "Obtain a Gift Rat",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Gift Rat" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Christmas_Event_Penguin",
            Display = "Obtain a Penguin",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Penguin" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Christmas_Event_Snow_Bunny",
            Display = "Obtain a Snow Bunny",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Snow Bunny" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Christmas_Event_French_Hen",
            Display = "Obtain a French Hen",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "French Hen" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Mistletoad",
            Display = "Obtain a Mistletoad",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Mistletoad" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Christmas_Event_Snowman_Soldier",
            Display = "Feed a Snowman Soldier",
            Type = "FeedPetWithAny",
            Target = 1,
            Arguments = { "Snowman Soldier" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Christmas_Event_Snowman_Builder",
            Display = "Feed a Snowman Builder",
            Type = "FeedPetWithAny",
            Target = 1,
            Arguments = { "Snowman Builder" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        }
    }
};