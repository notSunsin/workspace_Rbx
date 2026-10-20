-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ReplicatedFirst");
local RewardDataTypes = require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SummerHarvestTeamConfigAccessor = require(ReplicatedStorage.Modules.Events.Summer2026Event.SummerEventControllers.SummerHarvestController.SummerHarvestTeamConfigAccessor);
local HarvestMoonTeamConfig = require(ReplicatedStorage.Data.Events.HarvestMoonEvent.HarvestMoonTeamConfig);
local u2 = {
    DefaultPlayerEventData = function(p1) -- Line: 40, Name: DefaultPlayerEventData
        return {
            Points = 0,
            LastClaimedTime = 0,
            QuestContainerId = nil,
            QuestPeriod = nil,
            QuestExpiresAt = nil,
            ClaimedTiers = {}
        };
    end
};

function EventEntry(p3: table)
    return p3;
end;

local v4 = workspace:GetServerTimeNow() + 15;

if RunService:IsServer() then
    workspace:SetAttribute("TEAMEVENT_TEST_TIME", v4);
else
    while not workspace:GetAttribute("TEAMEVENT_TEST_TIME") do
        task.wait();
    end;

    workspace:GetAttribute("TEAMEVENT_TEST_TIME");
end;

local v5 = {
    CandyPackaging = EventEntry({
        DisplayName = "Candy Packaging",
        MaxMembers = 4,
        StartTime = 0,
        EndTime = 1777118400,
        ClaimCooldown = 1800,
        NoQuests = true,
        PersonalRewards = {
            Tier1 = {
                RequiredPoints = 10,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bunny Berry"
                    }) }
            },
            Tier2 = {
                RequiredPoints = 30,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 500,
                        Value = "ChocCoins"
                    }) }
            },
            Tier3 = {
                RequiredPoints = 55,
                Rewards = { RewardDataTypes.CrateReward({
                        Type = "Crate",
                        Quantity = 1,
                        Value = "Easter Crate"
                    }) }
            },
            Tier4 = {
                RequiredPoints = 105,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 1,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier5 = {
                RequiredPoints = 155,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 750,
                        Value = "ChocCoins"
                    }) }
            },
            Tier6 = {
                RequiredPoints = 230,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 1,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier7 = {
                RequiredPoints = 330,
                Rewards = { RewardDataTypes.CosmeticReward({
                        Type = "Cosmetic",
                        Quantity = 1,
                        Value = "Bunny Stump"
                    }) }
            },
            Tier8 = {
                RequiredPoints = 580,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Golden Egg"
                    }) }
            },
            Tier9 = {
                RequiredPoints = 830,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 1000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier10 = {
                RequiredPoints = 1080,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 1,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier11 = {
                RequiredPoints = 1330,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 2,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier12 = {
                RequiredPoints = 1730,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier13 = {
                RequiredPoints = 2130,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 2500,
                        Value = "ChocCoins"
                    }) }
            },
            Tier14 = {
                RequiredPoints = 2630,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 2,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier15 = {
                RequiredPoints = 3130,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 2,
                        Value = "Golden Egg"
                    }) }
            },
            Tier16 = {
                RequiredPoints = 3630,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bunny Berry"
                    }) }
            },
            Tier17 = {
                RequiredPoints = 4630,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 5000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier18 = {
                RequiredPoints = 5630,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 2,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier19 = {
                RequiredPoints = 6630,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 3,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier20 = {
                RequiredPoints = 7880,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier21 = {
                RequiredPoints = 9280,
                Rewards = { RewardDataTypes.CrateReward({
                        Type = "Crate",
                        Quantity = 2,
                        Value = "Easter Crate"
                    }) }
            },
            Tier22 = {
                RequiredPoints = 10780,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 2,
                        Value = "Golden Egg"
                    }) }
            },
            Tier23 = {
                RequiredPoints = 12380,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bonnet Bloom"
                    }) }
            },
            Tier24 = {
                RequiredPoints = 14180,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 2,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier25 = {
                RequiredPoints = 16180,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 2,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier26 = {
                RequiredPoints = 18430,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 10000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier27 = {
                RequiredPoints = 20930,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 3,
                        Value = "Golden Egg"
                    }) }
            },
            Tier28 = {
                RequiredPoints = 25930,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Eggfruit"
                    }) }
            }
        },
        TeamRewards = {
            Tier1 = {
                RequiredPoints = 25000,
                Rewards = { RewardDataTypes.CosmeticReward({
                        Type = "Cosmetic",
                        Quantity = 1,
                        Value = "Easter Nest"
                    }) }
            },
            Tier2 = {
                RequiredPoints = 28000,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 3,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier3 = {
                RequiredPoints = 30000,
                Rewards = { RewardDataTypes.CosmeticReward({
                        Type = "Cosmetic",
                        Quantity = 1,
                        Value = "Easter Sign"
                    }) }
            },
            Tier4 = {
                RequiredPoints = 35000,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 2,
                        Value = "Egg Shroom"
                    }) }
            },
            Tier5 = {
                RequiredPoints = 40000,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 5,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier6 = {
                RequiredPoints = 45000,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 4,
                        Value = "Golden Egg"
                    }) }
            },
            Tier7 = {
                RequiredPoints = 50000,
                Template = "Mid",
                Rewards = { RewardDataTypes.PetReward({
                        Type = "Pet",
                        Value = "Candy Squirrel"
                    }) }
            },
            Tier8 = {
                RequiredPoints = 60000,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 6,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier9 = {
                RequiredPoints = 70000,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Waddling Willow"
                    }) }
            },
            Tier10 = {
                RequiredPoints = 80000,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 6,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier11 = {
                RequiredPoints = 90000,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 10,
                        Value = "Golden Egg"
                    }) }
            },
            Tier12 = {
                RequiredPoints = 100000,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Waddling Willow",
                        Variant = "Gold",
                        CustomImage = "rbxassetid://106519223145832"
                    }) }
            }
        }
    }),
    BeeEvent = EventEntry({
        DisplayName = "Bee Event",
        TeamLess = true,
        MaxMembers = 1,
        StartTime = 0,
        EndTime = (1 / 0),
        ClaimCooldown = 1800,
        QuestContainer = "BeeEvent",
        PersonalRewards = {},
        TeamRewards = {}
    }),
    EasterTraining = EventEntry({
        DisplayName = "Easter Training",
        MaxMembers = 4,
        StartTime = 1777118400,
        EndTime = 1778356800,
        ClaimCooldown = 1800,
        PersonalRewards = {
            Tier1 = {
                RequiredPoints = 1,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bunny Berry"
                    }) }
            },
            Tier2 = {
                RequiredPoints = 2,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 500,
                        Value = "ChocCoins"
                    }) }
            },
            Tier3 = {
                RequiredPoints = 3,
                Template = "Mid",
                Rewards = { RewardDataTypes.CrateReward({
                        Type = "Crate",
                        Quantity = 1,
                        Value = "Easter Crate"
                    }) }
            },
            Tier4 = {
                RequiredPoints = 4,
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 1,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier5 = {
                RequiredPoints = 5,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 2,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier6 = {
                RequiredPoints = 6,
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Golden Egg"
                    }) }
            },
            Tier7 = {
                RequiredPoints = 7,
                Template = "Mid",
                Rewards = { RewardDataTypes.CosmeticReward({
                        Type = "Cosmetic",
                        Quantity = 1,
                        Value = "Bunny Stump"
                    }) }
            },
            Tier8 = {
                RequiredPoints = 8,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 2,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier9 = {
                RequiredPoints = 9,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 1000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier10 = {
                RequiredPoints = 10,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 3,
                        Value = "Golden Egg"
                    }) }
            },
            Tier11 = {
                RequiredPoints = 11,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 2500,
                        Value = "ChocCoins"
                    }) }
            },
            Tier12 = {
                RequiredPoints = 12,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 3,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier13 = {
                RequiredPoints = 14,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bonnet Bloom"
                    }) }
            },
            Tier14 = {
                RequiredPoints = 16,
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier15 = {
                RequiredPoints = 18,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 3,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier16 = {
                RequiredPoints = 20,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 2,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier17 = {
                RequiredPoints = 22,
                Rewards = { RewardDataTypes.CrateReward({
                        Type = "Crate",
                        Quantity = 2,
                        Value = "Easter Crate"
                    }) }
            },
            Tier18 = {
                RequiredPoints = 25,
                Template = "Mid",
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 5000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier19 = {
                RequiredPoints = 28,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 4,
                        Value = "Golden Egg"
                    }) }
            },
            Tier20 = {
                RequiredPoints = 31,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Waddling Willow"
                    }) }
            }
        },
        TeamRewards = {
            Tier1 = {
                RequiredPoints = 28,
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 3,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier2 = {
                RequiredPoints = 37,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 3,
                        Value = "Golden Egg"
                    }) }
            },
            Tier3 = {
                RequiredPoints = 46,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 3,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier4 = {
                RequiredPoints = 55,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Basket Bouquet"
                    }) }
            },
            Tier5 = {
                RequiredPoints = 64,
                Template = "Best",
                Rewards = { RewardDataTypes.PetReward({
                        Type = "Pet",
                        Quantity = 1,
                        Value = "Lyrebird"
                    }) }
            },
            Tier6 = {
                RequiredPoints = 74,
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 5,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier7 = {
                RequiredPoints = 84,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Jelly Bean Sprout"
                    }) }
            },
            Tier8 = {
                RequiredPoints = 94,
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 5,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier9 = {
                RequiredPoints = 103,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 10,
                        Value = "Golden Egg"
                    }) }
            },
            Tier10 = {
                RequiredPoints = 112,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Jelly Bean Sprout",
                        Variant = "Gold",
                        CustomImage = "rbxassetid://78800909706757"
                    }) }
            }
        }
    }),
    RoyalJelly = EventEntry({
        DisplayName = "Royal Jelly",
        MaxMembers = 4,
        StartTime = 0,
        EndTime = 1,
        ClaimCooldown = 1800,
        PersonalRewards = {
            Tier1 = {
                RequiredPoints = 1,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bunny Berry"
                    }) }
            },
            Tier2 = {
                RequiredPoints = 2,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 500,
                        Value = "ChocCoins"
                    }) }
            },
            Tier3 = {
                RequiredPoints = 3,
                Template = "Mid",
                Rewards = { RewardDataTypes.CrateReward({
                        Type = "Crate",
                        Quantity = 1,
                        Value = "Easter Crate"
                    }) }
            },
            Tier4 = {
                RequiredPoints = 4,
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 1,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier5 = {
                RequiredPoints = 5,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 2,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier6 = {
                RequiredPoints = 6,
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Golden Egg"
                    }) }
            },
            Tier7 = {
                RequiredPoints = 7,
                Template = "Mid",
                Rewards = { RewardDataTypes.CosmeticReward({
                        Type = "Cosmetic",
                        Quantity = 1,
                        Value = "Bunny Stump"
                    }) }
            },
            Tier8 = {
                RequiredPoints = 8,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 2,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier9 = {
                RequiredPoints = 9,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 1000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier10 = {
                RequiredPoints = 10,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 3,
                        Value = "Golden Egg"
                    }) }
            },
            Tier11 = {
                RequiredPoints = 11,
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 2500,
                        Value = "ChocCoins"
                    }) }
            },
            Tier12 = {
                RequiredPoints = 12,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 3,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier13 = {
                RequiredPoints = 14,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Bonnet Bloom"
                    }) }
            },
            Tier14 = {
                RequiredPoints = 16,
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 1,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier15 = {
                RequiredPoints = 18,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 3,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier16 = {
                RequiredPoints = 20,
                Template = "Best",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 2,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier17 = {
                RequiredPoints = 22,
                Rewards = { RewardDataTypes.CrateReward({
                        Type = "Crate",
                        Quantity = 2,
                        Value = "Easter Crate"
                    }) }
            },
            Tier18 = {
                RequiredPoints = 25,
                Template = "Mid",
                Rewards = { RewardDataTypes.CurrencyReward({
                        Type = "Currency",
                        Quantity = 5000,
                        Value = "ChocCoins"
                    }) }
            },
            Tier19 = {
                RequiredPoints = 28,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 4,
                        Value = "Golden Egg"
                    }) }
            },
            Tier20 = {
                RequiredPoints = 31,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Waddling Willow"
                    }) }
            }
        },
        TeamRewards = {
            Tier1 = {
                RequiredPoints = 28,
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 3,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier2 = {
                RequiredPoints = 37,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 3,
                        Value = "Golden Egg"
                    }) }
            },
            Tier3 = {
                RequiredPoints = 46,
                Rewards = { RewardDataTypes.GearReward({
                        Type = "Gear",
                        Quantity = 3,
                        Value = "Chocolate Sprinkler"
                    }) }
            },
            Tier4 = {
                RequiredPoints = 55,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Basket Bouquet"
                    }) }
            },
            Tier5 = {
                RequiredPoints = 64,
                Template = "Best",
                Rewards = { RewardDataTypes.PetReward({
                        Type = "Pet",
                        Quantity = 1,
                        Value = "Lyrebird"
                    }) }
            },
            Tier6 = {
                RequiredPoints = 74,
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 5,
                        Value = "Springtide Egg"
                    }) }
            },
            Tier7 = {
                RequiredPoints = 84,
                Template = "Mid",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Jelly Bean Sprout"
                    }) }
            },
            Tier8 = {
                RequiredPoints = 94,
                Rewards = { RewardDataTypes.SeedPackReward({
                        Type = "Seed Pack",
                        Quantity = 5,
                        Value = "Easter Seed Pack"
                    }) }
            },
            Tier9 = {
                RequiredPoints = 103,
                Template = "Mid",
                Rewards = { RewardDataTypes.EggReward({
                        Type = "Egg",
                        Quantity = 10,
                        Value = "Golden Egg"
                    }) }
            },
            Tier10 = {
                RequiredPoints = 112,
                Template = "Best",
                Rewards = { RewardDataTypes.SeedReward({
                        Type = "Seed",
                        Quantity = 1,
                        Value = "Jelly Bean Sprout",
                        Variant = "Gold",
                        CustomImage = "rbxassetid://78800909706757"
                    }) }
            }
        }
    }),
    SummerHarvest = EventEntry({
        DisplayName = "Summer Harvest",
        ClaimCooldown = 0,
        NoQuests = true,
        MaxMembers = SummerHarvestTeamConfigAccessor.TeamSize,
        StartTime = SummerHarvestTeamConfigAccessor.EventStartTime,
        EndTime = SummerHarvestTeamConfigAccessor.EventEndTime,
        PersonalRewards = {},
        TeamRewards = {}
    }),
    HarvestMoon = EventEntry({
        ClaimCooldown = 0,
        NoQuests = true,
        DisplayName = HarvestMoonTeamConfig.DisplayName,
        MaxMembers = HarvestMoonTeamConfig.TeamSize,
        StartTime = HarvestMoonTeamConfig.GetEventStartTime(),
        EndTime = HarvestMoonTeamConfig.GetEventEndTime(),
        PersonalRewards = HarvestMoonTeamConfig.PersonalRewards,
        TeamRewards = HarvestMoonTeamConfig.TeamRewards
    })
};
u2.Events = table.freeze(v5);
local v6 = {};

