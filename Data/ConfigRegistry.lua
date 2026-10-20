-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Events = ReplicatedStorage.Data.Events;

return {
    OptimizedGardenLoading = require(ReplicatedStorage.Data.OptimizedGardenLoading),
    EventRotationInitialTime = 1788035400,
    EventRotationConfig = require(ReplicatedStorage.Modules.EventRotation.EventRotationConfig),
    AngryPlantConfig = require(Events.AngryPlantEvent.AngryPlantConfig),
    LunarGlowConfig = require(Events.LunarGlowEvent.LunarGlowConfig),
    SummerHarvestEventConfig = require(Events.SummerHarvestEvent.SummerHarvestConfig),
    PrehistoricEventConfig = require(Events.PrehistoricEvent.PrehistoricEventConfig),
    BeanstalkEventConfig = require(Events.BeanstalkEvent.BeanstalkEventConfig),
    GoldCauldronConfig = require(Events.BeanstalkEvent.GoldCauldronConfig),
    BasketDeliveryConfig = require(Events.BeanstalkEvent.BasketDeliveryConfig),
    ZenEventConfig = require(Events.ZenEvent.ZenEventConfig),
    CookingEventConfig = require(Events.CookingEvent.CookingEventConfig),
    FallMarketEventConfig = require(Events.FallMarketEvent.FallMarketEventConfig),
    FallMarketIndexConfig = require(Events.FallMarketEvent.FallMarketIndexConfig),
    AcornChaosConfig = require(Events.FallMarketEvent.AcornChaosConfig),
    ShadyScarecrowConfig = require(Events.FallMarketEvent.ShadyScarecrowConfig),
    HalloweenHungryConfig = require(Events.Halloween2026Event.HalloweenHungryConfig),
    FlowerRushConfig = require(ReplicatedStorage.Data.BeeEvent.FlowerRushConfig),
    SummerCraftingConfig = require(ReplicatedStorage.Modules.Events.CampfireEvent.SummerCraftingController.SummerCraftingConfig),
    SummerFireConfig = require(Events.CampfireEvent.SummerFireConfig),
    SummerBearConfig = require(Events.CampfireEvent.SummerBearConfig),
    SummerRitualConfig = require(Events.CampfireEvent.SummerRitualConfig),
    SummerQuestConfig = require(Events.CampfireEvent.SummerQuestConfig),
    SummerHarvestConfig = require(Events.Summer2026Event.SummerHarvestConfig),
    SummerChestHuntConfig = require(Events.Summer2026Event.SummerChestHuntConfig),
    SummerHarvestTeamConfig = require(ReplicatedStorage.Modules.Events.Summer2026Event.SummerEventControllers.SummerHarvestController.SummerHarvestTeamConfig),
    PirateQuestConfig = require(Events.Summer2026Event.PirateQuestConfig),
    HarvestMoonConfig = require(Events.HarvestMoonEvent.HarvestMoonConfig),
    HarvestMoonOwlConfig = require(Events.HarvestMoonEvent.HarvestMoonOwlConfig),
    HarvestMoonTeamRewards = require(Events.HarvestMoonEvent.HarvestMoonTeamConfig).TeamRewards,
    HarvestMoonPetConfig = require(Events.HarvestMoonEvent.HarvestMoonPetConfig),
    HarvestMoonQuestsConfig = require(Events.HarvestMoonEvent.HarvestMoonQuestsConfig),
    HarvestMoonIndexConfig = require(Events.HarvestMoonEvent.HarvestMoonIndexConfig),
    MoonCraftingConfig = require(Events.HarvestMoonEvent.MoonCraftingConfig),
    SafariHarvestConfig = require(Events.SafariEvent.SafariEventConfigData),
    SeasonPassTimerData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassTimerData),
    AuthorizedGlobalChatQueuers = { 339310190, 327423121, 14838908, 3296891394 },
    AuthorizedGlobalCommand = { 10916243, 327423121, 425901043, 3296891394, 7627847305, 33372493, 355661302 },
    AuthorizedRolesLiveGame = { 255, 254, 253, 7 },
    AuthorizedRolesQAGame = { 255, 254, 253, 200, 16, 15, 7 },
    AuthorizedUsersDevGame = { 8095632868, 327423121, 178596165, 8038988248, 425901043, 885530, 10916243, 14838908, 6096303964, 537836346, 2927843917, 813163219, 1966448091, 8047477009, 8035006873, 224410, 59240296, 538710840, 169231774, 4886900128, 2678001507, 2243026817, 189239279, 7627847305, 3322671272, 92896663, 50252478, 2275737958, 8676725876, 9062754010, 9070867124, 9099919347, 4741243987, 9887377047, 8151008303, 1647400306, 9702825457, 9923316322, 355661302, 33372493, 381042662, 14745425, 91074774, 49215350, 11492897308, -1, -2, -3, -4, 348338200, 5116026013, 4135776327, 339310190, 724719395 },
    AuthorizedUsersLiveGame = { 537836346, 813163219, 327423121, 10916243, 425901043, 7627847305, 33372493, 355661302, 339310190, 5736834625, 3296891394 },
    UpdateTimerData = { {
            UpdateText = "<b><font color=\"rgb(0,254,242)\">Easter Update: Part 2</font></b> \n in: :UpdateTime:",
            UpdateTime = 1775928600
        }, {
            UpdateText = "<b><font color=\"rgb(255,0,0)\">Jandel Admin Abuse</font></b> \n in: :UpdateTime:",
            UpdateTime = 1775926800
        } },
    CandyBlossomCrafting_EGG_GROWTH = 10,
    CandyBlossomCrafting_ITEM_GROWTH = 1,
    CandyBlossomCrafting_EGG_REQUIREMENT = 50,
    CandyBlossomCrafting_ITEM_REQUIREMENT = 1,
    CommandLoggingToSPPEnabled = true,
    ContentCreators = { 327423121, 21213718 },
    BeeEventQuestPeriod = 3600,
    WaspWaveSurvival_EndsAtUnix = 1780777800,
    BeeEventQuestData = {
        Easy = { {
                Quest = "Pollinate",
                Target = 25,
                Jelly = 15
            }, {
                Quest = "GodlyPollination",
                Target = 1,
                Jelly = 15
            }, {
                Quest = "FillHoneyCompressor",
                Target = 4,
                Jelly = 15
            }, {
                Quest = "CompressPollen",
                Target = 10,
                Jelly = 15
            }, {
                Quest = "HatchBeeEgg",
                Target = 3,
                Jelly = 15
            }, {
                Quest = "BuyBeeEgg",
                Target = 1,
                Jelly = 15
            }, {
                Quest = "BuyHoneySeed",
                Target = 25,
                Jelly = 15
            }, {
                Quest = "IncubateSeed",
                Target = 2,
                Jelly = 15
            }, {
                Quest = "HoneyGardenHarvest",
                Target = 25,
                Jelly = 15
            }, {
                Quest = "HoneyGardenPlant",
                Target = 15,
                Jelly = 15
            }, {
                Quest = "EarnEventCurrency",
                Target = 200,
                Jelly = 15,
                Arguments = { "HoneyCoins" }
            }, {
                Quest = "SpendCurrency",
                Target = 100,
                Jelly = 15,
                Arguments = { "HoneyCoins" }
            } },
        Medium = { {
                Quest = "Pollinate",
                Target = 75,
                Jelly = 35
            }, {
                Quest = "GodlyPollination",
                Target = 3,
                Jelly = 35
            }, {
                Quest = "FillHoneyCompressor",
                Target = 15,
                Jelly = 35
            }, {
                Quest = "CompressPollen",
                Target = 30,
                Jelly = 35
            }, {
                Quest = "HatchBeeEgg",
                Target = 6,
                Jelly = 35
            }, {
                Quest = "BuyBeeEgg",
                Target = 2,
                Jelly = 35
            }, {
                Quest = "BuyHoneySeed",
                Target = 50,
                Jelly = 35
            }, {
                Quest = "IncubateSeed",
                Target = 4,
                Jelly = 35
            }, {
                Quest = "HoneyGardenHarvest",
                Target = 75,
                Jelly = 35
            }, {
                Quest = "HoneyGardenPlant",
                Target = 50,
                Jelly = 35
            }, {
                Quest = "EarnEventCurrency",
                Target = 500,
                Jelly = 35,
                Arguments = { "HoneyCoins" }
            }, {
                Quest = "SpendCurrency",
                Target = 300,
                Jelly = 35,
                Arguments = { "HoneyCoins" }
            } },
        Hard = { {
                Quest = "Pollinate",
                Target = 200,
                Jelly = 75
            }, {
                Quest = "GodlyPollination",
                Target = 7,
                Jelly = 75
            }, {
                Quest = "FillHoneyCompressor",
                Target = 25,
                Jelly = 75
            }, {
                Quest = "CompressPollen",
                Target = 80,
                Jelly = 75
            }, {
                Quest = "HatchBeeEgg",
                Target = 9,
                Jelly = 75
            }, {
                Quest = "BuyBeeEgg",
                Target = 20,
                Jelly = 75
            }, {
                Quest = "BuyHoneySeed",
                Target = 100,
                Jelly = 75
            }, {
                Quest = "IncubateSeed",
                Target = 7,
                Jelly = 75
            }, {
                Quest = "HoneyGardenHarvest",
                Target = 200,
                Jelly = 75
            }, {
                Quest = "HoneyGardenPlant",
                Target = 150,
                Jelly = 75
            }, {
                Quest = "EarnEventCurrency",
                Target = 1500,
                Jelly = 75,
                Arguments = { "HoneyCoins" }
            }, {
                Quest = "SpendCurrency",
                Target = 1000,
                Jelly = 75,
                Arguments = { "HoneyCoins" }
            } }
    },
    HoneyMachineSettings = {
        VALUE_POWER = 0.7079,
        VALUE_OFFSET_BEFORE = 0,
        VALUE_OFFSET_AFTER = 0,
        VALUE_COEFFICIENT = 0.1131
    },
    SummerBearSettings = {
        TRAIT_SWITCH_TIMER = 1800
    },
    PollingEnabled = false,
    BTClientEnabled = false,
    BTActorSampleRate = 1,
    CosmeticPoolCompactionEnabled = false,
    CosmeticPoolUnpoolEnabled = false
};