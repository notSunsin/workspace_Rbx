-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
require(ReplicatedStorage.Data.Events.CookingEvent.CookingEventConfig);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);

return {
    OpenPigRewards = function(p1: table, p2: userdata?) -- Line: 13, Name: OpenPigRewards
        -- upvalues: GameConfigController (copy), GenericRewardsUIController (copy)
        local v3 = {};

        for _, v in GameConfigController:GetConfig("CookingEventConfig").PigChefRewards do
            table.insert(v3, {
                Reward = {
                    Type = v.ItemType,
                    Value = v.ItemName,
                    Quantity = v.ItemAmount
                },
                Weight = v.Chance / 100
            });
        end;

        GenericRewardsUIController:Open({
            Title = "Rewards",
            DisplayOdds = true,
            RewardData = v3,
            Breadcrumb = p2
        });
    end,

    OpenRatRewards = function(p4: table, p5: userdata?) -- Line: 33, Name: OpenRatRewards
        -- upvalues: GameConfigController (copy), GenericRewardsUIController (copy)
        local v6 = {};

        for _, v in GameConfigController:GetConfig("CookingEventConfig").RatChefRewards do
            table.insert(v6, {
                Reward = {
                    Type = v.ItemType,
                    Value = v.ItemName,
                    Quantity = v.ItemAmount
                },
                Weight = v.Chance / 100
            });
        end;

        GenericRewardsUIController:Open({
            Title = "Rewards",
            DisplayOdds = true,
            RewardData = v6,
            Breadcrumb = p5
        });
    end
};