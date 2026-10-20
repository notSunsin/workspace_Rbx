-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("ServerScriptService");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local DataService = require(ReplicatedStorage.Modules.DataService);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DecimalNumberFormat = require(ReplicatedStorage.Data.DecimalNumberFormat);
require(ReplicatedStorage.Modules.CommaFormatNumber);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Comma_Module);
local PetEggShopData = require(ReplicatedStorage.Data.PetEggShopData);
local PetEggData = require(ReplicatedStorage.Data.PetEggData);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local Frame_Popup_Module = require(ReplicatedStorage.Frame_Popup_Module);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local PetList = PetRegistry.PetList;
local v1 = {};
local EggModels = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("EggModels");

local function GetTaggedStand(p2: string) -- Line: 42
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged(p2) do
        if v.Parent == workspace.NPCS or v.Parent == script then
            return v;
        end;
    end;

    return nil;
end;

local u3 = GetTaggedStand("PhysicalEggPetStandModel");
local ResetTimeLabel = u3:WaitForChild("Timer"):WaitForChild("SurfaceGui"):WaitForChild("ResetTimeLabel");
local u4 = u3:WaitForChild("RefreshSign"):FindFirstChildWhichIsA("ProximityPrompt", true);
local ConfirmPetEggPurchase = PlayerGui:WaitForChild("ConfirmPetEggPurchase");
local Purchase = ConfirmPetEggPurchase.Container.Content.Purchase;
local GiftButton = Purchase.Gift.GiftButton;
local RobuxButton = Purchase.PurchaseRobux.RobuxButton;
local ShecklesButton = Purchase.PurchaseCash.ShecklesButton;
local PetChanceDetails = Purchase.Display.PetChanceDetails;
local PetItemTemplate = PetChanceDetails.PetItemTemplate;
local u5 = 0;
local u6 = nil;

local function GetRefreshTime() -- Line: 65
    -- upvalues: DataService (copy), PetEggShopData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local v7 = Data.PetEggStock.ForcedEggEndTimestamp and (Data.PetEggStock.ForcedEggEndTimestamp - ServerTimeNow or -1) or -1;

    if v7 >= 0 then
        return v7;
    end;

    return PetEggShopData.RefreshTime - ServerTimeNow % PetEggShopData.RefreshTime;
end;

local function Color3ToHex(p8) -- Line: 77
    local math_floor_ret = math.floor(p8.R * 255);
    local math_floor_ret2 = math.floor(p8.G * 255);
    local math_floor_ret3 = math.floor(p8.B * 255);

    return string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;

