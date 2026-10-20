-- Decompiled with Potassium's decompiler.

local function EnchantmentEntry(p1: table) -- Line: 38
    return p1;
end;

local v2 = {};
local v3 = {
    Common = Color3.fromRGB(199, 199, 199),
    Rare = Color3.fromRGB(4, 119, 253),
    Mythical = Color3.fromRGB(169, 84, 255),
    Transcendent = Color3.fromRGB(85, 0, 127)
};
v2.Entries = {
    Power_1 = {
        DisplayName = "Power I",
        Description = "35% Extra Damage",
        Rarity = "Rare",
        Color = Color3.fromRGB(251, 68, 67),
        NameColor = v3.Rare,
        Modifiers = {
            DamageMult = 1.4,
            CritChanceAdd = 0.1
        }
    },
    Sword = {
        DisplayName = "Sword",
        Icon = "rbxassetid://71098529080946",
        Description = "+200% Damage and +30% Crit Chance",
        Rarity = "Mythical",
        Color = Color3.fromRGB(251, 68, 67),
        NameColor = v3.Mythical,
        Modifiers = {
            DamageMult = 3,
            CritChanceAdd = 0.3
        }
    },
    Shield = {
        DisplayName = "Shield",
        Icon = "rbxassetid://139573947408413",
        Description = "+250% Max Health and +100% Regen",
        Rarity = "Mythical",
        Color = Color3.fromRGB(66, 135, 245),
        NameColor = v3.Mythical,
        Modifiers = {
            MaxHealthMult = 3.5,
            HealRateMult = 2
        }
    },
    Spear = {
        DisplayName = "Spear",
        Icon = "rbxassetid://71898835955209",
        Description = "+120% Damage and +75% Speed",
        Rarity = "Mythical",
        Color = Color3.fromRGB(255, 150, 50),
        NameColor = v3.Mythical,
        Modifiers = {
            DamageMult = 2.2,
            SpeedMult = 1.75
        }
    },
    BeeShard = {
        DisplayName = "Bee Shard",
        Icon = "rbxassetid://101203337419820",
        Description = "+150% to all stats and +20% Crit Chance",
        Rarity = "Transcendent",
        Color = Color3.fromRGB(99, 205, 255),
        NameColor = v3.Transcendent,
        Modifiers = {
            SpeedMult = 2.5,
            MaxHealthMult = 2.5,
            DamageMult = 2.5,
            CritChanceAdd = 0.2,
            HealRateMult = 2.5,
            PollinationQualityMult = 2.5,
            PollinationRateMult = 2.5
        }
    },
    Crown = {
        DisplayName = "Crown",
        Icon = "rbxassetid://103720814734928",
        Description = "+150% to Speed, Pollination Quality and Pollination Rate",
        Rarity = "Mythical",
        Color = Color3.fromRGB(255, 196, 84),
        NameColor = v3.Mythical,
        Modifiers = {
            SpeedMult = 1.5,
            PollinationQualityMult = 2.5,
            PollinationRateMult = 2.5
        }
    }
};
v2.RarityNameColors = v3;

return v2;