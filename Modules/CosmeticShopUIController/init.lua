-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("ContentProvider");
game:GetService("TweenService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Modules.Signal);
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
require(ReplicatedStorage.Modules.CountDictionary);
require(ReplicatedStorage.Modules.FastTween);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.GiftController);
local CosmeticShopConfigData = require(ReplicatedStorage.Data.CosmeticShopConfigData);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Modules.DumpTable);
local DecimalNumberFormat = require(ReplicatedStorage.Data.DecimalNumberFormat);
local Notification = require(ReplicatedStorage.Modules.Notification);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
require(ReplicatedStorage.Data.CosmeticItemShopData);
require(ReplicatedStorage.Data.CosmeticCrateShopData);
local CosmeticShopTabData = require(ReplicatedStorage.Data.CosmeticShopTabData);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local Frame_Popup_Module = require(ReplicatedStorage.Frame_Popup_Module);
require(ReplicatedStorage.Modules.UseDynamicPrices);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local UITabHelperModule = require(ReplicatedStorage.Modules.UITabHelperModule);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local CosmeticShop_UI = PlayerGui:WaitForChild("CosmeticShop_UI");
local Frame = CosmeticShop_UI:FindFirstChild("Frame", true);
local Cosmetics = Frame:FindFirstChild("Cosmetics", true);
local Fences = Frame:FindFirstChild("Fences", true);
local RegularCosmeticsContainer = Cosmetics:FindFirstChild("RegularCosmeticsContainer", true);
local DailyCrateContainer = Cosmetics:FindFirstChild("DailyCrateContainer", true);
local script_BlueCosmeticTemplate = script.BlueCosmeticTemplate;
local script_GreenCosmeticTemplate = script.GreenCosmeticTemplate;
local script_FenceCosmeticTemplate = script.FenceCosmeticTemplate;
local FenceTimer = Frame:FindFirstChild("FenceTimer", true);
local ExitButton = Frame:FindFirstChild("ExitButton", true);
local Restock = Frame:FindFirstChild("Restock", true);
local Odds = Frame:FindFirstChild("Odds", true);
local TabList = CosmeticShop_UI:FindFirstChild("TabAnchor", true):FindFirstChild("TabList", true);
local ShowCrateOdds = PlayerGui:WaitForChild("ShowCrateOdds");
local u2 = WaitForDescendant(ShowCrateOdds, "CrateChanceDetails");
local u3 = WaitForDescendant(ShowCrateOdds, "CrateItemTemplate");
local u4 = WaitForDescendant(ShowCrateOdds, "HeaderTitle");
local u5 = WaitForDescendant(ShowCrateOdds, "ExitButton");
local TabButtonTemplate = ReplicatedStorage.UITemplates:WaitForChild("TabButtonTemplate");
local u6 = UITabHelperModule.CreateOrGetTabHandler("CosmeticShop", TabList, TabButtonTemplate);
u6.DefaultCategory = "Cosmetics";
u6.CurrentCategory = "Cosmetics";
local u7 = false;
local u8 = {};
local u9 = false;
local u10 = nil;

local function formatCosmeticTabForUpdate(p11: string) -- Line: 96
    return `Cosmetic Tab {p11}`;
end;

local function plrOwnsFence(p12: string) -- Line: 100
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if not Data then
        return false;
    end;

    local FenceSkinData = Data.FenceSkinData;

    if not FenceSkinData then
        return false;
    end;

    local OwnedFences = FenceSkinData.OwnedFences;

    if OwnedFences then
        return OwnedFences[p12] == true;
    end;

    return false;
end;

local function getRefreshTime() -- Line: 114
    -- upvalues: DataService (copy), CosmeticShopConfigData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local v13 = Data.CosmeticStock.ForcedCosmeticEndTimestamp and (Data.CosmeticStock.ForcedCosmeticEndTimestamp - ServerTimeNow or -1) or -1;

    if v13 >= 0 then
        return v13;
    end;

    return CosmeticShopConfigData.RefreshTime - ServerTimeNow % CosmeticShopConfigData.RefreshTime;
