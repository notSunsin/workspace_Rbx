-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local Shop_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Shop_UI");
local u1 = {};

for _, v in require(ReplicatedStorage.Data.SuperSeedData) do
    table.insert(u1, {
        Weight = 1,
        Reward = {
            Type = "Seed",
            Quantity = 1,
            Variant = nil,
            RarityOverride = nil,
            Value = v
        }
    });
end;

return {
    Open = function(p2) -- Line: 32, Name: Open
        -- upvalues: GenericRewardsUIController (copy), u1 (copy), Shop_UI (copy)
        GenericRewardsUIController:Open({
            Title = "Super Seed Chances",
            DisplayOdds = true,
            Disclaimer = "PRESETS/RoundedOddsCompliance",
            RewardData = u1,
            Breadcrumb = Shop_UI
        });
    end
};