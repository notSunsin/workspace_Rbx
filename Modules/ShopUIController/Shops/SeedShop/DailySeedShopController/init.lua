-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ReplicatedFirst");
local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
game:GetService("TweenService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.Observers);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.UseDynamicPrices);
require(ReplicatedStorage.Modules.WatchButtonHold);
require(ReplicatedStorage.Code.Particle2D);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.GiftController);
require(ReplicatedStorage.Modules.ShopTabHandler);
local NPCLevelHandler = require(ReplicatedStorage.Modules.NPCLevelHandler);
require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Code.Spr);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Modules.DumpTable);
require(ReplicatedStorage.Modules.PlantTraitsData);
require(ReplicatedStorage.Modules.Spring);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local ShopTabData = require(ReplicatedStorage.Data.ShopTabData);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local SeedShopConfigData = require(ReplicatedStorage.Data.SeedShopConfigData);
require(game.ReplicatedStorage.Data.SeedData);
require(game.ReplicatedStorage.Data.SeedShopData);
local DailySeedShopData = require(game.ReplicatedStorage.Data.DailySeedShopData);
local LocalPlayer = game.Players.LocalPlayer;
local Seed_Shop = LocalPlayer.PlayerGui:WaitForChild("Seed_Shop");
local ScrollingFrame = Seed_Shop:WaitForChild("Daily"):WaitForChild("ScrollingFrame");
ScrollingFrame:WaitForChild("UIListLayout");
local Title = Seed_Shop:WaitForChild("Daily"):WaitForChild("ScrollingFrame"):WaitForChild("Timer"):WaitForChild("Title");
local _ = game.SoundService.Click;
local Restock_SFX = game.SoundService.Restock_SFX;
local FeaturedDeal = ScrollingFrame:WaitForChild("FeaturedDeal");
local u1 = {};

for _, child in ScrollingFrame:WaitForChild("Seeds"):GetChildren() do
    if child:IsA("GuiObject") then
        table.insert(u1, child);
    end;
end;

local UITabHelperModule = require(ReplicatedStorage.Modules.UITabHelperModule);
local TabList = Seed_Shop:WaitForChild("TabAnchor"):WaitForChild("TabList");
local TabButtonTemplate = ReplicatedStorage.UITemplates:WaitForChild("TabButtonTemplate");
local v2 = UITabHelperModule.CreateOrGetTabHandler("SeedShop", TabList, TabButtonTemplate);
local u3 = nil;
local u4 = Signal.new();
local u5 = {};
local u6 = {};
local u7 = false;
local u8 = {};
local v9 = {};

local function AddFrameConnection(p10: any, p11: userdata) -- Line: 87
    -- upvalues: u8 (copy)
    if not u8[p10] then
        u8[p10] = {};
    end;

    table.insert(u8[p10], p11);
end;

local function Darken(p12) -- Line: 95
    local v13, v14, v15 = p12:ToHSV();

    return Color3.fromHSV(v13, v14, v15 / 2);
end;

local function GetRefreshTime() -- Line: 100
    -- upvalues: DataService (copy), ShopTabData (copy), SeedShopConfigData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v16 = DataService:GetData().SeedStocks["Daily Deals"];
    local v17 = v16 and v16.ForcedSeedEndTimestamp and (v16.ForcedSeedEndTimestamp - ServerTimeNow or -1) or -1;

    if v17 >= 0 then
        return v17;
    end;

    local RefreshTime = (ShopTabData.Seed["Daily Deals"] or SeedShopConfigData).RefreshTime;

    return RefreshTime - ServerTimeNow % RefreshTime;
end;

local function FetchStockInfo(p18: any, p19: string, p20: string) -- Line: 115
    local v21 = p18[p20];

    return not v21.Stocks[p19] and {
        MaxStock = 0,
        Stock = 0,
        IsGoodSeed = false
    } or v21.Stocks[p19];
end;