end;

local function DisplayCrateOdds(p14) -- Line: 126
    -- upvalues: CosmeticCrates (copy), u4 (copy), u2 (copy), u3 (copy), CosmeticList (copy), DecimalNumberFormat (copy), ShowCrateOdds (copy), Frame_Popup_Module (copy)
    local v15 = CosmeticCrates[p14];
    local Items = v15.CosmeticRolls.Items;
    local v16 = v15.Color:ToHex();
    u4.Text = string.format("<font color=\"%s\">%s</font> Chances", v16, p14);

    for _, child in u2:GetChildren() do
        if child:IsA("Frame") and child.Visible then
            child:Destroy();
        end;
    end;

    for i, v in Items do
        local v17 = u3:Clone();
        v17.Parent = u2;
        v17.Visible = true;

        if CosmeticList[i] and CosmeticList[i].Icon then
            v17.Detail.CrateImageLabel.Image = CosmeticList[i].Icon;
            v17.Detail.CrateImageLabel.Visible = true;
        end;

        v17.CrateChance.Text = `{DecimalNumberFormat(v.NormalizedOdd)}%`;
        v17.LayoutOrder = 100 / v.NormalizedOdd;
        v17.CrateName.Text = i;
    end;

    ShowCrateOdds.Enabled = true;
    Frame_Popup_Module.Show(ShowCrateOdds);
end;

local function DisplayPurchaseNotification(p18: table, p19: number?, p20: number?) -- Line: 161
    -- upvalues: Notification (copy)
    for _, v in p18 do
        Notification:CreateNotification(v, nil, p19);

        if p20 then
            task.wait(p20);
        end;
    end;
end;

