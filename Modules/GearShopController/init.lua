-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local Gear_Shop = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Gear_Shop");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local Spr = require(ReplicatedStorage.Code.Spr);
local Spring = require(ReplicatedStorage.Modules.Spring);
local GearShopData = require(ReplicatedStorage.Data.GearShopData);
local GearShopData2 = require(ReplicatedStorage.Data.GearShopData);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Modules.RetryPcall);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local SoundPlayer = require(game.ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(game.ReplicatedStorage.Data.SoundData);
local NPCLevelHandler = require(ReplicatedStorage.Modules.NPCLevelHandler);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
local ScrollingFrame = Gear_Shop:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
ScrollingFrame:WaitForChild("UIListLayout");
local Timer = Gear_Shop:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local ItemFrame = ScrollingFrame:WaitForChild("ItemFrame");
ItemFrame.Parent = script;
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemPadding.Parent = ScrollingFrame;
local u1 = {};
local u2 = {};
local v3 = {};
local u4 = nil;
local u5 = Signal.new();
local u6 = {};

local function GetRefreshTime() -- Line: 71
    -- upvalues: DataService (copy), GearShopData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local v7 = Data.GearStock.ForcedGearEndTimestamp and (Data.GearStock.ForcedGearEndTimestamp - ServerTimeNow or -1) or -1;

    if v7 >= 0 then
        return v7;
    end;

    return GearShopData.RefreshTime - ServerTimeNow % GearShopData.RefreshTime;
end;

local Click = game.SoundService.Click;
local Restock_SFX = game.SoundService.Restock_SFX;

local function SetupTimer() -- Line: 86
    -- upvalues: DataService (copy), GearShopData (copy), Timer (copy), NumberUtil (copy), TradeWorldController (copy), Restock_SFX (copy), ReplicatedStorage (copy)
    while true do
        local ServerTimeNow = workspace:GetServerTimeNow();
        local Data = DataService:GetData();
        local v8 = Data.GearStock.ForcedGearEndTimestamp and (Data.GearStock.ForcedGearEndTimestamp - ServerTimeNow or -1) or -1;

        if v8 < 0 then
            v8 = GearShopData.RefreshTime - ServerTimeNow % GearShopData.RefreshTime;
        end;

        Timer.Text = v8 <= 0 and "Restocking" or "New gear in " .. NumberUtil.compactFormat(v8);

        if v8 <= 1 and not TradeWorldController:IsInWorld() then
            Restock_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Restock_SFX.TimePosition = 0;
            Restock_SFX.Playing = true;
            require(ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#90EE90\"><b>Your Gear Shop stock has restocked!</b></font>");
        end;

        task.wait(1);
    end;
end;

local function SetupFrames() -- Line: 104
    -- upvalues: u2 (copy), u1 (copy), GearShopData2 (copy), UpdateService (copy), ItemFrame (copy), Item_Module (copy), Gear_Shop (copy), ColorHelper (copy), NumberUtil (copy), ScrollingFrame (copy), ItemPadding (copy), u6 (copy), ReplicatedStorage (copy), WatchButtonHold (copy), Spr (copy), MarketController (copy), Click (copy), GiftController (copy), u4 (ref), FastTween (copy), u5 (copy), UseDynamicPrices (copy), Comma_Module (copy), DataService (copy), NPCLevelHandler (copy), RebirthUnlocksSharedService (copy), LocalPlayer (copy)
    for _, v in ipairs(u2) do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    table.clear(u2);

    for _, v in u1 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    table.clear(u1);

    local function fetchStockInfo(p9: table, p10: string) -- Line: 120
        return p9[p10] or {
            MaxStock = 0,
            Stock = 0
        };
    end;

    local u11 = {};

    for i, v in GearShopData2.Gear do
        if v.LayoutOrder ~= -1 and not (UpdateService:IsHiddenFromUpdate(v.Gear.GearName) or UpdateService:IsHiddenAfterUpdate(v.Gear.GearName)) then
            local u12 = ItemFrame:Clone();
            u1[i] = u12;
            u12.Name = i;
            u12.LayoutOrder = v.LayoutOrder * 10;
            table.insert(u11, u12);
            local Main_Frame = u12.Main_Frame;
            local v13 = Item_Module.Return_Rarity_Data(v.Gear.GearRarity);

            if v13 then
                local v14 = v13[1];
                local v15 = v13[2];
                local v16 = v13[3];
                Main_Frame.Rarity_Text.Text = v14;

                if v16 and v14 == "Prismatic" then
                    local u17 = nil;
                    u17 = game:GetService("RunService").Heartbeat:Connect(function(p18) -- Line: 162
                        -- upvalues: Gear_Shop (ref), Main_Frame (copy), u17 (ref), ColorHelper (ref)
                        if not Gear_Shop.Enabled then
                            return;
                        end;

                        if not (Main_Frame and Main_Frame.Parent) then
                            u17:Disconnect();

                            return;
                        end;

                        local v19 = os.clock() * 0.1 % 1;
                        local Color3_fromHSV_ret = Color3.fromHSV(v19, 1, 1);
                        Main_Frame.Rarity_BG.ImageColor3 = Color3_fromHSV_ret;

                        if Main_Frame.Rarity_Text.UIStroke then
                            Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(Color3_fromHSV_ret);
                        end;
                    end);
                else
                    if Main_Frame.Rarity_Text.UIStroke then
                        Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v15);
                    end;

                    Main_Frame.Rarity_BG.ImageColor3 = v15;
                end;
            end;

            Main_Frame.Gear_Text.Text = v.Gear.GearName;
            Main_Frame.Gear_Text_Shadow.Text = v.Gear.GearName;
            Main_Frame.LargeDescriptionText.Text = v.Gear.GearDescription;
            Main_Frame.LargeDescriptionText.Visible = false;
            local u20 = false;
            Main_Frame.InfoButton.Activated:Connect(function() -- Line: 196, Name: ToggleDescriptionVisibility
                -- upvalues: u20 (ref), Main_Frame (copy)
                u20 = not u20;
                Main_Frame.LargeDescriptionText.Visible = u20;
                Main_Frame.Rarity_BG.Visible = not u20;
                Main_Frame.Rarity_Text.Visible = not u20;
                Main_Frame.Stock_Text.Visible = not u20;
                Main_Frame.Cost_Text.Visible = not u20;
            end);
            Main_Frame.Cost_Text.Text = NumberUtil.DisplaySheckles(v.Price);
            Main_Frame:WaitForChild("Gear_Image").Image = v.Gear.Asset;
            u12.Parent = ScrollingFrame;
            local UDim2_fromScale_ret = UDim2.fromScale(0.13, 0.042);
            local u21 = ItemPadding:Clone();
            u21.LayoutOrder = v.LayoutOrder * 10 + 1;
            u21.Name = i .. "_Padding";
            u21.Parent = ScrollingFrame;
            u1[u21.Name] = u21;
            local Frame = u12.Frame;
            Frame.Sheckles_Buy.In_Stock.Cost_Text.Text = NumberUtil.DisplaySheckles(v.Price);

            local function buy() -- Line: 226
                -- upvalues: u6 (ref), i (copy), ReplicatedStorage (ref)
                if u6[i] then
                    require(ReplicatedStorage.Modules.Notification):CreateNotification("Restocking. Please wait...");

                    return;
                end;

                ReplicatedStorage.GameEvents.BuyGearStock:FireServer(i);
            end;

            local u22 = false;
            local u23 = 0;
            WatchButtonHold(Frame.Sheckles_Buy, function(p24: number, p25: boolean?) -- Line: 242
                -- upvalues: u23 (ref), u22 (ref), Frame (copy), Spr (ref), u6 (ref), i (copy), ReplicatedStorage (ref)
                if workspace:GetAttribute("InTutorial") then
                    return;
                end;

                if p25 then
                    u23 = 0;

                    if u22 then
                        u22 = false;

                        if Frame:FindFirstChild("Sheckles_Buy") then
                            Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                                ImageColor3 = Color3.new(1, 1, 1)
                            });
                        end;
                    end;

                    return;
                end;

                if not u22 then
                    u22 = true;

                    if Frame:FindFirstChild("Sheckles_Buy") then
                        Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                            ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                        });
                    end;
                end;

                if os.clock() < u23 then
                    return;
                end;

                local v26 = ((1 - math.exp(p24 * -0.3)) * 24 + 8) // 1;
                local math_max_ret = math.max(v26, 1);
                u23 = os.clock() + 0.125;

                for i2 = 1, math_max_ret do
                    local v27;

                    if u6[i] then
                        require(ReplicatedStorage.Modules.Notification):CreateNotification("Restocking. Please wait...");
                        v27 = i2;
                    else
                        ReplicatedStorage.GameEvents.BuyGearStock:FireServer(i);
                        v27 = i2;
                    end;
                end;
            end, {
                minimumHoldTime = 1,
                interval = 0.125
            });
            Frame.Sheckles_Buy.Activated:Connect(buy);
            Frame.Robux_Buy.Activated:Connect(function() -- Line: 289
                -- upvalues: MarketController (ref), v (copy)
                MarketController:PromptPurchase(v.PurchaseID, Enum.InfoType.Product);
            end);
            Frame.Gift.Visible = v.GiftPurchaseID ~= nil;

            if v.GiftPurchaseID then
                Frame.Gift.Activated:Connect(function() -- Line: 295
                    -- upvalues: Click (ref), GiftController (ref), v (copy)
                    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    Click.TimePosition = 0;
                    Click.Playing = true;
                    GiftController:PromptGiftFromGiftId(v.GiftPurchaseID);
                end);
            end;

            local function updateOptions() -- Line: 303
                -- upvalues: u4 (ref), i (copy), Frame (copy), FastTween (ref), u21 (copy), UDim2_fromScale_ret (copy)
                if u4 == i then
                    Frame.Visible = true;
                    FastTween(Frame, TweenInfo.new(0.25), {
                        Position = UDim2.fromScale(0.515, 1.38)
                    });
                    FastTween(u21, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0.13, 0.28)
                    });

                    return;
                end;

                Frame.Visible = false;
                FastTween(Frame, TweenInfo.new(0.25), {
                    Position = UDim2.fromScale(0.5, 0.5)
                });
                FastTween(u21, TweenInfo.new(0.25), {
                    Size = UDim2_fromScale_ret
                });
            end;

            u5:Connect(updateOptions);
            task.spawn(updateOptions);
            local u28 = false;
            Main_Frame.Activated:Connect(function() -- Line: 319
                -- upvalues: u11 (copy), u12 (copy), FastTween (ref), ScrollingFrame (ref), UDim2_fromScale_ret (copy), u4 (ref), i (copy), u5 (ref), u28 (ref), UseDynamicPrices (ref), v (copy), Frame (copy), MarketController (ref), Comma_Module (ref)
                local v29 = table.find(u11, u12) or 1;
                FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                    CanvasPosition = Vector2.new(0, (u12.AbsoluteSize.Y + UDim2_fromScale_ret.Y.Scale * ScrollingFrame.AbsoluteSize.Y) * (v29 - 1))
                });
                local v30;

                if u4 == i then
                    v30 = nil;
                else
                    v30 = i;
                end;

                u4 = v30;
                u5:Fire();

                if not u28 then
                    if UseDynamicPrices or v.FallbackPrice == nil then
                        if not UseDynamicPrices then
                            warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        MarketController:SetPriceLabel(Frame.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                    else
                        Frame.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                    end;

                    u28 = true;
                end;
            end);
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            NumberValue.Parent = Frame;
            NumberValue.Changed:Connect(function(p31: number) -- Line: 353
                -- upvalues: Main_Frame (copy)
                Main_Frame.Stock_Text.Text = `X{p31 // 1} Stock`;
            end);
            local u32 = true;

            local function updateStock() -- Line: 359
                -- upvalues: DataService (ref), i (copy), NPCLevelHandler (ref), v (copy), u32 (ref), u22 (ref), NumberValue (copy), Spr (ref), Main_Frame (copy), Frame (copy), MarketController (ref), NumberUtil (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
                local Data = DataService:GetData();

                if Data then
                    Data = Data.GearStock.Stocks[i];
                end;

                local v33 = Data and Data.Stock or 0;
                local v34 = not NPCLevelHandler:HasRequiredNPCLevels(v.LevelLocks);

                if v.RobuxOnly or v34 then
                    Spr.stop(NumberValue);
                    Main_Frame.Stock_Text.Text = "";
                elseif u32 or not u22 then
                    u32 = false;
                    NumberValue.Value = v33;
                else
                    Spr.target(NumberValue, 1, 1.5, {
                        Value = v33
                    });
                end;

                Frame.Sheckles_Buy.In_Stock.Visible = v33 > 0;
                Frame.Sheckles_Buy.No_Stock.Visible = v33 <= 0;
                Frame.Sheckles_Buy.HoverImage = v33 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                Frame.Sheckles_Buy.Image = v33 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                Frame.Sheckles_Buy.Visible = not (v.RobuxOnly or v34);

                if v34 and v.LevelLocks then
                    local v35 = next(v.LevelLocks);
                    Main_Frame.Cost_Text.Text = `LOCKED: lvl{v35 and v.LevelLocks[v35] or 1}+`;
                    Main_Frame.Cost_Text.TextColor3 = Color3.fromRGB(255, 0, 0);
                elseif v.RobuxOnly then
                    Main_Frame.Cost_Text.Text = "???";
                    MarketController:SetPriceLabel(Main_Frame.Cost_Text, v.PurchaseID, ":robux::value:");
                else
                    Main_Frame.Cost_Text.Text = v33 <= 0 and "NO STOCK" or NumberUtil.DisplaySheckles(v.Price);
                    local Cost_Text = Main_Frame.Cost_Text;
                    local v36;

                    if v33 <= 0 then
                        v36 = Color3.fromRGB(255, 0, 0);
                    else
                        v36 = Color3.fromRGB(0, 255, 0);
                    end;

                    Cost_Text.TextColor3 = v36;
                end;

                if RebirthUnlocksSharedService:HasUnlockedShopItem(LocalPlayer, "Gear", i) then
                    Main_Frame.LockedFrame.Visible = false;
                    Main_Frame.Interactable = true;

                    return;
                end;

                Main_Frame.LockedFrame.Visible = true;
                Main_Frame.Interactable = false;
                Main_Frame.LockedFrame.UnlockInfo.Text = `Ascensions Required: {RebirthUnlocksSharedService:GetRemainingRebirthsNeededForItem(LocalPlayer, "Gear", i)}`;
            end;

            task.spawn(updateStock);
            task.spawn(function() -- Line: 422
                -- upvalues: DataService (ref), updateStock (copy), u2 (ref)
                local PathSignal = DataService:GetPathSignal("GearStock/@");

                if PathSignal then
                    local v37 = PathSignal:Connect(updateStock);
                    table.insert(u2, v37);
                end;
            end);
            task.spawn(function() -- Line: 431
                -- upvalues: DataService (ref), updateStock (copy), u2 (ref)
                local PathSignal = DataService:GetPathSignal("NPCPoints/@");

                if PathSignal then
                    local v38 = PathSignal:Connect(updateStock);
                    table.insert(u2, v38);
                end;
            end);
            task.spawn(function() -- Line: 440
                -- upvalues: RebirthUnlocksSharedService (ref), LocalPlayer (ref), DataService (ref), updateStock (copy), u2 (ref)
                local v39 = RebirthUnlocksSharedService:HasBeenAssignedABTest(LocalPlayer) and DataService:GetPathSignal("RebirthData/TotalRebirths");

                if v39 then
                    local v40 = v39:Connect(updateStock);
                    table.insert(u2, v40);
                end;
            end);
        end;
    end;

    table.sort(u11, function(p41, p42) -- Line: 451
        if p41.LayoutOrder == p42.LayoutOrder then
            return p41.Name < p42.Name;
        end;

        return p41.LayoutOrder < p42.LayoutOrder;
    end);
end;

local function OpenStockOdds() -- Line: 472
    -- upvalues: ReplicatedStorage (copy), GearShopData2 (copy), u1 (copy), Gear_Shop (copy)
    local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
    local v43 = {};

    for i, v in GearShopData2.Gear do
        local v44 = u1[i];

        if v44 and (v.StockChance and not v.RobuxOnly) then
            table.insert(v43, {
                Reward = {
                    Type = "Gear",
                    Quantity = 1,
                    Value = i
                },
                Weight = 1 / v.StockChance,
                ShopLayoutOrder = v44.LayoutOrder
            });
        end;
    end;

    if #v43 == 0 then
        return;
    end;

    local u45 = {};
    GenericRewardsUIController:Open({
        Title = "Stock Odds",
        DisplayOdds = true,
        RewardData = v43,
        Breadcrumb = Gear_Shop,
        HeaderColor = Gear_Shop.Frame.Frame.BackgroundColor3,

        RewardFrameCreatedCallback = function(p46, p47) -- Line: 507, Name: RewardFrameCreatedCallback
            -- upvalues: u45 (copy)
            u45[p46] = p47.ShopLayoutOrder;
        end,

        RewardsUIBuiltCallback = function() -- Line: 510, Name: RewardsUIBuiltCallback
            -- upvalues: u45 (copy)
            for i, v in u45 do
                i.LayoutOrder = v;
            end;
        end,

        Disclaimer = GenericRewardsUIController.RoundedOddsDisclaimer(v43)
    });
end;

function v3.Start(p48) -- Line: 519
    -- upvalues: GuiController (copy), Gear_Shop (copy), OpenStockOdds (copy), DevProductIds (copy), MarketController (copy), PolicyService (copy), LocalPlayer (copy), UpdateService (copy), SetupFrames (copy), SetupTimer (copy), DataService (copy), ScrollingFrame (copy), GearShopData2 (copy), NumberUtil (copy), Spring (copy), Debris (copy), u6 (copy), SoundPlayer (copy), SoundData (copy)
    GuiController:UsePopupAnims(Gear_Shop);
    Gear_Shop.Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 522
        -- upvalues: GuiController (ref), Gear_Shop (ref)
        GuiController:Close(Gear_Shop);
    end);
    Gear_Shop.Frame.Frame.Odds.SENSOR.Activated:Connect(OpenStockOdds);
    local Restock = Gear_Shop.Frame.Frame.Restock;
    local u49 = false;
    Restock.Activated:Connect(function() -- Line: 531
        -- upvalues: u49 (ref), DevProductIds (ref), MarketController (ref)
        if u49 then
            return;
        end;

        MarketController:PromptPurchase(DevProductIds.GearShopRestock.PurchaseID, Enum.InfoType.Product);
    end);
    task.spawn(function() -- Line: 540
        -- upvalues: PolicyService (ref), LocalPlayer (ref), u49 (ref), Restock (copy)
        local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

        if PolicyInfoForPlayerAsync then
            PolicyInfoForPlayerAsync = PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted;
        end;

        u49 = PolicyInfoForPlayerAsync == true;
        Restock.Visible = not u49;
    end);

    if not UpdateService:IsUpdateDone() then
        task.delay(UpdateService:GetRemainingTimeUntilUpdate(), function() -- Line: 547
            -- upvalues: SetupFrames (ref)
            SetupFrames();
        end);
    end;

    task.spawn(SetupTimer);
    SetupFrames();
    task.spawn(function() -- Line: 555
        -- upvalues: DataService (ref), ScrollingFrame (ref), GearShopData2 (ref), NumberUtil (ref), Spring (ref), Debris (ref), Gear_Shop (ref), u6 (ref), SoundPlayer (ref), SoundData (ref)
        local PathSignal = DataService:GetPathSignal("GearStock/@");

        if not PathSignal then
            return;
        end;

        local function _(p50: table, p51: string) -- Line: 561
            return p50[p51] or {
                MaxStock = 0,
                Stock = 0
            };
        end;

        local function adjustFrame(p52: string, p53: number) -- Line: 565
            -- upvalues: ScrollingFrame (ref), GearShopData2 (ref), NumberUtil (ref)
            local v54 = ScrollingFrame:FindFirstChild(p52);

            if not v54 then
                return;
            end;

            local v55 = GearShopData2.Gear[p52];

            if not v55 then
                warn((`No gear info found for id: {p52}`));

                return;
            end;

            local Main_Frame = v54.Main_Frame;
            local Frame = v54.Frame;
            local Cost_Text = Main_Frame.Cost_Text;
            local v56 = `X{p53} Stock`;
            local v57 = p53 > 0;
            Main_Frame.Stock_Text.Text = v56;
            Frame.Sheckles_Buy.In_Stock.Visible = v57;
            Frame.Sheckles_Buy.No_Stock.Visible = not v57;
            Frame.Sheckles_Buy.HoverImage = v57 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
            Frame.Sheckles_Buy.Image = v57 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";

            if v57 then
                Cost_Text.Text = NumberUtil.DisplaySheckles(v55.Price);
                Cost_Text.TextColor3 = Color3.fromRGB(0, 255, 0);

                return;
            end;

            Cost_Text.Text = "NO STOCK";
            Cost_Text.TextColor3 = Color3.fromRGB(255, 0, 0);
        end;

        local function createFlash(p58: string, p59) -- Line: 605
            -- upvalues: ScrollingFrame (ref), Spring (ref), Debris (ref)
            local v60 = ScrollingFrame:FindFirstChild(p58);

            if not v60 then
                return;
            end;

            local Main_Frame = v60.Main_Frame;
            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.fromScale(0.98, 0.98);
            Frame.Position = UDim2.fromScale(0.5, 0.5);
            Frame.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame.Transparency = 0.4;
            Frame.BackgroundColor3 = p59;
            Frame.ZIndex = 1000;
            Frame.Parent = Main_Frame;
            Spring.target(Frame, 1, 1, {
                Transparency = 1
            });
            Debris:AddItem(Frame, 2.1);
            task.delay(2, function() -- Line: 625
                -- upvalues: Frame (copy)
                if not (Frame and Frame.Parent) then
                    return;
                end;

                Frame:Destroy();
            end);
        end;

        local function playSound(p61: string) -- Line: 633
            -- upvalues: Gear_Shop (ref), Debris (ref)
            if not Gear_Shop.Enabled then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.SoundId = p61;
            Sound.Parent = game.Players.LocalPlayer.PlayerGui.ReplicatedAssets;
            Sound:Play();
            Debris:AddItem(Sound, Sound.TimeLength);
            task.delay(Sound.TimeLength, function() -- Line: 645
                -- upvalues: Sound (copy)
                if not (Sound and Sound.Parent) then
                    return;
                end;

                Sound:Destroy();
            end);
        end;

        local function getSortedByLayoutOrder(p62: table) -- Line: 653
            -- upvalues: ScrollingFrame (ref)
            local v63 = {};

            for i, _ in p62 do
                table.insert(v63, i);
            end;

            local function getLayoutOrder(p64: string) -- Line: 659
                -- upvalues: ScrollingFrame (ref)
                local v65 = ScrollingFrame:FindFirstChild(p64);

                return not v65 and 0 or v65.LayoutOrder;
            end;

            table.sort(v63, function(p66: string, p67: string) -- Line: 667
                -- upvalues: ScrollingFrame (ref)
                local v68 = ScrollingFrame:FindFirstChild(p66);
                local v69 = not v68 and 0 or v68.LayoutOrder;
                local v70 = ScrollingFrame:FindFirstChild(p67);

                return v69 < (not v70 and 0 or v70.LayoutOrder);
            end);

            return v63;
        end;

        local function stockAnimation(p71: table) -- Line: 674
            -- upvalues: DataService (ref), getSortedByLayoutOrder (copy), ScrollingFrame (ref), u6 (ref), adjustFrame (copy), Gear_Shop (ref), SoundPlayer (ref), SoundData (ref), GearShopData2 (ref), createFlash (copy)
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local v72 = getSortedByLayoutOrder(p71);
            table.clear(p71);

            for i, v in v72 do
                if ScrollingFrame:FindFirstChild(v) then
                    u6[v] = true;
                    local v73 = Data.GearStock.Stocks[v] or {
                        MaxStock = 0,
                        Stock = 0
                    };
                    local v74 = v73 and v73.Stock or 0;
                    local v75, v76;

                    if v74 > 0 then
                        v75 = i;
                        v76 = v;

                        for i2 = 0, v74 do
                            adjustFrame(v76, i2);

                            if Gear_Shop.Enabled then
                                SoundPlayer:PlaySound(SoundData.RestockAnimationSFX.Stock_Click);
                            end;

                            task.wait(0.05);
                            local _ = i2;
                        end;

                        local v77 = not GearShopData2.Gear[v76] and "Prismatic" or GearShopData2.Gear[v76].Gear.GearRarity;

                        if Gear_Shop.Enabled then
                            SoundPlayer:PlaySound(SoundData.RestockAnimationSFX[v77 or "Prismatic"]);
                        end;

                        createFlash(v76, Color3.fromRGB(24, 255, 0));
                        adjustFrame(v76, v74);
                    else
                        if Gear_Shop.Enabled then
                            SoundPlayer:PlaySound(SoundData.RestockAnimationSFX.No_Restock);
                        end;

                        createFlash(v, Color3.fromRGB(249, 0, 2));
                        adjustFrame(v, 0);
                        v76 = v;
                        v75 = i;
                    end;

                    task.wait((v75 - 1) * 0.02 + 0.25);
                    u6[v76] = nil;
                end;
            end;
        end;

        local Data = DataService:GetData();
        local Stocks = Data.GearStock.Stocks;
        local u78 = nil;
        PathSignal:Connect(function() -- Line: 745
            -- upvalues: Data (copy), Stocks (ref), GearShopData2 (ref), u78 (ref), stockAnimation (copy)
            if not Data then
                return;
            end;

            if Stocks then
                local v79 = false;

                for i, v in Data.GearStock.Stocks do
                    if not Stocks[i] or v.MaxStock ~= Stocks[i].MaxStock then
                        v79 = true;
                        break;
                    end;
                end;

                if not v79 then
                    return;
                end;
            end;

            Stocks = Data.GearStock.Stocks;
            local v80 = {};

            for i, _ in GearShopData2.Gear do
                v80[i] = true;
            end;

            if u78 then
                task.cancel(u78);
            end;

            u78 = task.delay(0.15, stockAnimation, v80);
        end);
    end);
end;

task.spawn(v3.Start, v3);

return v3;