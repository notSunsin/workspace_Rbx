-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local MarketController = require(ReplicatedStorage.Modules.MarketController);

return require(ReplicatedStorage.Modules.Observers).observeTag("CollectAllPriceText", function(p1) -- Line: 10
    -- upvalues: UseDynamicPrices (copy), MarketController (copy)
    if UseDynamicPrices then
        MarketController:SetPriceLabel(p1, 3418876817, ":value:R$");
    else
        p1.Text = "9R$";
    end;

    return nil;
end, { workspace });