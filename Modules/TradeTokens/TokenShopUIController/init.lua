-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("../DataService");
local u2 = require("../GuiController");
local u3 = require("../../Comma_Module");
local u4 = require("../GiftController");
local u5 = require("../MarketController");
local u6 = require("../UseDynamicPrices");
local TradeTokenData = require(ReplicatedStorage.Data.TradeTokenData);
local BuyTokens = Players.LocalPlayer.PlayerGui.BuyTokens;
local u7 = {};

function u7.Start(p8) -- Line: 20
    -- upvalues: u2 (copy), BuyTokens (copy), u7 (copy), u1 (copy)
    local StateForGui = u2:GetStateForGui(BuyTokens);
    u2:UsePopupAnims(BuyTokens);
    StateForGui.Visible:Observe(function(p9) -- Line: 24
        -- upvalues: u7 (ref)
        u7:Update();
    end);
    BuyTokens.Frame.Close.Activated:Connect(function() -- Line: 28
        -- upvalues: u2 (ref), BuyTokens (ref)
        u2:Close(BuyTokens);
    end);
    u7:_initTokenProducts();
    u1:GetPathSignal("TradeData/Tokens"):Connect(function() -- Line: 34
        -- upvalues: u7 (ref)
        u7:Update();
    end);
end;

function u7._initTokenProducts(p10) -- Line: 39
    -- upvalues: TradeTokenData (copy), BuyTokens (copy), u6 (copy), u5 (copy), u3 (copy), u4 (copy)
    for i, v in TradeTokenData.Shop.Tokens do
        local v11 = BuyTokens.Frame:FindFirstChild(i);

        if v11 then
            for i2, v2 in v do
                local v12 = v11:FindFirstChild("Amt" .. i2);

                if v12 then
                    if u6 or v2.FallbackPrice == nil then
                        if not u6 then
                            warn((`{v12:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        u5:SetPriceLabel(v12.Buy.Label, v2.ProductId);
                    else
                        v12.Buy.Label.Text = "" .. u3.Comma(v2.FallbackPrice);
                    end;

                    v12.Buy.Activated:Connect(function() -- Line: 57
                        -- upvalues: u5 (ref), v2 (copy)
                        u5:PromptPurchaseRobux(v2.ProductId, Enum.InfoType.Product);
                    end);

                    if v2.GiftId then
                        v12.Gift.Activated:Connect(function() -- Line: 62
                            -- upvalues: u4 (ref), v2 (copy)
                            u4:PromptGiftFromGiftId(v2.GiftId);
                        end);
                    end;
                end;
            end;
        end;
    end;
end;

function u7.Update(p13) -- Line: 71
    -- upvalues: u1 (copy), BuyTokens (copy), u3 (copy)
    local Data = u1:GetData();
    BuyTokens.Frame.Label.Text = "Tokens: " .. u3.Comma(Data.TradeData.Tokens);
end;

task.spawn(u7.Start, u7);

return u7;