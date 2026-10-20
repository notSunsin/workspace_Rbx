-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.WaitForDescendant);
require(ReplicatedStorage.Modules.MarketController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local CraftingGlobalObjectService = require(ReplicatedStorage.Modules.CraftingService.CraftingGlobalObjectService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local ReversedItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
local PetBoostRegistry = require(ReplicatedStorage.Data.PetRegistry.PetBoostRegistry);
local _ = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local _ = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Data.GearData);
require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);
local CraftingRecipeRegistry = require(ReplicatedStorage.Data.CraftingData.CraftingRecipeRegistry);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local SelectCraftingRecipeBindableEvent = GameEvents.SelectCraftingRecipeBindableEvent;
local OpenRecipeBindableEvent = GameEvents.OpenRecipeBindableEvent;
local CraftingGlobalObjectService2 = GameEvents.CraftingGlobalObjectService;
local CraftingFailedRemoteEvent = GameEvents.CraftingFailedRemoteEvent;
local HideCancelCraftingBindableEvent = GameEvents.HideCancelCraftingBindableEvent;
local ShowCancelCraftingBindableEvent = GameEvents.ShowCancelCraftingBindableEvent;
local PickupEvent = GameEvents.PickupEvent;
local ItemRecipes = CraftingRecipeRegistry.ItemRecipes;
local _ = PetRegistry.PetList;
local _ = PetRegistry.PetEggs;
local LocalPlayer = Players.LocalPlayer;
local RecipeSelection_UI = LocalPlayer.PlayerGui:WaitForChild("RecipeSelection_UI");
local u1 = {};

local function GetMachineId(p2: userdata) -- Line: 60
    return p2:GetAttribute("CraftingObjectType");
end;

local function GetMachineData(p3: userdata) -- Line: 64
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy)
    return CraftingGlobalObjectService:GetIndividualCraftingMachineData(p3, GetMachineId(p3));
end;

local function GetSelectedRecipe(p4: userdata) -- Line: 68
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p4, GetMachineId(p4));

    if not (IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId) then
        return nil, nil;
    end;

    local v5 = ItemRecipes[IndividualCraftingMachineData.RecipeId];

    if v5 then
        return v5, IndividualCraftingMachineData.RecipeId;
    end;

    return nil, nil;
end;

local function GetSubmittedIngredientItemIds(p6: userdata) -- Line: 78
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p6, GetMachineId(p6));

    if not (IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId) then
        return nil;
    end;

    if not ItemRecipes[IndividualCraftingMachineData.RecipeId] then
        return nil;
    end;

    local v7 = {};

    for i, _ in IndividualCraftingMachineData.InputItems do
        v7[tostring(i)] = true;
    end;

    return v7;
end;

local function GetCraftingSlotData(p8: userdata, p9: number) -- Line: 92
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p8, GetMachineId(p8));

    if IndividualCraftingMachineData then
        return IndividualCraftingMachineData.CraftingItems[p9];
    end;

    return nil;
end;

local function UpdateCraftingActiveAttribute(p10: userdata) -- Line: 99
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p10, GetMachineId(p10));
    local v11;

    if IndividualCraftingMachineData then
        v11 = IndividualCraftingMachineData.CraftingItems[1];
    else
        v11 = nil;
    end;

    local v12;

    if v11 == nil then
        v12 = false;
    else
        v12 = not v11.IsDone;
    end;

    p10:SetAttribute("IsCrafting", v12);
end;

local function IsCraftingComplete(p13) -- Line: 106
    return p13.IsDone;
end;

local function CreateItemRender(p14: string, p15: string) -- Line: 110
    -- upvalues: ItemImageFinder (copy)
    local v16 = script.IngredientModelTemplate:Clone();
    v16.Part.BillboardGui.ImageLabel.Image = ItemImageFinder(p14, p15);

    if v16 then
        script.CraftingModel_BillboardGui:Clone().Parent = v16;

        for _, descendant in v16:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
            end;
        end;
    end;

    return v16;
end;

local u17 = {};
local u18 = {};

local function CleanupModelRender(p19: userdata) -- Line: 137
    -- upvalues: u18 (copy)
    local v20 = u18[p19];

    if not v20 then
        return;
    end;

    if v20.Timer then
        v20.Timer:Destroy();
        v20.Timer = nil;
    end;

    for _, v in v20.Items do
        v:Destroy();
    end;

    table.clear(v20.Items);
