-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local u1 = {};

for i, v in require(ReplicatedStorage.Data.SeedShopData) do
    if not v.SpecialCurrencyType then
        table.insert(u1, {
            Weight = 1,
            Reward = {
                Type = "Seed",
                Quantity = 1,
                Variant = nil,
                RarityOverride = nil,
                Value = i
            }
        });
    end;
end;

return {
    Open = function(p2: table, p3: userdata) -- Line: 31, Name: Open
        -- upvalues: GenericRewardsUIController (copy), u1 (copy)
        GenericRewardsUIController:Open({
            Title = "Random Seed Chances",
            DisplayOdds = true,
            RewardData = u1,
            Breadcrumb = p3
        });
    end
};