-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("../DataService");
local u2 = require("../GuiController");
require("../../Comma_Module");
require("../MarketController");
require("../UseDynamicPrices");
local Notification = require(ReplicatedStorage.Modules.Notification);
local BuyButtercupCrate = Players.LocalPlayer.PlayerGui.BuyButtercupCrate;
local v3 = {};
local BuyCrate = ReplicatedStorage.GameEvents.ButtercupEvent.BuyCrate;

function v3.Start(p4) -- Line: 23
    -- upvalues: u2 (copy), BuyButtercupCrate (copy), u1 (copy), Notification (copy), BuyCrate (copy)
    u2:GetStateForGui(BuyButtercupCrate);
    u2:UsePopupAnims(BuyButtercupCrate);
    BuyButtercupCrate:WaitForChild("Shadow"):WaitForChild("Products"):WaitForChild("CloseButton").Activated:Connect(function() -- Line: 29
        -- upvalues: u2 (ref), BuyButtercupCrate (ref)
        u2:Close(BuyButtercupCrate);
    end);
    BuyButtercupCrate.Shadow.Products.ButtercupCrate.Buy.Activated:Connect(function() -- Line: 34
        -- upvalues: u1 (ref), Notification (ref), BuyCrate (ref)
        if u1:GetData().SpecialCurrency.ButtercupCoins < 3 then
            return Notification:CreateNotification("Not enough buttercup coins!");
        end;

        BuyCrate:FireServer();
    end);
end;

task.spawn(v3.Start, v3);

return v3;