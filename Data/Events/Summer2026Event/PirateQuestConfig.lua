-- Decompiled with Potassium's decompiler.

return {
    CONTAINER_NAME = "PirateQuest",
    CONTAINER_TAG = "PirateQuest",
    MODEL_TAG = "PirateQuestModel",
    TIMER_TAG = "PirateQuestTimer",
    DATA_KEY = "PirateQuestData",
    REFRESH_INTERVAL = 7200,
    SKIP_QUESTS_PRODUCT_ID = 3610859331,
    REWARD_CURRENCY = "TideTokens",
    TIER_REWARDS = {
        Easy = 5,
        Medium = 15,
        Hard = 30
    },
    Quests = {
        Easy = {
            {
                Quest = "SubmitHighTide",
                Target = 50
            },
            {
                Quest = "WaterSummerTidalPlant",
                Target = 10
            },
            {
                Quest = "SellSummerTidalPlant",
                Target = 20
            },
            {
                Quest = "ObtainSeedPack",
                Target = 2,
                Arguments = { "Coastal Seed Pack" }
            },
            {
                Quest = "HitPeopleWithShovel",
                Target = 2
            },
            {
                Quest = "ClaimConquestChest",
                Target = 2
            },
            {
                Quest = "ClaimPetFromClam",
                Target = 1
            },
            {
                Quest = "SpendTideTokens",
                Target = 20
            },
            {
                Quest = "EarnTideTokens",
                Target = 25
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 25,
                Arguments = { "Strawberry" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 20,
                Arguments = { "Blueberry" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 15,
                Arguments = { "Tomato" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 5,
                Arguments = { "Watermelon" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 5,
                Arguments = { "Cauliflower" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 2,
                Arguments = { "Rafflesia" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 10,
                Arguments = { "Green Apple" }
            },
            {
                Quest = "HatchSpecificEgg",
                Target = 2,
                Arguments = { "Coastal Egg" }
            }
        },
        Medium = {
            {
                Quest = "SubmitHighTide",
                Target = 150
            },
            {
                Quest = "WaterSummerTidalPlant",
                Target = 20
            },
            {
                Quest = "SellSummerTidalPlant",
                Target = 40
            },
            {
                Quest = "ObtainSeedPack",
                Target = 4,
                Arguments = { "Coastal Seed Pack" }
            },
            {
                Quest = "HitPeopleWithShovel",
                Target = 4
            },
            {
                Quest = "ClaimConquestChest",
                Target = 5
            },
            {
                Quest = "ClaimPetFromClam",
                Target = 2
            },
            {
                Quest = "SpendTideTokens",
                Target = 50
            },
            {
                Quest = "EarnTideTokens",
                Target = 75
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 50,
                Arguments = { "Strawberry" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 45,
                Arguments = { "Blueberry" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 25,
                Arguments = { "Tomato" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 10,
                Arguments = { "Watermelon" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 10,
                Arguments = { "Cauliflower" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 4,
                Arguments = { "Rafflesia" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 20,
                Arguments = { "Green Apple" }
            },
            {
                Quest = "HatchSpecificEgg",
                Target = 4,
                Arguments = { "Coastal Egg" }
            }
        },
        Hard = {
            {
                Quest = "SubmitHighTide",
                Target = 300
            },
            {
                Quest = "WaterSummerTidalPlant",
                Target = 40
            },
            {
                Quest = "SellSummerTidalPlant",
                Target = 80
            },
            {
                Quest = "ObtainSeedPack",
                Target = 7,
                Arguments = { "Coastal Seed Pack" }
            },
            {
                Quest = "HitPeopleWithShovel",
                Target = 6
            },
            {
                Quest = "ClaimConquestChest",
                Target = 8
            },
            {
                Quest = "ClaimPetFromClam",
                Target = 3
            },
            {
                Quest = "SpendTideTokens",
                Target = 100
            },
            {
                Quest = "EarnTideTokens",
                Target = 150
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 100,
                Arguments = { "Strawberry" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 90,
                Arguments = { "Blueberry" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 50,
                Arguments = { "Tomato" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 15,
                Arguments = { "Watermelon" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 15,
                Arguments = { "Cauliflower" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 6,
                Arguments = { "Rafflesia" }
            },
            {
                Quest = "SubmitHighTideSpecific",
                Target = 40,
                Arguments = { "Green Apple" }
            },
            {
                Quest = "HatchSpecificEgg",
                Target = 6,
                Arguments = { "Coastal Egg" }
            }
        }
    },
    MESSAGE_QUESTION = { { 1.5, "Ahoy, matey!" }, { 3, "Complete me Pirate Quests to earn Tide Tokens!" }, { 3, "Every quest ye finish pays out Tide Tokens right away." }, { 3, "Quests refresh each hour, so keep yer eye on the horizon..." } },
    MESSAGES = {
        ALL_COMPLETE = "All Pirate Quests complete! New quests next hour.",
        QUEST_REWARD = "+AMOUNT Tide Tokens!",
        SKIPPED = "Quests reset - Tide Tokens paid out!",
        RESET = "Pirate Quests Reset!"
    }
};