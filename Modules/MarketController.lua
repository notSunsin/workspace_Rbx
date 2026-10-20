-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Notification = require(ReplicatedStorage.Modules.Notification);
local RetryPcall = require(ReplicatedStorage.Modules.RetryPcall);
local Observers = require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Modules.DataService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.IsDev);
local NotifisController = require(ReplicatedStorage.Modules.NotifisController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.TradeTokenData);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local u1 = {
    PromptProductPurchaseInitiated = Signal.new(),
    ScreenBlur = Instance.new("BlurEffect"),
    ScreenCover = Instance.new("ScreenGui"),
    CoverFrame = Instance.new("Frame")
};
local u2 = {};

local function update(p3: userdata) -- Line: 41
    -- upvalues: u1 (copy), Comma_Module (copy)
    if p3:IsA("ProximityPrompt") then
        p3.ObjectText = "???";
    else
        p3.Text = "???";
    end;

    local Attribute = p3:GetAttribute("ProductId");

    if Attribute == nil then
        return;
    end;

    local ProductInfo, v4 = u1:GetProductInfo(Attribute, Enum.InfoType.Product);

    if not ProductInfo then
        if p3:IsA("ProximityPrompt") then
            p3.ObjectText = "Failed to load";

            return;
        end;

        p3.Text = "Failed to load";

        return;
    end;

    local v5 = p3:GetAttribute("Format") or ":robux::value:";
    local string_gsub_ret = string.gsub(v5, ":robux:", "");
    local string_gsub_ret2 = string.gsub(string_gsub_ret, ":value:", Comma_Module.Comma(v4.PriceInRobux));
    local string_gsub_ret3 = string.gsub(string_gsub_ret2, ":valueusd:", u1:GetDisplayInUSD(v4.PriceInRobux));
    local string_gsub_ret4 = string.gsub(string_gsub_ret3, ":rawvalue:", v4.PriceInRobux);

    if p3:IsA("ProximityPrompt") then
        p3.ObjectText = string_gsub_ret4;

        return;
    end;

    p3.Text = string_gsub_ret4;
end;

local function requestUpdate(p6: userdata) -- Line: 76
    -- upvalues: u2 (copy), update (copy)
    for _, v in u2 do
        if v.instance == p6 then
            return;
        end;
    end;

    local v7;

    if p6:IsA("TextLabel") or p6:IsA("TextButton") then
        v7 = p6:FindFirstAncestorWhichIsA("LayerCollector");
    else
        v7 = nil;
    end;

    if v7 and not v7.Enabled then
        table.insert(u2, {
            screenGui = v7,
            instance = p6
        });

        return;
    end;

    task.spawn(update, p6);
end;

local function removeFromRequest(p8: userdata) -- Line: 97
    -- upvalues: u2 (copy)
    for i = #u2, 1, -1 do
        local v9;

        if u2[i].instance == p8 then
            table.remove(u2, i);
            v9 = i;
        else
            v9 = i;
        end;
    end;
end;

local u10 = {};
local u11 = 0;

function u1.GetProductInfo(p12: table, u13: number, u14: any, p15: number?) -- Line: 119
    -- upvalues: u10 (copy), u11 (ref), RetryPcall (copy), MarketplaceService (copy)
    while true do
        local v16 = u10[tostring(u13)];

        if not (v16 and v16.fetching) then
            break;
        end;

        task.wait(1);
    end;

    local v17 = u10[tostring(u13)];

    if v17 and (not v17.fetching and v17.success) then
        return true, v17.data;
    end;

    u11 = u11 + 1;
    task.delay(60, function() -- Line: 135
        -- upvalues: u11 (ref)
        u11 = u11 - 1;
    end);

    while u11 > 36 do
        task.wait(1);
    end;

    u10[tostring(u13)] = {
        fetching = true,
        timestamp = workspace:GetServerTimeNow()
    };
    local v18, v19 = RetryPcall(p15 or 10, 30, function() -- Line: 150
        -- upvalues: MarketplaceService (ref), u13 (copy), u14 (copy)
        return MarketplaceService:GetProductInfo(u13, u14);
    end);

    if not v18 or v19 == nil then
        u10[tostring(u13)] = nil;

        return false, nil;
    end;

    u10[tostring(u13)] = {
        fetching = false,
        success = true,
        timestamp = workspace:GetServerTimeNow(),
        data = v19
    };
    task.delay(180, function() -- Line: 167
        -- upvalues: u10 (ref), u13 (copy)
        u10[tostring(u13)] = nil;
    end);

    return true, v19;
end;

function u1.CanPurchaseWithTokens(p20: table, p21: number, p22: any) -- Line: 174
    -- upvalues: UpdateService (copy), ReplicatedStorage (copy)
    if UpdateService:IsHiddenFromUpdate("Trade Tokens") then
        return false;
    end;

    return ReplicatedStorage.GameEvents.TradeEvents.TradeTokens.CanPurchase:InvokeServer(p21);
