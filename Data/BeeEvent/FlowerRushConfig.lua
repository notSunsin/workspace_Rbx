-- Decompiled with Potassium's decompiler.

return {
    ENABLED = true,
    START_EPOCH = -1,
    END_EPOCH = 0,
    MIN_DELAY = 600,
    MAX_DELAY = 900,
    DEV_MIN_DELAY = 20,
    DEV_MAX_DELAY = 45,
    SPAWN_MARGIN = 4,
    RANDOM_YAW = true,
    PROMPT_AMOUNT = 0.25,
    PROMPT_COOLDOWN = 0.12,
    PROMPT_MAX_DISTANCE = 16,
    MIN_CONTRIBUTION = 0,
    BEE_ASSIGN_RANGE = 50,
    BEE_RATE_MULTIPLIER = 1,
    BEE_ORBIT_RADIUS = 5,
    BEE_ORBIT_PER_BEE = 0.4,
    BEE_ORBIT_HEIGHT = 5,
    BEE_ORBIT_SPEED = 1.5,
    BEE_ARRIVE_DISTANCE = 4,
    PROGRESS_SYNC_RATE = 0.2,
    HIT_VFX_INTERVAL = 0.35,
    JIGGLE_TILT_DEG = 7,
    JIGGLE_POP = 0.35,
    JIGGLE_FREQUENCY = 14,
    JIGGLE_DECAY = 7,
    JIGGLE_DURATION = 0.6,
    FIRE_DROP_DELAY = 0.35,
    FIRE_DROP_HEIGHT = 2,
    REWARD_DROP_FLIGHT_TIME = 0.5,
    SPAWN_VFX_TIME = 2.5,
    FINAL_HIT_TIME = 1.5,
    WILT_FADE_TIME = 1,
    REVEAL_HIGHLIGHT_COLOR = { 255, 230, 120 },
    REVEAL_HIGHLIGHT_FILL = 0.6,
    REVEAL_HIGHLIGHT_TIME = 8,
    TITLE_FORMAT = "NAME - TIME",
    PROGRESS_TEXT = "CURRENT / MAX",
    PROGRESS_BAR_COLOR = { 255, 210, 60 },
    MSG_SPAWNED = "A [NAME] has bloomed! [Pollinate] it with your bees before it wilts!",
    MSG_SUCCESS = "The [NAME] was successfully [pollinated]!",
    MSG_RECEIVED = "You received QUANTITY REWARD!",
    MSG_WILTED = "The [NAME] wilted...",
    NOTIFICATION_COLOR = { 255, 255, 255 },
    NOTIFICATION_HIGHLIGHT_COLOR = { 255, 200, 40 },
    RARITY_COLORS = {
        Prismatic = "RAINBOW",
        Rare = { 0, 85, 255 },
        Legendary = { 255, 255, 0 },
        Mythical = { 187, 0, 255 },
        Divine = { 255, 85, 0 }
    },
    FLOWER_TYPES = {
        {
            Name = "Flower1",
            DisplayName = "Sunny Lily",
            Rarity = "Rare",
            Model = "Flower1",
            Weight = 42,
            MaxProgress = 500,
            TimeLimit = 180,
            Rewards = { {
                    Value = "HoneyCoins",
                    Display = "Honey Coins",
                    Quantity = 20,
                    Type = "Currency",
                    Weight = 10
                }, {
                    Value = "RoyalJelly",
                    Display = "Royal Jelly",
                    Quantity = 5,
                    Type = "Currency",
                    Weight = 10
                }, {
                    Value = "Common Bee Egg",
                    Display = "Common Bee Egg",
                    Quantity = 1,
                    Type = "Bee Egg",
                    Weight = 10
                }, {
                    Value = "Hive Crate",
                    Display = "Hive Crate",
                    Quantity = 1,
                    Type = "Crate",
                    Weight = 10
                }, {
                    Value = "Pollen Radar 2026",
                    Display = "Pollen Radar 2026",
                    Quantity = 1,
                    Type = "Gear",
                    Weight = 10
                } }
        },
        {
            Name = "Flower2",
            DisplayName = "Honey Lily",
            Rarity = "Legendary",
            Model = "Flower2",
            Weight = 11,
            MaxProgress = 1000,
            TimeLimit = 180,
            Rewards = { {
                    Value = "HoneyCoins",
                    Display = "Honey Coins",
                    Quantity = 40,
                    Type = "Currency",
                    Weight = 10
                }, {
                    Value = "RoyalJelly",
                    Display = "Royal Jelly",
                    Quantity = 12,
                    Type = "Currency",
                    Weight = 10
                }, {
                    Value = "Hive Egg",
                    Display = "Hive Egg",
                    Quantity = 1,
                    Type = "Egg",
                    Weight = 10
                }, {
                    Value = "Hive Crate",
                    Display = "Hive Crate",
                    Quantity = 2,
                    Type = "Crate",
                    Weight = 10
                }, {
                    Value = "Honey Hive Seed Pack",
                    Display = "Honey Hive Seed Pack",
                    Quantity = 1,
                    Type = "Seed Pack",
                    Weight = 10
                }, {
                    Value = "Honey Trough",
                    Display = "Honey Trough",
                    Quantity = 1,
                    Type = "Cosmetic",
                    Weight = 10
                } }
        },
        {
            Name = "Flower3",
            DisplayName = "Royal Lily",
            Rarity = "Mythical",
            Model = "Flower3",
            Weight = 5,
            MaxProgress = 1750,
            TimeLimit = 180,
            Rewards = { {
                    Value = "RoyalJelly",
                    Display = "Royal Jelly",
                    Quantity = 35,
                    Type = "Currency",
                    Weight = 10
                }, {
                    Value = "Rare Bee Egg",
                    Display = "Rare Bee Egg",
                    Quantity = 1,
                    Type = "Bee Egg",
                    Weight = 10
                }, {
                    Value = "Honey Table",
                    Display = "Honey Table",
                    Quantity = 1,
                    Type = "Cosmetic",
                    Weight = 10
                }, {
                    Value = "Honey Hive Seed Pack",
                    Display = "Honey Hive Seed Pack",
                    Quantity = 1,
                    Type = "Seed Pack",
                    Weight = 10
                }, {
                    Value = "Honey Birds of Paradise",
                    Display = "Honey Birds of Paradise Seed",
                    Quantity = 1,
                    Type = "Seed",
                    Weight = 10
                } }
        },
        {
            Name = "Flower4",
            DisplayName = "Silver Lily",
            Rarity = "Divine",
            Model = "Flower4",
            Weight = 1.4,
            MaxProgress = 2500,
            TimeLimit = 180,
            Rewards = { {
                    Value = "RoyalJelly",
                    Display = "Royal Jelly",
                    Quantity = 50,
                    Type = "Currency",
                    Weight = 10
                }, {
                    Value = "Mythical Bee Egg",
                    Display = "Mythical Bee Egg",
                    Quantity = 1,
                    Type = "Bee Egg",
                    Weight = 10
                }, {
                    Value = "Honey Hive Seed Pack",
                    Display = "Honey Hive Seed Pack",
                    Quantity = 2,
                    Type = "Seed Pack",
                    Weight = 10
                }, {
                    Value = "Honey Umbrella",
                    Display = "Honey Umbrella",
                    Quantity = 1,
                    Type = "Cosmetic",
                    Weight = 10
                } }
        },
        {
            Name = "Flower5",
            DisplayName = "Golden Lily",
            Rarity = "Prismatic",
            Model = "Flower5",
            Weight = 0.6,
            MaxProgress = 3500,
            TimeLimit = 180,
            Rewards = { {
                    Value = "RoyalJelly",
                    Display = "Royal Jelly",
                    Quantity = 100,
                    Type = "Currency",
                    RainbowInterface = true,
                    Weight = 10
                }, {
                    Value = "Transcendent Bee Egg",
                    Display = "Transcendent Bee Egg",
                    Quantity = 1,
                    Type = "Bee Egg",
                    RainbowInterface = true,
                    Weight = 10
                }, {
                    Value = "Royal Jelly Cup",
                    Display = "Royal Jelly Cup Seed",
                    Quantity = 1,
                    Type = "Seed",
                    RainbowInterface = true,
                    Weight = 10
                }, {
                    Value = "Honey Hive Seed Pack",
                    Display = "Honey Hive Seed Pack",
                    Quantity = 3,
                    Type = "Seed Pack",
                    RainbowInterface = true,
                    Weight = 10
                } }
        }
    }
};