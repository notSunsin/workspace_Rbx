-- Decompiled with Potassium's decompiler.

return {
    ENABLED = true,
    START_EPOCH = 1784406600,
    HUNT_DURATION = 180,
    HUNT_INTERVAL = 3600,
    HUNT_OFFSET = 1800,
    CHEST_COUNT = 5,
    CARRY_CAPACITY = 1,
    CARRY_HEIGHT_OFFSET = -0.75,
    TELEPORT_PICKUP_GRACE = 1,
    REVEAL_DELAY = 10,
    REWARD_CYCLE_INTERVAL = 5,
    CarrySpeedPenalties = {
        Rare = 2,
        Legendary = 4,
        Mythical = 6,
        Divine = 8
    },
    GlobalRewardRarities = {
        Rare = 39,
        Legendary = 15,
        Mythical = 5,
        Divine = 1
    },
    TierIcons = {
        Rare = "rbxassetid://95916103020252",
        Legendary = "rbxassetid://121825788501508",
        Mythical = "rbxassetid://119745755966208",
        Divine = "rbxassetid://108273051543225"
    },
    GlobalRewards = {
        Rare = { {
                Value = "TideTokens",
                Display = "Tide Token",
                Quantity = 10,
                Type = "Currency"
            }, {
                Value = "Tidal Crate",
                Display = "Tidal Crate",
                Quantity = 1,
                Type = "Crate"
            }, {
                Value = "Summer Splash Sprinkler",
                Display = "Summer Splash Sprinkler",
                Quantity = 1,
                Type = "Gear"
            }, {
                Value = "Coastal Seed Pack",
                Display = "Coastal Seed Pack",
                Quantity = 1,
                Type = "Seed Pack"
            }, {
                Value = "Coastal Egg",
                Display = "Coastal Egg",
                Quantity = 1,
                Type = "Egg"
            } },
        Legendary = { {
                Value = "TideTokens",
                Display = "Tide Token",
                Quantity = 20,
                Type = "Currency"
            }, {
                Value = "Summer Splash Sprinkler",
                Display = "Summer Splash Sprinkler",
                Quantity = 2,
                Type = "Gear",
                RainbowInterface = true
            }, {
                Value = "Coastal Seed Pack",
                Display = "Coastal Seed Pack",
                Quantity = 2,
                Type = "Seed Pack"
            }, {
                Value = "Coastal Egg",
                Display = "Coastal Egg",
                Quantity = 2,
                Type = "Egg"
            } },
        Mythical = { {
                Value = "TideTokens",
                Display = "Tide Token",
                Quantity = 50,
                Type = "Currency",
                RainbowInterface = true
            }, {
                Value = "Jellyfish",
                Display = "Jellyfish",
                Quantity = 1,
                Type = "Pet",
                RainbowInterface = true
            }, {
                Value = "Seaspray Grass",
                Display = "Seaspray Grass",
                Quantity = 1,
                Type = "Seed",
                RainbowInterface = true
            }, {
                Value = "Coastal Egg",
                Display = "Coastal Egg",
                Quantity = 4,
                Type = "Egg"
            } },
        Divine = { {
                Value = "Coastal Seed Pack",
                Display = "Coastal Seed Pack",
                Quantity = 6,
                Type = "Seed Pack",
                RainbowInterface = true
            }, {
                Value = "Coastal Egg",
                Display = "Coastal Egg",
                Quantity = 10,
                Type = "Egg",
                RainbowInterface = true
            }, {
                Value = "Gilded Grove",
                Display = "Gilded Grove",
                Quantity = 1,
                Type = "Seed",
                RainbowInterface = true
            } }
    }
};