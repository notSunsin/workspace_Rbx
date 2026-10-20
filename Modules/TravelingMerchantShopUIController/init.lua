-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local UserInputService = game:GetService("UserInputService");
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local PlayerGui = game.Players.LocalPlayer.PlayerGui;
local DataService = require(ReplicatedStorage.Modules.DataService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.DumpTable);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Item_Module = require(ReplicatedStorage.Item_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemDescriptionFinder = require(ReplicatedStorage.Modules.ItemDescriptionFinder);
require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local Spr = require(ReplicatedStorage.Code.Spr);
local _ = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local TravelingMerchantData = require(ReplicatedStorage.Data.TravelingMerchant.TravelingMerchantData);
require(ReplicatedStorage.Data.TravelingMerchant.TravelingMerchantShopConfigData);
require(ReplicatedStorage.Data.EventShopConfigData);
local BuyTravelingMerchantShopStock = GameEvents.BuyTravelingMerchantShopStock;
local u1 = false;
local u2 = nil;
local u3 = Signal.new();
local TravelingMerchantShop_UI = PlayerGui:WaitForChild("TravelingMerchantShop_UI");
local ScrollingFrame = TravelingMerchantShop_UI:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local Timer = TravelingMerchantShop_UI:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local ItemFrame = ScrollingFrame:WaitForChild("ItemFrame");
ItemFrame.Parent = script;
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemPadding.Parent = ScrollingFrame;
local ShopTitle = TravelingMerchantShop_UI:FindFirstChild("ShopTitle", true);
local u4 = {};
local u5 = {};
local v6 = {};

local function GetEndTime() -- Line: 67
    -- upvalues: DataService (copy), TravelingMerchantData (copy)
    workspace:GetServerTimeNow();
    local Data = DataService:GetData();

    if not Data.TravelingMerchantShopStock.MerchantType then
        return 0;
    end;

    local v7 = Data.TravelingMerchantShopStock.MerchantStartTime + TravelingMerchantData[Data.TravelingMerchantShopStock.MerchantType].Duration - workspace:GetServerTimeNow();

    return v7 <= 0 and 0 or v7;
end;

local Click = game.SoundService.Click;

local function SetupTimer() -- Line: 88
    -- upvalues: u1 (ref), GetEndTime (copy), Timer (copy), NumberUtil (copy)
    if u1 then
        return;
    end;

    u1 = true;

    while true do
        local v8 = GetEndTime();
        Timer.Text = v8 <= 0 and "Restocking" or "Leaving: " .. NumberUtil.compactFormat(v8);
        task.wait(1);
    end;
end;

local function SetCFrame(p9: userdata, p10) -- Line: 107
    if not p9:IsA("Model") then
        if p9:IsA("BasePart") then
            p9.CFrame = p10;
        end;

        return;
    end;

    p9:PivotTo(p10);
    p9:ScaleTo(0.5);
end;

local function SetOrientation(p11: userdata, p12: vector) -- Line: 117
    if p11:IsA("BasePart") then
        p11.Orientation = p12;
    end;
end;

local function GetOrientation(p13: userdata) -- Line: 124
    return not p13:IsA("BasePart") and Vector3.new(0, 0, 0) or p13.Orientation;
end;

local function RotateModel(u14: userdata, u15: number) -- Line: 132
    -- upvalues: RunService (copy)
    local u16 = 0;
    local Pivot = u14:GetPivot();

    return RunService.RenderStepped:Connect(function(p17: number) -- Line: 136
        -- upvalues: u16 (ref), u15 (copy), u14 (copy), Pivot (copy)
        u16 = u16 + p17 * u15;
        u14:PivotTo(Pivot * CFrame.Angles(0, math.rad(u16), 0));
    end);
end;

local function SetupFrames() -- Line: 143
    -- upvalues: SetupTimer (copy), u5 (copy), u4 (copy), DataService (copy), ShopTitle (copy), TravelingMerchantData (copy), UserInputService (copy), ItemImageFinder (copy), ContentProvider (copy), UpdateService (copy), ItemFrame (copy), Item_Module (copy), ColorHelper (copy), NumberUtil (copy), ItemDescriptionFinder (copy), ScrollingFrame (copy), ItemPadding (copy), BuyTravelingMerchantShopStock (copy), WatchButtonHold (copy), Spr (copy), MarketController (copy), Click (copy), GiftController (copy), FastTween (copy), ItemOddsController (copy), TravelingMerchantShop_UI (copy), CurrencyData (copy), u2 (ref), u3 (copy), UseDynamicPrices (copy), Comma_Module (copy)
    task.spawn(SetupTimer);

    for _, v in ipairs(u5) do
        if v.Connected then
            v:Disconnect();
        end;
    end;

    table.clear(u5);

    for _, v in u4 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    table.clear(u4);
    local Data = DataService:GetData();

    if Data.FirstTimeUser then
        return;
    end;

    local MerchantType = Data.TravelingMerchantShopStock.MerchantType;
    local _ = Data.TravelingMerchantShopStock.Stocks;

    if not MerchantType then
        return;
    end;

    ShopTitle.Text = `{TravelingMerchantData[MerchantType].Title} Shop`;
    local ShopData = TravelingMerchantData[MerchantType].ShopData;

    if not UserInputService.TouchEnabled then
        local u18 = {};

        for i, v in ShopData do
            if v.DisplayInShop and v.ItemType == "Seed" then
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = ItemImageFinder(i, "Holdable");
                table.insert(u18, ImageLabel);
            end;
        end;

        task.spawn(function() -- Line: 208
            -- upvalues: ContentProvider (ref), u18 (copy)
            ContentProvider:PreloadAsync(u18);
        end);
    end;

    local u19 = {};

    for i, v in ShopData do
        if v.DisplayInShop and not UpdateService:IsHiddenFromUpdate(v.SeedName) then
            local u20 = ItemFrame:Clone();
            u4[i] = u20;
            u20.Name = i;
            u20.LayoutOrder = v.LayoutOrder * 10;
            table.insert(u19, u20);
            local Main_Frame = u20.Main_Frame;
            local v21 = Item_Module.Return_Rarity_Data(v.SeedRarity);

            if v21 then
                Main_Frame.Rarity_Text.Text = v21[1];
                Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v21[2]);
                Main_Frame.Rarity_BG.ImageColor3 = v21[2];
            end;

            Main_Frame.Seed_Text.Text = v.SeedName;
            Main_Frame.Seed_Text_Shadow.Text = v.SeedName;
            local u22;

            if v.SpecialCurrencyType then
                u22 = NumberUtil.FormatCompactPrice(v.Price) .. "";
            else
                u22 = NumberUtil.DisplaySheckles(v.Price);
            end;

            if Main_Frame.Cost_Text:FindFirstChild("TEXT") then
                Main_Frame.Cost_Text.TEXT.Text = u22;
            else
                Main_Frame.Cost_Text.Text = u22;
            end;

            Main_Frame.Description_Text.Text = ItemDescriptionFinder(v.SeedName, v.ItemType) or v.Description;
            local ShopItem_Image = Main_Frame:FindFirstChild("ShopItem_Image", true);
            ShopItem_Image.Visible = true;
            ShopItem_Image.Image = ItemImageFinder(i, v.ItemType);
            u20.Parent = ScrollingFrame;
            local UDim2_fromScale_ret = UDim2.fromScale(0.13, 0.042);
            local u23 = ItemPadding:Clone();
            u23.LayoutOrder = v.LayoutOrder * 10 + 1;
            u23.Name = `{i}_Padding`;
            u23.Parent = ScrollingFrame;
            u4[u23.Name] = u23;
            local Frame = u20.Frame;

            if Frame.Sheckles_Buy.In_Stock.Cost_Text:FindFirstChild("TEXT") then
                Frame.Sheckles_Buy.In_Stock.Cost_Text.TEXT.Text = u22;
            else
                Frame.Sheckles_Buy.In_Stock.Cost_Text.Text = u22;
            end;

            local function buy() -- Line: 287
                -- upvalues: BuyTravelingMerchantShopStock (ref), i (copy)
                BuyTravelingMerchantShopStock:FireServer(i);
            end;

            local u24 = false;
            local u25 = 0;
            WatchButtonHold(Frame.Sheckles_Buy, function(p26: number, p27: boolean?) -- Line: 297
                -- upvalues: u25 (ref), u24 (ref), Frame (copy), Spr (ref), BuyTravelingMerchantShopStock (ref), i (copy)
                if workspace:GetAttribute("InTutorial") then
                    return;
                end;

                if p27 then
                    u25 = 0;

                    if u24 then
                        u24 = false;

                        if Frame:FindFirstChild("Sheckles_Buy") then
                            Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                                ImageColor3 = Color3.new(1, 1, 1)
                            });
                        end;
                    end;

                    return;
                end;

                if not u24 then
                    u24 = true;

                    if Frame:FindFirstChild("Sheckles_Buy") then
                        Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                            ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                        });
                    end;
                end;

                if os.clock() < u25 then
                    return;
                end;

                local v28 = ((1 - math.exp(p26 * -0.3)) * 24 + 8) // 1;
                local math_max_ret = math.max(v28, 1);
                u25 = os.clock() + 0.125;

                for i2 = 1, math_max_ret do
                    BuyTravelingMerchantShopStock:FireServer(i);
                    local _ = i2;
                end;
            end, {
                minimumHoldTime = 1,
                interval = 0.125
            });
            Frame.Sheckles_Buy.Activated:Connect(buy);
            local v29 = v.PurchaseID ~= nil;

            if v29 then
                Frame.Robux_Buy.Activated:Connect(function() -- Line: 346
                    -- upvalues: MarketController (ref), v (copy)
                    MarketController:PromptPurchase(v.PurchaseID, Enum.InfoType.Product);
                end);
            end;

            Frame.Robux_Buy.Visible = v29;
            Frame.Gift.Visible = v.GiftPurchaseID ~= nil;

            if v.GiftPurchaseID then
                Frame.Gift.Activated:Connect(function() -- Line: 356
                    -- upvalues: Click (ref), GiftController (ref), v (copy)
                    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    Click.TimePosition = 0;
                    Click.Playing = true;
                    GiftController:PromptGiftFromGiftId(v.GiftPurchaseID);
                end);
            end;

            if v.ItemType == "Seed" then
                local u30 = nil;
                local u31 = nil;
                Main_Frame.MouseEnter:Connect(function() -- Line: 369
                    -- upvalues: u30 (ref), FastTween (ref), u20 (copy), u31 (ref), ItemImageFinder (ref), i (copy)
                    u30 = FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                        Rotation = u20.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                    });
                    u31 = FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                        Scale = 1.5
                    });
                    u31.Completed:Connect(function(p32) -- Line: 385
                        -- upvalues: u20 (ref), ItemImageFinder (ref), i (ref)
                        if p32 == Enum.PlaybackState.Completed then
                            if not u20:IsDescendantOf(game) then
                                return;
                            end;

                            u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, "Holdable");
                        end;
                    end);
                end);
                Main_Frame.MouseLeave:Connect(function() -- Line: 396
                    -- upvalues: u30 (ref), u20 (copy), ItemImageFinder (ref), i (copy), v (copy), FastTween (ref)
                    if u30 then
                        u30:Cancel();
                    end;

                    u20.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                    u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, v.ItemType);
                    FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                        Scale = 1
                    });
                end);
            end;

            if v.ShowOdds then
                ItemOddsController:ConnectOddsButton({
                    Type = v.ItemType,
                    Value = v.SeedName
                }, Main_Frame.OddsButton, TravelingMerchantShop_UI);
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

            local function updateOptions() -- Line: 436
                -- upvalues: u2 (ref), i (copy), Frame (copy), FastTween (ref), u23 (copy), UDim2_fromScale_ret (copy)
                if u2 == i then
                    Frame.Visible = true;
                    FastTween(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0.5, 1.3)
                    });
                    FastTween(u23, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0.13, 0.25)
                    });

                    return;
                end;

                task.delay(0.25, function() -- Line: 448
                    -- upvalues: Frame (ref)
                    if Frame.Position == UDim2.fromScale(0.5, 0.5) then
                        Frame.Visible = false;
                    end;
                end);
                FastTween(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, 0.5)
                });
                FastTween(u23, TweenInfo.new(0.25), {
                    Size = UDim2_fromScale_ret
                });
            end;

            u3:Connect(updateOptions);
            task.spawn(updateOptions);
            local u33 = false;
            Main_Frame.Activated:Connect(function() -- Line: 464
                -- upvalues: u19 (copy), u20 (copy), FastTween (ref), ScrollingFrame (ref), UDim2_fromScale_ret (copy), u2 (ref), i (copy), u3 (ref), u33 (ref), UseDynamicPrices (ref), v (copy), Frame (copy), MarketController (ref), Comma_Module (ref)
                local v34 = table.find(u19, u20) or 1;
                FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                    CanvasPosition = Vector2.new(0, (u20.AbsoluteSize.Y + UDim2_fromScale_ret.Y.Scale * ScrollingFrame.AbsoluteSize.Y) * (v34 - 1))
                });
                local v35;

                if u2 == i then
                    v35 = nil;
                else
                    v35 = i;
                end;

                u2 = v35;
                u3:Fire();

                if not u33 then
                    if UseDynamicPrices or v.FallbackPrice == nil then
                        if not UseDynamicPrices then
                            warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        MarketController:SetPriceLabel(Frame.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                    else
                        Frame.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                    end;

                    u33 = true;
                end;
            end);

            if u2 == i then
                task.spawn(function() -- Line: 493
                    -- upvalues: UseDynamicPrices (ref), v (copy), Frame (copy), MarketController (ref), Comma_Module (ref), u33 (ref)
                    if UseDynamicPrices or v.FallbackPrice == nil then
                        if not UseDynamicPrices then
                            warn((`{Frame:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                        end;

                        MarketController:SetPriceLabel(Frame.Robux_Buy.Price, v.PurchaseID, ":robux::value:");
                    else
                        Frame.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(v.FallbackPrice)}`;
                    end;

                    u33 = true;
                end);
            end;

            local u36 = true;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            NumberValue.Parent = Frame;
            local v38 = NumberValue.Changed:Connect(function(p37: number) -- Line: 514
                -- upvalues: Main_Frame (copy)
                Main_Frame.Stock_Text.Text = `X{p37 // 1} Stock`;
            end);
            table.insert(u5, v38);

            local function updateStock() -- Line: 519
                -- upvalues: DataService (ref), i (copy), Main_Frame (copy), u36 (ref), u24 (ref), NumberValue (copy), Spr (ref), Frame (copy), u22 (ref), v (copy)
                local Data2 = DataService:GetData();

                if Data2 then
                    Data2 = Data2.TravelingMerchantShopStock.Stocks[i];
                end;

                local v39 = Data2 and Data2.Stock or 0;

                if not Main_Frame:FindFirstChild("Stock_Text", true) then
                    return;
                end;

                if u36 or not u24 then
                    u36 = false;
                    NumberValue.Value = v39;
                else
                    Spr.target(NumberValue, 1, 1.5, {
                        Value = v39
                    });
                end;

                Frame.Sheckles_Buy.In_Stock.Visible = v39 > 0;
                Frame.Sheckles_Buy.No_Stock.Visible = v39 <= 0;
                Frame.Sheckles_Buy.HoverImage = v39 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                Frame.Sheckles_Buy.Image = v39 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";

                if Main_Frame.Cost_Text:FindFirstChild("TEXT") then
                    Main_Frame.Cost_Text.TEXT.Text = v39 <= 0 and "NO STOCK" or u22;
                    local TEXT = Main_Frame.Cost_Text.TEXT;
                    local v40;

                    if v39 <= 0 then
                        v40 = Color3.fromRGB(255, 0, 0);
                    else
                        v40 = Color3.fromRGB(0, 255, 0);
                    end;

                    TEXT.TextColor3 = v40;
                else
                    Main_Frame.Cost_Text.Text = v39 <= 0 and "NO STOCK" or u22;
                    local Cost_Text = Main_Frame.Cost_Text;
                    local v41;

                    if v39 <= 0 then
                        v41 = Color3.fromRGB(255, 0, 0);
                    else
                        v41 = Color3.fromRGB(0, 255, 0);
                    end;

                    Cost_Text.TextColor3 = v41;
                end;

                if Main_Frame.Cost_Text:FindFirstChild("CurrencyImage") and v.SpecialCurrencyType then
                    Main_Frame.Cost_Text.CurrencyImage.Visible = v39 > 0;
                end;
            end;

            task.spawn(updateStock);
            task.spawn(function() -- Line: 557
                -- upvalues: DataService (ref), updateStock (copy), u5 (ref)
                local PathSignal = DataService:GetPathSignal("TravelingMerchantShopStock/@");

                if PathSignal then
                    local v42 = PathSignal:Connect(updateStock);
                    table.insert(u5, v42);
                end;
            end);
        end;
    end;

    table.sort(u19, function(p43, p44) -- Line: 566
        local LayoutOrder = p43.LayoutOrder;
        local LayoutOrder2 = p44.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p43.Name < p44.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);
end;

function v6.Start(p45) -- Line: 576
    -- upvalues: GuiController (copy), TravelingMerchantShop_UI (copy), SetupFrames (copy), DataService (copy)
    GuiController:UsePopupAnims(TravelingMerchantShop_UI);
    TravelingMerchantShop_UI.Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 579
        -- upvalues: GuiController (ref), TravelingMerchantShop_UI (ref)
        GuiController:Close(TravelingMerchantShop_UI);
    end);
    TravelingMerchantShop_UI.Frame.Frame.Restock.Activated:Connect(function() -- Line: 583
    end);
    SetupFrames();
    local PathSignal = DataService:GetPathSignal("TravelingMerchantShopStock/MerchantType");

    if PathSignal then
        PathSignal:Connect(SetupFrames);
    end;
end;

task.spawn(v6.Start, v6);

return v6;