local function SetupCosmeticItemFrame(u21: any, u22: any, u23: any, u24: boolean?) -- Line: 170
    -- upvalues: u10 (ref), CosmeticCrateOddsController (copy), CosmeticShop_UI (copy), CosmeticCrates (copy), FenceSkinRegistry (copy), CosmeticList (copy), Item_Module (copy), ColorHelper (copy), NumberUtil (copy), u7 (ref), ReplicatedStorage (copy), u6 (copy), DataService (copy), DisplayPurchaseNotification (copy), UpdateService (copy)
    local v25 = nil;

    if not u23 then
        return;
    end;

    local u26 = u23.FenceName ~= nil;

    if u24 then
        v25 = u23.CrateName;
        local OddsButton = u21:FindFirstChild("OddsButton");

        if OddsButton then
            OddsButton.Visible = true;

            if u10 then
                u10:Disconnect();
            end;

            u10 = OddsButton.Activated:Connect(function() -- Line: 188
                -- upvalues: CosmeticCrateOddsController (ref), u23 (copy), CosmeticShop_UI (ref)
                CosmeticCrateOddsController:Open(u23.CrateName, CosmeticShop_UI);
            end);
        end;
    elseif not u26 then
        v25 = u23.CosmeticName;
    end;

    local v27;

    if u24 then
        v27 = CosmeticCrates[v25];
    elseif u26 then
        v27 = FenceSkinRegistry[u22];
        v25 = v27.DisplayName;
    else
        v27 = CosmeticList[v25];
    end;

    u21:FindFirstChild("Title", true).Text = v25;
    local Rarity_BG = u21:FindFirstChild("Rarity_BG", true);
    local Rarity_Text = Rarity_BG:FindFirstChild("Rarity_Text", true);
    local v28 = Item_Module.Return_Rarity_Data(u24 and u23.CrateRarity or v27.Rarity);

    if v28 then
        local v29 = v28[2];
        local _ = v28[3];
        Rarity_Text.Text = v28[1];
        Rarity_BG.ImageColor3 = v29;
        Rarity_Text.UIStroke.Color = ColorHelper:Darken(v29);
    end;

    local Vector = u21:FindFirstChild("Vector", true);

    if u26 then
        Vector.Image = "rbxassetid://" .. v27.Icon;
    else
        Vector.Image = v27.Icon;
    end;

    local CashBuy = u21:FindFirstChild("CashBuy", true);
    CashBuy:FindFirstChild("Label", true).Text = NumberUtil.DisplaySheckles(u23.Price);
    CashBuy.Activated:Connect(function() -- Line: 239
        -- upvalues: u22 (copy), u7 (ref), u24 (copy), ReplicatedStorage (ref), u6 (ref), u26 (copy), u23 (copy), DataService (ref), DisplayPurchaseNotification (ref)
        if workspace:GetAttribute("InTutorial") and u22 ~= "Carrot" or u7 then
            return;
        end;

        u7 = true;

        if u24 then
            ReplicatedStorage.GameEvents.BuyCosmeticCrate:FireServer(u22, u6.CurrentCategory);
        elseif u26 then
            local FenceName = u23.FenceName;
            local Data = DataService:GetData();
            local v30;

            if Data then
                local FenceSkinData = Data.FenceSkinData;

                if FenceSkinData then
                    local OwnedFences = FenceSkinData.OwnedFences;

                    if OwnedFences then
                        v30 = OwnedFences[FenceName] == true;
                    else
                        v30 = false;
                    end;
                else
                    v30 = false;
                end;
            else
                v30 = false;
            end;

            if v30 then
                ReplicatedStorage.GameEvents.BuyCosmeticItem:FireServer(u22, u6.CurrentCategory);
            else
                ReplicatedStorage.GameEvents.BuyCosmeticShopFence:FireServer(u22, u6.CurrentCategory);
            end;
        else
            ReplicatedStorage.GameEvents.BuyCosmeticItem:FireServer(u22, u6.CurrentCategory);
        end;

        if u23.PurchaseNotification then
            task.spawn(function() -- Line: 254
                -- upvalues: DisplayPurchaseNotification (ref), u23 (ref)
                task.wait(1);
                DisplayPurchaseNotification(u23.PurchaseNotification, 10, 1.5);
            end);
        end;

        task.wait(0.5);
        u7 = false;
    end);

    if u23.LayoutOrder then
        u21.LayoutOrder = u23.LayoutOrder;
    end;

    task.spawn(function() -- Line: 268, Name: updateStock
        -- upvalues: DataService (ref), u24 (copy), u6 (ref), u26 (copy), u22 (copy), u21 (copy), u23 (copy), CashBuy (copy)
        local Data = DataService:GetData();
        local v31;

        if u24 then
            v31 = Data.CosmeticStock.TabStocks[u6.CurrentCategory].CrateStocks;
        elseif u26 then
            v31 = Data.CosmeticStock.TabStocks[u6.CurrentCategory].FenceStocks;
        else
            v31 = Data.CosmeticStock.TabStocks[u6.CurrentCategory].ItemStocks;
        end;

        if Data then
            Data = v31[u22];
        end;

        local v32 = Data and Data.Stock or 0;
        local v33 = v32 > 0;
        local StockTxt = u21:FindFirstChild("StockTxt", true);
        local UIStroke = StockTxt:FindFirstChild("UIStroke", true);

        if not UIStroke:GetAttribute("OriginalColor") then
            UIStroke:SetAttribute("OriginalColor", UIStroke.Color);
        end;

        if u26 then
            local FenceName = u23.FenceName;
            local Data2 = DataService:GetData();
            local v34;

            if Data2 then
                local FenceSkinData = Data2.FenceSkinData;

                if FenceSkinData then
                    local OwnedFences = FenceSkinData.OwnedFences;

                    if OwnedFences then
                        v34 = OwnedFences[FenceName] == true;
                    else
                        v34 = false;
                    end;
                else
                    v34 = false;
                end;
            else
                v34 = false;
            end;

            StockTxt.Text = v34 and "OWNED" or "UNOWNED";
            StockTxt.TextColor3 = v34 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0);
            local FenceName2 = u23.FenceName;
            local Data3 = DataService:GetData();
            local v35;

            if Data3 then
                local FenceSkinData = Data3.FenceSkinData;

                if FenceSkinData then
                    local OwnedFences = FenceSkinData.OwnedFences;

                    if OwnedFences then
                        v35 = OwnedFences[FenceName2] == true;
                    else
                        v35 = false;
                    end;
                else
                    v35 = false;
                end;
            else
                v35 = false;
            end;

            CashBuy.Active = not v35;
        else
            StockTxt.Text = v33 and `X{v32} Stock` or "NO STOCK";
            StockTxt.TextColor3 = v33 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 56, 83);
            StockTxt.UIStroke.Color = v33 and UIStroke:GetAttribute("OriginalColor") or Color3.fromRGB(0, 0, 0);
        end;

        if u26 then
            local FenceName = u23.FenceName;
            local Data2 = DataService:GetData();
            local v36;

            if Data2 then
                local FenceSkinData = Data2.FenceSkinData;

                if FenceSkinData then
                    local OwnedFences = FenceSkinData.OwnedFences;

                    if OwnedFences then
                        v36 = OwnedFences[FenceName] == true;
                    else
                        v36 = false;
                    end;
                else
                    v36 = false;
                end;
            else
                v36 = false;
            end;

            v33 = not v36;
        end;

        CashBuy.BackgroundColor3 = v33 and Color3.fromRGB(255, 204, 0) or Color3.fromRGB(100, 100, 100);
        CashBuy.UIStroke.Color = v33 and Color3.fromRGB(150, 116, 31) or Color3.fromRGB(60, 60, 60);
        CashBuy.Label.UIStroke.Color = v33 and Color3.fromRGB(122, 81, 0) or Color3.fromRGB(60, 60, 60);
    end);

    if UpdateService:IsHiddenFromUpdate(v25) then
        u21.Visible = false;
        task.delay(UpdateService:GetRemainingTimeUntilUpdate(), function() -- Line: 312
            -- upvalues: u21 (copy)
            u21.Visible = true;
        end);
    end;
