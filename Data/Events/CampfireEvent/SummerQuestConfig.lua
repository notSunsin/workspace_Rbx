-- Decompiled with Potassium's decompiler.

return {
    CONTAINER_NAME = "SummerQuest",
    CONTAINER_TAG = "SummerQuest",
    MODEL_TAG = "SummerQuestModel",
    DATA_KEY = "SummerQuestData",
    REFRESH_INTERVAL = 3600,
    REWARD_OPTION_COUNT = 3,
    MAX_FREE_REROLLS = 0,
    REWARD_CYCLE_INTERVAL = 5,
    REROLL_PRODUCT_ID = 3606118758,
    SKIP_QUESTS_PRODUCT_ID = 3606118806,
    Quests = {
        Easy = { {
                Quest = "PlantCampfireSeed",
                Target = 5
            }, {
                Quest = "SubmitBearnaby",
                Target = 3
            }, {
                Quest = "SubmitSummerCampfire",
                Target = 30
            }, {
                Quest = "OpenCampfireSeedPack",
                Target = 3
            }, {
                Quest = "SummerCraft",
                Target = 5
            }, {
                Quest = "SummerHarvest",
                Target = 15
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 8,
                Arguments = { "Firepit Flower" }
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 7,
                Arguments = { "Bear Claw Flower" }
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 3,
                Arguments = { "Venus Beartrap" }
            } },
        Medium = { {
                Quest = "HatchCampfireEgg",
                Target = 2
            }, {
                Quest = "PlantCampfireSeed",
                Target = 25
            }, {
                Quest = "SubmitBearnaby",
                Target = 10
            }, {
                Quest = "CreateInfernoPet",
                Target = 1
            }, {
                Quest = "SubmitSummerCampfire",
                Target = 60
            }, {
                Quest = "OpenCampfireSeedPack",
                Target = 10
            }, {
                Quest = "SummerCraft",
                Target = 10
            }, {
                Quest = "SummerCraftSpecific",
                Target = 1,
                Arguments = { "Campfire Egg" }
            }, {
                Quest = "SummerHarvest",
                Target = 45
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 12,
                Arguments = { "Venus Beartrap" }
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 12,
                Arguments = { "Hearth Reed" }
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 10,
                Arguments = { "Flame Berry" }
            } },
        Hard = { {
                Quest = "HatchCampfireEgg",
                Target = 4
            }, {
                Quest = "PlantCampfireSeed",
                Target = 50
            }, {
                Quest = "SubmitBearnaby",
                Target = 20
            }, {
                Quest = "CreateInfernoPet",
                Target = 2
            }, {
                Quest = "SubmitSummerCampfire",
                Target = 80
            }, {
                Quest = "OpenCampfireSeedPack",
                Target = 20
            }, {
                Quest = "SummerCraft",
                Target = 15
            }, {
                Quest = "SummerCraftSpecific",
                Target = 2,
                Arguments = { "Campfire Egg" }
            }, {
                Quest = "SummerHarvest",
                Target = 75
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 15,
                Arguments = { "Flame Berry" }
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 7,
                Arguments = { "Smoke Stalk" }
            }, {
                Quest = "SummerHarvestSpecific",
                Target = 5,
                Arguments = { "Smore Suckle" }
            } }
    },
    RewardPool = { {
            Chance = 12,
            Reward = {
                Type = "Crate",
                Value = "Campfire Crate",
                Quantity = 1
            }
        }, {
            Chance = 10,
            Reward = {
                Type = "Seed Pack",
                Value = "Campfire Seed Pack",
                Quantity = 1
            }
        }, {
            Chance = 10,
            Reward = {
                Type = "Gear",
                Value = "Areaclaimer",
                Quantity = 1
            }
        }, {
            Chance = 9,
            Reward = {
                Type = "Egg",
                Value = "Campfire Egg",
                Quantity = 1
            }
        }, {
            Chance = 4,
            Reward = {
                Type = "Seed",
                Value = "Flamebud",
                Quantity = 1
            }
        }, {
            Chance = 7,
            OnlyOnce = true,
            Reward = {
                Type = "Fences",
                Value = "CAMPFIRE",
                Quantity = 1
            }
        } },
    CampfireSeeds = {
        ["Bear Claw Flower"] = true,
        ["Campfire Clover"] = true,
        ["Flame Berry"] = true,
        ["Smore Suckle"] = true,
        ["Venus Beartrap"] = true,
        ["Pitcher Plant"] = true,
        Feijoa = true,
        ["Prickly Pear"] = true,
        ["Smoke Stalk"] = true,
        ["Hearth Reed"] = true,
        Kiwi = true,
        Banana = true,
        Avocado = true,
        ["Green Apple"] = true,
        Cauliflower = true,
        ["Firepit Flower"] = true,
        ["Mallow Melt"] = true
    },
    MESSAGE_QUESTION = { { 1.5, "I\'m the Camp Ranger!" }, { 3, "Complete Campfire Quests that I give you to earn rewards" }, { 3, "Every 3 quests you complete i\'ll give you a reward!" }, { 3, "Quests refresh each hour so keep an eye out for new ones..." } },
    MESSAGES = {
        ALL_COMPLETE = "🔥 All Campfire Quests completed! Pick your reward!",
        REWARD_CLAIMED = "🔥 Reward claimed: REWARD!",
        NO_PENDING = "You have no reward to claim right now.",
        REROLLED = "🔥 Your reward choices were rerolled!",
        NOT_READY = "Finish all 3 Campfire Quests first!"
    }
};