end;

local function UpdateModelRender(u21: userdata) -- Line: 154
    -- upvalues: u18 (copy), CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), CleanupModelRender (copy), TweenService (copy), PickupEvent (copy), CreateItemRender (copy), NumberUtil (copy), GetSubmittedIngredientItemIds (copy), u17 (copy)
    local v22 = u18[u21];

    if v22 == nil then
        v22 = {
            Items = {}
        };
        u18[u21] = v22;
    end;

    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(u21, GetMachineId(u21));
    local v23, v24;

    if IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId then
        v23 = ItemRecipes[IndividualCraftingMachineData.RecipeId];

        if v23 then
            v24 = IndividualCraftingMachineData.RecipeId;
        else
            v23 = nil;
            v24 = nil;
        end;
    else
        v23 = nil;
        v24 = nil;
    end;

    local IndividualCraftingMachineData2 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(u21, GetMachineId(u21));
    local v25;

    if IndividualCraftingMachineData2 then
        v25 = IndividualCraftingMachineData2.CraftingItems[1];
    else
        v25 = nil;
    end;

    if not (v23 or v25) then
        if v22.Key == nil then
            return;
        end;

        CleanupModelRender(u21);
        v22.Key = nil;

        return;
    end;

    local v26;

    if v25 then
        v26 = `Output_{v25.RecipeId}_{v25.IsDone}`;
    elseif v23 then
        v26 = `Craft_{v24}`;
    else
        v26 = nil;
    end;

    if v26 == nil then
        CleanupModelRender(u21);
        v22.Key = nil;

        return;
    end;

    local Items = v22.Items;

    if v22.Key == v26 then
        if v22.Key == v26 then
            local v27 = {};

            if v25 then
                v27 = ItemRecipes[v25.RecipeId].Outputs;
            elseif v23 then
                v27 = v23.Inputs;
            end;

            local v28 = 0;
            local v29 = nil;
            local v30 = nil;

            for i, _ in v27 do
                local v31 = Items[i];

                if v31 then
                    local ExtentsSize = v31:GetExtentsSize();
                    v31:PivotTo(CFrame.new(v28 + ExtentsSize.X * 0.5, 0, 0));
                    v31.Parent = u21;
                    v28 = v28 - (ExtentsSize.X + 2);
                    Items[i] = v31;
                    local Pivot = v31:GetPivot();
                    local v32 = (Pivot.Position - ExtentsSize * 0.5) * Vector3.new(1, 0, 1);
                    local v33 = (Pivot.Position + ExtentsSize * 0.5) * Vector3.new(1, 0, 1);

                    if v29 then
                        v29 = vector.min(v29, v32);
                    else
                        v29 = v32;
                    end;

                    if v30 then
                        v30 = vector.max(v30, v33);
                    else
                        v30 = v33;
                    end;
                end;
            end;

            if v29 and v30 then
                local v34 = (v29 + v30) * 0.5;

                for _, v in Items do
                    v:PivotTo(u21.PrimaryPart.CFrame * CFrame.new(v:GetPivot().Position + Vector3.new(0, 3, 0) - v34));
                end;
            end;
        end;
    else
        if v25 and (v22.Key and (string.find(v22.Key, "Craft_") and string.find(v26, "Output_"))) then
            task.spawn(function() -- Line: 189
                -- upvalues: u21 (copy), Items (copy), TweenService (ref)
                local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.InOut);
                local CFrame2 = u21.PrimaryPart.CFrame;
                local table_clone_ret = table.clone(Items);
                table.clear(Items);

                for _, v in table_clone_ret do
                    local v35 = v:FindFirstChildOfClass("BillboardGui");

                    if v35 then
                        v35.Enabled = false;
                    end;

                    local u36 = TweenService:Create(v.PrimaryPart, TweenInfo_new_ret, {
                        CFrame = CFrame2
                    });
                    u36:Play();
                    u36.Completed:Connect(function() -- Line: 213
                        -- upvalues: u36 (copy), v (copy)
                        u36:Destroy();
                        v:Destroy();
                    end);
                    task.wait(0.6);
                end;
            end);
        end;

        v22.Key = v26;
        CleanupModelRender(u21);
        local v37 = {};

        if v25 then
            local v38;

            if v25 == nil then
                v38 = false;
            else
                v38 = not v25.IsDone;
            end;

            if v38 and not v22.Timer then
                local v39 = script.BillboardGuiTemplate:Clone();
                v39.Name = "CraftingBillboardGui";
                v39.Parent = u21.PrimaryPart;
                v22.Timer = v39;
                PickupEvent:Fire("Craft_ActiveCrafting", u21.PrimaryPart);
                local IndividualCraftingMachineData3 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(u21, GetMachineId(u21));
                local v40;

                if IndividualCraftingMachineData3 then
                    v40 = IndividualCraftingMachineData3.CraftingItems[1];
                else
                    v40 = nil;
                end;

                local v41;

                if v40 == nil then
                    v41 = false;
                else
                    v41 = not v40.IsDone;
                end;

                u21:SetAttribute("IsCrafting", v41);
            elseif not v38 and v22.Timer then
                v22.Timer:Destroy();
                v22.Timer = nil;
                PickupEvent:Fire("Craft_CompleteDing");
                local IndividualCraftingMachineData3 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(u21, GetMachineId(u21));
                local v42;

                if IndividualCraftingMachineData3 then
                    v42 = IndividualCraftingMachineData3.CraftingItems[1];
                else
                    v42 = nil;
                end;

                local v43;

                if v42 == nil then
                    v43 = false;
                else
                    v43 = not v42.IsDone;
                end;

                u21:SetAttribute("IsCrafting", v43);
            end;

            v37 = ItemRecipes[v25.RecipeId].Outputs;
        elseif v23 then
            v37 = v23.Inputs;
        end;

        local v44 = 0;
        local v45 = nil;
        local v46 = nil;

        for i, v in v37 do
            local v47 = CreateItemRender(v.ItemData.ItemName, v.ItemType);
            local ExtentsSize = v47:GetExtentsSize();
            v47:PivotTo(CFrame.new(v44 + ExtentsSize.X * 0.5, 0, 0));
            v47.Parent = u21;
            v44 = v44 - (ExtentsSize.X + 2);
            Items[i] = v47;
            local Pivot = v47:GetPivot();
            local v48 = (Pivot.Position - ExtentsSize * 0.5) * Vector3.new(1, 0, 1);
            local v49 = (Pivot.Position + ExtentsSize * 0.5) * Vector3.new(1, 0, 1);

            if v45 then
                v45 = vector.min(v45, v48);
            else
                v45 = v48;
            end;

            if v46 then
                v46 = vector.max(v46, v49);
            else
                v46 = v49;
            end;
        end;

        if v45 and v46 then
            local v50 = (v45 + v46) * 0.5;

            for _, v in Items do
                v:PivotTo(u21.PrimaryPart.CFrame * CFrame.new(v:GetPivot().Position + Vector3.new(0, 3, 0) - v50));
            end;
        end;
    end;

    local v51 = v25 and v22.Timer;

    if v51 then
        v51.Timer.Text = NumberUtil.compactFormat(v25.TimeRemaining);
    end;

    local v52;

    if v23 then
        v52 = GetSubmittedIngredientItemIds(u21);
    else
        v52 = nil;
    end;

    for i, v in Items do
        local v53;

        if v25 then
            v53 = ItemRecipes[v25.RecipeId].Outputs[i];
        elseif v23 then
            v53 = v23.Inputs[i];
        else
            v53 = nil;
        end;

        if v53 then
            local v54;

            if v25 then
                v54 = `{v53.ItemData.Quantity}x` or "1x";
            else
                v54 = `{v52 and v52[tostring(i)] and 1 or 0}/{v53.ItemData.Quantity or 1}`;
            end;

            v.CraftingModel_BillboardGui.TextLabel.Text = `{v54} {v53.ItemData.ItemName}{v53.ItemType == "Seed" and " Seed" or ""}`;
        end;
    end;

    local v55;

    if u17[u21] == true then
        v55 = not v25 or v25.IsDone;
    else
        v55 = false;
    end;

    for _, v in Items do
        if v.Parent == u21 ~= v55 then
            local v56;

            if v55 then
                v56 = u21;
            else
                v56 = script;
            end;

            v.Parent = v56;
        end;
    end;
