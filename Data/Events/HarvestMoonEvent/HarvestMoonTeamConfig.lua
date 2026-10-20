-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local RewardDataTypes = require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local GlobalUpdateTime = ReplicatedFirst:WaitForChild("GlobalUpdateTime");

local function resolveStart() -- Line: 23
    -- upvalues: GlobalUpdateTime (copy)
    return GlobalUpdateTime.Value;
end;

return {
    EventName = "HarvestMoon",
    DisplayName = "Harvest Moon",
    TeamSize = 4,
    Duration = 1209600,
    PersonalRewards = {
        Tier1 = {
            RequiredPoints = 250,
            Template = "Mid",
            Rewards = { RewardDataTypes.SeedReward({
                    Type = "Seed",
                    Quantity = 1,
                    Value = "Carrot"
                }) }
        },
        Tier2 = {
            RequiredPoints = 750,
            Rewards = { RewardDataTypes.CurrencyReward({
                    Type = "Currency",
                    Quantity = 500,
                    Value = "MoonCoins"
                }) }
        },
        Tier3 = {
            RequiredPoints = 1500,
            Template = "Mid",
            Rewards = { RewardDataTypes.SeedReward({
                    Type = "Seed",
                    Quantity = 2,
                    Value = "Blueberry"
                }) }
        },
        Tier4 = {
            RequiredPoints = 3000,
            Rewards = { RewardDataTypes.CurrencyReward({
                    Type = "Currency",
                    Quantity = 1500,
                    Value = "MoonCoins"
                }) }
        },
        Tier5 = {
            RequiredPoints = 5000,
            Template = "Mid",
            Rewards = { RewardDataTypes.SeedReward({
                    Type = "Seed",
                    Quantity = 3,
                    Value = "Watermelon"
                }) }
        },
        Tier6 = {
            RequiredPoints = 8000,
            Rewards = { RewardDataTypes.CurrencyReward({
                    Type = "Currency",
                    Quantity = 3000,
                    Value = "MoonCoins"
                }) }
        },
        Tier7 = {
            RequiredPoints = 12000,
            Template = "Best",
            Rewards = { RewardDataTypes.SeedReward({
                    Type = "Seed",
                    Quantity = 5,
                    Value = "Pumpkin"
                }) }
        },
        Tier8 = {
            RequiredPoints = 18000,
            Template = "Best",
            Rewards = { RewardDataTypes.SeedReward({
                    Type = "Seed",
                    Quantity = 1,
                    Value = "Pineapple"
                }) }
        }
    },
    TeamRewards = {
        Tier1 = {
            RequiredPoints = 3500,
            Rewards = { RewardDataTypes.EggReward({
                    Type = "Egg",
                    Quantity = 3,
                    Value = "Moon Egg"
                }) }
        },
        Tier2 = {
            RequiredPoints = 8000,
            Rewards = { RewardDataTypes.CrateReward({
                    Type = "Crate",
                    Quantity = 2,
                    Value = "Moon Crate"
                }) }
        },
        Tier3 = {
            RequiredPoints = 12000,
            Template = "Mid",
            Rewards = { RewardDataTypes.GearReward({
                    Type = "Gear",
                    Quantity = 2,
                    Value = "Moon Staff"
                }) }
        },
        Tier4 = {
            RequiredPoints = 18000,
            Rewards = { RewardDataTypes.EggReward({
                    Type = "Egg",
                    Quantity = 3,
                    Value = "Moon Egg"
                }) }
        },
        Tier5 = {
            RequiredPoints = 20000,
            Rewards = { RewardDataTypes.CrateReward({
                    Type = "Crate",
                    Quantity = 2,
                    Value = "Moon Crate"
                }) }
        },
        Tier6 = {
            RequiredPoints = 22500,
            Rewards = { RewardDataTypes.EggReward({
                    Type = "Egg",
                    Quantity = 3,
                    Value = "Moon Egg"
                }) }
        },
        Tier7 = {
            RequiredPoints = 25000,
            Template = "Best",
            Rewards = { RewardDataTypes.SeedReward({
                    Type = "Seed",
                    Quantity = 1,
                    Value = "Lunar Lantern"
                }) }
        }
    },

    GetEventStartTime = function() -- Line: 112, Name: GetEventStartTime
        -- upvalues: GlobalUpdateTime (copy)
        return GlobalUpdateTime.Value;
    end,

    GetEventEndTime = function() -- Line: 116, Name: GetEventEndTime
        -- upvalues: GlobalUpdateTime (copy)
        return GlobalUpdateTime.Value + 1209600;
    end
};