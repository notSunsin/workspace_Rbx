-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local MoonCrafting = GameEvents:WaitForChild("MoonCrafting");
local OpenUI = MoonCrafting:WaitForChild("OpenUI");
local SelectRecipe = MoonCrafting:WaitForChild("SelectRecipe");
local PickupEvent = GameEvents:WaitForChild("PickupEvent");
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local MoonCraftingClient = require(ReplicatedStorage.Modules.Events.HarvestMoonEvent.MoonCrafting.MoonCraftingClient);
local MoonCraftingConfigAccessor = require(ReplicatedStorage.Modules.Events.HarvestMoonEvent.MoonCrafting.MoonCraftingConfigAccessor);
local MoonCraftingItemIdentity = require(ReplicatedStorage.Modules.Events.HarvestMoonEvent.MoonCrafting.MoonCraftingItemIdentity);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local CraftingStationHandler = ReplicatedStorage.Modules:WaitForChild("CraftingStationHandler");
local IngredientModelTemplate = CraftingStationHandler:WaitForChild("IngredientModelTemplate");
local CraftingModel_BillboardGui = CraftingStationHandler:WaitForChild("CraftingModel_BillboardGui");
local BillboardGuiTemplate = CraftingStationHandler:WaitForChild("BillboardGuiTemplate");
local u1 = {};
local u2 = false;
local u3 = {};
local u4 = {};

local function GetAnchorPart(p5: userdata) -- Line: 149
    if p5:IsA("BasePart") then
        return p5;
    end;

    if p5:IsA("Model") then
        return p5.PrimaryPart or p5:FindFirstChildWhichIsA("BasePart", true);
    end;

    return p5:FindFirstChildWhichIsA("BasePart", true);
end;

local function FormatCurrency(p6: string, p7: number) -- Line: 161
    -- upvalues: CurrencyData (copy), NumberUtil (copy)
    local v8 = CurrencyData[p6];
    local v9;

    if v8 then
        v9 = v8.CurrencyName or p6;
    else
        v9 = p6;
    end;

    local v10;

    if p6 == "Sheckles" then
        v10 = NumberUtil.FormatSheckles(p7);
    else
        v10 = NumberUtil.Comma(p7);
    end;

    return `{v10} {v9}`;
end;

local function FormatRemaining(p11: number) -- Line: 175
    -- upvalues: NumberUtil (copy)
    local compactFormat = NumberUtil.compactFormat;
    local math_ceil_ret = math.ceil(p11);

    return compactFormat((math.max(math_ceil_ret, 0)));
end;

local function CreateItemRender(p12: string, p13: string) -- Line: 184
    -- upvalues: IngredientModelTemplate (copy), ItemImageFinder (copy), CraftingModel_BillboardGui (copy)
    local v14 = IngredientModelTemplate:Clone();
    v14.Name = `MoonCraftingItem_{p12}`;
    v14.Part.BillboardGui.ImageLabel.Image = ItemImageFinder(p12, p13);
    local v15 = CraftingModel_BillboardGui:Clone();
    v15.Name = "ItemCaption";
    v15.Parent = v14.Part;

    for _, descendant in v14:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;

    return v14;
end;

local function GetItemCaption(p16: userdata) -- Line: 209
    local Part = p16:FindFirstChild("Part");

    if Part then
        Part = Part:FindFirstChild("ItemCaption");
    end;

    if Part then
        Part = Part:FindFirstChildWhichIsA("TextLabel");
    end;

    return Part;
end;

local function LayoutItems(p17: table, p18: userdata) -- Line: 217
    local v19 = #p17;

    if v19 == 0 then
        return;
    end;

    for i, v in p17 do
        v:PivotTo(p18.CFrame * CFrame.new((i - (v19 + 1) / 2) * 2.5, 3.25, 0));
    end;
end;

local function ClearItems(p20) -- Line: 230
    for _, v in p20.Items do
        v:Destroy();
    end;

    table.clear(p20.Items);
end;