end;

local function IsReadyToCraft(p57: userdata) -- Line: 364
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), CountDictionary (copy), GetSubmittedIngredientItemIds (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p57, GetMachineId(p57));

    if not (IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId) then
        return false;
    end;

    local v58 = ItemRecipes[IndividualCraftingMachineData.RecipeId];

    if v58 then
        return CountDictionary((GetSubmittedIngredientItemIds(p57))) >= CountDictionary(v58.Inputs);
    end;

    return false;
end;

local function UpdatePrompt(p59: userdata) -- Line: 378
    -- upvalues: RebirthUnlocksSharedService (copy), LocalPlayer (copy), CraftingGlobalObjectService (copy), GetMachineId (copy), HideCancelCraftingBindableEvent (copy), ItemRecipes (copy), ShowCancelCraftingBindableEvent (copy), CountDictionary (copy), GetSubmittedIngredientItemIds (copy)
    if not p59.PrimaryPart then
        return;
    end;

    local v60 = p59:FindFirstChildWhichIsA("ProximityPrompt", true);

    if not v60 then
        return warn("Cannot Find Prox Prompt On crafting station");
    end;

    if not RebirthUnlocksSharedService:HasUnlockedFeature(LocalPlayer, "CRAFTING") then
        v60.Enabled = false;

        return;
    end;

    v60.Enabled = true;
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p59, GetMachineId(p59));
    local v61;

    if IndividualCraftingMachineData then
        v61 = IndividualCraftingMachineData.CraftingItems[1];
    else
        v61 = nil;
    end;

    v60.ActionText = "Select Recipe";
    HideCancelCraftingBindableEvent:Fire();

    if v61 then
        if v61.IsDone then
            v60.ActionText = "Claim";

            return;
        end;

        v60.ActionText = "Skip";

        return;
    end;

    local IndividualCraftingMachineData2 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p59, GetMachineId(p59));

    if not (IndividualCraftingMachineData2 and IndividualCraftingMachineData2.RecipeId) then
        return;
    end;

    local IndividualCraftingMachineData3 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p59, GetMachineId(p59));
    local v62;

    if IndividualCraftingMachineData3 and IndividualCraftingMachineData3.RecipeId then
        v62 = ItemRecipes[IndividualCraftingMachineData3.RecipeId];

        if v62 then
            local _ = IndividualCraftingMachineData3.RecipeId;
        else
            v62 = nil;
        end;
    else
        v62 = nil;
    end;

    if v62 then
        ShowCancelCraftingBindableEvent:Fire(p59);
        local IndividualCraftingMachineData4 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p59, GetMachineId(p59));
        local v63;

        if IndividualCraftingMachineData4 and IndividualCraftingMachineData4.RecipeId then
            local v64 = ItemRecipes[IndividualCraftingMachineData4.RecipeId];

            if v64 then
                v63 = CountDictionary((GetSubmittedIngredientItemIds(p59))) >= CountDictionary(v64.Inputs);
            else
                v63 = false;
            end;
        else
            v63 = false;
        end;

        if v63 then
            local Cost = v62.Cost;

            if not Cost then
                v60.ActionText = "Start Crafting: No Cost";

                return;
            end;

            local v65;

            if Cost then
                v65 = Cost.CurrencyType;
            else
                v65 = Cost;
            end;

            if Cost then
                local _ = Cost.Amount;
            end;

            v60.ActionText = `Start Crafting: {Cost.Amount} {v65}`;

            return;
        end;

        v60.ActionText = "Submit Item";
    end;
