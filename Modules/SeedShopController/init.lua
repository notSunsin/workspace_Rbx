-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ReplicatedFirst");
local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
game:GetService("TweenService");
game:GetService("AdService");
local LocalPlayer = game.Players.LocalPlayer;
local Seed_Shop = LocalPlayer.PlayerGui:WaitForChild("Seed_Shop");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.Observers);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Signal = require(ReplicatedStorage.Modules.Signal);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
require(ReplicatedStorage.Code.Particle2D);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local Spr = require(ReplicatedStorage.Code.Spr);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local SeedShopConfigData = require(ReplicatedStorage.Data.SeedShopConfigData);
local ShopTabHandler = require(ReplicatedStorage.Modules.ShopTabHandler);
local ShopTabData = require(ReplicatedStorage.Data.ShopTabData);
local NPCLevelHandler = require(ReplicatedStorage.Modules.NPCLevelHandler);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Modules.DumpTable);
require(ReplicatedStorage.Modules.PlantTraitsData);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
local RewardedAdEvent = ReplicatedStorage.GameEvents:WaitForChild("RewardedAdEvent");
require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
local u1 = nil;
local u2 = Signal.new();
local ScrollingFrame = Seed_Shop:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
ScrollingFrame:WaitForChild("UIListLayout");
local Timer = Seed_Shop:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local ItemFrame = ScrollingFrame:WaitForChild("ItemFrame");
ItemFrame.Parent = script;
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemPadding.Parent = ScrollingFrame;
local SeedShopData = require(game.ReplicatedStorage.Data.SeedShopData);
local DailySeedShopData = require(game.ReplicatedStorage.Data.DailySeedShopData);
local Frame = Seed_Shop:WaitForChild("Frame");
local Daily = Seed_Shop:WaitForChild("Daily");
local SeedData = require(game.ReplicatedStorage.Data.SeedData);
local SoundPlayer = require(game.ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(game.ReplicatedStorage.Data.SoundData);
local u3 = {};
local u4 = {};
local u5 = {};
local v6 = {};
local Spring = require(ReplicatedStorage.Modules.Spring);
local u7 = {};
local u8 = false;
local u9 = nil;
local u10 = nil;
local u11 = {};
local UITabHelperModule = require(ReplicatedStorage.Modules.UITabHelperModule);
local TabList = Seed_Shop:WaitForChild("TabAnchor"):WaitForChild("TabList");
local TabButtonTemplate = ReplicatedStorage.UITemplates:WaitForChild("TabButtonTemplate");
local u12 = UITabHelperModule.CreateOrGetTabHandler("SeedShop", TabList, TabButtonTemplate);
u12.DefaultCategory = "Shop";
u12.CurrentCategory = "Shop";
local u13 = {
    Shop = SeedShopData,
    ["Normal Seeds"] = SeedShopData,
    ["Daily Deals"] = DailySeedShopData
};
local u14 = {
    {
        Name = "Shop",
        IsLocked = false,
        Color = Color3.fromRGB(40, 170, 0)
    },
    {
        Name = "Daily Deals",
        IsLocked = false
    }
};
local EventShopConfigData = require(ReplicatedStorage.Data.EventShopConfigData);
local u15 = {
    ["Honey Coins"] = "Honey Coin Shop",
    ["Honey Seeds"] = "Honey Seed Shop",
    ["Royal Jelly"] = "Royal Jelly Shop"
};

local function rebuildTabsForContext() -- Line: 115
    -- upvalues: LocalPlayer (copy), u12 (copy), u14 (copy), EventShopConfigData (copy), UpdateService (copy)
    local Attribute = LocalPlayer:GetAttribute("OpenedFromHoneyShop");

    if not Attribute then
        u12.SetCategories(u14);
        u12.DefaultCategory = "Shop";
        u12.CurrentCategory = "Shop";

        return;
    end;

    local LinkedShops = EventShopConfigData.GetLinkedShops(Attribute);

    if not LinkedShops then
        u12.SetCategories(u14);

        return;
    end;

    local v16 = {};

    for _, v in LinkedShops do
        if v.Index == "SEED_SHOP" then
            for _, v2 in u14 do
                local table_clone_ret = table.clone(v2);

                if table_clone_ret.Name == "Shop" then
                    table_clone_ret.Name = "Normal Seeds";
                end;

                table.insert(v16, table_clone_ret);
            end;
        elseif UpdateService:IsActive(v.Index) then
            table.insert(v16, {
                IsLocked = false,
                Name = v.Label,
                Color = v.Color
            });
        end;
    end;

    u12.SetCategories(v16);
    local v17 = Attribute and "Normal Seeds" or "Shop";
    u12.DefaultCategory = v17;
    u12.SetCurrentCategory(v17);
end;

Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 159
    -- upvalues: Seed_Shop (copy), rebuildTabsForContext (copy), LocalPlayer (copy)
    if Seed_Shop.Enabled then
        rebuildTabsForContext();

        return;
    end;

    LocalPlayer:SetAttribute("OpenedFromHoneyShop", nil);
end);

local function GetRefreshTime() -- Line: 168
    -- upvalues: DataService (copy), u12 (copy), ShopTabData (copy), SeedShopConfigData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local CurrentCategory = u12.CurrentCategory;
    local v18 = (CurrentCategory == "Daily Deals" or CurrentCategory == "Normal Seeds") and "Shop" or CurrentCategory;
    local v19 = Data.SeedStocks[v18];
    local v20 = v19 and v19.ForcedSeedEndTimestamp and (v19.ForcedSeedEndTimestamp - ServerTimeNow or -1) or -1;

    if v20 >= 0 then
        return v20;
    end;

    local RefreshTime = (ShopTabData.Seed[v18] or SeedShopConfigData).RefreshTime;

    return RefreshTime - ServerTimeNow % RefreshTime;
end;

local CollectionService = game:GetService("CollectionService");

local function Get_Tagged_Part(p21) -- Line: 190
    -- upvalues: CollectionService (copy)
    local Tagged = CollectionService:GetTagged(p21);

    for _, v in ipairs(Tagged) do
        if v:IsA("TextLabel") then
            return v;
        end;
    end;

    return nil;
end;

local function HasBeenAssignedThisABTest(p22: userdata, p23: string) -- Line: 204
    -- upvalues: ReplicatedStorage (copy)
    local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);

    if ClientABTests.GetAssignmentsAsync(p22, true) then
        return ClientABTests.GetAttributeAsync(p22, p23, true) and true or false;
    end;

    return false;
end;

local u24 = {};