local u30 = {
    UpdateStockDisplay = function(p22: any, p23: number) -- Line: 136, Name: UpdateStockDisplay
        if not (p22 and (p22.Parent and p22:FindFirstChild("StockNum"))) then
            return;
        end;

        p22.StockNum.Text = `X{p23} Stock`;
        local StockNum = p22.StockNum;
        local v24;

        if p23 > 0 then
            v24 = Color3.fromRGB(235, 227, 143);
        else
            v24 = Color3.fromRGB(255, 0, 0);
        end;

        StockNum.TextColor3 = v24;
    end,

    UpdateButtonState = function(p25: any, p26: number) -- Line: 144, Name: UpdateButtonState
        if not (p25 and p25.Parent) then
            return;
        end;

        if not p25.PurchaseButton.Main.SENSOR then
            return;
        end;

        local Main = p25.PurchaseButton:FindFirstChild("Main");
        local OutOfStock = p25.PurchaseButton:FindFirstChild("OutOfStock");

        if Main then
            Main.Visible = p26 > 0;
        end;

        if OutOfStock then
            OutOfStock.Visible = p26 <= 0;
        end;
    end,

    UpdateLockedState = function(p27: any, p28: boolean, p29: number?) -- Line: 161, Name: UpdateLockedState
    end
};

local function SetupRarityDisplay(u31: any, u32: any, p33: table?) -- Line: 176
    -- upvalues: Seed_Shop (copy), u8 (copy)
    if not p33 then
        return;
    end;

    local v34 = p33[1];
    local v35 = p33[2];
    local v36 = p33[3];
    u31.Rarity.ITEM_RARITY.Text = v34;

    if u31.Rarity:FindFirstChild("Details") then
        u31.Rarity.Details.Visible = false;
    end;

    if v36 and v34 == "Prismatic" then
        local u37 = nil;
        u37 = game:GetService("RunService").Heartbeat:Connect(function(p38) -- Line: 191
            -- upvalues: Seed_Shop (ref), u32 (copy), u37 (ref), u31 (copy)
            if not Seed_Shop.Enabled then
                return;
            end;

            if not (u32 and u32.Parent) then
                u37:Disconnect();

                return;
            end;

            local v39 = os.clock() * 0.1 % 1;
            local Color3_fromHSV_ret = Color3.fromHSV(v39, 1, 1);
            u31.Rarity.BackgroundColor3 = Color3_fromHSV_ret;

            if u31.Rarity.ITEM_RARITY.UIStroke then
                local UIStroke = u31.Rarity.ITEM_RARITY.UIStroke;
                local v40, v41, v42 = Color3_fromHSV_ret:ToHSV();
                UIStroke.Color = Color3.fromHSV(v40, v41, v42 / 2);
            end;

            local UIStroke = u32.Rarity.UIStroke;
            local v43, v44, v45 = Color3_fromHSV_ret:ToHSV();
            UIStroke.Color = Color3.fromHSV(v43, v44, v45 / 2);
        end);

        if not u8[u31] then
            u8[u31] = {};
        end;

        table.insert(u8[u31], u37);

        return;
    end;

    if v34 ~= "Transcendent" then
        if u32.Rarity.ITEM_RARITY.UIStroke then
            local UIStroke = u32.Rarity.ITEM_RARITY.UIStroke;
            local v46, v47, v48 = v35:ToHSV();
            UIStroke.Color = Color3.fromHSV(v46, v47, v48 / 2);
        end;

        u32.Rarity.BackgroundColor3 = v35;
        local UIStroke = u32.Rarity.UIStroke;
        local v49, v50, v51 = v35:ToHSV();
        UIStroke.Color = Color3.fromHSV(v49, v50, v51 / 2);

        return;
    end;

    if u31.Rarity:FindFirstChild("Details") then
        u31.Rarity.Details.Visible = true;
    end;

    local u52 = 1;
    local v55 = game:GetService("RunService").Heartbeat:Connect(function(p53) -- Line: 224
        -- upvalues: Seed_Shop (ref), u32 (copy), u31 (copy), u52 (ref)
        if not Seed_Shop.Enabled then
            return;
        end;

        if u32 and u32.Parent then
            if u31.Rarity.Details then
                for _, child in u31.Rarity.Details:GetChildren() do
                    child.Rotation = child.Rotation + 10 * p53;
                    local v54 = child.Size.X.Offset + u52 * 1;

                    if v54 >= 50 then
                        v54 = 50;
                        u52 = -1;
                    elseif v54 <= 0 then
                        v54 = 0;
                        u52 = 1;
                    end;

                    child.Size = UDim2.new(0, v54, 0, v54);
                end;
            end;

            return;
        end;

        animationConnection:Disconnect();
    end);

    if not u8[u31] then
        u8[u31] = {};
    end;

    table.insert(u8[u31], v55);

    if u31.Rarity.ITEM_RARITY.UIStroke then
        local UIStroke = u31.Rarity.ITEM_RARITY.UIStroke;
        local v56, v57, v58 = v35:ToHSV();
        UIStroke.Color = Color3.fromHSV(v56, v57, v58 / 2);
    end;

    local UIStroke = u31.Rarity.UIStroke;
    local v59, v60, v61 = v35:ToHSV();
    UIStroke.Color = Color3.fromHSV(v59, v60, v61 / 2);
    u32.Rarity.BackgroundColor3 = Color3.new(1, 1, 1);
    u32.Rarity.UIGradient.Enabled = true;
    u32.Rarity.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 149, 1), Color3.fromRGB(255, 238, 5));
