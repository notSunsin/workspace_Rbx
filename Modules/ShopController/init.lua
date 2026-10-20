-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
game:GetService("SoundService");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local EventInfinitePackData = require(ReplicatedStorage.Data.EventInfinitePackData);
local InfinitePackData = require(ReplicatedStorage.Data.InfinitePackData);
require(ReplicatedStorage.Data.InfinitePackData.InfinitePackTypes);
require(ReplicatedStorage.Data.SeedPackData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local DiggingEventConfigData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingEventConfigData);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local TwilightPackData = require(ReplicatedStorage.Data.Packs.TwilightPackData);
local ScarletAspenLimitedSeedData = require(ReplicatedStorage.Data.Packs.ScarletAspenLimitedSeedData);
local Summer2026PackData = require(ReplicatedStorage.Data.Packs.Summer2026PackData);
local GoldenShovelPackData = require(ReplicatedStorage.Data.Packs.GoldenShovelPackData);
local SaintPatricksBundleData = require(ReplicatedStorage.Data.Packs.SaintPatricksBundleData);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.DataService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.RetryPcall);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local Notification = require(ReplicatedStorage.Modules.Notification);
local ExoticPackData = require(ReplicatedStorage.Data.ExoticPackData);
require(ReplicatedStorage.Modules.CountDictionary);
require(ReplicatedStorage.Modules.InventoryService);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local PityHoverController = require(ReplicatedStorage.Modules.PityHoverController);
local DiggingUIController = require(ReplicatedStorage.Modules.DiggingMinigame.DiggingUIController);
local ImageCycle = require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local PityData = require(ReplicatedStorage.Data.PityData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local SuperSeedRewardUIController = require(ReplicatedStorage.Modules.SuperSeedRewardUIController);
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
local SeedRainDropData = require(ReplicatedStorage.Data.SeedRainDropData);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
local IsDev = require(ReplicatedStorage.Modules.IsDev);
local script_PetProducts = require(script.PetProducts);
local WeatherUtils = require(ReplicatedStorage.Modules.WeatherUtils);
require(ReplicatedStorage.UserGenerated.FastFlags);
local ReplaceNormalPack = EventInfinitePackData.ReplaceNormalPack;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Shop_UI = PlayerGui.Shop_UI;
local u1 = {};

local function Darken(p2, p3: number) -- Line: 83
    local v4, v5, v6 = p2:ToHSV();

    return Color3.fromHSV(v4, v5, (math.clamp(v6 / p3, 0, 1)));
end;

local u7 = {};
local u8 = 0;

function u1._updateNotifications(p9) -- Line: 90
    -- upvalues: PlayerGui (copy), u7 (copy)
    PlayerGui.Hud_UI.SideBtns.Shop.Notify.Visible = next(u7) ~= nil;
end;

function u1.Notify(p10) -- Line: 94
    -- upvalues: u8 (ref), u7 (copy), u1 (copy)
    local v11 = u8 + 1;
    u8 = v11;
    table.insert(u7, v11);
    u1:_updateNotifications();

    return v11;
end;

function u1.ClearNotification(p12, p13) -- Line: 102
    -- upvalues: u7 (copy), u1 (copy)
    if not p13 then
        return false;
    end;

    local table_find_ret = table.find(u7, p13);

    if not table_find_ret then
        return true;
    end;

    table.remove(u7, table_find_ret);
    u1:_updateNotifications();

    return true;
end;

function u1._notifyUntilOpened(p14) -- Line: 118
    -- upvalues: GuiController (copy), Shop_UI (copy), u1 (copy)
    local StateForGui = GuiController:GetStateForGui(Shop_UI);

    if StateForGui.Visible:Get() then
        return;
    end;

    local u15 = u1:Notify();
    local u16 = nil;
    u16 = StateForGui.Visible:Listen(function(p17: boolean) -- Line: 127
        -- upvalues: u1 (ref), u15 (copy), u16 (ref)
        if not p17 then
            return;
        end;

        u1:ClearNotification(u15);

        if u16 then
            u16:Disconnect();
            u16 = nil;
        end;
    end);
end;

function u1._initSummer2026Pack(p18) -- Line: 143
    -- upvalues: Shop_UI (copy), PolicyService (copy), LocalPlayer (copy), DataService (copy), MarketController (copy), UseDynamicPrices (copy), Summer2026PackData (copy), Comma_Module (copy), Notification (copy), GiftController (copy), PetEggOddsController (copy), NumberUtil (copy), UpdateService (copy)
    local Summer2026Pack = Shop_UI.Frame.ScrollingFrame.Summer2026Pack;
    local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

    if PolicyInfoForPlayerAsync and PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted then
        Summer2026Pack.Visible = false;

        return;
    end;

    local Cost = Summer2026Pack.Buy.Cost;
    local Worth = Summer2026Pack.Buy.Worth;
    local Position = Cost.Position;
    local u19 = nil;

    local function RefreshOwned() -- Line: 161
        -- upvalues: DataService (ref), u19 (ref), MarketController (ref), Cost (copy), Worth (copy), Position (copy), UseDynamicPrices (ref), Summer2026PackData (ref), Comma_Module (ref)
        local Data = DataService:GetData();
        local v20 = Data and Data.ShovelSkinData and Data.ShovelSkinData.OwnedShovels;

        if v20 then
            v20 = v20.SummerSpade;
        end;

        local v21 = v20 == true;

        if v21 == u19 then
            return;
        end;

        u19 = v21;

        if v21 then
            MarketController:RemovePriceLabel(Cost);
            Worth.Visible = false;
            Cost.Position = UDim2.fromScale(0.5, Position.Y.Scale);
            Cost.Text = "OWNED";

            return;
        end;

        Worth.Visible = true;
        Cost.Position = Position;

        if UseDynamicPrices then
            MarketController:SetPriceLabel(Cost, Summer2026PackData.ProductId);

            return;
        end;

        Cost.Text = `<font size="19"><font weight="400">{utf8.char(57346)}</font>{Comma_Module.Comma(399)}</font>`;
    end;

    Summer2026Pack.Buy.Activated:Connect(function() -- Line: 185
        -- upvalues: u19 (ref), Notification (ref), MarketController (ref), Summer2026PackData (ref)
        if u19 then
            Notification:CreateNotification("You already own the Beach Bundle!");

            return;
        end;

        MarketController:PromptPurchase(Summer2026PackData.ProductId, Enum.InfoType.Product);
    end);
    Summer2026Pack.Gift.Activated:Connect(function() -- Line: 193
        -- upvalues: GiftController (ref), Summer2026PackData (ref)
        GiftController:PromptGiftFromGiftId(Summer2026PackData.GiftId);
    end);
    local OddsButton = Summer2026Pack:FindFirstChild("OddsButton", true);

    if OddsButton then
        OddsButton.Activated:Connect(function() -- Line: 199
            -- upvalues: PetEggOddsController (ref), Shop_UI (ref)
            PetEggOddsController:Open("Premium Coastal Egg", Shop_UI);
        end);
    end;

    RefreshOwned();
    local PathSignal = DataService:GetPathSignal("ShovelSkinData/@");

    if PathSignal then
        PathSignal:Connect(RefreshOwned);
    end;

    task.spawn(function() -- Line: 210
        -- upvalues: Summer2026PackData (ref), Summer2026Pack (copy), NumberUtil (ref), UpdateService (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v22 = Summer2026PackData.StartTime.UnixTimestamp <= ServerTimeNow;
            local v23 = Summer2026PackData.EndTime - ServerTimeNow;
            Summer2026Pack.Timer.Text = NumberUtil.formatShopTime((math.max(v23, 0)));

            if v22 then
                if v23 > 0 then
                    v22 = not UpdateService:IsHiddenFromUpdate("Summer2026Pack");
                else
                    v22 = false;
                end;
            end;

            Summer2026Pack.Visible = v22;
            task.wait(1);
        end;
    end);
end;

function u1._initTwilightPack(p24) -- Line: 228
    -- upvalues: DataService (copy), Shop_UI (copy), MarketController (copy), TwilightPackData (copy), GiftController (copy), UseDynamicPrices (copy), Comma_Module (copy), UpdateService (copy), NumberUtil (copy)
    if not DataService:GetData() then
        return;
    end;

    local TwilightPack = Shop_UI.Frame.ScrollingFrame.TwilightPack;
    TwilightPack.Visible = true;
    TwilightPack.Frame.Buy.Activated:Connect(function() -- Line: 237
        -- upvalues: MarketController (ref), TwilightPackData (ref)
        MarketController:PromptPurchase(TwilightPackData.ProductId, Enum.InfoType.Product);
    end);
    TwilightPack.Frame.Gift.Activated:Connect(function() -- Line: 241
        -- upvalues: GiftController (ref), TwilightPackData (ref)
        GiftController:PromptGiftFromGiftId(TwilightPackData.GiftId);
    end);

    if UseDynamicPrices then
        if not UseDynamicPrices then
            warn((`{TwilightPack.Frame.Buy.Cost:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
        end;

        MarketController:SetPriceLabel(TwilightPack.Frame.Buy.Cost, TwilightPackData.ProductId);
    else
        TwilightPack.Frame.Buy.Cost.Text = `<font size="19"><font weight="400">{utf8.char(57346)}</font>{Comma_Module.Comma(299)}</font>`;
    end;

    task.spawn(function() -- Line: 256
        -- upvalues: UpdateService (ref), TwilightPack (copy), TwilightPackData (ref), NumberUtil (ref)
        while not UpdateService:IsHiddenAfterUpdate("Shop Twilight Pack") do
            local v25 = TwilightPackData.EndTime.UnixTimestamp - workspace:GetServerTimeNow();
            TwilightPack.Frame.Timer.Text = NumberUtil.formatShopTime(v25);
            TwilightPack.Visible = v25 > 0;
            task.wait(1);
        end;

        TwilightPack.Visible = false;
    end);
end;

local function ComputeSeedRainDropWeights(p26) -- Line: 277
    local v27 = {};
    local v28 = {};

    for i, v in p26 do
        table.insert(v27, i);
        table.insert(v28, 1 / v.StockChance);
    end;

    local v29 = {};

    for i, v in v27 do
        local v30 = i;
        local v31 = 0;
        local v32 = { 1 };

        for i2, v2 in v28 do
            if i2 ~= v30 then
                v31 = v31 + 1;
                local v33 = v2;
                local v34 = {};

                for i3 = 0, v31 do
                    v34[i3] = (v32[i3] or 0) * (1 - v33) + (v32[i3 - 1] or 0) * v33;
                    local _ = i3;
                end;

                v32 = v34;
            end;
        end;

        local v35 = 0;

        for i2 = 0, #v27 - 1 do
            v35 = v35 + (v32[i2] or 0) / (i2 + 1);
            local _ = i2;
        end;

        v29[v] = v28[v30] * v35;
    end;

    return v29;
end;

local u36 = {
    Prismatic = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0.7, 1)),
        ColorSequenceKeypoint.new(0.25, Color3.fromHSV(0.12, 0.7, 1)),
        ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.33, 0.7, 1)),
        ColorSequenceKeypoint.new(0.75, Color3.fromHSV(0.58, 0.7, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromHSV(0.78, 0.7, 1))
    })
};

local function OpenSeedRainOdds(p37: string, p38: string) -- Line: 323
    -- upvalues: SeedRainDropData (copy), ComputeSeedRainDropWeights (copy), GenericRewardsUIController (copy), Shop_UI (copy), u36 (copy), GGStaticData (copy)
    local v39 = SeedRainDropData[p38];

    if not v39 then
        return;
    end;

    local v40 = {};

    for i, v in ComputeSeedRainDropWeights(v39) do
        table.insert(v40, {
            Reward = {
                Type = "Seed",
                Quantity = 1,
                Value = i
            },
            Weight = v
        });
    end;

    GenericRewardsUIController:Open({
        DisplayOdds = true,
        Title = `{p37} Seed Rain`,
        RewardData = v40,
        Breadcrumb = Shop_UI,
        HeaderColor = u36[p37] or GGStaticData.RarityColorMap[p37],
        Disclaimer = p37 == "Divine" and "PRESETS/RoundedOddsCompliance" or nil
    });
end;

function u1._initSeedRain(p41) -- Line: 347
    -- upvalues: ReplicatedStorage (copy), Shop_UI (copy), DataService (copy), ClientABTests (copy), LocalPlayer (copy), PolicyService (copy), DevProductIds (copy), WeatherUtils (copy), Notification (copy), MarketController (copy), OpenSeedRainOdds (copy)
    local TradeWorldData = require(ReplicatedStorage.Data.TradeWorldData);
    local SeedRain = Shop_UI.Frame.ScrollingFrame.SeedRain;

    if game.PlaceId == TradeWorldData.PlaceId and true or TradeWorldData.ForceInWorld == true then
        SeedRain.Visible = false;

        return;
    end;

    if not DataService:GetData() then
        return;
    end;

    if not ClientABTests.GetAttributeAsync(LocalPlayer, "AB_PurchaseSeedRain", false) then
        SeedRain.Visible = false;

        return;
    end;

    local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

    if PolicyInfoForPlayerAsync and PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted then
        SeedRain.Visible = false;

        return;
    end;

    SeedRain.Visible = true;
    local u42 = {
        Mythical = {
            WeatherAttribute = "MythicalSeedRain",
            ProductId = DevProductIds.MythicalSeedRain.PurchaseID
        },
        Divine = {
            WeatherAttribute = "DivineSeedRain",
            ProductId = DevProductIds.DivineSeedRain.PurchaseID
        },
        Prismatic = {
            WeatherAttribute = "PrismaticSeedRain",
            ProductId = DevProductIds.PrismaticSeedRain.PurchaseID
        }
    };

    local function UpdateForRarity(u43: string) -- Line: 399
        -- upvalues: u42 (copy), SeedRain (copy), WeatherUtils (ref), Notification (ref), MarketController (ref), OpenSeedRainOdds (ref)
        local u44 = u42[u43];

        if not u44 then
            return;
        end;

        local v45 = SeedRain.List:FindFirstChild(u43);
        v45.Buttons.Buy.Activated:Connect(function() -- Line: 405
            -- upvalues: WeatherUtils (ref), u44 (copy), Notification (ref), u43 (copy), MarketController (ref)
            if WeatherUtils.IsThisWeatherRunning(u44.WeatherAttribute) then
                Notification:CreateNotification((`{u43} Seed Rain is already active / on cooldown!`));

                return;
            end;

            MarketController:PromptPurchase(u44.ProductId, Enum.InfoType.Product);
        end);
        MarketController:SetPriceLabel(v45.Buttons.Buy, u44.ProductId);
        v45.OddsButton.Activated:Connect(function() -- Line: 418
            -- upvalues: OpenSeedRainOdds (ref), u43 (copy), u44 (copy)
            OpenSeedRainOdds(u43, u44.WeatherAttribute);
        end);
    end;

    UpdateForRarity("Mythical");
    UpdateForRarity("Divine");
    UpdateForRarity("Prismatic");
end;

function u1._initSuperSeedPackV1(p46) -- Line: 428
    -- upvalues: DataService (copy), ClientABTests (copy), LocalPlayer (copy), Shop_UI (copy), IsDev (copy), PolicyService (copy), DevProductIds (copy), SuperSeedRewardUIController (copy), MarketController (copy), GiftController (copy)
    if not DataService:GetData() then
        return;
    end;

    local AttributeAsync = ClientABTests.GetAttributeAsync(LocalPlayer, "AB_SuperSeedPack_V1", false);
    local SuperSeedPackV1 = Shop_UI.Frame.ScrollingFrame.SuperSeedPackV1;

    if not (AttributeAsync or IsDev()) then
        SuperSeedPackV1.Visible = false;

        return;
    end;

    local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

    if PolicyInfoForPlayerAsync and PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted then
        SuperSeedPackV1.Visible = false;

        return;
    end;

    local u47 = {
        [1] = {
            ProductId = DevProductIds.SuperSeed1.PurchaseID
        },
        [3] = {
            ProductId = DevProductIds.SuperSeed3.PurchaseID
        },
        [10] = {
            ProductId = DevProductIds.SuperSeed10.PurchaseID
        }
    };
    SuperSeedPackV1.TitleFrame.InfoButton.Activated:Connect(function() -- Line: 463
        -- upvalues: SuperSeedRewardUIController (ref)
        SuperSeedRewardUIController:Open();
    end);
    SuperSeedPackV1.Visible = true;

    local function UpdateForAmount(p48: number) -- Line: 469
        -- upvalues: u47 (copy), SuperSeedPackV1 (copy), MarketController (ref), GiftController (ref)
        local u49 = u47[p48];

        if not u49 then
            return;
        end;

        local v50 = SuperSeedPackV1.List:FindFirstChild(p48);
        v50.Buttons.Buy.Activated:Connect(function() -- Line: 475
            -- upvalues: MarketController (ref), u49 (copy)
            MarketController:PromptPurchase(u49.ProductId, Enum.InfoType.Product);
        end);
        v50.Buttons.Gift.Activated:Connect(function() -- Line: 478
            -- upvalues: GiftController (ref), u49 (copy)
            GiftController:PromptGiftFromNormalId(u49.ProductId);
        end);
        MarketController:SetPriceLabel(v50.Buttons.Buy, u49.ProductId);
    end;

    UpdateForAmount(1);
    UpdateForAmount(3);
    UpdateForAmount(10);
end;

function u1._initSuperSeedPackV2(p51) -- Line: 490
    -- upvalues: DataService (copy), ClientABTests (copy), LocalPlayer (copy), Shop_UI (copy), IsDev (copy), PolicyService (copy), MarketController (copy), DevProductIds (copy), GiftController (copy), SuperSeedRewardUIController (copy)
    if not DataService:GetData() then
        return;
    end;

    local AttributeAsync = ClientABTests.GetAttributeAsync(LocalPlayer, "AB_SuperSeedPack_V2", false);
    local SuperSeedPackV2 = Shop_UI.Frame.ScrollingFrame.SuperSeedPackV2;

    if not (AttributeAsync or IsDev()) then
        SuperSeedPackV2.Visible = false;

        return;
    end;

    local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

    if PolicyInfoForPlayerAsync and PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted then
        SuperSeedPackV2.Visible = false;

        return;
    end;

    SuperSeedPackV2.Visible = true;
    SuperSeedPackV2.Buy.Activated:Connect(function() -- Line: 514
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.SuperSeed9.PurchaseID, Enum.InfoType.Product);
    end);
    SuperSeedPackV2.Gift.Activated:Connect(function() -- Line: 517
        -- upvalues: GiftController (ref), DevProductIds (ref)
        GiftController:PromptGiftFromNormalId(DevProductIds.SuperSeed9.PurchaseID);
    end);
    SuperSeedPackV2.TitleFrame.InfoButton.Activated:Connect(function() -- Line: 521
        -- upvalues: SuperSeedRewardUIController (ref)
        SuperSeedRewardUIController:Open();
    end);
    MarketController:SetPriceLabel(SuperSeedPackV2.Buy, DevProductIds.SuperSeed9.PurchaseID);
end;

local function CycleRainbowText(u52: userdata) -- Line: 539
    -- upvalues: RunService (copy)
    return RunService.PostSimulation:Connect(function() -- Line: 540
        -- upvalues: u52 (copy)
        u52.TextColor3 = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
    end);
end;

function u1._initLimitedSeed(p53) -- Line: 550
    -- upvalues: Shop_UI (copy), UpdateService (copy), ScarletAspenLimitedSeedData (copy), DataService (copy), RunService (copy), MarketController (copy), GiftController (copy), ReplicatedStorage (copy)
    local LimitedStock = Shop_UI.Frame.ScrollingFrame.LimitedStock;

    if UpdateService:IsHiddenAfterUpdate(ScarletAspenLimitedSeedData.UpdateGateKey) or workspace:GetServerTimeNow() >= ScarletAspenLimitedSeedData.EndTime then
        LimitedStock.Visible = false;

        return;
    end;

    if not DataService:GetData() then
        return;
    end;

    LimitedStock.LayoutOrder = 3;
    LimitedStock.Title.Text = ScarletAspenLimitedSeedData.Title;
    LimitedStock.Title.TextLabel.Text = ScarletAspenLimitedSeedData.Title;
    LimitedStock.Seed.Text = `Rainbow {ScarletAspenLimitedSeedData.SeedDisplay}`;
    local Seed = LimitedStock.Seed;
    local u54 = RunService.PostSimulation:Connect(function() -- Line: 540
        -- upvalues: Seed (copy)
        Seed.TextColor3 = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
    end);
    LimitedStock.Visible = true;
    LimitedStock.Stock.Text = "Syncing...";
    LimitedStock.Buy.Visible = false;
    LimitedStock.Gift.Visible = false;
    LimitedStock.Buy.Activated:Connect(function() -- Line: 586
        -- upvalues: MarketController (ref), ScarletAspenLimitedSeedData (ref)
        MarketController:PromptPurchase(ScarletAspenLimitedSeedData.ProductId, Enum.InfoType.Product);
    end);
    LimitedStock.Gift.Activated:Connect(function() -- Line: 592
        -- upvalues: GiftController (ref), ScarletAspenLimitedSeedData (ref)
        GiftController:PromptGiftFromNormalId(ScarletAspenLimitedSeedData.ProductId);
    end);
    MarketController:SetPriceLabel(LimitedStock.Buy, ScarletAspenLimitedSeedData.ProductId);
    local u55 = false;

    local function CloseCard() -- Line: 601
        -- upvalues: u55 (ref), LimitedStock (copy), u54 (copy)
        if u55 then
            return;
        end;

        u55 = true;
        LimitedStock.Visible = false;
        u54:Disconnect();
    end;

    task.spawn(function() -- Line: 611
        -- upvalues: u55 (ref), ScarletAspenLimitedSeedData (ref), LimitedStock (copy), u54 (copy)
        while not u55 and workspace:GetServerTimeNow() < ScarletAspenLimitedSeedData.EndTime do
            task.wait(1);
        end;

        if u55 then
            return;
        end;

        u55 = true;
        LimitedStock.Visible = false;
        u54:Disconnect();
    end);
    local ReplicatedGlobalStock = ReplicatedStorage.Data.ReplicatedGlobalStock;
    local Id = ScarletAspenLimitedSeedData.LimitedStock.Id;
    local u56 = ReplicatedGlobalStock:FindFirstChild(Id) or ReplicatedGlobalStock:WaitForChild(Id, 30);

    if not (u56 and u56:IsA("NumberValue")) then
        warn((`[ShopController] no replicated stock value "{Id}"; the limited seed card stays unbuyable`));

        return;
    end;

    u56.Changed:Connect(function() -- Line: 634, Name: updateStock
        -- upvalues: u56 (copy), LimitedStock (copy), ScarletAspenLimitedSeedData (ref)
        local math_floor_ret = math.floor(u56.Value);
        local math_max_ret = math.max(0, math_floor_ret);
        local v57 = math_max_ret > 0;
        LimitedStock.Buy.Visible = v57;
        LimitedStock.Gift.Visible = v57;
        LimitedStock.Stock.Text = not v57 and "Out of Stock" or `{math_max_ret} / {ScarletAspenLimitedSeedData.LimitedStock.Max}`;
    end);
    local math_floor_ret = math.floor(u56.Value);
    local math_max_ret = math.max(0, math_floor_ret);
    local v58 = math_max_ret > 0;
    LimitedStock.Buy.Visible = v58;
    LimitedStock.Gift.Visible = v58;
    LimitedStock.Stock.Text = not v58 and "Out of Stock" or `{math_max_ret} / {ScarletAspenLimitedSeedData.LimitedStock.Max}`;
end;

function u1._initSaintPatricksPack(p59) -- Line: 650
    -- upvalues: DataService (copy), Shop_UI (copy), MarketController (copy), SaintPatricksBundleData (copy), UseDynamicPrices (copy), Comma_Module (copy), UpdateService (copy), NumberUtil (copy)
    if not DataService:GetData() then
        return;
    end;

    local SaintPatricksPack = Shop_UI.Frame.ScrollingFrame.SaintPatricksPack;
    SaintPatricksPack.Visible = true;
    SaintPatricksPack.Buy.Activated:Connect(function() -- Line: 659
        -- upvalues: MarketController (ref), SaintPatricksBundleData (ref)
        MarketController:PromptPurchase(SaintPatricksBundleData.ProductId, Enum.InfoType.Product);
    end);

    if UseDynamicPrices then
        if not UseDynamicPrices then
            warn((`{SaintPatricksPack.Buy.Cost:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
        end;

        MarketController:SetPriceLabel(SaintPatricksPack.Buy, SaintPatricksBundleData.ProductId);
    else
        SaintPatricksPack.Buy.Text = `<font size="19"><font weight="400">{utf8.char(57346)}</font>{Comma_Module.Comma(1199)}</font>`;
    end;

    task.spawn(function() -- Line: 674
        -- upvalues: UpdateService (ref), SaintPatricksPack (copy), SaintPatricksBundleData (ref), NumberUtil (ref)
        while not UpdateService:IsHiddenAfterUpdate("Saint Patricks") do
            local v60 = SaintPatricksBundleData.EndTime.UnixTimestamp - workspace:GetServerTimeNow();
            SaintPatricksPack.bg.Timer.Text = NumberUtil.formatShopTime(v60);
            SaintPatricksPack.Visible = v60 > 0;
            task.wait(1);
        end;

        SaintPatricksPack.Visible = false;
    end);
end;

function u1._initGoldShovelPack(p61) -- Line: 691
    -- upvalues: Shop_UI (copy), DataService (copy), MarketController (copy), UseDynamicPrices (copy), GoldenShovelPackData (copy), Notification (copy), GiftController (copy), UpdateService (copy)
    local GoldShovel = Shop_UI.Frame.ScrollingFrame.GoldShovel;
    GoldShovel.Visible = false;
    local u62 = nil;

    local function v65() -- Line: 696
        -- upvalues: DataService (ref), u62 (ref), MarketController (ref), GoldShovel (copy), UseDynamicPrices (ref), GoldenShovelPackData (ref)
        local Data = DataService:GetData();
        local v63 = Data and Data.ShovelSkinData and Data.ShovelSkinData.OwnedShovels;

        if v63 then
            v63 = v63.GoldenShovel;
        end;

        local v64 = v63 == true;

        if v64 == u62 then
            return;
        end;

        u62 = v64;

        if not v64 then
            if UseDynamicPrices then
                MarketController:SetPriceLabel(GoldShovel.Buy, GoldenShovelPackData.ProductId);
            end;

            return;
        end;

        MarketController:RemovePriceLabel(GoldShovel.Buy);
        GoldShovel.Buy.Text = "OWNED";
    end;

    GoldShovel.Buy.Activated:Connect(function() -- Line: 711
        -- upvalues: u62 (ref), Notification (ref), MarketController (ref), GoldenShovelPackData (ref)
        if u62 then
            Notification:CreateNotification("You already own the Golden Shovel Pack!");

            return;
        end;

        MarketController:PromptPurchase(GoldenShovelPackData.ProductId, Enum.InfoType.Product);
    end);
    GoldShovel.Gift.Activated:Connect(function() -- Line: 719
        -- upvalues: GiftController (ref), GoldenShovelPackData (ref)
        GiftController:PromptGiftFromGiftId(GoldenShovelPackData.GiftId);
    end);
    v65();
    local PathSignal = DataService:GetPathSignal("ShovelSkinData/@");

    if PathSignal then
        PathSignal:Connect(v65);
    end;

    task.spawn(function() -- Line: 731
        -- upvalues: GoldShovel (copy), UpdateService (ref)
        while GoldShovel.Parent do
            GoldShovel.Visible = not UpdateService:IsHiddenFromUpdate("Gold Shovel Pack");
            task.wait(1);
        end;
    end);
end;

function u1._initRainbowShovelPack(p66) -- Line: 739
    -- upvalues: DataService (copy), Shop_UI (copy), Notification (copy), MarketController (copy), DevProductIds (copy), UseDynamicPrices (copy), UpdateService (copy), NumberUtil (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local RainbowShovel = Shop_UI.Frame.ScrollingFrame.RainbowShovel;
    RainbowShovel.Visible = true;

    local function UpdateOwned() -- Line: 748
        -- upvalues: DataService (ref), RainbowShovel (copy)
        local Data2 = DataService:GetData();

        if Data2 and Data2.PermanentGears["Rainbow Shovel"] then
            RainbowShovel.Buy.Text = "OWNED";
            RainbowShovel.Buy.Active = false;
        end;
    end;

    local Data2 = DataService:GetData();

    if Data2 and Data2.PermanentGears["Rainbow Shovel"] then
        RainbowShovel.Buy.Text = "OWNED";
        RainbowShovel.Buy.Active = false;
    end;

    DataService:GetPathSignal("PermanentGears/@"):Connect(function() -- Line: 758
        -- upvalues: DataService (ref), RainbowShovel (copy)
        local Data3 = DataService:GetData();

        if Data3 and Data3.PermanentGears["Rainbow Shovel"] then
            RainbowShovel.Buy.Text = "OWNED";
            RainbowShovel.Buy.Active = false;
        end;
    end);
    RainbowShovel.Buy.Activated:Connect(function() -- Line: 762
        -- upvalues: DataService (ref), Notification (ref), MarketController (ref), DevProductIds (ref)
        local Data3 = DataService:GetData();

        if Data3 and Data3.PermanentGears["Rainbow Shovel"] then
            Notification:CreateNotification("You already own the Rainbow Shovel Pack!");

            return;
        end;

        MarketController:PromptPurchase(DevProductIds.RainbowShovelPack.PurchaseID, Enum.InfoType.Product);
    end);

    if not Data.PermanentGears["Rainbow Shovel"] and UseDynamicPrices then
        MarketController:SetPriceLabel(RainbowShovel.Buy, DevProductIds.RainbowShovelPack.PurchaseID);
    end;

    task.spawn(function() -- Line: 777
        -- upvalues: UpdateService (ref), RainbowShovel (copy), NumberUtil (ref)
        while true do
            local RemainingTimeUntilUpdate = UpdateService:GetRemainingTimeUntilUpdate();

            if RemainingTimeUntilUpdate <= 0 then
                break;
            end;

            RainbowShovel.bg.Timer.Text = NumberUtil.formatShopTime(RemainingTimeUntilUpdate);
            task.wait(1);
        end;

        RainbowShovel.Visible = false;
    end);
end;

local ReplicatedGlobalStock = ReplicatedStorage.Data.ReplicatedGlobalStock;
local ExoticPack = Shop_UI.Frame.ScrollingFrame.ExoticPack;
ExoticPack.Visible = false;
local u67 = {};

function u1._createExoticPack(p68: table, u69: any, p70: number, p71: string?) -- Line: 801
    -- upvalues: u67 (copy), Trove (copy), Shop_UI (copy), ExoticPack (copy), PityData (copy), Notification (copy), SeedPackOddsController (copy), PetEggOddsController (copy), PityHoverController (copy), ItemImageFinder (copy), SeedData (copy), GuiController (copy), RunService (copy), MarketController (copy), DataService (copy), PlayerGui (copy), UseDynamicPrices (copy), Comma_Module (copy), GiftController (copy), NumberUtil (copy), ReplicatedGlobalStock (copy)
    local u72 = u67[p70];

    if u72 then
        u72:Clean();
    else
        u72 = Trove.new();
        u67[p70] = u72;
    end;

    local u73 = Shop_UI.Frame.ScrollingFrame:FindFirstChild((`ExoticPack{p70}`));

    if not u73 then
        u73 = u72:Clone(ExoticPack);
        u73.Name = `ExoticPack{p70}`;
        u73.LayoutOrder = p70;
        u73.Parent = Shop_UI.Frame.ScrollingFrame;
    end;

    u73.Visible = true;
    u72:Add(function() -- Line: 821
        -- upvalues: u73 (ref)
        u73.Visible = false;
    end);
    u72:Add(u73.Destroying:Once(function() -- Line: 825
        -- upvalues: u72 (ref)
        u72:Destroy();
    end));
    local v74;

    if u69.Pity then
        v74 = PityData[u69.Pity];
    else
        v74 = nil;
    end;

    local LimitedStock = u69.LimitedStock;
    local u75 = nil;

    local function isSoldOut() -- Line: 838
        -- upvalues: LimitedStock (copy), u75 (ref)
        local v76;

        if LimitedStock == nil or u75 == nil then
            v76 = false;
        else
            v76 = u75 <= 0;
        end;

        return v76;
    end;

    local function rejectIfSoldOut() -- Line: 845
        -- upvalues: LimitedStock (copy), u75 (ref), Notification (ref)
        local v77;

        if LimitedStock == nil or u75 == nil then
            v77 = false;
        else
            v77 = u75 <= 0;
        end;

        if not v77 then
            return false;
        end;

        Notification:CreateNotification("This pack is sold out!");

        return true;
    end;

    local v78 = {};
    local v79 = {};
    local v80 = {};

    for i, v in u69.Items do
        local v81;

        if u69.BiggerTemplateIndex <= i then
            v81 = u73.List.UIListLayout.TemplateBigger;
        elseif u69.MidTemplateIndex <= i or #u69.Items <= 5 then
            v81 = u73.List.UIListLayout.TemplateMid;
        else
            v81 = u73.List.UIListLayout.TemplateSmaller;
        end;

        local u82 = u72:Clone(v81);

        if v81 == u73.List.UIListLayout.TemplateSmaller then
            table.insert(v79, u82);
        elseif v81 == u73.List.UIListLayout.TemplateMid then
            table.insert(v80, u82);
        elseif v81 == u73.List.UIListLayout.TemplateBigger then
            table.insert(v78, u82);
        end;

        u82.Odds.Text = `{math.floor(v.Chance * 100) / 100}%`;

        if v.Type == "Pack" then
            u82.OddsButton.Visible = true;
            u72:Add(u82.OddsButton.Activated:Connect(function() -- Line: 877
                -- upvalues: SeedPackOddsController (ref), v (copy), Shop_UI (ref), u69 (copy)
                SeedPackOddsController:Open(v.RewardId, Shop_UI, u69.Pity, v.Chance);
            end));
        elseif v.Type == "Egg" then
            u82.OddsButton.Visible = true;
            u72:Add(u82.OddsButton.Activated:Connect(function() -- Line: 882
                -- upvalues: PetEggOddsController (ref), v (copy), Shop_UI (ref), u69 (copy)
                PetEggOddsController:Open(v.RewardId, Shop_UI, u69.Pity, nil, v.Chance);
            end));
        else
            u82.OddsButton.Visible = false;
        end;

        local v83, v84;

        if v74 then
            v83 = i;
            v84 = v;
            local v85 = 0;

            for _, v2 in v74.Items do
                if v2.RewardId == v84.RewardId and v2.Type == v84.Type then
                    v85 = v2.Pity;
                    break;
                end;
            end;

            if v85 > 0 then
                local Pity = u82.Pity;
                Pity.Text = `{v85}*`;
                Pity.Visible = true;
                PityHoverController:AddGuiObject(u82, v85, v74.DisplayPlural);
                u72:Add(function() -- Line: 904
                    -- upvalues: PityHoverController (ref), u82 (copy)
                    PityHoverController:RemoveGuiObject(u82);
                end);
            end;
        else
            v83 = i;
            v84 = v;
        end;

        local v86 = u82:FindFirstChild("VectorHolder") and u82.VectorHolder:FindFirstChild("Vector") or u82:FindFirstChild("Vector");

        if v84.Icon then
            v86.Image = v84.Icon;

            if string.find(v84.RewardId, "GIANT") then
                v86.Size = UDim2.fromScale(1.5, 1.5);
            end;

            v86.Visible = true;
        else
            local v87;

            if v84.Type == "Pet" then
                v87 = ItemImageFinder(v84.RewardId, "Pet");
            else
                v87 = SeedData[v84.RewardId] and SeedData[v84.RewardId].Asset;
            end;

            if v87 then
                v86.Visible = true;
                v86.Image = v87;
            end;
        end;

        if u69.Title == "EXOTIC KITSUNE CHEST!" then
            u82.Size = UDim2.fromScale(u82.Size.X.Scale * 0.95, u82.Size.Y.Scale * 0.95);
        end;

        if v84.RewardId == "Sunflower" or v84.RewardId == "Shedletsky Gnome" then
            u82.Odds.TextColor3 = Color3.fromRGB(255, 204, 1);
        elseif u69.BiggerTemplateIndex <= v83 then
            local StateForGui = GuiController:GetStateForGui(Shop_UI);
            local u88 = nil;
            u72:Add(StateForGui.Visible:Observe(function(p89: boolean) -- Line: 942
                -- upvalues: u88 (ref), RunService (ref), u82 (copy)
                if p89 then
                    if not u88 then
                        u88 = RunService.PostSimulation:Connect(function() -- Line: 946
                            -- upvalues: u82 (ref)
                            u82.Odds.TextColor3 = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                        end);
                    end;
                elseif u88 then
                    u88:Disconnect();
                    u88 = nil;
                end;
            end));
            u72:Add(function() -- Line: 958
                -- upvalues: u88 (ref)
                if u88 then
                    u88:Disconnect();
                    u88 = nil;
                end;
            end);
        end;

        u82.Parent = u73.List;
    end;

    if u69.Title == "EXOTIC SANTA\'S SURPRISE PRESENT!" then
        local v90 = u72:Add(Instance.new("Frame"));
        v90.Name = "Sub";
        v90.BackgroundTransparency = 1;
        v90.Size = UDim2.fromScale(1.3, 1.3);
        local v91 = u72:Add(Instance.new("UIGridLayout"));
        v91.Name = "UIGridLayout";
        v91.CellPadding = UDim2.fromOffset(2, 2);
        v91.CellSize = UDim2.fromScale(0.45, 0.45);
        v91.HorizontalAlignment = Enum.HorizontalAlignment.Right;
        v91.SortOrder = Enum.SortOrder.LayoutOrder;
        u72:Add(Instance.new("UIAspectRatioConstraint")).Parent = v91;
        v91.Parent = v90;
        local v92 = u72:Add(Instance.new("UIAspectRatioConstraint"));
        v92.Name = "UIAspectRatioConstraint";
        v92.AspectRatio = 1.54;
        v92.Parent = v90;

        for _, v in v79 do
            v.Parent = v90;
        end;

        v90.Parent = u73.List;

        for _, v in v80 do
            v.Size = UDim2.fromScale(1.2, 1.2);
        end;

        for _, v in v78 do
            v.Size = UDim2.fromScale(1.3, 1.3);
        end;

        local Size = u73.List.Size;
        local Position = u73.List.Position;
        local Padding = u73.List.UIListLayout.Padding;
        u73.List.Size = UDim2.fromScale(0.732, 0.3);
        u73.List.Position = UDim2.fromScale(0.61, 0.4);
        u73.List.UIListLayout.Padding = UDim.new(0.012, 0);
        u72:Add(function() -- Line: 1012
            -- upvalues: u73 (ref), Shop_UI (ref), Size (copy), Position (copy), Padding (copy)
            if u73:IsDescendantOf(Shop_UI) then
                u73.List.Size = Size;
                u73.List.Position = Position;
                u73.List.UIListLayout.Padding = Padding;
            end;
        end);
    end;

    MarketController:RemovePriceLabel(u73.Buttons.Buy1);
    local u93 = nil;
    local u94 = nil;
    local u95 = u72:Extend();
    local u96 = {
        ["PREMIUM GOLDEN EGG!"] = true,
        ["PREMIUM SPRINGTIDE EGG!"] = true,
        ["PREMIUM HIVE EGG!"] = true,
        ["EXOTIC HIVE SEED PACK!"] = true,
        ["PREMIUM CAMPFIRE EGG!"] = true,
        ["EXOTIC CAMPFIRE SEED PACK!"] = true,
        ["PREMIUM COASTAL EGG!"] = true,
        ["EXOTIC COASTAL SEED PACK!"] = true,
        ["PREMIUM MOON EGG!"] = true,
        ["EXOTIC MOON CHEST!"] = true,
        ["PREMIUM BEANPOD EGG!"] = true,
        ["EXOTIC BEANPOD CHEST!"] = true,
        ["EXOTIC AUTUMN SEED PACK!"] = true,
        ["PREMIUM AUTUMN EGG!"] = true,
        ["EXOTIC FAIRY CHEST!"] = true,
        ["PREMIUM HAUNTED EGG!"] = true
    };

    local function updateButtonsVisibility() -- Line: 1047
        -- upvalues: u95 (copy), DataService (ref), u96 (copy), u69 (copy), u93 (ref), u94 (ref), u73 (ref), PlayerGui (ref)
        u95:Clean();
        local Data = DataService:GetData();
        local v97 = false;

        if u96[u69.Title] then
            for _, v in Data.Transactions do
                if v.ProductId == u69.Products[10] then
                    v97 = true;
                    break;
                end;
            end;
        end;

        if u93 then
            u93.Visible = v97;
        end;

        if u94 then
            u94.Visible = v97;
        end;

        if v97 then
            local Position = u73.Buttons.Position;
            u73.Buttons.Position = UDim2.fromScale(0.4, 0.79);
            u95:Add(function() -- Line: 1073
                -- upvalues: u73 (ref), PlayerGui (ref), Position (copy)
                if u73:FindFirstChild("Buttons") and u73:IsDescendantOf(PlayerGui) then
                    u73.Buttons.Position = Position;
                end;
            end);

            for i in u69.Products do
                local u98 = u73.Buttons:FindFirstChild((`Buy{i}`));

                if u98 then
                    local Size = u98.Size;
                    u98.Size = UDim2.fromScale(0.22, 0.9);
                    u95:Add(function() -- Line: 1084
                        -- upvalues: u98 (copy), Size (copy)
                        u98.Size = Size;
                    end);
                end;
            end;
        end;
    end;

    if u69.Products[50] then
        local v99 = u72:Clone(u73.Buttons.Buy10);
        v99.Name = "Buy50";
        v99.LayoutOrder = u73.Buttons.Gift10.LayoutOrder + 1;
        v99.Parent = u73.Buttons;
        u93 = v99;
        local v100 = u72:Clone(u73.Buttons.Gift10);
        v100.Name = "Gift50";
        v100.LayoutOrder = v99.LayoutOrder + 1;
        v100.Parent = u73.Buttons;
        u94 = v100;
    end;

    u72:Add(task.spawn(function() -- Line: 1110
        -- upvalues: u72 (ref), DataService (ref), updateButtonsVisibility (copy)
        u72:Add(DataService:GetPathSignal("TotalRobuxSpent"):Connect(function() -- Line: 1111
            -- upvalues: updateButtonsVisibility (ref)
            updateButtonsVisibility();
        end));
        u72:Add(DataService:GetPathSignal("Transactions/@"):Connect(function() -- Line: 1115
            -- upvalues: updateButtonsVisibility (ref)
            updateButtonsVisibility();
        end));
    end));
    u72:Add(task.spawn(updateButtonsVisibility));

    for i, v in u69.Products do
        local v101 = u73.Buttons:FindFirstChild((`Buy{i}`));

        if v101 then
            if UseDynamicPrices or u69.FallbackPrices[i] == nil then
                if not UseDynamicPrices then
                    warn((`{v101:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                end;

                MarketController:SetPriceLabel(v101, v);
            else
                local v102 = u69.FallbackPrices[i];
                v101.Text = `<font size="19"><font weight="400">{utf8.char(57346)}</font>{Comma_Module.Comma(v102)}</font>`;
            end;

            local v103;

            if i == 1 then
                v103 = u69.Display;
            else
                v103 = u69.DisplayPlural;
            end;

            v101.Amount.Text = `{i} {v103}`;
            u72:Add(v101.Activated:Connect(function() -- Line: 1140
                -- upvalues: LimitedStock (copy), u75 (ref), Notification (ref), MarketController (ref), v (copy)
                local v104;

                if LimitedStock == nil or u75 == nil then
                    v104 = false;
                else
                    v104 = u75 <= 0;
                end;

                local v105;

                if v104 then
                    Notification:CreateNotification("This pack is sold out!");
                    v105 = true;
                else
                    v105 = false;
                end;

                if v105 then
                    return;
                end;

                MarketController:PromptPurchase(v, Enum.InfoType.Product);
            end));
        end;
    end;

    u72:Add(task.spawn(function() -- Line: 1147
        -- upvalues: u73 (ref), u93 (ref), UseDynamicPrices (ref), u69 (copy), MarketController (ref), Comma_Module (ref)
        u73.Buttons.Buy10.TextLabel.Visible = false;

        if u93 then
            u93.TextLabel.Visible = false;
        end;

        if UseDynamicPrices or u69.FallbackPrices[1] == nil then
            if not UseDynamicPrices then
                warn((`{u73.Buttons.Buy10:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
            end;

            local ProductInfo, v106 = MarketController:GetProductInfo(u69.Products[1], Enum.InfoType.Product);

            if not ProductInfo then
                return;
            end;

            u73.Buttons.Buy10.TextLabel.Text = Comma_Module.Comma(v106.PriceInRobux * 10);

            if u93 then
                u93.TextLabel.Text = Comma_Module.Comma(v106.PriceInRobux * 50);
            end;
        else
            u73.Buttons.Buy10.TextLabel.Text = Comma_Module.Comma(u69.FallbackPrices[1] * 10);

            if u93 then
                u93.TextLabel.Text = Comma_Module.Comma(u69.FallbackPrices[1] * 50);
            end;
        end;

        u73.Buttons.Buy10.TextLabel.Visible = true;

        if u93 then
            u93.TextLabel.Visible = true;
        end;
    end));
    u72:Add(u73.Buttons.Gift1.Activated:Connect(function() -- Line: 1180
        -- upvalues: LimitedStock (copy), u75 (ref), Notification (ref), GiftController (ref), u69 (copy)
        local v107;

        if LimitedStock == nil or u75 == nil then
            v107 = false;
        else
            v107 = u75 <= 0;
        end;

        local v108;

        if v107 then
            Notification:CreateNotification("This pack is sold out!");
            v108 = true;
        else
            v108 = false;
        end;

        if v108 then
            return;
        end;

        GiftController:PromptGiftFromGiftId(u69.GiftProducts[1]);
    end));
    u72:Add(u73.Buttons.Gift3.Activated:Connect(function() -- Line: 1186
        -- upvalues: LimitedStock (copy), u75 (ref), Notification (ref), GiftController (ref), u69 (copy)
        local v109;

        if LimitedStock == nil or u75 == nil then
            v109 = false;
        else
            v109 = u75 <= 0;
        end;

        local v110;

        if v109 then
            Notification:CreateNotification("This pack is sold out!");
            v110 = true;
        else
            v110 = false;
        end;

        if v110 then
            return;
        end;

        GiftController:PromptGiftFromGiftId(u69.GiftProducts[3]);
    end));
    u72:Add(u73.Buttons.Gift10.Activated:Connect(function() -- Line: 1192
        -- upvalues: LimitedStock (copy), u75 (ref), Notification (ref), GiftController (ref), u69 (copy)
        local v111;

        if LimitedStock == nil or u75 == nil then
            v111 = false;
        else
            v111 = u75 <= 0;
        end;

        local v112;

        if v111 then
            Notification:CreateNotification("This pack is sold out!");
            v112 = true;
        else
            v112 = false;
        end;

        if v112 then
            return;
        end;

        GiftController:PromptGiftFromGiftId(u69.GiftProducts[10]);
    end));

    if u94 and u69.GiftProducts[50] ~= nil then
        u72:Add(u94.Activated:Connect(function() -- Line: 1199
            -- upvalues: LimitedStock (copy), u75 (ref), Notification (ref), GiftController (ref), u69 (copy)
            local v113;

            if LimitedStock == nil or u75 == nil then
                v113 = false;
            else
                v113 = u75 <= 0;
            end;

            local v114;

            if v113 then
                Notification:CreateNotification("This pack is sold out!");
                v114 = true;
            else
                v114 = false;
            end;

            if v114 then
                return;
            end;

            GiftController:PromptGiftFromGiftId(u69.GiftProducts[50]);
        end));
    end;

    u72:Add(task.spawn(function() -- Line: 1207
        -- upvalues: u69 (copy), u73 (ref), NumberUtil (ref)
        while true do
            local v115 = u69.EndTime - workspace:GetServerTimeNow();
            u73.Timer.Text = NumberUtil.formatShopTime(v115);

            if v115 <= 0 then
                u73.Visible = false;
            end;

            task.wait(1);
        end;
    end));
    u73.Title.Text = u69.Title;
    u73.Title.TitleShadow.Text = u69.Title;

    if LimitedStock then
        local Id = LimitedStock.Id;
        local Max = LimitedStock.Max;
        u73.Title.Size = UDim2.new(0.5, 0, 0.12, 0);
        u73.Title.Position = UDim2.new(0.45, 0, 0.1, 0);
        local u116 = u72:Clone(u73.Title);
        u116.Name = "RemainingStock";
        u116.Size = UDim2.new(0.45, 0, 0.175, 0);
        u116.Position = UDim2.new(0.45, 0, 0.175, 0);
        u116.TitleShadow.TextColor3 = Color3.fromRGB(254, 222, 10);
        u116.Parent = u73;

        local function updateStockLabel() -- Line: 1242
            -- upvalues: u75 (ref), Comma_Module (ref), Max (copy), u116 (copy)
            local v117;

            if u75 then
                local math_floor_ret = math.floor(u75);
                local math_max_ret = math.max(0, math_floor_ret);
                v117 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
            else
                v117 = "SYNCING...";
            end;

            u116.Text = v117;
            u116.TitleShadow.Text = v117;
        end;

        local function bindStockValue(u118: userdata) -- Line: 1257
            -- upvalues: u75 (ref), Comma_Module (ref), Max (copy), u116 (copy), u72 (ref)
            u75 = u118.Value;
            local v119;

            if u75 then
                local math_floor_ret = math.floor(u75);
                local math_max_ret = math.max(0, math_floor_ret);
                v119 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
            else
                v119 = "SYNCING...";
            end;

            u116.Text = v119;
            u116.TitleShadow.Text = v119;
            u72:Add(u118:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1261
                -- upvalues: u75 (ref), u118 (copy), Comma_Module (ref), Max (ref), u116 (ref)
                u75 = u118.Value;
                local v120;

                if u75 then
                    local math_floor_ret = math.floor(u75);
                    local math_max_ret = math.max(0, math_floor_ret);
                    v120 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
                else
                    v120 = "SYNCING...";
                end;

                u116.Text = v120;
                u116.TitleShadow.Text = v120;
            end));
        end;

        local v121;

        if u75 then
            local math_floor_ret = math.floor(u75);
            local math_max_ret = math.max(0, math_floor_ret);
            v121 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
        else
            v121 = "SYNCING...";
        end;

        u116.Text = v121;
        u116.TitleShadow.Text = v121;
        local u122 = ReplicatedGlobalStock:FindFirstChild(Id);

        if u122 and u122:IsA("NumberValue") then
            u75 = u122.Value;
            local v123;

            if u75 then
                local math_floor_ret = math.floor(u75);
                local math_max_ret = math.max(0, math_floor_ret);
                v123 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
            else
                v123 = "SYNCING...";
            end;

            u116.Text = v123;
            u116.TitleShadow.Text = v123;
            u72:Add(u122:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1261
                -- upvalues: u75 (ref), u122 (copy), Comma_Module (ref), Max (copy), u116 (copy)
                u75 = u122.Value;
                local v124;

                if u75 then
                    local math_floor_ret = math.floor(u75);
                    local math_max_ret = math.max(0, math_floor_ret);
                    v124 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
                else
                    v124 = "SYNCING...";
                end;

                u116.Text = v124;
                u116.TitleShadow.Text = v124;
            end));
        else
            u72:Add(ReplicatedGlobalStock.ChildAdded:Connect(function(u125) -- Line: 1278
                -- upvalues: Id (copy), u75 (ref), Comma_Module (ref), Max (copy), u116 (copy), u72 (ref)
                if u125.Name == Id and u125:IsA("NumberValue") then
                    u75 = u125.Value;
                    local v126;

                    if u75 then
                        local math_floor_ret = math.floor(u75);
                        local math_max_ret = math.max(0, math_floor_ret);
                        v126 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
                    else
                        v126 = "SYNCING...";
                    end;

                    u116.Text = v126;
                    u116.TitleShadow.Text = v126;
                    u72:Add(u125:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1261
                        -- upvalues: u75 (ref), u125 (copy), Comma_Module (ref), Max (ref), u116 (ref)
                        u75 = u125.Value;
                        local v127;

                        if u75 then
                            local math_floor_ret = math.floor(u75);
                            local math_max_ret = math.max(0, math_floor_ret);
                            v127 = `{Comma_Module.Comma(math_max_ret)}/{Comma_Module.Comma(Max)} LEFT`;
                        else
                            v127 = "SYNCING...";
                        end;

                        u116.Text = v127;
                        u116.TitleShadow.Text = v127;
                    end));
                end;
            end));
        end;
    else
        u73.Title.Size = ExoticPack.Title.Size;
        u73.Title.Position = ExoticPack.Title.Position;
    end;

    u73.Image = p71 or (u69.BackgroundImage or "rbxassetid://138776814412466");
    u73.Vector.Image = u69.Vector;
    u73.Vector.Position = u69.VectorPosition;
    u73.Vector.Size = u69.VectorSize;

    return u73;
end;

function u1._destroyExoticPack(p128: table, p129: number) -- Line: 1298
    -- upvalues: u67 (copy)
    local v130 = u67[p129];

    if v130 then
        v130:Destroy();
        u67[p129] = nil;
    end;
end;

local u134 = {
    Crate = function(p131: string) -- Line: 1307
        -- upvalues: CosmeticCrateOddsController (copy), Shop_UI (copy)
        CosmeticCrateOddsController:Open(p131, Shop_UI);
    end,

    ["Seed Pack"] = function(p132: string) -- Line: 1310
        -- upvalues: SeedPackOddsController (copy), Shop_UI (copy)
        SeedPackOddsController:Open(p132, Shop_UI);
    end,

    Egg = function(p133: string) -- Line: 1313
        -- upvalues: PetEggOddsController (copy), Shop_UI (copy)
        PetEggOddsController:Open(p133, Shop_UI);
    end
};

local function RoundedOddsDisclaimer(p135: table) -- Line: 1326
    -- upvalues: GenericRewardsUIController (copy)
    local v136 = 0;

    for _, v in p135 do
        v136 = v136 + (v.Weight or 0);
    end;

    if v136 <= 0 then
        return nil;
    end;

    local v137 = 0;

    for _, v in p135 do
        v137 = v137 + GenericRewardsUIController.RoundOddsPercent((v.Weight or 0) / v136 * 100);
    end;

    return math.abs(v137 - 100) >= 1e-9 and "PRESETS/RoundedOddsCompliance" or nil;
end;

local function OpenInfinitePackOdds() -- Line: 1356
    -- upvalues: InfinitePackData (copy), LocalPlayer (copy), GenericRewardsUIController (copy), Shop_UI (copy), RoundedOddsDisclaimer (copy)
    local DropWeightsAsync = InfinitePackData.GetDropWeightsAsync(LocalPlayer);

    if #DropWeightsAsync == 0 then
        return;
    end;

    local v138 = {};

    for _, v in DropWeightsAsync do
        table.insert(v138, {
            Reward = {
                Type = v.Entry.Type,
                Value = v.Entry.RewardName,
                Quantity = v.Entry.Amount
            },
            Weight = v.Weight
        });
    end;

    GenericRewardsUIController:Open({
        Title = "Forever Pack",
        DisplayOdds = true,
        RewardData = v138,
        Breadcrumb = Shop_UI,
        Disclaimer = RoundedOddsDisclaimer(v138)
    });
end;

local function InitialiseInfinitePack(u139: string) -- Line: 1383
    -- upvalues: Shop_UI (copy), PolicyService (copy), LocalPlayer (copy), OpenInfinitePackOdds (copy), DataService (copy), EventInfinitePackData (copy), Players (copy), InfinitePackData (copy), FastTween (copy), ReplicatedStorage (copy), ItemImageFinder (copy), ItemNameFinder (copy), GiveServiceCommon (copy), u134 (copy), UseDynamicPrices (copy), MarketController (copy), Comma_Module (copy), NumberUtil (copy), ImageCycle (copy)
    local Infinite = Shop_UI.Frame.ScrollingFrame.Infinite;

    if u139 ~= "DEFAULT" then
        Infinite = Shop_UI.Frame.ScrollingFrame[`Infinite_{u139}`];

        if not Infinite then
            warn("Current Infinite Pack type UI does not exist!");

            return;
        end;
    end;

    Infinite.Visible = true;
    local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

    if PolicyInfoForPlayerAsync and PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted then
        Infinite.Visible = false;

        return;
    end;

    local Holder = Infinite.INF.Holder;
    local Template = Holder.Template;
    local OddsButton = Infinite.Header:FindFirstChild("OddsButton");

    if OddsButton and (OddsButton:IsA("GuiButton") and u139 == "DEFAULT") then
        OddsButton.Activated:Connect(function() -- Line: 1418
            -- upvalues: OpenInfinitePackOdds (ref)
            task.spawn(OpenInfinitePackOdds);
        end);
    end;

    local u140 = nil;
    local NumberValue = Instance.new("NumberValue");
    local u141 = nil;
    local u142 = 0;
    local u143 = nil;
    local Scale = Template.Size.X.Scale;
    local Scale2 = Template.Size.Y.Scale;

    local function canvasRatio() -- Line: 1455
        -- upvalues: u143 (ref), u142 (ref)
        return math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
    end;

    local function updatePosition(p144: userdata, p145: number) -- Line: 1462
        -- upvalues: u143 (ref), u142 (ref), Scale (copy), Scale2 (copy), NumberValue (copy)
        local math_max_ret = math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
        p144.Size = UDim2.fromScale(Scale / math_max_ret, Scale2);
        p144.Position = UDim2.fromScale(0.38 * (p145 - 1 - NumberValue.Value) / math_max_ret, 0);
    end;

    local function updateCanvas() -- Line: 1472
        -- upvalues: u143 (ref), u142 (ref), Holder (copy)
        local math_max_ret = math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
        local v146 = math_max_ret > 1;
        Holder.CanvasSize = UDim2.fromScale(math_max_ret, 0);
        Holder.ScrollingEnabled = v146;
        Holder.Active = v146;
    end;

    local function relayout() -- Line: 1482
        -- upvalues: Holder (copy), u143 (ref), u142 (ref), Scale (copy), Scale2 (copy), NumberValue (copy)
        for _, child in Holder:GetChildren() do
            local v147 = tonumber(child.Name);

            if v147 then
                local math_max_ret = math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
                child.Size = UDim2.fromScale(Scale / math_max_ret, Scale2);
                child.Position = UDim2.fromScale(0.38 * (v147 - 1 - NumberValue.Value) / math_max_ret, 0);
            end;
        end;
    end;

    local function generate() -- Line: 1491
        -- upvalues: DataService (ref), u139 (copy), EventInfinitePackData (ref), Players (ref), InfinitePackData (ref), u143 (ref), u142 (ref), Holder (copy), relayout (copy), u141 (ref), FastTween (ref), NumberValue (copy), Template (copy), Scale (copy), Scale2 (copy), ReplicatedStorage (ref), ItemImageFinder (ref), ItemNameFinder (ref), GiveServiceCommon (ref), u134 (ref), UseDynamicPrices (ref), MarketController (ref), Comma_Module (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local Depth = Data.InfinitePack.Depth;

        if u139 ~= "DEFAULT" then
            Depth = Data.EventInfinitePack[u139].Depth;

            if not Depth then
                warn("Current Infinite Pack type Data does not exist!");

                return;
            end;
        end;

        local function fetchRewards(p148: number) -- Line: 1503
            -- upvalues: u139 (ref), EventInfinitePackData (ref), Players (ref), Data (ref), InfinitePackData (ref)
            if u139 == "DEFAULT" then
                return InfinitePackData.GetRewardsAsync(Players.LocalPlayer, Data.InfinitePack.Day, p148);
            end;

            return EventInfinitePackData.GetRewards(Players.LocalPlayer, Data.EventInfinitePack[u139].Day, p148);
        end;

        local function findNextPaid(p149: table) -- Line: 1529
            -- upvalues: Depth (ref)
            for i = Depth + 2, #p149 do
                local v150 = p149[i];

                if v150 and (v150.ProductId or 0) ~= 0 then
                    return i;
                end;

                local _ = i;
            end;

            return nil;
        end;

        local v151 = Depth + 5;
        local v152;

        if u139 == "DEFAULT" then
            v152 = InfinitePackData.GetRewardsAsync(Players.LocalPlayer, Data.InfinitePack.Day, v151);
        else
            v152 = EventInfinitePackData.GetRewards(Players.LocalPlayer, Data.EventInfinitePack[u139].Day, v151);
        end;

        local v153 = nil;

        for i = Depth + 2, #v152 do
            local v154 = v152[i];

            if v154 and (v154.ProductId or 0) ~= 0 then
                v153 = i;
                break;
            end;

            local _ = i;
        end;

        u143 = v153;
        local v155 = Depth + 5;

        while true do
            if u143 or v155 >= Depth + 30 then
                local math_max_ret = math.max(Depth + 5, u143 or 0);
                local math_min_ret = math.min(math_max_ret, #v152);
                u142 = Depth;
                local math_max_ret2 = math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
                local v156 = math_max_ret2 > 1;
                Holder.CanvasSize = UDim2.fromScale(math_max_ret2, 0);
                Holder.ScrollingEnabled = v156;
                Holder.Active = v156;
                relayout();

                if Depth ~= u141 then
                    Holder.CanvasPosition = Vector2.zero;
                end;

                u141 = Depth;
                FastTween(NumberValue, TweenInfo.new(0.2), {
                    Value = Depth
                });

                for _, child in Holder:GetChildren() do
                    local v157 = tonumber(child.Name);

                    if v157 and v157 <= Depth then
                        task.delay(0.2, function() -- Line: 1579
                            -- upvalues: child (copy)
                            child:Destroy();
                        end);
                    end;
                end;

                for i = Depth + 1, math_min_ret do
                    local v158 = v152[i];
                    local u159 = Holder:FindFirstChild((tostring(i)));

                    if not u159 then
                        u159 = Template:Clone();
                        u159.Name = tostring(i);
                        u159.LayoutOrder = i;
                        u159.ZIndex = #v152 - i;
                        local math_max_ret3 = math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
                        u159.Size = UDim2.fromScale(Scale / math_max_ret3, Scale2);
                        u159.Position = UDim2.fromScale(0.38 * (i - 1 - NumberValue.Value) / math_max_ret3, 0);
                        u159.Visible = true;
                        local u160 = v158.ProductId or 0;

                        if u160 ~= 0 then
                            u159.CLAIM_BUTTON:Destroy();
                            u159.RBX_BUTTON.Name = "CLAIM_BUTTON";
                        end;

                        u159.CLAIM_BUTTON.SENSOR.Activated:Connect(function() -- Line: 1602
                            -- upvalues: Data (ref), DataService (ref), u139 (ref), i (copy), ReplicatedStorage (ref)
                            Data = DataService:GetData();

                            if u139 == "DEFAULT" then
                                if Data.InfinitePack.Depth + 1 ~= i then
                                    return;
                                end;

                                ReplicatedStorage.GameEvents.InfinitePack.Claim:FireServer();

                                return;
                            end;

                            if Data.EventInfinitePack[u139].Depth + 1 ~= i then
                                return;
                            end;

                            ReplicatedStorage.GameEvents.InfinitePack.EventClaim:FireServer();
                        end);

                        if v158 then
                            local v161 = v158.Rewards[1];
                            u159.IMAGE_CONTAINER.ITEM_IMAGE.Image = ItemImageFinder(v161.RewardName, v161.Type);
                            local v162 = `{ItemNameFinder(v161.RewardName, v161.Type) or v161.RewardName}{v161.Amount <= 1 and "" or ` x{v161.Amount}`}`;
                            u159.IMAGE_CONTAINER.RewardName.Text = v162;
                            local Type = v161.Type;
                            local u163 = v161.RewardName or "Normal";
                            local RarityColor = GiveServiceCommon:GetRarityColor({
                                Type = Type,
                                Value = u163,
                                Quantity = v161.Amount or 1
                            });
                            local v164 = RarityColor or Color3.fromRGB(127, 127, 127);
                            local IMAGE_CONTAINER = u159.IMAGE_CONTAINER;
                            local v165, v166, v167 = RarityColor:ToHSV();
                            IMAGE_CONTAINER.BackgroundColor3 = Color3.fromHSV(v165, v166, (math.clamp(v167 / 1.3, 0, 1)));
                            local RewardName = u159.IMAGE_CONTAINER.RewardName;
                            local v168, v169, v170 = v164:ToHSV();
                            RewardName.TextStrokeColor3 = Color3.fromHSV(v168, v169, (math.clamp(v170 / 3, 0, 1)));

                            if u134[Type] then
                                local u171 = u159.OddsButton.Activated:Connect(function() -- Line: 1647
                                    -- upvalues: u134 (ref), Type (copy), u163 (copy)
                                    if u134[Type] then
                                        u134[Type](u163);
                                    end;
                                end);
                                u159.Destroying:Once(function() -- Line: 1652
                                    -- upvalues: u171 (ref)
                                    if u171 then
                                        u171:Disconnect();
                                        u171 = nil;
                                    end;
                                end);
                                u159.OddsButton.Visible = true;
                            else
                                u159.OddsButton.Visible = false;
                            end;
                        end;

                        u159.Parent = Holder;
                        local task_spawn_ret = task.spawn(function() -- Line: 1666
                            -- upvalues: u139 (ref), EventInfinitePackData (ref), u160 (copy), InfinitePackData (ref), u159 (copy), UseDynamicPrices (ref), MarketController (ref), Comma_Module (ref)
                            local v172 = u139 ~= "DEFAULT" and EventInfinitePackData.FallbackPrices[u160] or InfinitePackData.FallbackPrices[u160];

                            if u160 == 0 then
                                u159.CLAIM_BUTTON.CLAIM.Text = "FREE";
                                u159.CLAIM_BUTTON.CLAIM_BUTTON.Text = "FREE";
                                u159.CLAIM_BUTTON_DISABLED.CLAIM.Text = "FREE";
                                u159.CLAIM_BUTTON_DISABLED.CLAIM_BUTTON.Text = "FREE";

                                return;
                            end;

                            if UseDynamicPrices or v172 == nil then
                                if not UseDynamicPrices then
                                    warn((`{u159:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                end;

                                MarketController:SetPriceLabel(u159.CLAIM_BUTTON.CLAIM, u160);
                                MarketController:SetPriceLabel(u159.CLAIM_BUTTON.CLAIM_BUTTON, u160);
                                MarketController:SetPriceLabel(u159.CLAIM_BUTTON_DISABLED.CLAIM, u160);
                                MarketController:SetPriceLabel(u159.CLAIM_BUTTON_DISABLED.CLAIM_BUTTON, u160);

                                return;
                            end;

                            local v173 = `{utf8.char(57346)}{Comma_Module.Comma(v172)}`;
                            u159.CLAIM_BUTTON.CLAIM.Text = v173;
                            u159.CLAIM_BUTTON.CLAIM_BUTTON.Text = v173;
                            u159.CLAIM_BUTTON_DISABLED.CLAIM.Text = v173;
                            u159.CLAIM_BUTTON_DISABLED.CLAIM_BUTTON.Text = v173;
                        end);
                        u159.Destroying:Once(function() -- Line: 1699
                            -- upvalues: task_spawn_ret (copy)
                            if coroutine.status(task_spawn_ret) == "suspended" then
                                pcall(task.cancel, task_spawn_ret);
                            end;
                        end);
                    end;

                    u159.ZIndex = #v152 - i;
                    local v174;

                    if i == (u139 ~= "DEFAULT" and Data.EventInfinitePack[u139].Depth or Data.InfinitePack.Depth) + 1 then
                        u159.CLAIM_BUTTON.Visible = true;
                        u159.CLAIM_BUTTON_DISABLED.Visible = false;
                        v174 = i;
                    else
                        u159.CLAIM_BUTTON.Visible = false;
                        u159.CLAIM_BUTTON_DISABLED.Visible = true;
                        v174 = i;
                    end;
                end;

                return;
            end;

            v155 = math.min(v155 + 5, Depth + 30);

            if u139 == "DEFAULT" then
                v152 = InfinitePackData.GetRewardsAsync(Players.LocalPlayer, Data.InfinitePack.Day, v155);
            else
                v152 = EventInfinitePackData.GetRewards(Players.LocalPlayer, Data.EventInfinitePack[u139].Day, v155);
            end;

            local v175 = nil;

            for i = Depth + 2, #v152 do
                local v176 = v152[i];

                if v176 and (v176.ProductId or 0) ~= 0 then
                    v175 = i;
                    break;
                end;

                local _ = i;
            end;

            u143 = v175;
        end;
    end;

    local function reconcile() -- Line: 1726
        -- upvalues: DataService (ref), u139 (copy), u140 (ref), Holder (copy), u141 (ref), generate (copy)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local v177 = u139 ~= "DEFAULT" and Data.EventInfinitePack[u139].Day or Data.InfinitePack.Day;

        if u140 == v177 then
            return;
        end;

        for _, child in Holder:GetChildren() do
            if child:IsA("GuiObject") and tonumber(child.Name) then
                child:Destroy();
            end;
        end;

        u140 = v177;
        u141 = nil;
        generate();
    end;

    NumberValue.Changed:Connect(relayout);
    local math_max_ret = math.max(1, 0.38 * (not u143 and 0 or u143 - u142));
    local v178 = math_max_ret > 1;
    Holder.CanvasSize = UDim2.fromScale(math_max_ret, 0);
    Holder.ScrollingEnabled = v178;
    Holder.Active = v178;
    relayout();
    task.spawn(function() -- Line: 1764
        -- upvalues: reconcile (copy), u139 (copy), DataService (ref), generate (copy)
        task.spawn(reconcile);

        if u139 == "DEFAULT" then
            assert(DataService:GetPathSignal("InfinitePack/@")):Connect(function() -- Line: 1773
                -- upvalues: reconcile (ref), generate (ref)
                reconcile();
                generate();
            end);

            return;
        end;

        local v179 = `EventInfinitePack/{u139}/@`;
        assert(DataService:GetPathSignal(v179)):Connect(function() -- Line: 1768
            -- upvalues: reconcile (ref), generate (ref)
            reconcile();
            generate();
        end);
    end);
    task.spawn(function() -- Line: 1780
        -- upvalues: NumberUtil (ref), Infinite (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v180 = NumberUtil.compactFormat((ServerTimeNow // 86400 + 1) * 86400 - ServerTimeNow);
            Infinite.Header.Timer.Text = v180;
            Infinite.Header.Timer.TimerShadow.Text = v180;
            task.wait(1);
        end;
    end);
    local ForeverPackRewards = Infinite.PossibleRewardsContainer:FindFirstChild("ForeverPackRewards");

    for _, child in Infinite.PossibleRewardsContainer:GetChildren() do
        if string.match(child.Name, "ForeverPackRewards") then
            ForeverPackRewards = child;
        end;
    end;

    local REWARD_IMAGE = ForeverPackRewards.REWARD_IMAGE;
    ForeverPackRewards.Visible = false;
    local v181 = {};
    local Rewards = InfinitePackData.Rewards;

    if u139 ~= "DEFAULT" then
        Rewards = EventInfinitePackData.Rewards;
    end;

    if not Rewards then
        warn("Current Infinite Pack Type [packRewards] does not exist!");

        return;
    end;

    for _, v in Rewards.Free do
        if v.Type then
            if REWARD_IMAGE then
                table.insert(v181, {
                    Type = v.Type,
                    Value = v.RewardName or "Normal",
                    Quantity = v.Amount or 1
                });
            end;
        else
            warn("No reward type");
        end;
    end;

    for _, v in Rewards.Paid do
        if v.Type then
            if REWARD_IMAGE then
                table.insert(v181, {
                    Type = v.Type,
                    Value = v.RewardName or "Normal",
                    Quantity = v.Amount or 1
                });
            end;
        else
            warn("No reward type");
        end;
    end;

    ImageCycle.CycleRewardImages(REWARD_IMAGE, ForeverPackRewards.ITEM_NAME.REWARD_NAME, ForeverPackRewards.ITEM_NAME.REWARD_NAME_SHADOW, ForeverPackRewards, v181);
    ForeverPackRewards.Visible = true;
end;

function u1._initInfinitePack(p182) -- Line: 1860
    -- upvalues: InitialiseInfinitePack (copy)
    InitialiseInfinitePack("DEFAULT");
end;

function u1._initEventInfinitePack(p183) -- Line: 1864
    -- upvalues: EventInfinitePackData (copy), InitialiseInfinitePack (copy)
    local CurrentPack = EventInfinitePackData.CurrentPack;

    if CurrentPack then
        InitialiseInfinitePack(CurrentPack);
    end;
end;

function u1._initSheckles(p184) -- Line: 1871
    -- upvalues: Shop_UI (copy), MarketController (copy), GiftController (copy), UseDynamicPrices (copy), Comma_Module (copy)
    for _, child in Shop_UI.Frame.ScrollingFrame.Sheckles.List:GetChildren() do
        if child:IsA("GuiObject") then
            local u185 = tonumber(child.Name);

            if u185 then
                child.Buttons.Buy.Activated:Connect(function() -- Line: 1882
                    -- upvalues: MarketController (ref), u185 (copy)
                    MarketController:PromptPurchase(u185, Enum.InfoType.Product);
                end);
                child.Buttons.Gift.Activated:Connect(function() -- Line: 1886
                    -- upvalues: GiftController (ref), u185 (copy)
                    GiftController:PromptGiftFromNormalId(u185);
                end);

                if UseDynamicPrices or type(child:GetAttribute("FallbackPrice")) ~= "number" then
                    if not UseDynamicPrices then
                        warn((`{child.Buttons.Buy:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                    end;

                    MarketController:SetPriceLabel(child.Buttons.Buy, u185);
                else
                    child.Buttons.Buy.Text = `{utf8.char(57346)}{Comma_Module.Comma(child:GetAttribute("FallbackPrice"))}`;
                end;
            end;
        end;
    end;
end;

function u1._initPetProducts(p186) -- Line: 1902
    -- upvalues: Shop_UI (copy), DataService (copy), script_PetProducts (copy), UseDynamicPrices (copy), MarketController (copy), Comma_Module (copy), Notification (copy)
    for _, child in Shop_UI.Frame.ScrollingFrame.PetProducts.List:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "Free" then
            local Value = child:FindFirstChild("DataType").Value;
            local v187 = `PetsData/{Value}`;
            local u188 = DataService:GetData().PetsData[Value];
            local u189 = script_PetProducts[child.Name][u188 + 1];
            local u190;

            if u189 then
                u190 = u189.ProductId;
            else
                u190 = nil;
            end;

            local u191 = 0;

            local function Preinitialization() -- Line: 1917
                -- upvalues: u191 (ref), u188 (ref), DataService (ref), Value (copy), u189 (ref), script_PetProducts (ref), child (copy), u190 (ref), UseDynamicPrices (ref), MarketController (ref), Comma_Module (ref)
                u191 = u191 + 1;
                u188 = DataService:GetData().PetsData[Value];
                u189 = script_PetProducts[child.Name][u188 + 1];
                local v192;

                if u189 then
                    v192 = u189.ProductId;
                else
                    v192 = nil;
                end;

                u190 = v192;

                if u188 < 5 then
                    if UseDynamicPrices or u189.FallbackPrice == nil then
                        if not UseDynamicPrices then
                            warn((`{child:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        MarketController:SetPriceLabel(child.Buttons.Buy, u190);
                    else
                        child.Buttons.Buy.Text = `{utf8.char(57346)}{Comma_Module.Comma(u189.FallbackPrice)}`;
                    end;
                else
                    child.Buttons.Buy.Text = "MAX!";
                end;

                child.Amount.Text = `{u188}/5 Extra!`;
            end;

            assert(DataService:GetPathSignal(v187)):Connect(Preinitialization);
            Preinitialization();
            child.Buttons.Buy.Activated:Connect(function() -- Line: 1944
                -- upvalues: u188 (ref), Notification (ref), DataService (ref), Value (copy), u190 (ref), script_PetProducts (ref), child (copy), MarketController (ref)
                if u188 >= 5 then
                    Notification:CreateNotification("Maximum Slots Purchased!");

                    return;
                end;

                u188 = DataService:GetData().PetsData[Value];
                u190 = script_PetProducts[child.Name][u188 + 1].ProductId;
                MarketController:PromptPurchase(u190, Enum.InfoType.Product);
            end);
        end;
    end;
end;

local u193 = false;

function u1._initFarmersMarket(p194) -- Line: 1959
    -- upvalues: u193 (ref), Shop_UI (copy), DataService (copy), Notification (copy), MarketController (copy), DevProductIds (copy), UseDynamicPrices (copy), Comma_Module (copy)
    if u193 then
        return;
    end;

    u193 = true;
    Shop_UI.Frame.ScrollingFrame.FarmersMarket.Visible = true;
    local Data = DataService:GetData();
    local Frame = Shop_UI.Frame.ScrollingFrame.FarmersMarket.Frame;
    local Buy = Frame.Buy;

    local function DisableButton() -- Line: 1974
        -- upvalues: Buy (copy)
        Buy.Text = "Purchased";
        Buy.BackgroundColor3 = Color3.fromRGB(128, 128, 128);

        for _, child in Buy:GetChildren() do
            if child:IsA("UIStroke") then
                child.Color = Color3.fromRGB(24, 24, 24);
            end;
        end;
    end;

    local u195 = nil;
    u195 = DataService:GetPathSignal("PermanentGears/@"):Connect(function() -- Line: 1986
        -- upvalues: Data (copy), DisableButton (copy), Shop_UI (ref), u195 (ref)
        if Data.PermanentGears["Booth Sign"] then
            DisableButton();
            Shop_UI.Frame.ScrollingFrame.FarmersMarket.Visible = false;

            if u195 then
                u195:Disconnect();
                u195 = nil;
            end;
        end;
    end);
    Buy.Activated:Connect(function() -- Line: 1998
        -- upvalues: Data (copy), Notification (ref), MarketController (ref), DevProductIds (ref)
        if Data.PermanentGears["Booth Sign"] then
            Notification:CreateNotification("You\'ve already bought a Trade Sign!");

            return;
        end;

        MarketController:PromptPurchaseRobux(DevProductIds.BuyBoothPack.PurchaseID, Enum.InfoType.Product);
    end);

    if Data.PermanentGears["Booth Sign"] then
        DisableButton();
        Shop_UI.Frame.ScrollingFrame.FarmersMarket.Visible = false;
    elseif UseDynamicPrices then
        if not UseDynamicPrices then
            warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
        end;

        MarketController:SetPriceLabel(Buy, DevProductIds.BuyBoothPack.PurchaseID);
    else
        Buy.Text = `{utf8.char(57346)}{Comma_Module.Comma(149)}`;
    end;
end;

function u1._initDiggingTreasure(p196) -- Line: 2023
    -- upvalues: DiggingEventConfigData (copy), Shop_UI (copy), ReplicatedStorage (copy), ClientABTests (copy), LocalPlayer (copy), MarketController (copy), DevProductIds (copy), GuiController (copy), DiggingUIController (copy), DataService (copy), ItemImageFinder (copy), NumberUtil (copy), Chalk (copy)
    local CurrentTheme = DiggingEventConfigData.GetCurrentTheme();

    if CurrentTheme == "DISABLED" then
        return;
    end;

    local GraveDiggerPack = Shop_UI.Frame.ScrollingFrame.GraveDiggerPack;
    local PermanentDigging = require(ReplicatedStorage.Data.SharedCycleHandlerData).PermanentDigging;
    local DiggingRewardData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingRewardData);
    GraveDiggerPack.Visible = true;

    if ClientABTests.GetAttributeAsync(LocalPlayer, "AB_DiggingTypes", "Default") == "No_Free" then
        GraveDiggerPack.OfflineText.Visible = false;
    else
        GraveDiggerPack.OfflineText.Visible = true;
    end;

    MarketController:SetPriceLabel(GraveDiggerPack.Buttons.Buy10, DevProductIds.DiggingBuy10Digs.PurchaseID);
    MarketController:SetPriceLabel(GraveDiggerPack.Buttons.Buy20, DevProductIds.DiggingBuy20Digs.PurchaseID);
    GraveDiggerPack.Buttons.Buy10.Activated:Connect(function() -- Line: 2049
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.DiggingBuy10Digs.PurchaseID, Enum.InfoType.Product);
    end);
    GraveDiggerPack.Buttons.Buy20.Activated:Connect(function() -- Line: 2053
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.DiggingBuy20Digs.PurchaseID, Enum.InfoType.Product);
    end);
    task.spawn(function() -- Line: 2057
        -- upvalues: MarketController (ref), DevProductIds (ref), GraveDiggerPack (copy)
        local ProductInfo, v197 = MarketController:GetProductInfo(DevProductIds.DiggingBuyDigs.PurchaseID, Enum.InfoType.Product, 3);
        GraveDiggerPack.Buttons.Buy20.TextLabel.Text = not (ProductInfo and v197.PriceInRobux) and 236 or (v197.PriceInRobux or 59) * 4;
    end);
    GraveDiggerPack.Buttons.Go.Activated:Connect(function() -- Line: 2068
        -- upvalues: GuiController (ref), Shop_UI (ref), DiggingUIController (ref)
        GuiController:Close(Shop_UI);
        task.wait(0.5);
        DiggingUIController:Open();
    end);
    task.spawn(function() -- Line: 2074
        -- upvalues: DataService (ref), CurrentTheme (copy), DiggingRewardData (copy), GraveDiggerPack (copy), ItemImageFinder (ref), PermanentDigging (copy), NumberUtil (ref), Chalk (ref)
        local Data = DataService:GetData();

        if CurrentTheme == "DISABLED" then
            return;
        end;

        local v198 = DiggingRewardData.RewardSets[CurrentTheme] or {};
        table.sort(v198, function(p199, p200) -- Line: 2083
            return p199.Chance < p200.Chance;
        end);

        for i = math.min(4, #v198), 1, -1 do
            local v201 = GraveDiggerPack.Rewards[`Segment{i}`];
            local v202;

            if v201 then
                v201.RewardImage.Image = ItemImageFinder(v198[i].Value, v198[i].Type);
                v202 = i;
            else
                v202 = i;
            end;
        end;

        while true do
            local TimeUntilNext = PermanentDigging:GetTimeUntilNext();

            if TimeUntilNext then
                local v203 = NumberUtil.compactFormat(TimeUntilNext);
                local v204 = "Resets in: " .. Chalk.red((`{v203}`));
                GraveDiggerPack.Background.Top.RestocksIn.Timer.Text = v204;
            end;

            if Data then
                GraveDiggerPack.Buttons.Go.Amount.Text = `({Data.DiggingData.RemainingDigs}) Digs Available`;
            end;

            task.wait(1);
        end;
    end);
end;

local function HandleTreasureDiggingPack() -- Line: 2121
    -- upvalues: Shop_UI (copy), DiggingEventConfigData (copy), u1 (copy)
    Shop_UI.Frame.ScrollingFrame.GraveDiggerPack.Visible = false;

    if DiggingEventConfigData.GetCurrentTheme() == "DISABLED" then
        return;
    end;

    task.spawn(u1._initDiggingTreasure, u1);
end;

function u1.Start(p205) -- Line: 2131
    -- upvalues: GuiController (copy), Shop_UI (copy), PolicyService (copy), LocalPlayer (copy), UpdateService (copy), ExoticPackData (copy), ContentProvider (copy), u1 (copy), ReplaceNormalPack (copy), DiggingEventConfigData (copy), EventInfinitePackData (copy), ScarletAspenLimitedSeedData (copy), ReplicatedStorage (copy)
    GuiController:UsePopupAnims(Shop_UI);
    Shop_UI.Frame.Close.Activated:Connect(function() -- Line: 2134
        -- upvalues: GuiController (ref), Shop_UI (ref)
        GuiController:Close(Shop_UI);
    end);
    task.spawn(function() -- Line: 2138
        -- upvalues: PolicyService (ref), LocalPlayer (ref), UpdateService (ref), ExoticPackData (ref), ContentProvider (ref), u1 (ref)
        local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

        if PolicyInfoForPlayerAsync and PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted then
            return;
        end;

        local v206 = UpdateService:IsHiddenFromUpdate("Premium Haunted Egg");

        if v206 then
            task.spawn(function() -- Line: 2150
                -- upvalues: ExoticPackData (ref), ContentProvider (ref)
                local v207 = {};

                for _, v in ExoticPackData.EXOTIC_FAIRY_CHEST.Items do
                    if v.Icon then
                        local ImageLabel = Instance.new("ImageLabel");
                        ImageLabel.Image = v.Icon;
                        table.insert(v207, ImageLabel);
                    end;
                end;

                ContentProvider:PreloadAsync(v207);

                for _, v in v207 do
                    v:Destroy();
                end;

                table.clear(v207);
            end);
            xpcall(function() -- Line: 2170
                -- upvalues: u1 (ref), ExoticPackData (ref)
                u1:_createExoticPack(ExoticPackData.EXOTIC_FAIRY_CHEST, 1);
            end, warn);
            xpcall(function() -- Line: 2174
                -- upvalues: u1 (ref), ExoticPackData (ref)
                u1:_createExoticPack(ExoticPackData.PREMIUM_AUTUMN_EGG, 2, "rbxassetid://78289594972654");
            end, warn);

            while UpdateService:IsHiddenFromUpdate("Premium Haunted Egg") do
                task.wait(1);
            end;
        end;

        xpcall(function() -- Line: 2183
            -- upvalues: u1 (ref), ExoticPackData (ref)
            u1:_createExoticPack(ExoticPackData.PREMIUM_HAUNTED_EGG, 1);
        end, warn);
        xpcall(function() -- Line: 2187
            -- upvalues: u1 (ref)
            u1:_destroyExoticPack(2);
        end, warn);

        if v206 then
            u1:_notifyUntilOpened();
        end;
    end);

    if ReplaceNormalPack then
        Shop_UI.Frame.ScrollingFrame.Infinite.Visible = false;

        if Shop_UI.Frame.ScrollingFrame.CanvasSize.Y.Scale > 1.775 then
            Shop_UI.Frame.ScrollingFrame.CanvasSize = UDim2.fromScale(0, 1.775);
        end;
    else
        task.spawn(u1._initInfinitePack, u1);
    end;

    Shop_UI.Frame.ScrollingFrame.GraveDiggerPack.Visible = false;

    if DiggingEventConfigData.GetCurrentTheme() ~= "DISABLED" then
        task.spawn(u1._initDiggingTreasure, u1);
    end;

    if UpdateService:IsUpdateDone() then
        if UpdateService:IsHiddenFromUpdate("Booth Sign") then
            task.spawn(function() -- Line: 2211
                -- upvalues: u1 (ref)
                u1:_initFarmersMarket();
            end);
        end;
    else
        if EventInfinitePackData.CurrentPack and EventInfinitePackData.CurrentPack ~= "None" then
            task.spawn(u1._initEventInfinitePack, u1);
        end;

        UpdateService.OnUpdated:Once(function() -- Line: 2221
            -- upvalues: Shop_UI (ref), DiggingEventConfigData (ref), u1 (ref)
            Shop_UI.Frame.ScrollingFrame.GraveDiggerPack.Visible = false;

            if DiggingEventConfigData.GetCurrentTheme() == "DISABLED" then
                return;
            end;

            task.spawn(u1._initDiggingTreasure, u1);
        end);
    end;

    if UpdateService:IsHiddenFromUpdate("Shop/Seed Rain") then
        UpdateService.OnUpdated:Once(function() -- Line: 2227
            -- upvalues: u1 (ref)
            task.spawn(function() -- Line: 2228
                -- upvalues: u1 (ref)
                u1:_initSeedRain();
            end);
        end);
    else
        task.spawn(function() -- Line: 2233
            -- upvalues: u1 (ref)
            u1:_initSeedRain();
        end);
    end;

    if UpdateService:IsHiddenFromUpdate("Shop/Super Seed Pack V1") then
        UpdateService.OnUpdated:Once(function() -- Line: 2239
            -- upvalues: u1 (ref)
            task.spawn(function() -- Line: 2240
                -- upvalues: u1 (ref)
                u1:_initSuperSeedPackV1();
            end);
        end);
    else
        task.spawn(function() -- Line: 2245
            -- upvalues: u1 (ref)
            u1:_initSuperSeedPackV1();
        end);
    end;

    if UpdateService:IsHiddenFromUpdate("Shop/Super Seed Pack V2") then
        UpdateService.OnUpdated:Once(function() -- Line: 2251
            -- upvalues: u1 (ref)
            task.spawn(function() -- Line: 2252
                -- upvalues: u1 (ref)
                u1:_initSuperSeedPackV2();
            end);
        end);
    else
        task.spawn(function() -- Line: 2257
            -- upvalues: u1 (ref)
            u1:_initSuperSeedPackV2();
        end);
    end;

    if UpdateService:IsHiddenFromUpdate(ScarletAspenLimitedSeedData.UpdateGateKey) then
        Shop_UI.Frame.ScrollingFrame.LimitedStock.Visible = false;
        UpdateService.OnUpdated:Once(function() -- Line: 2266
            -- upvalues: u1 (ref), ScarletAspenLimitedSeedData (ref)
            task.spawn(function() -- Line: 2267
                -- upvalues: u1 (ref)
                u1:_initLimitedSeed();
            end);

            if workspace:GetServerTimeNow() < ScarletAspenLimitedSeedData.EndTime then
                u1:_notifyUntilOpened();
            end;
        end);
    else
        task.spawn(function() -- Line: 2276
            -- upvalues: u1 (ref)
            u1:_initLimitedSeed();
        end);
    end;

    if UpdateService:IsHiddenFromUpdate("Shop/Farmers Market") then
        UpdateService.OnUpdated:Once(function() -- Line: 2282
            -- upvalues: u1 (ref)
            task.spawn(function() -- Line: 2283
                -- upvalues: u1 (ref)
                u1:_initFarmersMarket();
            end);
        end);
    else
        task.spawn(function() -- Line: 2288
            -- upvalues: u1 (ref)
            u1:_initFarmersMarket();
        end);
    end;

    task.spawn(u1._initPetProducts, u1);
    task.spawn(function() -- Line: 2296
        -- upvalues: Shop_UI (ref), u1 (ref)
        Shop_UI.Frame.ScrollingFrame.TwilightPack.Visible = false;
        u1:_initTwilightPack();
    end);
    task.spawn(function() -- Line: 2300
        -- upvalues: Shop_UI (ref), u1 (ref)
        Shop_UI.Frame.ScrollingFrame.Summer2026Pack.Visible = false;
        u1:_initSummer2026Pack();
    end);
    task.spawn(function() -- Line: 2304
        -- upvalues: u1 (ref)
        u1:_initGoldShovelPack();
    end);
    task.spawn(function() -- Line: 2307
        -- upvalues: Shop_UI (ref), u1 (ref)
        Shop_UI.Frame.ScrollingFrame.SaintPatricksPack.Visible = true;
        u1:_initSaintPatricksPack();
    end);

    if UpdateService:IsHiddenFromUpdate("Easter") then
        Shop_UI.Frame.ScrollingFrame.RainbowShovel.Visible = true;
        u1:_initRainbowShovelPack();
    else
        Shop_UI.Frame.ScrollingFrame.RainbowShovel.Visible = false;
    end;

    local TradeWorldData = require(ReplicatedStorage.Data.TradeWorldData);

    if game.PlaceId == TradeWorldData.PlaceId and true or TradeWorldData.ForceInWorld == true then
        task.spawn(function() -- Line: 2324
            -- upvalues: u1 (ref)
            u1:_initFarmersMarket();
        end);
    end;
end;

task.spawn(u1.Start, u1);

return u1;