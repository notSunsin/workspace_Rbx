-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SettingsRegistry = require(ReplicatedStorage.Data.SettingsRegistry);
require(ReplicatedStorage.Modules.PlatformService.Signal);
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Types.SlotServiceTypes);
require(ReplicatedStorage.Types.PetTypes);
require(ReplicatedStorage.Data.GardenGuideData.GardenGuideTypes);
require(ReplicatedStorage.Data.CookingPotType);
require(ReplicatedStorage.Data.DiggingMinigame.DiggingTypes);
require(ReplicatedStorage.Data.NPCLevels.NPCLevelData.NPCLevelTypes);
require(ReplicatedStorage.Data.RebirthConfigData);
require(ReplicatedStorage.Data.TendablePlantTypes);
require(ReplicatedStorage.Data.InfGrowPlantData.InfGrowPlantTypes);
require(ReplicatedStorage.Modules.GiveServiceCommon);
local DiggingConfigData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingConfigData);
local TradeTokenData = require(ReplicatedStorage.Data.TradeTokenData);
require(ReplicatedStorage.Modules.TeamEventHelper);
require(ReplicatedStorage.Data.PetEggData);

local function DeepCopy(p1) -- Line: 25
    -- upvalues: DeepCopy (copy)
    local table_clone_ret = table.clone(p1);

    for i, v in table_clone_ret do
        if type(v) == "table" then
            table_clone_ret[i] = DeepCopy(v);
        end;
    end;

    return table_clone_ret;
end;

