-- Decompiled with Potassium's decompiler.

return {
    ClockworkWindup = {
        Name = "ClockworkWindup",
        Type = "Active",
        Interval = 30,
        TargetCount = 2,
        Duration = 10,
        EffectColor = Color3.fromRGB(135, 88, 45),
        Effects = {
            Speed = 20
        }
    },
    BabyHatchBoost = {
        Name = "BabyHatchBoost",
        Type = "PlayerAttribute",
        Attribute = "BeeSwarmHatchSpeedMultiplier",
        Value = 1.5
    },
    MerchantHoneyCoinBonus = {
        Name = "MerchantHoneyCoinBonus",
        Type = "PlayerAttribute",
        Attribute = "BeeSwarmHoneyCoinMultiplier",
        Value = 1.1
    },
    TreasureQualityUpgrade = {
        Name = "TreasureQualityUpgrade",
        Type = "PlayerAttribute",
        Attribute = "BeeSwarmPollinatedPlantQualityUpgradeChance",
        Value = 0.1
    },
    PrincessRoyalBlessing = {
        Name = "PrincessRoyalBlessing",
        Type = "Active",
        Interval = 60,
        TargetMode = "HighestRarity",
        TargetCount = 1,
        Duration = 15,
        EffectColor = Color3.fromRGB(255, 105, 180),
        Effects = {
            PollinationQuality = 4
        }
    },
    JesterFoolishBlessing = {
        Name = "JesterFoolishBlessing",
        Type = "Active",
        Interval = 60,
        TargetMode = "LowestRarity",
        TargetCount = 1,
        Duration = 15,
        EffectColor = Color3.fromRGB(80, 255, 120),
        Effects = {
            PollinationQuality = 4
        }
    },
    IllusionCopy = {
        Name = "IllusionCopy",
        Type = "Active",
        Interval = 60,
        Duration = 20,
        EffectColor = Color3.fromRGB(220, 220, 255)
    },
    PanicMode = {
        Name = "PanicMode",
        Type = "Active",
        Interval = 60,
        Duration = 10,
        EffectColor = Color3.fromRGB(255, 80, 80),
        Effects = {
            SpeedMultiplier = 6,
            PollinationQualityMultiplier = 6,
            PollinationRateMultiplier = 6
        }
    },
    NecromancerSummon = {
        Name = "NecromancerSummon",
        Type = "Active",
        Interval = 80,
        Duration = 20,
        SummonCount = 3,
        SummonBeeName = "Skeleton Bee",
        EffectColor = Color3.fromRGB(150, 255, 190)
    },
    ChaosSurge = {
        Name = "ChaosSurge",
        Type = "Active",
        Interval = 60,
        TargetCount = 3,
        Duration = 15,
        StatMultiplier = 10,
        EffectColor = Color3.fromRGB(190, 80, 255),
        Stats = { "Speed", "PollinationQuality", "PollinationRate" }
    },
    OverlordCommand = {
        Name = "OverlordCommand",
        Type = "Active",
        Interval = 100,
        Duration = 25,
        TargetRarityMax = "Divine",
        EffectColor = Color3.fromRGB(255, 210, 90),
        Effects = {
            Speed = 2,
            PollinationQuality = 2,
            PollinationRate = 2
        }
    },
    GenesisPollination = {
        Name = "GenesisPollination",
        Type = "Active",
        Interval = 240,
        Duration = 0,
        TierName = "Pollinated_Godly",
        EffectColor = Color3.fromRGB(255, 255, 180)
    },
    ChronoAcceleration = {
        Name = "ChronoAcceleration",
        Type = "Active",
        Interval = 80,
        TargetCount = 6,
        Duration = 15,
        EffectColor = Color3.fromRGB(80, 220, 255),
        Effects = {
            Speed = 15,
            PollinationRate = 15
        }
    }
};