local function PullItemsIntoStation(u21: table, p22: userdata) -- Line: 245
    -- upvalues: TweenService (copy)
    local CFrame2 = p22.CFrame;
    local TweenInfo_new_ret = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    task.spawn(function() -- Line: 249
        -- upvalues: u21 (copy), TweenService (ref), TweenInfo_new_ret (copy), CFrame2 (copy)
        for i, v in u21 do
            local v23 = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true);

            if v23 then
                local ItemCaption = v23:FindFirstChild("ItemCaption");

                if ItemCaption and ItemCaption:IsA("BillboardGui") then
                    ItemCaption.Enabled = false;
                end;

                local u24 = TweenService:Create(v23, TweenInfo_new_ret, {
                    CFrame = CFrame2
                });
                u24:Play();
                u24.Completed:Connect(function() -- Line: 265
                    -- upvalues: u24 (copy), v (copy)
                    u24:Destroy();
                    v:Destroy();
                end);

                if i < #u21 then
                    task.wait(0.45);
                end;
            else
                v:Destroy();
            end;
        end;
    end);
end;

local function ResolveTimer(p25: userdata, p26: userdata) -- Line: 288
    -- upvalues: BillboardGuiTemplate (copy)
    local function HasOwnCaption(p27: userdata, p28: userdata) -- Line: 291
        for _, descendant in p27:GetDescendants() do
            if descendant ~= p28 and descendant:IsA("TextLabel") then
                return true;
            end;
        end;

        return false;
    end;

    for _, descendant in (p25.Parent or p25):GetDescendants() do
        if descendant:IsA("TextLabel") and descendant.Name == "Timer" then
            local v29 = descendant:FindFirstAncestorWhichIsA("BillboardGui");

            if v29 then
                return v29, descendant, false, HasOwnCaption(v29, descendant);
            end;
        end;
    end;

    local v30 = BillboardGuiTemplate:Clone();
    v30.Name = "MoonCraftingTimer";
    v30.Parent = p26;
    local Timer = v30:FindFirstChild("Timer");

    if Timer and Timer:IsA("TextLabel") then
        return v30, Timer, true, HasOwnCaption(v30, Timer);
    end;

    return v30, nil, true, true;
end;

local function EnsurePrompt(p31: userdata, p32: userdata) -- Line: 331
    -- upvalues: MoonCraftingConfigAccessor (copy)
    local v33 = p31:FindFirstChildWhichIsA("ProximityPrompt", true);

    if not v33 then
        v33 = Instance.new("ProximityPrompt");
        v33.Parent = p32;
    end;

    v33.Name = "MoonCraftingProximityPrompt";
    v33.Style = Enum.ProximityPromptStyle.Custom;
    v33.RequiresLineOfSight = false;
    v33.HoldDuration = 0;
    v33.KeyboardKeyCode = Enum.KeyCode.E;
    v33.MaxActivationDistance = 10;
    v33.ActionText = "Select Recipe";
    v33.ObjectText = MoonCraftingConfigAccessor:GetPromptObjectText();
    v33:SetAttribute("Theme", "ShadowedPrompt");

    return v33;
end;