end;

local function SetupHoverEffects(p62, p63, p64) -- Line: 272
    p62.Item_Image.Image = p64.Asset;
end;

local function SetupPurchaseButtons(p65: any, u66: any, p67: any, u68: string, p69: string) -- Line: 339
    -- upvalues: ReplicatedStorage (copy), u8 (copy)
    local v70 = u66.PurchaseButton.Main.SENSOR.Activated:Connect(function() -- Line: 340, Name: buy
        -- upvalues: u68 (copy), ReplicatedStorage (ref)
        if workspace:GetAttribute("InTutorial") and u68 ~= "Carrot" then
            return;
        end;

        ReplicatedStorage.GameEvents.BuyDailySeedShopStock:FireServer(u68);
    end);
    local v71 = u66.PurchaseButton.Main.MouseEnter:Connect(function() -- Line: 396
        -- upvalues: u66 (copy)
        u66.PurchaseButton.Main.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8);
    end);
    local v72 = u66.PurchaseButton.Main.MouseLeave:Connect(function() -- Line: 400
        -- upvalues: u66 (copy)
        u66.PurchaseButton.Main.BackgroundColor3 = Color3.new(1, 1, 1);
    end);

    if not u8[p65] then
        u8[p65] = {};
    end;

    table.insert(u8[p65], v70);

    if not u8[p65] then
        u8[p65] = {};
    end;

    table.insert(u8[p65], v71);

    if not u8[p65] then
        u8[p65] = {};
    end;

    table.insert(u8[p65], v72);
end;

local function CreateStockUpdater(p73: any, u74: any, u75: any, u76: string, u77: string, p78: string) -- Line: 413
    -- upvalues: u7 (ref), u30 (copy), u8 (copy), DataService (copy), u6 (copy), NPCLevelHandler (copy)
    local _StockValue = p73:FindFirstChild("_StockValue");

    if not _StockValue then
        _StockValue = Instance.new("NumberValue");
        _StockValue.Name = "_StockValue";
        _StockValue.Parent = p73;
    end;

    _StockValue.Value = 0;
    local v80 = _StockValue.Changed:Connect(function(p79) -- Line: 423
        -- upvalues: u7 (ref), u30 (ref), u74 (copy)
        if not u7 then
            u30.UpdateStockDisplay(u74, p79);
            u30.UpdateButtonState(u74, p79);
        end;
    end);

    if not u8[p73] then
        u8[p73] = {};
    end;

    table.insert(u8[p73], v80);

    return function(p81: string?) -- Line: 431, Name: updateStock
        -- upvalues: u74 (copy), DataService (ref), u77 (copy), u76 (copy), u6 (ref), _StockValue (ref), u30 (ref), NPCLevelHandler (ref), u75 (copy)
        if not (u74 and u74.Parent) then
            return;
        end;

        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local v82 = Data.SeedStocks[u77];

        if not v82 then
            return;
        end;

        local v83 = v82.Stocks[u76];
        local v84 = v83 and v83.Stock or 0;

        if not u6[u77] then
            u6[u77] = {};
        end;

        if not u6[u77][u76] then
            u6[u77][u76] = v82.Seed;
        end;

        _StockValue.Value = v84;
        u30.UpdateButtonState(u74, v84);
        u30.UpdateStockDisplay(u74, v84);
        local v85 = not NPCLevelHandler:HasRequiredNPCLevels(u75.LevelLocks);
        local v86;

        if v85 and u75.LevelLocks then
            local v87 = next(u75.LevelLocks);
            v86 = v87 and u75.LevelLocks[v87] or 1;
        else
            v86 = nil;
        end;

        u30.UpdateLockedState(u74, v85, v86);
    end;
