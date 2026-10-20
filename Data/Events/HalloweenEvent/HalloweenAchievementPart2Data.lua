-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "WEB",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Mausoleum",
            Quantity = 1
        }, {
            Type = "Egg",
            Value = "Spooky Egg",
            Quantity = 5
        }, {
            Type = "Seed Pack",
            Value = "Halloween Gear Box",
            Quantity = 5
        }, {
            Type = "Crate",
            Value = "Spooky Crate",
            Quantity = 3
        }, {
            Type = "Crate",
            Value = "Pumpkin Crate",
            Quantity = 3
        }, {
            Type = "Seed Pack",
            Value = "Spooky Chest",
            Quantity = 3
        } },
    Quests = {
        {
            Id = "Halloween_EventP2_Harvest_10_Blight_Plants",
            Display = "Harvest 10 Blight Mutated Plants",
            Type = "HarvestMutation",
            Target = 10,
            Arguments = { "Blight" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP2_Harvest_25_Blight_Plants",
            Display = "Harvest 25 Blight Mutated Plants",
            Type = "HarvestMutation",
            Target = 25,
            Arguments = { "Blight" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP2_Harvest_50_Blight_Plants",
            Display = "Harvest 50 Blight Mutated Plants",
            Type = "HarvestMutation",
            Target = 50,
            Arguments = { "Blight" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Halloween_EventP2_Harvest_10_Spooky_Trait_Plants",
            Display = "Harvest 10 Plants with the Spooky trait",
            Type = "HarvestTrait",
            Target = 10,
            Arguments = { "Spooky" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP2_Harvest_50_Spooky_Trait_Plants",
            Display = "Harvest 50 Plants with the Spooky trait",
            Type = "HarvestTrait",
            Target = 50,
            Arguments = { "Spooky" },
            Rewards = { {
                    Type = "XP",
                    Value = 400
                } }
        },
        {
            Id = "Halloween_EventP2_Harvest_40_Zombie_Fruit",
            Display = "Harvest 35 Zombie Fruit",
            Type = "Harvest",
            Target = 40,
            Arguments = { "Zombie Fruit" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween_EventP2_Harvest_20_Candy_Cornflower",
            Display = "Harvest 20 Candy Cornflower",
            Type = "Harvest",
            Target = 20,
            Arguments = { "Candy Cornflower" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP2_Sell_7_Wisp_Flower",
            Display = "Sell 7 Wisp Flower",
            Type = "Sell",
            Target = 7,
            Arguments = { "Wisp Flower" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Halloween_EventP2_Sell_4_Mummy\'s_Hand",
            Display = "Sell 4 Mummy\'s Hand",
            Type = "Sell",
            Target = 4,
            Arguments = { "Mummy\'s Hand" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Halloween_EventP2_Plant_20_Zombie_Fruit",
            Display = "Plant 20 Zombie Fruit",
            Type = "Plant",
            Target = 20,
            Arguments = { "Zombie Fruit" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween_EventP2_Plant_15_Candy_Cornflower",
            Display = "Plant 15 Candy Cornflower",
            Type = "Plant",
            Target = 15,
            Arguments = { "Candy Cornflower" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP2_Plant_10_Wisp_Flower",
            Display = "Plant 10 Wisp Flower",
            Type = "Plant",
            Target = 10,
            Arguments = { "Wisp Flower" },
            Rewards = { {
                    Type = "XP",
                    Value = 250
                } }
        },
        {
            Id = "Halloween_EventP2_Plant_5_Mummy\'s_Hand",
            Display = "Plant 5 Mummy\'s Hand",
            Type = "Plant",
            Target = 5,
            Arguments = { "Mummy\'s Hand" },
            Rewards = { {
                    Type = "XP",
                    Value = 300
                } }
        },
        {
            Id = "Halloween_EventP2_A_Crow",
            Display = "Obtain a Crow",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Crow" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 50
                } }
        },
        {
            Id = "Halloween_EventP2_A_Goat",
            Display = "Obtain a Goat",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Goat" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 75
                } }
        },
        {
            Id = "Halloween_EventP2_A_Goblin",
            Display = "Obtain a Goblin",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Goblin" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP2_A_Dark_Spriggan",
            Display = "Obtain an Dark Spriggan",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Dark Spriggan" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Halloween_EventP2_A_Hex_Serpent",
            Display = "Obtain a Hex Serpent",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Hex Serpent" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Halloween_EventP2_Dig_Up_Any_Reward_1",
            Display = "Dig up 1 treasure from the Gravedigger Event!",
            Type = "HP2_DigUpAnyReward",
            Target = 1,
            Arguments = {},
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 25
                } }
        },
        {
            Id = "Halloween_EventP2_Dig_Up_Any_Reward_10",
            Display = "Dig up 10 treasure from the Gravedigger Event!",
            Type = "HP2_DigUpAnyReward",
            Target = 10,
            Arguments = {},
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Halloween_EventP2_Dig_Up_Any_Reward_50",
            Display = "Dig up 50 treasure from the Gravedigger Event!",
            Type = "HP2_DigUpAnyReward",
            Target = 50,
            Arguments = {},
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        }
    }
};