local function Refresh(p34: userdata) -- Line: 358
    -- upvalues: u4 (copy), MoonCraftingConfigAccessor (copy), MoonCraftingClient (copy), NumberUtil (copy), CurrencyData (copy), PullItemsIntoStation (copy), CreateItemRender (copy), LayoutItems (copy), PickupEvent (copy), u3 (copy)
    local v35 = u4[p34];

    if not v35 then
        return;
    end;

    local Anchor = v35.Anchor;
    local Prompt = v35.Prompt;
    local v36 = MoonCraftingConfigAccessor:IsEnabled();
    local CraftingSlot = MoonCraftingClient:GetCraftingSlot(1);
    local SelectedRecipe, v37 = MoonCraftingClient:GetSelectedRecipe();
    Prompt.Enabled = v36 or CraftingSlot ~= nil;
    local v38;

    if CraftingSlot == nil then
        v38 = false;
    else
        v38 = not CraftingSlot.IsDone;
    end;

    p34:SetAttribute("IsCrafting", v38);
    local v39 = nil;
    local v40 = nil;

    if CraftingSlot then
        v39 = MoonCraftingConfigAccessor:GetRecipe(CraftingSlot.RecipeId);

        if CraftingSlot.IsDone then
            Prompt.ActionText = "Claim";
        elseif MoonCraftingConfigAccessor:GetSkipProductId() == 0 then
            local compactFormat = NumberUtil.compactFormat;
            local math_ceil_ret = math.ceil(CraftingSlot.TimeRemaining or 0);
            Prompt.ActionText = compactFormat((math.max(math_ceil_ret, 0)));
        else
            Prompt.ActionText = "Skip Craft";
        end;

        if v39 then
            v39 = v39.Outputs;
        end;

        v40 = `Output_{tostring(CraftingSlot.RecipeId)}_{tostring(CraftingSlot.IsDone)}`;
    elseif SelectedRecipe then
        local v41 = 0;

        for _ in MoonCraftingClient:GetSubmittedSlots() do
            v41 = v41 + 1;
        end;

        if #SelectedRecipe.Inputs <= v41 then
            local Cost = SelectedRecipe.Cost;
            local v42;

            if Cost and Cost.Amount > 0 then
                local CurrencyType = Cost.CurrencyType;
                local Amount = Cost.Amount;
                local v43 = CurrencyData[CurrencyType];
                local v44;

                if v43 then
                    v44 = v43.CurrencyName or CurrencyType;
                else
                    v44 = CurrencyType;
                end;

                local v45;

                if CurrencyType == "Sheckles" then
                    v45 = NumberUtil.FormatSheckles(Amount);
                else
                    v45 = NumberUtil.Comma(Amount);
                end;

                v42 = `Start Crafting: {`{v45} {v44}`}`;
            else
                v42 = "Start Crafting";
            end;

            Prompt.ActionText = v42;
        else
            Prompt.ActionText = "Submit Item";
        end;

        v39 = SelectedRecipe.Inputs;
        v40 = `Craft_{tostring(v37)}`;
    else
        Prompt.ActionText = "Select Recipe";
    end;

    if v35.RenderKey ~= v40 then
        local v46;

        if v35.RenderKey == nil then
            v46 = false;
        else
            v46 = string.find(v35.RenderKey, "^Craft_") ~= nil;
        end;

        local v47;

        if v40 == nil then
            v47 = false;
        else
            v47 = string.find(v40, "^Output_") ~= nil;
        end;

        if v46 and v47 then
            PullItemsIntoStation(v35.Items, Anchor);
            v35.Items = {};
        else
            for _, v in v35.Items do
                v:Destroy();
            end;

            table.clear(v35.Items);
        end;

        v35.RenderKey = v40;

        if v39 then
            for i, v in v39 do
                v35.Items[i] = CreateItemRender(v.ItemData.ItemName, v.ItemType);
            end;

            LayoutItems(v35.Items, Anchor);
        end;
    end;

    local v48;

    if SelectedRecipe then
        v48 = MoonCraftingClient:GetSubmittedSlots();
    else
        v48 = nil;
    end;

    for i, v in v35.Items do
        local v49;

        if v39 then
            v49 = v39[i];
        else
            v49 = v39;
        end;

        local Part = v:FindFirstChild("Part");

        if Part then
            Part = Part:FindFirstChild("ItemCaption");
        end;

        if Part then
            Part = Part:FindFirstChildWhichIsA("TextLabel");
        end;

        if v49 and Part then
            local v50 = v49.ItemData.Quantity or 1;
            local v51 = v49.ItemType == "Seed" and " Seed" or "";

            if CraftingSlot then
                Part.Text = `{v50}x {v49.ItemData.ItemName}{v51}`;
            else
                Part.Text = `{v48 and v48[tostring(i)] and 1 or 0}/{v50} {v49.ItemData.ItemName}{v51}`;
            end;
        end;
    end;

    local v52;

    if CraftingSlot == nil then
        v52 = false;
    else
        v52 = not CraftingSlot.IsDone;
    end;

    if v35.Timer then
        v35.Timer.Enabled = v52;

        if v52 and v35.TimerLabel then
            local compactFormat = NumberUtil.compactFormat;
            local math_ceil_ret = math.ceil(CraftingSlot.TimeRemaining or 0);
            local v53 = compactFormat((math.max(math_ceil_ret, 0)));

            if not v35.TimerHasCaption then
                v53 = "Time Remaining:<br/>" .. v53;
            end;

            v35.TimerLabel.Text = v53;
        end;
    end;

    if v52 and not v35.WasCrafting then
        PickupEvent:Fire("Craft_ActiveCrafting", Anchor);
    elseif not v52 and v35.WasCrafting then
        PickupEvent:Fire("Craft_CompleteDing");
    end;

    v35.WasCrafting = v52;
    local v54;

    if u3[p34] == true then
        v54 = CraftingSlot == nil and true or CraftingSlot.IsDone;
    else
        v54 = false;
    end;

    if not v54 then
        p34 = script;
    end;

    for _, v in v35.Items do
        if v.Parent ~= p34 then
            v.Parent = p34;
        end;
    end;
