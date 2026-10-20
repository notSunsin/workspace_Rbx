-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui;
local MoonCrafting = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("MoonCrafting");
local OpenUI = MoonCrafting:WaitForChild("OpenUI");
local SelectRecipe = MoonCrafting:WaitForChild("SelectRecipe");
local DataService = require(ReplicatedStorage.Modules.DataService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local MoonCraftingConfigAccessor = require(ReplicatedStorage.Modules.Events.HarvestMoonEvent.MoonCrafting.MoonCraftingConfigAccessor);
local MoonCraftingClient = require(ReplicatedStorage.Modules.Events.HarvestMoonEvent.MoonCrafting.MoonCraftingClient);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local GearData = require(ReplicatedStorage.Data.GearData);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetList = PetRegistry.PetList;
local PetEggs = PetRegistry.PetEggs;
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
local MoonCrafting_UI = PlayerGui:WaitForChild("MoonCrafting_UI");
local Frame = MoonCrafting_UI:WaitForChild("Frame");
local ScrollingFrame = Frame:WaitForChild("ScrollingFrame");
local ItemFrame = ScrollingFrame:WaitForChild("ItemFrame");
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemFrame.Parent = script;
ItemPadding.Parent = script;
local u1 = {};
local u2 = {};
local u3 = nil;
local u4 = Signal.new();
local u5 = {};
local u6 = false;

local function FindRegistryDescription(p7: string, p8: string) -- Line: 116
    -- upvalues: PetList (copy), PetEggs (copy), CosmeticList (copy), CosmeticCrates (copy), SeedPackData (copy), GearUtil (copy), GearData (copy)
    if p8 == "Pet" then
        local v9 = PetList[p7];

        if v9 then
            v9 = v9.Description;
        end;

        return v9;
    end;

    if p8 == "PetEgg" or p8 == "Egg" then
        local v10 = PetEggs[p7];

        if v10 then
            v10 = v10.Description;
        end;

        return v10;
    end;

    if p8 == "Cosmetic" then
        local v11 = CosmeticList[p7];

        if v11 then
            v11 = v11.Description;
        end;

        return v11;
    end;

    if p8 == "CosmeticCrate" or p8 == "Crate" then
        local v12 = CosmeticCrates[p7];

        if v12 then
            v12 = v12.Description;
        end;

        return v12;
    end;

    if p8 == "Seed Pack" then
        local v13 = SeedPackData.Packs[p7];

        if v13 then
            v13 = v13.Description;
        end;

        return v13;
    end;

    if not GearUtil.IsItemTypeGear(p8) then
        return nil;
    end;

    local v14 = GearData[p7];

    if v14 then
        v14 = v14.GearDescription;
    end;

    return v14;
end;

local function GetRecipeDescription(p15) -- Line: 140
    -- upvalues: FindRegistryDescription (copy)
    if p15.Description and p15.Description ~= "" then
        return p15.Description;
    end;

    local v16 = p15.Outputs[1];

    return FindRegistryDescription(v16.ItemData.ItemName, v16.ItemType);
end;

local function SetupOddsButton(p17: userdata, p18: any) -- Line: 159
    -- upvalues: SeedPackData (copy), SeedPackOddsController (copy), MoonCrafting_UI (copy), PetEggs (copy), PetEggOddsController (copy), CosmeticCrates (copy), CosmeticCrateOddsController (copy)
    local OddsButton = p17:FindFirstChild("OddsButton");

    if not OddsButton then
        return false;
    end;

    OddsButton.Visible = false;
    local v19 = p18.Outputs[1];
    local ItemName = v19.ItemData.ItemName;
    local v20 = nil;
    local v21;

    if v19.ItemType == "Seed Pack" and SeedPackData.Packs[ItemName] then
        v21 = function() -- Line: 173
            -- upvalues: SeedPackOddsController (ref), ItemName (copy), MoonCrafting_UI (ref)
            SeedPackOddsController:Open(ItemName, MoonCrafting_UI);
        end;
    elseif v19.ItemType == "PetEgg" and PetEggs[ItemName] then
        v21 = function() -- Line: 177
            -- upvalues: PetEggOddsController (ref), ItemName (copy), MoonCrafting_UI (ref)
            PetEggOddsController:Open(ItemName, MoonCrafting_UI);
        end;
    else
        v21 = v19.ItemType == "CosmeticCrate" and CosmeticCrates[ItemName] and function() -- Line: 181
            -- upvalues: CosmeticCrateOddsController (ref), ItemName (copy), MoonCrafting_UI (ref)
            CosmeticCrateOddsController:Open(ItemName, MoonCrafting_UI);
        end or v20;
    end;

    if not v21 then
        return false;
    end;

    OddsButton.Visible = true;
    OddsButton.Activated:Connect(v21);

    return true;
end;

local function AddIngredientRow(p22: userdata, p23: userdata, p24: string?, p25: string, p26: string?) -- Line: 198
    local v27 = p23:Clone();
    v27.Parent = p22;
    v27.Visible = true;

    if p24 then
        v27.Detail.ItemImageLabel.Image = p24;
    end;

    v27.Detail.ItemImageLabel.Visible = true;
    v27.ItemName.Text = p25;

    if not p26 then
        v27.ItemAmount.Visible = false;

        return v27;
    end;

    v27.ItemAmount.Text = p26;
    v27.ItemAmount.Visible = true;

    return v27;
end;

local function ApplyLockState(p28: userdata, p29: userdata, p30: any, p31: boolean, p32: boolean) -- Line: 236
    -- upvalues: MoonCraftingClient (copy), MoonCraftingConfigAccessor (copy)
    local RemainingSummonContributions = MoonCraftingConfigAccessor:GetRemainingSummonContributions(p30, (MoonCraftingClient:GetSummonsContributed()));
    local v33 = RemainingSummonContributions > 0;
    p29.Visible = v33;
    p28.Interactable = not v33;

    if v33 then
        local TextLabel = p29:FindFirstChild("TextLabel");

        if TextLabel and TextLabel:IsA("TextLabel") then
            TextLabel.Text = MoonCraftingConfigAccessor:GetLockedText(RemainingSummonContributions);
        end;
    end;

    local InfoButton = p28:FindFirstChild("InfoButton");

    if InfoButton then
        InfoButton.Visible = not v33 and p31;
    end;

    local OddsButton = p28:FindFirstChild("OddsButton");

    if OddsButton then
        OddsButton.Visible = not v33 and p32;
    end;

    return v33;
end;

local function IsRecipeHiddenForUpdate(p34: string) -- Line: 271
    -- upvalues: UpdateService (copy)
    local v35 = `MoonCrafting/{p34}`;

    return UpdateService:IsHiddenFromUpdate(p34) or UpdateService:IsHiddenAfterUpdate(p34) or (UpdateService:IsHiddenFromUpdate(v35) or UpdateService:IsHiddenAfterUpdate(v35));
end;

local function BuildRecipeCard(u36: any, u37: number) -- Line: 280
    -- upvalues: ItemFrame (copy), WaitForDescendant (copy), ItemImageFinder (copy), CurrencyData (copy), NumberUtil (copy), MoonCraftingConfigAccessor (copy), FindRegistryDescription (copy), SetupOddsButton (copy), ApplyLockState (copy), u5 (copy), SeedData (copy), FastTween (copy), SelectRecipe (copy), GuiController (copy), MoonCrafting_UI (copy), MarketController (copy), ItemPadding (copy), u3 (ref), u4 (copy), ScrollingFrame (copy), UseDynamicPrices (copy), Comma_Module (copy)
    local u38 = ItemFrame:Clone();
    u38.Name = u36.Id;
    u38.LayoutOrder = (u36.LayoutOrder or 0) * 2;
    local Main_Frame = u38.Main_Frame;
    local Frame2 = u38.Frame;
    local v39 = WaitForDescendant(u38, "RecipeDetails");
    local v40 = WaitForDescendant(u38, "RequiredItemTemplate");

    for _, v in u36.Inputs do
        local v41 = v.ItemType == "Seed" and " Seed" or "";
        local v42 = ItemImageFinder(v.ItemData.ItemName, v.ItemType);
        local v43 = `{v.ItemData.ItemName}{v41}`;
        local v44 = v40:Clone();
        v44.Parent = v39;
        v44.Visible = true;

        if v42 then
            v44.Detail.ItemImageLabel.Image = v42;
        end;

        v44.Detail.ItemImageLabel.Visible = true;
        v44.ItemName.Text = v43;
        v44.ItemAmount.Visible = false;
    end;

    local v45 = u36.Cost and u36.Cost.Amount > 0 and CurrencyData[u36.Cost.CurrencyType];

    if v45 then
        local Icon = v45.Icon;
        local CurrencyName = v45.CurrencyName;
        local v46 = `x{NumberUtil.FormatSheckles(u36.Cost.Amount)}`;
        local v47 = v40:Clone();
        v47.Parent = v39;
        v47.Visible = true;

        if Icon then
            v47.Detail.ItemImageLabel.Image = Icon;
        end;

        v47.Detail.ItemImageLabel.Visible = true;
        v47.ItemName.Text = CurrencyName;

        if v46 then
            v47.ItemAmount.Text = v46;
            v47.ItemAmount.Visible = true;
        else
            v47.ItemAmount.Visible = false;
        end;

        v47.Detail.ItemImageLabel.ImageColor3 = v45.Color;
    end;

    local v48 = u36.Outputs[1];
    local v49 = v48.ItemData.Quantity or 1;
    local RecipeDisplayName = MoonCraftingConfigAccessor:GetRecipeDisplayName(u36);

    if v49 > 1 then
        RecipeDisplayName = `{RecipeDisplayName} x{v49}`;
    end;

    Main_Frame.CanvasGroup.Item_Text.Text = RecipeDisplayName;
    Main_Frame.CanvasGroup.Item_Text_Shadow.Text = RecipeDisplayName;
    local v50 = `{MoonCraftingConfigAccessor:GetUIText("CraftTimeLabel", "Craft Time")}: {NumberUtil.compactFormat(u36.TimeToCraft)}`;
    Main_Frame.Cost_Text.Text = v50;
    Main_Frame.Cost_Text_Shadow.Text = v50;
    local v51;

    if u36.Description and u36.Description ~= "" then
        v51 = u36.Description;
    else
        local v52 = u36.Outputs[1];
        v51 = FindRegistryDescription(v52.ItemData.ItemName, v52.ItemType);
    end;

    Main_Frame.LargeDescriptionText.Visible = false;

    if v51 then
        Main_Frame.LargeDescriptionText.Text = v51;
        Main_Frame.InfoButton.Visible = true;
        local u53 = false;
        Main_Frame.InfoButton.Activated:Connect(function() -- Line: 341
            -- upvalues: u53 (ref), Main_Frame (copy)
            u53 = not u53;
            Main_Frame.LargeDescriptionText.Visible = u53;
            Main_Frame.Cost_Text.Visible = not u53;
            Main_Frame.Display.Visible = not u53;
        end);
    else
        Main_Frame.InfoButton.Visible = false;
    end;

    local v54 = u36.IconItemName or v48.ItemData.ItemName;
    local u55 = ItemImageFinder(v54, u36.IconItemType or v48.ItemType);
    local ShopItem_Image = Main_Frame.CanvasGroup.ShopItem_Image;
    ShopItem_Image.Visible = true;

    if u55 then
        ShopItem_Image.Image = u55;
    end;

    local u56 = SetupOddsButton(Main_Frame, u36);
    local Overlay = Main_Frame:FindFirstChild("Overlay");

    if Overlay and Overlay:IsA("Frame") then
        local u57 = v51 ~= nil;
        ApplyLockState(Main_Frame, Overlay, u36, u57, u56);
        table.insert(u5, function() -- Line: 384, Name: RefreshLock
            -- upvalues: u38 (copy), ApplyLockState (ref), Main_Frame (copy), Overlay (copy), u36 (copy), u57 (copy), u56 (copy)
            if not u38:IsDescendantOf(game) then
                return;
            end;

            ApplyLockState(Main_Frame, Overlay, u36, u57, u56);
        end);
    else
        warn((`[MoonCrafting] MoonCrafting_UI ItemFrame.Main_Frame has no "Overlay" Frame; recipe "{u36.Id}" cannot show its locked state.`));
    end;

    if v48.ItemType == "Seed" then
        local u58 = SeedData[v54];

        if u58 then
            u58 = u58.FruitIcon;
        end;

        if u58 then
            local u59 = nil;
            Main_Frame.MouseEnter:Connect(function() -- Line: 408
                -- upvalues: Main_Frame (copy), u59 (ref), FastTween (ref), ShopItem_Image (copy), u38 (copy), u58 (copy)
                if not Main_Frame.Interactable then
                    return;
                end;

                u59 = FastTween(ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                    Rotation = ShopItem_Image.Rotation + 10
                });
                FastTween(ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                    Scale = 1.5
                }).Completed:Connect(function(p60) -- Line: 425
                    -- upvalues: u38 (ref), ShopItem_Image (ref), u58 (ref)
                    if p60 ~= Enum.PlaybackState.Completed or not u38:IsDescendantOf(game) then
                        return;
                    end;

                    ShopItem_Image.Image = u58;
                end);
            end);
            Main_Frame.MouseLeave:Connect(function() -- Line: 435
                -- upvalues: Main_Frame (copy), u59 (ref), ShopItem_Image (copy), u55 (copy), FastTween (ref)
                if not Main_Frame.Interactable then
                    return;
                end;

                if u59 then
                    u59:Cancel();
                end;

                ShopItem_Image.Rotation = 0;
                ShopItem_Image.Image = u55;
                FastTween(ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                    Scale = 1
                });
            end);
        end;
    end;

    Frame2.CraftButton.Activated:Connect(function() -- Line: 457
        -- upvalues: SelectRecipe (ref), u36 (copy), GuiController (ref), MoonCrafting_UI (ref)
        SelectRecipe:Fire(u36.Id);
        GuiController:Close(MoonCrafting_UI);
    end);
    local u61 = u36.PurchaseID or 0;
    local u62 = u61 ~= 0;
    Frame2.Robux_Buy.Visible = u62;

    if u62 then
        Frame2.Robux_Buy.Activated:Connect(function() -- Line: 468
            -- upvalues: MarketController (ref), u61 (copy)
            MarketController:PromptPurchase(u61, Enum.InfoType.Product);
        end);
    end;

    local u63 = ItemPadding:Clone();
    u63.Name = `{u36.Id}_Padding`;
    u63.LayoutOrder = u38.LayoutOrder + 1;

    local function UpdateExpanded() -- Line: 478
        -- upvalues: u3 (ref), u36 (copy), Frame2 (copy), FastTween (ref), u63 (copy)
        if u3 == u36.Id then
            Frame2.Visible = true;
            FastTween(Frame2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 1.3)
            });
            FastTween(u63, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0.13, 0.25)
            });

            return;
        end;

        task.delay(0.25, function() -- Line: 491
            -- upvalues: Frame2 (ref)
            if Frame2.Parent and Frame2.Position == UDim2.fromScale(0.5, 0.5) then
                Frame2.Visible = false;
            end;
        end);
        FastTween(Frame2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        });
        FastTween(u63, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0.13, 0.02)
        });
    end;

    u4:Connect(UpdateExpanded);
    task.spawn(UpdateExpanded);
    local u64 = false;
    Main_Frame.Activated:Connect(function() -- Line: 511
        -- upvalues: FastTween (ref), ScrollingFrame (ref), u38 (copy), u37 (copy), u3 (ref), u36 (copy), u4 (ref), u64 (ref), u62 (copy), UseDynamicPrices (ref), MarketController (ref), Frame2 (copy), u61 (copy), Comma_Module (ref)
        FastTween(ScrollingFrame, TweenInfo.new(0.35), {
            CanvasPosition = Vector2.new(0, u38.AbsoluteSize.Y * (u37 - 1))
        });
        local v65;

        if u3 == u36.Id then
            v65 = nil;
        else
            v65 = u36.Id;
        end;

        u3 = v65;
        u4:Fire();

        if not u64 and u62 then
            if UseDynamicPrices or u36.RobuxPrice == nil then
                MarketController:SetPriceLabel(Frame2.Robux_Buy.Price, u61, ":robux::value:");
            else
                Frame2.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma(u36.RobuxPrice)}`;
            end;

            u64 = true;
        end;
    end);

    return u38, u63;
end;

local function ClearFrames() -- Line: 536
    -- upvalues: u2 (copy), u4 (copy), u3 (ref), u5 (copy)
    for _, v in u2 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u2);
    u4:DisconnectAll();
    u3 = nil;
    table.clear(u5);
end;

local function SetupFrames() -- Line: 553
    -- upvalues: ClearFrames (copy), MoonCraftingConfigAccessor (copy), DataService (copy), UpdateService (copy), BuildRecipeCard (copy), ScrollingFrame (copy), u2 (copy)
    ClearFrames();
    local Recipes = MoonCraftingConfigAccessor:GetRecipes();

    if #Recipes == 0 then
        warn("[MoonCrafting] MoonCraftingConfig.Recipes is empty; nothing to show.");

        return;
    end;

    local Data = DataService:GetData();
    local v66 = Data and Data.UnlockedRecipes or {};
    local v67 = 0;

    for _, v in Recipes do
        if v.DisplayInCrafting ~= false then
            local Id = v.Id;
            local v68 = `MoonCrafting/{Id}`;

            if not (UpdateService:IsHiddenFromUpdate(Id) or UpdateService:IsHiddenAfterUpdate(Id) or (UpdateService:IsHiddenFromUpdate(v68) or UpdateService:IsHiddenAfterUpdate(v68)) or v.IsUnlockable and not table.find(v66, v.Id)) then
                v67 = v67 + 1;
                local v69, v70 = BuildRecipeCard(v, v67);
                v69.Parent = ScrollingFrame;
                v70.Parent = ScrollingFrame;
                table.insert(u2, v69);
                table.insert(u2, v70);
            end;
        end;
    end;
end;

function u1.Open(p71) -- Line: 594
    -- upvalues: SetupFrames (copy), GuiController (copy), MoonCrafting_UI (copy)
    SetupFrames();
    GuiController:Open(MoonCrafting_UI);
end;

function u1.Close(p72) -- Line: 599
    -- upvalues: GuiController (copy), MoonCrafting_UI (copy)
    GuiController:Close(MoonCrafting_UI);
end;

function u1.Start(p73) -- Line: 603
    -- upvalues: u6 (ref), Frame (copy), MoonCraftingConfigAccessor (copy), GuiController (copy), MoonCrafting_UI (copy), u1 (copy), OpenUI (copy), UpdateService (copy), SetupFrames (copy), DataService (copy), u5 (copy)
    if u6 then
        return;
    end;

    u6 = true;
    Frame.Frame.Title.Text = MoonCraftingConfigAccessor:GetUIText("Title", "Moon Crafting");
    GuiController:UsePopupAnims(MoonCrafting_UI);
    Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 613
        -- upvalues: u1 (ref)
        u1:Close();
    end);
    OpenUI.Event:Connect(function() -- Line: 617
        -- upvalues: u1 (ref)
        u1:Open();
    end);
    UpdateService.OnUpdated:Connect(function() -- Line: 621
        -- upvalues: SetupFrames (ref)
        SetupFrames();
    end);
    task.spawn(function() -- Line: 633
        -- upvalues: DataService (ref), u5 (ref)
        local PathSignal = DataService:GetPathSignal("HarvestMoonData/SummonsContributed");

        if not PathSignal then
            return;
        end;

        PathSignal:Connect(function() -- Line: 640
            -- upvalues: u5 (ref)
            for _, v in u5 do
                v();
            end;
        end);
    end);
end;

return u1;