function UPD_Restock_Timer_AB(p25)
    -- upvalues: Get_Tagged_Part (copy), u24 (copy)
    local Attribute = p25:GetAttribute("AB_RestockTimer_NEW");
    local v26 = Attribute == nil and "Not_Visible" or Attribute;

    if v26 == "Not_Visible" then
        return;
    end;

    if v26 == "SeedShopRestock_1" then
        local u27 = Get_Tagged_Part("SeedShopRestock_1");

        if u27 then
            local Parent = u27.Parent;
            Parent.Enabled = true;
            table.insert(u24, u27);

            return function() -- Line: 233
                -- upvalues: Parent (copy), u24 (ref), u27 (copy)
                Parent.Enabled = false;
                local table_find_ret = table.find(u24, u27);

                if table_find_ret then
                    table.remove(u24, table_find_ret);
                end;
            end;
        end;
    elseif v26 == "SeedShopRestock_2" then
        local u28 = Get_Tagged_Part("SeedShopRestock_2");

        if u28 then
            local Parent = u28.Parent.Parent;
            Parent.Enabled = true;
            table.insert(u24, u28);

            return function() -- Line: 249
                -- upvalues: Parent (copy), u24 (ref), u28 (copy)
                Parent.Enabled = false;
                local table_find_ret = table.find(u24, u28);

                if table_find_ret then
                    table.remove(u24, table_find_ret);
                end;
            end;
        end;
    else
        local u29 = v26 == "SeedShopRestock_3" and Get_Tagged_Part("SeedShopRestock_3");

        if u29 then
            local Parent = u29.Parent.Parent;
            Parent.Enabled = true;
            table.insert(u24, u29);

            return function() -- Line: 265
                -- upvalues: Parent (copy), u24 (ref), u29 (copy)
                Parent.Enabled = false;
                local table_find_ret = table.find(u24, u29);

                if table_find_ret then
                    table.remove(u24, table_find_ret);
                end;
            end;
        end;
    end;
end;

UPD_Restock_Timer_AB(LocalPlayer);
LocalPlayer:GetAttributeChangedSignal("AB_RestockTimer_NEW"):Connect(function() -- Line: 278
    -- upvalues: LocalPlayer (copy)
    UPD_Restock_Timer_AB(LocalPlayer);
end);
local _ = game.SoundService.Click;
local Restock_SFX = game.SoundService.Restock_SFX;

local function UpdateRefreshLabel() -- Line: 286
    -- upvalues: GetRefreshTime (copy), Timer (copy), NumberUtil (copy), u24 (copy), TradeWorldController (copy), Restock_SFX (copy)
    local v30 = GetRefreshTime();
    Timer.Text = v30 <= 0 and "Restocking" or "New seeds in " .. NumberUtil.compactFormat(v30);

    for _, v in u24 do
        v.Text = v30 <= 0 and "Now" or NumberUtil.compactFormat(v30);
    end;

    if v30 <= 1 and not TradeWorldController:IsInWorld() then
        Restock_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Restock_SFX.TimePosition = 0;
        Restock_SFX.Playing = true;
        require(game.ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#ADD8E6\"><b>Your Seed Shop stock has restocked!</b></font>");
    end;
end;

local function SetupTimer() -- Line: 304
    -- upvalues: UpdateRefreshLabel (copy)
    while true do
        UpdateRefreshLabel();
        task.wait(1);
    end;
end;

local Click = game.SoundService.Click;
task.spawn(function() -- Line: 313
    -- upvalues: Seed_Shop (copy)
    local TweenService = game:GetService("TweenService");
    local u31 = nil;
    game.Workspace:GetAttributeChangedSignal("RestockFever"):Connect(function() -- Line: 318
        -- upvalues: Seed_Shop (ref), u31 (ref), TweenService (copy)
        local RainbowBackground = Seed_Shop:FindFirstChild("RainbowBackground");

        if not RainbowBackground then
            return;
        end;

        local UIGradient = RainbowBackground:FindFirstChild("UIGradient");

        if not UIGradient then
            return;
        end;

        if u31 then
            u31:Cancel();
        end;

        if game.Workspace:GetAttribute("RestockFever") then
            RainbowBackground.Transparency = 0;
            u31 = TweenService:Create(UIGradient, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
                Rotation = UIGradient.Rotation + 360
            });
            u31:Play();

            return;
        end;

        if u31 then
            u31:Cancel();
        end;

        UIGradient.Rotation = 0;
        RainbowBackground.Transparency = 1;
    end);
end);

