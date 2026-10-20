-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("../DataService");
local u2 = require("../GuiController");
local u3 = require("../../Comma_Module");
require("../GiftController");
local u4 = require("../MarketController");
local u5 = require("../UseDynamicPrices");
local ButtercupCoinData = require(ReplicatedStorage.Data.ButtercupCoinData);
local ButtercupCoinShop_UI = Players.LocalPlayer.PlayerGui.ButtercupCoinShop_UI;
local u6 = {};

function u6.Start(p7) -- Line: 20
    -- upvalues: u2 (copy), ButtercupCoinShop_UI (copy), u6 (copy), u1 (copy)
    local StateForGui = u2:GetStateForGui(ButtercupCoinShop_UI);
    u2:UsePopupAnims(ButtercupCoinShop_UI);
    StateForGui.Visible:Observe(function(p8) -- Line: 24
        -- upvalues: u6 (ref)
        u6:Update();
    end);
    ButtercupCoinShop_UI.Shadow.Frame.Header.CloseButton.Activated:Connect(function() -- Line: 28
        -- upvalues: u2 (ref), ButtercupCoinShop_UI (ref)
        u2:Close(ButtercupCoinShop_UI);
    end);
    u6:_initProducts();
    u1:GetPathSignal("SpecialCurrency/ButtercupCoins"):Connect(function() -- Line: 34
        -- upvalues: u6 (ref)
        u6:Update();
    end);
end;

function u6._initProducts(p9) -- Line: 39
    -- upvalues: ButtercupCoinData (copy), ButtercupCoinShop_UI (copy), u5 (copy), u4 (copy), u3 (copy)
    for i, v in ButtercupCoinData.Shop do
        local v10 = ButtercupCoinShop_UI.Shadow.Frame:FindFirstChild(i);

        if v10 then
            for i2, v2 in v do
                local v11 = v10:FindFirstChild("Package" .. i2);

                if v11 then
                    if u5 or v2.FallbackPrice == nil then
                        if not u5 then
                            warn((`{v11:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        u4:SetPriceLabel(v11.Buy.Label, v2.ProductId);
                    else
                        v11.Buy.Label.Text = "" .. u3.Comma(v2.FallbackPrice);
                    end;

                    v11.Buy.Activated:Connect(function() -- Line: 57
                        -- upvalues: u4 (ref), v2 (copy)
                        u4:PromptPurchaseRobux(v2.ProductId, Enum.InfoType.Product);
                    end);
                end;
            end;
        end;
    end;
end;

function u6.Update(p12) -- Line: 65
    -- upvalues: u1 (copy), ButtercupCoinShop_UI (copy), u3 (copy)
    local Data = u1:GetData();
    ButtercupCoinShop_UI.Shadow.Frame.Header.CoinCounter.Label.Text = "Coins: " .. u3.Comma(Data.SpecialCurrency.ButtercupCoins);
end;

task.spawn(u6.Start, u6);

return u6;