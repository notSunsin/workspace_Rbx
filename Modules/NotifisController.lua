-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = require("./DataService");
local u2 = require("./GuiController");
local u3 = require("../Comma_Module");
local TradingController = require(ReplicatedStorage.Modules.TradeControllers.TradingController);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local TradeNotifs = PlayerGui:WaitForChild("TradeNotifs");
local PromptPurchase = TradeNotifs:WaitForChild("PromptPurchase");
local PurchaseCompleted = TradeNotifs:WaitForChild("PurchaseCompleted");
local UnfairTrade = PlayerGui:WaitForChild("UnfairTrade"):WaitForChild("UnfairTrade");
PlayerGui:WaitForChild("TradingUI");
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};

function u7.Start(p8) -- Line: 25
    -- upvalues: u2 (copy), TradeNotifs (copy), u7 (copy), PromptPurchase (copy), PurchaseCompleted (copy), UnfairTrade (copy), TradingController (copy)
    u2:UsePopupAnims(TradeNotifs);

    for _, child in TradeNotifs:GetChildren() do
        local Close = child:FindFirstChild("Close", 9000000000);

        if Close and child.Name ~= "UnfairTrade" then
            Close.Txt.Activated:Connect(function() -- Line: 32
                -- upvalues: u7 (ref)
                u7:Close();
            end);
        end;
    end;

    PromptPurchase.Options.All.Activated:Connect(function() -- Line: 39
        -- upvalues: u7 (ref)
        u7:Close("Robux");
    end);
    PromptPurchase.Options.Tier.Activated:Connect(function() -- Line: 42
        -- upvalues: u7 (ref)
        u7:Close("Tokens");
    end);
    PurchaseCompleted.Ok.Activated:Connect(function() -- Line: 47
        -- upvalues: u7 (ref)
        u7:Close();
    end);
    UnfairTrade.Options.Yes.Activated:Connect(function() -- Line: 53
        -- upvalues: TradingController (ref)
        TradingController:Accept();
    end);
end;

function u7.Open(p9: table, p10: string, p11: function?) -- Line: 67
    -- upvalues: u5 (ref), TradeNotifs (copy), u2 (copy), u6 (ref), u4 (ref)
    if u5 then
        u5.Visible = false;
        u5 = nil;
    end;

    local v12 = TradeNotifs:FindFirstChild(p10);

    if v12 then
        v12.Visible = true;
        u5 = v12;
    end;

    local v13 = {};

    for _, v in u2:GetAllOpenGuis() do
        if v ~= TradeNotifs then
            table.insert(v13, v);
            u2:Close(v);
        end;
    end;

    u6 = v13;
    u4 = p11;
    u2:Open(TradeNotifs);
end;

function u7.Close(p14, p15) -- Line: 94
    -- upvalues: u4 (ref), u2 (copy), TradeNotifs (copy), u6 (ref)
    if u4 and p15 ~= nil then
        task.defer(u4, p15);
        u4 = nil;
    end;

    u2:Close(TradeNotifs);
    local v16 = u6;

    if v16 then
        for _, v in v16 do
            u2:Open(v);
        end;

        u6 = nil;
    end;
end;

function u7.PromptPurchase(p17: table, p18: string, p19: number, p20: number, p21: function) -- Line: 112
    -- upvalues: PromptPurchase (copy), u1 (copy), u3 (copy), u7 (copy)
    PromptPurchase.Title.Text = p18;
    local Data = u1:GetData();
    PromptPurchase.Bottom.Price.Label.Text = u3.Comma(Data.TradeData.Tokens);
    PromptPurchase.Options.All.Price.Text = "Buy  " .. u3.Comma(p19) .. " Robux";
    PromptPurchase.Options.Tier.Price.Text = u3.Comma(p20) .. " Tokens";
    u7:Open("PromptPurchase", p21);
end;

function u7.PurchaseCompleted(p22: table, p23: string, p24: number) -- Line: 124
    -- upvalues: PurchaseCompleted (copy), u3 (copy), u7 (copy)
    PurchaseCompleted.Bottom.Label.Text = `You have successfully bought {p23}.`;
    PurchaseCompleted.Bottom.Price.Label.Text = u3.Comma(p24);
    u7:Open("PurchaseCompleted");
    game.SoundService.Purchase:Play();
end;

function u7.HideAllUI(p25) -- Line: 133
    -- upvalues: TradeNotifs (copy)
    for _, child in TradeNotifs:GetChildren() do
        if child:IsA("ImageLabel") then
            child.Visible = false;
        end;
    end;
end;

task.spawn(u7.Start, u7);

return u7;