return {
    Backpack = {},
    Gamepasses = {},
    PlantedObjects = {},
    PlantedObjectsNew = {},
    SavedFruit = {},
    LastSaveTime = 0,
    LastPetsSaveTime = nil,
    LastPetsIncubationTime = nil,
    FirstTimeUser = true,
    TutorialReplays = 0,
    PlayedGuaranteedLuckyHarvest = false,
    ToyCodeCooldown = 0,
    LastSeenUpdateLog = nil,
    LastRotationEvent = nil,
    LastResetEventStartTime = {},
    NewPlayersServers = {
        ShouldTeleport = true
    },
    Migrated = {},
    CropsSold = 0,
    TotalCropsValueSold = 0,
    GardenGuide = {
        GardenGuideColor = nil,
        PlantData = {},
        PetData = {},
        CosmeticData = {},
        FoodData = {},
        MutationData = {}
    },
    CropMastery = {
        PlantData = {}
    },
    ShopTabData = {},
    RebirthData = {
        TotalRebirths = 0,
        LastRebirthTime = 0,
        RequiredPlants = {}
    },
    Sheckles = 20,
    DailyEgg = {
        Stock = nil,
        LastPurchaseDay = 0
    },
    GardenLevel = {
        TotalExperience = 0,
        ClaimedLevelRewards = {}
    },
    LastPlayedSeasonPass = nil,
    SeasonPass = {},
    SeasonPassHarvestCounter = {},
    SeasonPassLastHarvestReset = 0,
    NPCPoints = {},
    SpecialCurrency = {
        Honey = 0,
        HoneyCoins = 10,
        SummerCoins = 0,
        TideTokens = 0,
        MoonCoins = 0,
        Chi = 0,
        GardenCoins = 0,
        FairyPoints = 0,
        PassPoints = 0,
        CandyCorn = 0,
        AdventToken = 0,
        CarrotCoins = 0,
        ButtercupCoins = 0,
        HeartCoins = 0,
        ChocCoins = 0,
        RoyalJelly = 0
    },
    SummerQuestData = {
        Period = -1,
        ContainerId = "",
        RewardsReady = false,
        RewardClaimed = false,
        ClaimedContainerId = "",
        RerollCount = 0,
        PendingRewards = {},
        ClaimedOnceRewards = {}
    },
    PirateQuestData = {
        Period = -1,
        ContainerId = "",
        SkipSalt = 0
    },
    HoneyMachine2026 = {
        PlantWeight = 0,
        TimeLeft = 0,
        HoneyStored = 0,
        IsRunning = false,
        SubmittedPlants = {}
    },
    Fertilizer = {
        FertilizedPlants = {}
    },
    SummerHarvestTeamData = {
        GrandPrizeAwarded = false,
        DayPoints = {},
        CompletedDays = {},
        ClaimedDays = {},
        TeamDayTotals = {},
        Team = {}
    },
    SummerCraftingEventData = {
        Slots = { false, false, false }
    },
    SummerIndexData = {
        RewardClaimed = false,
        Discovered = {}
    },
    TideIndexData = {
        RewardClaimed = false,
        Discovered = {}
    },
    TendablePlants = {
        DEFAULT = {}
    },
    InfGrowPlants = {
        DEFAULT = {}
    },
    CookingKit = {
        DEFAULT = {}
    },
    TravelingHoneyMerchant = {
        SubmittedWeight = 0
    },
    GhoulGardenData = {
        HasPurchasedHalloweenPlant = false,
        HasSoldHalloweenPlant = false
    },
    EasterEventData = {
        HasSeenPopup = false,
        HasBeenGivenStarterPack = false,
        HasSoldEasterPlant = false,
        HasPurchasedEasterPlant = false,
        HasEnabledEasterGarden = false,
        HasBeenFed = false,
        SeedPackGiverDiscovered = false,
        Progression = 1,
        ProgressionSeedPacks = 0,
        CandyBlossomShardProgress = 0,
        TotalEasterPlaytime = 0,
        TotalTrackedPlaytime = 0,
        AwardedFinalReward = false,
        RequiredPlantInfo = {
            RequiredPlant = nil,
            RequiredPlantSize = nil,
            RequiredPlantVariant = nil,
            RequiredPlantMutation = nil
        },
        GoldenEgg = {
            LastBuyTime = 0,
            BuyAmount = 0
        },
        EvilBunnyData = {
            QuestState = "Idle",
            TargetPlantKey = nil,
            TargetPlantName = nil,
            PlantScore = nil,
            LastSacrificeTime = 0,
            TotalSacrifices = 0
        }
    },
    TeamEventData = {},
    DiggingData = {
        DataCycle = 0,
        DigComplete = false,
        GridSize = -1,
        NextDiggingGainTime = 0,
        RemainingDigs = DiggingConfigData.MAX_DIGS_AVALIABLE,
        TreasureData = {},
        GridData = {}
    },
    ChristmasEvent = {
        SubmissionPoints = 0,
        Advent = {
            CurrentQuestContainer = nil,
            QuestGeneration = 0,
            FinalRewardClaimed = nil,
            PendingRobuxClaimDay = nil,
            Days = {}
        },
        Gifting = {
            GiftsGiven = 0,
            SubmissionCycle = -1,
            ItemRewardsLockedOut = {},
            ItemRewardsReceived = {},
            FruitGiven = {}
        },
        ChristmasGlow = {
            CurrentScore = 0,
            LastClaimedThreshold = 0,
            ResetsPerformed = 0
        },
        GiftingV2 = {
            CurrentGift = nil,
            SubmissionPoints = 0,
            TotalGiftsClaimed = 0,
            LastClaimedCycle = 0,
            CurrentCycle = 0
        },
        ChristmasTree = {
            SubmissionPoints = 0,
            SubmissionRewardsClaimed = 0,
            LastSubmitTime = 0,
            TreeSize = 0,
            HighestClaimedBracket = 0,
            ClaimedTreeCount = 0,
            HasATree = false,
            RewardBracketsClaimed = {}
        }
    },
    HungryBirdsEvent = {
        CooldownTime = 0
    },
    ButtercupEvent = {
        Buttercup_Seeds = -1,
        EventActivated = false,
        Quests = {
            CurrentQuestContainer = nil,
            QuestGeneration = 0
        }
    },
    BlackButtercupEvent = {
        CurrentQuestIndex = 1,
        ButtercupsGiven = 0
    },
    ValentinesEvent = {
        Reward2PriceMultiplier = 1,
        Completed = { false, false, false, false, false },
        Completed2 = { false, false, false, false, false, false, false, false, false, false }
    },
    AdminQuest = nil,
    LevelData = {},
    ClaimedCodes = {
        FREE_PANDA_PET_UPDATE = false
    },
    SeedStocks = {},
    GearStock = {
        Gear = 0,
        ForcedGear = nil,
        ForcedGearEndTimestamp = nil,
        Stocks = {}
    },
    PetEggStock = {
        Egg = 0,
        ForcedEgg = nil,
        ForcedEggEndTimestamp = nil,
        Stocks = {}
    },
    CosmeticStock = {
        CosmeticSeed = 0,
        ForcedCosmetic = nil,
        ForcedCosmeticEndTimestamp = nil,
        PermanentPurchases = {},
        TabStocks = {}
    },
    BeeEggShopStock = {
        Egg = 0,
        ForcedEgg = nil,
        ForcedEggEndTimestamp = nil,
        Stocks = {}
    },
    EventShopStock = {},
    UnlockedEventShopItems = {},
    TravelingMerchantShopStock = {
        MerchantType = nil,
        MerchantStartTime = 0,
        Stocks = {},
        LifetimePurchases = {}
    },
    GardenCoinShopStock = {
        LastRefreshed = nil,
        LastTimePurchasedGardenCoin = nil,
        Stocks = {}
    },
    GardenCoinShopStats = {
        UnlockedGardenCoins = false,
        LifetimeGardenCoins = 0,
        LifetimePurchases = {}
    },
    DailyQuests = {
        Day = 0,
        ContainerId = "",
        RunStartDay = 0,
        DaysCompleted = 0,
        DailyRewards = {}
    },
    SeasonPassDailyQuests = {
        Day = 0,
        ContainerId = ""
    },
    SavedObjects = {},
    ExtraBackpackSize = 0,
    InventoryData = {},
    QuestContainers = {},
    BadgeData = {},
    AwardedBadges = {},
    PetsData = {
        PurchasedEquipSlots = 0,
        PurchasedEggSlots = 0,
        PurchasedPetInventorySlots = 0,
        PetPouchUses = 0,
        SelectedPetLoadout = 1,
        MaxLoadoutSlots = 3,
        MutableStats = {
            MaxEquippedPets = 3,
            MaxPetsInInventory = 60,
            MaxEggsInFarm = 3
        },
        EquippedPets = {},
        PetInventory = {
            Counter = 0,
            Data = {}
        },
        PetLoadouts = { {}, {}, {}, {}, {}, {} },
        PetLoadoutNames = { "", "", "", "", "", "" },
        LastLoadedPetLoadout = {},
        PetIncubatorData = {
            IncubatorData = {}
        },
        PetEggIncubatorData = {
            IncubatorData = {}
        }
    },
    InfinitePack = {
        Depth = 0,
        Day = 0
    },
    InfinitePack_AdRewards1 = {
        Depth = 1,
        Day = 1
    },
    InfinitePack_AdRewards2 = {
        Depth = 0,
        Day = 0
    },
    AdRewardsWateringCanProgress = {
        Depth = 0,
        Day = 0
    },
    EventInfinitePack = {},
    StarterPack = {
        Started = false,
        ContainerId = nil,
        Timer = nil,
        ShowTimer = nil
    },
    TotalRobuxSpent = 0,
    TotalTokensSpent = 0,
    Transactions = {},
    ItemGiftHistory = {
        Plants = {},
        Pets = {}
    },
    Gifts = {
        Inventory = {},
        History = {
            Sent = {},
            Received = {}
        }
    },
    Settings = {
        Textures = SettingsRegistry.Textures.SettingsData.DefaultValue,
        FavoriteIcons = SettingsRegistry.FavoriteIcons.SettingsData.DefaultValue,
        VisualEffects = SettingsRegistry.VisualEffects.SettingsData.DefaultValue,
        GearShopButton = SettingsRegistry.GearShopButton.SettingsData.DefaultValue,
        PetShopButton = SettingsRegistry.PetShopButton.SettingsData.DefaultValue,
        RecieveGifts = SettingsRegistry.RecieveGifts.SettingsData.DefaultValue,
        PetUpdateRate = SettingsRegistry.PetUpdateRate.SettingsData.DefaultValue,
        PlantableCollisions = SettingsRegistry.PlantableCollisions.SettingsData.DefaultValue,
        UIScale = SettingsRegistry.UIScale.SettingsData.DefaultValue,
        TradeRequests = SettingsRegistry.TradeRequests.SettingsData.DefaultValue,
        Tips = SettingsRegistry.Tips.SettingsData.DefaultValue,
        AutoCloseActivePetsUI = SettingsRegistry.AutoCloseActivePetsUI.SettingsData.DefaultValue,
        CropMutationVFX = SettingsRegistry.CropMutationVFX.SettingsData.DefaultValue,
        PetMutationVFX = SettingsRegistry.PetMutationVFX.SettingsData.DefaultValue,
        PetScaling = SettingsRegistry.PetScaling.SettingsData.DefaultValue,
        HeldPetScaling = SettingsRegistry.HeldPetScaling.SettingsData.DefaultValue,
        HeldFruitScaling = SettingsRegistry.HeldFruitScaling.SettingsData.DefaultValue,
        KeepPetOnGround = SettingsRegistry.KeepPetOnGround.SettingsData.DefaultValue,
        LowerPlantFXQuality = SettingsRegistry.LowerPlantFXQuality.SettingsData.DefaultValue,
        PerformanceMode = SettingsRegistry.PerformanceMode.SettingsData.DefaultValue,
        ToggleNotifications = SettingsRegistry.ToggleNotifications.SettingsData.DefaultValue,
        PetNotifications = SettingsRegistry.PetNotifications.SettingsData.DefaultValue,
        PlantPassiveNotifications = SettingsRegistry.PlantPassiveNotifications.SettingsData.DefaultValue,
        OtherPlayerBeeColonyVisibility = SettingsRegistry.OtherPlayerBeeColonyVisibility.SettingsData.DefaultValue,
        BeeColonyFollowPlayer = SettingsRegistry.BeeColonyFollowPlayer.SettingsData.DefaultValue
    },
    DefaultSettingsAlreadySet = {},
    CosmeticData = {
        Inventory = {},
        Pool = {},
        MutableStats = {
            MaxEquippedCosmetics = 0,
            MaxCosmeticsInInventory = 0,
            MaxCratesInFarm = 0,
            BonusCosmeticInventorySlots = 0
        },
        Equipped = {}
    },
    ExpansionsData = {
        CanSeeExpansions = false,
        Unlocked = {},
        ExpansionTimers = {}
    },
    PlayerFlags = {
        ResetCosmetic = false,
        ResetStats = false,
        ClampedCosmeticInventoryOverflow = false,
        RestoredCosmeticInventoryBonus = false,
        LogAllRemoteCalls = false,
        HasDuplicatedPets = nil,
        GotGreenbeanTools = nil,
        PrunedRecipesUsedIn = nil,
        ReturnedGardenCoinPurchases = false
    },
    AB_FTUELuckBoost_Timer = nil,
    PlayedEggTutorial = false,
    GardenLikes = {
        Likes = 0,
        LikedBy = {},
        LikedGardens = {}
    },
    PetMutationMachine = {
        SubmittedPet = nil,
        TimeLeft = 0,
        IsRunning = false,
        PetReady = false
    },
    PetAgeBreakMachine = {
        SubmittedPet = nil,
        TimeLeft = 0,
        IsRunning = false,
        PetReady = false
    },
    SamTheClam = {
        SubmittedPet = nil,
        Reward = nil,
        TimeLeft = 0,
        IsRunning = false,
        RewardReady = false,
        DimaUpgradeLevel = 0,
        DimaProgress = 0
    },
    UnlockedRecipes = {},
    ShovelSkinData = {
        Equipped = "",
        OwnedShovels = {}
    },
    CraftingData = {
        GlobalCraftingObjectData = {}
    },
    InventorySortData = {},
    HotbarData = {},
    SaveSlots = {
        SelectedSlot = "DEFAULT",
        UnlockedBefore = false,
        AllSlots = {
            DEFAULT = {
                SlotName = "Save Slot #1",
                SelectedFenceSkin = "DEFAULT",
                LastLoaded = os.time(),
                LastSaveTime = os.time(),
                PlantedObjects = {},
                SavedObjects = {},
                EquippedCosmetics = {}
            }
        }
    },
    BoxingMachineData = {
        BoxingMachines = {}
    },
    JellyCrafting = {
        StoredItem = nil,
        StartTime = 0
    },
    TradeHistory = {
        Shard = 1,
        RecentTrades = {}
    },
    BoothHistory = {
        Shard = 1,
        RecentTransactions = {}
    },
    TradeData = {
        Tokens = 0,
        ViewInventoryPermission = "Everyone",
        TradeRequestPermission = "Everyone",
        UnfairTradeWarning = true,
        Pin = {
            Pin = nil,
            Recovery = nil,
            Disable = {
                Attempts = 3,
                LastReset = 0
            },
            Match = {
                Attempts = 3,
                LastReset = 0
            }
        },
        Listings = {},
        TradeLocks = {},
        TokenAmounts = {
            All = DeepCopy(TradeTokenData.TokenAmountsTemplate)
        },
        RecentlyViewedListingIds = {}
    },
    Pity = {},
    PunnishmentData = {
        Warnings = {}
    },
    FenceSkinData = {
        OwnedFences = {}
    },
    TradeBoothSkinData = {
        CurrentSkin = nil,
        OwnedSkins = {}
    },
    Achievements = {
        Seasons = {}
    },
    RaccoonSteals = {},
    GiftHatchEggAttempts = 0,
    ArbitraryFTUEData = {
        AcknowledgedBackpack = false
    },
    GiveawayData = {},
    PermanentGears = {},
    PlayerGiftCooldown = {},
    GearUseData = {
        ChristmasStockingsTutorialCompleted = false,
        WonderWaterTutorialCompleted = false,
        SnowGlobe = {
            TimesUsed = 0,
            CurrentChance = 0,
            FirstUsed = 0
        },
        ChristmasStockings = {}
    },
    BurntPlants = 0,
    CandyBlossomCraftingProgress = {
        Eggs = 0,
        ["Candy Blossom Shard"] = 0,
        CRAFTS_COMPLETED = 0
    },
    UpgraderMigrations = {},
    BeeEventData = {
        HasSeenPopup = false,
        HasSeenPopupPart2 = false,
        HasSeenEndPopup = false,
        HasEnabledHoneyGarden = false,
        HasReceivedStarterBeeEgg = false,
        HasReceivedStarterCrop = false,
        HasPlacedFirstBeeEgg = false,
        HasFirstHatchedBee = false,
        HasSubmittedToHoneyMachine = false,
        HasCollectedHoney = false,
        HasFirstCompressed = false,
        HasPurchasedFirstUpgrade = false,
        HasPurchasedFirstBeeEgg = false,
        AwardedFinalReward = false,
        BeeInventoryData = {},
        BeeSkillTree = {},
        HoneyIncubatorData = {
            StartTime = 0,
            Accelerations = 0,
            CurrentSeed = "",
            Running = false,
            Claimable = false
        },
        WaspWaveSurvival = {
            LastStartedAt = 0,
            BestWave = 0,
            TotalRuns = 0,
            TotalWavesCleared = 0
        }
    },
    AngryPlantEventData = {
        CurrentLevel = 1,
        CheckpointProgress = 0,
        SeenIntro = false,
        RequiredPlantInfo = {
            RequiredPlant = nil,
            RequiredPlantSize = nil,
            RequiredPlantVariant = nil,
            RequiredPlantMutation = nil
        }
    },
    HalloweenHungryData = {
        CurrentLevel = 1,
        CheckpointProgress = 0,
        ProgressVersion = 1,
        Submitted = {}
    },
    LunarGlowEventData = {
        Experience = 0,
        ClaimedRewardIndices = {}
    },
    PrehistoricEventData = {
        TimeLeft = 0,
        IsRunning = false,
        RewardReady = false,
        RewardType = nil,
        RewardName = nil,
        RewardAmount = nil,
        SubmittedPetValue = 0,
        SubmittedPet = nil,
        PlantWeight = 0,
        CurrentMachineLevel = 0,
        DinoQuests = {
            Id = 0,
            Containers = {},
            Milestone = {
                Progress = 0,
                Claimed = {},
                Completed = {}
            }
        },
        SubmittedPlants = {}
    },
    ZenEventData = {
        TranquilLevel = 0,
        CorruptionLevel = 0,
        CorruptionZenSpawn = 0,
        CurrentQuest = nil,
        ZenTree = {
            SubmittedPlantsValue = 0,
            CurrentTreeLevel = 0
        }
    },
    CookingPot = {
        CookingEndTime = nil,
        FinishedFoodRawData = nil,
        IsCooking = false,
        CookTimeTotal = 0,
        BestRecipe = nil,
        MutationChance = 0,
        WaterColor = nil,
        SubmittedIngredients = {}
    },
    KitchenStormEventData = {
        StormPoints = 0
    },
    FoodConnoisseurEventData = {
        PendingRewards = {}
    },
    BeanstalkEvent = {
        ClaimedRewards = 0,
        LastRewardClaimedTime = 0,
        EventsContributed = 0,
        LastBeanStalkTime = 0
    },
    GoldCauldronData = {
        Weight = 0,
        GoalWeight = 0,
        CooldownEndsAt = 0,
        CooldownTotal = 0
    },
    BasketDeliveryData = {
        Index = 1,
        Runs = 0,
        PendingRewards = {}
    },
    FallMarket = {
        EventsContributed = 0,
        LastRewardClaimedTime = 0,
        ActivitiesCompleted = 0,
        LastActivityCycleCompleted = 0,
        CanClaimFinalReward = true,
        FallEnergy = 0,
        LastFallEnergyRewardClaimed = 0,
        FallEnergyRewardClaimable = false,
        FallQuests = {
            Rerolled = 0,
            Day = 0,
            Containers = {}
        }
    },
    ShadyScarecrowData = {
        LastSubmitTime = 0,
        TotalSubmissions = 0,
        PendingReward = nil
    },
    FallMarketIndexData = {
        RewardClaimed = false,
        RewardReadyNotified = false,
        Discovered = {}
    },
    HalloweenEventData = {
        WitchesBrew = {
            ContributionValue = 0,
            LastRewardTime = 0,
            ContributionCycle = 0,
            SubmittedCauldronItems = {}
        },
        HalloweenMarket = {
            HadFirstRestock = false
        },
        DeadTree = {
            LastQuestGenerationCycle = 0,
            LastClaimCycle = 0,
            WeepingSeedBonusChance = 0,
            QuestContainers = {}
        },
        HarvestReaper = {
            LastClaimCycle = 0,
            RobuxBowlFillsPending = 0
        }
    },
    FairyEvent = {
        LastSaveTime = nil,
        LastFairyEvent = nil,
        ExtendedTime = nil,
        LooseFairies = nil,
        FairyWorldParkour = nil,
        GuaranteedLuminous = 0,
        FairiesCapturedWithNetV1 = 0,
        FairiesCapturedWithNetV2 = 0,
        EnchantedChestsClaimed = 0,
        SubmittedFairyJars = 0,
        Upgrades = {},
        FairyQuests = {
            QuestsVersion = 0,
            Day = 0,
            CompletionSource = nil,
            WishLevel = 0,
            RerollsUsed = 0,
            TrackCompleted = false,
            FairyFountainProgressActual = 0,
            FairyFountainProgressVisual = 0,
            FairyFountainProgressTarget = 0,
            Containers = {},
            PendingRewards = {}
        }
    },
    SafariEvent = {
        ContibutedPoints = 0,
        TotalRewardsClaimed = 0,
        IndivdualRewardPoints = 0,
        V1Contributions = 0,
        Version = 0,
        ItemRewardsReceived = {},
        ItemRewardsLockedOut = {}
    },
    SmithingEventData = {
        SubmittedGear = false,
        SubmittedFruit = false,
        SubmittedPet = false,
        StoredValue = 0
    },
    ChipmunkEvent = {
        ChipmunkID = nil,
        SubmissionScore = 0,
        WeightTiersClaimed = {}
    },
    TraderEventData = {
        LastClaimedCycle = 0,
        StreakEndTime = 0,
        CurrentStreak = 0,
        MaxStreak = 0
    },
    SummerFireEventData = {
        HasSeenPopup = false,
        CurrentLevel = 0,
        CurrentMutation = "Wet",
        InfernoShardProgress = 0,
        ShardSlots = { false, false, false, false }
    },
    HarvestMoonData = {
        SummonsContributed = 0
    },
    HarvestMoonOwlData = {
        Points = 0,
        Trait = "",
        RequiredMutation = "",
        CooldownEndsAt = 0,
        TraitExpiresAt = 0
    },
    HarvestMoonQuestData = {
        Period = -1,
        ContainerId = "",
        SkipSalt = 0,
        Points = 0,
        ClaimedTiers = {},
        AwardedQuests = {}
    },
    HarvestMoonIndexData = {
        RewardClaimed = false,
        RewardReadyNotified = false,
        Discovered = {}
    },
    MoonCraftingData = {
        InputItems = {},
        CraftingItems = {}
    },
    HarvestMoonPet = {
        SubmittedPet = nil,
        StoredPetType = nil,
        StoredPetRarity = nil,
        StartTime = 0
    }
};