end;

function u1.PromptPurchaseRobux(p23: table, p24: number, p25: any) -- Line: 196
    -- upvalues: u1 (copy), Notification (copy), ReplicatedStorage (copy), LocalPlayer (copy), MarketplaceService (copy)
    u1:ToggleScreenBlur(true);

    if p25 == Enum.InfoType.Product then
        if workspace:GetAttribute("AllowFakePurchases") then
            Notification:CreateNotification((`Invoking fake purchase for "{p24}"`));
            task.wait(0.5);
            ReplicatedStorage.GameEvents.Market.FakePurchase:FireServer(p24);
            task.wait(1);

            return;
        end;

        if p24 == 0 then
            return;
        end;

        if not p24 then
            return;
        end;

        u1.PromptProductPurchaseInitiated:Fire(LocalPlayer, p24);
        MarketplaceService:PromptProductPurchase(LocalPlayer, p24);

        return;
    end;

    if p25 ~= Enum.InfoType.GamePass then
        if p25 == Enum.InfoType.Asset then
            MarketplaceService:PromptPurchase(LocalPlayer, p24);

            return;
        end;

        if p25 == Enum.InfoType.Bundle then
            MarketplaceService:PromptBundlePurchase(LocalPlayer, p24);
        end;

        return;
    end;

    if not workspace:GetAttribute("AllowFakePurchases") then
        if p24 <= 0 then
            return;
        end;

        MarketplaceService:PromptGamePassPurchase(LocalPlayer, p24);

        return;
    end;

    Notification:CreateNotification((`Invoking fake purchase for "{p24}"`));
    task.wait(0.5);
    ReplicatedStorage.GameEvents.Market.FakePurchase:FireServer(p24);
    task.wait(1);
end;

function u1.PromptPurchase(p26: table, u27: number, u28: any) -- Line: 236
    -- upvalues: u1 (copy), NotifisController (copy), ReplicatedStorage (copy), Notification (copy)
    local v29, u30 = u1:CanPurchaseWithTokens(u27, u28);

    if not v29 then
        u1:PromptPurchaseRobux(u27, u28);

        return;
    end;

    local ProductInfo, v31 = u1:GetProductInfo(u27, u28);
    local v32;

    if ProductInfo and v31 then
        v32 = v31.PriceInRobux;
    else
        v32 = u30.PriceInRobux;
    end;

    NotifisController:PromptPurchase(u30.Name, v32, u30.PriceInRobux, function(p33) -- Line: 244
        -- upvalues: u1 (ref), u27 (copy), u28 (copy), ReplicatedStorage (ref), NotifisController (ref), u30 (copy), Notification (ref)
        if p33 == "Robux" then
            u1:PromptPurchaseRobux(u27, u28);

            return;
        end;

        if p33 == "Tokens" then
            local v34, v35 = ReplicatedStorage.GameEvents.TradeEvents.TradeTokens.Purchase:InvokeServer(u27);

            if v34 then
                NotifisController:PurchaseCompleted(u30.Name, u30.PriceInRobux);

                return;
            end;

            if v35 then
                Notification:CreateNotification(v35);
            end;
        end;
    end);
end;

function u1.RemovePriceLabel(p36: table, p37: userdata) -- Line: 261
    p37:RemoveTag("PriceLabel");
end;

function u1.ConvertToUSD(p38: table, p39: number) -- Line: 265
    return math.ceil(p39 * 0.012375 * 100) / 100;
end;

function u1.GetDisplayInUSD(p40: table, p41: number) -- Line: 270
    -- upvalues: Comma_Module (copy), u1 (copy)
    return Comma_Module.Comma(u1:ConvertToUSD(p41)):gsub(",", ".");
end;

function u1.SetPriceLabel(p42: table, p43: userdata, p44: number, p45: string?) -- Line: 274
    -- upvalues: requestUpdate (copy)
    p43:SetAttribute("Format", p45 or ":robux::value:");
    p43:SetAttribute("ProductId", p44);
    p43:AddTag("PriceLabel");
    requestUpdate(p43);
end;

function u1.ToggleScreenBlur(p46: table, p47: boolean) -- Line: 281
    -- upvalues: u1 (copy), TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    if not p47 then
        u1.ScreenBlur.Enabled = true;
        u1.CoverFrame.Visible = true;
        TweenService:Create(u1.ScreenBlur, TweenInfo_new_ret, {
            Size = 0
        }):Play();
        TweenService:Create(u1.CoverFrame, TweenInfo_new_ret, {
            BackgroundTransparency = 1
        }):Play();
        task.delay(0.6, function() -- Line: 299
            -- upvalues: u1 (ref)
            u1.ScreenBlur.Enabled = false;
            u1.CoverFrame.Visible = false;
        end);

        return;
    end;

    u1.ScreenBlur.Size = 0;
    u1.ScreenBlur.Enabled = true;
    u1.CoverFrame.BackgroundTransparency = 1;
    u1.CoverFrame.Visible = true;
    TweenService:Create(u1.ScreenBlur, TweenInfo_new_ret, {
        Size = 24
    }):Play();
    TweenService:Create(u1.CoverFrame, TweenInfo_new_ret, {
        BackgroundTransparency = 0.2
    }):Play();
