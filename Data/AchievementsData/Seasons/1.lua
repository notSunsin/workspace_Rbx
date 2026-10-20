-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    SeasonName = "Core Plants",
    SeasonDescription = "Achievements for seeds in the seed shop",
    SeasonAwardSubHeading = "Complete all achievements to unlock 100 backpack slots",
    StartTime = game.GameId == 7500518143 and 0 or 1755352800,
    Rewards = { {
            Type = "Cosmetic",
            Value = "Statue Of Achievement",
            Quantity = 1
        } },
    Sets = {
        Common = {
            Rewards = { {
                    Type = "Cosmetic",
                    Value = "Cooking Kit",
                    Quantity = 1
                }, {
                    Type = "Seed Pack",
                    Value = "Silver Common Seed Pack",
                    Quantity = 5
                } },
            Quests = { {
                    Id = "Common_Shovel_100_Plants",
                    Display = "Shovel 100 Plants ",
                    Type = "ShovelAny",
                    Target = 100,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                }, {
                    Id = "Common_Harvest_200_Carrots",
                    Display = "Harvest 200 Carrots",
                    Type = "Harvest",
                    Target = 200,
                    Arguments = { "Carrot" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                }, {
                    Id = "Common_Gift_1_Carrots",
                    Display = "Gift 1 Carrot",
                    Type = "Gift",
                    Target = 1,
                    Arguments = { "Carrot" },
                    Rewards = { {
                            Type = "XP",
                            Value = 50
                        } }
                }, {
                    Id = "Common_Sell_500_Strawberries",
                    Display = "Sell 500 Strawberries",
                    Type = "Sell",
                    Target = 500,
                    Arguments = { "Strawberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                }, {
                    Id = "Common_Gift_5_Strawberry",
                    Display = "Gift 5 Strawberries",
                    Type = "Gift",
                    Target = 5,
                    Arguments = { "Strawberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                } }
        },
        Uncommon = {
            Rewards = { {
                    Type = "Seed Pack",
                    Value = "Silver Uncommon Seed Pack",
                    Quantity = 5
                } },
            Quests = {
                {
                    Id = "Common_Shovel_300_Plants",
                    Display = "Shovel 300 Plants ",
                    Type = "ShovelAny",
                    Target = 300,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 300
                        } }
                },
                {
                    Id = "Uncommon_Harvest_250_Mutations",
                    Display = "Harvest 250 Mutated Crops",
                    Type = "HarvestAnyMutation",
                    Target = 250,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 300
                        } }
                },
                {
                    Id = "Uncommon_Harvest_150_Any_Variant",
                    Display = "Harvest 150 Silver, Gold or Rainbow Crops",
                    Type = "HarvestAnyVariant",
                    Target = 150,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Harvest_1000_Blueberries",
                    Display = "Harvest 1000 Blueberries",
                    Type = "Harvest",
                    Target = 1000,
                    Arguments = { "Blueberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Harvest_300_Mutated_Blueberries",
                    Display = "Harvest 300 Mutated Blueberries",
                    Type = "HarvestCropWithAnyMutation",
                    Target = 300,
                    Arguments = { "Blueberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Cooking_100_Blueberries",
                    Display = "Use 100 Blueberries in Cooking",
                    Type = "Cooking",
                    Target = 100,
                    Arguments = { "Blueberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Feed_150_Blueberry_To_Pet",
                    Display = "Feed 150 Blueberry to Pets",
                    Type = "FeedAnyPet",
                    Target = 150,
                    Arguments = { "Blueberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Plant_200_Orange_Tulip",
                    Display = "Harvest 10 Gold Blueberry",
                    Type = "HarvestCropWithVariant",
                    Target = 10,
                    Arguments = { "Blueberry", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 200
                        } }
                },
                {
                    Id = "Uncommon_Gift_100_Orange_Tulip",
                    Display = "Gift any 100 Crop",
                    Type = "GiftAny",
                    Target = 100,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                }
            }
        },
        Rare = {
            Rewards = { {
                    Type = "Cosmetic",
                    Value = "Cooking Kit",
                    Quantity = 1
                }, {
                    Type = "Seed Pack",
                    Value = "Silver Rare Seed Pack",
                    Quantity = 5
                } },
            Quests = {
                {
                    Id = "Rare_Harvest_500_Mutations",
                    Display = "Harvest 500 Mutated Crops",
                    Type = "HarvestAnyMutation",
                    Target = 500,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Rare_Harvest_200_Wet_Crops",
                    Display = "Harvest 200 Wet Crops",
                    Type = "HarvestMutation",
                    Target = 200,
                    Arguments = { "Wet" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Rare_Harvest_500_Corn",
                    Display = "Harvest 500 Corn",
                    Type = "Harvest",
                    Target = 500,
                    Arguments = { "Corn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 300
                        } }
                },
                {
                    Id = "Rare_Harvest_100_Mutated_Any_Corn",
                    Display = "Harvest 100 Mutated Corn",
                    Type = "HarvestCropWithAnyMutation",
                    Target = 100,
                    Arguments = { "Corn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                },
                {
                    Id = "Rare_Harvest_30_Silver_Corn",
                    Display = "Harvest 30 Silver, Gold or Rainbow Corn",
                    Type = "HarvestCropAnyVariant",
                    Target = 30,
                    Arguments = { "Corn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                },
                {
                    Id = "Rare_Harvest_15_Gold_Corn",
                    Display = "Harvest 15 Gold Corn",
                    Type = "HarvestCropWithVariant",
                    Target = 15,
                    Arguments = { "Corn", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Harvest_1_Rainbow_Corn",
                    Display = "Harvest 1 Rainbow Corn",
                    Type = "HarvestCropWithVariant",
                    Target = 1,
                    Arguments = { "Corn", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Cook_100_Corn",
                    Display = "Use 100 Corn in Cooking",
                    Type = "Cooking",
                    Target = 100,
                    Arguments = { "Corn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                },
                {
                    Id = "Rare_Harvest_2000_Tomato",
                    Display = "Harvest 2000 Tomatoes",
                    Type = "Harvest",
                    Target = 2000,
                    Arguments = { "Tomato" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Harvest_1Kg_Tomato",
                    Display = "Harvest 10 1kg Tomatoes",
                    Type = "HarvestGreaterThanSize",
                    Target = 10,
                    Size = 1,
                    Arguments = { "Tomato" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Harvest_30_Silver_Tomato",
                    Display = "Harvest 30 Silver, Gold or Rainbow Tomatoes",
                    Type = "HarvestCropAnyVariant",
                    Target = 30,
                    Arguments = { "Tomato" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Harvest_15_Gold_Tomato",
                    Display = "Harvest 5 Gold Tomatoes",
                    Type = "HarvestCropWithVariant",
                    Target = 5,
                    Arguments = { "Tomato", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Harvest_1_Rainbow_Tomato",
                    Display = "Harvest 1 Rainbow Tomatoes",
                    Type = "HarvestCropWithVariant",
                    Target = 1,
                    Arguments = { "Tomato", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Cook_500_Tomato",
                    Display = "Use 500 Tomatoes in Cooking",
                    Type = "Cooking",
                    Target = 500,
                    Arguments = { "Tomato" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                },
                {
                    Id = "Rare_Plant_500_Daffodil",
                    Display = "Plant 500 Daffodils",
                    Type = "Plant",
                    Target = 500,
                    Arguments = { "Daffodil" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Rare_Gift_40_Daffodil",
                    Display = "Gift 40 Daffodils",
                    Type = "Gift",
                    Target = 40,
                    Arguments = { "Daffodil" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                },
                {
                    Id = "Rare_Harvest_10_Wet_Daffodil",
                    Display = "Harvest 10 Wet Daffodils",
                    Type = "HarvestCropWithMutation",
                    Target = 10,
                    Arguments = { "Daffodil", "Wet" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                }
            }
        },
        Legendary = {
            Rewards = { {
                    Type = "Seed Pack",
                    Value = "Silver Legendary Seed Pack",
                    Quantity = 5
                } },
            Quests = {
                {
                    Id = "Legendary_Harvest_60_Windstruck_Crops",
                    Display = "Harvest 60 Windstruck Crops",
                    Type = "HarvestMutation",
                    Target = 60,
                    Arguments = { "Windstruck" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Harvest_60_Chilled_Crops",
                    Display = "Harvest 60 Chilled Crops",
                    Type = "HarvestMutation",
                    Target = 60,
                    Arguments = { "Chilled" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Harvest_100_Any_Variant",
                    Display = "Harvest 100 Silver, Gold or Rainbow Crops",
                    Type = "HarvestAnyVariant",
                    Target = 100,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Harvest_500_Bamboo",
                    Display = "Harvest 500 Bamboo",
                    Type = "Harvest",
                    Target = 500,
                    Arguments = { "Bamboo" },
                    Rewards = { {
                            Type = "XP",
                            Value = 450
                        } }
                },
                {
                    Id = "Legendary_Feed_100_Bamboo_To_Pet",
                    Display = "Feed 500 Bamboo to Pets",
                    Type = "FeedAnyPet",
                    Target = 500,
                    Arguments = { "Bamboo" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Sell_300_Bamboos",
                    Display = "Sell 300 Bamboos",
                    Type = "Sell",
                    Target = 300,
                    Arguments = { "Bamboo" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Harvest_1_15kg_Bamboo",
                    Display = "Harvest 1 15kg Bamboo",
                    Type = "HarvestGreaterThanSize",
                    Target = 1,
                    Size = 15,
                    Arguments = { "Bamboo" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Harvest_100_Mutated_Bamboo",
                    Display = "Harvest 50 Mutated Bamboo",
                    Type = "HarvestCropWithAnyMutation",
                    Target = 50,
                    Arguments = { "Bamboo" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Cook_250_Apple",
                    Display = "Use 250 Apples in Cooking",
                    Type = "Cooking",
                    Target = 250,
                    Arguments = { "Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Plant_30_Apple",
                    Display = "Plant 30 Apple Trees",
                    Type = "Plant",
                    Target = 30,
                    Arguments = { "Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 450
                        } }
                },
                {
                    Id = "Legendary_Harvest_1500_Apple",
                    Display = "Harvest 1500 Apples",
                    Type = "Harvest",
                    Target = 1500,
                    Arguments = { "Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 450
                        } }
                },
                {
                    Id = "Legendary_Gift_20_Pumpkin",
                    Display = "Gift 20 Pumpkins",
                    Type = "Gift",
                    Target = 20,
                    Arguments = { "Pumpkin" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Legendary_Harvest_15_10kg_Pumpkin",
                    Display = "Harvest 15 10kg Pumpkins",
                    Type = "HarvestGreaterThanSize",
                    Target = 15,
                    Size = 10,
                    Arguments = { "Pumpkin" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Legendary_Cook_20_Pumpkin",
                    Display = "Use 20 Pumpkins in Cooking",
                    Type = "Cooking",
                    Target = 20,
                    Arguments = { "Pumpkin" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Legendary_Feed_Pets_100_Watermelon",
                    Display = "Feed 100 Watermelons to Pets",
                    Type = "FeedAnyPet",
                    Target = 100,
                    Arguments = { "Watermelon" },
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Legendary_Gift_10_Watermelon",
                    Display = "Gift 10 Watermelons",
                    Type = "Gift",
                    Target = 10,
                    Arguments = { "Watermelon" },
                    Rewards = { {
                            Type = "XP",
                            Value = 350
                        } }
                },
                {
                    Id = "Legendary_Harvest_15_Watermelon",
                    Display = "Harvest 15 9kg Watermelons",
                    Type = "HarvestGreaterThanSize",
                    Target = 15,
                    Size = 9,
                    Arguments = { "Watermelon" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                }
            }
        },
        Mythical = {
            Rewards = { {
                    Type = "Cosmetic",
                    Value = "Cooking Kit",
                    Quantity = 1
                }, {
                    Type = "Seed Pack",
                    Value = "Silver Mythical Seed Pack",
                    Quantity = 4
                } },
            Quests = {
                {
                    Id = "Mythical_Harvest_5000_Mutations",
                    Display = "Harvest 5000 Mutated Plants",
                    Type = "HarvestAnyMutation",
                    Target = 5000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Harvest_50_Shocked_Mango",
                    Display = "Harvest 50 Shocked Mangos",
                    Type = "HarvestCropWithMutation",
                    Target = 50,
                    Arguments = { "Mango", "Shocked" },
                    Rewards = { {
                            Type = "XP",
                            Value = 550
                        } }
                },
                {
                    Id = "Mythical_Shovel_850_Crops",
                    Display = "Shovel 850 Plants",
                    Type = "ShovelAny",
                    Target = 850,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 400
                        } }
                },
                {
                    Id = "Mythical_Plant_30_Coconut",
                    Display = "Plant 30 Coconut Trees",
                    Type = "Plant",
                    Target = 30,
                    Arguments = { "Coconut" },
                    Rewards = { {
                            Type = "XP",
                            Value = 550
                        } }
                },
                {
                    Id = "Mythical_Cook_60_Coconut",
                    Display = "Use 60 Coconuts in Cooking",
                    Type = "Cooking",
                    Target = 60,
                    Arguments = { "Coconut" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Harvest_1500_Coconuts",
                    Display = "Harvest 1500 Coconuts",
                    Type = "Harvest",
                    Target = 1500,
                    Arguments = { "Coconut" },
                    Rewards = { {
                            Type = "XP",
                            Value = 550
                        } }
                },
                {
                    Id = "Mythical_Harvest_300_Cactus",
                    Display = "Harvest 300 Cacti",
                    Type = "Harvest",
                    Target = 300,
                    Arguments = { "Cactus" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Harvest_30_Silver_Cactus",
                    Display = "Harvest 30 Silver, Gold or Rainbow Cacti",
                    Type = "HarvestCropAnyVariant",
                    Target = 30,
                    Arguments = { "Cactus" },
                    Rewards = { {
                            Type = "XP",
                            Value = 450
                        } }
                },
                {
                    Id = "Mythical_Harvest_20_Shocked_Coconut",
                    Display = "Harvest 20 Shocked Coconuts",
                    Type = "HarvestCropWithMutation",
                    Target = 20,
                    Arguments = { "Coconut", "Shocked" },
                    Rewards = { {
                            Type = "XP",
                            Value = 450
                        } }
                },
                {
                    Id = "Mythical_Gift_15_Dragon_Fruit",
                    Display = "Gift 15 Dragon Fruits",
                    Type = "Gift",
                    Target = 15,
                    Arguments = { "Dragon Fruit" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Feed_Pets_100_Dragon_Fruit",
                    Display = "Feed 100 Dragon Fruits to Pets",
                    Type = "FeedAnyPet",
                    Target = 100,
                    Arguments = { "Dragon Fruit" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Harvest_5_Rainbow_Dragon_Fuit",
                    Display = "Harvest 5 Rainbow Dragon Fruits",
                    Type = "HarvestCropWithVariant",
                    Target = 5,
                    Arguments = { "Dragon Fruit", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Harvest_300_Dragon_Fruit",
                    Display = "Harvest 600 Dragon Fruits",
                    Type = "Harvest",
                    Target = 600,
                    Arguments = { "Dragon Fruit" },
                    Rewards = { {
                            Type = "XP",
                            Value = 550
                        } }
                },
                {
                    Id = "Mythical_Feed_125_Mango",
                    Display = "Feed 125 Mangos to Pets",
                    Type = "FeedAnyPet",
                    Target = 125,
                    Arguments = { "Mango" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Harvest_500_Mango",
                    Display = "Harvest 500 Mangos",
                    Type = "Harvest",
                    Target = 500,
                    Arguments = { "Mango" },
                    Rewards = { {
                            Type = "XP",
                            Value = 550
                        } }
                },
                {
                    Id = "Mythical_Harvest_20Kg_Mango",
                    Display = "Harvest 10 20kg Mangos",
                    Type = "HarvestGreaterThanSize",
                    Target = 10,
                    Size = 20,
                    Arguments = { "Mango" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Mythical_Harvest_15_Gold_Mango",
                    Display = "Harvest 15 Gold Mangos",
                    Type = "HarvestCropWithVariant",
                    Target = 15,
                    Arguments = { "Mango", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                }
            }
        },
        Divine = {
            Rewards = { {
                    Type = "Seed Pack",
                    Value = "Silver Divine Seed Pack",
                    Quantity = 3
                } },
            Quests = {
                {
                    Id = "Divine_Harvest_2000_Mutations",
                    Display = "Harvest 8000 Mutated Crops",
                    Type = "HarvestAnyMutation",
                    Target = 8000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 700
                        } }
                },
                {
                    Id = "Divine_Harvest_75_Shocked_Crops",
                    Display = "Harvest 75 Shocked Crops",
                    Type = "HarvestMutation",
                    Target = 75,
                    Arguments = { "Shocked" },
                    Rewards = { {
                            Type = "XP",
                            Value = 700
                        } }
                },
                {
                    Id = "Divine_Cook_60_Grape",
                    Display = "Use 60 Grapes in Cooking",
                    Type = "Cooking",
                    Target = 60,
                    Arguments = { "Grape" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Harvest_1000_Grape",
                    Display = "Harvest 1000 Grapes",
                    Type = "Harvest",
                    Target = 1000,
                    Arguments = { "Grape" },
                    Rewards = { {
                            Type = "XP",
                            Value = 650
                        } }
                },
                {
                    Id = "Divine_Harvest_200_Grape",
                    Display = "Harvest 200 Mutated Grapes",
                    Type = "HarvestCropWithAnyMutation",
                    Target = 200,
                    Arguments = { "Grape" },
                    Rewards = { {
                            Type = "XP",
                            Value = 650
                        } }
                },
                {
                    Id = "Divine_Cook_250_Mushroom",
                    Display = "Use 250 Mushrooms in Cooking",
                    Type = "Cooking",
                    Target = 250,
                    Arguments = { "Mushroom" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Divine_Gift_30_Mushroom",
                    Display = "Gift 30 Mushrooms",
                    Type = "Gift",
                    Target = 30,
                    Arguments = { "Mushroom" },
                    Rewards = { {
                            Type = "XP",
                            Value = 450
                        } }
                },
                {
                    Id = "Divine_Harvest_60_Mushroom",
                    Display = "Harvest 60 Mushrooms",
                    Type = "Harvest",
                    Target = 60,
                    Arguments = { "Mushroom" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Harvest_500_Pepper",
                    Display = "Harvest 500 Peppers",
                    Type = "Harvest",
                    Target = 500,
                    Arguments = { "Pepper" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Feed_Pets_300_Pepper",
                    Display = "Feed 300 Peppers to Pets",
                    Type = "FeedAnyPet",
                    Target = 300,
                    Arguments = { "Pepper" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Harvest_15_Gold_Pepper",
                    Display = "Harvest 15 Gold Peppers",
                    Type = "HarvestCropWithVariant",
                    Target = 15,
                    Arguments = { "Pepper", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Harvest_400_Cacao",
                    Display = "Harvest 400 Cacao",
                    Type = "Harvest",
                    Target = 400,
                    Arguments = { "Cacao" },
                    Rewards = { {
                            Type = "XP",
                            Value = 650
                        } }
                },
                {
                    Id = "Divine_Cook_250_Cacao",
                    Display = "Use 250 Cacao in Cooking",
                    Type = "Cooking",
                    Target = 250,
                    Arguments = { "Cacao" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Gift_20_Cacao",
                    Display = "Gift 20 Cacao",
                    Type = "Gift",
                    Target = 20,
                    Arguments = { "Cacao" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                }
            }
        },
        Prismatic = {
            Rewards = { {
                    Type = "Seed Pack",
                    Value = "Silver Prismatic Seed Pack",
                    Quantity = 2
                } },
            Quests = {
                {
                    Id = "Prismatic_Harvest_20000_Mutations",
                    Display = "Harvest 20000 Mutated Plants",
                    Type = "HarvestAnyMutation",
                    Target = 20000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Shovel_1000_Crops",
                    Display = "Shovel 1000 Plants",
                    Type = "ShovelAny",
                    Target = 1000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_30_Disco_Crops",
                    Display = "Harvest 30 Disco Crops",
                    Type = "HarvestMutation",
                    Target = 30,
                    Arguments = { "Disco" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_300_Beanstalk",
                    Display = "Harvest 300 Beanstalks",
                    Type = "Harvest",
                    Target = 300,
                    Arguments = { "Beanstalk" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Harvest_100_Silver_Beanstalk",
                    Display = "Harvest 100 Silver, Gold or Rainbow Beanstalks",
                    Type = "HarvestCropAnyVariant",
                    Target = 100,
                    Arguments = { "Beanstalk" },
                    Rewards = { {
                            Type = "XP",
                            Value = 950
                        } }
                },
                {
                    Id = "Prismatic_Harvest_5_Rainbow_Beanstalk",
                    Display = "Harvest 5 Rainbow Beanstalks",
                    Type = "HarvestCropWithVariant",
                    Target = 5,
                    Arguments = { "Beanstalk", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_100_Ember_Lily",
                    Display = "Harvest 100 Ember Lilies",
                    Type = "Harvest",
                    Target = 100,
                    Arguments = { "Ember Lily" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_10_Gold_Ember_Lily",
                    Display = "Harvest 10 Gold Ember Lilies",
                    Type = "HarvestCropWithVariant",
                    Target = 10,
                    Arguments = { "Ember Lily", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Gift_10_Ember_Lily",
                    Display = "Gift 10 Ember Lilies",
                    Type = "Gift",
                    Target = 10,
                    Arguments = { "Ember Lily" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Plant_6_Sugar_Apple",
                    Display = "Plant 6 Sugar Apple Trees",
                    Type = "Plant",
                    Target = 6,
                    Arguments = { "Sugar Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_1000_Sugar_Apple",
                    Display = "Harvest 1000 Sugar Apples",
                    Type = "Harvest",
                    Target = 1000,
                    Arguments = { "Sugar Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_10_Rainbow_Sugar_Apple",
                    Display = "Harvest 10 Rainbow Sugar Apples",
                    Type = "HarvestCropWithVariant",
                    Target = 10,
                    Arguments = { "Sugar Apple", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Cook_15_Sugar_Apple",
                    Display = "Use 15 Sugar Apples in Cooking",
                    Type = "Cooking",
                    Target = 15,
                    Arguments = { "Sugar Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Harvest_300_Giant_Pinecone",
                    Display = "Harvest 300 Giant Pinecones",
                    Type = "Harvest",
                    Target = 300,
                    Arguments = { "Giant Pinecone" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_10_Giant_Giant_Pinecone",
                    Display = "Harvest 10 15kg Giant Pinecones",
                    Type = "HarvestGreaterThanSize",
                    Target = 10,
                    Size = 15,
                    Arguments = { "Giant Pinecone" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Sell_1000_Burning_Bud",
                    Display = "Sell 1000 Burning Buds",
                    Type = "Sell",
                    Target = 1000,
                    Arguments = { "Burning Bud" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Gift_5_Burning_Bud",
                    Display = "Gift 5 Burning Buds",
                    Type = "Gift",
                    Target = 5,
                    Arguments = { "Burning Bud" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Harvest_30_Silver_Burning_Bud",
                    Display = "Harvest 30 Silver, Gold or Rainbow Burning Buds",
                    Type = "HarvestCropAnyVariant",
                    Target = 30,
                    Arguments = { "Burning Bud" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_300_Elder_Strawberry",
                    Display = "Harvest 300 Elder Strawberries",
                    Type = "Harvest",
                    Target = 300,
                    Arguments = { "Elder Strawberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_30_Gold_Elder_Strawberry",
                    Display = "Harvest 30 Gold Elder Strawberries",
                    Type = "HarvestCropWithVariant",
                    Target = 30,
                    Arguments = { "Elder Strawberry", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Cook_30_Elder_Strawberry",
                    Display = "Use 30 Elder Strawberries in Cooking",
                    Type = "Cooking",
                    Target = 30,
                    Arguments = { "Elder Strawberry" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Plant_3_Romanesco",
                    Display = "Plant 3 Romanesco",
                    Type = "Plant",
                    Target = 3,
                    Arguments = { "Romanesco" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Harvest_25_Romanesco",
                    Display = "Harvest 25 Mutated Romanesco",
                    Type = "HarvestCropWithAnyMutation",
                    Target = 25,
                    Arguments = { "Romanesco" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Harvest_5_Gold_Romanesco",
                    Display = "Harvest 5 Gold Romanesco",
                    Type = "HarvestCropWithVariant",
                    Target = 5,
                    Arguments = { "Romanesco", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                },
                {
                    Id = "Prismatic_Harvest_1_Rainbow_Romanesco",
                    Display = "Harvest 1 Rainbow Romanesco",
                    Type = "HarvestCropWithVariant",
                    Target = 1,
                    Arguments = { "Romanesco", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 900
                        } }
                }
            }
        },
        Transcendent = {
            Rewards = { {
                    Type = "Seed Pack",
                    Value = "Silver Transcendent Seed Pack",
                    Quantity = 2
                } },
            Quests = {
                {
                    Id = "Transcendent_Harvest_Mutations",
                    Display = "Harvest 50000 Mutated Plants",
                    Type = "HarvestAnyMutation",
                    Target = 50000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Heavy",
                    Display = "Harvest 20 Crimson Thorns that are at least 15kgs",
                    Type = "HarvestGreaterThanSize",
                    Target = 20,
                    Size = 15,
                    Arguments = { "Crimson Thorn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Variant",
                    Display = "Harvest 200 Ember Mutated Plants",
                    Type = "HarvestMutation",
                    Target = 200,
                    Arguments = { "Ember" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Plant_Crimson_Thorn",
                    Display = "Plant 200 Crimson Thorns",
                    Type = "Plant",
                    Target = 200,
                    Arguments = { "Crimson Thorn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Crimson_Thorn",
                    Display = "Harvest 400 Crimson Thorns",
                    Type = "Harvest",
                    Target = 400,
                    Arguments = { "Crimson Thorn" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Crimson_Thorn_Variant",
                    Display = "Harvest 150 Silver Crimson Thorns",
                    Type = "HarvestCropWithVariant",
                    Target = 150,
                    Arguments = { "Crimson Thorn", "Silver" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Crimson_Thorn_Mutation",
                    Display = "Harvest 20 Crimson Thorns with Meteoric mutation",
                    Type = "HarvestCropWithMutation",
                    Target = 20,
                    Arguments = { "Crimson Thorn", "Meteoric" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Plant_Zebrazinkle",
                    Display = "Plant 150 Zebrazinkle",
                    Type = "Plant",
                    Target = 150,
                    Arguments = { "Zebrazinkle" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Zebrazinkle",
                    Display = "Harvest 300 Zebrazinkle",
                    Type = "Harvest",
                    Target = 300,
                    Arguments = { "Zebrazinkle" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Zebrazinkle_Variant",
                    Display = "Harvest 100 Gold Zebrazinkles",
                    Type = "HarvestCropWithVariant",
                    Target = 100,
                    Arguments = { "Zebrazinkle", "Gold" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Zebrazinkle_Mutation",
                    Display = "Harvest 15 Zebrazinkles with Biohazard mutation",
                    Type = "HarvestCropWithMutation",
                    Target = 15,
                    Arguments = { "Zebrazinkle", "Biohazard" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Plant_Octobloom",
                    Display = "Plant 100 Octobloom",
                    Type = "Plant",
                    Target = 100,
                    Arguments = { "Octobloom" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Octobloom",
                    Display = "Harvest 200 Octobloom",
                    Type = "Harvest",
                    Target = 200,
                    Arguments = { "Octobloom" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Octobloom_Variant",
                    Display = "Harvest 50 Rainbow Octoblooms",
                    Type = "HarvestCropWithVariant",
                    Target = 50,
                    Arguments = { "Octobloom", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Octobloom_Mutation",
                    Display = "Harvest 10 Octoblooms with Brainrot mutation",
                    Type = "HarvestCropWithMutation",
                    Target = 10,
                    Arguments = { "Octobloom", "Brainrot" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Plant_Alien_Apple",
                    Display = "Plant 50 Alien Apple",
                    Type = "Plant",
                    Target = 50,
                    Arguments = { "Alien Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Alien_Apple",
                    Display = "Harvest 100 Alien Apple",
                    Type = "Harvest",
                    Target = 100,
                    Arguments = { "Alien Apple" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Alien_Apple_Variant",
                    Display = "Harvest 10 Rainbow Alien Apple",
                    Type = "HarvestCropWithVariant",
                    Target = 10,
                    Arguments = { "Alien Apple", "Rainbow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Transcendent_Harvest_Alien_Apple_Mutation",
                    Display = "Harvest 5 Alien Apples with Abyssal mutation",
                    Type = "HarvestCropWithMutation",
                    Target = 5,
                    Arguments = { "Alien Apple", "Abyssal" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                }
            }
        }
    }
};