local function SetupTimer() -- Line: 84
    -- upvalues: DataService (copy), PetEggShopData (copy), ResetTimeLabel (copy), NumberUtil (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Data = DataService:GetData();
    local v9 = Data.PetEggStock.ForcedEggEndTimestamp and (Data.PetEggStock.ForcedEggEndTimestamp - ServerTimeNow or -1) or -1;

    if v9 < 0 then
        v9 = PetEggShopData.RefreshTime - ServerTimeNow % PetEggShopData.RefreshTime;
    end;

    ResetTimeLabel.Text = v9 <= 0 and "Restocking" or NumberUtil.compactFormat(v9);
    task.wait(1);
end;

local function DeepCopyDictionary(p10) -- Line: 99
    -- upvalues: DeepCopyDictionary (copy)
    local v11 = {};

    for i, v in p10 do
        if type(v) == "table" then
            v11[i] = DeepCopyDictionary(v);
        else
            v11[i] = v;
        end;
    end;

    return v11;
end;

local function GenerateStall() -- Line: 111
    -- upvalues: DataService (copy), GuiController (copy), ConfirmPetEggPurchase (copy), u3 (copy), DeepCopyDictionary (copy), PetEggData (copy), EggModels (copy), PetRegistry (copy), NumberUtil (copy), Purchase (copy), PetChanceDetails (copy), PetItemTemplate (copy), PetList (copy), DecimalNumberFormat (copy), ShecklesButton (copy), MarketController (copy), RobuxButton (copy), u6 (ref), u5 (ref), Frame_Popup_Module (copy)
    local Data = DataService:GetData();
    GuiController:Close(ConfirmPetEggPurchase);
    local Children = u3.EggLocations:GetChildren();

    for _, v in ipairs(Children) do
        if v:IsA("Model") then
            v:Destroy();
        end;
    end;

    local v12 = DeepCopyDictionary(Data.PetEggStock.Stocks);
    table.sort(v12, function(p13, p14) -- Line: 126
        -- upvalues: PetEggData (ref)
        return PetEggData[p13.EggName].StockChance > PetEggData[p14.EggName].StockChance;
    end);

    for i, v in ipairs(v12) do
        local u15 = PetEggData[v.EggName];

        if i > 3 then
            return;
        end;

        if v then
            local v16 = EggModels:FindFirstChild(u15.EggName);

            if v16 then
                local u17 = v16:Clone();
                u17.Parent = u3.EggLocations;
                u17:PivotTo(Children[i].CFrame);
                u17.HitBox.Anchored = true;
                local u18;

                if v.Stock <= 0 then
                    u17:SetAttribute("RobuxEggOnly", true);
                    u18 = i;

                    for _, descendant in u17:GetDescendants() do
                        if descendant:IsA("BasePart") and descendant.Name ~= "HitBox" then
                            descendant.Transparency = 0.65;
                        end;
                    end;
                else
                    u18 = i;
                end;

                local SurfaceGui = Children[u18]:FindFirstChild("SurfaceGui", true);
                local EggNameTextLabel = SurfaceGui:WaitForChild("EggNameTextLabel");
                local RarityTextLabel = SurfaceGui:WaitForChild("RarityTextLabel");
                local PriceTextLabel = SurfaceGui:WaitForChild("PriceTextLabel");
                local v19 = PetRegistry.PetEggs[u15.EggName];
                local v20 = v19 and v19.Color or Color3.new(1, 1, 1);
                EggNameTextLabel.Text = u15.EggName;
                RarityTextLabel.Text = u15.EggRarity;
                RarityTextLabel.TextColor3 = v20;
                PriceTextLabel.Text = `{NumberUtil.DisplaySheckles(u15.Price)}`;
                local ProximityPrompt = Instance.new("ProximityPrompt");
                ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
                ProximityPrompt.Parent = u17;
                ProximityPrompt.ActionText = "Buy Egg";
                ProximityPrompt.HoldDuration = 0;
                ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
                ProximityPrompt.Enabled = true;
                ProximityPrompt.MaxActivationDistance = 6;
                ProximityPrompt.Triggered:Connect(function() -- Line: 195
                    -- upvalues: Purchase (ref), PetRegistry (ref), u15 (copy), PetChanceDetails (ref), PetItemTemplate (ref), PetList (ref), DecimalNumberFormat (ref), ShecklesButton (ref), NumberUtil (ref), MarketController (ref), RobuxButton (ref), u6 (ref), u5 (ref), u18 (copy), u17 (copy), Frame_Popup_Module (ref), ConfirmPetEggPurchase (ref), GuiController (ref)
                    local _ = Purchase.PetName;
                    local Rarity = Purchase.Rarity;
                    local HeaderTitle = Purchase.HeaderTitle;
                    local PetEggs = PetRegistry.PetEggs;

                    if not PetEggs then
                        return warn((`PetEggShopController:GenerateStall | Cannot find Pet Rarity Data for "{u15.EggName}"!`));
                    end;

                    local v21 = PetEggs[u15.EggName];
                    local Color = v21.Color;
                    local Items = v21.RarityData.Items;
                    local math_floor_ret = math.floor(Color.R * 255);
                    local math_floor_ret2 = math.floor(Color.G * 255);
                    local math_floor_ret3 = math.floor(Color.B * 255);
                    local string_format_ret = string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3);
                    Rarity.TextColor3 = Color;
                    HeaderTitle.Text = string.format("Purchase <font color=\"%s\">%s</font>", string_format_ret, u15.EggName);

                    for _, child in PetChanceDetails:GetChildren() do
                        if child:IsA("Frame") and child.Visible then
                            child:Destroy();
                        end;
                    end;

                    for i2, v2 in Items do
                        local v22 = PetItemTemplate:Clone();
                        v22.Parent = PetChanceDetails;
                        v22.Visible = true;

                        if PetList[i2] and PetList[i2].Icon then
                            v22.Detail.PetImageLabel.Image = PetList[i2].Icon;
                        end;

                        v22.PetChance.Text = `{DecimalNumberFormat(v2.NormalizedOdd)}%`;
                        v22.LayoutOrder = 100 / v2.NormalizedOdd;
                        v22.PetName.Text = v2.Name;
                    end;

                    ShecklesButton.Text = NumberUtil.DisplaySheckles(u15.Price);
                    task.spawn(function() -- Line: 238
                        -- upvalues: MarketController (ref), RobuxButton (ref), u15 (ref)
                        MarketController:SetPriceLabel(RobuxButton, u15.PurchaseID, ":robux::value:");
                    end);
                    u6 = u15;
                    u5 = u18;

                    if u17:GetAttribute("RobuxEggOnly") then
                        ShecklesButton.Text = "NO STOCK";
                        ShecklesButton.UIStroke.Color = Color3.fromRGB(85, 0, 0);
                        ShecklesButton.Parent.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
                        ShecklesButton.Parent.UIStroke.Color = Color3.fromRGB(85, 0, 0);
                    else
                        ShecklesButton.Text = NumberUtil.DisplaySheckles(u15.Price);
                        ShecklesButton.UIStroke.Color = Color3.fromRGB(30, 100, 14);
                        ShecklesButton.Parent.BackgroundColor3 = Color3.fromRGB(37, 238, 38);
                        ShecklesButton.Parent.UIStroke.Color = Color3.fromRGB(30, 100, 14);
                    end;

                    ShecklesButton.AutoButtonColor = not u17:GetAttribute("RobuxEggOnly");
                    ShecklesButton.Active = not u17:GetAttribute("RobuxEggOnly");
                    Frame_Popup_Module.Show(ConfirmPetEggPurchase);
                    GuiController:Open(ConfirmPetEggPurchase);
                end);
                ProximityPrompt.PromptShown:Connect(function() -- Line: 263
                    -- upvalues: SurfaceGui (copy)
                    SurfaceGui.Enabled = true;
                end);
                ProximityPrompt.PromptHidden:Connect(function() -- Line: 267
                    -- upvalues: SurfaceGui (copy)
                    SurfaceGui.Enabled = false;
                end);
            else
                warn((`GenerateStall | No egg model found for name "{u15.EggName}"!`));
            end;
        else
            warn((`GenerateStall | No egg found for egg "{u15.EggName}"!`));
        end;
    end;
