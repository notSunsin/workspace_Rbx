-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    Rewards = { {
            Type = "Fences",
            Value = "BEANSTALK",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Beanstalk Statue",
            Quantity = 1
        }, {
            Type = "Egg",
            Value = "Beanpod Egg",
            Quantity = 3
        }, {
            Type = "Seed Pack",
            Value = "Beanpod Chest",
            Quantity = 3
        } },
    Quests = {
        {
            Id = "Beanstalk_Harvest_Nimbush",
            Display = "Harvest 50 Nimbush",
            Type = "Harvest",
            Target = 50,
            Arguments = { "Nimbush" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Beanstalk_Harvest_Twist_Berry",
            Display = "Harvest 50 Twist Berry",
            Type = "Harvest",
            Target = 50,
            Arguments = { "Twist Berry" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Beanstalk_Open_Beanpod_Chest",
            Display = "Open 10 Beanpod Chests",
            Type = "OpenSeedPackOfType",
            AnyArgumentsMatch = true,
            Target = 10,
            Arguments = { "Beanpod Chest", "Exotic Beanpod Chest", "Rainbow Exotic Beanpod Chest" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Beanstalk_Hatch_Beanpod_Egg",
            Display = "Hatch 10 Beanpod Eggs",
            Type = "HatchEgg",
            AnyArgumentsMatch = true,
            Target = 10,
            Arguments = { "Beanpod Egg", "Premium Beanpod Egg", "Rainbow Premium Beanpod Egg" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Beanstalk_Sell_Fableflower",
            Display = "Sell 100 Fableflowers",
            Type = "Sell",
            Target = 100,
            Arguments = { "Fableflower" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Beanstalk_Craft_Beanpod_Crate",
            Display = "Craft 5 Beanpod Crates",
            Type = "Craft",
            Target = 5,
            Arguments = { "Beanpod Crate" },
            Rewards = { {
                    Type = "XP",
                    Value = 100
                } }
        },
        {
            Id = "Beanstalk_Harvest_Lilypad_Cluster",
            Display = "Harvest 10 Lilypad Clusters",
            Type = "Harvest",
            Target = 10,
            Arguments = { "Lilypad Cluster" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Beanstalk_Harvest_Aurum_Spire",
            Display = "Harvest 5 Aurum Spire",
            Type = "Harvest",
            Target = 5,
            Arguments = { "Aurum Spire" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Beanstalk_Feed_Cloud_Sprite",
            Display = "Feed a Cloud Sprite a Nimbush",
            Type = "FeedPet",
            Target = 1,
            Arguments = { "Cloud Sprite", "Nimbush" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Beanstalk_Hatch_Cloud_Hound",
            Display = "Obtain a Cloud Hound",
            Type = "ObtainPet",
            Target = 1,
            Arguments = { "Cloud Hound" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Beanstalk_Cooking_Twist_Berry",
            Display = "Use 10 Twist Berries in Cooking",
            Type = "Cooking",
            Target = 10,
            Arguments = { "Twist Berry" },
            Rewards = { {
                    Type = "XP",
                    Value = 150
                } }
        },
        {
            Id = "Beanstalk_Harvest_Frozen_Harpvine",
            Display = "Harvest 10 Frozen Harpvines",
            Type = "HarvestCropWithMutation",
            Target = 10,
            Arguments = { "Harpvine", "Frozen" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Beanstalk_Sell_Wool",
            Display = "Sell 25 Wool",
            Type = "Sell",
            Target = 25,
            Arguments = { "Wool" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Beanstalk_Sell_Elder_Beanstalk",
            Display = "Sell 3 Elder Beanstalk",
            Type = "Sell",
            Target = 3,
            Arguments = { "Elder Beanstalk" },
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        },
        {
            Id = "Beanstalk_Mutate",
            Display = "Obtain Golden Mutation on a Goose",
            Type = "MutatePet",
            Target = 1,
            Arguments = { "Goose", "Golden" },
            ActivePet = {},
            Rewards = { {
                    Type = "XP",
                    Value = 200
                } }
        }
    }
};