local function SetupFrames() -- Line: 344
    -- upvalues: u4 (copy), u5 (copy), u3 (copy), UserInputService (copy), u13 (copy), u12 (copy), ContentProvider (copy), u9 (ref), u8 (ref), ShopTabHandler (copy), UpdateService (copy), LocalPlayer (copy), ReplicatedStorage (copy), ItemFrame (copy), Item_Module (copy), Seed_Shop (copy), ColorHelper (copy), Comma_Module (copy), NumberUtil (copy), ScrollingFrame (copy), FastTween (copy), ItemPadding (copy), DataService (copy), WatchButtonHold (copy), Spr (copy), MarketController (copy), Click (copy), GiftController (copy), CurrencyData (copy), u1 (ref), u2 (copy), UseDynamicPrices (copy), Spring (copy), u11 (copy), SoundPlayer (copy), SoundData (copy), SeedData (copy), u7 (copy), u10 (ref), NPCLevelHandler (copy), RebirthUnlocksSharedService (copy)
    for _, v in ipairs(u4) do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    table.clear(u4);

    for _, v in u5 do
        if v then
            task.cancel(v);
        end;
    end;

    table.clear(u5);

    for _, v in u3 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    table.clear(u3);

    if not UserInputService.TouchEnabled then
        local u32 = {};

        for _, v in u13[u12.CurrentCategory] or u13.Shop do
            if v.DisplayInShop and v.Seed then
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = v.Seed.FruitIcon;
                table.insert(u32, ImageLabel);
            end;
        end;

        task.spawn(function() -- Line: 384
            -- upvalues: ContentProvider (ref), u32 (copy)
            ContentProvider:PreloadAsync(u32);

            for _, v in u32 do
                v:Destroy();
            end;

            table.clear(u32);
        end);
    end;

    local function FetchStockInfo(p33: any, p34: string, p35: string) -- Line: 393
        local v36 = p33[p35];

        return not v36.Stocks[p34] and {
            MaxStock = 0,
            Stock = 0
        } or v36.Stocks[p34];
    end;

    local u37 = {};

    for i, v in u13[u12.CurrentCategory] do
        if v.DisplayInShop and v.Seed then
            if u9 then
                task.cancel(u9);
                u8 = false;
            end;

            local v38 = ShopTabHandler:IsItemLockedByTab("Seed", i);
            local CurrentCategory = u12.CurrentCategory;
            local u39, u40;

            if v38 then
                u39 = i;
                u40 = v;
                local v41 = false;

                for _, v2 in v38 do
                    if ShopTabHandler:IsTabUnlocked("Seed", v2) then
                        v41 = true;
                        break;
                    end;
                end;

                if table.find(v38, u12.CurrentCategory) and v41 then
                    goto l1;
                end;
            else
                local u39, u40;
                local v42 = 0;

                while true do
                    if v42 == 0 then
                        v42 = -1;
                        u39 = i;
                        u40 = v;
                        v42 = 1;
                        continue;
                    elseif v42 == 1 then
                        v42 = -1;

                        if (v38 or (not u12.CurrentCategory or u12.CurrentCategory == u12.DefaultCategory)) and not (UpdateService:IsHiddenFromUpdate(u40.Seed.SeedName) or UpdateService:IsHiddenAfterUpdate(u40.Seed.SeedName)) then
                            if u40.ABTestName then
                                local v43 = LocalPlayer;
                                local ABTestName = u40.ABTestName;
                                local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
                                local v44;

                                if ClientABTests.GetAssignmentsAsync(v43, true) then
                                    v44 = ClientABTests.GetAttributeAsync(v43, ABTestName, true) and true or false;
                                else
                                    v44 = false;
                                end;

                                if v44 then
                                    goto l0;
                                end;
                            else
                                local u45 = ItemFrame:Clone();
                                u3[u39] = u45;
                                u45.Name = u39;
                                u45.LayoutOrder = u40.LayoutOrder * 10;
                                table.insert(u37, u45);
                                local Main_Frame = u45.Main_Frame;
                                local v46 = Item_Module.Return_Rarity_Data(u40.Seed.SeedRarity);

                                if v46 then
                                    local v47 = v46[1];
                                    local v48 = v46[2];
                                    local v49 = v46[3];
                                    Main_Frame.Rarity_Text.Text = v47;

                                    if v49 and v47 == "Prismatic" then
                                        local u50 = nil;
                                        u50 = game:GetService("RunService").Heartbeat:Connect(function(p51) -- Line: 480
                                            -- upvalues: Seed_Shop (ref), Main_Frame (copy), u50 (ref), ColorHelper (ref)
                                            if not Seed_Shop.Enabled then
                                                return;
                                            end;

                                            if not (Main_Frame and Main_Frame.Parent) then
                                                u50:Disconnect();

                                                return;
                                            end;

                                            local v52 = os.clock() * 0.1 % 1;
                                            local Color3_fromHSV_ret = Color3.fromHSV(v52, 1, 1);
                                            Main_Frame.Rarity_BG.ImageColor3 = Color3_fromHSV_ret;

                                            if Main_Frame.Rarity_Text.UIStroke then
                                                Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(Color3_fromHSV_ret);
                                            end;
                                        end);
                                    elseif v47 == "Transcendent" then
                                        Main_Frame.Rarity_BG.TranscendantSparkles.Visible = true;
                                        local u53 = nil;
                                        local u54 = 1;
                                        u53 = game:GetService("RunService").Heartbeat:Connect(function(p55) -- Line: 508
                                            -- upvalues: Seed_Shop (ref), Main_Frame (copy), u53 (ref), u54 (ref)
                                            if not Seed_Shop.Enabled then
                                                return;
                                            end;

                                            if not (Main_Frame and Main_Frame.Parent) then
                                                u53:Disconnect();

                                                return;
                                            end;

                                            Random.new();

                                            for _, child in Main_Frame.Rarity_BG.TranscendantSparkles:GetChildren() do
                                                child.Rotation = child.Rotation + 10 * p55;
                                                local v56 = child.Size.X.Offset + u54 * 1;

                                                if v56 >= 50 then
                                                    v56 = 50;
                                                    u54 = -1;
                                                elseif v56 <= 0 then
                                                    v56 = 0;
                                                    u54 = 1;
                                                end;

                                                child.Size = UDim2.new(0, v56, 0, v56);
                                            end;
                                        end);

                                        if Main_Frame.Rarity_Text.UIStroke then
                                            Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v48);
                                        end;

                                        Main_Frame.Rarity_BG.ImageColor3 = Color3.new(1, 1, 1);
                                        Main_Frame.Rarity_BG.UIGradient.Enabled = true;
                                        Main_Frame.Rarity_BG.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 149, 1), Color3.fromRGB(255, 238, 5));
                                    else
                                        if Main_Frame.Rarity_Text.UIStroke then
                                            Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v48);
                                        end;

                                        Main_Frame.Rarity_BG.ImageColor3 = v48;
                                    end;
                                end;

                                Main_Frame.Seed_Text.Text = u40.Seed.SeedName;
                                Main_Frame.Seed_Text_Shadow.Text = u40.Seed.SeedName;
                                local u57;

                                if u40.SpecialCurrencyType then
                                    u57 = Comma_Module.Comma(u40.Price) .. "";
                                else
                                    u57 = NumberUtil.DisplaySheckles(u40.Price);
                                end;

                                if u40.Description then
                                    Main_Frame.LargeDescriptionText.Text = u40.Description;
                                    Main_Frame.InfoButton.Visible = true;
                                else
                                    Main_Frame.InfoButton.Visible = false;
                                    Main_Frame.Seed_Text.Size = UDim2.fromScale(0.652, Main_Frame.Seed_Text.Size.Y.Scale);
                                    Main_Frame.Seed_Text_Shadow.Size = UDim2.fromScale(0.652, Main_Frame.Seed_Text_Shadow.Size.Y.Scale);
                                end;

                                Main_Frame.LargeDescriptionText.Visible = false;
                                local u58 = false;
                                Main_Frame.InfoButton.Activated:Connect(function() -- Line: 579, Name: ToggleDescriptionVisibility
                                    -- upvalues: u58 (ref), Main_Frame (copy)
                                    u58 = not u58;
                                    Main_Frame.LargeDescriptionText.Visible = u58;
                                    Main_Frame.Rarity_BG.Visible = not u58;
                                    Main_Frame.Rarity_Text.Visible = not u58;
                                    Main_Frame.Stock_Text.Visible = not u58;
                                    Main_Frame.Cost_Text.Visible = not u58;
                                end);

                                if u40.IsLimited then
                                    Main_Frame.LimitedBanner.Visible = true;
                                end;

                                u45.Parent = ScrollingFrame;
                                u45.Main_Frame.CanvasGroup.ShopItem_Image.Image = u40.Seed.Asset;
                                local u59 = nil;
                                local u60 = nil;
                                Main_Frame.MouseEnter:Connect(function() -- Line: 601
                                    -- upvalues: u59 (ref), FastTween (ref), u45 (copy), u60 (ref), u40 (copy)
                                    u59 = FastTween(u45.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                                        Rotation = u45.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                                    });
                                    u60 = FastTween(u45.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                        Scale = 1.5
                                    });
                                    u60.Completed:Connect(function(p61) -- Line: 617
                                        -- upvalues: u45 (ref), u40 (ref)
                                        if p61 == Enum.PlaybackState.Completed then
                                            if not u45:IsDescendantOf(game) then
                                                return;
                                            end;

                                            u45.Main_Frame.CanvasGroup.ShopItem_Image.Image = u40.Seed.FruitIcon;
                                        end;
                                    end);
                                end);
                                Main_Frame.MouseLeave:Connect(function() -- Line: 627
                                    -- upvalues: u59 (ref), u45 (copy), u40 (copy), FastTween (ref)
                                    if u59 then
                                        u59:Cancel();
                                    end;

                                    u45.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                                    u45.Main_Frame.CanvasGroup.ShopItem_Image.Image = u40.Seed.Asset;
                                    FastTween(u45.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                        Scale = 1
                                    });
                                end);
                                local v62 = Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 644
                                    -- upvalues: Seed_Shop (ref), u59 (ref), u45 (copy), u40 (copy), FastTween (ref)
                                    if not Seed_Shop.Enabled then
                                        if u59 then
                                            u59:Cancel();
                                        end;

                                        u45.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                                        u45.Main_Frame.CanvasGroup.ShopItem_Image.Image = u40.Seed.Asset;
                                        FastTween(u45.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                            Scale = 1
                                        });
                                    end;
                                end);
                                table.insert(u4, v62);
                                local u63 = ItemPadding:Clone();
                                u63.LayoutOrder = u40.LayoutOrder * 10 + 1;
                                u63.Name = `{u39}_Padding`;
                                u63.Parent = ScrollingFrame;
                                u3[u63.Name] = u63;
                                local Frame2 = u45.Frame;

                                if Frame2.Sheckles_Buy.In_Stock.Cost_Text:FindFirstChild("TEXT") then
                                    Frame2.Sheckles_Buy.In_Stock.Cost_Text.TEXT.Text = u57;
                                else
                                    Frame2.Sheckles_Buy.In_Stock.Cost_Text.Text = u57;
                                end;

                                if u40.EndTime then
                                    local task_spawn_ret = task.spawn(function() -- Line: 679
                                        -- upvalues: u40 (copy), Main_Frame (copy), NumberUtil (ref)
                                        while true do
                                            local v64 = u40.EndTime - workspace:GetServerTimeNow();
                                            Main_Frame.LimitedBanner.Timer.Text = NumberUtil.formatShopTime(v64);
                                            Main_Frame.LimitedBanner.Timer.Visible = v64 > 0;
                                            task.wait(1);
                                        end;
                                    end);
                                    table.insert(u5, task_spawn_ret);
                                end;

                                local function buy() -- Line: 693
                                    -- upvalues: u39 (copy), u8 (ref), DataService (ref), u45 (copy), CurrentCategory (copy), ReplicatedStorage (ref)
                                    if workspace:GetAttribute("InTutorial") and u39 ~= "Carrot" then
                                        return;
                                    end;

                                    if u8 then
                                        local Data = DataService:GetData();

                                        if Data then
                                            local v65 = u39;
                                            local Shop = Data.SeedStocks.Shop;
                                            Data = not Shop.Stocks[v65] and {
                                                MaxStock = 0,
                                                Stock = 0
                                            } or Shop.Stocks[v65];
                                        end;

                                        local v66 = Data and Data.Stock or 0;
                                        local Attribute = u45.Main_Frame:GetAttribute("CurrentStock");

                                        if Attribute and Attribute < v66 then
                                            return;
                                        end;
                                    end;

                                    local v67 = CurrentCategory or "Shop";
                                    ReplicatedStorage.GameEvents.BuySeedStock:FireServer(v67 == "Normal Seeds" and "Shop" or v67, u39);
                                end;

                                local u68 = false;
                                local u69 = 0;
                                WatchButtonHold(Frame2.Sheckles_Buy, function(p70: number, p71: boolean?) -- Line: 722
                                    -- upvalues: u69 (ref), u68 (ref), Frame2 (copy), Spr (ref), buy (copy)
                                    if workspace:GetAttribute("InTutorial") then
                                        return;
                                    end;

                                    if p71 then
                                        u69 = 0;

                                        if u68 then
                                            u68 = false;

                                            if Frame2:FindFirstChild("Sheckles_Buy") then
                                                Spr.target(Frame2.Sheckles_Buy, 0.8, 2, {
                                                    ImageColor3 = Color3.new(1, 1, 1)
                                                });
                                            end;
                                        end;

                                        return;
                                    end;

                                    if not u68 then
                                        u68 = true;

                                        if Frame2:FindFirstChild("Sheckles_Buy") then
                                            Spr.target(Frame2.Sheckles_Buy, 0.8, 2, {
                                                ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                                            });
                                        end;
                                    end;

                                    if os.clock() < u69 then
                                        return;
                                    end;

                                    local v72 = ((1 - math.exp(p70 * -0.3)) * 24 + 8) // 1;
                                    local math_max_ret = math.max(v72, 1);
                                    u69 = os.clock() + 0.125;

                                    for i2 = 1, math_max_ret do
                                        buy();
                                        local _ = i2;
                                    end;
                                end, {
                                    minimumHoldTime = 1,
                                    interval = 0.125
                                });
                                Frame2.Sheckles_Buy.Activated:Connect(buy);
                                Frame2.Robux_Buy.Activated:Connect(function() -- Line: 769
                                    -- upvalues: MarketController (ref), u40 (copy)
                                    MarketController:PromptPurchase(u40.PurchaseID, Enum.InfoType.Product);
                                end);
                                Frame2.Gift.Visible = u40.GiftPurchaseID ~= nil;

                                if u40.GiftPurchaseID then
                                    Frame2.Gift.Activated:Connect(function() -- Line: 775
                                        -- upvalues: Click (ref), GiftController (ref), u40 (copy)
                                        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                                        Click.TimePosition = 0;
                                        Click.Playing = true;
                                        GiftController:PromptGiftFromGiftId(u40.GiftPurchaseID);
                                    end);
                                end;

                                if u40.SpecialCurrencyType and CurrencyData[u40.SpecialCurrencyType] then
                                    Main_Frame.Cost_Text.CurrencyImage.Image = CurrencyData[u40.SpecialCurrencyType].Icon;
                                    Frame2.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Image = CurrencyData[u40.SpecialCurrencyType].Icon;
                                else
                                    Main_Frame.Cost_Text.CurrencyImage.Visible = false;
                                    Frame2.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Visible = false;
                                end;

                                local function updateOptions() -- Line: 791
                                    -- upvalues: u1 (ref), u39 (copy), Frame2 (copy), FastTween (ref), u63 (copy)
                                    if u1 == u39 then
                                        Frame2.Visible = true;
                                        FastTween(Frame2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                            Position = UDim2.fromScale(0.5, 1.3)
                                        });
                                        FastTween(u63, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                            Size = UDim2.fromScale(0.13, 0.25)
                                        });

                                        return;
                                    end;

                                    Frame2.Visible = false;
                                    FastTween(Frame2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Position = UDim2.fromScale(0.5, 0.5)
                                    });
                                    FastTween(u63, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Size = UDim2.fromScale(0.13, 0.02)
                                    });
                                end;

                                u2:Connect(updateOptions);
                                task.spawn(updateOptions);
                                task.spawn(function() -- Line: 816
                                    -- upvalues: Main_Frame (copy), u37 (copy), u45 (copy), u39 (copy), u1 (ref), ScrollingFrame (ref), FastTween (ref), u2 (ref), UseDynamicPrices (ref), u40 (copy), Frame2 (copy), MarketController (ref), Comma_Module (ref)
                                    task.wait(0.5);
                                    local u73 = false;
                                    Main_Frame.Activated:Connect(function() -- Line: 835
                                        -- upvalues: u37 (ref), u45 (ref), u39 (ref), u1 (ref), Main_Frame (ref), ScrollingFrame (ref), FastTween (ref), u2 (ref), u73 (ref), UseDynamicPrices (ref), u40 (ref), Frame2 (ref), MarketController (ref), Comma_Module (ref)
                                        table.find(u37, u45);

                                        if workspace:GetAttribute("InTutorial") and not (workspace:GetAttribute("InTutorialShopMovement") or u39 == "Carrot" and u1 ~= u39) then
                                            return;
                                        end;

                                        local v74 = (Main_Frame.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y + (u45.AbsolutePosition.Y + u45.AbsoluteSize.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y)) / 2 - ScrollingFrame.AbsoluteSize.Y / 2;
                                        FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                                            CanvasPosition = Vector2.new(0, v74)
                                        });
                                        local v75;

                                        if u1 == u39 then
                                            v75 = nil;
                                        else
                                            v75 = u39;
                                        end;

                                        u1 = v75;
                                        u2:Fire();

                                        if not u73 then
                                            if UseDynamicPrices or u40.FallbackPrice == nil then
                                                if not UseDynamicPrices then
                                                    warn((`{Frame2:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                                end;

                                                MarketController:SetPriceLabel(Frame2.Robux_Buy.Price, u40.PurchaseID, ":robux::value:");
                                            else
                                                Frame2.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(u40.FallbackPrice)}`;
                                            end;

                                            u73 = true;
                                        end;
                                    end);
                                end);
                                local NumberValue = Instance.new("NumberValue");
                                NumberValue.Value = 0;
                                NumberValue.Parent = Frame2;
                                local v77 = NumberValue.Changed:Connect(function(p76: number) -- Line: 902
                                    -- upvalues: Main_Frame (copy), u8 (ref)
                                    if Main_Frame and (Main_Frame:FindFirstChild("Stock_Text") and not u8) then
                                        Main_Frame.Stock_Text.Text = `X{p76 // 1} Stock`;
                                    end;
                                end);
                                table.insert(u4, v77);
                                local u78 = true;

                                local function reorderTable(p79) -- Line: 914
                                    local v80 = {};

                                    for i2 in pairs(p79) do
                                        table.insert(v80, i2);
                                    end;

                                    table.sort(v80);
                                    local v81 = {};

                                    for i2, v2 in ipairs(v80) do
                                        v81[i2] = p79[v2];
                                    end;

                                    return v81;
                                end;

                                local function AdjustFrame(p82: string, p83: number) -- Line: 930
                                    -- upvalues: ScrollingFrame (ref), u13 (ref), u12 (ref), NumberUtil (ref)
                                    local v84 = `X{p83} Stock`;

                                    if not ScrollingFrame:FindFirstChild(p82) then
                                        return;
                                    end;

                                    local Main_Frame2 = ScrollingFrame:FindFirstChild(p82).Main_Frame;
                                    local Frame3 = ScrollingFrame:FindFirstChild(p82).Frame;
                                    Main_Frame2.Stock_Text.Text = v84;
                                    Frame3.Sheckles_Buy.In_Stock.Visible = p83 > 0;
                                    Frame3.Sheckles_Buy.No_Stock.Visible = p83 <= 0;
                                    Frame3.Sheckles_Buy.HoverImage = p83 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                                    Frame3.Sheckles_Buy.Image = p83 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                                    local v85 = Main_Frame2.Cost_Text:FindFirstChild("TEXT") or Main_Frame2.Cost_Text;

                                    if u13[u12.CurrentCategory][p82] then
                                        v85.Text = p83 <= 0 and "NO STOCK" or NumberUtil.DisplaySheckles(u13[u12.CurrentCategory][p82].Price);
                                    else
                                        v85.Text = "NO STOCK";
                                    end;

                                    local v86;

                                    if p83 <= 0 then
                                        v86 = Color3.fromRGB(255, 0, 0);
                                    else
                                        v86 = Color3.fromRGB(0, 255, 0);
                                    end;

                                    v85.TextColor3 = v86;
                                    Main_Frame2:SetAttribute("CurrentStock", p83);
                                end;

                                local function CreateFlash(p87: string, p88) -- Line: 966
                                    -- upvalues: ScrollingFrame (ref), Spring (ref)
                                    local v89 = ScrollingFrame:FindFirstChild(p87);

                                    if not v89 then
                                        return;
                                    end;

                                    local Main_Frame2 = v89.Main_Frame;
                                    local Frame3 = Instance.new("Frame");
                                    Frame3.Size = UDim2.new(0.98, 0, 0.98, 0);
                                    Frame3.Position = UDim2.new(0.5, 0, 0.5, 0);
                                    Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
                                    Frame3.Transparency = 0.4;
                                    Frame3.BackgroundColor3 = p88;
                                    Frame3.Parent = Main_Frame2;
                                    Spring.target(Frame3, 1, 1, {
                                        Transparency = 1
                                    });
                                    game:GetService("Debris"):AddItem(Frame3, 2);
                                end;

                                local function PlaySound(p90) -- Line: 984
                                    -- upvalues: Seed_Shop (ref)
                                    if Seed_Shop.Enabled then
                                        local Sound = Instance.new("Sound");
                                        Sound.SoundId = p90;
                                        Sound.Parent = game.Players.LocalPlayer.PlayerGui.ReplicatedAssets;
                                        Sound:Play();
                                        game:GetService("Debris"):AddItem(Sound, Sound.TimeLength);
                                    end;
                                end;

                                local function HoverToFrame(p91: string) -- Line: 994
                                    -- upvalues: ScrollingFrame (ref), Spring (ref)
                                    if not p91 then
                                        return;
                                    end;

                                    local Main_Frame2 = ScrollingFrame:FindFirstChild(p91).Main_Frame;

                                    if not Main_Frame2 then
                                        return;
                                    end;

                                    if not (ScrollingFrame and ScrollingFrame:IsA("ScrollingFrame")) then
                                        return;
                                    end;

                                    local v92 = Main_Frame2.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y;
                                    Spring.stop(ScrollingFrame);
                                    Spring.target(ScrollingFrame, 0.8, 3, {
                                        CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X, ScrollingFrame.CanvasPosition.Y + v92)
                                    });
                                end;

                                local function StockAnimation(u93: string, p94: any) -- Line: 1022
                                    -- upvalues: u11 (ref), u13 (ref), u12 (ref), DataService (ref), u9 (ref), u8 (ref), reorderTable (copy), AdjustFrame (copy), ScrollingFrame (ref), Seed_Shop (ref), SoundPlayer (ref), SoundData (ref), SeedData (ref), CreateFlash (copy)
                                    if table.find(u11, u93) then
                                        return;
                                    end;

                                    table.insert(u11, u13[u12.CurrentCategory][u93].LayoutOrder, u93);
                                    local Data = DataService:GetData();

                                    if u9 then
                                        task.cancel(u9);
                                        u8 = false;
                                    end;

                                    u9 = task.delay(0.05, function() -- Line: 1038
                                        -- upvalues: u8 (ref), reorderTable (ref), u11 (ref), Data (copy), AdjustFrame (ref), ScrollingFrame (ref), Seed_Shop (ref), SoundPlayer (ref), SoundData (ref), SeedData (ref), u93 (copy), CreateFlash (ref)
                                        if u8 then
                                            return;
                                        end;

                                        u8 = true;
                                        local u95 = reorderTable(u11);

                                        local function ResetStock() -- Line: 1046
                                            -- upvalues: u8 (ref), u11 (ref), u95 (copy), Data (ref), AdjustFrame (ref)
                                            u8 = false;
                                            table.clear(u11);

                                            for _, v2 in u95 do
                                                local v96 = Data;

                                                if v96 then
                                                    local Shop = Data.SeedStocks.Shop;
                                                    v96 = not Shop.Stocks[v2] and {
                                                        MaxStock = 0,
                                                        Stock = 0
                                                    } or Shop.Stocks[v2];
                                                end;

                                                AdjustFrame(v2, v96 and v96.Stock or 0);
                                            end;
                                        end;

                                        for i2, v2 in u95 do
                                            if ScrollingFrame:FindFirstChild(v2) then
                                                if u8 == false then
                                                    ResetStock();

                                                    return;
                                                end;

                                                local v97 = Data;

                                                if v97 then
                                                    local Shop = Data.SeedStocks.Shop;
                                                    v97 = not Shop.Stocks[v2] and {
                                                        MaxStock = 0,
                                                        Stock = 0
                                                    } or Shop.Stocks[v2];
                                                end;

                                                local v98 = v97 and v97.Stock or 0;
                                                local v99;

                                                if v98 > 0 then
                                                    v99 = i2;
                                                    local v100 = v2;

                                                    for i3 = 0, v98 do
                                                        AdjustFrame(v100, i3);

                                                        if Seed_Shop.Enabled then
                                                            SoundPlayer:PlaySound(SoundData.RestockAnimationSFX.Stock_Click);
                                                        end;

                                                        task.wait(0.05);

                                                        if u8 == false then
                                                            ResetStock();

                                                            return;
                                                        end;

                                                        local _ = i3;
                                                    end;

                                                    if Seed_Shop.Enabled then
                                                        SoundPlayer:PlaySound(SoundData.RestockAnimationSFX[SeedData[u93].SeedRarity or "Prismatic"]);
                                                    end;

                                                    CreateFlash(v100, Color3.fromRGB(24, 255, 0));
                                                else
                                                    if Seed_Shop.Enabled then
                                                        SoundPlayer:PlaySound(SoundData.RestockAnimationSFX.No_Restock);
                                                    end;

                                                    CreateFlash(v2, Color3.fromRGB(249, 0, 2));
                                                    AdjustFrame(v2, 0);
                                                    v99 = i2;
                                                end;

                                                if u8 == false then
                                                    ResetStock();

                                                    return;
                                                end;

                                                local v101 = 0.25 + (v99 - 1) * 0.02;
                                                task.wait(u8 and v101 and v101 or 0);
                                            end;
                                        end;
                                    end);
                                end;

                                local u102 = false;

                                local function updateStock(p103) -- Line: 1117
                                    -- upvalues: DataService (ref), CurrentCategory (copy), u39 (copy), u7 (ref), u10 (ref), u12 (ref), u102 (ref), Main_Frame (copy), u8 (ref), StockAnimation (copy), Frame2 (copy), u57 (ref), u78 (ref), u68 (ref), NumberValue (copy), Spr (ref), NPCLevelHandler (ref), u40 (copy), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
                                    local Data = DataService:GetData();
                                    local v104 = CurrentCategory or "Shop";
                                    local v105 = v104 == "Normal Seeds" and "Shop" or v104;
                                    local v106 = Data.SeedStocks[v105];

                                    if not v106 then
                                        return;
                                    end;

                                    if Data then
                                        if v106 then
                                            Data = v106.Stocks[u39];
                                        else
                                            Data = v106;
                                        end;
                                    end;

                                    local v107 = Data and Data.Stock or 0;

                                    if not u7[v105] then
                                        u7[v105] = {};
                                    end;

                                    if not u7[v105][u39] then
                                        u7[v105][u39] = v106.Seed;
                                    end;

                                    if p103 and (p103 == "SeedStocks" and (u7[v105][u39] ~= v106.Seed and (u10 and u10 == u12.CurrentCategory))) then
                                        u102 = true;
                                        local v108 = Main_Frame.Cost_Text:FindFirstChild("TEXT") or Main_Frame.Cost_Text;
                                        v108.Text = "NO STOCK";
                                        v108.TextColor3 = Color3.fromRGB(255, 0, 0);
                                        Main_Frame.Stock_Text.Text = "X0 Stock";
                                        task.spawn(function() -- Line: 1155
                                            -- upvalues: Main_Frame (ref)
                                            Main_Frame.Parent.Frame.Sheckles_Buy.In_Stock.Visible = false;
                                            Main_Frame.Parent.Frame.Sheckles_Buy.No_Stock.Visible = true;
                                            Main_Frame.Parent.Frame.Sheckles_Buy.HoverImage = "rbxassetid://138411009141674";
                                            Main_Frame.Parent.Frame.Sheckles_Buy.Image = "rbxassetid://104713419928195";
                                        end);

                                        if u8 then
                                            u8 = false;
                                            task.wait(0.15);
                                            StockAnimation(u39, p103);
                                        else
                                            StockAnimation(u39, p103);
                                        end;

                                        Main_Frame:SetAttribute("CurrentSeed", v106.Seed);
                                        u7[v105][u39] = v106.Seed;
                                        task.delay(0.05, function() -- Line: 1179
                                            -- upvalues: u102 (ref)
                                            u102 = false;
                                        end);
                                    elseif p103 == "SeedStocks" and (u7[v105][u39] == v106.Seed and not u102) then
                                        local v109 = `X{v107} Stock`;
                                        Main_Frame.Stock_Text.Text = v109;
                                        Frame2.Sheckles_Buy.In_Stock.Visible = v107 > 0;
                                        Frame2.Sheckles_Buy.No_Stock.Visible = v107 <= 0;
                                        Frame2.Sheckles_Buy.HoverImage = v107 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                                        Frame2.Sheckles_Buy.Image = v107 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                                        local v110 = Main_Frame.Cost_Text:FindFirstChild("TEXT") or Main_Frame.Cost_Text;
                                        v110.Text = v107 <= 0 and "NO STOCK" or u57;
                                        local v111;

                                        if v107 <= 0 then
                                            v111 = Color3.fromRGB(255, 0, 0);
                                        else
                                            v111 = Color3.fromRGB(0, 255, 0);
                                        end;

                                        v110.TextColor3 = v111;
                                    elseif not u102 then
                                        if u78 or not u68 then
                                            u78 = false;
                                            NumberValue.Value = v107;
                                        else
                                            Spr.target(NumberValue, 1, 1.5, {
                                                Value = v107
                                            });
                                        end;

                                        local v112 = `X{v107} Stock`;
                                        Main_Frame.Stock_Text.Text = v112;
                                        Frame2.Sheckles_Buy.In_Stock.Visible = v107 > 0;
                                        Frame2.Sheckles_Buy.No_Stock.Visible = v107 <= 0;
                                        Frame2.Sheckles_Buy.HoverImage = v107 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                                        Frame2.Sheckles_Buy.Image = v107 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                                        local v113 = Main_Frame.Cost_Text:FindFirstChild("TEXT") or Main_Frame.Cost_Text;
                                        v113.Text = v107 <= 0 and "NO STOCK" or u57;
                                        local v114;

                                        if v107 <= 0 then
                                            v114 = Color3.fromRGB(255, 0, 0);
                                        else
                                            v114 = Color3.fromRGB(0, 255, 0);
                                        end;

                                        v113.TextColor3 = v114;
                                    end;

                                    local v115 = not NPCLevelHandler:HasRequiredNPCLevels(u40.LevelLocks);

                                    if v115 and u40.LevelLocks then
                                        local v116 = next(u40.LevelLocks);
                                        local v117 = v116 and u40.LevelLocks[v116] or 1;
                                        Main_Frame.LockedFrame.Visible = true;
                                        Main_Frame.LockedFrame.UnlockInfo.Text = `NPC Friend Level Needed: lvl{v117}`;
                                    else
                                        Main_Frame.LockedFrame.Visible = false;
                                    end;

                                    local v118 = Main_Frame.Cost_Text:FindFirstChild("TEXT") or Main_Frame.Cost_Text;

                                    if v115 and u40.LevelLocks then
                                        local v119 = next(u40.LevelLocks);
                                        v118.Text = `LOCKED: lvl{v119 and u40.LevelLocks[v119] or 1}+`;
                                        v118.TextColor3 = Color3.fromRGB(255, 0, 0);
                                    end;

                                    if Main_Frame.Cost_Text:FindFirstChild("CurrencyImage") and u40.SpecialCurrencyType then
                                        Main_Frame.Cost_Text.CurrencyImage.Visible = v107 > 0;
                                    end;

                                    if RebirthUnlocksSharedService:HasUnlockedShopItem(LocalPlayer, "Seed", u39) then
                                        Main_Frame.LockedFrame.Visible = false;
                                        Main_Frame.Interactable = true;

                                        return;
                                    end;

                                    Main_Frame.LockedFrame.Visible = true;
                                    Main_Frame.Interactable = false;
                                    Main_Frame.LockedFrame.UnlockInfo.Text = `Ascensions Required: {RebirthUnlocksSharedService:GetRemainingRebirthsNeededForItem(LocalPlayer, "Seed", u39)}`;
                                end;

                                task.spawn(updateStock);
                                task.spawn(function() -- Line: 1297
                                    -- upvalues: DataService (ref), updateStock (copy), u4 (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
                                    local PathSignal = DataService:GetPathSignal("SeedStocks/@");

                                    if PathSignal then
                                        local v120 = PathSignal:Connect(updateStock);
                                        table.insert(u4, v120);
                                    end;

                                    local PathSignal2 = DataService:GetPathSignal("SeedStocks");

                                    if PathSignal2 then
                                        local v121 = PathSignal2:Connect(updateStock);
                                        table.insert(u4, v121);
                                    end;

                                    task.spawn(function() -- Line: 1310
                                        -- upvalues: DataService (ref), updateStock (ref), u4 (ref)
                                        local PathSignal3 = DataService:GetPathSignal("NPCPoints/@");

                                        if PathSignal3 then
                                            local v122 = PathSignal3:Connect(updateStock);
                                            table.insert(u4, v122);
                                        end;
                                    end);
                                    local v123 = RebirthUnlocksSharedService:HasBeenAssignedABTest(LocalPlayer) and DataService:GetPathSignal("RebirthData/TotalRebirths");

                                    if v123 then
                                        local v124 = v123:Connect(updateStock);
                                        table.insert(u4, v124);
                                    end;
                                end);
                            end;
                        end;

                        break;
                    else
                        break;
                    end;
                end;
            end;
        end;
    end;

    table.sort(u37, function(p125, p126) -- Line: 1328
        local LayoutOrder = p125.LayoutOrder;
        local LayoutOrder2 = p126.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p125.Name < p126.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);
end;

local function UnlockTabVisibility() -- Line: 1338
    -- upvalues: u14 (copy), ShopTabHandler (copy), u12 (copy)
    for _, v in u14 do
        local v127 = ShopTabHandler:IsTabUnlocked("Seed", v.Name);

        if v.IsLocked and v127 then
            u12.UnlockTab(v.Name);
        end;
    end;
end;

local function SetupTabs() -- Line: 1351
    -- upvalues: DataService (copy), rebuildTabsForContext (copy), UnlockTabVisibility (copy)
    if DataService:GetData().FirstTimeUser then
        return;
    end;

    rebuildTabsForContext();
    UnlockTabVisibility();
end;

u12.OnCategoryChanged:Connect(function(u128: string) -- Line: 1363, Name: OnTabSelected
    -- upvalues: u15 (copy), ReplicatedStorage (copy), Seed_Shop (copy), Daily (copy), Frame (copy), SetupFrames (copy), u1 (ref), u2 (copy), UpdateRefreshLabel (copy)
    if u15[u128] then
        local EventShopUIController = require(ReplicatedStorage.Modules.EventShopUIController);
        require(ReplicatedStorage.Modules.GuiController):Close(Seed_Shop);
        task.defer(function() -- Line: 1369
            -- upvalues: EventShopUIController (copy), u15 (ref), u128 (copy)
            EventShopUIController:Open(u15[u128]);
        end);

        return;
    end;

    if u128 == "Daily Deals" then
        Daily.Visible = true;
        Frame.Visible = false;
    else
        Daily.Visible = false;
        Frame.Visible = true;
        SetupFrames();
    end;

    u1 = nil;
    u2:Fire();
    task.spawn(UpdateRefreshLabel);
end);
local u129 = {
    Enum.AdAvailabilityResult.PlayerIneligible,
    Enum.AdAvailabilityResult.DeviceIneligible,
    Enum.AdAvailabilityResult.PublisherIneligible,
    Enum.AdAvailabilityResult.ExperienceIneligible
};

local function isIneligible(p130) -- Line: 1402
    -- upvalues: u129 (copy)
    for _, v in ipairs(u129) do
        if p130 == v then
            return true;
        end;
    end;

    return false;
end;

function checkForAds()
    -- upvalues: Seed_Shop (copy)
    Seed_Shop.Frame.Frame.RewardAd.Visible = false;
end;

Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1441
    -- upvalues: Seed_Shop (copy)
    Seed_Shop.Frame.Frame.RewardAd.Visible = false;

    if Seed_Shop.Enabled then
        checkForAds();
    end;
end);
Seed_Shop.Frame.Frame.RewardAd.SENSOR.Activated:Connect(function() -- Line: 1448
    -- upvalues: Seed_Shop (copy), RewardedAdEvent (copy)
    Seed_Shop.Frame.Frame.RewardAd.Visible = false;
    RewardedAdEvent:FireServer();
end);
RewardedAdEvent.OnClientEvent:Connect(function(p131: boolean, p132: any) -- Line: 1453
    if p132 == Enum.ShowAdResult.ShowCompleted then
        checkForAds();
    end;
end);
Seed_Shop.Frame.Frame.Odds.SENSOR.Activated:Connect(function() -- Line: 1463, Name: OpenStockOdds
    -- upvalues: ReplicatedStorage (copy), u13 (copy), u12 (copy), u3 (copy), Seed_Shop (copy)
    local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
    local v133 = {};

    for i, v in u13[u12.CurrentCategory] or u13.Shop do
        local v134 = u3[i];

        if v134 and v.StockChance then
            table.insert(v133, {
                Reward = {
                    Type = "Seed",
                    Quantity = 1,
                    Value = i
                },
                Weight = 1 / v.StockChance,
                ShopLayoutOrder = v134.LayoutOrder
            });
        end;
    end;

    if #v133 == 0 then
        return;
    end;

    local u135 = {};
    GenericRewardsUIController:Open({
        Title = "Stock Odds",
        DisplayOdds = true,
        Disclaimer = "PRESETS/RoundedOddsCompliance",
        RewardData = v133,
        Breadcrumb = Seed_Shop,
        HeaderColor = Color3.fromRGB(92, 175, 68),

        RewardFrameCreatedCallback = function(p136, p137) -- Line: 1499, Name: RewardFrameCreatedCallback
            -- upvalues: u135 (copy)
            u135[p136] = p137.ShopLayoutOrder;
        end,

        RewardsUIBuiltCallback = function() -- Line: 1502, Name: RewardsUIBuiltCallback
            -- upvalues: u135 (copy)
            for i, v in u135 do
                i.LayoutOrder = v;
            end;
        end
    });
end);
local Odds = Seed_Shop.Frame.Frame.Odds;
local RewardAd = Seed_Shop.Frame.Frame.RewardAd;
local Position = Odds.Position;
RewardAd:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1518, Name: UpdateOddsPosition
    -- upvalues: RewardAd (copy), Odds (copy), Position (copy)
    if RewardAd.Visible then
        Odds.Position = Position;

        return;
    end;

    Odds.Position = UDim2.new(RewardAd.Position.X.Scale + RewardAd.Size.X.Scale * (0.5 - RewardAd.AnchorPoint.X), 0, Position.Y.Scale, Position.Y.Offset);