for i, _ in u2.Events do
    v6[i] = i;
end;

u2.EventNames = table.freeze(v6);
u2.CurrentEvent = "BeeEvent";
UpdateService.OnUpdated:Connect(function() -- Line: 632
    -- upvalues: u2 (copy)
    u2.CurrentEvent = "BeeEvent";
end);

if UpdateService:IsUpdateDone() then
    u2.CurrentEvent = "BeeEvent";
end;

for i, v in u2.Events do
    local u7 = i;
    local v8 = {};

    for i2, _ in v.PersonalRewards do
        table.insert(v8, i2);
    end;

    table.sort(v8, function(p9, p10) -- Line: 647
        -- upvalues: u2 (copy), u7 (copy)
        return u2.Events[u7].PersonalRewards[p9].RequiredPoints < u2.Events[u7].PersonalRewards[p10].RequiredPoints;
    end);
    v.SortedPersonalKeys = v8;
end;

for i, v in u2.Events do
    local u11 = i;
    local v12 = {};

    for i2, _ in v.TeamRewards do
        table.insert(v12, i2);
    end;

    table.sort(v12, function(p13, p14) -- Line: 662
        -- upvalues: u2 (copy), u11 (copy)
        return u2.Events[u11].TeamRewards[p13].RequiredPoints < u2.Events[u11].TeamRewards[p14].RequiredPoints;
    end);
    v.SortedTeamKeys = v12;
