-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local PlayerGui = game.Players.LocalPlayer.PlayerGui;
local DataService = require(ReplicatedStorage.Modules.DataService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.DumpTable);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Comma_Module);
local Item_Module = require(ReplicatedStorage.Item_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
require(ReplicatedStorage.Modules.UseDynamicPrices);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local WatchButtonHold = require(ReplicatedStorage.Modules.WatchButtonHold);
local Spr = require(ReplicatedStorage.Code.Spr);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local _ = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local GardenCoinShopData = require(ReplicatedStorage.Data.GardenCoinShopData);
require(ReplicatedStorage.Data.GardenCoinShopConfigData);
local BuyGardenCoinShopStock = GameEvents.BuyGardenCoinShopStock;
local u1 = false;
local u2 = nil;
local u3 = Signal.new();
local GardenCoinShop_UI = PlayerGui:WaitForChild("GardenCoinShop_UI");
local ScrollingFrame = GardenCoinShop_UI:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
GardenCoinShop_UI:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer").Visible = false;
local ItemFrame = ScrollingFrame:WaitForChild("ItemFrame");
ItemFrame.Parent = script;
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemPadding.Parent = ScrollingFrame;
local u4 = {};
local u5 = {};
local v6 = {};
local _ = game.SoundService.Click;

local function SetupTimer() -- Line: 78
    -- upvalues: u1 (ref)
    if u1 then
        return;
    end;

    u1 = true;
end;

local function SetCFrame(p7: userdata, p8) -- Line: 100
    if not p7:IsA("Model") then
        if p7:IsA("BasePart") then
            p7.CFrame = p8;
        end;

        return;
    end;

    p7:PivotTo(p8);
    p7:ScaleTo(0.5);
end;

local function SetOrientation(p9: userdata, p10: vector) -- Line: 110
    if p9:IsA("BasePart") then
        p9.Orientation = p10;
    end;
end;

local function GetOrientation(p11: userdata) -- Line: 117
    return not p11:IsA("BasePart") and Vector3.new(0, 0, 0) or p11.Orientation;
end;

local function RotateModel(u12: userdata, u13: number) -- Line: 125
    -- upvalues: RunService (copy)
    local u14 = 0;
    local Pivot = u12:GetPivot();

    return RunService.RenderStepped:Connect(function(p15: number) -- Line: 129
        -- upvalues: u14 (ref), u13 (copy), u12 (copy), Pivot (copy)
        u14 = u14 + p15 * u13;
        u12:PivotTo(Pivot * CFrame.Angles(0, math.rad(u14), 0));
    end);
end;

local function Clear() -- Line: 136
    -- upvalues: u5 (copy), u4 (copy)
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
end;

local function SetupFrames() -- Line: 154
    -- upvalues: SetupTimer (copy), Clear (copy), DataService (copy), UserInputService (copy), GardenCoinShopData (copy), ItemImageFinder (copy), ContentProvider (copy), UpdateService (copy), ItemFrame (copy), u4 (copy), Item_Module (copy), RunService (copy), GardenCoinShop_UI (copy), ColorHelper (copy), NumberUtil (copy), u5 (copy), ScrollingFrame (copy), ItemPadding (copy), BuyGardenCoinShopStock (copy), WatchButtonHold (copy), Spr (copy), FastTween (copy), SeedPackOddsController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), CurrencyData (copy), u2 (ref), u3 (copy), SetupFrames (copy)
    task.spawn(SetupTimer);
    Clear();
    local Data = DataService:GetData();
    local _ = Data.GardenCoinShopStock.Stocks;

    if not UserInputService.TouchEnabled then
        local u16 = {};

        for i, v in GardenCoinShopData do
            if v.DisplayInShop and v.ItemType == "Seed" then
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = v.Icon or ItemImageFinder(i, "Holdable");
                table.insert(u16, ImageLabel);
            end;
        end;

        task.spawn(function() -- Line: 186
            -- upvalues: ContentProvider (ref), u16 (copy)
            ContentProvider:PreloadAsync(u16);
        end);
    end;

    local u17 = {};

    for i, v in GardenCoinShopData do
        if not (not v.DisplayInShop or (UpdateService:IsHiddenFromUpdate(v.SeedName) or v.HideAfterLifetimeLimitReached and (v.LifetimeLimit and (Data.GardenCoinShopStats.LifetimePurchases[i] or 0) == v.LifetimeLimit)) or v.LifetimeLimitDependancy and (Data.GardenCoinShopStats.LifetimePurchases[v.LifetimeLimitDependancy] or 0) ~= GardenCoinShopData[v.LifetimeLimitDependancy].LifetimeLimit) then
            local u18 = ItemFrame:Clone();
            u4[i] = u18;
            u18.Name = i;
            u18.LayoutOrder = v.LayoutOrder * 10;
            table.insert(u17, u18);
            local Main_Frame = u18.Main_Frame;
            local v19 = Item_Module.Return_Rarity_Data(v.SeedRarity);

            if v19 then
                local v20 = v19[1];
                local v21 = v19[2];
                local v22 = v19[3];
                Main_Frame.Rarity_Text.Text = v20;

                if v22 and v20 == "Prismatic" then
                    local u23 = nil;
                    u23 = RunService.Heartbeat:Connect(function() -- Line: 239
                        -- upvalues: GardenCoinShop_UI (ref), Main_Frame (copy), u23 (ref), ColorHelper (ref)
                        if not GardenCoinShop_UI.Enabled then
                            return;
                        end;

                        if not (Main_Frame and Main_Frame.Parent) then
                            u23:Disconnect();

                            return;
                        end;

                        local v24 = os.clock() * 0.1 % 1;
                        local Color3_fromHSV_ret = Color3.fromHSV(v24, 1, 1);
                        Main_Frame.Rarity_BG.ImageColor3 = Color3_fromHSV_ret;

                        if Main_Frame.Rarity_Text.UIStroke then
                            Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(Color3_fromHSV_ret);
                        end;
                    end);
                else
                    if Main_Frame.Rarity_Text.UIStroke then
                        Main_Frame.Rarity_Text.UIStroke.Color = ColorHelper:Darken(v21);
                    end;

                    Main_Frame.Rarity_BG.ImageColor3 = v21;
                end;
            end;

            Main_Frame.Seed_Text.Text = v.SeedName;
            Main_Frame.Seed_Text_Shadow.Text = v.SeedName;
            local u25;

            if v.SpecialCurrencyType then
                u25 = NumberUtil.FormatCompactPrice(v.Price) .. "";
            else
                u25 = NumberUtil.DisplaySheckles(v.Price);
            end;

            if Main_Frame.Cost_Text:FindFirstChild("TEXT") then
                Main_Frame.Cost_Text.TEXT.Text = u25;
            else
                Main_Frame.Cost_Text.Text = u25;
            end;

            if v.LifetimeLimit then
                Main_Frame.Description_Text.Text = v.Description .. ` ({Data.GardenCoinShopStats.LifetimePurchases[i] or 0}/{v.LifetimeLimit})`;
                local PathSignal = DataService:GetPathSignal("GardenCoinShopStats/LifetimePurchases/@");
                table.insert(u5, PathSignal:Connect(function() -- Line: 290
                    -- upvalues: DataService (ref), i (copy), Main_Frame (copy), v (copy)
                    local v26 = DataService:GetData().GardenCoinShopStats.LifetimePurchases[i] or 0;
                    Main_Frame.Description_Text.Text = v.Description .. ` ({v26}/{v.LifetimeLimit})`;
                end));
            else
                Main_Frame.Description_Text.Text = v.Description;
            end;

            local ShopItem_Image = Main_Frame:FindFirstChild("ShopItem_Image", true);
            ShopItem_Image.Visible = true;
            ShopItem_Image.Image = v.Icon or ItemImageFinder(i, v.ItemType);
            u18.Parent = ScrollingFrame;
            local u27 = ItemPadding:Clone();
            u27.LayoutOrder = v.LayoutOrder * 10 + 1;
            u27.Name = `{i}_Padding`;
            u27.Parent = ScrollingFrame;
            u4[u27.Name] = u27;
            local Frame = u18.Frame;

            if Frame.Sheckles_Buy.In_Stock.Cost_Text:FindFirstChild("TEXT") then
                Frame.Sheckles_Buy.In_Stock.Cost_Text.TEXT.Text = u25;
            else
                Frame.Sheckles_Buy.In_Stock.Cost_Text.Text = u25;
            end;

            local function buy() -- Line: 319
                -- upvalues: BuyGardenCoinShopStock (ref), i (copy)
                BuyGardenCoinShopStock:FireServer(i);
            end;

            local u28 = false;
            local u29 = 0;
            WatchButtonHold(Frame.Sheckles_Buy, function(p30: number, p31: boolean?) -- Line: 329
                -- upvalues: u29 (ref), u28 (ref), Frame (copy), Spr (ref), BuyGardenCoinShopStock (ref), i (copy)
                if workspace:GetAttribute("InTutorial") then
                    return;
                end;

                if p31 then
                    u29 = 0;

                    if u28 then
                        u28 = false;

                        if Frame:FindFirstChild("Sheckles_Buy") then
                            Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                                ImageColor3 = Color3.new(1, 1, 1)
                            });
                        end;
                    end;

                    return;
                end;

                if not u28 then
                    u28 = true;

                    if Frame:FindFirstChild("Sheckles_Buy") then
                        Spr.target(Frame.Sheckles_Buy, 0.8, 2, {
                            ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                        });
                    end;
                end;

                if os.clock() < u29 then
                    return;
                end;

                local v32 = ((1 - math.exp(p30 * -0.3)) * 24 + 8) // 1;
                local math_max_ret = math.max(v32, 1);
                u29 = os.clock() + 0.125;

                for i2 = 1, math_max_ret do
                    BuyGardenCoinShopStock:FireServer(i);
                    local _ = i2;
                end;
            end, {
                minimumHoldTime = 1,
                interval = 0.125
            });
            Frame.Sheckles_Buy.Activated:Connect(buy);

            if v.ItemType == "Seed" then
                local u33 = nil;
                local u34 = nil;
                Main_Frame.MouseEnter:Connect(function() -- Line: 394
                    -- upvalues: u33 (ref), FastTween (ref), u18 (copy), u34 (ref), ItemImageFinder (ref), i (copy)
                    u33 = FastTween(u18.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                        Rotation = u18.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                    });
                    u34 = FastTween(u18.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                        Scale = 1.5
                    });
                    u34.Completed:Connect(function(p35) -- Line: 410
                        -- upvalues: u18 (ref), ItemImageFinder (ref), i (ref)
                        if p35 == Enum.PlaybackState.Completed then
                            if not u18:IsDescendantOf(game) then
                                return;
                            end;

                            u18.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, "Holdable");
                        end;
                    end);
                end);
                Main_Frame.MouseLeave:Connect(function() -- Line: 421
                    -- upvalues: u33 (ref), u18 (copy), ItemImageFinder (ref), i (copy), v (copy), FastTween (ref)
                    if u33 then
                        u33:Cancel();
                    end;

                    u18.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                    u18.Main_Frame.CanvasGroup.ShopItem_Image.Image = ItemImageFinder(i, v.ItemType);
                    FastTween(u18.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                        Scale = 1
                    });
                end);
            end;

            if v.ItemType == "Seed Pack" and v.ShowOdds then
                Main_Frame.OddsButton.Visible = true;
                Main_Frame.OddsButton.Activated:Connect(function() -- Line: 442
                    -- upvalues: SeedPackOddsController (ref), v (copy), GardenCoinShop_UI (ref)
                    SeedPackOddsController:Open(v.SeedName, GardenCoinShop_UI);
                end);
            elseif v.ItemType == "Egg" and v.ShowOdds then
                Main_Frame.OddsButton.Visible = true;
                Main_Frame.OddsButton.Activated:Connect(function() -- Line: 447
                    -- upvalues: PetEggOddsController (ref), v (copy), GardenCoinShop_UI (ref)
                    PetEggOddsController:Open(v.SeedName, GardenCoinShop_UI);
                end);
            elseif v.ItemType == "Crate" and v.ShowOdds then
                Main_Frame.OddsButton.Visible = true;
                Main_Frame.OddsButton.Activated:Connect(function() -- Line: 452
                    -- upvalues: CosmeticCrateOddsController (ref), v (copy), GardenCoinShop_UI (ref)
                    CosmeticCrateOddsController:Open(v.SeedName, GardenCoinShop_UI);
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

            local function updateOptions() -- Line: 470
                -- upvalues: u2 (ref), i (copy), Frame (copy), FastTween (ref), u27 (copy)
                if u2 == i then
                    Frame.Visible = true;
                    FastTween(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0.5, 1.3)
                    });
                    FastTween(u27, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0.13, 0.25)
                    });

                    return;
                end;

                task.delay(0.25, function() -- Line: 482
                    -- upvalues: Frame (ref)
                    if Frame.Position == UDim2.fromScale(0.5, 0.5) then
                        Frame.Visible = false;
                    end;
                end);
                FastTween(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, 0.5)
                });
                FastTween(u27, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.13, 0.02)
                });
            end;

            u3:Connect(updateOptions);
            task.spawn(updateOptions);
            Main_Frame.Activated:Connect(function() -- Line: 501
                -- upvalues: FastTween (ref), ScrollingFrame (ref), u18 (copy), u17 (copy), u2 (ref), i (copy), u3 (ref)
                FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                    CanvasPosition = Vector2.new(0, u18.AbsoluteSize.Y * (table.find(u17, u18) - 1))
                });
                local v36;

                if u2 == i then
                    v36 = nil;
                else
                    v36 = i;
                end;

                u2 = v36;
                u3:Fire();
            end);
            local u37 = true;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            NumberValue.Parent = Frame;
            NumberValue.Changed:Connect(function(p38: number) -- Line: 546
                -- upvalues: Main_Frame (copy)
                Main_Frame.Stock_Text.Text = `X{p38 // 1} Stock`;
            end);

            local function updateStock() -- Line: 550
                -- upvalues: DataService (ref), i (copy), Main_Frame (copy), v (copy), SetupFrames (ref), u37 (ref), u28 (ref), NumberValue (copy), Spr (ref), Frame (copy), u25 (ref)
                local Data2 = DataService:GetData();
                local v39;

                if Data2 then
                    v39 = Data2.GardenCoinShopStock.Stocks[i];
                else
                    v39 = Data2;
                end;

                local v40 = v39 and v39.Stock or 0;

                if not Main_Frame:FindFirstChild("Stock_Text", true) then
                    return;
                end;

                if v.HideAfterLifetimeLimitReached and (v.LifetimeLimit and (Data2.GardenCoinShopStats.LifetimePurchases[i] or 0) == v.LifetimeLimit) then
                    SetupFrames();

                    return;
                end;

                if u37 or not u28 then
                    u37 = false;
                    NumberValue.Value = v40;
                else
                    Spr.target(NumberValue, 1, 1.5, {
                        Value = v40
                    });
                end;

                Frame.Sheckles_Buy.In_Stock.Visible = v40 > 0;
                Frame.Sheckles_Buy.No_Stock.Visible = v40 <= 0;
                Frame.Sheckles_Buy.HoverImage = v40 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
                Frame.Sheckles_Buy.Image = v40 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";

                if Main_Frame.Cost_Text:FindFirstChild("TEXT") then
                    Main_Frame.Cost_Text.TEXT.Text = v40 <= 0 and "NO STOCK" or u25;
                    local TEXT = Main_Frame.Cost_Text.TEXT;
                    local v41;

                    if v40 <= 0 then
                        v41 = Color3.fromRGB(255, 0, 0);
                    else
                        v41 = Color3.fromRGB(0, 255, 0);
                    end;

                    TEXT.TextColor3 = v41;
                else
                    Main_Frame.Cost_Text.Text = v40 <= 0 and "NO STOCK" or u25;
                    local Cost_Text = Main_Frame.Cost_Text;
                    local v42;

                    if v40 <= 0 then
                        v42 = Color3.fromRGB(255, 0, 0);
                    else
                        v42 = Color3.fromRGB(0, 255, 0);
                    end;

                    Cost_Text.TextColor3 = v42;
                end;

                if Main_Frame.Cost_Text:FindFirstChild("CurrencyImage") and v.SpecialCurrencyType then
                    Main_Frame.Cost_Text.CurrencyImage.Visible = v40 > 0;
                end;
            end;

            task.spawn(updateStock);
            task.spawn(function() -- Line: 597
                -- upvalues: DataService (ref), updateStock (copy), u5 (ref)
                local PathSignal = DataService:GetPathSignal("GardenCoinShopStock/@");

                if PathSignal then
                    local v43 = PathSignal:Connect(updateStock);
                    table.insert(u5, v43);
                end;
            end);
        end;
    end;

    table.sort(u17, function(p44, p45) -- Line: 606
        local LayoutOrder = p44.LayoutOrder;
        local LayoutOrder2 = p45.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p44.Name < p45.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);