end;

local function SetupUI() -- Line: 277
    -- upvalues: Purchase (copy), GuiController (copy), ConfirmPetEggPurchase (copy), RobuxButton (copy), MarketController (copy), u6 (ref), GiftButton (copy), GiftController (copy), ShecklesButton (copy), ReplicatedStorage (copy), u5 (ref)
    Purchase.Exit.ExitButton.Activated:Connect(function() -- Line: 280
        -- upvalues: GuiController (ref), ConfirmPetEggPurchase (ref)
        GuiController:Close(ConfirmPetEggPurchase);
    end);
    RobuxButton.Activated:Connect(function() -- Line: 284
        -- upvalues: MarketController (ref), u6 (ref), GuiController (ref), ConfirmPetEggPurchase (ref)
        MarketController:PromptPurchase(u6.PurchaseID, Enum.InfoType.Product);
        GuiController:Close(ConfirmPetEggPurchase);
    end);
    GiftButton.Activated:Connect(function() -- Line: 289
        -- upvalues: u6 (ref), GiftController (ref), GuiController (ref), ConfirmPetEggPurchase (ref)
        if u6.GiftPurchaseID then
            GiftController:PromptGiftFromGiftId(u6.GiftPurchaseID);
        end;

        GuiController:Close(ConfirmPetEggPurchase);
    end);
    ShecklesButton.Activated:Connect(function() -- Line: 296
        -- upvalues: ReplicatedStorage (ref), u5 (ref), GuiController (ref), ConfirmPetEggPurchase (ref)
        ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(u5);
        GuiController:Close(ConfirmPetEggPurchase);
    end);