end;

function u1.Start(p48) -- Line: 306
    -- upvalues: ReplicatedStorage (copy), u1 (copy), Observers (copy), requestUpdate (copy), removeFromRequest (copy), u2 (copy), update (copy), PlayerGui (copy), MarketplaceService (copy)
    ReplicatedStorage.GameEvents.Market.PromptPurchase.OnClientEvent:Connect(function(p49: any, p50: boolean?) -- Line: 307
        -- upvalues: u1 (ref)
        local v51 = nil;

        if p49.type == 1 then
            v51 = Enum.InfoType.Product;
        elseif p49.type == 2 then
            v51 = Enum.InfoType.GamePass;
        elseif p49.type == 3 then
            v51 = Enum.InfoType.Asset;
        elseif p49.type == 4 then
            v51 = Enum.InfoType.Bundle;
        end;

        if not v51 then
            return;
        end;

        if p50 then
            u1:PromptPurchaseRobux(p49.id, v51);

            return;
        end;

        u1:PromptPurchase(p49.id, v51);
    end);
    Observers.observeTag("PriceLabel", function(u52: userdata) -- Line: 331
        -- upvalues: Observers (ref), requestUpdate (ref), removeFromRequest (ref)
        if u52:IsA("TextButton") or (u52:IsA("TextLabel") or u52:IsA("ProximityPrompt")) then
            return Observers.observeAttribute(u52, "ProductId", function(p53) -- Line: 336
                -- upvalues: requestUpdate (ref), u52 (copy), removeFromRequest (ref)
                requestUpdate(u52);

                return function() -- Line: 339
                    -- upvalues: removeFromRequest (ref), u52 (ref)
                    removeFromRequest(u52);
                end;
            end);
        end;

        return nil;
    end);
    PlayerGui.ChildAdded:Connect(function(u54: userdata) -- Line: 345, Name: onGuiAdded
        -- upvalues: u2 (ref), update (ref)
        if not u54:IsA("LayerCollector") then
            return;
        end;

        u54:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 350
            -- upvalues: u54 (copy), u2 (ref), update (ref)
            if not u54.Enabled then
                return;
            end;

            for i = #u2, 1, -1 do
                local v55 = u2[i];
                local v56;

                if v55.screenGui == u54 then
                    task.spawn(update, v55.instance);
                    table.remove(u2, i);
                    v56 = i;
                else
                    v56 = i;
                end;
            end;
        end);
    end);

    for _, child in PlayerGui:GetChildren() do
        if child:IsA("LayerCollector") then
            child:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 350
                -- upvalues: child (copy), u2 (ref), update (ref)
                if not child.Enabled then
                    return;
                end;

                for i = #u2, 1, -1 do
                    local v57 = u2[i];
                    local v58;

                    if v57.screenGui == child then
                        task.spawn(update, v57.instance);
                        table.remove(u2, i);
                        v58 = i;
                    else
                        v58 = i;
                    end;
                end;
            end);
        end;
    end;

    u1.ScreenBlur.Size = 0;
    u1.ScreenBlur.Enabled = false;
    u1.ScreenBlur.Parent = game:GetService("Lighting");
    u1.CoverFrame.Size = UDim2.fromScale(2, 2);
    u1.CoverFrame.Position = UDim2.fromScale(0.5, 0.5);
    u1.CoverFrame.AnchorPoint = Vector2.new(0.5, 0.5);
    u1.CoverFrame.BackgroundColor3 = Color3.new(0, 0, 0);
    u1.CoverFrame.BackgroundTransparency = 1;
    u1.CoverFrame.Visible = false;
    u1.CoverFrame.Parent = u1.ScreenCover;
    u1.ScreenCover.DisplayOrder = 9999;
    u1.ScreenCover.Parent = PlayerGui;
    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function() -- Line: 388
        -- upvalues: u1 (ref)
        u1:ToggleScreenBlur(false);
    end);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function() -- Line: 392
        -- upvalues: u1 (ref)
        u1:ToggleScreenBlur(false);
    end);
    MarketplaceService.PromptPurchaseFinished:Connect(function() -- Line: 396
        -- upvalues: u1 (ref)
        u1:ToggleScreenBlur(false);
    end);
    MarketplaceService.PromptBundlePurchaseFinished:Connect(function() -- Line: 400
        -- upvalues: u1 (ref)
        u1:ToggleScreenBlur(false);
    end);
end;

task.spawn(u1.Start, u1);

return u1;