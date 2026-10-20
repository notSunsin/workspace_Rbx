-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local Spr = require(ReplicatedStorage.Code.Spr);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Modules.RetryPcall);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.GiftController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Modules.NPCLevelHandler);
require(ReplicatedStorage.Modules.Notification);
local SeasonPassShopData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassShopData);
local SeasonPassData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
require(ReplicatedStorage.Data.GearData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local GameEvents = ReplicatedStorage.GameEvents;
local BuySeasonPassStock = GameEvents.SeasonPass.BuySeasonPassStock;
local ShecklesClient = GameEvents:WaitForChild("ShecklesClient");
local SeasonPassUI = game.Players.LocalPlayer.PlayerGui:WaitForChild("SeasonPassUI");
local Store = SeasonPassUI.SeasonPassFrame.Main.Store;
local ScrollingFrame = Store.ScrollingFrame;
local Timer = Store.Timer;
local SeasonPassTemplates = SeasonPassUI.SeasonPassTemplates;
local SeasonPassShopItemTemplate = SeasonPassTemplates.SeasonPassShopItemTemplate;
local SeasonPassShopPaddingTemplate = SeasonPassTemplates.SeasonPassShopPaddingTemplate;
local u1 = {};
local u2 = {};
local v3 = {};
local u4 = nil;
local u5 = Signal.new();

local function GetRefreshTime() -- Line: 60
    -- upvalues: DataService (copy), SeasonPassData (copy), SeasonPassShopData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();

    if not SeasonPassData.CurrentSeason then
        return (1 / 0);
    end;

    if not Data.SeasonPass[SeasonPassData.CurrentSeason] then
        return (1 / 0);
    end;

    local v6 = not Data.SeasonPass[SeasonPassData.CurrentSeason].ForcedItemEndTimestamp and -1 or Data.SeasonPass[SeasonPassData.CurrentSeason].ForcedItemEndTimestamp - ServerTimeNow;

    if v6 >= 0 then
        return v6;
    end;

    return SeasonPassShopData.RefreshTime - ServerTimeNow % SeasonPassShopData.RefreshTime;
end;

local _ = game.SoundService.Click;

local function SetupTimer() -- Line: 85
    -- upvalues: GetRefreshTime (copy), Timer (copy), NumberUtil (copy)
    while true do
        local v7 = GetRefreshTime();
        Timer.Text = v7 <= 0 and "Restocking" or "Restocking in " .. NumberUtil.compactFormat(v7);
        task.wait(1);
    end;
end;

local u8 = nil;
local u9 = nil;
local u10 = nil;

local function SetupFrames() -- Line: 102
    -- upvalues: SeasonPassData (copy), u2 (copy), u1 (copy), UpdateService (copy), SeasonPassShopItemTemplate (copy), Item_Module (copy), SeasonPassUI (copy), ColorHelper (copy), Comma_Module (copy), u9 (ref), SeedPackOddsController (copy), u8 (ref), CosmeticCrateOddsController (copy), u10 (ref), PetEggOddsController (copy), ScrollingFrame (copy), SeasonPassShopPaddingTemplate (copy), BuySeasonPassStock (copy), WatchButtonHold (copy), Spr (copy), MarketController (copy), u4 (ref), FastTween (copy), u5 (copy), UseDynamicPrices (copy), SeedData (copy), DataService (copy)
    if not SeasonPassData.CurrentSeason then
        return;
    end;

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
    local u11 = {};

    for i, v in SeasonPassData.ShopItems do
        if v.LayoutOrder ~= -1 then
            local u12 = v.DisplayName or i;
            local v13 = v.Rarity or "Empty Rarity";
            local v14 = v.Desc or "";
            local v15 = v.ImageId or "rbxassetid://6937742258";

            if not (UpdateService:IsHiddenFromUpdate(u12) or UpdateService:IsHiddenAfterUpdate(u12)) then
                local u16 = SeasonPassShopItemTemplate:Clone();
                u1[i] = u16;
                u16.Name = i;
                u16.LayoutOrder = v.LayoutOrder * 10;
                table.insert(u11, u16);
                local Main_Frame = u16.Main_Frame;
                local v17 = Item_Module.Return_Rarity_Data(v13);

                if v17 then
                    local v18 = v17[1];
                    local v19 = v17[2];
                    local v20 = v17[3];
                    Main_Frame.Rarity_Text.Text = v18;

                    if v20 and v18 == "Prismatic" then
                        local u21 = nil;
                        u21 = game:GetService("RunService").Heartbeat:Connect(function(p22) -- Line: 160
                            -- upvalues: SeasonPassUI (ref), Main_Frame (copy), u21 (ref), ColorHelper (ref)
                            if not SeasonPassUI.Enabled then
                                return;
                            end;

                            if not (Main_Frame and Main_Frame.Parent) then
                                u21:Disconnect();

                                return;
                            end;

                            local v23 = os.clock() * 0.1 % 1;
                            local Color3_fromHSV_ret = Color3.fromHSV(v23, 1, 1);
                            Main_Frame.Rarity_BG.ImageColor3 = Color3_fromHSV_ret;

                            if Main_Frame.Rarity_Text.UIStroke then
                                Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(Color3_fromHSV_ret);
                            end;
                        end);
                    else
                        if Main_Frame.Rarity_Text.UIStroke then
                            Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v19);
                        end;

                        Main_Frame.Rarity_BG.ImageColor3 = v19;
                    end;
                end;

                Main_Frame.Gear_Text.Text = u12;
                Main_Frame.Gear_Text_Shadow.Text = u12;
                Main_Frame.Description_Text.Text = v14;
                Main_Frame.Cost_Text.Text = Comma_Module.Comma(v.Price);
                Main_Frame:WaitForChild("Gear_Image").Image = v15;

                if v.Type == "Seed Pack" then
                    Main_Frame.Gear_Image.OddsButton.Visible = true;

                    if u9 then
                        u9:Disconnect();
                    end;

                    u9 = Main_Frame.Gear_Image.OddsButton.Activated:Connect(function() -- Line: 200
                        -- upvalues: SeedPackOddsController (ref), u12 (copy), SeasonPassUI (ref)
                        SeedPackOddsController:Open(u12, SeasonPassUI);
                    end);
                elseif v.Type == "Crate" then
                    Main_Frame.Gear_Image.OddsButton.Visible = true;

                    if u8 then
                        u8:Disconnect();
                    end;

                    u8 = Main_Frame.Gear_Image.OddsButton.Activated:Connect(function() -- Line: 209
                        -- upvalues: CosmeticCrateOddsController (ref), u12 (copy), SeasonPassUI (ref)
                        CosmeticCrateOddsController:Open(u12, SeasonPassUI);
                    end);
                elseif v.Type == "Egg" then
                    Main_Frame.Gear_Image.OddsButton.Visible = true;

                    if u10 then
                        u10:Disconnect();
                    end;

                    u10 = Main_Frame.Gear_Image.OddsButton.Activated:Connect(function() -- Line: 218
                        -- upvalues: PetEggOddsController (ref), u12 (copy), SeasonPassUI (ref)
                        PetEggOddsController:Open(u12, SeasonPassUI);
                    end);
                else
                    Main_Frame.Gear_Image.OddsButton.Visible = false;
                end;

                u16.Visible = true;
                u16.Parent = ScrollingFrame.Content;
                local u24 = SeasonPassShopPaddingTemplate:Clone();
                u24.LayoutOrder = v.LayoutOrder * 10 + 1;
                u24.Name = i .. "_Padding";
                u24.Parent = ScrollingFrame.Content;
                u1[u24.Name] = u24;
                local Frame = u16.Frame;
                Frame.Points_Buy.In_Stock.Cost_Text.Text = Comma_Module.Comma(v.Price);

                local function buy() -- Line: 238
                    -- upvalues: BuySeasonPassStock (ref), i (copy)
                    BuySeasonPassStock:FireServer(i);
                end;

                local u25 = false;
                local u26 = 0;
                WatchButtonHold(Frame.Points_Buy, function(p27: number, p28: boolean?) -- Line: 248
                    -- upvalues: u26 (ref), u25 (ref), Frame (copy), Spr (ref), BuySeasonPassStock (ref), i (copy)
                    if workspace:GetAttribute("InTutorial") then
                        return;
                    end;

                    if p28 then
                        u26 = 0;

                        if u25 then
                            u25 = false;

                            if Frame:FindFirstChild("Points_Buy") then
                                Spr.target(Frame.Points_Buy, 0.8, 2, {
                                    ImageColor3 = Color3.new(1, 1, 1)
                                });
                            end;
                        end;

                        return;
                    end;

                    if not u25 then
                        u25 = true;

                        if Frame:FindFirstChild("Points_Buy") then
                            Spr.target(Frame.Points_Buy, 0.8, 2, {
                                ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                            });
                        end;
                    end;

                    if os.clock() < u26 then
                        return;
                    end;

                    local v29 = ((1 - math.exp(p27 * -0.3)) * 24 + 8) // 1;
                    local math_max_ret = math.max(v29, 1);
                    u26 = os.clock() + 0.125;

                    for i2 = 1, math_max_ret do
                        BuySeasonPassStock:FireServer(i);
                        local _ = i2;
                    end;
                end, {
                    minimumHoldTime = 1,
                    interval = 0.125
                });
                Frame.Points_Buy.Activated:Connect(buy);
                Frame.Robux_Buy.Activated:Connect(function() -- Line: 294
                    -- upvalues: MarketController (ref), v (copy)
                    MarketController:PromptPurchase(v.PurchaseID, Enum.InfoType.Product);
                end);

                local function updateOptions() -- Line: 298
                    -- upvalues: u4 (ref), i (copy), Frame (copy), FastTween (ref), u24 (copy)
                    if u4 == i then
                        Frame.Visible = true;
                        FastTween(Frame, TweenInfo.new(0.25), {
                            Position = UDim2.fromScale(0.5, 1.24)
                        });
                        FastTween(u24, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0.13, 0.25)
                        });

                        return;
                    end;

                    Frame.Visible = false;
                    FastTween(Frame, TweenInfo.new(0.25), {
                        Position = UDim2.fromScale(0.5, 0.5)
                    });
                    FastTween(u24, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0.13, 0.02)
                    });
                end;

                u5:Connect(updateOptions);
                task.spawn(updateOptions);
                local u30 = false;
                Main_Frame.Activated:Connect(function() -- Line: 314
                    -- upvalues: FastTween (ref), ScrollingFrame (ref), u16 (copy), u11 (copy), u4 (ref), i (copy), u5 (ref), u30 (ref), UseDynamicPrices (ref), v (copy), Frame (copy), MarketController (ref), Comma_Module (ref)
                    FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                        CanvasPosition = Vector2.new(0, u16.AbsoluteSize.Y * (table.find(u11, u16) - 1))
                    });
                    local v31;

                    if u4 == i then
                        v31 = nil;
                    else
                        v31 = i;
                    end;

                    u4 = v31;
                    u5:Fire();

                    if not u30 then
                        if UseDynamicPrices or v.FallbackPrice == nil then
                            if not UseDynamicPrices then
                                warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                            end;

                            MarketController:SetPriceLabel(Frame.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                        else
                            Frame.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                        end;

                        u30 = true;
                    end;
                end);

                if v.Type == "Seed" then
                    local u32 = nil;
                    local u33 = nil;
                    u16.Main_Frame.CanvasGroup.ShopItem_Image.Image = SeedData[u12].Asset;
                    u16.Main_Frame.CanvasGroup.Visible = true;
                    u16.Main_Frame.Gear_Image.Visible = false;
                    Main_Frame.MouseEnter:Connect(function() -- Line: 346
                        -- upvalues: u32 (ref), FastTween (ref), u16 (copy), u33 (ref), SeedData (ref), u12 (copy)
                        u32 = FastTween(u16.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                            Rotation = u16.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                        });
                        u33 = FastTween(u16.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                            Scale = 1.5
                        });
                        u33.Completed:Connect(function(p34) -- Line: 362
                            -- upvalues: u16 (ref), SeedData (ref), u12 (ref)
                            if p34 == Enum.PlaybackState.Completed then
                                if not u16:IsDescendantOf(game) then
                                    return;
                                end;

                                u16.Main_Frame.CanvasGroup.ShopItem_Image.Image = SeedData[u12].FruitIcon;
                            end;
                        end);
                    end);
                    Main_Frame.MouseLeave:Connect(function() -- Line: 372
                        -- upvalues: u32 (ref), u16 (copy), SeedData (ref), u12 (copy), FastTween (ref)
                        if u32 then
                            u32:Cancel();
                        end;

                        u16.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                        u16.Main_Frame.CanvasGroup.ShopItem_Image.Image = SeedData[u12].Asset;
                        FastTween(u16.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                            Scale = 1
                        });
                    end);
                end;

                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 0;
                NumberValue.Parent = Frame;
                NumberValue.Changed:Connect(function(p35: number) -- Line: 395
                    -- upvalues: Main_Frame (copy)
                    local Stock_Text = Main_Frame:FindFirstChild("Stock_Text");

                    if Stock_Text then
                        Stock_Text.Text = `X{p35 // 1} Stock`;
                    end;
                end);
                local u36 = true;

                local function updateStock() -- Line: 404
                    -- upvalues: SeasonPassData (ref), DataService (ref), i (copy), v (copy), u36 (ref), u25 (ref), NumberValue (copy), Spr (ref), Main_Frame (copy), Frame (copy), MarketController (ref), Comma_Module (ref)
                    if not SeasonPassData.CurrentSeason then
                        return;
                    end;

                    local Data = DataService:GetData();

                    if not Data.SeasonPass[SeasonPassData.CurrentSeason] then
                        return;
                    end;

                    if Data then
                        Data = Data.SeasonPass[SeasonPassData.CurrentSeason].Stocks[i];
                    end;

                    local v37 = Data and Data.Stock or 0;

                    if v.RobuxOnly then
                        Spr.stop(NumberValue);
                        local Stock_Text = Main_Frame:FindFirstChild("Stock_Text");

                        if Stock_Text then
                            Stock_Text.Text = "";
                        end;
                    elseif u36 or not u25 then
                        u36 = false;
                        NumberValue.Value = v37;
                    else
                        Spr.target(NumberValue, 1, 1.5, {
                            Value = v37
                        });
                    end;

                    Frame.Points_Buy.In_Stock.Visible = v37 > 0;
                    Frame.Points_Buy.No_Stock.Visible = v37 <= 0;
                    Frame.Points_Buy.HoverImage = v37 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                    Frame.Points_Buy.Image = v37 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                    Frame.Points_Buy.Visible = not v.RobuxOnly;

                    if v.RobuxOnly then
                        Main_Frame.Cost_Text.Text = "???";
                        MarketController:SetPriceLabel(Main_Frame.Cost_Text, v.PurchaseID, ":robux::value:");

                        return;
                    end;

                    Main_Frame.Cost_Text.Text = v37 <= 0 and "NO STOCK" or Comma_Module.Comma(v.Price);
                    local Cost_Text = Main_Frame.Cost_Text;
                    local v38;

                    if v37 <= 0 then
                        v38 = Color3.fromRGB(255, 0, 0);
                    else
                        v38 = Color3.fromRGB(0, 255, 0);
                    end;

                    Cost_Text.TextColor3 = v38;
                end;

                task.spawn(updateStock);
                task.spawn(function() -- Line: 452
                    -- upvalues: DataService (ref), SeasonPassData (ref), updateStock (copy), u2 (ref)
                    local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/@`));

                    if PathSignal then
                        local v39 = PathSignal:Connect(updateStock);
                        table.insert(u2, v39);
                    end;
                end);
            end;
        end;
    end;

    table.sort(u11, function(p40, p41) -- Line: 461
        if p40.LayoutOrder == p41.LayoutOrder then
            return p40.Name < p41.Name;
        end;

        return p40.LayoutOrder < p41.LayoutOrder;
    end);
end;

local function OpenStockOdds() -- Line: 469
    -- upvalues: ReplicatedStorage (copy), SeasonPassData (copy), UpdateService (copy), SeasonPassUI (copy), Store (copy)
    local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
    local v42 = {};

    for i, v in SeasonPassData.ShopItems do
        local v43 = v.DisplayName or i;

        if v.LayoutOrder ~= -1 and not (v.RobuxOnly or (not v.StockChance or (UpdateService:IsHiddenFromUpdate(v43) or UpdateService:IsHiddenAfterUpdate(v43)))) then
            local v44 = {
                Reward = {
                    Quantity = 1,
                    Type = v.Type,
                    Value = i
                },
                Weight = 1 / v.StockChance,
                ShopLayoutOrder = v.LayoutOrder
            };

            if v43 == i then
                v43 = nil;
            end;

            v44.ShopDisplayName = v43;
            table.insert(v42, v44);
        end;
    end;

    if #v42 == 0 then
        return;
    end;

    local u45 = {};
    GenericRewardsUIController:Open({
        Title = "Stock Odds",
        DisplayOdds = true,
        RewardData = v42,
        Breadcrumb = SeasonPassUI,
        HeaderColor = Store.OddsButton.BackgroundColor3,

        RewardFrameCreatedCallback = function(p46, p47) -- Line: 507, Name: RewardFrameCreatedCallback
            -- upvalues: u45 (copy)
            u45[p46] = p47.ShopLayoutOrder;

            if p47.ShopDisplayName then
                p46.Frame.RewardName.Text = `1x {p47.ShopDisplayName}`;
            end;
        end,

        RewardsUIBuiltCallback = function() -- Line: 514, Name: RewardsUIBuiltCallback
            -- upvalues: u45 (copy)
            for i, v in u45 do
                i.LayoutOrder = v;
            end;
        end,

        Disclaimer = GenericRewardsUIController.RoundedOddsDisclaimer(v42)
    });
end;

local function UpdateBank(p48: number) -- Line: 524
    -- upvalues: Store (copy)
    Store.Currency.TextLabel.Text = tostring(p48);
end;

function v3.UpdateShopFrames() -- Line: 530
    -- upvalues: SetupFrames (copy)
    SetupFrames();
end;

function v3.Start(p49) -- Line: 535
    -- upvalues: Store (copy), DevProductIds (copy), MarketController (copy), OpenStockOdds (copy), UpdateService (copy), SetupFrames (copy), SetupTimer (copy), DataService (copy)
    Store.Refresh.Activated:Connect(function() -- Line: 536
        -- upvalues: DevProductIds (ref), MarketController (ref)
        MarketController:PromptPurchase(DevProductIds.SeasonPassShopRestock.PurchaseID, Enum.InfoType.Product);
    end);
    Store.OddsButton.Activated:Connect(OpenStockOdds);

    if not UpdateService:IsUpdateDone() then
        task.delay(UpdateService:GetRemainingTimeUntilUpdate(), function() -- Line: 544
            -- upvalues: SetupFrames (ref)
            SetupFrames();
        end);
    end;

    task.spawn(SetupTimer);
    SetupFrames();
    local Data = DataService:GetData();

    if Data then
        Store.Currency.TextLabel.Text = tostring(Data.SpecialCurrency.PassPoints);

        return;
    end;

    warn("No player data");
end;

ShecklesClient.OnClientEvent:Connect(function(p50) -- Line: 558
    -- upvalues: SoundService (copy)
    if type(p50) ~= "string" then
        return;
    end;

    local v51 = SoundService:FindFirstChild(p50, true);

    if not v51 then
        return;
    end;

    v51.TimePosition = 0;
    v51.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    v51:Play();
end);
local PathSignal = DataService:GetPathSignal("SpecialCurrency/PassPoints/@");

if PathSignal then
    PathSignal:Connect(function(p52: string, p53: any, p54: string) -- Line: 573
        -- upvalues: DataService (copy), Store (copy)
        local Data = DataService:GetData();

        if Data then
            Store.Currency.TextLabel.Text = tostring(Data.SpecialCurrency.PassPoints);

            return;
        end;

        warn("No player data");
    end);
end;

return v3;