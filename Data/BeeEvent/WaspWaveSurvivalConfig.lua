-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);
local IsDev = require(ReplicatedStorage.Modules.IsDev);
local v1 = {};

local function minutes(p2: number) -- Line: 9
    return p2 * 60;
end;

local function hours(p3: number) -- Line: 13
    return p3 * 60 * 60;
end;

v1.MaxWaves = 100;
v1.IntermissionSeconds = 1;
v1.FailCheckInterval = 1;
v1.PortalIgniteCooldownSeconds = IsDev() and 600 or 60 * 60;
v1.PortalWarmupSeconds = IsDev() and 10 or 600;
v1.StartDelaySeconds = 5;
v1.EventIntervalSeconds = v1.PortalIgniteCooldownSeconds;
v1.EventAvailableSeconds = v1.PortalWarmupSeconds;
v1.BotIdPrefix = "wasp-survival";
v1.EggName = "WaspEgg";
v1.SurvivalWaspVisualScale = 1.35;
v1.SurvivalBossVisualScale = 1.6;
v1.WaveMilestones = {
    {
        Wave = 1,
        Count = 3,
        HealthMultiplier = 0.55,
        DamageMultiplier = 0.45,
        SpeedMultiplier = 0.95,
        AttackCooldownMultiplier = 1.25,
        Pool = {
            Wasp = 100
        }
    },
    {
        Wave = 5,
        Count = 4,
        HealthMultiplier = 0.7,
        DamageMultiplier = 0.55,
        SpeedMultiplier = 1,
        AttackCooldownMultiplier = 1.18,
        Pool = {
            Wasp = 75,
            ["Razorsting Wasp"] = 25
        }
    },
    {
        Wave = 10,
        Count = 5,
        HealthMultiplier = 0.9,
        DamageMultiplier = 0.7,
        SpeedMultiplier = 1,
        AttackCooldownMultiplier = 1.08,
        Boss = "Wasp King",
        Pool = {
            Wasp = 55,
            ["Razorsting Wasp"] = 32,
            ["Acidwing Wasp"] = 13
        }
    },
    {
        Wave = 15,
        Count = 5,
        HealthMultiplier = 1.05,
        DamageMultiplier = 0.82,
        SpeedMultiplier = 1.01,
        AttackCooldownMultiplier = 1.03,
        Pool = {
            Wasp = 35,
            ["Razorsting Wasp"] = 38,
            ["Acidwing Wasp"] = 27
        }
    },
    {
        Wave = 20,
        Count = 6,
        HealthMultiplier = 1.25,
        DamageMultiplier = 0.92,
        SpeedMultiplier = 1.02,
        AttackCooldownMultiplier = 1,
        Pool = {
            Wasp = 15,
            ["Razorsting Wasp"] = 42,
            ["Acidwing Wasp"] = 35,
            ["Bloomvein Wasp"] = 8
        }
    },
    {
        Wave = 25,
        Count = 6,
        HealthMultiplier = 1.45,
        DamageMultiplier = 1.02,
        SpeedMultiplier = 1.03,
        AttackCooldownMultiplier = 0.98,
        Pool = {
            ["Razorsting Wasp"] = 40,
            ["Acidwing Wasp"] = 40,
            ["Bloomvein Wasp"] = 20
        }
    },
    {
        Wave = 30,
        Count = 7,
        HealthMultiplier = 1.7,
        DamageMultiplier = 1.12,
        SpeedMultiplier = 1.04,
        AttackCooldownMultiplier = 0.96,
        Pool = {
            ["Razorsting Wasp"] = 35,
            ["Acidwing Wasp"] = 38,
            ["Bloomvein Wasp"] = 17,
            ["Hiveburn Wasp"] = 10
        }
    },
    {
        Wave = 35,
        Count = 7,
        HealthMultiplier = 1.95,
        DamageMultiplier = 1.22,
        SpeedMultiplier = 1.05,
        AttackCooldownMultiplier = 0.95,
        Pool = {
            ["Razorsting Wasp"] = 20,
            ["Acidwing Wasp"] = 38,
            ["Bloomvein Wasp"] = 20,
            ["Hiveburn Wasp"] = 17,
            ["Dreadhorn Wasp"] = 5
        }
    },
    {
        Wave = 40,
        Count = 8,
        HealthMultiplier = 2.2,
        DamageMultiplier = 1.32,
        SpeedMultiplier = 1.05,
        AttackCooldownMultiplier = 0.94,
        Pool = {
            ["Acidwing Wasp"] = 35,
            ["Bloomvein Wasp"] = 22,
            ["Hiveburn Wasp"] = 28,
            ["Dreadhorn Wasp"] = 15
        }
    },
    {
        Wave = 45,
        Count = 8,
        HealthMultiplier = 2.45,
        DamageMultiplier = 1.45,
        SpeedMultiplier = 1.06,
        AttackCooldownMultiplier = 0.93,
        Pool = {
            ["Acidwing Wasp"] = 20,
            ["Bloomvein Wasp"] = 25,
            ["Hiveburn Wasp"] = 30,
            ["Dreadhorn Wasp"] = 18,
            ["Warsong Wasp"] = 7
        }
    },
    {
        Wave = 50,
        Count = 9,
        HealthMultiplier = 2.75,
        DamageMultiplier = 1.6,
        SpeedMultiplier = 1.06,
        AttackCooldownMultiplier = 0.92,
        Boss = "Wasp King",
        Pool = {
            ["Acidwing Wasp"] = 15,
            ["Bloomvein Wasp"] = 25,
            ["Hiveburn Wasp"] = 30,
            ["Dreadhorn Wasp"] = 20,
            ["Warsong Wasp"] = 10
        }
    },
    {
        Wave = 55,
        Count = 9,
        HealthMultiplier = 3,
        DamageMultiplier = 1.72,
        SpeedMultiplier = 1.07,
        AttackCooldownMultiplier = 0.91,
        Pool = {
            ["Acidwing Wasp"] = 15,
            ["Bloomvein Wasp"] = 25,
            ["Hiveburn Wasp"] = 27,
            ["Dreadhorn Wasp"] = 18,
            ["Warsong Wasp"] = 12,
            ["Thunderbuzz Wasp"] = 3
        }
    },
    {
        Wave = 60,
        Count = 9,
        HealthMultiplier = 3.25,
        DamageMultiplier = 1.85,
        SpeedMultiplier = 1.08,
        AttackCooldownMultiplier = 0.9,
        Pool = {
            ["Acidwing Wasp"] = 12,
            ["Bloomvein Wasp"] = 25,
            ["Hiveburn Wasp"] = 27,
            ["Dreadhorn Wasp"] = 18,
            ["Warsong Wasp"] = 14,
            ["Thunderbuzz Wasp"] = 4
        }
    },
    {
        Wave = 65,
        Count = 10,
        HealthMultiplier = 3.55,
        DamageMultiplier = 1.98,
        SpeedMultiplier = 1.09,
        AttackCooldownMultiplier = 0.89,
        Pool = {
            ["Acidwing Wasp"] = 10,
            ["Bloomvein Wasp"] = 24,
            ["Hiveburn Wasp"] = 26,
            ["Dreadhorn Wasp"] = 18,
            ["Warsong Wasp"] = 16,
            ["Thunderbuzz Wasp"] = 6
        }
    },
    {
        Wave = 70,
        Count = 10,
        HealthMultiplier = 3.9,
        DamageMultiplier = 2.1,
        SpeedMultiplier = 1.1,
        AttackCooldownMultiplier = 0.88,
        Pool = {
            ["Acidwing Wasp"] = 8,
            ["Bloomvein Wasp"] = 24,
            ["Hiveburn Wasp"] = 25,
            ["Dreadhorn Wasp"] = 18,
            ["Warsong Wasp"] = 17,
            ["Thunderbuzz Wasp"] = 8
        }
    },
    {
        Wave = 75,
        Count = 10,
        HealthMultiplier = 4.25,
        DamageMultiplier = 2.22,
        SpeedMultiplier = 1.1,
        AttackCooldownMultiplier = 0.87,
        Pool = {
            ["Acidwing Wasp"] = 5,
            ["Bloomvein Wasp"] = 24,
            ["Hiveburn Wasp"] = 24,
            ["Dreadhorn Wasp"] = 19,
            ["Warsong Wasp"] = 18,
            ["Thunderbuzz Wasp"] = 10
        }
    },
    {
        Wave = 80,
        Count = 11,
        HealthMultiplier = 4.65,
        DamageMultiplier = 2.38,
        SpeedMultiplier = 1.11,
        AttackCooldownMultiplier = 0.86,
        Pool = {
            ["Bloomvein Wasp"] = 22,
            ["Hiveburn Wasp"] = 24,
            ["Dreadhorn Wasp"] = 20,
            ["Warsong Wasp"] = 18,
            ["Thunderbuzz Wasp"] = 14,
            ["Juggerhorn Wasp"] = 2
        }
    },
    {
        Wave = 85,
        Count = 11,
        HealthMultiplier = 5.05,
        DamageMultiplier = 2.55,
        SpeedMultiplier = 1.12,
        AttackCooldownMultiplier = 0.85,
        Pool = {
            ["Bloomvein Wasp"] = 20,
            ["Hiveburn Wasp"] = 23,
            ["Dreadhorn Wasp"] = 20,
            ["Warsong Wasp"] = 18,
            ["Thunderbuzz Wasp"] = 16,
            ["Juggerhorn Wasp"] = 3
        }
    },
    {
        Wave = 90,
        Count = 12,
        HealthMultiplier = 5.5,
        DamageMultiplier = 2.75,
        SpeedMultiplier = 1.13,
        AttackCooldownMultiplier = 0.84,
        Boss = "Wasp King",
        Pool = {
            ["Bloomvein Wasp"] = 18,
            ["Hiveburn Wasp"] = 22,
            ["Dreadhorn Wasp"] = 20,
            ["Warsong Wasp"] = 18,
            ["Thunderbuzz Wasp"] = 17,
            ["Juggerhorn Wasp"] = 5
        }
    },
    {
        Wave = 95,
        Count = 12,
        HealthMultiplier = 6,
        DamageMultiplier = 2.9,
        SpeedMultiplier = 1.14,
        AttackCooldownMultiplier = 0.83,
        Pool = {
            ["Bloomvein Wasp"] = 16,
            ["Hiveburn Wasp"] = 20,
            ["Dreadhorn Wasp"] = 20,
            ["Warsong Wasp"] = 18,
            ["Thunderbuzz Wasp"] = 20,
            ["Juggerhorn Wasp"] = 6
        }
    },
    {
        Wave = 100,
        Count = 13,
        HealthMultiplier = 6.5,
        DamageMultiplier = 3,
        SpeedMultiplier = 1.15,
        AttackCooldownMultiplier = 0.82,
        Boss = "Wasp King",
        Pool = {
            ["Bloomvein Wasp"] = 14,
            ["Hiveburn Wasp"] = 20,
            ["Dreadhorn Wasp"] = 20,
            ["Warsong Wasp"] = 18,
            ["Thunderbuzz Wasp"] = 20,
            ["Juggerhorn Wasp"] = 8
        }
    }
};
v1.CheckpointChestEvery = 5;
v1.CheckpointChestSpawnCountMin = 3;
v1.CheckpointChestSpawnCountMax = 4;
v1.CheckpointChestSpawnDistance = 10;
v1.CheckpointChestRingJitter = 2;
v1.CheckpointChestRaycastHeight = 30;
v1.CheckpointChestRaycastDepth = 120;
v1.CheckpointChestYOffset = 0;
v1.CheckpointChestRewards = {
    [5] = {
        Tier = 1,
        RollCount = 1,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 125
            } },
        Rolls = { {
                Weight = 60,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 75
                }
            }, {
                Weight = 25,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 20,
                Reward = {
                    Type = "Crate",
                    Value = "Hive Crate",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            } }
    },
    [10] = {
        Tier = 1,
        RollCount = 1,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 250
            } },
        Rolls = { {
                Weight = 45,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 125
                }
            }, {
                Weight = 30,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 25,
                Reward = {
                    Type = "Crate",
                    Value = "Hive Crate",
                    Quantity = 1
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Gear",
                    Value = "Common Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            } }
    },
    [15] = {
        Tier = 1,
        RollCount = 1,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 350
            } },
        Rolls = { {
                Weight = 45,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 175
                }
            }, {
                Weight = 28,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 20,
                Reward = {
                    Type = "Crate",
                    Value = "Hive Crate",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Common Bee Egg",
                    Quantity = 1
                }
            } }
    },
    [20] = {
        Tier = 1,
        RollCount = 2,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 500
            } },
        Rolls = { {
                Weight = 45,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 225
                }
            }, {
                Weight = 26,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 18,
                Reward = {
                    Type = "Crate",
                    Value = "Hive Crate",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            } }
    },
    [25] = {
        Tier = 1,
        RollCount = 2,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 650
            } },
        Rolls = { {
                Weight = 42,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 300
                }
            }, {
                Weight = 25,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 15,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Common Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            } }
    },
    [30] = {
        Tier = 2,
        RollCount = 2,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 850
            } },
        Rolls = { {
                Weight = 38,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 400
                }
            }, {
                Weight = 24,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 15,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Rare Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            } }
    },
    [35] = {
        Tier = 2,
        RollCount = 2,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 1000
            } },
        Rolls = { {
                Weight = 36,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 500
                }
            }, {
                Weight = 22,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 14,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Seed",
                    Value = "Hexpetal",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Rare Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            } }
    },
    [40] = {
        Tier = 2,
        RollCount = 2,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 1250
            }, {
                Type = "Bee Shard",
                Value = "Sword",
                Quantity = 1
            } },
        Rolls = { {
                Weight = 34,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 650
                }
            }, {
                Weight = 20,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 12,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 10
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Rare Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 3,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            } }
    },
    [45] = {
        Tier = 2,
        RollCount = 2,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 1500
            } },
        Rolls = { {
                Weight = 32,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 800
                }
            }, {
                Weight = 18,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 12,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 10
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Rare Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            } }
    },
    [50] = {
        Tier = 2,
        RollCount = 3,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 2000
            }, {
                Type = "Currency",
                Value = "RoyalJelly",
                Quantity = 10
            }, {
                Type = "Bee Shard",
                Value = "Shield",
                Quantity = 1
            } },
        Rolls = { {
                Weight = 30,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 1000
                }
            }, {
                Weight = 18,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 12,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 5
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Rare Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            } }
    },
    [55] = {
        Tier = 2,
        RollCount = 3,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 2250
            } },
        Rolls = { {
                Weight = 30,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 1200
                }
            }, {
                Weight = 16,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 6
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Rare Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 3,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            } }
    },
    [60] = {
        Tier = 3,
        RollCount = 3,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 2750
            }, {
                Type = "Bee Shard",
                Value = "Spear",
                Quantity = 1
            } },
        Rolls = { {
                Weight = 28,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 1500
                }
            }, {
                Weight = 16,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 25
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 1,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [65] = {
        Tier = 3,
        RollCount = 3,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 3250
            } },
        Rolls = { {
                Weight = 26,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 1750
                }
            }, {
                Weight = 14,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 8
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 3,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 1,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [70] = {
        Tier = 3,
        RollCount = 3,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 3750
            }, {
                Type = "Currency",
                Value = "RoyalJelly",
                Quantity = 15
            } },
        Rolls = { {
                Weight = 24,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 2000
                }
            }, {
                Weight = 14,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 9,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 10
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 1.25,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [75] = {
        Tier = 3,
        RollCount = 3,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 4250
            } },
        Rolls = {
            {
                Weight = 22,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 2250
                }
            },
            {
                Weight = 12,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            },
            {
                Weight = 9,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 12
                }
            },
            {
                Weight = 6,
                Reward = {
                    Type = "Egg",
                    Value = "Hive Egg",
                    Quantity = 3
                }
            },
            {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            },
            {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            },
            {
                Weight = 1,
                Reward = {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                }
            },
            {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            },
            {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            },
            {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            },
            {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            },
            {
                Weight = 1.5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            }
        }
    },
    [80] = {
        Tier = 3,
        RollCount = 4,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 5000
            }, {
                Type = "Bee Shard",
                Value = "Crown",
                Quantity = 1
            } },
        Rolls = { {
                Weight = 22,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 2500
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 14
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 1.5,
                Reward = {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 2,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [85] = {
        Tier = 3,
        RollCount = 4,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 6000
            } },
        Rolls = { {
                Weight = 20,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 3000
                }
            }, {
                Weight = 10,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 1
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 16
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 7,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 2.5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [90] = {
        Tier = 4,
        RollCount = 4,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 7500
            }, {
                Type = "Currency",
                Value = "RoyalJelly",
                Quantity = 30
            }, {
                Type = "Bee Shard",
                Value = "BeeShard",
                Quantity = 1
            } },
        Rolls = { {
                Weight = 18,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 4000
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 20
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 2.5,
                Reward = {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 3,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [95] = {
        Tier = 4,
        RollCount = 4,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 9000
            } },
        Rolls = { {
                Weight = 16,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 5000
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 25
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 3,
                Reward = {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    },
    [100] = {
        Tier = 5,
        RollCount = 5,
        Guaranteed = { {
                Type = "Currency",
                Value = "HoneyCoins",
                Quantity = 15000
            }, {
                Type = "Currency",
                Value = "RoyalJelly",
                Quantity = 75
            }, {
                Type = "Seed",
                Value = "Swivel Stinger",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Transcendent Bee Egg",
                Quantity = 1
            }, {
                Type = "Bee Shard",
                Value = "BeeShard",
                Quantity = 1
            } },
        Rolls = { {
                Weight = 14,
                Reward = {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 7500
                }
            }, {
                Weight = 8,
                Reward = {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 30
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Seed",
                    Value = "Suncrest Orchid",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }
            }, {
                Weight = 4,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                }
            }, {
                Weight = 6,
                Reward = {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }
            }, {
                Weight = 5,
                Reward = {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }
            } }
    }
};
v1.Rewards = {
    Guaranteed = {
        {
            MinWave = 5,
            Rewards = { {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 500
                } }
        },
        {
            MinWave = 10,
            Rewards = { {
                    Type = "Seed Pack",
                    Value = "Honey Hive Seed Pack",
                    Quantity = 3
                } }
        },
        {
            MinWave = 25,
            Rewards = { {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 2500
                }, {
                    Type = "Bee Shard",
                    Value = "Sword",
                    Quantity = 1
                } }
        },
        {
            MinWave = 50,
            Rewards = { {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 20
                }, {
                    Type = "Bee Shard",
                    Value = "Shield",
                    Quantity = 1
                }, {
                    Type = "Bee Shard",
                    Value = "Spear",
                    Quantity = 1
                } }
        },
        {
            MinWave = 75,
            Rewards = { {
                    Type = "Bee Shard",
                    Value = "Crown",
                    Quantity = 1
                }, {
                    Type = "Gear",
                    Value = "Mythical Bee Egg",
                    Quantity = 1
                } }
        },
        {
            MinWave = 90,
            Rewards = { {
                    Type = "Bee Shard",
                    Value = "BeeShard",
                    Quantity = 1
                }, {
                    Type = "Gear",
                    Value = "Transcendent Bee Egg",
                    Quantity = 1
                } }
        },
        {
            MinWave = 100,
            Rewards = { {
                    Type = "Seed",
                    Value = "Swivel Stinger",
                    Quantity = 1
                }, {
                    Type = "Currency",
                    Value = "HoneyCoins",
                    Quantity = 25000
                }, {
                    Type = "Currency",
                    Value = "RoyalJelly",
                    Quantity = 100
                } }
        }
    },
    ChaseItems = { {
            BaseChance = 0.025,
            ChancePerWave = 0.0005,
            MaxChance = 0.08,
            Reward = {
                Type = "Seed Pack",
                Value = "Honey Hive Seed Pack",
                Quantity = 15
            }
        }, {
            BaseChance = 0.004,
            ChancePerWave = 0.00035,
            MaxChance = 0.04,
            Reward = {
                Type = "Egg",
                Value = "Hive Egg",
                Quantity = 10
            }
        }, {
            BaseChance = 0.0005,
            ChancePerWave = 0.00012,
            MaxChance = 0.015,
            Reward = {
                Type = "Seed",
                Value = "Suncrest Orchid",
                Quantity = 1
            }
        }, {
            BaseChance = 0.0005,
            ChancePerWave = 0.0001,
            MaxChance = 0.0125,
            Reward = {
                Type = "Gear",
                Value = "Transcendent Bee Egg",
                Quantity = 1
            }
        }, {
            BaseChance = 0.0004,
            ChancePerWave = 0.00012,
            MaxChance = 0.015,
            Reward = {
                Type = "Bee Shard",
                Value = "BeeShard",
                Quantity = 1
            }
        } }
};

return v1;