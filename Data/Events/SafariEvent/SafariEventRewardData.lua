-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);
local Signal = require(ReplicatedStorage.Modules.Signal);
local v1 = {
    EventShopUnlocks = {
        ["Orange Delight"] = 250000,
        ["Explorer\'s Compass"] = 2000000,
        ["Safari Crate"] = 20000000,
        ["Zebra Whistle"] = 50000000,
        ["Safari Egg"] = 125000000,
        Protea = 300000000,
        ["Lush Sprinkler"] = 1000000000,
        ["Mini Shipping Container"] = 4000000000,
        ["Safari Totem Charm"] = 9000000000,
        Baobab = 13000000000,
        ["Pet Shard JUMBO"] = 55000000000,
        ["Safari Seed Pack"] = 120000000000,
        ["Savannah Crate"] = 125000000000,
        Gecko = 130000000000,
        Hyena = 165000000000,
        ["Cape Buffalo"] = 195000000000,
        Hippo = 212000000000,
        ["Ancestral Horn"] = 216000000000,
        Crocodile = 218000000000,
        ["Safari Obelisk Charm"] = 222000000000,
        Lion = 236000000000
    },
    EventShopRestockCooldown = {
        [800000000] = 2700,
        [17000000000] = 1800,
        [25000000000] = 900,
        [240000000000] = 600
    },
    WeatherUnlocks = {
        SafariRain = 500000000,
        SafariNight = 7000000000,
        SafariDrought = 11000000000,
        SafariOasis = 15000000000,
        SafariStampede = 21000000000,
        SafariTyphoon = 45000000000,
        SafariDusk = 145000000000,
        SafariStorm = 206000000000,
        SafariHunt = 208000000000,
        SafariTour = 232000000000
    },
    EventShopChanceIncreases = {
        Small = 35000000000,
        Medium = 80000000000,
        Large = 206000000000
    },
    ItemRewards = {
        RL_01 = {
            Index = 65000000000,
            Value = {
                Type = "Gear",
                Value = "Mega Lollipop",
                Quantity = 1
            }
        },
        SafariWoodFence = {
            Index = 100000000000,
            Value = {
                Type = "Fences",
                Value = "SAFARIWOOD"
            }
        },
        SafariEgg_10 = {
            Index = 222000000000,
            Value = {
                Type = "Egg",
                Value = "Safari Egg",
                Quantity = 10
            }
        },
        RL_02 = {
            Index = 202000000000,
            Value = {
                Type = "Gear",
                Value = "Mega Lollipop",
                Quantity = 1
            }
        },
        SafariEgg_20 = {
            Index = 238000000000,
            Value = {
                Type = "Egg",
                Value = "Safari Egg",
                Quantity = 20
            }
        }
    },
    DummyRewards = {
        [95000000000] = {
            HeaderText = "Travelling Merchant",
            RewardText = "Safari Traveling Merchant Unlocked AFTER the event",
            Image = "rbxassetid://131315439920630"
        }
    },
    SeedShopUnlocks = {
        Zebrazinkle = 160000000000
    }
};
local v2 = {};
local u3 = {
    Rewards = {
        {
            DisplayName = "Watering Can",
            Type = "Gear",
            Value = "Watering Can",
            Quantity = 10,
            Chance = 8
        },
        {
            DisplayName = "Event Lantern",
            Type = "Gear",
            Value = "Event Lantern",
            Quantity = 5,
            Chance = 7
        },
        {
            DisplayName = "Silver Fertilizer",
            Type = "Gear",
            Value = "Silver Fertilizer",
            Quantity = 1,
            Chance = 7.5
        },
        {
            DisplayName = "Harvest Tool",
            Type = "Gear",
            Value = "Harvest Tool",
            Quantity = 5,
            Chance = 12
        },
        {
            DisplayName = "Reclaimer",
            Type = "Gear",
            Value = "Reclaimer",
            Quantity = 1,
            Chance = 9
        },
        {
            DisplayName = "Rare Summer Egg",
            Type = "Egg",
            Value = "Rare Summer Egg",
            Quantity = 1,
            Chance = 6.5
        },
        {
            DisplayName = "Gold Fertilizer",
            Type = "Gear",
            Value = "Gold Fertilizer",
            Quantity = 1,
            Chance = 5
        },
        {
            DisplayName = "Safari Crate",
            Type = "Crate",
            Value = "Safari Crate",
            Quantity = 1,
            Chance = 5.1
        },
        {
            DisplayName = "Safari Egg",
            Type = "Egg",
            Value = "Safari Egg",
            Quantity = 1,
            Chance = 5
        },
        {
            DisplayName = "Lush Sprinkler",
            Type = "Gear",
            Value = "Lush Sprinkler",
            Quantity = 1,
            Chance = 5
        },
        {
            DisplayName = "Levelup Lollipop",
            Type = "Gear",
            Value = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3
        },
        {
            DisplayName = "Bee Egg",
            Type = "Egg",
            Value = "Bee Egg",
            Quantity = 1,
            Chance = 2.5
        },
        {
            DisplayName = "Grandmaster Sprinkler",
            Type = "Gear",
            Value = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 2
        },
        {
            DisplayName = "Rainbow Fertilizer",
            Type = "Gear",
            Value = "Rainbow Fertilizer",
            Quantity = 1,
            Chance = 1
        },
        {
            DisplayName = "Safari Egg",
            Type = "Egg",
            Value = "Safari Egg",
            Quantity = 3,
            Chance = 1
        },
        {
            DisplayName = "Levelup Lollipop",
            Type = "Gear",
            Value = "Levelup Lollipop",
            Quantity = 3,
            Chance = 1
        },
        {
            DisplayName = "Paradise Egg",
            Type = "Egg",
            Value = "Paradise Egg",
            Quantity = 1,
            Chance = 1
        },
        {
            DisplayName = "Energy Chew",
            Type = "Gear",
            Value = "Energy Chew",
            Quantity = 1,
            Chance = 0.5
        }
    },
    Part2Rewards = { {
            DisplayName = "Safari Seed Pack",
            Type = "Seed Pack",
            Value = "Safari Seed Pack",
            Quantity = 1,
            Chance = 5
        }, {
            DisplayName = "Safari Seed Pack",
            Type = "Seed Pack",
            Value = "Safari Seed Pack",
            Quantity = 3,
            Chance = 1
        } }
};
local v4 = {
    Rewards = {
        [0] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 1,
                Quantity = 1
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 1,
                Quantity = 1
            }, {
                Value = "Safari Crate",
                Type = "Crate",
                Chance = 10,
                Quantity = 1
            }, {
                Value = "Savannah Crate",
                Type = "Crate",
                Chance = 10,
                Quantity = 1
            } },
        [20] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Safari Crate",
                Type = "Crate",
                Chance = 8,
                Quantity = 1
            }, {
                Value = "Savannah Crate",
                Type = "Crate",
                Chance = 8,
                Quantity = 1
            }, {
                Value = "Pet Shard Oxpecker",
                Type = "Gear",
                Chance = 0.5,
                Quantity = 1
            } },
        [40] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Safari Crate",
                Type = "Crate",
                Chance = 4,
                Quantity = 1
            }, {
                Value = "Savannah Crate",
                Type = "Crate",
                Chance = 4,
                Quantity = 1
            }, {
                Value = "Pet Shard Oxpecker",
                Type = "Gear",
                Chance = 1,
                Quantity = 1
            } },
        [60] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 10,
                Quantity = 1
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 10,
                Quantity = 1
            }, {
                Value = "Safari Crate",
                Type = "Crate",
                Chance = 1,
                Quantity = 1
            }, {
                Value = "Savannah Crate",
                Type = "Crate",
                Chance = 1,
                Quantity = 1
            }, {
                Value = "Pet Shard Oxpecker",
                Type = "Gear",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Pet Shard Giraffe",
                Type = "Gear",
                Chance = 1,
                Quantity = 1
            } },
        [80] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 20,
                Quantity = 1
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 20,
                Quantity = 1
            }, {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 10,
                Quantity = 2
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 10,
                Quantity = 2
            }, {
                Value = "Pet Shard Oxpecker",
                Type = "Gear",
                Chance = 4,
                Quantity = 1
            }, {
                Value = "Pet Shard Giraffe",
                Type = "Gear",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Pet Shard Rhino",
                Type = "Gear",
                Chance = 0.5,
                Quantity = 1
            } },
        [100] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 20,
                Quantity = 2
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 20,
                Quantity = 2
            }, {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 10,
                Quantity = 3
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 10,
                Quantity = 3
            }, {
                Value = "Pet Shard Giraffe",
                Type = "Gear",
                Chance = 4,
                Quantity = 1
            }, {
                Value = "Pet Shard Rhino",
                Type = "Gear",
                Chance = 1,
                Quantity = 1
            }, {
                Value = "Pet Shard Crocodile",
                Type = "Gear",
                Chance = 0.5,
                Quantity = 1
            } },
        [120] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 30,
                Quantity = 3
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 30,
                Quantity = 3
            }, {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 10,
                Quantity = 4
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 10,
                Quantity = 4
            }, {
                Value = "Pet Shard Giraffe",
                Type = "Gear",
                Chance = 8,
                Quantity = 1
            }, {
                Value = "Pet Shard Rhino",
                Type = "Gear",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Pet Shard Crocodile",
                Type = "Gear",
                Chance = 1,
                Quantity = 1
            }, {
                Value = "Pet Shard Lion",
                Type = "Gear",
                Chance = 0.5,
                Quantity = 1
            } },
        [140] = { {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 30,
                Quantity = 3
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 30,
                Quantity = 3
            }, {
                Value = "Safari Seed Pack",
                Type = "Seed Pack",
                Chance = 15,
                Quantity = 4
            }, {
                Value = "Safari Egg",
                Type = "Egg",
                Chance = 15,
                Quantity = 4
            }, {
                Value = "Pet Shard Rhino",
                Type = "Gear",
                Chance = 4,
                Quantity = 1
            }, {
                Value = "Pet Shard Crocodile",
                Type = "Gear",
                Chance = 2,
                Quantity = 1
            }, {
                Value = "Pet Shard Lion",
                Type = "Gear",
                Chance = 1,
                Quantity = 1
            } }
    }
};

