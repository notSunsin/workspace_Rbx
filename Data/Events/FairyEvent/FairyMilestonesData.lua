-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.QuestRewards);
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.GiveServiceCommon);
local u3 = {
    RestartFairyPointsPrice = 7500,
    RestartRobuxPrice = 59,
    SkipTierRobuxPrice = 59,
    RerollRewardsRobuxPrice = 39,
    MaxWishLevel = 5,
    MaxRerolls = 0,
    QuestsVersion = 3,
    TierToFountainProgress = { 100, 200, 300, 500, 800 },
    Rewards = {
        { {
                Chance = 10,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Enchanted Seed Pack",
                    Quantity = 1
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Currency",
                    Value = "FairyPoints",
                    Quantity = 500
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Crate",
                    Value = "Fairy Crate",
                    Quantity = 1
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Glimmering Radar",
                    Quantity = 5
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Targeter",
                    Quantity = 1
                }
            } },
        { {
                Chance = 15,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Enchanted Seed Pack",
                    Quantity = 1
                }
            }, {
                Chance = 15,
                Reward = {
                    Type = "Currency",
                    Value = "FairyPoints",
                    Quantity = 500
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Crate",
                    Value = "Fairy Crate",
                    Quantity = 1
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Fairy Chest",
                    Quantity = 1
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Bell",
                    Quantity = 1
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Glimmering Radar",
                    Quantity = 5
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Targeter",
                    Quantity = 1
                }
            } },
        { {
                Chance = 15,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Enchanted Seed Pack",
                    Quantity = 1
                }
            }, {
                Chance = 15,
                Reward = {
                    Type = "Currency",
                    Value = "FairyPoints",
                    Quantity = 750
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Crate",
                    Value = "Fairy Crate",
                    Quantity = 1
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Fairy Chest",
                    Quantity = 1
                }
            }, {
                Chance = 8,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Bell",
                    Quantity = 3
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Glimmering Radar",
                    Quantity = 10
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Targeter",
                    Quantity = 3
                }
            }, {
                Chance = 1,
                Reward = {
                    Type = "Gear",
                    Value = "Pet Shard Glimmering",
                    Quantity = 1
                }
            } },
        { {
                Chance = 15,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Enchanted Seed Pack",
                    Quantity = 2
                }
            }, {
                Chance = 15,
                Reward = {
                    Type = "Currency",
                    Value = "FairyPoints",
                    Quantity = 2000
                }
            }, {
                Chance = 5,
                Reward = {
                    Type = "Crate",
                    Value = "Fairy Crate",
                    Quantity = 1
                }
            }, {
                Chance = 15,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Fairy Chest",
                    Quantity = 1
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Bell",
                    Quantity = 5
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Glimmering Radar",
                    Quantity = 10
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Fairy Targeter",
                    Quantity = 5
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Pet Shard Glimmering",
                    Quantity = 1
                }
            } },
        { {
                Chance = 10,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Enchanted Seed Pack",
                    Quantity = 3
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Crate",
                    Value = "Enchanted Crate",
                    Quantity = 3
                }
            }, {
                Chance = 10,
                Reward = {
                    Type = "Seed Pack",
                    Value = "Fairy Chest",
                    Quantity = 3
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Gear",
                    Value = "Pet Shard Glimmering",
                    Quantity = 1
                }
            }, {
                Chance = 3,
                Reward = {
                    Type = "Egg",
                    Value = "Enchanted Egg",
                    Quantity = 1
                }
            }, {
                Chance = 2,
                Reward = {
                    Type = "Seed",
                    Value = "Flutter Freesia",
                    Quantity = 1
                }
            } }
    },

    GetCurrentDay = function(p1: table, p2: number) -- Line: 386, Name: GetCurrentDay
        return (p2 + 14400) // 43200;
    end
};

function u3.GetCurrentTime(p4: table, p5: number) -- Line: 390
    -- upvalues: u3 (copy)
    return (u3:GetCurrentDay(p5) + 1) * 43200 - 14400;
end;

function u3.TimeUntilReset(p6) -- Line: 394
    -- upvalues: u3 (copy)
    local UnixTimestamp = DateTime.now().UnixTimestamp;

    return u3:GetCurrentTime(UnixTimestamp) - UnixTimestamp;
end;

return u3;