-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "FAIRY",
            Quantity = 1
        }, {
            Type = "Seed Pack",
            Value = "Enchanted Chest",
            Quantity = 5
        }, {
            Type = "Gear",
            Value = "Pet Shard Luminous",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Wish Fountain",
            Quantity = 1
        } },
    Quests = {
        {
            Id = "Fairy_Event_Harvest_10_Glimmering_Plants",
            Display = "Harvest 10 Glimmering Plants",
            Type = "HarvestMutation",
            Target = 10,
            Arguments = { "Glimmering" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fairy_Event_Harvest_50_Glimmering_Plants",
            Display = "Harvest 50 Glimmering Plants",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Glimmering" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fairy_Event_Harvest_100_Glimmering_Plants",
            Display = "Harvest 100 Glimmering Plants",
            Type = "HarvestMutation",
            Target = 100,
            Arguments = { "Glimmering" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                }, {
                    Type = "Seed Pack",
                    Value = "Enchanted Seed Pack",
                    Quantity = 1
                } }
        },
        {
            Id = "Fairy_Event_Craft_10_Glimmering_Spray",
            Display = "Craft 10 Glimmering Spray",
            Type = "Craft",
            Target = 10,
            Arguments = { "Mutation Spray Glimmering" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fairy_Event_Craft_15_Fairy_Net",
            Display = "Craft 15 Fairy Net",
            Type = "Craft",
            Target = 15,
            Arguments = { "Fairy Net" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Fairy_Event_Craft_1_Fairy_Summoner",
            Display = "Craft 1 Fairy Summoner",
            Type = "Craft",
            Target = 1,
            Arguments = { "Fairy Summoner" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fairy_Event_Hatch_5_Enchanted_Eggs",
            Display = "Hatch 5 Enchanted Eggs",
            Type = "HatchEgg",
            Target = 5,
            Arguments = { "Enchanted Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fairy_Event_Hatch_15_Enchanted_Eggs",
            Display = "Hatch 15 Enchanted Eggs",
            Type = "HatchEgg",
            Target = 15,
            Arguments = { "Enchanted Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fairy_Event_Hatch_30_Enchanted_Eggs",
            Display = "Hatch 30 Enchanted Eggs",
            Type = "HatchEgg",
            Target = 30,
            Arguments = { "Enchanted Egg" },
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
            Id = "Fairy_Event_Hatch_1_2kg_Imp",
            Display = "Hatch an Imp at least 1.2kg",
            Type = "HatchPetGreaterThanSize",
            Target = 1,
            Size = 1.2,
            Arguments = { "Imp" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fairy_Event_Hatch_1kg_Pixie",
            Display = "Hatch a Pixie less than 1kg",
            Type = "HatchPetLessThanSize",
            Target = 1,
            Size = 1,
            Arguments = { "Pixie" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Fairy_Event_A_Ladybug",
            Display = "Obtain a Ladybug",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Ladybug" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Fairy_Event_A_Pixie",
            Display = "Obtain a Pixie",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Pixie" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Fairy_Event_A_Imp",
            Display = "Obtain an Imp",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Imp" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 120
                } }
        },
        {
            Id = "Fairy_Event_A_Glimmering_Sprite",
            Display = "Obtain a Glimmering Sprite",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Glimmering Sprite" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 500
                } }
        },
        {
            Id = "Fairy_Event_A_Cockatrice",
            Display = "Obtain a Cockatrice",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Cockatrice" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 1000
                } }
        }
    }
};