end;

function v1.Start(p23) -- Line: 302
    -- upvalues: DataService (copy), GenerateStall (copy), SetupUI (copy), u4 (copy), DevProductIds (copy), MarketController (copy), RebirthUnlocksSharedService (copy), LocalPlayer (copy), PetEggShopData (copy), ResetTimeLabel (copy), NumberUtil (copy)
    task.spawn(function() -- Line: 303
        -- upvalues: DataService (ref), GenerateStall (ref)
        local PathSignal = DataService:GetPathSignal("PetEggStock/@");

        if PathSignal then
            PathSignal:Connect(GenerateStall);
        end;

        local PathSignal2 = DataService:GetPathSignal("PetEggStock");

        if PathSignal2 then
            PathSignal2:Connect(GenerateStall);
        end;
    end);
    task.spawn(GenerateStall);
    task.spawn(SetupUI);
    task.spawn(function() -- Line: 318
        -- upvalues: u4 (ref), DevProductIds (ref), MarketController (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
        u4.Triggered:Connect(function() -- Line: 319
            -- upvalues: DevProductIds (ref), MarketController (ref)
            MarketController:PromptPurchase(DevProductIds.RefreshPetShop.PurchaseID, Enum.InfoType.Product);
        end);

        if RebirthUnlocksSharedService:HasUnlockedFeature(LocalPlayer, "PET_STAND") then
            return;
        end;

        u4.Enabled = false;
        local u24 = nil;
        u24 = RebirthUnlocksSharedService.OnRebirthUnlock:Connect(function(p25: userdata, p26: string) -- Line: 329
            -- upvalues: LocalPlayer (ref), u4 (ref), u24 (ref)
            if p25 ~= LocalPlayer then
                return;
            end;

            if p26 ~= "PET_STAND" then
                return;
            end;

            u4.Enabled = true;

            if u24 then
                u24:Disconnect();
                u24 = nil;
            end;
        end);
    end);
    task.spawn(function() -- Line: 342
        -- upvalues: DataService (ref), PetEggShopData (ref), ResetTimeLabel (ref), NumberUtil (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local Data = DataService:GetData();
            local v27 = Data.PetEggStock.ForcedEggEndTimestamp and (Data.PetEggStock.ForcedEggEndTimestamp - ServerTimeNow or -1) or -1;

            if v27 < 0 then
                v27 = PetEggShopData.RefreshTime - ServerTimeNow % PetEggShopData.RefreshTime;
            end;

            ResetTimeLabel.Text = v27 <= 0 and "Restocking" or NumberUtil.compactFormat(v27);
            task.wait(1);
        end;
    end);
end;

task.spawn(v1.Start, v1);
local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
local v28 = ClientABTests.GetAssignmentsAsync(LocalPlayer, true) and ClientABTests.GetAttributes(LocalPlayer);

if v28 then
    local v29 = GetTaggedStand("PetStandModel");
    local v30 = GetTaggedStand("PhysicalEggPetStandModel");
    local v31 = GetTaggedStand("PetMutationMachine");

    if v29 and (v30 and v31) then
        if v28.AB_PhysicalEggShop == true then
            v29.Parent = script;
            v30.Parent = workspace.NPCS;
            v31:PivotTo(CFrame.new(Vector3.new(-242.354, 1.05, 25.4)) * CFrame.fromEulerAngles(0, 90, 0));
        else
            v29.Parent = workspace.NPCS;
            v30.Parent = script;
            v31:PivotTo(CFrame.new(Vector3.new(-242.354, 1.05, 17.4)) * CFrame.fromEulerAngles(0, 90, 0));
        end;
    else
        warn("PetEggShopController | AB shop swap skipped - live stand/machine not found");
    end;
end;

return v1;