end;

local u55 = {};

local function RefreshSign(p56: userdata) -- Line: 515
    -- upvalues: u55 (copy), MoonCraftingClient (copy)
    local TextLabel = p56:FindFirstChild("TextLabel", true);

    if not (TextLabel and TextLabel:IsA("TextLabel")) then
        warn((`[MoonCrafting] {p56:GetFullName()} is tagged "MoonCraftingHarvestSign" but has no TextLabel.`));

        return;
    end;

    local v57 = u55[p56];

    if not v57 then
        v57 = string.match(TextLabel.Text, "^(.*<br%s*/?>)") or TextLabel.Text .. "<br/>";
        u55[p56] = v57;
    end;

    TextLabel.Text = v57 .. tostring(MoonCraftingClient:GetSummonsContributed());
end;

local function RefreshAll() -- Line: 533
    -- upvalues: u4 (copy), Refresh (copy), CollectionService (copy), RefreshSign (copy)
    for i in u4 do
        Refresh(i);
    end;

    for _, v in CollectionService:GetTagged("MoonCraftingHarvestSign") do
        RefreshSign(v);
    end;
end;

local function SubmitHeldItem() -- Line: 545
    -- upvalues: MoonCraftingClient (copy), Notification (copy), LocalPlayer (copy), InventoryServiceEnums (copy), MoonCraftingItemIdentity (copy), PickupEvent (copy)
    if not MoonCraftingClient:GetSelectedRecipe() then
        Notification:CreateNotification("No Moon Crafting recipe has been selected");

        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v58 = Character:FindFirstChildWhichIsA("Tool");

    if not v58 then
        Notification:CreateNotification("You are not holding an item!");

        return;
    end;

    if v58:GetAttribute(InventoryServiceEnums.Favorite) then
        Notification:CreateNotification("Cannot Submit a favorited item!");

        return;
    end;

    if v58:GetAttribute("Traded") then
        Notification:CreateNotification("This item is pending trade!");

        return;
    end;

    local v59 = MoonCraftingItemIdentity.FromTool(v58);

    if not v59 then
        return;
    end;

    local v60 = MoonCraftingClient:FindOpenSlotFor(v59.ItemType, v59.ItemName);

    if not v60 then
        Notification:CreateNotification("That is not a required item for this craft");

        return;
    end;

    MoonCraftingClient:InputItem(v60, {
        ItemType = v59.ItemType,
        ItemData = {
            UUID = v59.UUID
        }
    });
    PickupEvent:Fire("Craft_SubmitItem");
end;