end;

function v6.Start(p46) -- Line: 616
    -- upvalues: GuiController (copy), GardenCoinShop_UI (copy), SetupFrames (copy), DataService (copy), CollectionService (copy), ReplicatedStorage (copy)
    GuiController:UsePopupAnims(GardenCoinShop_UI);
    GardenCoinShop_UI.Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 619
        -- upvalues: GuiController (ref), GardenCoinShop_UI (ref)
        GuiController:Close(GardenCoinShop_UI);
    end);
    SetupFrames();
    task.wait(1);
    local Data = DataService:GetData();

    local function UpdateGardenCoinShopVisibility() -- Line: 645
        -- upvalues: CollectionService (ref), Data (copy), ReplicatedStorage (ref)
        for _, v in CollectionService:GetTagged("GardenCoinShop") do
            local v47;

            if Data.GardenCoinShopStats.UnlockedGardenCoins then
                v47 = workspace;
            else
                v47 = ReplicatedStorage;
            end;

            v.Parent = v47;
        end;
    end;

    DataService:GetPathSignal("GardenCoinShopStats/UnlockedGardenCoins"):Connect(UpdateGardenCoinShopVisibility);

    for _, v in CollectionService:GetTagged("GardenCoinShop") do
        local v48;

        if Data.GardenCoinShopStats.UnlockedGardenCoins then
            v48 = workspace;
        else
            v48 = ReplicatedStorage;
        end;

        v.Parent = v48;
    end;
end;

task.spawn(function() -- Line: 655
    -- upvalues: UpdateService (copy), SetupFrames (copy)
    while UpdateService:IsUpdateDone() == false do
        task.wait(1);
    end;

    task.wait(0.5);
    SetupFrames();
end);
task.spawn(v6.Start, v6);

return v6;