for _, v in {
    {
        Source = v1.EventShopUnlocks,

        Build = function(p5, p6) -- Line: 373, Name: Build
            return {
                Type = "EventShopUnlock",
                Key = p5,
                Value = p5,
                MilestoneValue = p6
            };
        end
    },
    {
        Source = v1.EventShopRestockCooldown,

        Build = function(p7, p8) -- Line: 379, Name: Build
            return {
                Type = "EventShopCooldown",
                Key = `Cooldown_{p8}`,
                Value = p8,
                MilestoneValue = p7
            };
        end
    },
    {
        Source = v1.WeatherUnlocks,

        Build = function(p9, p10) -- Line: 385, Name: Build
            return {
                Type = "WeatherUnlock",
                Key = p9,
                Value = p9,
                MilestoneValue = p10
            };
        end
    },
    {
        Source = v1.ItemRewards,

        Build = function(p11, p12) -- Line: 391, Name: Build
            return {
                Type = "ItemReward",
                Key = p11,
                ID = p11,
                Value = p12.Value,
                MilestoneValue = p12.Index
            };
        end
    },
    {
        Source = v1.EventShopChanceIncreases,

        Build = function(p13, p14) -- Line: 397, Name: Build
            return {
                Type = "EventShopChance",
                Key = `EventShopChance_{p13}`,
                ID = p13,
                Value = p13,
                MilestoneValue = p14
            };
        end
    },
    {
        Source = v1.DummyRewards,

        Build = function(p15, p16) -- Line: 403, Name: Build
            return {
                Type = "DummyReward",
                Key = `Dummy_{p15}`,
                RewardText = p16.RewardText,
                HeaderText = p16.HeaderText,
                Image = p16.Image,
                MilestoneValue = p15
            };
        end
    },
    {
        Source = v1.SeedShopUnlocks,

        Build = function(p17, p18) -- Line: 409, Name: Build
            return {
                Type = "SeedShopUnlock",
                Key = p17,
                Value = p17,
                MilestoneValue = p18
            };
        end
    }
} do
    local v19 = v;

    for i, v3 in v.Source do
        table.insert(v2, v19.Build(i, v3));
    end;
end;

table.sort(v2, function(p20: table, p21: table) -- Line: 422
    return p20.MilestoneValue < p21.MilestoneValue;
end);
local u22 = Signal.new();
task.spawn(function() -- Line: 427
    -- upvalues: ReplicatedStorage (copy), u3 (copy), u22 (copy)
    local UpdateService = require(ReplicatedStorage.Modules.UpdateService);

    if UpdateService:IsHiddenFromUpdate("Safari Part 2") then
        UpdateService.OnUpdated:Wait();
    end;

    for _, v in u3.Part2Rewards do
        table.insert(u3.Rewards, v);
    end;

    u22:Fire();
end);

return {
    IndividualRewardsChanged = u22,
    AllMilestonesData = v2,
    MilestoneUnlockData = v1,
    SafariIndividualRewardData = u3,
    SafariJoeRewards = v4
};