end;

function u2.GetNextPersonalTier(p15: table, p16: userdata, p17: number) -- Line: 671
    -- upvalues: u2 (copy)
    local v18 = u2.Events[p16];

    if not v18 then
        return nil;
    end;

    for _, v in v18.SortedPersonalKeys do
        local v19 = v18.PersonalRewards[v];

        if p17 < v19.RequiredPoints then
            return v19;
        end;
    end;

    return nil;
end;

function u2.GetPreviousPersonalTier(p20: table, p21: userdata, p22: number) -- Line: 684
    -- upvalues: u2 (copy)
    local v23 = u2.Events[p21];

    if not v23 then
        return nil;
    end;

    local v24 = nil;

    for _, v in v23.SortedPersonalKeys do
        local v25 = v23.PersonalRewards[v];

        if v25.RequiredPoints > p22 then
            break;
        end;

        v24 = v25;
    end;

    return v24;
end;

function u2.GetCompletedPersonalTierCount(p26: table, p27: userdata, p28: number) -- Line: 702
    -- upvalues: u2 (copy)
    local v29 = u2.Events[p27];

    if not v29 then
        return 0;
    end;

    local v30 = 0;

    for _, v in v29.PersonalRewards do
        if v.RequiredPoints <= p28 then
            v30 = v30 + 1;
        end;
    end;

    return v30;
