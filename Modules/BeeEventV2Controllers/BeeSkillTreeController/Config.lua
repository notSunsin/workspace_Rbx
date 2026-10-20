-- Decompiled with Potassium's decompiler.

return {
    UPGRADE_CONFIG = {
        BeeCapacity = {
            MaxTier = 8,
            CostPerTier = { 15, 20, 25, 100, 250, 1000, 5000, 10000 },
            LevelsPerTier = { 1, 3, 3, 3, 3, 3, 2, 2 }
        },
        BeeSpeed = {
            MaxTier = 4,
            CostPerTier = { 25, 45, 500, 2000 }
        },
        CompressorCapacity = {
            MaxTier = 4,
            CostPerTier = { 10, 15, 150, 1000 }
        },
        CompressorSpeed = {
            MaxTier = 4,
            CostPerTier = { 15, 75, 500, 5000 }
        },
        PollinationAmount = {
            MaxTier = 4,
            CostPerTier = { 10, 65, 250, 2000 }
        }
    },
    PAGE_NODES = {
        Combat = {
            AttachTo = "__origin__",
            RequiresUpgrade = "BeeCapacity",
            RequiresTier = 1,
            SubTree = "Combat",
            Icon = "rbxassetid://86201852336196",
            Label = "Combat",
            Description = "Unlock combat abilities and stat upgrades for your bee.",
            UpdateGate = "BeeCombatSkills",
            Color = Color3.fromRGB(255, 106, 223)
        }
    },
    SUB_TREE_CONFIGS = {
        Combat = {
            Order = { "Damage", "CriticalChance", "MoreHealth", "RespawnSpeed", "Lifesteal", "Looting" },
            Lifesteal = {
                MaxTier = 3,
                DisplayName = "Lifesteal",
                Icon = "rbxassetid://85384873258459",
                Description = "Each hit heals you for a % of damage dealt.",
                CostPerTier = { 1000, 3000, 8000 }
            },
            Looting = {
                MaxTier = 3,
                DisplayName = "Looting",
                Icon = "rbxassetid://133804117668746",
                Description = "Increases the chance of rare loot drops.",
                CostPerTier = { 800, 2400, 6000 }
            },
            Damage = {
                MaxTier = 5,
                DisplayName = "Damage",
                Icon = "rbxassetid://89962179281001",
                Description = "Increases your bee\'s attack damage.",
                CostPerTier = { 400, 1200, 3000, 8000, 20000 }
            },
            CriticalChance = {
                MaxTier = 5,
                DisplayName = "Critical Chance",
                Icon = "rbxassetid://140393301156020",
                Description = "Increases the chance of landing a critical hit.",
                CostPerTier = { 500, 1400, 3600, 10000, 24000 }
            },
            RespawnSpeed = {
                MaxTier = 3,
                DisplayName = "Faster Respawn",
                Icon = "rbxassetid://103432472824672",
                Description = "Reduces the time it takes to respawn after death.",
                CostPerTier = { 600, 1800, 5000 }
            },
            MoreHealth = {
                MaxTier = 5,
                DisplayName = "More Health",
                Icon = "rbxassetid://79699393751654",
                Description = "Increases your bee\'s maximum health.",
                CostPerTier = { 600, 1600, 4000, 10000, 24000 }
            },
            BeeAbilities = {
                Icon = "rbxassetid://0",
                Description = "A unique combat ability.",
                BranchCaps = {
                    {
                        AttachTo = "CriticalChance",
                        Name = "CriticalChanceAbility",
                        DisplayName = "Sting Burst",
                        Icon = "rbxassetid://70400859195154",
                        Cost = 52000,
                        Description = "On attack, bees have a 8% chance to instantly attack again."
                    },
                    {
                        AttachTo = "MoreHealth",
                        Name = "MoreHealthAbility",
                        DisplayName = "Pollen Shield",
                        Icon = "rbxassetid://114609344121956",
                        Cost = 52000,
                        Description = "When attacked, bees have a 8% chance to completely block damage."
                    },
                    {
                        AttachTo = "Damage",
                        Name = "DamageAbility",
                        DisplayName = "Berserker Instinct",
                        Icon = "rbxassetid://109233698665287",
                        Cost = 64000,
                        Description = "When a bee slays an enemy, it gains +50% damage and attack speed for 6 seconds."
                    },
                    {
                        AttachTo = "RespawnSpeed",
                        Name = "RespawnSpeedAbility",
                        DisplayName = "Last Stand",
                        Icon = "rbxassetid://107622636623108",
                        Cost = 56000,
                        Description = "Upon taking fatal damage there is a 4% chance the bee survives with 25% health."
                    },
                    {
                        AttachTo = "Lifesteal",
                        Name = "LifestealAbility",
                        DisplayName = "Bee\'s Bond",
                        Icon = "rbxassetid://132667801658921",
                        Cost = 50000,
                        Description = "On attack, bees have a 5% chance to heal 5% health of the lowest health bee."
                    },
                    {
                        AttachTo = "Looting",
                        Name = "LootingAbility",
                        DisplayName = "Bee Greed",
                        Icon = "rbxassetid://131356722712901",
                        Cost = 70000,
                        Description = "On attack, bees have a 10% chance to give HoneyCoins equal to base damage dealt, with a 1% chance to give Royal Jelly equal to half base damage dealt."
                    }
                }
            }
        }
    },
    SUB_TREE_ORIGIN = {
        Combat = {
            Label = "← Main Tree",
            Icon = "rbxassetid://130381526915161",
            Description = "Return to the main skill tree."
        }
    }
};