end);

if RewardAd.Visible then
    Odds.Position = Position;
else
    Odds.Position = UDim2.new(RewardAd.Position.X.Scale + RewardAd.Size.X.Scale * (0.5 - RewardAd.AnchorPoint.X), 0, Position.Y.Scale, Position.Y.Offset);
end;

function v6.Start(p138) -- Line: 1531
    -- upvalues: GuiController (copy), Seed_Shop (copy), RewardedAdEvent (copy), DevProductIds (copy), MarketController (copy), u10 (ref), u12 (copy), PolicyService (copy), LocalPlayer (copy), UpdateService (copy), SetupFrames (copy), DataService (copy), rebuildTabsForContext (copy), UnlockTabVisibility (copy), SetupTimer (copy)
    GuiController:UsePopupAnims(Seed_Shop);
    Seed_Shop.Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 1534
        -- upvalues: GuiController (ref), Seed_Shop (ref)
        GuiController:Close(Seed_Shop);
    end);
    RewardedAdEvent.OnClientEvent:Connect(function(p139: boolean, p140: any) -- Line: 1539
        if p140 == Enum.ShowAdResult.ShowCompleted then
            checkForAds();
        end;
    end);
    local Restock = Seed_Shop.Frame.Frame.Restock;
    local u141 = false;
    Restock.Activated:Connect(function() -- Line: 1549
        -- upvalues: u141 (ref), DevProductIds (ref), MarketController (ref), u10 (ref), u12 (ref)
        if u141 then
            return;
        end;

        MarketController:PromptPurchase(DevProductIds.SeedShopRestock.PurchaseID, Enum.InfoType.Product);
        u10 = u12.CurrentCategory;
    end);
    task.spawn(function() -- Line: 1557
        -- upvalues: PolicyService (ref), LocalPlayer (ref), u141 (ref), Restock (copy)
        local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

        if PolicyInfoForPlayerAsync then
            PolicyInfoForPlayerAsync = PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted;
        end;

        u141 = PolicyInfoForPlayerAsync == true;
        Restock.Visible = not u141;
    end);

    if not UpdateService:IsUpdateDone() then
        task.delay(UpdateService:GetRemainingTimeUntilUpdate() + 1, function() -- Line: 1564
            -- upvalues: SetupFrames (ref)
            SetupFrames();
        end);
    end;

    UpdateService.OnUpdated:Connect(function() -- Line: 1569
        -- upvalues: DataService (ref), rebuildTabsForContext (ref), UnlockTabVisibility (ref)
        if DataService:GetData().FirstTimeUser then
            return;
        end;

        rebuildTabsForContext();
        UnlockTabVisibility();
    end);

    if UpdateService:IsHiddenFromUpdate("Seed Shop Tabs") then
        task.delay(UpdateService:GetRemainingTimeUntilUpdate(), function() -- Line: 1574
            -- upvalues: UpdateService (ref), DataService (ref), rebuildTabsForContext (ref), UnlockTabVisibility (ref)
            if UpdateService:IsUpdateDone() or workspace:GetServerTimeNow() >= UpdateService:GetUpdateTime() then
                if DataService:GetData().FirstTimeUser then
                    return;
                end;

                rebuildTabsForContext();
                UnlockTabVisibility();
            end;
        end);
    elseif not DataService:GetData().FirstTimeUser then
        rebuildTabsForContext();
        UnlockTabVisibility();
    end;

    task.spawn(SetupTimer);
    SetupFrames();
    task.spawn(function() -- Line: 1586
        -- upvalues: DataService (ref), UnlockTabVisibility (ref)
        local PathSignal = DataService:GetPathSignal("ShopTabData/@");

        if PathSignal then
            PathSignal:Connect(UnlockTabVisibility);
        end;
    end);
end;

function v6.Redraw(p142) -- Line: 1594
    -- upvalues: SetupFrames (copy)
    SetupFrames();
end;

task.spawn(v6.Start, v6);
ReplicatedStorage.GameEvents.ABTestingEvents.ReSetupShopFrames.Event:Connect(function() -- Line: 1605
    -- upvalues: SetupFrames (copy)
    task.wait(1);
    SetupFrames();
end);

return v6;