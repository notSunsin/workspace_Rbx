-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.AchievementsData.Types);

return {
    SeasonName = "Core Pets",
    SeasonDescription = "Achievements for eggs in the egg shop",
    SeasonAwardSubHeading = "Complete all achievements for the MEGA Lollipop, Egg Incubator and Pet Shard Rainbow",
    StartTime = game.GameId == 7500518143 and 0 or 1755955800,
    Rewards = { {
            Type = "Gear",
            Value = "Mega Lollipop",
            Quantity = 1
        }, {
            Type = "Cosmetic",
            Value = "Egg Incubator",
            Quantity = 1
        }, {
            Type = "Gear",
            Value = "Pet Shard Rainbow",
            Quantity = 1
        } },
    Sets = {
        Common = {
            Rewards = { {
                    Type = "Egg",
                    Value = "Uncommon Egg",
                    Quantity = 5
                }, {
                    Type = "Gear",
                    Value = "Levelup Lollipop",
                    Quantity = 1
                } },
            Quests = {
                {
                    Id = "Common_Dog_to_DigUp_15_Seeds",
                    Display = "Dog to dig up 15 Seeds ",
                    Type = "DogDigUp",
                    Target = 15,
                    Arguments = { "Dog" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "Common_GoldenLab_to_DigUp_30_Seeds",
                    Display = "Golden Lab to dig up 30 Seeds ",
                    Type = "DogDigUp",
                    Target = 30,
                    Arguments = { "Golden Lab" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "Common_Feed_Pets_100_Times",
                    Display = "Feed Pets 100 Times",
                    Type = "FeedAnyPetWithAny",
                    Target = 100,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "Common_Sell_Pets_100_Times",
                    Display = "Sell 100 Pets",
                    Type = "SellAnyPet",
                    Target = 100,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "Common_Gift_5_Dogs",
                    Display = "Gift 5 Dogs",
                    Type = "GiftPet",
                    Target = 5,
                    Arguments = { "Dog" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "Common_Mutate_Lab",
                    Display = "Mutate a Golden Lab",
                    Type = "MutatePetWithAny",
                    Target = 1,
                    Arguments = { "Golden Lab" },
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                }
            }
        },
        Uncommon = {
            Rewards = { {
                    Type = "Egg",
                    Value = "Rare Egg",
                    Quantity = 5
                }, {
                    Type = "Gear",
                    Value = "Levelup Lollipop",
                    Quantity = 3
                } },
            Quests = {
                {
                    Id = "Uncommon_Cat_Nap_15_times",
                    Display = "Get Cat to Nap 15 Times",
                    Type = "PetZoneTrigger",
                    Target = 15,
                    Arguments = { "Cat" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_BerryType_100_times_Deer",
                    Display = "Get Berry type crops to replant 100 times with Deer active",
                    Type = "PetAttributeCounter",
                    Target = 100,
                    Arguments = {},
                    ActivePet = { "Deer" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Hatch_25_Eggs_With_Chicken",
                    Display = "Hatch 25 Eggs with Chicken active",
                    Type = "HatchAnyEgg",
                    Target = 25,
                    Arguments = {},
                    ActivePet = { "Chicken" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Gift_200_Pets",
                    Display = "Gift 200 Pets",
                    Type = "GiftAnyPet",
                    Target = 200,
                    Arguments = {},
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Grow_Cat_Age_50",
                    Display = "Grow a Cat to age 50",
                    Type = "GrowPetToAge",
                    Target = 1,
                    Arguments = { "Cat", "50" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Uncommon_Use_200_Pet_Boosts",
                    Display = "Use 200 Pet Boosts",
                    Type = "BoostAnyPetWithAny",
                    Target = 200,
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
                    Type = "Egg",
                    Value = "Legendary Egg",
                    Quantity = 5
                }, {
                    Type = "Gear",
                    Value = "Levelup Lollipop",
                    Quantity = 5
                }, {
                    Type = "Gear",
                    Value = "Pet Shard Silver",
                    Quantity = 1
                } },
            Quests = {
                {
                    Id = "Rare_OrangeTabby_Nap_15_times",
                    Display = "Get Orange Tabby to Nap 20 Times",
                    Type = "PetZoneTrigger",
                    Target = 20,
                    Arguments = { "Orange Tabby" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Rare_BerryType_200_times_SpottedDeer",
                    Display = "Get Berry type crops to replant 200 times with Spotted Deer active",
                    Type = "PetAttributeCounter",
                    Target = 200,
                    Arguments = {},
                    ActivePet = { "Spotted Deer" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Rare_Get_Refunded_100_Fruit_Monkey",
                    Display = "Get refunded 100 fruit with Monkey active",
                    Type = "PetAttributeCounter",
                    Target = 100,
                    Arguments = {},
                    ActivePet = { "Monkey" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Rare_Hatch_50_Eggs_With_Rooster",
                    Display = "Hatch 50 Eggs with Rooster active",
                    Type = "HatchAnyEgg",
                    Target = 50,
                    Arguments = {},
                    ActivePet = { "Rooster" },
                    Rewards = { {
                            Type = "XP",
                            Value = 250
                        } }
                },
                {
                    Id = "Rare_Grow_Monkey_Age_75",
                    Display = "Grow a Monkey to age 75",
                    Type = "GrowPetToAge",
                    Target = 1,
                    Arguments = { "Monkey", "75" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Rare_Gift_200_Pet",
                    Display = "Gift 200 Pets",
                    Type = "GiftAnyPet",
                    Target = 200,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                }
            }
        },
        Legendary = {
            Rewards = { {
                    Type = "Egg",
                    Value = "Mythical Egg",
                    Quantity = 5
                }, {
                    Type = "Gear",
                    Value = "Silver Lollipop",
                    Quantity = 1
                }, {
                    Type = "Gear",
                    Value = "Pet Shard Silver",
                    Quantity = 2
                } },
            Quests = {
                {
                    Id = "Legendary_Get_Refunded_300_Fruit_SilverMonkey",
                    Display = "Get refunded 300 fruit with Silver Monkey active",
                    Type = "PetAttributeCounter",
                    Target = 300,
                    Arguments = {},
                    ActivePet = { "Silver Monkey" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Legendary_Place_Sprinkler_100_times_Turtle",
                    Display = "Place Sprinklers 100 times with Turtle active",
                    Type = "PlaceItem",
                    Target = 100,
                    Arguments = {},
                    ActivePet = { "Turtle" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Legendary_Plant_500_Crop_Cow",
                    Display = "Plant 500 crops with Cow active",
                    Type = "PlantAny",
                    Target = 500,
                    Arguments = {},
                    ActivePet = { "Cow" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Legendary_Otter_Water_500_Crop",
                    Display = "Get Sea Otter to water 500 crops",
                    Type = "PetAction",
                    Target = 500,
                    Arguments = { "Sea Otter" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Legendary_PolarBear_Mutate_100",
                    Display = "Get Polar Bear to mutate fruits 100 times",
                    Type = "PetAction",
                    Target = 100,
                    Arguments = { "Polar Bear" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                },
                {
                    Id = "Legendary_Use_5_LevelUp_Lollipop",
                    Display = "Use 5 Level Up Lollipop",
                    Type = "BoostAnyPet",
                    Target = 5,
                    Arguments = { "Lollipop" },
                    Rewards = { {
                            Type = "XP",
                            Value = 150
                        } }
                }
            }
        },
        Mythical = {
            Rewards = { {
                    Type = "Egg",
                    Value = "Bug Egg",
                    Quantity = 5
                }, {
                    Type = "Gear",
                    Value = "Silver Lollipop",
                    Quantity = 2
                }, {
                    Type = "Gear",
                    Value = "Pet Shard Silver",
                    Quantity = 2
                } },
            Quests = {
                {
                    Id = "Mythical_Lucky_Harvest_250_Times_Snail",
                    Display = "Get 250 Lucky Harvests with the Snail",
                    Type = "LuckyHarvestAny",
                    Target = 250,
                    Arguments = {},
                    ActivePet = { "Snail" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Plant_500_Leafy_Crops_Caterpillar",
                    Display = "Plant 500 Leafy crops with Caterpillar active",
                    Type = "PlantWithTrait",
                    Target = 500,
                    Arguments = { "Leafy" },
                    ActivePet = { "Caterpillar" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Grey_Mouse_Gain_10000_XP",
                    Display = "Get Grey Mouse to gain 10,000 XP",
                    Type = "PetXPGain",
                    Target = 10000,
                    Arguments = { "Grey Mouse" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Brown_Mouse_Gain_15000_XP",
                    Display = "Get Brown Mouse to gain 15,000 XP",
                    Type = "PetXPGain",
                    Target = 15000,
                    Arguments = { "Brown Mouse" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Duplicate_Crops_500_Times_Giant_Ant",
                    Display = "Get 500 Lucky Dupes with Red Giant Ant",
                    Type = "LuckyDupeAny",
                    Target = 500,
                    Arguments = {},
                    ActivePet = { "Red Giant Ant" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Save_100_Reclaimers_Squirrel",
                    Display = "Save 100 Reclaimers while Squirrel is active",
                    Type = "LuckyReclaim",
                    Target = 100,
                    Arguments = {},
                    ActivePet = { "Squirrel" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Grow_Squirrel_Age_100",
                    Display = "Grow a Squirrel to Age 100",
                    Type = "GrowPetToAge",
                    Target = 1,
                    Arguments = { "Squirrel", "100" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Mythical_Gold_Mutation_Brown_Mouse",
                    Display = "Obtain Golden Mutation on Brown Mouse",
                    Type = "MutatePet",
                    Target = 1,
                    Arguments = { "Brown Mouse", "Golden" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                }
            }
        },
        Divine = {
            Rewards = { {
                    Type = "Gear",
                    Value = "Pet Shard Golden",
                    Quantity = 1
                }, {
                    Type = "Gear",
                    Value = "Gold Lollipop",
                    Quantity = 2
                } },
            Quests = {
                {
                    Id = "Divine_Duplicate_Crops_750_Times_Giant_Ant",
                    Display = "Get 750 Lucky Dupes with Giant Ant",
                    Type = "LuckyDupeAny",
                    Target = 750,
                    Arguments = {},
                    ActivePet = { "Giant Ant" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Praying_Mantis_Zen_Zone_100",
                    Display = "Get Praying Mantis to perform Zen Zone 100 times",
                    Type = "PetZoneTrigger",
                    Target = 100,
                    Arguments = { "Praying Mantis" },
                    ActivePet = { "Praying Mantis" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Dragonfly_Turn_500_Fruit",
                    Display = "Get Dragonfly to turn 500 fruit Gold",
                    Type = "PetFruitVariantTrigger",
                    Target = 500,
                    Arguments = { "Dragonfly", "Gold" },
                    ActivePet = { "Dragonfly" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Red_Fox_Steal_50_Seed",
                    Display = "Get Red Fox to steal 50 seeds",
                    Type = "PetStealSeeds",
                    Target = 50,
                    Arguments = { "Red Fox" },
                    ActivePet = { "Red Fox" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Grow_3_Pet_Age_100",
                    Display = "Grow 3 Pets to Age 100",
                    Type = "GrowAnyPetToAge",
                    Target = 3,
                    Arguments = { "100" },
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Mutate_100_Pets",
                    Display = "Mutate 100 Pets",
                    Type = "MutateAnyPetWithAny",
                    Target = 100,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Hatch_1750_Eggs",
                    Display = "Hatch 1750 eggs",
                    Type = "HatchAnyEgg",
                    Target = 1750,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                },
                {
                    Id = "Divine_Sell_Pets_1000_Times",
                    Display = "Sell 1000 Pets",
                    Type = "SellAnyPet",
                    Target = 1000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 600
                        } }
                }
            }
        },
        Prismatic = {
            Rewards = { {
                    Type = "Gear",
                    Value = "Pet Shard Rainbow",
                    Quantity = 1
                }, {
                    Type = "Gear",
                    Value = "Rainbow Lollipop",
                    Quantity = 1
                }, {
                    Type = "Gear",
                    Value = "Silver Lollipop",
                    Quantity = 1
                } },
            Quests = {
                {
                    Id = "Prismatic_Tree_Frog_Action",
                    Display = "Get Tree Frog to advance the growth of 250 crops",
                    Type = "PetAction",
                    Target = 250,
                    Arguments = { "Tree Frog" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Prismatic_Iguana_Action",
                    Display = "Get Iguana to melt 100 Frozen mutated crops",
                    Type = "PetAction",
                    Target = 100,
                    Arguments = { "Iguana" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Prismatic_Tiger_Action",
                    Display = "Get Tiger to randomize mutations on 600 crops",
                    Type = "PetAction",
                    Target = 600,
                    Arguments = { "Tiger" },
                    Rewards = { {
                            Type = "XP",
                            Value = 500
                        } }
                },
                {
                    Id = "Prismatic_Grow_Pet_Age",
                    Display = "Grow 5 Pets to Age 500",
                    Type = "GrowAnyPetToAge",
                    Target = 5,
                    Arguments = { "500" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Mutate_Pets",
                    Display = "Mutate 400 Pets",
                    Type = "MutateAnyPetWithAny",
                    Target = 400,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Hatch_Eggs",
                    Display = "Hatch 2000 eggs",
                    Type = "HatchAnyEgg",
                    Target = 2000,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Sell_Pets",
                    Display = "Sell 1500 Pets",
                    Type = "SellAnyPet",
                    Target = 1500,
                    Arguments = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                },
                {
                    Id = "Prismatic_Hatch_Heavy_Pets",
                    Display = "Hatch a Chimpanzee of at least 2.5 kgs",
                    Type = "HatchPetGreaterThanSize",
                    Target = 1,
                    Size = 2.5,
                    Arguments = { "Chimpanzee" },
                    Rewards = { {
                            Type = "XP",
                            Value = 1000
                        } }
                }
            }
        },
        ["Catch Them All"] = {
            Rewards = { {
                    Type = "Gear",
                    Value = "Pet Pouch",
                    Quantity = 10
                }, {
                    Type = "Cosmetic",
                    Value = "Mutation Machine Booster",
                    Quantity = 1
                } },
            Quests = {
                {
                    Id = "CatchThemAll_A_Dog",
                    Display = "Obtain a Dog",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Dog" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_GoldenLab",
                    Display = "Obtain a Golden Lab",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Golden Lab" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Bunny",
                    Display = "Obtain a Bunny",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Bunny" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_BlackBunny",
                    Display = "Obtain a Black Bunny",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Black Bunny" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Cat",
                    Display = "Obtain a Cat",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Cat" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Deer",
                    Display = "Obtain a Deer",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Deer" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Chicken",
                    Display = "Obtain a Chicken",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Chicken" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_OrangeTabby",
                    Display = "Obtain a Orange Tabby",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Orange Tabby" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Monkey",
                    Display = "Obtain a Monkey",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Monkey" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_SpottedDeer",
                    Display = "Obtain a Spotted Deer",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Spotted Deer" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Rooster",
                    Display = "Obtain a Rooster",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Rooster" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Pig",
                    Display = "Obtain a Pig",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Pig" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_SilverMonkey",
                    Display = "Obtain a Silver Monkey",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Silver Monkey" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Cow",
                    Display = "Obtain a Cow",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Cow" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_SeaOtter",
                    Display = "Obtain a Sea Otter",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Sea Otter" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Turtle",
                    Display = "Obtain a Turtle",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Turtle" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_PolarBear",
                    Display = "Obtain a Polar Bear",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Polar Bear" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_GreyMouse",
                    Display = "Obtain a Grey Mouse",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Grey Mouse" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Squirrel",
                    Display = "Obtain a Squirrel",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Squirrel" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_BrownMouse",
                    Display = "Obtain a Brown Mouse",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Brown Mouse" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_RedGiantAnt",
                    Display = "Obtain a Red Giant Ant",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Red Giant Ant" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_RedFox",
                    Display = "Obtain a Red Fox",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Red Fox" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Dragonfly",
                    Display = "Obtain a Dragonfly",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Dragonfly" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_PrayingMantis",
                    Display = "Obtain a Praying Mantis",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Praying Mantis" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_GiantAnt",
                    Display = "Obtain a Giant Ant",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Giant Ant" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Snail",
                    Display = "Obtain a Snail",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Snail" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                },
                {
                    Id = "CatchThemAll_A_Caterpillar",
                    Display = "Obtain a Caterpillar",
                    Type = "ObtainPet",
                    Target = 1,
                    Arguments = { "Caterpillar" },
                    ActivePet = {},
                    Rewards = { {
                            Type = "XP",
                            Value = 100
                        } }
                }
            }
        }
    }
};