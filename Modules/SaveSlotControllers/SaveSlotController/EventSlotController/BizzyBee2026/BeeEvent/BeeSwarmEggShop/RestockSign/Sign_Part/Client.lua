-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
script.Parent.ProximityPrompt.Triggered:Connect(function() -- Line: 6
    -- upvalues: MarketController (copy), DevProductIds (copy)
    MarketController:PromptPurchase(DevProductIds.RestockBeeEggShop.PurchaseID, Enum.InfoType.Product);
end);