function u1.SubmitAllRequiredItems(p61) -- Line: 600
    -- upvalues: MoonCraftingClient (copy), Notification (copy), PickupEvent (copy), InventoryService (copy), MoonCraftingItemIdentity (copy), InventoryServiceEnums (copy)
    local SelectedRecipe = MoonCraftingClient:GetSelectedRecipe();

    if not SelectedRecipe then
        Notification:CreateNotification("No Moon Crafting recipe has been selected");

        return;
    end;

    PickupEvent:Fire("Click");
    local SubmittedSlots = MoonCraftingClient:GetSubmittedSlots();
    local v62 = {};

    for i, v in SelectedRecipe.Inputs do
        if not SubmittedSlots[tostring(i)] then
            local ItemName = v.ItemData.ItemName;
            local ItemType = v.ItemType;
            local v65 = InventoryService:Find(ItemType, function(p63) -- Line: 632
                -- upvalues: v (copy), MoonCraftingItemIdentity (ref), ItemType (copy), ItemName (copy)
                if v.ItemData.AcceptAllTypes then
                    return true;
                end;

                local v64 = MoonCraftingItemIdentity.FromInventoryData(ItemType, p63);

                if v64 == ItemName then
                    return true;
                end;

                if v.ItemData.AcceptedNames then
                    for _, v2 in v.ItemData.AcceptedNames do
                        if v64 == v2 then
                            return true;
                        end;
                    end;
                end;

                return false;
            end);
            local v66 = v.ItemData.Quantity or 1;
            local v67 = i;

            for i2, v2 in v65 do
                if not (v2.ItemData.IsFavorite or v2.ItemData[InventoryServiceEnums.Favorite]) then
                    local v68 = v62[i2] or 0;

                    if (v2.ItemData.Quantity or (v2.ItemData.Uses or 1)) - v68 >= v66 then
                        v62[i2] = v68 + v66;
                        MoonCraftingClient:InputItem(v67, {
                            ItemType = v2.ItemType,
                            ItemData = {
                                UUID = i2
                            }
                        });
                        task.delay(0.1 + v67 * 0.1, function() -- Line: 678
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

function u1.CancelRecipe(p69) -- Line: 687
    -- upvalues: MoonCraftingClient (copy)
    MoonCraftingClient:Cancel();
end;

function u1.CanCancelRecipe(p70) -- Line: 692
    -- upvalues: MoonCraftingClient (copy)
    local v71;

    if MoonCraftingClient:GetCraftingSlot(1) == nil then
        v71 = MoonCraftingClient:GetSelectedRecipe() ~= nil;
    else
        v71 = false;
    end;

    return v71;
end;

function u1.IsAtStation(p72) -- Line: 701
    -- upvalues: u3 (copy), u4 (copy)
    for i, v in u3 do
        if v and u4[i] then
            return true;
        end;
    end;

    return false;
end;

local function OnPromptTriggered(p73: userdata) -- Line: 711
    -- upvalues: u4 (copy), MoonCraftingClient (copy), MoonCraftingConfigAccessor (copy), MarketController (copy), SubmitHeldItem (copy), OpenUI (copy), RefreshAll (copy)
    if not u4[p73] then
        return;
    end;

    local CraftingSlot = MoonCraftingClient:GetCraftingSlot(1);

    if CraftingSlot then
        if CraftingSlot.IsDone then
            MoonCraftingClient:Claim(1);
        else
            local SkipProductId = MoonCraftingConfigAccessor:GetSkipProductId();

            if SkipProductId ~= 0 then
                MoonCraftingClient:AuthoriseSkip(1);
                task.spawn(function() -- Line: 740
                    -- upvalues: MarketController (ref), SkipProductId (copy)
                    MarketController:PromptPurchase(SkipProductId, Enum.InfoType.Product);
                end);
            end;
        end;
    elseif MoonCraftingClient:GetSelectedRecipe() then
        if MoonCraftingClient:IsReadyToCraft() then
            MoonCraftingClient:Craft();
        else
            SubmitHeldItem();
        end;
    else
        OpenUI:Fire();
    end;

    RefreshAll();
end;

function u1.SetupStation(p74: table, u75: userdata) -- Line: 761
    -- upvalues: u4 (copy), EnsurePrompt (copy), ResolveTimer (copy), OnPromptTriggered (copy), u3 (copy), Refresh (copy)
    if u4[u75] then
        return;
    end;

    local v76;

    if u75:IsA("BasePart") then
        v76 = u75;
    elseif u75:IsA("Model") then
        v76 = u75.PrimaryPart or u75:FindFirstChildWhichIsA("BasePart", true);
    else
        v76 = u75:FindFirstChildWhichIsA("BasePart", true);
    end;

    local v77 = 0;

    while not (v76 or (v77 >= 10 or not u75:IsDescendantOf(game))) do
        v77 = v77 + task.wait();

        if u75:IsA("BasePart") then
            v76 = u75;
        elseif u75:IsA("Model") then
            v76 = u75.PrimaryPart or u75:FindFirstChildWhichIsA("BasePart", true);
        else
            v76 = u75:FindFirstChildWhichIsA("BasePart", true);
        end;
    end;

    if not v76 then
        warn((`[MoonCrafting] timed out waiting for a BasePart on {u75:GetFullName()}.`));

        return;
    end;

    if u4[u75] then
        return;
    end;

    local v78 = EnsurePrompt(u75, v76);
    local v79, v80, v81, v82 = ResolveTimer(u75, v76);

    if v79 then
        v79.Enabled = false;
    end;

    if v80 and not v82 then
        v80.RichText = true;
    end;

    u4[u75] = {
        RenderKey = nil,
        WasCrafting = false,
        Anchor = v76,
        Prompt = v78,
        Items = {},
        Timer = v79,
        TimerLabel = v80,
        OwnsTimer = v81,
        TimerHasCaption = v82
    };
    v78.Triggered:Connect(function() -- Line: 810
        -- upvalues: OnPromptTriggered (ref), u75 (copy)
        OnPromptTriggered(u75);
    end);
    v78.PromptShown:Connect(function() -- Line: 814
        -- upvalues: u3 (ref), u75 (copy), Refresh (ref)
        u3[u75] = true;
        Refresh(u75);
    end);
    v78.PromptHidden:Connect(function() -- Line: 819
        -- upvalues: u3 (ref), u75 (copy), Refresh (ref)
        u3[u75] = nil;
        Refresh(u75);
    end);
    Refresh(u75);
end;

local function TeardownStation(p83: userdata) -- Line: 827
    -- upvalues: u4 (copy), u3 (copy)
    local v84 = u4[p83];

    if not v84 then
        return;
    end;

    u4[p83] = nil;
    u3[p83] = nil;

    for _, v in v84.Items do
        v:Destroy();
    end;

    table.clear(v84.Items);

    if v84.Timer then
        if v84.OwnsTimer then
            v84.Timer:Destroy();

            return;
        end;

        v84.Timer.Enabled = false;
    end;
end;

function u1.Start(p85) -- Line: 848
    -- upvalues: u2 (ref), CollectionService (copy), u1 (copy), TeardownStation (copy), RefreshSign (copy), u55 (copy), DataService (copy), SelectRecipe (copy), MoonCraftingClient (copy), PickupEvent (copy), RefreshAll (copy)
    if u2 then
        return;
    end;

    u2 = true;

    for _, v in CollectionService:GetTagged("MoonCraftingStation") do
        task.spawn(function() -- Line: 855
            -- upvalues: u1 (ref), v (copy)
            u1:SetupStation(v);
        end);
    end;

    CollectionService:GetInstanceAddedSignal("MoonCraftingStation"):Connect(function(u86) -- Line: 860
        -- upvalues: u1 (ref)
        task.spawn(function() -- Line: 861
            -- upvalues: u1 (ref), u86 (copy)
            u1:SetupStation(u86);
        end);
    end);
    CollectionService:GetInstanceRemovedSignal("MoonCraftingStation"):Connect(TeardownStation);
    task.spawn(function() -- Line: 873
        -- upvalues: CollectionService (ref), RefreshSign (ref)
        for _, v in CollectionService:GetTagged("MoonCraftingHarvestSign") do
            RefreshSign(v);
        end;
    end);
    CollectionService:GetInstanceAddedSignal("MoonCraftingHarvestSign"):Connect(function(p87) -- Line: 879
        -- upvalues: RefreshSign (ref)
        task.spawn(RefreshSign, p87);
    end);
    CollectionService:GetInstanceRemovedSignal("MoonCraftingHarvestSign"):Connect(function(p88) -- Line: 883
        -- upvalues: u55 (ref)
        u55[p88] = nil;
    end);
    task.spawn(function() -- Line: 888
        -- upvalues: DataService (ref), CollectionService (ref), RefreshSign (ref)
        local PathSignal = DataService:GetPathSignal("HarvestMoonData/SummonsContributed");

        if not PathSignal then
            return;
        end;

        PathSignal:Connect(function() -- Line: 894
            -- upvalues: CollectionService (ref), RefreshSign (ref)
            for _, v in CollectionService:GetTagged("MoonCraftingHarvestSign") do
                RefreshSign(v);
            end;
        end);
    end);
    SelectRecipe.Event:Connect(function(p89: string) -- Line: 902
        -- upvalues: MoonCraftingClient (ref), PickupEvent (ref)
        MoonCraftingClient:SetRecipe(p89);
        PickupEvent:Fire("Craft_SelectRecipe");
    end);
    task.spawn(function() -- Line: 908
        -- upvalues: DataService (ref), RefreshAll (ref)
        local PathSignal = DataService:GetPathSignal("MoonCraftingData/@");

        if PathSignal then
            PathSignal:Connect(RefreshAll);
        end;

        local PathSignal2 = DataService:GetPathSignal("MoonCraftingData");

        if PathSignal2 then
            PathSignal2:Connect(RefreshAll);
        end;
    end);
    task.spawn(function() -- Line: 932
        -- upvalues: RefreshAll (ref)
        while true do
            task.wait(1);
            xpcall(RefreshAll, function(p90) -- Line: 939
                warn((`[MoonCrafting] station repaint failed: {p90}\n{debug.traceback()}`));
            end);
        end;
    end);
end;

return u1;