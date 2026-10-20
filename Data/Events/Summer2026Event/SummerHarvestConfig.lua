-- Decompiled with Potassium's decompiler.

return {
    HARVEST_DURATION = 600,
    HARVEST_INTERVAL = 3600,
    HARVEST_WEATHER = "HighTide",
    HARVEST_WEATHER_DURATION = 600,
    MEGA_HARVEST_CHANCE = 3,
    COINS_PER_1000_POINTS = 1,
    MEGA_HARVEST_MULTIPLIER = 2,
    REWARD_CYCLE_INTERVAL = 5,
    START_EVENT_ON_LATE_JOIN = true,
    TRAIT_WARNING = "Thats not a Summer [TRAIT] OR Tidal [MUTATED] plant!",
    REWARD_SIGN_THRESHOLDS = { {
            Points = 20000,
            Label = "TRANSCENDENT REWARDS"
        }, {
            Points = 14000,
            Label = "PRISMATIC REWARDS"
        }, {
            Points = 11000,
            Label = "DIVINE REWARDS"
        }, {
            Points = 8500,
            Label = "MYTHICAL REWARDS"
        }, {
            Points = 5000,
            Label = "LEGENDARY REWARDS"
        }, {
            Points = 2000,
            Label = "RARE REWARDS"
        }, {
            Points = 500,
            Label = "UNCOMMON REWARDS"
        }, {
            Points = 10,
            Label = "COMMON REWARDS"
        } },
    RARITY_VALUES = {
        Common = 1,
        Uncommon = 2,
        Rare = 3,
        Legendary = 4,
        Mythical = 5,
        Divine = 6,
        Prismatic = 7,
        Transcendent = 8
    },
    VARIANT_VALUES = {
        Normal = 0,
        Silver = 1,
        Gold = 2,
        Rainbow = 3,
        Diamond = 3,
        Jelly = 3,
        Ember = 3
    },
    ACCEPTED_TRAITS = { "Summer" },
    ACCEPTED_MUTATIONS = { "Tidal" },
    RewardData = {
        {
            ItemName = "Watering Can",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 2,
            SummerPointsRequired = 10,
            Display = true
        },
        {
            ItemName = "Sheckles",
            ItemType = "Currency",
            ItemAmount = 5000,
            SummerPointsRequired = 50,
            Display = true
        },
        {
            ItemName = "Basic Sprinkler",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 2,
            SummerPointsRequired = 100,
            Display = true
        },
        {
            ItemName = "Recall Wrench",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 2,
            SummerPointsRequired = 120,
            Display = true
        },
        {
            ItemName = "Favorite Tool",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 2,
            SummerPointsRequired = 200,
            Display = true
        },
        {
            ItemName = "Cleaning Spray",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 2,
            SummerPointsRequired = 250,
            Display = true
        },
        {
            ItemName = "Normal",
            ItemPlayerFacingName = "Normal Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 1,
            SummerPointsRequired = 300,
            Display = true
        },
        {
            ItemName = "Coastal Crate",
            ItemType = "Crate",
            ItemAmount = 1,
            Chance = 5,
            SummerPointsRequired = 350,
            Display = true
        },
        {
            ItemName = "Lightning Rod",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 24,
            SummerPointsRequired = 400,
            Display = true
        },
        {
            ItemName = "Castle Crocus",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 10,
            SummerPointsRequired = 800,
            Display = true
        },
        {
            ItemName = "Beach Crate",
            ItemType = "Crate",
            ItemAmount = 1,
            Chance = 5,
            SummerPointsRequired = 1000,
            Display = true
        },
        {
            ItemName = "Harvest Tool",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 3,
            SummerPointsRequired = 1200,
            Display = true
        },
        {
            ItemName = "Flower Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 5,
            SummerPointsRequired = 1600,
            Display = true
        },
        {
            ItemName = "Gardener Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 3,
            SummerPointsRequired = 1900,
            Display = true
        },
        {
            ItemName = "Watermelon",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 10,
            SummerPointsRequired = 2000,
            Display = true
        },
        {
            ItemName = "Rafflesia",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 7,
            SummerPointsRequired = 2000,
            Display = true
        },
        {
            ItemName = "Summer Fun Crate",
            ItemType = "Crate",
            ItemAmount = 1,
            Chance = 3,
            SummerPointsRequired = 2400,
            Display = true
        },
        {
            ItemName = "Sun Bloom",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 6,
            SummerPointsRequired = 3400,
            Display = true
        },
        {
            ItemName = "Safari Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 2,
            SummerPointsRequired = 3600,
            Display = true
        },
        {
            ItemName = "Rare Egg",
            ItemType = "Egg",
            ItemAmount = 1,
            Chance = 5,
            SummerPointsRequired = 3800,
            Display = true
        },
        {
            ItemName = "Coastal Egg",
            ItemType = "Egg",
            ItemAmount = 1,
            Chance = 8,
            SummerPointsRequired = 4000,
            Display = true
        },
        {
            ItemName = "Nectarine",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 15,
            SummerPointsRequired = 4200,
            Display = true
        },
        {
            ItemName = "Delphinium",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 10,
            SummerPointsRequired = 4400,
            Display = true
        },
        {
            ItemName = "Gourmet Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 3,
            SummerPointsRequired = 4600,
            Display = true
        },
        {
            ItemName = "Reclaimer",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 9,
            SummerPointsRequired = 4800,
            Display = true
        },
        {
            ItemName = "Coastal Crate",
            ItemType = "Crate",
            ItemAmount = 1,
            Chance = 5,
            SummerPointsRequired = 5000,
            Display = true
        },
        {
            ItemName = "Tidal Crate",
            ItemType = "Crate",
            ItemAmount = 1,
            Chance = 8,
            SummerPointsRequired = 7500,
            Week2 = true,
            Display = true
        },
        {
            ItemName = "Coastal Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 3,
            SummerPointsRequired = 3000,
            Week2 = true,
            Display = true
        },
        {
            ItemName = "Buttercup Chest",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 7,
            SummerPointsRequired = 6000,
            Week2 = true,
            Display = true
        },
        {
            ItemName = "Summer Splash Sprinkler",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 7,
            SummerPointsRequired = 9000,
            Week2 = true,
            Display = true
        },
        {
            ItemName = "Enchanted Seed Pack",
            ItemType = "Seed Pack",
            ItemAmount = 1,
            Chance = 9,
            SummerPointsRequired = 5200,
            Display = true
        },
        {
            ItemName = "Lily of the Valley",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 10,
            SummerPointsRequired = 5500,
            Display = true
        },
        {
            ItemName = "Godly Sprinkler",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 5,
            SummerPointsRequired = 5800,
            Display = true
        },
        {
            ItemName = "Rare Summer Egg",
            ItemType = "Egg",
            ItemAmount = 1,
            Chance = 15,
            SummerPointsRequired = 6000,
            Display = true
        },
        {
            ItemName = "Master Sprinkler",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 10,
            SummerPointsRequired = 6200,
            Display = true
        },
        {
            ItemName = "Oasis Crate",
            ItemType = "Crate",
            ItemAmount = 1,
            Chance = 8,
            SummerPointsRequired = 6500,
            Display = true
        },
        {
            ItemName = "Gnome",
            ItemType = "Pet",
            ItemAmount = 1,
            Chance = 15,
            SummerPointsRequired = 6800,
            Display = true
        },
        {
            ItemName = "Sun Bloom",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 18,
            SummerPointsRequired = 7000,
            Display = true
        },
        {
            ItemName = "Popsicle Melt",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 22,
            SummerPointsRequired = 7200,
            Display = true
        },
        {
            ItemName = "Coastal Egg",
            ItemType = "Egg",
            ItemAmount = 1,
            Chance = 9,
            SummerPointsRequired = 7500,
            Display = true
        },
        {
            ItemName = "Bug Egg",
            ItemType = "Egg",
            ItemAmount = 1,
            Chance = 14,
            SummerPointsRequired = 8000,
            Display = true
        },
        {
            ItemName = "Hamster",
            ItemType = "Pet",
            ItemAmount = 1,
            Chance = 10,
            SummerPointsRequired = 11000,
            Display = true
        },
        {
            ItemName = "Beach Ball Palm",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 20,
            SummerPointsRequired = 12000,
            Display = true
        },
        {
            ItemName = "Levelup Lollipop",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 30,
            SummerPointsRequired = 14000,
            Display = true
        },
        {
            ItemName = "Jungle Egg",
            ItemType = "Egg",
            ItemAmount = 1,
            Chance = 20,
            SummerPointsRequired = 16000,
            Display = true
        },
        {
            ItemName = "Grandmaster Sprinkler",
            ItemType = "Gear",
            ItemAmount = 1,
            Chance = 70,
            SummerPointsRequired = 18000,
            Display = true
        },
        {
            ItemName = "Octobloom",
            ItemType = "Seed",
            ItemAmount = 1,
            Chance = 100,
            SummerPointsRequired = 20000,
            Display = true
        }
    }
};