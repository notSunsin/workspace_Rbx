-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local UserInputService = game:GetService("UserInputService");
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local DataService = require(ReplicatedStorage.Modules.DataService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.DumpTable);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Item_Module = require(ReplicatedStorage.Item_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemDescriptionFinder = require(ReplicatedStorage.Modules.ItemDescriptionFinder);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local UITabHelperModule = require(ReplicatedStorage.Modules.UITabHelperModule);
local ShopTabHandler = require(ReplicatedStorage.Modules.ShopTabHandler);
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local Spr = require(ReplicatedStorage.Code.Spr);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local _ = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local EventShopConfigData = require(ReplicatedStorage.Data.EventShopConfigData);
local NPCLevelHandler = require(ReplicatedStorage.Modules.NPCLevelHandler);
local EventShopData = require(ReplicatedStorage.Data.EventShopData);
local BuyEventShopStock = GameEvents.BuyEventShopStock;
local BuyEventShopRestock = GameEvents.BuyEventShopRestock;
local u1 = false;
local u2 = nil;
local u3 = Signal.new();
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local TabButtonTemplate = ReplicatedStorage.UITemplates:WaitForChild("TabButtonTemplate");
local u12 = nil;
local u13 = {};
local u14 = {};
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = { {
        Name = "Main",
        IsLocked = false
    }, {
        Name = "Friendship",
        IsLocked = true
    } };
local u19 = {};
local u20 = {};
local u21 = {};
local u22 = "";

local function ShouldShowEventShopRestockNotification() -- Line: 90
    -- upvalues: SaveSlotController (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();

    return not (CurrentSaveSlot and CurrentSaveSlot.IsBeeSlot);
end;

local function GetRefreshTime() -- Line: 99
    -- upvalues: u22 (ref), DataService (copy), EventShopConfigData (copy)
    if u22 == "" then
        return nil;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local v23 = Data and Data.EventShopStock and Data.EventShopStock[u22];

    if not v23 then
        return nil;
    end;

    local ShopResetTime = EventShopConfigData.GetShopResetTime(u22);
    local ForcedEventShopEndTimestamp = v23.ForcedEventShopEndTimestamp;

    if ForcedEventShopEndTimestamp and (ServerTimeNow < ForcedEventShopEndTimestamp and ForcedEventShopEndTimestamp - ServerTimeNow <= ShopResetTime) then
        return ForcedEventShopEndTimestamp - ServerTimeNow;
    end;

    return ShopResetTime - ServerTimeNow % ShopResetTime;
end;

local Click = game.SoundService.Click;
local Restock_SFX = game.SoundService.Restock_SFX;

local function SetupTimer() -- Line: 125
    -- upvalues: UpdateService (copy), u6 (ref), u1 (ref), GetRefreshTime (copy), NumberUtil (copy), TradeWorldController (copy), SaveSlotController (copy), Restock_SFX (copy)
    if UpdateService:IsHiddenFromUpdate("Event Shop Timer") or UpdateService:IsHiddenAfterUpdate("Event Shop Timer") then
        u6.Visible = false;
        u1 = false;

        return;
    end;

    u6.Visible = true;

    if u1 then
        return;
    end;

    u1 = true;

    while true do
        while true do
            local v24 = GetRefreshTime();

            if v24 == nil then
                break;
            end;

            u6.Text = v24 <= 0 and "Restocking" or "Restocks in " .. NumberUtil.compactFormat(v24);

            if v24 <= 1 and not TradeWorldController:IsInWorld() then
                local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();

                if not (CurrentSaveSlot and CurrentSaveSlot.IsBeeSlot) then
                    Restock_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    Restock_SFX.TimePosition = 0;
                    Restock_SFX.Playing = true;
                    require(game.ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#FFB6C1\"><b>Your Event Shop stock has restocked!</b></font>");
                end;
            end;

            task.wait(1);
        end;

        u6.Text = "";
        task.wait(1);
    end;
end;

local function ApplyRarityVisuals(p25: userdata) -- Line: 164
    p25.Rarity_BG.UIGradient.Enabled = false;
    p25.Rarity_BG.ImageColor3 = Color3.new(1, 1, 1);
    p25.Rarity_BG.TranscendantSparkles.Visible = false;
    local Rarity_Text = p25.Rarity_Text;

    if Rarity_Text.UIStroke then
        Rarity_Text.UIStroke.Color = Color3.new(0, 0, 0);
    end;
end;

local function SetupRarityEffects(u26, p27) -- Line: 175
    -- upvalues: ApplyRarityVisuals (copy), RunService (copy), u4 (ref), ColorHelper (copy), u20 (copy)
    if not p27 then
        return;
    end;

    local v28 = p27[1];
    local v29 = p27[2];
    local v30 = p27[3];
    ApplyRarityVisuals(u26);
    u26.Rarity_Text.Text = v28;

    if v30 and v28 == "Prismatic" then
        local u31 = nil;
        u31 = RunService.Heartbeat:Connect(function() -- Line: 190
            -- upvalues: u4 (ref), u26 (copy), u31 (ref), ColorHelper (ref)
            if not u4.Enabled then
                return;
            end;

            if not (u26 and u26.Parent) then
                if u31 then
                    u31:Disconnect();
                end;

                return;
            end;

            local v32 = os.clock() * 0.1 % 1;
            local Color3_fromHSV_ret = Color3.fromHSV(v32, 1, 1);
            u26.Rarity_BG.ImageColor3 = Color3_fromHSV_ret;

            if u26.Rarity_Text.UIStroke then
                u26.Rarity_Text.UIStroke.Color = ColorHelper:Darken(Color3_fromHSV_ret);
            end;
        end);
        table.insert(u20, u31);

        return;
    end;

    if v28 ~= "Transcendent" then
        u26.Rarity_BG.ImageColor3 = v29;

        if u26.Rarity_Text.UIStroke then
            u26.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v29);
        end;

        return;
    end;

    u26.Rarity_BG.TranscendantSparkles.Visible = true;
    u26.Rarity_BG.ImageColor3 = Color3.new(1, 1, 1);
    u26.Rarity_BG.UIGradient.Enabled = true;
    u26.Rarity_BG.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 149, 1), Color3.fromRGB(255, 238, 5));

    if u26.Rarity_Text.UIStroke then
        u26.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v29);
    end;

    local u33 = 1;
    local u34 = nil;
    u34 = RunService.Heartbeat:Connect(function(p35: number) -- Line: 234
        -- upvalues: u4 (ref), u26 (copy), u34 (ref), u33 (ref)
        if not u4.Enabled then
            return;
        end;

        if u26 and u26.Parent then
            for _, child in u26.Rarity_BG.TranscendantSparkles:GetChildren() do
                child.Rotation = child.Rotation + p35 * 10;
                local v36 = child.Size.X.Offset + u33 * 1;

                if v36 >= 50 then
                    v36 = 50;
                    u33 = -1;
                elseif v36 <= 0 then
                    v36 = 0;
                    u33 = 1;
                end;

                child.Size = UDim2.new(0, v36, 0, v36);
            end;

            return;
        end;

        if u34 then
            u34:Disconnect();
        end;
    end);
    table.insert(u20, u34);
end;