end;

local function ConnectStockSignals(u88: any, u89: function, p90: string) -- Line: 476
    -- upvalues: DataService (copy), u8 (copy)
    task.spawn(function() -- Line: 477
        -- upvalues: DataService (ref), u89 (copy), u88 (copy), u8 (ref)
        for _, v in {
            {
                Source = "SeedStocks",
                Signal = DataService:GetPathSignal("SeedStocks/@")
            },
            {
                Source = "SeedStocks",
                Signal = DataService:GetPathSignal("SeedStocks")
            },
            {
                Source = "NPCPoints",
                Signal = DataService:GetPathSignal("NPCPoints/@")
            }
        } do
            local Signal2 = v.Signal;
            local Source = v.Source;

            if Signal2 then
                local v91 = Signal2:Connect(function() -- Line: 488
                    -- upvalues: u89 (ref), Source (copy)
                    u89(Source);
                end);
                local v92 = u88;

                if not u8[v92] then
                    u8[v92] = {};
                end;

                table.insert(u8[v92], v91);
            end;
        end;

        task.wait(0.05);
        u89();
    end);
end;

local function CleanupFrame(p93) -- Line: 503
    -- upvalues: u8 (copy)
    if u8[p93] then
        for _, v in u8[p93] do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        u8[p93] = nil;
    end;

    if not p93 then
        return;
    end;

    local _StockValue = p93:FindFirstChild("_StockValue");

    if _StockValue then
        _StockValue:Destroy();
    end;
end;

local function SetupDetailAnimation(p94: userdata) -- Line: 535
    -- upvalues: u8 (copy)
    if p94:FindFirstChild("Details") and p94:FindFirstChild("Details"):FindFirstChild("Sunray") then
        local Sunray = p94.Details.Sunray;
        local v96 = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 539
            -- upvalues: Sunray (copy)
            local v95 = Sunray;
            v95.Rotation = v95.Rotation + 0.1;
        end);

        if not u8[p94] then
            u8[p94] = {};
        end;

        table.insert(u8[p94], v96);
    end;
end;

local function SetupItemFrame(u97: any, p98: string, p99: any, p100: string, p101: table) -- Line: 548
    -- upvalues: CleanupFrame (copy), SetupRarityDisplay (copy), Item_Module (copy), SetupDetailAnimation (copy), Comma_Module (copy), NumberUtil (copy), CurrencyData (copy), SetupPurchaseButtons (copy), CreateStockUpdater (copy), DataService (copy), u8 (copy)
    CleanupFrame(u97);
    u97.Name = p98;
    u97.SeedName.Text = p99.Seed.SeedName;
    u97.Item_Image.Image = p99.Seed.Asset;
    u97.Item_Image.Rotation = 0;
    SetupRarityDisplay(u97, u97, Item_Module.Return_Rarity_Data(p99.Seed.SeedRarity));
    u97.Item_Image.Image = p99.Seed.Asset;
    SetupDetailAnimation(u97);
    local v102;

    if p99.SpecialCurrencyType then
        v102 = Comma_Module.Comma(p99.Price) .. "";
    else
        v102 = NumberUtil.DisplaySheckles(p99.Price);
    end;

    if u97.PurchaseButton.Main:FindFirstChild("Price") then
        u97.PurchaseButton.Main.Price.Text = v102;
    end;

    if p99.SpecialCurrencyType then
        local _ = CurrencyData[p99.SpecialCurrencyType];
    end;

    SetupPurchaseButtons(u97, u97, p99, p98, p100);
    local u103 = CreateStockUpdater(u97, u97, p99, p98, p100, v102);
    task.spawn(function() -- Line: 477
        -- upvalues: DataService (ref), u103 (copy), u97 (copy), u8 (ref)
        for _, v in {
            {
                Source = "SeedStocks",
                Signal = DataService:GetPathSignal("SeedStocks/@")
            },
            {
                Source = "SeedStocks",
                Signal = DataService:GetPathSignal("SeedStocks")
            },
            {
                Source = "NPCPoints",
                Signal = DataService:GetPathSignal("NPCPoints/@")
            }
        } do
            local Signal2 = v.Signal;
            local Source = v.Source;

            if Signal2 then
                local v104 = Signal2:Connect(function() -- Line: 488
                    -- upvalues: u103 (ref), Source (copy)
                    u103(Source);
                end);
                local v105 = u97;

                if not u8[v105] then
                    u8[v105] = {};
                end;

                table.insert(u8[v105], v104);
            end;
        end;

        task.wait(0.05);
        u103();
    end);

    return u97;