end;

local function StartCrafting(p66: userdata) -- Line: 434
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), DataService (copy), Notification (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p66, GetMachineId(p66));
    local v67;

    if IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId then
        v67 = ItemRecipes[IndividualCraftingMachineData.RecipeId];

        if v67 then
            local _ = IndividualCraftingMachineData.RecipeId;
        else
            v67 = nil;
        end;
    else
        v67 = nil;
    end;

    if not v67 then
        return;
    end;

    local Data = DataService:GetData();
    local Cost = v67.Cost;
    local v68;

    if Cost then
        v68 = Cost.CurrencyType;
    else
        v68 = Cost;
    end;

    if Cost then
        Cost = Cost.Amount;
    end;

    if v68 and Cost and (Data[v68] or Data.SpecialCurrency[v68]) < Cost then
        Notification:CreateNotification((`You need {`<font color="#ff9500">{Cost} {v68}</font>`} to craft this.`));

        return;
    end;

    CraftingGlobalObjectService:Craft(p66, GetMachineId(p66));
end;

local function SubmitHeldItemForCrafting(p69: userdata) -- Line: 458
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), Notification (copy), GetSubmittedIngredientItemIds (copy), LocalPlayer (copy), InventoryServiceEnums (copy), ReversedItemTypeEnums (copy), PetsService (copy), ItemTypeEnums (copy), PetBoostRegistry (copy), InventoryService (copy), PickupEvent (copy)
    CraftingGlobalObjectService:GetCraftingObjectData(p69);
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p69, GetMachineId(p69));
    local v70;

    if IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId then
        v70 = ItemRecipes[IndividualCraftingMachineData.RecipeId];

        if v70 then
            local _ = IndividualCraftingMachineData.RecipeId;
        else
            v70 = nil;
        end;
    else
        v70 = nil;
    end;

    if not v70 then
        Notification:CreateNotification("No Crafting recipe has been selected");

        return;
    end;

    local v71 = GetSubmittedIngredientItemIds(p69);

    if not v71 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v72 = Character:FindFirstChildWhichIsA("Tool");

    if not v72 then
        Notification:CreateNotification("You are not holding an item!");

        return;
    end;

    if not Character:FindFirstChildWhichIsA("Humanoid") then
        return;
    end;

    if v72:GetAttribute(InventoryServiceEnums.Favorite) then
        Notification:CreateNotification("Cannot Submit a favorited item!");

        return;
    end;

    if v72:GetAttribute("Traded") then
        Notification:CreateNotification("This item is pending trade!");

        return;
    end;

    local v73 = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)] or v72:GetAttribute("ItemType");
    local Attribute = v72:GetAttribute(InventoryServiceEnums.ItemName);
    local Attribute2 = v72:GetAttribute("PET_UUID");
    local v74;

    if Attribute2 then
        v74 = PetsService:GetPlayerPetData(Attribute2);
    else
        v74 = Attribute2;
    end;

    if v73 then
        if v73 == ReversedItemTypeEnums[ItemTypeEnums.PetEgg] then
            Attribute = v72:GetAttribute(InventoryServiceEnums.EggName);
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums.CosmeticCrate] then
            Attribute = v72:GetAttribute(InventoryServiceEnums.CrateType);
        elseif Attribute2 and v74 then
            Attribute = v74.PetType;
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums.SprayBottle] then
            Attribute = v72:GetAttribute(InventoryServiceEnums.SprayType);
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums.PetBoost] then
            Attribute = `{v72:GetAttribute(InventoryServiceEnums.PetBoostSize)} {PetBoostRegistry.BoostTypeToPetModelName[v72:GetAttribute(InventoryServiceEnums.PetBoostType)]}`;
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Seed Pack"]] then
            Attribute = v72:GetAttribute(InventoryServiceEnums.Type);
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Harvest Tool"]] or (v73 == ReversedItemTypeEnums[ItemTypeEnums["Watering Can"]] or v73 == ReversedItemTypeEnums[ItemTypeEnums["Recall Wrench"]]) then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums.PetShard] then
            Attribute = v72:GetAttribute(InventoryServiceEnums.ShardType);
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Fairy Jar"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Fairy Net"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Luminous Wand"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Fairy Caller"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Fairy Targeter"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Fairy Power Extender"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Fairy Summoner"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        elseif v73 == ReversedItemTypeEnums[ItemTypeEnums["Favorite Tool"]] then
            Attribute = ReversedItemTypeEnums[v72:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        end;
    else
        if Attribute then
            return;
        end;

        local ToolData = InventoryService:GetToolData(v72);

        if not ToolData then
            return;
        end;

        if not ToolData.ItemType then
            return;
        end;

        Attribute = ToolData.ItemType;
        v73 = Attribute;
    end;

    local v75 = v72:GetAttribute(InventoryServiceEnums.ITEM_UUID) or Attribute2;
    local v76 = nil;

    for i, v in v70.Inputs do
        if not (v71[tostring(i)] or (v.ItemData.ItemName ~= Attribute or v.ItemType ~= v73)) then
            v76 = i;
            break;
        end;
    end;

    if not v76 then
        Notification:CreateNotification("That is not a required item for crafting");

        return;
    end;

    CraftingGlobalObjectService:InputItem(p69, p69:GetAttribute("CraftingObjectType"), v76, {
        ItemType = v73,
        ItemData = {
            UUID = v75
        }
    });
    PickupEvent:Fire("Craft_SubmitItem");
end;

function u1.SubmitAllRequiredItems(p77: table, p78: userdata) -- Line: 579
    -- upvalues: GetSubmittedIngredientItemIds (copy), PickupEvent (copy), CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), Notification (copy), LocalPlayer (copy), InventoryService (copy), ReversedItemTypeEnums (copy), ItemTypeEnums (copy), PetBoostRegistry (copy)
    local v79 = GetSubmittedIngredientItemIds(p78);
    PickupEvent:Fire("Click");

    if not v79 then
        return;
    end;

    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p78, GetMachineId(p78));
    local v80;

    if IndividualCraftingMachineData and IndividualCraftingMachineData.RecipeId then
        v80 = ItemRecipes[IndividualCraftingMachineData.RecipeId];

        if v80 then
            local _ = IndividualCraftingMachineData.RecipeId;
        else
            v80 = nil;
        end;
    else
        v80 = nil;
    end;

    if not v80 then
        Notification:CreateNotification("No Crafting recipe has been selected");

        return;
    end;

    if not LocalPlayer.Character then
        return;
    end;

    local _ = LocalPlayer.Backpack;
    local v81 = {};

    for i, v in v80.Inputs do
        if not v79[tostring(i)] then
            local ItemName = v.ItemData.ItemName;
            local ItemType = v.ItemType;
            local v84 = InventoryService:Find(ItemType, function(p82: table) -- Line: 624
                -- upvalues: ItemType (copy), ReversedItemTypeEnums (ref), ItemTypeEnums (ref), PetBoostRegistry (ref), ItemName (copy)
                local v83;

                if ItemType == ReversedItemTypeEnums[ItemTypeEnums.PetEgg] then
                    v83 = p82.EggName;
                elseif ItemType == ReversedItemTypeEnums[ItemTypeEnums.CosmeticCrate] then
                    v83 = p82.CrateType;
                elseif ItemType == ReversedItemTypeEnums[ItemTypeEnums.SprayBottle] then
                    v83 = p82.SprayType;
                elseif ItemType == ReversedItemTypeEnums[ItemTypeEnums.PetBoost] then
                    v83 = `{p82.PetBoostSize} {PetBoostRegistry.BoostTypeToPetModelName[p82.PetBoostType]}`;
                elseif ItemType == ReversedItemTypeEnums[ItemTypeEnums["Seed Pack"]] then
                    v83 = p82.Type;
                elseif ItemType == ReversedItemTypeEnums[ItemTypeEnums.PetShard] then
                    v83 = p82.ShardType;
                else
                    v83 = p82.ITEM_TYPE;
                end;

                return ItemName == (v83 or p82.ItemName or ItemType);
            end);
            local v85 = v.ItemData.Quantity or 1;
            local v86 = i;

            for i2, v2 in v84 do
                if not v2.ItemData.IsFavorite then
                    local v87 = v81[i2] or 0;

                    if (v2.ItemData.Quantity or (v2.ItemData.Uses or 1)) - v87 >= v85 then
                        v81[i2] = v87 + v85;
                        CraftingGlobalObjectService:InputItem(p78, p78:GetAttribute("CraftingObjectType"), v86, {
                            ItemType = v2.ItemType,
                            ItemData = {
                                UUID = i2
                            }
                        });
                        task.delay(0.1 + v86 * 0.1, function() -- Line: 686
                            -- upvalues: PickupEvent (ref)
                            PickupEvent:Fire("Craft_SubmitItem");
                        end);
                        break;
                    end;
                end;
            end;
        end;
    end;
