-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.DumpTable);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.GiftController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.WaitForDescendant);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Item_Module);
local NumberUtil2 = require(ReplicatedStorage.Modules.NumberUtil);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
require(ReplicatedStorage.Modules.ItemImageFinder);
local StringUtils = require(ReplicatedStorage.Modules.StringUtils);
local CosmeticRegistry = require(ReplicatedStorage.Data.CosmeticRegistry);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
require(ReplicatedStorage.Data.SeedData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.GearData);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local CosmeticCrateRegistry = require(ReplicatedStorage.Data.CosmeticCrateRegistry);
local CraftingRecipeRegistry = require(ReplicatedStorage.Data.CraftingData.CraftingRecipeRegistry);
require(ReplicatedStorage.Modules.GearUtil);
local ItemDescriptionFinder = require(ReplicatedStorage.Modules.ItemDescriptionFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
require(ReplicatedStorage.Modules.ColorHelper);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local SelectCraftingRecipeBindableEvent = GameEvents.SelectCraftingRecipeBindableEvent;
local OpenRecipeBindableEvent = GameEvents.OpenRecipeBindableEvent;
local _ = CosmeticRegistry.CosmeticList;
local CosmeticCrates = CosmeticCrateRegistry.CosmeticCrates;
local _ = PetRegistry.PetList;
local PetEggs = PetRegistry.PetEggs;
local LocalPlayer = game.Players.LocalPlayer;
local RecipeSelection_UI = LocalPlayer.PlayerGui:WaitForChild("RecipeSelection_UI");
local ScrollingFrame = RecipeSelection_UI.Frame.ScrollingFrame;
local ItemFrame = ScrollingFrame.ItemFrame;
ItemFrame.Parent = script;
local ItemPadding = ScrollingFrame:WaitForChild("ItemPadding");
ItemPadding.Parent = ScrollingFrame;
local u1 = nil;
local u2 = nil;
local u3 = Signal.new();
local u4 = nil;
local u5 = {};
local u6 = {};
local v7 = {};

local function SetCFrame(p8: userdata, p9) -- Line: 76
    if not p8:IsA("Model") then
        if p8:IsA("BasePart") then
            p8.CFrame = p9;
        end;

        return;
    end;

    p8:PivotTo(p9);
    p8:ScaleTo(0.5);
end;

local function SetOrientation(p10: userdata, p11: vector) -- Line: 86
    if p10:IsA("BasePart") then
        p10.Orientation = p11;
    end;
end;

local function GetOrientation(p12: userdata) -- Line: 93
    return not p12:IsA("BasePart") and Vector3.new(0, 0, 0) or p12.Orientation;
end;

local function SetupFrames(p13: string) -- Line: 100
    -- upvalues: DataService (copy), LocalPlayer (copy), CraftingRecipeRegistry (copy), u5 (copy), u6 (copy), EventRotationController (copy), EventRotationUtils (copy), UpdateService (copy), ItemFrame (copy), ItemImageFinder (copy), CurrencyData (copy), NumberUtil2 (copy), NumberUtil (copy), ItemDescriptionFinder (copy), ScrollingFrame (copy), ItemPadding (copy), SelectCraftingRecipeBindableEvent (copy), u4 (ref), MarketController (copy), StringUtils (copy), FastTween (copy), SeedPackData (copy), SeedPackOddsController (copy), RecipeSelection_UI (copy), PetEggs (copy), PetEggOddsController (copy), CosmeticCrates (copy), CosmeticCrateOddsController (copy), u2 (ref), u3 (copy), UseDynamicPrices (copy), Comma_Module (copy)
    local Data = DataService:GetData();

    if not Data then
        return warn((`No PlayerData for {LocalPlayer}!`));
    end;

    local v14 = CraftingRecipeRegistry.RecipiesSortedByMachineType[p13];

    if not v14 then
        return warn("CraftingRecipeUIController:SetupFrames| Cannot find valid Crafting Station Type");
    end;

    for _, v in u5 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    for _, v in u6 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    for i, v in v14 do
        if v.DisplayInCrafting ~= false and (not v.IsUnlockable or table.find(Data.UnlockedRecipes, i)) then
            local v15, v16, v17, v18, v19, u20, v21, v22, u23, u24, v25, v26, v27, v28, u29, v30, v31, v32, u33, u34, u35, u36, v37, u38, u39, u40, u41, u42, v43, v44, u45;

            if v.EventConfig then
                local LoadedEvent = EventRotationController:GetLoadedEvent();

                if LoadedEvent and LoadedEvent.EventSet == v.EventConfig.EventSet then
                    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(v.EventConfig.EventID, v.EventConfig.EventSet);

                    if EventInSetIndex and EventRotationController:IsPastEventIDIndex(EventInSetIndex) then
                        v15 = v.Inputs;
                        v16 = v.Outputs[1];
                        v17 = v.TimeToCraft;
                        v18 = v16.ItemData.ItemName;
                        v19 = v16.ItemType;

                        if not (UpdateService:IsHiddenFromUpdate(i) or UpdateService:IsHiddenAfterUpdate(i)) then
                            u20 = ItemFrame:Clone();
                            v21 = u20.Main_Frame.Display.RecipeDetails;
                            v22 = v21.RequiredItemTemplate;
                            u23 = i;
                            u24 = v;

                            for _, v2 in v15 do
                                v25 = v22:Clone();
                                v25.Parent = v21;
                                v25.Visible = true;
                                v26 = ItemImageFinder(v2.ItemData.ItemName, v2.ItemType);

                                if v26 then
                                    v25.Detail.ItemImageLabel.Image = v26;
                                end;

                                v25.Detail.ItemImageLabel.Visible = true;
                                v25.ItemName.Text = `{v2.ItemData.ItemName}{v2.ItemType == "Seed" and " Seed" or ""}`;
                                v25.ItemAmount.Visible = false;
                            end;

                            v27 = u24.Cost and CurrencyData[u24.Cost.CurrencyType];

                            if v27 then
                                v28 = v22:Clone();
                                v28.Parent = v21;
                                v28.Visible = true;
                                v28.ItemName.Text = v27.CurrencyName;
                                v28.ItemAmount.Text = "x" .. NumberUtil2.FormatSheckles(u24.Cost.Amount);
                                v28.Detail.ItemImageLabel.Image = v27.Icon;
                                v28.Detail.ItemImageLabel.Visible = true;
                                v28.Detail.ItemImageLabel.ImageColor3 = v27.Color;
                            end;

                            table.insert(u5, u20);
                            u20.Name = v18;
                            u20.LayoutOrder = u24.LayoutOrder;
                            u29 = u20.Main_Frame;
                            v30 = v16.ItemData.Quantity or 1;

                            if v30 > 1 then
                                v31 = `{v18} x{v30}`;
                            else
                                v31 = v18;
                            end;

                            u29.CanvasGroup.Item_Text.Text = v31;
                            u29.CanvasGroup.Item_Text_Shadow.Text = v31;
                            u29.Cost_Text.Text = `Craft Time: {NumberUtil.compactFormat(v17)}`;
                            u29.Cost_Text_Shadow.Text = `Craft Time: {NumberUtil.compactFormat(v17)}`;
                            v32 = ItemDescriptionFinder(v18, v19);

                            if #v32 > 0 then
                                u29.LargeDescriptionText.Text = v32;
                                u29.InfoButton.Visible = true;
                            else
                                u29.InfoButton.Visible = false;
                            end;

                            u29.LargeDescriptionText.Visible = false;
                            u33 = false;
                            u29.InfoButton.Activated:Connect(function() -- Line: 228, Name: ToggleDescriptionVisibility
                                -- upvalues: u33 (ref), u29 (copy)
                                u33 = not u33;
                                u29.LargeDescriptionText.Visible = u33;
                                u29.Cost_Text.Visible = not u33;
                                u29.Display.Visible = not u33;
                            end);
                            u29:FindFirstChild("ShopItem_Image", true).Visible = true;
                            u20.Parent = ScrollingFrame;
                            u34 = ItemPadding:Clone();
                            u34.LayoutOrder = u24.LayoutOrder + 1;
                            u34.Name = `{u23}_Padding`;
                            u34.Parent = ScrollingFrame;
                            table.insert(u6, u34);
                            u35 = u20.Frame;
                            u35.CraftButton.Activated:Connect(function() -- Line: 252
                                -- upvalues: SelectCraftingRecipeBindableEvent (ref), u4 (ref), u23 (copy), u24 (copy)
                                SelectCraftingRecipeBindableEvent:Fire(u4, u23, u24);
                            end);
                            u36 = u24.PurchaseID ~= 0;
                            u35.Robux_Buy.Visible = u36;

                            if u36 then
                                u35.Robux_Buy.Activated:Connect(function() -- Line: 260
                                    -- upvalues: MarketController (ref), u24 (copy)
                                    MarketController:PromptPurchase(u24.PurchaseID, Enum.InfoType.Product);
                                end);
                            end;

                            v37 = StringUtils:NormalizeRecipeName(u23);
                            u38 = ItemImageFinder(v37, v19);

                            if u38 then
                                u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = u38;
                            end;

                            if v16.ItemType == "Seed" then
                                u39 = nil;
                                u40 = nil;
                                u41 = ItemImageFinder(v37, "Fruit");
                                u29.MouseEnter:Connect(function() -- Line: 276
                                    -- upvalues: u39 (ref), FastTween (ref), u20 (copy), u40 (ref), u41 (copy)
                                    u39 = FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                                        Rotation = u20.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                                    });
                                    u40 = FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                        Scale = 1.5
                                    });
                                    u40.Completed:Connect(function(p46) -- Line: 292
                                        -- upvalues: u20 (ref), u41 (ref)
                                        if p46 == Enum.PlaybackState.Completed then
                                            if not u20:IsDescendantOf(game) then
                                                return;
                                            end;

                                            u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = u41;
                                        end;
                                    end);
                                end);
                                u29.MouseLeave:Connect(function() -- Line: 301
                                    -- upvalues: u39 (ref), u20 (copy), u38 (copy), FastTween (ref)
                                    if u39 then
                                        u39:Cancel();
                                    end;

                                    u20.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                                    u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = u38;
                                    FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                        Scale = 1
                                    });
                                end);
                            end;

                            u42 = v16.ItemData.ItemName;
                            v43 = u29:FindFirstChild("OddsButton");

                            if v43 then
                                v43.Visible = false;

                                if v16.ItemType == "Seed Pack" and SeedPackData.Packs[u42] then
                                    v43.Visible = true;
                                    v43.Activated:Connect(function() -- Line: 327
                                        -- upvalues: SeedPackOddsController (ref), u42 (copy), RecipeSelection_UI (ref)
                                        SeedPackOddsController:Open(u42, RecipeSelection_UI);
                                    end);
                                elseif v16.ItemType == "PetEgg" and PetEggs[u42] then
                                    v43.Visible = true;
                                    v43.Activated:Connect(function() -- Line: 332
                                        -- upvalues: PetEggOddsController (ref), u42 (copy), RecipeSelection_UI (ref)
                                        PetEggOddsController:Open(u42, RecipeSelection_UI);
                                    end);
                                elseif v16.ItemType == "CosmeticCrate" and CosmeticCrates[u42] then
                                    v43.Visible = true;
                                    v43.Activated:Connect(function() -- Line: 337
                                        -- upvalues: CosmeticCrateOddsController (ref), u42 (copy), RecipeSelection_UI (ref)
                                        CosmeticCrateOddsController:Open(u42, RecipeSelection_UI);
                                    end);
                                end;
                            end;

                            v44 = function() -- Line: 343, Name: updateOptions
                                -- upvalues: u2 (ref), u23 (copy), u35 (copy), FastTween (ref), u34 (copy)
                                if u2 == u23 then
                                    u35.Visible = true;
                                    FastTween(u35, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Position = UDim2.fromScale(0.5, 1.3)
                                    });
                                    FastTween(u34, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Size = UDim2.fromScale(0.13, 0.25)
                                    });

                                    return;
                                end;

                                task.delay(0.25, function() -- Line: 354
                                    -- upvalues: u35 (ref)
                                    if u35.Position == UDim2.fromScale(0.5, 0.5) then
                                        u35.Visible = false;
                                    end;
                                end);
                                FastTween(u35, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Position = UDim2.fromScale(0.5, 0.5)
                                });
                                FastTween(u34, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Size = UDim2.fromScale(0.13, 0.02)
                                });
                            end;

                            u3:Connect(v44);
                            task.spawn(v44);
                            u45 = false;
                            u29.Activated:Connect(function() -- Line: 373
                                -- upvalues: FastTween (ref), ScrollingFrame (ref), u20 (copy), u5 (ref), u2 (ref), u23 (copy), u3 (ref), u45 (ref), u36 (copy), UseDynamicPrices (ref), u24 (copy), u35 (copy), MarketController (ref), Comma_Module (ref)
                                FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                                    CanvasPosition = Vector2.new(0, u20.AbsoluteSize.Y * (table.find(u5, u20) - 1))
                                });
                                local v47;

                                if u2 == u23 then
                                    v47 = nil;
                                else
                                    v47 = u23;
                                end;

                                u2 = v47;
                                u3:Fire();

                                if not u45 and u36 then
                                    if UseDynamicPrices or u24.RobuxPrice == nil then
                                        if not UseDynamicPrices then
                                            warn((`{u35:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                        end;

                                        MarketController:SetPriceLabel(u35.Robux_Buy.Price, u24.PurchaseID, ":robux::value:");
                                    else
                                        u35.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma((`{u24.RobuxPrice}`))}`;
                                    end;

                                    u45 = true;
                                end;
                            end);
                        end;
                    end;
                end;
            else
                v15 = v.Inputs;
                v16 = v.Outputs[1];
                v17 = v.TimeToCraft;
                v18 = v16.ItemData.ItemName;
                v19 = v16.ItemType;

                if not (UpdateService:IsHiddenFromUpdate(i) or UpdateService:IsHiddenAfterUpdate(i)) then
                    u20 = ItemFrame:Clone();
                    v21 = u20.Main_Frame.Display.RecipeDetails;
                    v22 = v21.RequiredItemTemplate;
                    u23 = i;
                    u24 = v;

                    for _, v2 in v15 do
                        v25 = v22:Clone();
                        v25.Parent = v21;
                        v25.Visible = true;
                        v26 = ItemImageFinder(v2.ItemData.ItemName, v2.ItemType);

                        if v26 then
                            v25.Detail.ItemImageLabel.Image = v26;
                        end;

                        v25.Detail.ItemImageLabel.Visible = true;
                        v25.ItemName.Text = `{v2.ItemData.ItemName}{v2.ItemType == "Seed" and " Seed" or ""}`;
                        v25.ItemAmount.Visible = false;
                    end;

                    v27 = u24.Cost and CurrencyData[u24.Cost.CurrencyType];

                    if v27 then
                        v28 = v22:Clone();
                        v28.Parent = v21;
                        v28.Visible = true;
                        v28.ItemName.Text = v27.CurrencyName;
                        v28.ItemAmount.Text = "x" .. NumberUtil2.FormatSheckles(u24.Cost.Amount);
                        v28.Detail.ItemImageLabel.Image = v27.Icon;
                        v28.Detail.ItemImageLabel.Visible = true;
                        v28.Detail.ItemImageLabel.ImageColor3 = v27.Color;
                    end;

                    table.insert(u5, u20);
                    u20.Name = v18;
                    u20.LayoutOrder = u24.LayoutOrder;
                    u29 = u20.Main_Frame;
                    v30 = v16.ItemData.Quantity or 1;

                    if v30 > 1 then
                        v31 = `{v18} x{v30}`;
                    else
                        v31 = v18;
                    end;

                    u29.CanvasGroup.Item_Text.Text = v31;
                    u29.CanvasGroup.Item_Text_Shadow.Text = v31;
                    u29.Cost_Text.Text = `Craft Time: {NumberUtil.compactFormat(v17)}`;
                    u29.Cost_Text_Shadow.Text = `Craft Time: {NumberUtil.compactFormat(v17)}`;
                    v32 = ItemDescriptionFinder(v18, v19);

                    if #v32 > 0 then
                        u29.LargeDescriptionText.Text = v32;
                        u29.InfoButton.Visible = true;
                    else
                        u29.InfoButton.Visible = false;
                    end;

                    u29.LargeDescriptionText.Visible = false;
                    u33 = false;
                    u29.InfoButton.Activated:Connect(function() -- Line: 228, Name: ToggleDescriptionVisibility
                        -- upvalues: u33 (ref), u29 (copy)
                        u33 = not u33;
                        u29.LargeDescriptionText.Visible = u33;
                        u29.Cost_Text.Visible = not u33;
                        u29.Display.Visible = not u33;
                    end);
                    u29:FindFirstChild("ShopItem_Image", true).Visible = true;
                    u20.Parent = ScrollingFrame;
                    u34 = ItemPadding:Clone();
                    u34.LayoutOrder = u24.LayoutOrder + 1;
                    u34.Name = `{u23}_Padding`;
                    u34.Parent = ScrollingFrame;
                    table.insert(u6, u34);
                    u35 = u20.Frame;
                    u35.CraftButton.Activated:Connect(function() -- Line: 252
                        -- upvalues: SelectCraftingRecipeBindableEvent (ref), u4 (ref), u23 (copy), u24 (copy)
                        SelectCraftingRecipeBindableEvent:Fire(u4, u23, u24);
                    end);
                    u36 = u24.PurchaseID ~= 0;
                    u35.Robux_Buy.Visible = u36;

                    if u36 then
                        u35.Robux_Buy.Activated:Connect(function() -- Line: 260
                            -- upvalues: MarketController (ref), u24 (copy)
                            MarketController:PromptPurchase(u24.PurchaseID, Enum.InfoType.Product);
                        end);
                    end;

                    v37 = StringUtils:NormalizeRecipeName(u23);
                    u38 = ItemImageFinder(v37, v19);

                    if u38 then
                        u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = u38;
                    end;

                    if v16.ItemType == "Seed" then
                        u39 = nil;
                        u40 = nil;
                        u41 = ItemImageFinder(v37, "Fruit");
                        u29.MouseEnter:Connect(function() -- Line: 276
                            -- upvalues: u39 (ref), FastTween (ref), u20 (copy), u40 (ref), u41 (copy)
                            u39 = FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0), {
                                Rotation = u20.Main_Frame.CanvasGroup.ShopItem_Image.Rotation + 10
                            });
                            u40 = FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                Scale = 1.5
                            });
                            u40.Completed:Connect(function(p46) -- Line: 292
                                -- upvalues: u20 (ref), u41 (ref)
                                if p46 == Enum.PlaybackState.Completed then
                                    if not u20:IsDescendantOf(game) then
                                        return;
                                    end;

                                    u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = u41;
                                end;
                            end);
                        end);
                        u29.MouseLeave:Connect(function() -- Line: 301
                            -- upvalues: u39 (ref), u20 (copy), u38 (copy), FastTween (ref)
                            if u39 then
                                u39:Cancel();
                            end;

                            u20.Main_Frame.CanvasGroup.ShopItem_Image.Rotation = 0;
                            u20.Main_Frame.CanvasGroup.ShopItem_Image.Image = u38;
                            FastTween(u20.Main_Frame.CanvasGroup.ShopItem_Image.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                Scale = 1
                            });
                        end);
                    end;

                    u42 = v16.ItemData.ItemName;
                    v43 = u29:FindFirstChild("OddsButton");

                    if v43 then
                        v43.Visible = false;

                        if v16.ItemType == "Seed Pack" and SeedPackData.Packs[u42] then
                            v43.Visible = true;
                            v43.Activated:Connect(function() -- Line: 327
                                -- upvalues: SeedPackOddsController (ref), u42 (copy), RecipeSelection_UI (ref)
                                SeedPackOddsController:Open(u42, RecipeSelection_UI);
                            end);
                        elseif v16.ItemType == "PetEgg" and PetEggs[u42] then
                            v43.Visible = true;
                            v43.Activated:Connect(function() -- Line: 332
                                -- upvalues: PetEggOddsController (ref), u42 (copy), RecipeSelection_UI (ref)
                                PetEggOddsController:Open(u42, RecipeSelection_UI);
                            end);
                        elseif v16.ItemType == "CosmeticCrate" and CosmeticCrates[u42] then
                            v43.Visible = true;
                            v43.Activated:Connect(function() -- Line: 337
                                -- upvalues: CosmeticCrateOddsController (ref), u42 (copy), RecipeSelection_UI (ref)
                                CosmeticCrateOddsController:Open(u42, RecipeSelection_UI);
                            end);
                        end;
                    end;

                    v44 = function() -- Line: 343, Name: updateOptions
                        -- upvalues: u2 (ref), u23 (copy), u35 (copy), FastTween (ref), u34 (copy)
                        if u2 == u23 then
                            u35.Visible = true;
                            FastTween(u35, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Position = UDim2.fromScale(0.5, 1.3)
                            });
                            FastTween(u34, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(0.13, 0.25)
                            });

                            return;
                        end;

                        task.delay(0.25, function() -- Line: 354
                            -- upvalues: u35 (ref)
                            if u35.Position == UDim2.fromScale(0.5, 0.5) then
                                u35.Visible = false;
                            end;
                        end);
                        FastTween(u35, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Position = UDim2.fromScale(0.5, 0.5)
                        });
                        FastTween(u34, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(0.13, 0.02)
                        });
                    end;

                    u3:Connect(v44);
                    task.spawn(v44);
                    u45 = false;
                    u29.Activated:Connect(function() -- Line: 373
                        -- upvalues: FastTween (ref), ScrollingFrame (ref), u20 (copy), u5 (ref), u2 (ref), u23 (copy), u3 (ref), u45 (ref), u36 (copy), UseDynamicPrices (ref), u24 (copy), u35 (copy), MarketController (ref), Comma_Module (ref)
                        FastTween(ScrollingFrame, TweenInfo.new(0.35), {
                            CanvasPosition = Vector2.new(0, u20.AbsoluteSize.Y * (table.find(u5, u20) - 1))
                        });
                        local v47;

                        if u2 == u23 then
                            v47 = nil;
                        else
                            v47 = u23;
                        end;

                        u2 = v47;
                        u3:Fire();

                        if not u45 and u36 then
                            if UseDynamicPrices or u24.RobuxPrice == nil then
                                if not UseDynamicPrices then
                                    warn((`{u35:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                end;

                                MarketController:SetPriceLabel(u35.Robux_Buy.Price, u24.PurchaseID, ":robux::value:");
                            else
                                u35.Robux_Buy.Price.Text = `{utf8.char(57346)}{Comma_Module.Comma((`{u24.RobuxPrice}`))}`;
                            end;

                            u45 = true;
                        end;
                    end);
                end;
            end;
        end;
    end;

    table.sort(u5, function(p48: userdata, p49: userdata) -- Line: 399
        local LayoutOrder = p48.LayoutOrder;
        local LayoutOrder2 = p49.LayoutOrder;

        if LayoutOrder == LayoutOrder2 then
            return p48.Name < p49.Name;
        end;

        return LayoutOrder < LayoutOrder2;
    end);
end;

function v7.Start(p50) -- Line: 409
    -- upvalues: GuiController (copy), RecipeSelection_UI (copy)
    GuiController:UsePopupAnims(RecipeSelection_UI);
    RecipeSelection_UI.Frame.Frame.ExitButton.Activated:Connect(function() -- Line: 412
        -- upvalues: GuiController (ref), RecipeSelection_UI (ref)
        GuiController:Close(RecipeSelection_UI);
    end);
end;

OpenRecipeBindableEvent.Event:Connect(function(p51: userdata) -- Line: 417
    -- upvalues: GuiController (copy), RecipeSelection_UI (copy), u2 (ref), UpdateService (copy), u1 (ref), SetupFrames (copy), u4 (ref)
    GuiController:Open(RecipeSelection_UI);
    u2 = nil;
    local Attribute = p51:GetAttribute("CraftingObjectType");

    if not Attribute or typeof(Attribute) ~= "string" then
        return warn("CraftingObjectType is not valid");
    end;

    if not (UpdateService:IsUpdateDone() or u1) then
        local RemainingTimeUntilUpdate = UpdateService:GetRemainingTimeUntilUpdate();
        u1 = task.delay(RemainingTimeUntilUpdate + 1, function() -- Line: 428
            -- upvalues: SetupFrames (ref), Attribute (copy)
            SetupFrames(Attribute);
        end);
    end;

    SetupFrames(Attribute);
    u4 = p51;
end);
task.spawn(v7.Start, v7);

return v7;