end;

function u2.GetMaxPersonalTierCount(p31: table, p32: userdata) -- Line: 717
    -- upvalues: u2 (copy)
    local v33 = u2.Events[p32];

    if not v33 then
        return 0;
    end;

    local v34 = 0;

    for _ in v33.PersonalRewards do
        v34 = v34 + 1;
    end;

    return v34;
end;

function u2.IsMaxPersonalTier(p35: table, p36: userdata, p37: number) -- Line: 730
    -- upvalues: u2 (copy)
    local CompletedPersonalTierCount = u2:GetCompletedPersonalTierCount(p36, p37);
    local MaxPersonalTierCount = u2:GetMaxPersonalTierCount(p36);
    local v38;

    if MaxPersonalTierCount <= CompletedPersonalTierCount then
        v38 = MaxPersonalTierCount > 0;
    else
        v38 = false;
    end;

    return v38;
end;

function u2.GetMaxPersonalPoints(p39: table, p40: userdata) -- Line: 737
    -- upvalues: u2 (copy)
    local v41 = u2.Events[p40];

    if not (v41 and v41.SortedPersonalKeys) then
        return 0;
    end;

    local v42 = v41.SortedPersonalKeys[#v41.SortedPersonalKeys];

    return not v42 and 0 or v41.PersonalRewards[v42].RequiredPoints;
end;

function u2.GetActiveEvents(p43) -- Line: 748
    -- upvalues: u2 (copy)
    local v44 = {};

    for i, v in u2.Events do
        local StartTime = v.StartTime;
        local EndTime = v.EndTime;
        local ServerTimeNow = workspace:GetServerTimeNow();

        if StartTime <= ServerTimeNow and ServerTimeNow < EndTime then
            v44[i] = v;
        end;
    end;

    return v44;
end;

function u2.CalculatePackagingPoints(p45: table, p46: userdata) -- Line: 770
    -- upvalues: ReplicatedStorage (copy), InventoryServiceEnums (copy), PlantTraitsData (copy)
    local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);

    if not p46 then
        return nil, "No tool";
    end;

    local Attribute = p46:GetAttribute(InventoryServiceEnums.ItemName);

    if not Attribute then
        return nil, "Not a valid plant";
    end;

    if not (PlantTraitsData.HasTrait(Attribute, "Easter") or PlantTraitsData.HasTrait(Attribute, "Candy")) then
        return nil, "Only Easter & Candy Fruit can be submitted";
    end;

    local v47 = CalculatePlantValue(p46);
    local v48 = (type(v47) ~= "number" or (v47 ~= v47 or v47 < 0)) and 0 or v47;
    local v49 = math.log10(1 + v48) * 10 / 13;
    local math_min_ret = math.min(v49, 10);

    return (math_min_ret ~= math_min_ret or math_min_ret < 0) and 0 or math_min_ret, nil;
end;

return u2;