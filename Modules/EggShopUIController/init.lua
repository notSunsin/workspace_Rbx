-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("ContentProvider");
game:GetService("UserInputService");
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
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local Spr = require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Modules.ShopTabHandler);
require(ReplicatedStorage.Data.ShopTabData);
local NPCLevelHandler = require(ReplicatedStorage.Modules.NPCLevelHandler);
local Spring = require(ReplicatedStorage.Modules.Spring);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Item_Module = require(ReplicatedStorage.Item_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local SoundPlayer = require(game.ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(game.ReplicatedStorage.Data.SoundData);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local _ = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
require(ReplicatedStorage.Data.EventShopConfigData);
local PetEggData = require(ReplicatedStorage.Data.PetEggData);
local PetEggShopData = require(ReplicatedStorage.Data.PetEggShopData);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local BuyPetEgg = GameEvents.BuyPetEgg;
local u1 = {
    ["Common Egg"] = "PRESETS/RoundedOddsCompliance"
};
local u2 = false;
local u3 = nil;
local u4 = Signal.new();
local u5 = {};
local PetShop_UI = PlayerGui:WaitForChild("PetShop_UI");
local ScrollingFrame = PetShop_UI:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local Timer = PetShop_UI:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local ItemFrame = ScrollingFrame:WaitForChild("ItemFrame");
ItemFrame.Parent = script;
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemPadding.Parent = ScrollingFrame;
local u6 = {};
local u7 = {};
local v8 = {};
local PolicyInfoForPlayerAsync = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);

if PolicyInfoForPlayerAsync then
    PolicyInfoForPlayerAsync = PolicyInfoForPlayerAsync.ArePaidRandomItemsRestricted;
end;

local function GetRefreshTime() -- Line: 101
    -- upvalues: DataService (copy), PetEggShopData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local v9 = Data.PetEggStock.ForcedEggEndTimestamp and (Data.PetEggStock.ForcedEggEndTimestamp - ServerTimeNow or -1) or -1;

    if v9 >= 0 then
        return v9;
    end;

    return PetEggShopData.RefreshTime - ServerTimeNow % PetEggShopData.RefreshTime;
end;

local game_SoundService = game.SoundService;
local Click = game_SoundService.Click;
local Restock_SFX = game_SoundService.Restock_SFX;

local function SetupTimer() -- Line: 120
    -- upvalues: u2 (ref), DataService (copy), PetEggShopData (copy), Timer (copy), NumberUtil (copy), TradeWorldController (copy), Restock_SFX (copy)
    if u2 then
        return;
    end;

    u2 = true;

    while true do
        local ServerTimeNow = workspace:GetServerTimeNow();
        local Data = DataService:GetData();
        local v10 = Data.PetEggStock.ForcedEggEndTimestamp and (Data.PetEggStock.ForcedEggEndTimestamp - ServerTimeNow or -1) or -1;

        if v10 < 0 then
            v10 = PetEggShopData.RefreshTime - ServerTimeNow % PetEggShopData.RefreshTime;
        end;

        Timer.Text = v10 <= 0 and "Restocking" or "Restock: " .. NumberUtil.compactFormat(v10);

        if v10 <= 1 and not TradeWorldController:IsInWorld() then
            Restock_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Restock_SFX.TimePosition = 0;
            Restock_SFX.Playing = true;
            require(game.ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#FFB6C1\"><b>Your Pet Shop stock has restocked!</b></font>");
        end;

        task.wait(1);
    end;
end;

local function SetCFrame(p11: userdata, p12) -- Line: 147
    if not p11:IsA("Model") then
        if p11:IsA("BasePart") then
            p11.CFrame = p12;
        end;

        return;
    end;

    p11:PivotTo(p12);
    p11:ScaleTo(0.5);
end;

local function SetOrientation(p13: userdata, p14: vector) -- Line: 157
    if p13:IsA("BasePart") then
        p13.Orientation = p14;
    end;
end;

local function GetOrientation(p15: userdata) -- Line: 164
    return not p15:IsA("BasePart") and Vector3.new(0, 0, 0) or p15.Orientation;
end;

local function RotateModel(u16: userdata, u17: number) -- Line: 172
    -- upvalues: RunService (copy)
    local u18 = 0;
    local Pivot = u16:GetPivot();

    return RunService.RenderStepped:Connect(function(p19: number) -- Line: 176
        -- upvalues: u18 (ref), u17 (copy), u16 (copy), Pivot (copy)
        u18 = u18 + p19 * u17;
        u16:PivotTo(Pivot * CFrame.Angles(0, math.rad(u18), 0));
    end);
end;

local function SetupFrames() -- Line: 183
    -- upvalues: SetupTimer (copy), u7 (copy), u6 (copy), PetEggData (copy), UpdateService (copy), ItemFrame (copy), Item_Module (copy), ColorHelper (copy), NumberUtil (copy), ItemImageFinder (copy), ScrollingFrame (copy), ItemPadding (copy), u5 (copy), ReplicatedStorage (copy), BuyPetEgg (copy), WatchButtonHold (copy), Spr (copy), PolicyInfoForPlayerAsync (copy), MarketController (copy), Click (copy), GiftController (copy), PetEggOddsController (copy), PetShop_UI (copy), u1 (copy), CurrencyData (copy), u3 (ref), FastTween (copy), u4 (copy), UseDynamicPrices (copy), Comma_Module (copy), DataService (copy), NPCLevelHandler (copy), RebirthUnlocksSharedService (copy), LocalPlayer (copy)
    task.spawn(SetupTimer);

    for _, v in ipairs(u7) do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    table.clear(u7);

    for _, v in u6 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    table.clear(u6);
    local u20 = {};

    for i, v in PetEggData do
        if not (UpdateService:IsHiddenFromUpdate(v.EggName) or (UpdateService:IsHiddenAfterUpdate(v.EggName) or v.DisplayInShop == false)) then
            local u21 = ItemFrame:Clone();
            u6[i] = u21;
            u21.Name = i;
            u21.LayoutOrder = v.LayoutOrder * 10;
            table.insert(u20, u21);
            local Main_Frame = u21.Main_Frame;
            local v22 = Item_Module.Return_Rarity_Data(v.EggRarity);

            if v22 then
                Main_Frame.Rarity_Text.Text = v22[1];
                Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v22[2]);
                Main_Frame.Rarity_BG.ImageColor3 = v22[2];
            end;

            Main_Frame.Seed_Text.Text = v.EggName;
            Main_Frame.Seed_Text_Shadow.Text = v.EggName;
            local u23;

            if v.SpecialCurrencyType then
                u23 = NumberUtil.FormatCompactPrice(v.Price) .. "";
            else
                u23 = NumberUtil.DisplaySheckles(v.Price);
            end;

            if Main_Frame.Cost_Text:FindFirstChild("TEXT") then
                Main_Frame.Cost_Text.TEXT.Text = u23;
            else
                Main_Frame.Cost_Text.Text = u23;
            end;

            if v.PetEggDescription and v.PetEggDescription ~= "" then
                Main_Frame.LargeDescriptionText.Text = v.PetEggDescription;
                Main_Frame.InfoButton.Visible = true;
            else
                Main_Frame.InfoButton.Visible = false;
                Main_Frame.Seed_Text.Size = UDim2.fromScale(0.652, Main_Frame.Seed_Text.Size.Y.Scale);
                Main_Frame.Seed_Text_Shadow.Size = UDim2.fromScale(0.652, Main_Frame.Seed_Text_Shadow.Size.Y.Scale);
            end;

            if v.Limited == true then
                u21.Main_Frame.LimitedBanner.Visible = true;
            else
                u21.Main_Frame.LimitedBanner.Visible = false;
            end;

            Main_Frame.LargeDescriptionText.Visible = false;
            local u24 = false;
            Main_Frame.InfoButton.Activated:Connect(function() -- Line: 290, Name: ToggleDescriptionVisibility
                -- upvalues: u24 (ref), Main_Frame (copy)
                u24 = not u24;
                Main_Frame.LargeDescriptionText.Visible = u24;
                Main_Frame.Rarity_BG.Visible = not u24;
                Main_Frame.Rarity_Text.Visible = not u24;
                Main_Frame.Stock_Text.Visible = not u24;
                Main_Frame.Cost_Text.Visible = not u24;
            end);
            local ShopItem_Image = Main_Frame:FindFirstChild("ShopItem_Image", true);
            ShopItem_Image.Visible = true;
            local v25 = v.ItemType or "Egg";
            ShopItem_Image.Image = ItemImageFinder(i, v25);
            u21.Parent = ScrollingFrame;
            local u26 = ItemPadding:Clone();
            u26.LayoutOrder = v.LayoutOrder * 10 + 1;
            u26.Name = `{i}_Padding`;
            u26.Parent = ScrollingFrame;
            u6[u26.Name] = u26;
            local Frame = u21.Frame;

            if Frame.Sheckles_Buy.In_Stock.Cost_Text:FindFirstChild("TEXT") then
                Frame.Sheckles_Buy.In_Stock.Cost_Text.TEXT.Text = u23;
            else
                Frame.Sheckles_Buy.In_Stock.Cost_Text.Text = u23;
            end;

            local function buy() -- Line: 324
                -- upvalues: u5 (ref), i (copy), ReplicatedStorage (ref), BuyPetEgg (ref)
                if u5[i] then
                    require(ReplicatedStorage.Modules.Notification):CreateNotification("Restocking. Please wait...");

                    return;
                end;

                BuyPetEgg:FireServer(i);
            end;

            local u27 = false;
            local u28 = 0;
            WatchButtonHold(Frame.Sheckles_Buy, function(p29: number, p30: boolean?) -- Line: 339
                -- upvalues: u28 (ref), u27 (ref), Frame (copy), Spr (ref), u5 (ref), i (copy), ReplicatedStorage (ref), BuyPetEgg (ref)
                if workspace:GetAttribute("InTutorial") then
                    return;
                end;

                if p30 then
                    u28 = 0;

                    if u27 then
                        u27 = false;

                        if Frame:FindFirstChild("Sheckles_Buy") then
                            Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                                ImageColor3 = Color3.new(1, 1, 1)
                            });
                        end;
                    end;

                    return;
                end;

                if not u27 then
                    u27 = true;

                    if Frame:FindFirstChild("Sheckles_Buy") then
                        Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                            ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                        });
                    end;
                end;

                if os.clock() < u28 then
                    return;
                end;

                local v31 = ((1 - math.exp(p29 * -0.3)) * 24 + 8) // 1;
                local math_max_ret = math.max(v31, 1);
                u28 = os.clock() + 0.125;

                for i2 = 1, math_max_ret do
                    local v32;

                    if u5[i] then
                        require(ReplicatedStorage.Modules.Notification):CreateNotification("Restocking. Please wait...");
                        v32 = i2;
                    else
                        BuyPetEgg:FireServer(i);
                        v32 = i2;
                    end;
                end;
            end, {
                minimumHoldTime = 1,
                interval = 0.125
            });
            Frame.Sheckles_Buy.Activated:Connect(buy);
            local v33 = not PolicyInfoForPlayerAsync;

            if v33 then
                if v.PurchaseID == nil then
                    v33 = false;
                else
                    v33 = v.PurchaseID > 0;
                end;
            end;

            Frame.Robux_Buy.Visible = v33;

            if v.PurchaseID and not PolicyInfoForPlayerAsync then
                Frame.Robux_Buy.Activated:Connect(function() -- Line: 388
                    -- upvalues: MarketController (ref), v (copy)
                    MarketController:PromptPurchase(v.PurchaseID, Enum.InfoType.Product);
                end);
            end;

            Frame.Gift.Visible = v.GiftPurchaseID ~= nil;

            if v.GiftPurchaseID then
                Frame.Gift.Activated:Connect(function() -- Line: 395
                    -- upvalues: Click (ref), GiftController (ref), v (copy)
                    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    Click.TimePosition = 0;
                    Click.Playing = true;
                    GiftController:PromptGiftFromGiftId(v.GiftPurchaseID);
                end);
            end;

            if v25 == "Egg" then
                Main_Frame.OddsButton.Visible = true;
                Main_Frame.OddsButton.Activated:Connect(function() -- Line: 407
                    -- upvalues: PetEggOddsController (ref), v (copy), PetShop_UI (ref), u1 (ref)
                    PetEggOddsController:Open(v.EggName, PetShop_UI, nil, nil, nil, u1[v.EggName]);
                end);
            else
                Main_Frame.OddsButton.Visible = false;
            end;

            if v.SpecialCurrencyType and CurrencyData[v.SpecialCurrencyType] then
                Main_Frame.Cost_Text.CurrencyImage.Image = CurrencyData[v.SpecialCurrencyType].Icon;
                Frame.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Image = CurrencyData[v.SpecialCurrencyType].Icon;
            else
                Main_Frame.Cost_Text.CurrencyImage.Visible = false;
                Frame.Sheckles_Buy.In_Stock.Cost_Text.CurrencyImage.Visible = false;
            end;

            local function updateOptions() -- Line: 427
                -- upvalues: u3 (ref), i (copy), Frame (copy), FastTween (ref), u26 (copy)
                if u3 == i then
                    Frame.Visible = true;
                    FastTween(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0.5, 1.3)
                    });
                    FastTween(u26, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0.13, 0.25)
                    });

                    return;
                end;

                task.delay(0.25, function() -- Line: 439
                    -- upvalues: Frame (ref)
                    if Frame.Position == UDim2.fromScale(0.5, 0.5) then
                        Frame.Visible = false;
                    end;
                end);
                FastTween(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, 0.5)
                });
                FastTween(u26, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.13, 0.02)
                });
            end;

            u4:Connect(updateOptions);
            task.spawn(updateOptions);
            local u34 = false;
            Main_Frame.Activated:Connect(function() -- Line: 458
                -- upvalues: FastTween (ref), ScrollingFrame (ref), u21 (copy), u20 (copy), u3 (ref), i (copy), u4 (ref), u34 (ref), UseDynamicPrices (ref), v (copy), Frame (copy), MarketController (ref), Comma_Module (ref)
                FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                    CanvasPosition = Vector2.new(0, u21.AbsoluteSize.Y * (table.find(u20, u21) - 1))
                });
                local v35;

                if u3 == i then
                    v35 = nil;
                else
                    v35 = i;
                end;

                u3 = v35;
                u4:Fire();

                if not u34 then
                    if UseDynamicPrices or v.FallbackPrice == nil then
                        if not UseDynamicPrices then
                            warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        MarketController:SetPriceLabel(Frame.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                    else
                        Frame.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                    end;

                    u34 = true;
                end;
            end);

            if u3 == i then
                task.spawn(function() -- Line: 481
                    -- upvalues: UseDynamicPrices (ref), v (copy), Frame (copy), MarketController (ref), Comma_Module (ref), u34 (ref)
                    if UseDynamicPrices or v.FallbackPrice == nil then
                        if not UseDynamicPrices then
                            warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        MarketController:SetPriceLabel(Frame.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                    else
                        Frame.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                    end;

                    u34 = true;
                end);
            end;

            local u36 = true;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            NumberValue.Parent = Frame;
            NumberValue.Changed:Connect(function(p37: number) -- Line: 502
                -- upvalues: Main_Frame (copy)
                if Main_Frame and Main_Frame:FindFirstChild("Stock_Text") then
                    Main_Frame.Stock_Text.Text = `X{p37 // 1} Stock`;
                end;
            end);

            local function updateStock() -- Line: 508
                -- upvalues: DataService (ref), i (copy), u36 (ref), u27 (ref), NumberValue (copy), Spr (ref), Frame (copy), Main_Frame (copy), u23 (ref), NPCLevelHandler (ref), v (copy), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
                local Data = DataService:GetData();

                if not Data then
                    return;
                end;

                local v38 = 0;

                for _, v2 in Data.PetEggStock.Stocks do
                    if v2.EggName == i then
                        v38 = v38 + v2.Stock;
                    end;
                end;

                if u36 or not u27 then
                    u36 = false;
                    NumberValue.Value = v38;
                else
                    Spr.target(NumberValue, 1, 1.5, {
                        Value = v38
                    });
                end;

                Frame.Sheckles_Buy.In_Stock.Visible = v38 > 0;
                Frame.Sheckles_Buy.No_Stock.Visible = v38 <= 0;
                Frame.Sheckles_Buy.HoverImage = v38 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                Frame.Sheckles_Buy.Image = v38 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";

                if Main_Frame.Cost_Text:FindFirstChild("TEXT") then
                    Main_Frame.Cost_Text.TEXT.Text = v38 <= 0 and "NO STOCK" or u23;
                    local TEXT = Main_Frame.Cost_Text.TEXT;
                    local v39;

                    if v38 <= 0 then
                        v39 = Color3.fromRGB(255, 0, 0);
                    else
                        v39 = Color3.fromRGB(0, 255, 0);
                    end;

                    TEXT.TextColor3 = v39;
                else
                    Main_Frame.Cost_Text.Text = v38 <= 0 and "NO STOCK" or u23;
                    local Cost_Text = Main_Frame.Cost_Text;
                    local v40;

                    if v38 <= 0 then
                        v40 = Color3.fromRGB(255, 0, 0);
                    else
                        v40 = Color3.fromRGB(0, 255, 0);
                    end;

                    Cost_Text.TextColor3 = v40;
                end;

                local v41 = not NPCLevelHandler:HasRequiredNPCLevels(v.LevelLocks);

                if v41 then
                    Spr.stop(NumberValue);
                    Main_Frame.Stock_Text.Text = "";
                elseif u36 or not u27 then
                    u36 = false;
                    NumberValue.Value = v38;
                else
                    Spr.target(NumberValue, 1, 1.5, {
                        Value = v38
                    });
                end;

                if v41 and v.LevelLocks then
                    local v42 = next(v.LevelLocks);
                    local v43 = v42 and v.LevelLocks[v42] or 1;
                    Main_Frame.LockedFrame.Visible = true;
                    Main_Frame.LockedFrame.UnlockInfo.Text = `NPC Friend Level Needed: lvl{v43}`;
                else
                    Main_Frame.LockedFrame.Visible = false;
                end;

                Frame.Sheckles_Buy.In_Stock.Visible = v38 > 0;
                Frame.Sheckles_Buy.No_Stock.Visible = v38 <= 0;
                Frame.Sheckles_Buy.HoverImage = v38 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                Frame.Sheckles_Buy.Image = v38 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
                Frame.Sheckles_Buy.Visible = not v41;
                local v44 = Main_Frame.Cost_Text:FindFirstChild("TEXT") or Main_Frame.Cost_Text;

                if v41 and v.LevelLocks then
                    local v45 = next(v.LevelLocks);
                    v44.Text = `LOCKED: lvl{v45 and v.LevelLocks[v45] or 1}+`;
                    v44.TextColor3 = Color3.fromRGB(255, 0, 0);
                else
                    v44.Text = v38 <= 0 and "NO STOCK" or u23;
                    local v46;

                    if v38 <= 0 then
                        v46 = Color3.fromRGB(255, 0, 0);
                    else
                        v46 = Color3.fromRGB(0, 255, 0);
                    end;

                    v44.TextColor3 = v46;
                end;

                if Main_Frame.Cost_Text:FindFirstChild("CurrencyImage") and v.SpecialCurrencyType then
                    Main_Frame.Cost_Text.CurrencyImage.Visible = v38 > 0;
                end;

                if RebirthUnlocksSharedService:HasUnlockedShopItem(LocalPlayer, "Egg", i) then
                    Main_Frame.LockedFrame.Visible = false;
                    Main_Frame.Interactable = true;

                    return;
                end;

                Main_Frame.LockedFrame.Visible = true;
                Main_Frame.Interactable = false;
                Main_Frame.LockedFrame.UnlockInfo.Text = `Ascensions Required: {RebirthUnlocksSharedService:GetRemainingRebirthsNeededForItem(LocalPlayer, "Egg", i)}`;
            end;

            task.spawn(updateStock);
            task.spawn(function() -- Line: 612
                -- upvalues: DataService (ref), updateStock (copy), u7 (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
                local PathSignal = DataService:GetPathSignal("PetEggStock/@");

                if PathSignal then
                    local v47 = PathSignal:Connect(updateStock);
                    table.insert(u7, v47);
                end;

                local PathSignal2 = DataService:GetPathSignal("PetEggStock");

                if PathSignal2 then
                    local v48 = PathSignal2:Connect(updateStock);
                    table.insert(u7, v48);
                end;

                local v49 = RebirthUnlocksSharedService:HasBeenAssignedABTest(LocalPlayer) and DataService:GetPathSignal("RebirthData/TotalRebirths");

                if v49 then
                    local v50 = v49:Connect(updateStock);
                    table.insert(u7, v50);
                end;
            end);
        end;
    end;

    table.sort(u20, function(p51, p52) -- Line: 636
        local LayoutOrder = p51.LayoutOrder;
        local LayoutOrder2 = p52.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p51.Name < p52.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);
end;

local function OnTabSelected(p53: string) -- Line: 669
    -- upvalues: SetupFrames (copy), u3 (ref), u4 (copy)
    SetupFrames();
    u3 = nil;
    u4:Fire();
end;

local function OpenStockOdds() -- Line: 680
    -- upvalues: ReplicatedStorage (copy), PetEggData (copy), u6 (copy), PetShop_UI (copy)
    local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
    local v54 = {};

    for i, v in PetEggData do
        local v55 = u6[i];

        if v55 and (v.StockChance and not v.RobuxOnly) then
            table.insert(v54, {
                Reward = {
                    Quantity = 1,
                    Type = v.ItemType or "Egg",
                    Value = i
                },
                Weight = 1 / v.StockChance,
                ShopLayoutOrder = v55.LayoutOrder
            });
        end;
    end;

    if #v54 == 0 then
        return;
    end;

    local u56 = {};
    GenericRewardsUIController:Open({
        Title = "Stock Odds",
        DisplayOdds = true,
        RewardData = v54,
        Breadcrumb = PetShop_UI,
        HeaderColor = PetShop_UI.Frame.Frame.BackgroundColor3,

        RewardFrameCreatedCallback = function(p57, p58) -- Line: 709, Name: RewardFrameCreatedCallback
            -- upvalues: u56 (copy)
            u56[p57] = p58.ShopLayoutOrder;
        end,

        RewardsUIBuiltCallback = function() -- Line: 712, Name: RewardsUIBuiltCallback
            -- upvalues: u56 (copy)
            for i, v in u56 do
                i.LayoutOrder = v;
            end;
        end,

        Disclaimer = GenericRewardsUIController.RoundedOddsDisclaimer(v54)
    });
end;

function v8.Start(p59) -- Line: 721
    -- upvalues: GuiController (copy), PetShop_UI (copy), OpenStockOdds (copy), PolicyInfoForPlayerAsync (copy), DevProductIds (copy), MarketController (copy), UpdateService (copy), SetupFrames (copy), DataService (copy), ScrollingFrame (copy), PetEggData (copy), Comma_Module (copy), Spring (copy), Debris (copy), u5 (copy), SoundPlayer (copy), SoundData (copy)
    GuiController:UsePopupAnims(PetShop_UI);
    PetShop_UI.Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 724
        -- upvalues: GuiController (ref), PetShop_UI (ref)
        GuiController:Close(PetShop_UI);
        PetShop_UI.Enabled = false;
    end);
    PetShop_UI.Frame.Frame.Odds.SENSOR.Activated:Connect(OpenStockOdds);
    PetShop_UI.Frame.Frame.Restock.Visible = not PolicyInfoForPlayerAsync;
    PetShop_UI.Frame.Frame.Restock.Activated:Connect(function() -- Line: 732
        -- upvalues: PolicyInfoForPlayerAsync (ref), DevProductIds (ref), MarketController (ref)
        if PolicyInfoForPlayerAsync then
            return;
        end;

        MarketController:PromptPurchase(DevProductIds.RefreshPetShop.PurchaseID, Enum.InfoType.Product);
    end);

    if not UpdateService:IsUpdateDone() then
        task.delay(UpdateService:GetRemainingTimeUntilUpdate() + 1, function() -- Line: 756
            -- upvalues: SetupFrames (ref)
            SetupFrames();
        end);
    end;

    SetupFrames();
    task.spawn(function() -- Line: 763
        -- upvalues: DataService (ref), ScrollingFrame (ref), PetEggData (ref), Comma_Module (ref), Spring (ref), Debris (ref), PetShop_UI (ref), u5 (ref), SoundPlayer (ref), SoundData (ref)
        local PathSignal = DataService:GetPathSignal("PetEggStock/@");

        if not PathSignal then
            return;
        end;

        local function fetchStock(p60: table, p61: string) -- Line: 771
            local v62 = 0;

            for _, v in p60 do
                if v.EggName == p61 then
                    v62 = v62 + 1;
                end;
            end;

            return v62;
        end;

        local function adjustFrame(p63: string, p64: number) -- Line: 782
            -- upvalues: ScrollingFrame (ref), PetEggData (ref), Comma_Module (ref)
            local v65 = ScrollingFrame:FindFirstChild(p63);

            if not v65 then
                return;
            end;

            local v66 = PetEggData[p63];

            if not v66 then
                warn((`No pet info found for id: {p63}`));

                return;
            end;

            local Main_Frame = v65.Main_Frame;
            local Frame = v65.Frame;
            local Cost_Text = Main_Frame.Cost_Text;
            local v67 = `X{p64} Stock`;
            local v68 = p64 > 0;
            Main_Frame.Stock_Text.Text = v67;
            Frame.Sheckles_Buy.In_Stock.Visible = v68;
            Frame.Sheckles_Buy.No_Stock.Visible = not v68;
            Frame.Sheckles_Buy.HoverImage = v68 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
            Frame.Sheckles_Buy.Image = v68 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";

            if v68 then
                Cost_Text.Text = Comma_Module.Comma(v66.Price) .. "¢";
                Cost_Text.TextColor3 = Color3.fromRGB(0, 255, 0);

                return;
            end;

            Cost_Text.Text = "NO STOCK";
            Cost_Text.TextColor3 = Color3.fromRGB(255, 0, 0);
        end;

        local function createFlash(p69: string, p70) -- Line: 821
            -- upvalues: ScrollingFrame (ref), Spring (ref), Debris (ref)
            local v71 = ScrollingFrame:FindFirstChild(p69);

            if not v71 then
                return;
            end;

            local Main_Frame = v71.Main_Frame;
            local Frame = Instance.new("Frame");
            Frame.Size = UDim2.fromScale(0.98, 0.98);
            Frame.Position = UDim2.fromScale(0.5, 0.5);
            Frame.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame.Transparency = 0.4;
            Frame.BackgroundColor3 = p70;
            Frame.ZIndex = 1000;
            Frame.Parent = Main_Frame;
            Spring.target(Frame, 1, 1, {
                Transparency = 1
            });
            Debris:AddItem(Frame, 2.1);
            task.delay(2, function() -- Line: 841
                -- upvalues: Frame (copy)
                if not (Frame and Frame.Parent) then
                    return;
                end;

                Frame:Destroy();
            end);
        end;

        local function playSound(p72: string) -- Line: 849
            -- upvalues: PetShop_UI (ref), Debris (ref)
            if not PetShop_UI.Enabled then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.SoundId = p72;
            Sound.Parent = game.Players.LocalPlayer.PlayerGui.ReplicatedAssets;
            Sound:Play();
            Debris:AddItem(Sound, Sound.TimeLength);
            task.delay(Sound.TimeLength, function() -- Line: 861
                -- upvalues: Sound (copy)
                if not (Sound and Sound.Parent) then
                    return;
                end;

                Sound:Destroy();
            end);
        end;

        local function getSortedByLayoutOrder(p73: table) -- Line: 869
            -- upvalues: ScrollingFrame (ref)
            local v74 = {};

            for i, _ in p73 do
                table.insert(v74, i);
            end;

            local function getLayoutOrder(p75: string) -- Line: 875
                -- upvalues: ScrollingFrame (ref)
                local v76 = ScrollingFrame:FindFirstChild(p75);

                return not v76 and 0 or v76.LayoutOrder;
            end;

            table.sort(v74, function(p77: string, p78: string) -- Line: 883
                -- upvalues: ScrollingFrame (ref)
                local v79 = ScrollingFrame:FindFirstChild(p77);
                local v80 = not v79 and 0 or v79.LayoutOrder;
                local v81 = ScrollingFrame:FindFirstChild(p78);

                return v80 < (not v81 and 0 or v81.LayoutOrder);
            end);

            return v74;
        end;

        local function stockAnimation(p82: table) -- Line: 890
            -- upvalues: DataService (ref), getSortedByLayoutOrder (copy), ScrollingFrame (ref), u5 (ref), adjustFrame (copy), PetShop_UI (ref), SoundPlayer (ref), SoundData (ref), PetEggData (ref), createFlash (copy)
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local v83 = getSortedByLayoutOrder(p82);
            table.clear(p82);

            for i, v in v83 do
                if ScrollingFrame:FindFirstChild(v) then
                    u5[v] = true;
                    local v84 = v;
                    local v85 = 0;

                    for _, v2 in Data.PetEggStock.Stocks do
                        if v2.EggName == v84 then
                            v85 = v85 + 1;
                        end;
                    end;

                    if v85 > 0 then
                        for i2 = 0, v85 do
                            adjustFrame(v84, i2);

                            if PetShop_UI.Enabled then
                                SoundPlayer:PlaySound(SoundData.RestockAnimationSFX.Stock_Click);
                            end;

                            task.wait(0.05);
                            local _ = i2;
                        end;

                        local v86 = not PetEggData[v84] and "Prismatic" or PetEggData[v84].EggRarity;

                        if PetShop_UI.Enabled then
                            SoundPlayer:PlaySound(SoundData.RestockAnimationSFX[v86 or "Prismatic"]);
                        end;

                        createFlash(v84, Color3.fromRGB(24, 255, 0));
                        adjustFrame(v84, v85);
                    else
                        if PetShop_UI.Enabled then
                            SoundPlayer:PlaySound(SoundData.RestockAnimationSFX.No_Restock);
                        end;

                        createFlash(v84, Color3.fromRGB(249, 0, 2));
                        adjustFrame(v84, 0);
                    end;

                    task.wait((i - 1) * 0.02 + 0.25);
                    u5[v84] = nil;
                end;
            end;
        end;

        local Data = DataService:GetData();
        local Egg = Data.PetEggStock.Egg;
        local u87 = nil;
        PathSignal:Connect(function() -- Line: 955
            -- upvalues: Data (copy), Egg (ref), PetEggData (ref), u87 (ref), stockAnimation (copy)
            if not Data then
                return;
            end;

            if Egg and Egg == Data.PetEggStock.Egg then
                return;
            end;

            Egg = Data.PetEggStock.Egg;
            local v88 = {};

            for i, _ in PetEggData do
                v88[i] = true;
            end;

            if u87 then
                task.cancel(u87);
            end;

            u87 = task.delay(0.15, stockAnimation, v88);
        end);
    end);
end;

task.spawn(v8.Start, v8);

return v8;