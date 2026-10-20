-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local Observers = require(ReplicatedStorage.Modules.Observers);
Observers.observeTag("SkipSummerBearPriceText", function(p1) -- Line: 14
    -- upvalues: UseDynamicPrices (copy), MarketController (copy)
    if UseDynamicPrices then
        MarketController:SetPriceLabel(p1, 3604080687, "<font color=\"rgb(255,255,255)\">Skip Current Fruit</font><br/>:robux::value:");
    else
        p1.Text = "<font color=\"rgb(255,255,255)\">Skip Current Fruit</font><br/>49R$";
    end;

    return nil;
end, { workspace });
Observers.observeTag("SkipAllSummerBearPriceText", function(p2) -- Line: 23
    -- upvalues: UseDynamicPrices (copy), MarketController (copy)
    if UseDynamicPrices then
        MarketController:SetPriceLabel(p2, 3604080725, "<font color=\"rgb(255,255,255)\">Skip All Fruits</font><br/>:robux::value:");
    else
        p2.Text = "<font color=\"rgb(255,255,255)\">Skip All Fruits</font><br/>799R$";
    end;

    return nil;
end, { workspace });

return {};