end;

local function PreloadAssets(p106) -- Line: 597
    -- upvalues: UserInputService (copy), DailySeedShopData (copy), ContentProvider (copy)
    if UserInputService.TouchEnabled then
        return;
    end;

    local u107 = {};

    for i, v in DailySeedShopData do
        if p106.Stocks[i] then
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Image = v.Seed.Asset;
            table.insert(u107, ImageLabel);
        end;
    end;

    task.spawn(function() -- Line: 611
        -- upvalues: ContentProvider (ref), u107 (copy)
        ContentProvider:PreloadAsync(u107);

        for _, v in u107 do
            v:Destroy();
        end;

        table.clear(u107);
    end);
end;

local function SetupFrames() -- Line: 625
    -- upvalues: u5 (copy), DataService (copy), PreloadAssets (copy), DailySeedShopData (copy), UpdateService (copy), FeaturedDeal (copy), u1 (copy), SetupItemFrame (copy)
    table.clear(u5);
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local v108 = Data.SeedStocks["Daily Deals"];

    if not (v108 and v108.Stocks) then
        return;
    end;

    PreloadAssets(v108);
    local v109 = {};
    local v110 = 1;

    for i, v in DailySeedShopData do
        if v108.Stocks[i] and not (UpdateService:IsHiddenFromUpdate(v.Seed.SeedName) or UpdateService:IsHiddenAfterUpdate(v.Seed.SeedName)) then
            local v111 = FeaturedDeal;

            if not v108.Stocks[i].IsGoodSeed then
                v111 = u1[v110];
                v110 = v110 + 1;
            end;

            if v111 then
                SetupItemFrame(v111, i, v, "Daily Deals", v109);
                table.insert(v109, v111);
                u5[i] = v111;
                v111.Visible = true;
            end;
        end;
    end;
end;

local u112 = {};