end;

function u1.CancelRecipe(p88: table, p89: userdata) -- Line: 694
    -- upvalues: CraftingGlobalObjectService (copy)
    CraftingGlobalObjectService:Cancel(p89, (p89:GetAttribute("CraftingObjectType")));
end;

function u1.CanCancelRecipe(p90: table, p91: userdata) -- Line: 699
    -- upvalues: CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), u17 (copy)
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p91, GetMachineId(p91));
    local v92;

    if IndividualCraftingMachineData then
        v92 = IndividualCraftingMachineData.CraftingItems[1];
    else
        v92 = nil;
    end;

    local v93 = not v92;

    if v93 then
        v93 = false;
        local IndividualCraftingMachineData2 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(p91, GetMachineId(p91));
        local v94;

        if IndividualCraftingMachineData2 and IndividualCraftingMachineData2.RecipeId then
            v94 = ItemRecipes[IndividualCraftingMachineData2.RecipeId];

            if v94 then
                local _ = IndividualCraftingMachineData2.RecipeId;
            else
                v94 = nil;
            end;
        else
            v94 = nil;
        end;

        if v94 ~= nil then
            v93 = u17[p91] == true;
        end;
    end;

    return v93;
end;

function u1.SetupProximityPromptForCraftingStation(p95: table, u96: userdata) -- Line: 703
    -- upvalues: UpdatePrompt (copy), CraftingGlobalObjectService (copy), GetMachineId (copy), ItemRecipes (copy), CountDictionary (copy), GetSubmittedIngredientItemIds (copy), StartCrafting (copy), SubmitHeldItemForCrafting (copy), OpenRecipeBindableEvent (copy), u17 (copy), UpdateModelRender (copy), DataService (copy)
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Default;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
    ProximityPrompt.Name = "CraftingProximityPrompt";
    ProximityPrompt.ActionText = "Select Recipe";
    ProximityPrompt.ObjectText = "Crafting";
    ProximityPrompt.MaxActivationDistance = 10;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    local v97 = 0;

    while not u96.PrimaryPart and v97 < 10 do
        v97 = v97 + task.wait();
    end;

    if not u96.PrimaryPart then
        warn("Timed out waiting for PrimaryPart on", u96.Name);
    end;

    ProximityPrompt.Parent = u96.PrimaryPart;
    ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
    UpdatePrompt(u96);
    ProximityPrompt.Triggered:Connect(function() -- Line: 730
        -- upvalues: u96 (copy), CraftingGlobalObjectService (ref), GetMachineId (ref), ItemRecipes (ref), CountDictionary (ref), GetSubmittedIngredientItemIds (ref), StartCrafting (ref), SubmitHeldItemForCrafting (ref), OpenRecipeBindableEvent (ref), UpdatePrompt (ref)
        local v98 = u96;
        local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(v98, GetMachineId(v98));
        local v99;

        if IndividualCraftingMachineData then
            v99 = IndividualCraftingMachineData.CraftingItems[1];
        else
            v99 = nil;
        end;

        if v99 == nil then
            local v100 = u96;
            local IndividualCraftingMachineData2 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(v100, GetMachineId(v100));
            local v101;

            if IndividualCraftingMachineData2 and IndividualCraftingMachineData2.RecipeId then
                v101 = ItemRecipes[IndividualCraftingMachineData2.RecipeId];

                if v101 then
                    local _ = IndividualCraftingMachineData2.RecipeId;
                else
                    v101 = nil;
                end;
            else
                v101 = nil;
            end;

            if v101 then
                local v102 = u96;
                local IndividualCraftingMachineData3 = CraftingGlobalObjectService:GetIndividualCraftingMachineData(v102, GetMachineId(v102));
                local v103;

                if IndividualCraftingMachineData3 and IndividualCraftingMachineData3.RecipeId then
                    local v104 = ItemRecipes[IndividualCraftingMachineData3.RecipeId];

                    if v104 then
                        v103 = CountDictionary((GetSubmittedIngredientItemIds(v102))) >= CountDictionary(v104.Inputs);
                    else
                        v103 = false;
                    end;
                else
                    v103 = false;
                end;

                if v103 then
                    StartCrafting(u96);
                else
                    SubmitHeldItemForCrafting(u96);
                end;
            else
                OpenRecipeBindableEvent:Fire(u96);
            end;
        elseif v99.IsDone then
            CraftingGlobalObjectService:Claim(u96, u96:GetAttribute("CraftingObjectType"), 1);
        else
            CraftingGlobalObjectService:Skip(u96, u96:GetAttribute("CraftingObjectType"), 1);
        end;

        UpdatePrompt(u96);
    end);
    ProximityPrompt.PromptShown:Connect(function() -- Line: 754
        -- upvalues: u17 (ref), u96 (copy), UpdatePrompt (ref), UpdateModelRender (ref)
        u17[u96] = true;
        UpdatePrompt(u96);
        UpdateModelRender(u96);
    end);
    ProximityPrompt.PromptHidden:Connect(function() -- Line: 760
        -- upvalues: u17 (ref), u96 (copy), UpdatePrompt (ref), UpdateModelRender (ref)
        u17[u96] = nil;
        UpdatePrompt(u96);
        UpdateModelRender(u96);
    end);

    local function UpdateFunction() -- Line: 766
        -- upvalues: UpdatePrompt (ref), u96 (copy), UpdateModelRender (ref), CraftingGlobalObjectService (ref), GetMachineId (ref)
        UpdatePrompt(u96);
        UpdateModelRender(u96);
        local v105 = u96;
        local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(v105, GetMachineId(v105));
        local v106;

        if IndividualCraftingMachineData then
            v106 = IndividualCraftingMachineData.CraftingItems[1];
        else
            v106 = nil;
        end;

        local v107;

        if v106 == nil then
            v107 = false;
        else
            v107 = not v106.IsDone;
        end;

        v105:SetAttribute("IsCrafting", v107);
    end;

    task.spawn(function() -- Line: 772
        -- upvalues: DataService (ref), UpdateFunction (copy)
        local PathSignal = DataService:GetPathSignal("CraftingData/@");

        if PathSignal then
            PathSignal:Connect(UpdateFunction);
        end;

        local PathSignal2 = DataService:GetPathSignal("CraftingData");

        if PathSignal2 then
            PathSignal2:Connect(UpdateFunction);
        end;

        DataService:GetPathSignal("RebirthData/TotalRebirths"):Connect(UpdateFunction);
    end);
    UpdatePrompt(u96);
    UpdateModelRender(u96);
    local IndividualCraftingMachineData = CraftingGlobalObjectService:GetIndividualCraftingMachineData(u96, GetMachineId(u96));
    local v108;

    if IndividualCraftingMachineData then
        v108 = IndividualCraftingMachineData.CraftingItems[1];
    else
        v108 = nil;
    end;

    local v109;

    if v108 == nil then
        v109 = false;
    else
        v109 = not v108.IsDone;
    end;

    u96:SetAttribute("IsCrafting", v109);