end;

local function setupFrames() -- Line: 318
    -- upvalues: u8 (copy), DataService (copy), UpdateService (copy), u6 (copy), CosmeticShopTabData (copy), SetupCosmeticItemFrame (copy), DailyCrateContainer (copy), CosmeticList (copy), script_GreenCosmeticTemplate (copy), RegularCosmeticsContainer (copy), script_BlueCosmeticTemplate (copy), script_FenceCosmeticTemplate (copy), Fences (copy)
    for _, v in u8 do
        v:Destroy();
    end;

    local v37 = {};
    local Data = DataService:GetData();

    if not UpdateService:IsHiddenFromUpdate("Cosmetic Tab Fences") or u6.CurrentCategory == u6.DefaultCategory then
        local v38 = Data.CosmeticStock.TabStocks[u6.CurrentCategory];

        if not v38 then
            return;
        end;

        local ItemStocks = v38.ItemStocks;
        local FenceStocks = v38.FenceStocks;

        if not CosmeticShopTabData.Tabs[u6.CurrentCategory] then
            return;
        end;

        for i, _ in pairs(v38.CrateStocks) do
            SetupCosmeticItemFrame(DailyCrateContainer.DailyCrateTemplate, i, CosmeticShopTabData.Tabs[u6.CurrentCategory].Crates[i], true);
        end;

        for i, _ in pairs(ItemStocks) do
            local v39 = CosmeticShopTabData.Tabs[u6.CurrentCategory].Items[i];
            local v40 = CosmeticList[i];
            local v41;

            if v40.Rarity == "Common" or v40.Rarity == "Uncommon" then
                v41 = script_GreenCosmeticTemplate:Clone();
                v41.Parent = RegularCosmeticsContainer.Green;
            else
                v41 = script_BlueCosmeticTemplate:Clone();
                v41.Parent = RegularCosmeticsContainer.Blue;
            end;

            u8[i] = v41;
            v41.Name = i;
            table.insert(v37, v41);
            SetupCosmeticItemFrame(v41, i, v39);
        end;

        for i, _ in pairs(FenceStocks) do
            local v42 = CosmeticShopTabData.Tabs[u6.CurrentCategory].Fences[i];
            local v43 = script_FenceCosmeticTemplate:Clone();
            v43.Parent = Fences.Green;
            u8[i] = v43;
            v43.Name = i;
            table.insert(v37, v43);
            SetupCosmeticItemFrame(v43, i, v42);
        end;
    end;

    table.sort(v37, function(p44, p45) -- Line: 390
        local LayoutOrder = p44.LayoutOrder;
        local LayoutOrder2 = p45.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p44.Name < p45.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);

    if not UpdateService:IsHiddenFromUpdate("Cosmetic Shop Tabs") then
        u6.RebuildCategoryList();
    end;