local function UpdateRefreshLabel() -- Line: 698
    -- upvalues: DataService (copy), ShopTabData (copy), SeedShopConfigData (copy), Title (copy), NumberUtil (copy), u112 (copy), TradeWorldController (copy), Restock_SFX (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v113 = DataService:GetData().SeedStocks["Daily Deals"];
    local v114 = v113 and v113.ForcedSeedEndTimestamp and (v113.ForcedSeedEndTimestamp - ServerTimeNow or -1) or -1;

    if v114 < 0 then
        local RefreshTime = (ShopTabData.Seed["Daily Deals"] or SeedShopConfigData).RefreshTime;
        v114 = RefreshTime - ServerTimeNow % RefreshTime;
    end;

    Title.Text = v114 <= 0 and "Restocking" or "New deals in " .. NumberUtil.compactFormat(v114);

    for _, v in u112 do
        v.Text = v114 <= 0 and "Now" or NumberUtil.compactFormat(v114);
    end;

    if v114 <= 1 and not TradeWorldController:IsInWorld() then
        Restock_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Restock_SFX.TimePosition = 0;
        Restock_SFX.Playing = true;
        require(game.ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#ADD8E6\"><b>Your Daily Deals Shop stock has restocked!</b></font>");
    end;
end;

local function SetupTimer() -- Line: 718
    -- upvalues: UpdateRefreshLabel (copy)
    while true do
        UpdateRefreshLabel();
        task.wait(1);
    end;
end;

v2.OnCategoryChanged:Connect(function(p115: string) -- Line: 729, Name: OnTabSelected
    -- upvalues: SetupFrames (copy), u3 (ref), u4 (copy), UpdateRefreshLabel (copy)
    if p115 == "Daily Deals" then
        SetupFrames();
        u3 = nil;
        u4:Fire();
        task.spawn(UpdateRefreshLabel);
    end;
end);

function v9.Start(p116) -- Line: 745
    -- upvalues: GuiController (copy), Seed_Shop (copy), DevProductIds (copy), MarketController (copy), PolicyService (copy), LocalPlayer (copy), DataService (copy), SetupFrames (copy), UpdateService (copy), SetupTimer (copy)
    GuiController:UsePopupAnims(Seed_Shop);
    Seed_Shop.Daily.Frame.ExitButton.Activated:Connect(function() -- Line: 748
        -- upvalues: GuiController (ref), Seed_Shop (ref)
        GuiController:Close(Seed_Shop);
    end);
    local Restock = Seed_Shop.Daily.Frame.Restock;
    local u117 = false;
    Restock.SENSOR.Activated:Connect(function() -- Line: 755
        -- upvalues: u117 (ref), DevProductIds (ref), MarketController (ref)
        if u117 then
            return;
        end;

        MarketController:PromptPurchase(DevProductIds.DailySeedShopRestock.PurchaseID, Enum.InfoType.Product);
    end);
    task.spawn(function() -- Line: 762
        -- upvalues: PolicyService (ref), LocalPlayer (ref), u117 (ref), Restock (copy)
        local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

        if PolicyInfoForPlayerAsync then
            PolicyInfoForPlayerAsync = PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted;
        end;

        u117 = PolicyInfoForPlayerAsync == true;
        Restock.Visible = not u117;
    end);
    Seed_Shop.Daily.Frame.Restock.MouseEnter:Connect(function() -- Line: 768
        -- upvalues: Seed_Shop (ref)
        Seed_Shop.Daily.Frame.Restock.BackgroundColor3 = Color3.fromRGB(220, 180, 0);
    end);
    Seed_Shop.Daily.Frame.Restock.MouseLeave:Connect(function() -- Line: 772
        -- upvalues: Seed_Shop (ref)
        Seed_Shop.Daily.Frame.Restock.BackgroundColor3 = Color3.fromRGB(255, 204, 0);
    end);
    task.spawn(function() -- Line: 778
        -- upvalues: DataService (ref), SetupFrames (ref)
        local PathSignal = DataService:GetPathSignal("SeedStocks/Daily Deals/@");

        if PathSignal then
            local u118 = {};
            local Data = DataService:GetData();

            if Data and (Data.SeedStocks and Data.SeedStocks["Daily Deals"]) then
                u118["Daily Deals"] = Data.SeedStocks["Daily Deals"].Seed;
            end;

            PathSignal:Connect(function(p119) -- Line: 789
                -- upvalues: DataService (ref), u118 (copy), SetupFrames (ref)
                local Data2 = DataService:GetData();

                if not (Data2 and Data2.SeedStocks) then
                    return;
                end;

                local v120 = Data2.SeedStocks["Daily Deals"];

                if not v120 then
                    return;
                end;

                local v121 = u118["Daily Deals"] and u118["Daily Deals"] ~= v120.Seed and true or false;
                u118["Daily Deals"] = v120.Seed;

                if v121 then
                    SetupFrames();
                end;
            end);
        end;
    end);

    if not UpdateService:IsUpdateDone() then
        task.delay(UpdateService:GetRemainingTimeUntilUpdate() + 1, function() -- Line: 812
            -- upvalues: SetupFrames (ref)
            SetupFrames();
        end);
    end;

    task.spawn(SetupTimer);
    SetupFrames();
end;

task.spawn(v9.Start, v9);

return v9;