end;

CraftingGlobalObjectService2.OnClientEvent:Connect(function(p110: userdata) -- Line: 790
end);
CraftingFailedRemoteEvent.OnClientEvent:Connect(function(p111: userdata) -- Line: 794
    -- upvalues: u1 (copy), Notification (copy)
    u1:CancelRecipe(p111);
    Notification:CreateNotification("Crafting failed! Try again!");
end);
SelectCraftingRecipeBindableEvent.Event:Connect(function(p112: userdata, p113: string, p114: any) -- Line: 799
    -- upvalues: GuiController (copy), RecipeSelection_UI (copy), CraftingGlobalObjectService (copy), PickupEvent (copy)
    GuiController:Close(RecipeSelection_UI);
    CraftingGlobalObjectService:SetRecipe(p112, p112:GetAttribute("CraftingObjectType"), p113);
    PickupEvent:Fire("Craft_SelectRecipe");
end);
local Tagged = CollectionService:GetTagged("CraftingObject");

if #Tagged <= 0 then
    error("CraftingStationHandler: Cannot find CraftingStation");

    return {};
end;

for _, v in Tagged do
    u1:SetupProximityPromptForCraftingStation(v);
end;

CollectionService:GetInstanceAddedSignal("CraftingObject"):Connect(function(p115) -- Line: 818
    -- upvalues: u1 (copy)
    u1:SetupProximityPromptForCraftingStation(p115);
end);

return u1;