end;

local function buildStockOddsData() -- Line: 410
    -- upvalues: CosmeticShopTabData (copy), u6 (copy), DataService (copy), UpdateService (copy), CosmeticList (copy)
    local v46 = CosmeticShopTabData.Tabs[u6.CurrentCategory];

    if not v46 then
        return {};
    end;

    local Data = DataService:GetData();
    local v47 = Data and (Data.CosmeticStock and Data.CosmeticStock.PermanentPurchases) or {};

    local function isHidden(p48: string) -- Line: 422
        -- upvalues: UpdateService (ref)
        return UpdateService:IsHiddenFromUpdate(p48) or UpdateService:IsHiddenAfterUpdate(p48);
    end;

    local v49 = {};
    local v50 = {};
    local v51 = {};
    local v52 = {};
    local v53 = {};

    for i, v in v46.Crates or {} do
        if not v.RobuxOnly then
            local CrateName = v.CrateName;

            if not (UpdateService:IsHiddenFromUpdate(CrateName) or UpdateService:IsHiddenAfterUpdate(CrateName)) then
                table.insert(v49, i);
            end;
        end;
    end;

    for i, v in v46.Items or {} do
        local v54 = CosmeticList[i];

        if v54 and not (UpdateService:IsHiddenFromUpdate(i) or UpdateService:IsHiddenAfterUpdate(i)) then
            if v.PermanentUntilPurchase then
                if (v47[i] or 0) < (v.LifetimeLimit or 1) then
                    table.insert(v51, i);
                end;
            elseif v54.Rarity == "Common" or v54.Rarity == "Uncommon" then
                table.insert(v52, i);
            else
                table.insert(v50, i);
            end;
        end;
    end;

    for i, v in v46.Fences or {} do
        if not (v.PermanentUntilPurchase or (UpdateService:IsHiddenFromUpdate(i) or UpdateService:IsHiddenAfterUpdate(i))) then
            table.insert(v53, i);
        end;
    end;

    local u55 = {};

    local function addPool(p56: table, p57: number, p58: string) -- Line: 461
        -- upvalues: u55 (copy)
        if #p56 == 0 or p57 <= 0 then
            return;
        end;

        local v59 = math.min(p57, #p56) / #p56;

        for _, v in p56 do
            table.insert(u55, {
                Reward = {
                    Quantity = 1,
                    Type = p58,
                    Value = v
                },
                Weight = v59
            });
        end;
    end;

    addPool(v49, 1, "Crate");
    addPool(v51, 1, "Cosmetic");
    addPool(v50, #v51 > 0 and 1 or 2, "Cosmetic");
    addPool(v52, 4, "Cosmetic");
    addPool(v53, 3, "Fences");

    return u55;
end;

local function openStockOdds() -- Line: 484
    -- upvalues: ReplicatedStorage (copy), buildStockOddsData (copy), CosmeticShop_UI (copy), Odds (copy)
    local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
    local v60 = buildStockOddsData();

    if #v60 == 0 then
        return;
    end;

    GenericRewardsUIController:Open({
        Title = "Stock Odds",
        DisplayOdds = true,
        RewardData = v60,
        Breadcrumb = CosmeticShop_UI,
        HeaderColor = Odds.BackgroundColor3,
        Disclaimer = GenericRewardsUIController.RoundedOddsDisclaimer(v60)
    });
end;

local function onTabSelected(p61: string) -- Line: 502
    -- upvalues: Cosmetics (copy), Fences (copy), setupFrames (copy)
    Cosmetics.Visible = p61 == "Cosmetics";
    Fences.Visible = p61 == "Fences";
    setupFrames();
end;

local function setupTabs() -- Line: 509
    -- upvalues: u6 (copy)
    u6.SetCategories({ {
            Name = "Cosmetics",
            IsLocked = false
        }, {
            Name = "Fences",
            IsLocked = false
        } });
    u6.DefaultCategory = "Cosmetics";
    u6.SetCurrentCategory(u6.DefaultCategory);
end;

function v1.Start(p62) -- Line: 520
    -- upvalues: DataService (copy), CosmeticShopConfigData (copy), FenceTimer (copy), Notification (copy), NumberUtil (copy), ExitButton (copy), GuiController (copy), CosmeticShop_UI (copy), Restock (copy), u9 (ref), DevProductIds (copy), MarketController (copy), PolicyService (copy), LocalPlayer (copy), Odds (copy), openStockOdds (copy), u5 (copy), ShowCrateOdds (copy), setupFrames (copy), setupTabs (copy), u6 (copy), onTabSelected (copy), Cosmetics (copy), Fences (copy)
    task.spawn(function() -- Line: 521
        -- upvalues: DataService (ref), CosmeticShopConfigData (ref), FenceTimer (ref), Notification (ref), NumberUtil (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local Data = DataService:GetData();
            local v63 = Data.CosmeticStock.ForcedCosmeticEndTimestamp and (Data.CosmeticStock.ForcedCosmeticEndTimestamp - ServerTimeNow or -1) or -1;

            if v63 < 0 then
                v63 = CosmeticShopConfigData.RefreshTime - ServerTimeNow % CosmeticShopConfigData.RefreshTime;
            end;

            if v63 <= 1 then
                FenceTimer.Text = "Restocking";
                Notification:CreateNotification("Your Cosmetic Shop stock has been reset!");
            else
                FenceTimer.Text = "RESETS IN: " .. NumberUtil.compactFormat(v63);
            end;

            task.wait(1);
        end;
    end);
    ExitButton.Activated:Connect(function() -- Line: 535
        -- upvalues: GuiController (ref), CosmeticShop_UI (ref)
        GuiController:Close(CosmeticShop_UI);
        CosmeticShop_UI.Enabled = false;
    end);
    Restock.Activated:Connect(function() -- Line: 540
        -- upvalues: u9 (ref), DevProductIds (ref), MarketController (ref)
        if u9 then
            return;
        end;

        MarketController:PromptPurchase(DevProductIds.CosmeticShopRestock.PurchaseID, Enum.InfoType.Product);
    end);
    task.spawn(function() -- Line: 547
        -- upvalues: PolicyService (ref), LocalPlayer (ref), u9 (ref), Restock (ref)
        local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

        if PolicyInfoForPlayerAsync then
            PolicyInfoForPlayerAsync = PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted;
        end;

        u9 = PolicyInfoForPlayerAsync == true;
        Restock.Visible = not u9;
    end);
    Odds.SENSOR.Activated:Connect(openStockOdds);
    u5.Activated:Connect(function() -- Line: 555
        -- upvalues: ShowCrateOdds (ref)
        ShowCrateOdds.Enabled = false;
    end);
    local PathSignal = DataService:GetPathSignal("CosmeticStock/@");

    if PathSignal then
        PathSignal:Connect(setupFrames);
    end;

    local PathSignal2 = DataService:GetPathSignal("CosmeticStock");

    if PathSignal2 then
        PathSignal2:Connect(setupFrames);
    end;

    setupTabs();
    u6.OnCategoryChanged:Connect(onTabSelected);
    local DefaultCategory = u6.DefaultCategory;
    Cosmetics.Visible = DefaultCategory == "Cosmetics";
    Fences.Visible = DefaultCategory == "Fences";
    setupFrames();
end;

task.spawn(v1.Start, v1);

return v1;