local function SetCFrame(p37: userdata, p38) -- Line: 273
    if not p37:IsA("Model") then
        if p37:IsA("BasePart") then
            p37.CFrame = p38;
        end;

        return;
    end;

    p37:PivotTo(p38);
    p37:ScaleTo(0.5);
end;

local function SetOrientation(p39: userdata, p40: vector) -- Line: 283
    if p39:IsA("BasePart") then
        p39.Orientation = p40;
    end;
end;

local function GetOrientation(p41: userdata) -- Line: 290
    return not p41:IsA("BasePart") and Vector3.new(0, 0, 0) or p41.Orientation;
end;

local function RotateModel(u42: userdata, u43: number) -- Line: 298
    -- upvalues: RunService (copy)
    local u44 = 0;
    local Pivot = u42:GetPivot();

    return RunService.RenderStepped:Connect(function(p45: number) -- Line: 302
        -- upvalues: u44 (ref), u43 (copy), u42 (copy), Pivot (copy)
        u44 = u44 + p45 * u43;
        u42:PivotTo(Pivot * CFrame.Angles(0, math.rad(u44), 0));
    end);
end;

local u46 = nil;

local function SetupFrames() -- Line: 311
    -- upvalues: u22 (ref), EventShopData (copy), SetupTimer (copy), u20 (copy), u19 (copy), UserInputService (copy), ItemImageFinder (copy), ContentProvider (copy), UpdateService (copy), EventRotationController (copy), EventShopConfigData (copy), u12 (ref), u9 (ref), Item_Module (copy), SetupRarityEffects (copy), ItemNameFinder (copy), LocalPlayer (copy), NumberUtil (copy), ItemDescriptionFinder (copy), u5 (ref), u10 (ref), BuyEventShopStock (copy), WatchButtonHold (copy), Spr (copy), MarketController (copy), Click (copy), GiftController (copy), FastTween (copy), ItemOddsController (copy), u4 (ref), CurrencyData (copy), u2 (ref), u3 (copy), UseDynamicPrices (copy), Comma_Module (copy), DataService (copy), NPCLevelHandler (copy), ReplicatedStorage (copy), u46 (ref)
    if u22 == "" or not EventShopData[u22] then
        return;
    end;

    task.spawn(SetupTimer);

    for _, v in ipairs(u20) do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    table.clear(u20);

    for _, v in u19 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u19);
    local v47 = EventShopData[u22];

    if not UserInputService.TouchEnabled then
        local u48 = {};

        for i, v in v47 do
            if v.DisplayInShop and v.ItemType == "Seed" then
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = ItemImageFinder(i, "Holdable");
                table.insert(u48, ImageLabel);
            end;
        end;

        task.spawn(function() -- Line: 349
            -- upvalues: ContentProvider (ref), u48 (copy)
            ContentProvider:PreloadAsync(u48);
        end);
    end;

    local v49 = {};

    for i, v in v47 do
        if v.DisplayInShop and not (UpdateService:IsHiddenFromUpdate(v.SeedName) or UpdateService:IsHiddenAfterUpdate(v.SeedName)) then
            local LoadedEvent = EventRotationController:GetLoadedEvent();
            local Config = EventShopConfigData.GetConfig(u22);
            local u50, u51, v52, v53, v54, u55, u56, v57, u58, u59, v60, u61, u62, v63, v64, u65, u66, v67, v68, v69, u70, u71, u72, v73, v74, u75;

            if LoadedEvent and Config.EVENT_SET then
                if LoadedEvent.EventSet == Config.EVENT_SET then
                    local MinEventIndex = v.MinEventIndex;

                    if MinEventIndex and not EventRotationController:IsPastEventIDIndex(MinEventIndex) then
                        warn((`{v.SeedName}: Event Index {MinEventIndex} not yet passed`));
                    elseif not u12.CurrentCategory or u12.CurrentCategory == u12.DefaultCategory then
                        u50 = u9:Clone();
                        u19[i] = u50;
                        u50.Name = i;
                        u50.LayoutOrder = v.LayoutOrder * 10;
                        table.insert(v49, u50);
                        u51 = u50.Main_Frame;
                        v52 = Item_Module.Return_Rarity_Data(v.SeedRarity);

                        if v52 then
                            SetupRarityEffects(u51, v52);
                        end;

                        u51.Seed_Text.Text = ItemNameFinder(v.SeedName, v.ItemType) or v.SeedName;
                        u51.Seed_Text_Shadow.Text = ItemNameFinder(v.SeedName, v.ItemType) or v.SeedName;
                        v53 = LocalPlayer:GetAttribute("NewYearsEggPriceMultiplier");
                        v54 = v53 == "Multiplier_X0.1" and 0.1 or (v53 == "Multiplier_X10" and 10 or 1);

                        if v.SpecialCurrencyType then
                            u55 = NumberUtil.FormatCompactPrice(v.Price * v54) .. "";
                        else
                            u55 = NumberUtil.DisplaySheckles(v.Price * v54);
                        end;

                        u51.Description_Text.Text = ItemDescriptionFinder(v.SeedName, v.ItemType) or v.Description;

                        if u51.Description_Text.Text == "" then
                            u51.InfoButton.Visible = false;
                        else
                            u51.LargeDescriptionText.Text = ItemDescriptionFinder(v.SeedName, v.ItemType) or v.Description;
                            u51.InfoButton.Visible = true;
                        end;

                        u51.LargeDescriptionText.Visible = false;
                        u56 = false;
                        u51.InfoButton.Activated:Connect(function() -- Line: 467, Name: ToggleDescriptionVisibility
                            -- upvalues: u56 (ref), u51 (copy)
                            u56 = not u56;
                            u51.LargeDescriptionText.Visible = u56;
                            u51.Rarity_BG.Visible = not u56;
                            u51.Rarity_Text.Visible = not u56;
                            u51.Stock_Text.Visible = not u56;
                            u51.Cost_Text.Visible = not u56;
                        end);

                        if u51.Cost_Text:FindFirstChild("TEXT") then
                            u51.Cost_Text.TEXT.Text = u55;
                        else
                            u51.Cost_Text.Text = u55;
                        end;

                        v57 = u51:FindFirstChild("ShopItem_Image", true);
                        v57.Visible = true;
                        v57.Image = ItemImageFinder(i, v.ItemType);
                        u50.Parent = u5;
                        u58 = u10:Clone();
                        u58.LayoutOrder = v.LayoutOrder * 10 + 1;
                        u58.Name = `{i}_Padding`;
                        u58.Parent = u5;
                        u19[u58.Name] = u58;
                        u59 = u50.Frame;

                        if u59.Sheckles_Buy.In_Stock.Cost_Text:FindFirstChild("TEXT") then
                            u59.Sheckles_Buy.In_Stock.Cost_Text.TEXT.Text = u55;
                        else
                            u59.Sheckles_Buy.In_Stock.Cost_Text.Text = u55;
                        end;

                        v60 = function() -- Line: 508, Name: buy
                            -- upvalues: BuyEventShopStock (ref), i (copy), u22 (ref)
                            BuyEventShopStock:FireServer(i, u22);
                        end;

                        u61 = false;
                        u62 = 0;
                        WatchButtonHold(u59.Sheckles_Buy, function(p76: number, p77: boolean?) -- Line: 518
                            -- upvalues: u62 (ref), u61 (ref), u59 (copy), Spr (ref), BuyEventShopStock (ref), i (copy), u22 (ref)
                            if workspace:GetAttribute("InTutorial") then
                                return;
                            end;

                            if p77 then
                                u62 = 0;

                                if u61 then
                                    u61 = false;

                                    if u59:FindFirstChild("Sheckles_Buy") then
                                        Spr.target(u59.Sheckles_Buy, 0.8, 2, {
                                            ImageColor3 = Color3.new(1, 1, 1)
                                        });
                                    end;
                                end;

                                return;
                            end;

                            if not u61 then
                                u61 = true;

                                if u59:FindFirstChild("Sheckles_Buy") then
                                    Spr.target(u59.Sheckles_Buy, 0.8, 2, {
                                        ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                                    });
                                end;
                            end;

                            if os.clock() < u62 then
                                return;
                            end;

                            local v78 = ((1 - math.exp(p76 * -0.3)) * 24 + 8) // 1;
                            local math_max_ret = math.max(v78, 1);
                            u62 = os.clock() + 0.125;

                            for i2 = 1, math_max_ret do
                                BuyEventShopStock:FireServer(i, u22);
                                local _ = i2;
                            end;
                        end, {
                            minimumHoldTime = 1,
                            interval = 0.125
                        });
                        u59.Sheckles_Buy.Activated:Connect(v60);
                        v63 = u59.Robux_Buy;

                        if v.PurchaseID == nil then
                            v64 = false;
                        else
                            v64 = v.PurchaseID > 0;
                        end;

                        v63.Visible = v64;
                        u59.Robux_Buy.Activated:Connect(function() -- Line: 565
                            -- upvalues: MarketController (ref), v (copy)
                            MarketController:PromptPurchase(v.PurchaseID, Enum.InfoType.Product);
                        end);
                        u59.Gift.Visible = v.GiftPurchaseID ~= nil;

                        if v.GiftPurchaseID then
                            u59.Gift.Activated:Connect(function() -- Line: 571
                                -- upvalues: Click (ref), GiftController (ref), v (copy)
                                Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                                Click.TimePosition = 0;
                                Click.Playing = true;
                                GiftController:PromptGiftFromGiftId(v.GiftPurchaseID);
                            end);
                        end;

                        if v.ItemType == "Seed" then
                            u65 = nil;
                            u66 = nil;
                            u51.MouseEnter:Connect(function() -- Line: 584
                                -- upvalues: u65 (ref), FastTween (ref), u50 (copy), u66 (ref), ItemImageFinder (ref), i (copy)
                                u65 = FastTween(u50.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                                    Rotation = u50.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                                });
                                u66 = FastTween(u50.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                    Scale = 1.5
                                });
                                u66.Completed:Connect(function(p79) -- Line: 600
                                    -- upvalues: u50 (ref), ItemImageFinder (ref), i (ref)
                                    if p79 == Enum.PlaybackState.Completed then
                                        if not u50:IsDescendantOf(game) then
                                            return;
                                        end;

                                        u50.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, "Holdable");
                                    end;
                                end);
                            end);
                            u51.MouseLeave:Connect(function() -- Line: 611
                                -- upvalues: u65 (ref), u50 (copy), ItemImageFinder (ref), i (copy), v (copy), FastTween (ref)
                                if u65 then
                                    u65:Cancel();
                                end;

                                u50.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                                u50.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, v.ItemType);
                                FastTween(u50.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                    Scale = 1
                                });
                            end);
                        end;

                        if v.ShowOdds then
                            ItemOddsController:ConnectOddsButton({
                                Type = v.ItemType,
                                Value = v.SeedName
                            }, u51.OddsButton, u4);
                        else
                            u51.OddsButton.Visible = false;
                        end;

                        if v.SpecialCurrencyType and CurrencyData[v.SpecialCurrencyType] then
                            u51.Cost_Text.CurrencyImage.Image = CurrencyData[v.SpecialCurrencyType].Icon;
                            u59.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Image = CurrencyData[v.SpecialCurrencyType].Icon;
                        else
                            u51.Cost_Text.CurrencyImage.Visible = false;
                            u59.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Visible = false;
                        end;

                        v67 = function() -- Line: 651, Name: updateOptions
                            -- upvalues: u2 (ref), i (copy), u59 (copy), FastTween (ref), u58 (copy)
                            if u2 == i then
                                u59.Visible = true;
                                FastTween(u59, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Position = UDim2.fromScale(0.5, 1.3)
                                });
                                FastTween(u58, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Size = UDim2.fromScale(0.13, 0.25)
                                });

                                return;
                            end;

                            task.delay(0.25, function() -- Line: 663
                                -- upvalues: u59 (ref)
                                if u59.Position == UDim2.fromScale(0.5, 0.5) then
                                    u59.Visible = false;
                                end;
                            end);
                            FastTween(u59, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Position = UDim2.fromScale(0.5, 0.5)
                            });
                            FastTween(u58, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(0.13, 0.02)
                            });
                        end;

                        v68 = u20;
                        v69 = u3:Connect(v67);
                        table.insert(v68, v69);
                        task.spawn(v67);
                        u70 = false;
                        u51.Activated:Connect(function() -- Line: 683
                            -- upvalues: u51 (copy), u5 (ref), u50 (copy), FastTween (ref), u2 (ref), i (copy), u3 (ref), u70 (ref), UseDynamicPrices (ref), v (copy), u59 (copy), MarketController (ref), Comma_Module (ref)
                            local v80 = (u51.AbsolutePosition.Y - u5.AbsolutePosition.Y + u5.CanvasPosition.Y + (u50.AbsolutePosition.Y + u50.AbsoluteSize.Y - u5.AbsolutePosition.Y + u5.CanvasPosition.Y)) / 2 - u5.AbsoluteSize.Y / 2;
                            local math_max_ret = math.max(0, u5.AbsoluteCanvasSize.Y - u5.AbsoluteSize.Y);
                            local math_clamp_ret = math.clamp(v80, 0, math_max_ret);
                            FastTween(u5, TweenInfo.new(0.35), {
                                CanvasPosition = Vector2.new(0, math_clamp_ret)
                            });
                            local v81;

                            if u2 == i then
                                v81 = nil;
                            else
                                v81 = i;
                            end;

                            u2 = v81;
                            u3:Fire();

                            if not u70 then
                                if UseDynamicPrices or v.FallbackPrice == nil then
                                    if not UseDynamicPrices then
                                        warn((`{u59:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                    end;

                                    MarketController:SetPriceLabel(u59.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                                else
                                    u59.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                                end;

                                u70 = true;
                            end;
                        end);

                        if u2 == i then
                            task.spawn(function() -- Line: 720
                                -- upvalues: UseDynamicPrices (ref), v (copy), u59 (copy), MarketController (ref), Comma_Module (ref), u70 (ref)
                                if UseDynamicPrices or v.FallbackPrice == nil then
                                    if not UseDynamicPrices then
                                        warn((`{u59:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                    end;

                                    MarketController:SetPriceLabel(u59.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                                else
                                    u59.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                                end;

                                u70 = true;
                            end);
                        end;

                        u71 = true;
                        u72 = Instance.new("NumberValue");
                        u72.Value = 0;
                        u72.Parent = u59;
                        v73 = u20;
                        v74 = u72.Changed:Connect(function(p82: number) -- Line: 741
                            -- upvalues: u51 (copy)
                            if u51.Stock_Text then
                                u51.Stock_Text.Text = `X{p82 // 1} Stock`;
                            end;
                        end);
                        table.insert(v73, v74);

                        u75 = function() -- Line: 748, Name: updateStock
                            -- upvalues: DataService (ref), u22 (ref), i (copy), NPCLevelHandler (ref), v (copy), u71 (ref), u61 (ref), u72 (copy), Spr (ref), u51 (copy), EventShopConfigData (ref), ReplicatedStorage (ref), u59 (copy), u55 (ref)
                            local Data = DataService:GetData();
                            local v83 = Data and Data.EventShopStock and Data.EventShopStock[u22];
                            local v84 = v83 and v83.Stocks and v83.Stocks[i];
                            local v85 = v84 and v84.Stock or 0;
                            local v86 = not NPCLevelHandler:HasRequiredNPCLevels(v.LevelLocks);

                            if v86 then
                                Spr.stop(u72);
                                u51.Stock_Text.Text = "";
                            elseif u71 or not u61 then
                                u71 = false;
                                u72.Value = v85;
                            else
                                Spr.target(u72, 1, 1.5, {
                                    Value = v85
                                });
                            end;

                            local UnlockedEventShopItems = Data.UnlockedEventShopItems;
                            local v87;

                            if EventShopConfigData.GetConfig(u22).SHOP_LOCK_TYPE == "EVENT" then
                                local _ = ReplicatedStorage.Data.ReplicatedGlobalStock.GiftsGiven;
                                v87 = false;
                            else
                                v87 = not table.find(UnlockedEventShopItems, i) and v.LockedInShop;
                            end;

                            if v87 then
                                u51.LockedFrame.Visible = true;
                                u51.LockedFrame.UnlockInfo.Text = v.UnlockText;
                            elseif v86 and v.LevelLocks then
                                local v88 = next(v.LevelLocks);
                                local v89 = v88 and v.LevelLocks[v88] or 1;
                                u51.LockedFrame.Visible = true;
                                u51.LockedFrame.UnlockInfo.Text = `NPC Friend Level Needed: Level {v89}`;
                            else
                                u51.LockedFrame.Visible = false;
                            end;

                            u59.Sheckles_Buy.In_Stock.Visible = v85 > 0;
                            u59.Sheckles_Buy.No_Stock.Visible = v85 <= 0;
                            u59.Sheckles_Buy.HoverImage = v85 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                            u59.Sheckles_Buy.Image = v85 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                            u59.Sheckles_Buy.Visible = not v86;
                            local v90 = u51.Cost_Text:FindFirstChild("TEXT") or u51.Cost_Text;

                            if v86 and v.LevelLocks then
                                local v91 = next(v.LevelLocks);
                                v90.Text = `LOCKED: lvl{v91 and v.LevelLocks[v91] or 1}+`;
                                v90.TextColor3 = Color3.fromRGB(255, 0, 0);
                            else
                                v90.Text = v85 <= 0 and "NO STOCK" or u55;
                                local v92;

                                if v85 <= 0 then
                                    v92 = Color3.fromRGB(255, 0, 0);
                                else
                                    v92 = Color3.fromRGB(0, 255, 0);
                                end;

                                v90.TextColor3 = v92;
                            end;

                            if u51.Cost_Text:FindFirstChild("CurrencyImage") and v.SpecialCurrencyType then
                                u51.Cost_Text.CurrencyImage.Visible = v85 > 0;
                            end;
                        end;

                        task.spawn(u75);
                        task.spawn(function() -- Line: 838
                            -- upvalues: DataService (ref), u75 (copy), u20 (ref)
                            local PathSignal = DataService:GetPathSignal("EventShopStock/@");

                            if PathSignal then
                                local v93 = PathSignal:Connect(u75);
                                table.insert(u20, v93);
                            end;

                            local PathSignal2 = DataService:GetPathSignal("EventShopStock");

                            if PathSignal2 then
                                local v94 = PathSignal2:Connect(u75);
                                table.insert(u20, v94);
                            end;

                            local PathSignal3 = DataService:GetPathSignal("UnlockedEventShopItems");

                            if PathSignal3 then
                                local v95 = PathSignal3:Connect(u75);
                                table.insert(u20, v95);
                            end;

                            task.spawn(function() -- Line: 858
                                -- upvalues: DataService (ref), u75 (ref), u20 (ref)
                                local PathSignal4 = DataService:GetPathSignal("NPCPoints/@");

                                if PathSignal4 then
                                    local v96 = PathSignal4:Connect(u75);
                                    table.insert(u20, v96);
                                end;
                            end);
                        end);
                    end;
                else
                    warn((`Wrong Event: Current({LoadedEvent.EventSet}) | Config({Config.EVENT_SET})`));
                end;
            elseif not u12.CurrentCategory or u12.CurrentCategory == u12.DefaultCategory then
                u50 = u9:Clone();
                u19[i] = u50;
                u50.Name = i;
                u50.LayoutOrder = v.LayoutOrder * 10;
                table.insert(v49, u50);
                u51 = u50.Main_Frame;
                v52 = Item_Module.Return_Rarity_Data(v.SeedRarity);

                if v52 then
                    SetupRarityEffects(u51, v52);
                end;

                u51.Seed_Text.Text = ItemNameFinder(v.SeedName, v.ItemType) or v.SeedName;
                u51.Seed_Text_Shadow.Text = ItemNameFinder(v.SeedName, v.ItemType) or v.SeedName;
                v53 = LocalPlayer:GetAttribute("NewYearsEggPriceMultiplier");
                v54 = v53 == "Multiplier_X0.1" and 0.1 or (v53 == "Multiplier_X10" and 10 or 1);

                if v.SpecialCurrencyType then
                    u55 = NumberUtil.FormatCompactPrice(v.Price * v54) .. "";
                else
                    u55 = NumberUtil.DisplaySheckles(v.Price * v54);
                end;

                u51.Description_Text.Text = ItemDescriptionFinder(v.SeedName, v.ItemType) or v.Description;

                if u51.Description_Text.Text == "" then
                    u51.InfoButton.Visible = false;
                else
                    u51.LargeDescriptionText.Text = ItemDescriptionFinder(v.SeedName, v.ItemType) or v.Description;
                    u51.InfoButton.Visible = true;
                end;

                u51.LargeDescriptionText.Visible = false;
                u56 = false;
                u51.InfoButton.Activated:Connect(function() -- Line: 467, Name: ToggleDescriptionVisibility
                    -- upvalues: u56 (ref), u51 (copy)
                    u56 = not u56;
                    u51.LargeDescriptionText.Visible = u56;
                    u51.Rarity_BG.Visible = not u56;
                    u51.Rarity_Text.Visible = not u56;
                    u51.Stock_Text.Visible = not u56;
                    u51.Cost_Text.Visible = not u56;
                end);

                if u51.Cost_Text:FindFirstChild("TEXT") then
                    u51.Cost_Text.TEXT.Text = u55;
                else
                    u51.Cost_Text.Text = u55;
                end;

                v57 = u51:FindFirstChild("ShopItem_Image", true);
                v57.Visible = true;
                v57.Image = ItemImageFinder(i, v.ItemType);
                u50.Parent = u5;
                u58 = u10:Clone();
                u58.LayoutOrder = v.LayoutOrder * 10 + 1;
                u58.Name = `{i}_Padding`;
                u58.Parent = u5;
                u19[u58.Name] = u58;
                u59 = u50.Frame;

                if u59.Sheckles_Buy.In_Stock.Cost_Text:FindFirstChild("TEXT") then
                    u59.Sheckles_Buy.In_Stock.Cost_Text.TEXT.Text = u55;
                else
                    u59.Sheckles_Buy.In_Stock.Cost_Text.Text = u55;
                end;

                v60 = function() -- Line: 508, Name: buy
                    -- upvalues: BuyEventShopStock (ref), i (copy), u22 (ref)
                    BuyEventShopStock:FireServer(i, u22);
                end;

                u61 = false;
                u62 = 0;
                WatchButtonHold(u59.Sheckles_Buy, function(p76: number, p77: boolean?) -- Line: 518
                    -- upvalues: u62 (ref), u61 (ref), u59 (copy), Spr (ref), BuyEventShopStock (ref), i (copy), u22 (ref)
                    if workspace:GetAttribute("InTutorial") then
                        return;
                    end;

                    if p77 then
                        u62 = 0;

                        if u61 then
                            u61 = false;

                            if u59:FindFirstChild("Sheckles_Buy") then
                                Spr.target(u59.Sheckles_Buy, 0.8, 2, {
                                    ImageColor3 = Color3.new(1, 1, 1)
                                });
                            end;
                        end;

                        return;
                    end;

                    if not u61 then
                        u61 = true;

                        if u59:FindFirstChild("Sheckles_Buy") then
                            Spr.target(u59.Sheckles_Buy, 0.8, 2, {
                                ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                            });
                        end;
                    end;

                    if os.clock() < u62 then
                        return;
                    end;

                    local v78 = ((1 - math.exp(p76 * -0.3)) * 24 + 8) // 1;
                    local math_max_ret = math.max(v78, 1);
                    u62 = os.clock() + 0.125;

                    for i2 = 1, math_max_ret do
                        BuyEventShopStock:FireServer(i, u22);
                        local _ = i2;
                    end;
                end, {
                    minimumHoldTime = 1,
                    interval = 0.125
                });
                u59.Sheckles_Buy.Activated:Connect(v60);
                v63 = u59.Robux_Buy;

                if v.PurchaseID == nil then
                    v64 = false;
                else
                    v64 = v.PurchaseID > 0;
                end;

                v63.Visible = v64;
                u59.Robux_Buy.Activated:Connect(function() -- Line: 565
                    -- upvalues: MarketController (ref), v (copy)
                    MarketController:PromptPurchase(v.PurchaseID, Enum.InfoType.Product);
                end);
                u59.Gift.Visible = v.GiftPurchaseID ~= nil;

                if v.GiftPurchaseID then
                    u59.Gift.Activated:Connect(function() -- Line: 571
                        -- upvalues: Click (ref), GiftController (ref), v (copy)
                        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        Click.TimePosition = 0;
                        Click.Playing = true;
                        GiftController:PromptGiftFromGiftId(v.GiftPurchaseID);
                    end);
                end;

                if v.ItemType == "Seed" then
                    u65 = nil;
                    u66 = nil;
                    u51.MouseEnter:Connect(function() -- Line: 584
                        -- upvalues: u65 (ref), FastTween (ref), u50 (copy), u66 (ref), ItemImageFinder (ref), i (copy)
                        u65 = FastTween(u50.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                            Rotation = u50.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                        });
                        u66 = FastTween(u50.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                            Scale = 1.5
                        });
                        u66.Completed:Connect(function(p79) -- Line: 600
                            -- upvalues: u50 (ref), ItemImageFinder (ref), i (ref)
                            if p79 == Enum.PlaybackState.Completed then
                                if not u50:IsDescendantOf(game) then
                                    return;
                                end;

                                u50.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, "Holdable");
                            end;
                        end);
                    end);
                    u51.MouseLeave:Connect(function() -- Line: 611
                        -- upvalues: u65 (ref), u50 (copy), ItemImageFinder (ref), i (copy), v (copy), FastTween (ref)
                        if u65 then
                            u65:Cancel();
                        end;

                        u50.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                        u50.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, v.ItemType);
                        FastTween(u50.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                            Scale = 1
                        });
                    end);
                end;

                if v.ShowOdds then
                    ItemOddsController:ConnectOddsButton({
                        Type = v.ItemType,
                        Value = v.SeedName
                    }, u51.OddsButton, u4);
                else
                    u51.OddsButton.Visible = false;
                end;

                if v.SpecialCurrencyType and CurrencyData[v.SpecialCurrencyType] then
                    u51.Cost_Text.CurrencyImage.Image = CurrencyData[v.SpecialCurrencyType].Icon;
                    u59.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Image = CurrencyData[v.SpecialCurrencyType].Icon;
                else
                    u51.Cost_Text.CurrencyImage.Visible = false;
                    u59.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Visible = false;
                end;

                v67 = function() -- Line: 651, Name: updateOptions
                    -- upvalues: u2 (ref), i (copy), u59 (copy), FastTween (ref), u58 (copy)
                    if u2 == i then
                        u59.Visible = true;
                        FastTween(u59, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Position = UDim2.fromScale(0.5, 1.3)
                        });
                        FastTween(u58, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(0.13, 0.25)
                        });

                        return;
                    end;

                    task.delay(0.25, function() -- Line: 663
                        -- upvalues: u59 (ref)
                        if u59.Position == UDim2.fromScale(0.5, 0.5) then
                            u59.Visible = false;
                        end;
                    end);
                    FastTween(u59, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0.5, 0.5)
                    });
                    FastTween(u58, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0.13, 0.02)
                    });
                end;

                v68 = u20;
                v69 = u3:Connect(v67);
                table.insert(v68, v69);
                task.spawn(v67);
                u70 = false;
                u51.Activated:Connect(function() -- Line: 683
                    -- upvalues: u51 (copy), u5 (ref), u50 (copy), FastTween (ref), u2 (ref), i (copy), u3 (ref), u70 (ref), UseDynamicPrices (ref), v (copy), u59 (copy), MarketController (ref), Comma_Module (ref)
                    local v80 = (u51.AbsolutePosition.Y - u5.AbsolutePosition.Y + u5.CanvasPosition.Y + (u50.AbsolutePosition.Y + u50.AbsoluteSize.Y - u5.AbsolutePosition.Y + u5.CanvasPosition.Y)) / 2 - u5.AbsoluteSize.Y / 2;
                    local math_max_ret = math.max(0, u5.AbsoluteCanvasSize.Y - u5.AbsoluteSize.Y);
                    local math_clamp_ret = math.clamp(v80, 0, math_max_ret);
                    FastTween(u5, TweenInfo.new(0.35), {
                        CanvasPosition = Vector2.new(0, math_clamp_ret)
                    });
                    local v81;

                    if u2 == i then
                        v81 = nil;
                    else
                        v81 = i;
                    end;

                    u2 = v81;
                    u3:Fire();

                    if not u70 then
                        if UseDynamicPrices or v.FallbackPrice == nil then
                            if not UseDynamicPrices then
                                warn((`{u59:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                            end;

                            MarketController:SetPriceLabel(u59.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                        else
                            u59.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                        end;

                        u70 = true;
                    end;
                end);

                if u2 == i then
                    task.spawn(function() -- Line: 720
                        -- upvalues: UseDynamicPrices (ref), v (copy), u59 (copy), MarketController (ref), Comma_Module (ref), u70 (ref)
                        if UseDynamicPrices or v.FallbackPrice == nil then
                            if not UseDynamicPrices then
                                warn((`{u59:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                            end;

                            MarketController:SetPriceLabel(u59.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                        else
                            u59.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                        end;

                        u70 = true;
                    end);
                end;

                u71 = true;
                u72 = Instance.new("NumberValue");
                u72.Value = 0;
                u72.Parent = u59;
                v73 = u20;
                v74 = u72.Changed:Connect(function(p82: number) -- Line: 741
                    -- upvalues: u51 (copy)
                    if u51.Stock_Text then
                        u51.Stock_Text.Text = `X{p82 // 1} Stock`;
                    end;
                end);
                table.insert(v73, v74);

                u75 = function() -- Line: 748, Name: updateStock
                    -- upvalues: DataService (ref), u22 (ref), i (copy), NPCLevelHandler (ref), v (copy), u71 (ref), u61 (ref), u72 (copy), Spr (ref), u51 (copy), EventShopConfigData (ref), ReplicatedStorage (ref), u59 (copy), u55 (ref)
                    local Data = DataService:GetData();
                    local v83 = Data and Data.EventShopStock and Data.EventShopStock[u22];
                    local v84 = v83 and v83.Stocks and v83.Stocks[i];
                    local v85 = v84 and v84.Stock or 0;
                    local v86 = not NPCLevelHandler:HasRequiredNPCLevels(v.LevelLocks);

                    if v86 then
                        Spr.stop(u72);
                        u51.Stock_Text.Text = "";
                    elseif u71 or not u61 then
                        u71 = false;
                        u72.Value = v85;
                    else
                        Spr.target(u72, 1, 1.5, {
                            Value = v85
                        });
                    end;

                    local UnlockedEventShopItems = Data.UnlockedEventShopItems;
                    local v87;

                    if EventShopConfigData.GetConfig(u22).SHOP_LOCK_TYPE == "EVENT" then
                        local _ = ReplicatedStorage.Data.ReplicatedGlobalStock.GiftsGiven;
                        v87 = false;
                    else
                        v87 = not table.find(UnlockedEventShopItems, i) and v.LockedInShop;
                    end;

                    if v87 then
                        u51.LockedFrame.Visible = true;
                        u51.LockedFrame.UnlockInfo.Text = v.UnlockText;
                    elseif v86 and v.LevelLocks then
                        local v88 = next(v.LevelLocks);
                        local v89 = v88 and v.LevelLocks[v88] or 1;
                        u51.LockedFrame.Visible = true;
                        u51.LockedFrame.UnlockInfo.Text = `NPC Friend Level Needed: Level {v89}`;
                    else
                        u51.LockedFrame.Visible = false;
                    end;

                    u59.Sheckles_Buy.In_Stock.Visible = v85 > 0;
                    u59.Sheckles_Buy.No_Stock.Visible = v85 <= 0;
                    u59.Sheckles_Buy.HoverImage = v85 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                    u59.Sheckles_Buy.Image = v85 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                    u59.Sheckles_Buy.Visible = not v86;
                    local v90 = u51.Cost_Text:FindFirstChild("TEXT") or u51.Cost_Text;

                    if v86 and v.LevelLocks then
                        local v91 = next(v.LevelLocks);
                        v90.Text = `LOCKED: lvl{v91 and v.LevelLocks[v91] or 1}+`;
                        v90.TextColor3 = Color3.fromRGB(255, 0, 0);
                    else
                        v90.Text = v85 <= 0 and "NO STOCK" or u55;
                        local v92;

                        if v85 <= 0 then
                            v92 = Color3.fromRGB(255, 0, 0);
                        else
                            v92 = Color3.fromRGB(0, 255, 0);
                        end;

                        v90.TextColor3 = v92;
                    end;

                    if u51.Cost_Text:FindFirstChild("CurrencyImage") and v.SpecialCurrencyType then
                        u51.Cost_Text.CurrencyImage.Visible = v85 > 0;
                    end;
                end;

                task.spawn(u75);
                task.spawn(function() -- Line: 838
                    -- upvalues: DataService (ref), u75 (copy), u20 (ref)
                    local PathSignal = DataService:GetPathSignal("EventShopStock/@");

                    if PathSignal then
                        local v93 = PathSignal:Connect(u75);
                        table.insert(u20, v93);
                    end;

                    local PathSignal2 = DataService:GetPathSignal("EventShopStock");

                    if PathSignal2 then
                        local v94 = PathSignal2:Connect(u75);
                        table.insert(u20, v94);
                    end;

                    local PathSignal3 = DataService:GetPathSignal("UnlockedEventShopItems");

                    if PathSignal3 then
                        local v95 = PathSignal3:Connect(u75);
                        table.insert(u20, v95);
                    end;

                    task.spawn(function() -- Line: 858
                        -- upvalues: DataService (ref), u75 (ref), u20 (ref)
                        local PathSignal4 = DataService:GetPathSignal("NPCPoints/@");

                        if PathSignal4 then
                            local v96 = PathSignal4:Connect(u75);
                            table.insert(u20, v96);
                        end;
                    end);
                end);
            end;
        end;
    end;

    if u46 then
        u46();
    end;

    table.sort(v49, function(p97, p98) -- Line: 876
        local LayoutOrder = p97.LayoutOrder;
        local LayoutOrder2 = p98.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p97.Name < p98.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);
end;

local function UpdateRestockButton() -- Line: 886
    -- upvalues: UpdateService (copy), u4 (ref), DataService (copy), u22 (ref), EventShopConfigData (copy), NumberUtil (copy)
    if UpdateService:IsHiddenAfterUpdate("Event Shop Restock") or UpdateService:IsHiddenFromUpdate("Event Shop Restock") then
        u4.Frame.Frame.RestockButton.Visible = true;
        u4.Frame.Frame.RestockInfo.Visible = true;

        return;
    end;

    u4.Frame.Frame.RestockButton.Visible = true;
    u4.Frame.Frame.RestockInfo.Visible = false;
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    if not Data.EventShopStock[u22] then
        task.wait(2);
    end;

    if not Data.EventShopStock[u22] then
        u4.Frame.Frame.RestockButton.Visible = false;
        u4.Frame.Frame.RestockInfo.Visible = false;

        return;
    end;

    local Config = EventShopConfigData.GetConfig(u22);
    local TextLabel = u4.Frame.Frame.RestockButton.TextLabel;

    if Config.RESTOCK_CURRENCY == "ROBUX" then
        TextLabel.Text = "RESTOCK";

        return;
    end;

    local math_max_ret = math.max(Config.BASE_RESTOCK_COST, Data.EventShopStock[u22].RestockCost);

    if Config.RESTOCK_CURRENCY == "Sheckles" then
        TextLabel.Text = `RESTOCK: {NumberUtil.FormatCompactPrice(math_max_ret)}¢`;

        return;
    end;

    TextLabel.Text = `RESTOCK: {NumberUtil.FormatCompactPrice(math_max_ret)}`;
end;

local function ToggleUsualUI(p99: boolean) -- Line: 929
    -- upvalues: PlayerGui (copy)
    local BackpackGui = PlayerGui:WaitForChild("BackpackGui");
    local Teleport_UI = PlayerGui:WaitForChild("Teleport_UI");
    local Hud_UI = PlayerGui:WaitForChild("Hud_UI");
    BackpackGui.Enabled = p99;
    Teleport_UI.Enabled = p99;
    Hud_UI.Enabled = p99;
end;

local u100 = nil;

local function GetStockOddsButton() -- Line: 944
    -- upvalues: u4 (ref)
    if not u4 then
        return nil;
    end;

    local Frame = u4:FindFirstChild("Frame");

    if Frame then
        Frame = Frame:FindFirstChild("Frame");
    end;

    if Frame then
        Frame = Frame:FindFirstChild("Odds");
    end;

    if not Frame then
        return nil;
    end;

    local OddsButton = Frame:FindFirstChild("OddsButton");

    if OddsButton and OddsButton:IsA("GuiButton") then
        return OddsButton;
    end;

    return nil;
end;

local function GetStockOddsFrame() -- Line: 966
    -- upvalues: u4 (ref)
    if not u4 then
        return nil;
    end;

    local Frame = u4:FindFirstChild("Frame");

    if Frame then
        Frame = Frame:FindFirstChild("Frame");
    end;

    if Frame then
        Frame = Frame:FindFirstChild("Odds");
    end;

    if Frame and Frame:IsA("GuiObject") then
        return Frame;
    end;

    return nil;
end;

local function BuildStockOddsRewardData() -- Line: 982
    -- upvalues: EventShopData (copy), u22 (ref), u19 (copy), UpdateService (copy)
    local v101 = EventShopData[u22];

    if not v101 then
        return {};
    end;

    local v102 = {};

    for i, v in v101 do
        local v103 = u19[i];

        if v103 and (v.StockChance and (v.DisplayInShop and not (UpdateService:IsHiddenFromUpdate(v.SeedName) or UpdateService:IsHiddenAfterUpdate(v.SeedName)))) then
            local v104 = {
                Reward = {
                    Quantity = 1,
                    Type = v.ItemType,
                    Value = i
                },
                Weight = math.clamp(1 / v.StockChance, 0, 1),
                ShopLayoutOrder = v103.LayoutOrder
            };
            table.insert(v102, v104);
        end;
    end;

    return v102;
end;

local function OpenStockOdds() -- Line: 1024
    -- upvalues: u22 (ref), EventShopConfigData (copy), BuildStockOddsRewardData (copy), u4 (ref), GenericRewardsUIController (copy)
    if u22 == "" then
        return;
    end;

    if not EventShopConfigData.GetShowStockOddsButton(u22) then
        return;
    end;

    local v105 = BuildStockOddsRewardData();

    if #v105 == 0 then
        return;
    end;

    local u106 = {};
    local Frame = u4:FindFirstChild("Frame");

    if Frame then
        Frame = Frame:FindFirstChild("Frame");
    end;

    GenericRewardsUIController:Open({
        Title = "Stock Odds",
        DisplayOdds = true,
        RewardData = v105,
        Breadcrumb = u4,
        HeaderColor = Frame.BackgroundColor3 or Color3.fromRGB(255, 213, 0),

        RewardFrameCreatedCallback = function(p107, p108) -- Line: 1050, Name: RewardFrameCreatedCallback
            -- upvalues: u106 (copy)
            u106[p107] = p108.ShopLayoutOrder;
        end,

        RewardsUIBuiltCallback = function() -- Line: 1053, Name: RewardsUIBuiltCallback
            -- upvalues: u106 (copy)
            for i, v in u106 do
                i.LayoutOrder = v;
            end;
        end
    });
end;

u46 = function() -- Line: 1061
    -- upvalues: u4 (ref), GetStockOddsButton (copy), EventShopConfigData (copy), u22 (ref), BuildStockOddsRewardData (copy), u17 (copy), OpenStockOdds (copy)
    local v109;

    if u4 then
        v109 = u4:FindFirstChild("Frame");

        if v109 then
            v109 = v109:FindFirstChild("Frame");
        end;

        if v109 then
            v109 = v109:FindFirstChild("Odds");
        end;

        if not (v109 and v109:IsA("GuiObject")) then
            v109 = nil;
        end;
    else
        v109 = nil;
    end;

    local v110 = GetStockOddsButton();

    if not (v109 and v110) then
        return;
    end;

    local v111 = EventShopConfigData.GetShowStockOddsButton(u22) and #BuildStockOddsRewardData() > 0;
    v109.Visible = v111;

    if u17[v110] then
        return;
    end;

    u17[v110] = true;
    v110.Activated:Connect(OpenStockOdds);
end;

local function BindShopUI(p112: string) -- Line: 1081
    -- upvalues: EventShopConfigData (copy), PlayerGui (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u15 (copy), u16 (copy), u9 (ref), u10 (ref), u11 (ref), u12 (ref), UITabHelperModule (copy), TabButtonTemplate (copy), u14 (copy), u100 (ref), UpdateService (copy), u13 (copy), GuiController (copy), u22 (ref), MarketController (copy), BuyEventShopRestock (copy), UpdateRestockButton (copy)
    u4 = PlayerGui:FindFirstChild(EventShopConfigData.GetShopUIName(p112), true);
    u5 = u4:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
    u6 = u4:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("RestocksIn"):WaitForChild("Timer");
    u7 = u4:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("EventShopTitle");
    u8 = u4:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("EventShopTitle"):WaitForChild("EventShopTitle");

    if not u15[u4] then
        local ItemFrame = u5:WaitForChild("ItemFrame");
        local ItemPadding = u5:WaitForChild("ItemPadding");
        u15[u4] = ItemFrame:Clone();
        u16[u4] = ItemPadding:Clone();
        u15[u4].Parent = nil;
        u16[u4].Parent = nil;
        ItemFrame.Visible = false;
        ItemPadding.Visible = false;
    end;

    u9 = u15[u4];
    u10 = u16[u4];
    u11 = u4:WaitForChild("TabAnchor"):WaitForChild("TabList");
    u12 = UITabHelperModule.CreateOrGetTabHandler("EventShop", u11, TabButtonTemplate);

    if not u14[u12] then
        u14[u12] = true;
        u12.OnCategoryChanged:Connect(u100);
    end;

    local LinkedShops = EventShopConfigData.GetLinkedShops(p112);

    if LinkedShops and #LinkedShops > 0 then
        local v113 = {};
        local v114 = nil;

        for _, v in LinkedShops do
            if UpdateService:IsActive(v.Index) then
                table.insert(v113, {
                    IsLocked = false,
                    Name = v.Label,
                    Color = v.Color
                });

                if v.Index == p112 then
                    v114 = v.Label;
                end;
            end;
        end;

        local v115;

        if #LinkedShops == 2 then
            v115 = #v113 == 1;
        else
            v115 = false;
        end;

        if v115 then
            u12.SetCategories({});
            u12.CurrentCategory = nil;
            u12.DefaultCategory = nil;
        else
            if v114 then
                u12.CurrentCategory = v114;
                u12.DefaultCategory = v114;
            end;

            u12.SetCategories(v113);
        end;
    else
        u12.SetCategories({});
        u12.CurrentCategory = nil;
        u12.DefaultCategory = nil;
    end;

    if u13[u4] then
        return;
    end;

    u13[u4] = true;
    GuiController:UsePopupAnims(u4);
    u4.Frame.Frame.CloseButton.Activated:Connect(function() -- Line: 1161
        -- upvalues: GuiController (ref), u4 (ref)
        GuiController:Close(u4);
    end);
    u4:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1165
        -- upvalues: u4 (ref), PlayerGui (ref)
        local v116 = not u4.Enabled;
        local BackpackGui = PlayerGui:WaitForChild("BackpackGui");
        local Teleport_UI = PlayerGui:WaitForChild("Teleport_UI");
        local Hud_UI = PlayerGui:WaitForChild("Hud_UI");
        BackpackGui.Enabled = v116;
        Teleport_UI.Enabled = v116;
        Hud_UI.Enabled = v116;
    end);
    u4.Frame.Frame.RestockButton.Activated:Connect(function() -- Line: 1169
        -- upvalues: EventShopConfigData (ref), u22 (ref), MarketController (ref), BuyEventShopRestock (ref), UpdateRestockButton (ref)
        if EventShopConfigData.GetConfig(u22).RESTOCK_CURRENCY == "ROBUX" then
            MarketController:PromptPurchase(3471912100, Enum.InfoType.Product);
        else
            BuyEventShopRestock:FireServer(u22);
        end;

        task.spawn(function() -- Line: 1176
            -- upvalues: UpdateRestockButton (ref)
            task.wait(0.5);
            UpdateRestockButton();
        end);
    end);
end;

local PathSignal = DataService:GetPathSignal("EventShopStock/@");

if PathSignal then
    PathSignal:Connect(function() -- Line: 1186
        -- upvalues: u4 (ref), UpdateRestockButton (copy)
        if not u4 then
            return;
        end;

        UpdateRestockButton();
    end);
end;

local function UnlockTabVisibility() -- Line: 1195
    -- upvalues: u18 (copy), EventShopConfigData (copy), u22 (ref), ShopTabHandler (copy), u12 (ref)
    for _, v in u18 do
        local v117 = ShopTabHandler:IsTabUnlocked(EventShopConfigData.GetConfig(u22).SHOP_TYPE, v.Name);

        if v.IsLocked and v117 then
            u12.UnlockTab(v.Name);
        end;
    end;
end;

local function SetupTabs() -- Line: 1207
    -- upvalues: u12 (ref), u18 (copy), UnlockTabVisibility (copy)
    u12.SetCategories(u18);
    u12.DefaultCategory = "Main";
    u12.SetCurrentCategory(u12.DefaultCategory);
    UnlockTabVisibility();
end;

u100 = function(p118: string) -- Line: 1216
    -- upvalues: u22 (ref), EventShopConfigData (copy), ReplicatedStorage (copy), u21 (copy), SetupFrames (copy), u2 (ref), u3 (copy)
    local v119 = u22 ~= "" and EventShopConfigData.GetLinkedShops(u22);

    if v119 then
        for _, v in v119 do
            if v.Label == p118 then
                if v.Index == "SEED_SHOP" then
                    local GuiController2 = require(ReplicatedStorage.Modules.GuiController);
                    local Players = game:GetService("Players");
                    local PlayerGui2 = Players.LocalPlayer.PlayerGui;
                    Players.LocalPlayer:SetAttribute("OpenedFromHoneyShop", u22);
                    GuiController2:Open(PlayerGui2:WaitForChild("Seed_Shop"));

                    return;
                end;

                if v.Index ~= u22 then
                    local Index = v.Index;
                    task.defer(function() -- Line: 1234
                        -- upvalues: u21 (ref), Index (copy)
                        u21:Open(Index);
                    end);

                    return;
                end;
            end;
        end;
    end;

    SetupFrames();
    u2 = nil;
    u3:Fire();
end;

function u21.Recreate(p120: table, p121: string) -- Line: 1252
    -- upvalues: u22 (ref), BindShopUI (copy), SetupFrames (copy), u46 (ref), UpdateRestockButton (copy), u21 (copy)
    u22 = p121;
    BindShopUI(p121);
    SetupFrames();

    if u46 then
        u46();
    end;

    UpdateRestockButton();
    u21:SetTitle(p121);
end;

function u21.Prewarm(p122: table, p123: string) -- Line: 1263
    -- upvalues: u21 (copy)
    u21:Recreate(p123);
end;

function u21.SetTitle(p124: table, p125: string) -- Line: 1267
    -- upvalues: u7 (ref), u8 (ref), u5 (ref)
    u7.Text = p125;
    u8.Text = p125;
    u5.CanvasPosition = Vector2.new(0, 0);
end;

function u21.Start(p126) -- Line: 1274
    -- upvalues: DataService (copy), UnlockTabVisibility (copy)
    task.spawn(function() -- Line: 1285
        -- upvalues: DataService (ref), UnlockTabVisibility (ref)
        local PathSignal2 = DataService:GetPathSignal("ShopTabData/@");

        if PathSignal2 then
            PathSignal2:Connect(UnlockTabVisibility);
        end;
    end);
end;

local Christmas_Bell_Shop_SFX = game.SoundService.Christmas_Bell_Shop_SFX;

function u21.Open(p127: table, p128: string) -- Line: 1310
    -- upvalues: UpdateService (copy), Christmas_Bell_Shop_SFX (copy), u4 (ref), GuiController (copy), PlayerGui (copy), u2 (ref), u21 (copy)
    if not UpdateService:IsActive(p128) then
        return;
    end;

    Christmas_Bell_Shop_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Christmas_Bell_Shop_SFX.TimePosition = 0;
    Christmas_Bell_Shop_SFX.Playing = true;

    if u4 then
        GuiController:Close(u4);
    end;

    local PetShop_UI = PlayerGui:FindFirstChild("PetShop_UI");

    if PetShop_UI and PetShop_UI:IsA("ScreenGui") then
        GuiController:Close(PetShop_UI);
        PetShop_UI.Enabled = false;
    end;

    u2 = nil;
    u21:Recreate(p128);
    GuiController:Open(u4);
end;

function u21.GetCurrentIndex(p129) -- Line: 1334
    -- upvalues: u22 (ref)
    return u22;
end;

task.spawn(u21.Start, u21);
UpdateService.OnUpdated:Connect(function() -- Line: 1340
    -- upvalues: SetupTimer (copy), SetupFrames (copy), u46 (ref)
    task.spawn(SetupTimer);
    SetupFrames();

    if u46 then
        u46();
    end;
end);

return u21;