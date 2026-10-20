-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
game:GetService("ReplicatedFirst");
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local InventorySortingController = require(ReplicatedStorage.Modules.InventorySortingController);
local TradingController = require(ReplicatedStorage.Modules.TradeControllers.TradingController);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local CategoryList = require(ReplicatedStorage.Data.CategoryList);
require(ReplicatedStorage.Modules.UpdateService);
local script_InspectionHover = require(script.InspectionHover);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = Signal.new();
local u2 = Signal.new();
local u3 = GuiService:IsTenFootInterface() or RunService:IsStudio();
local u4 = {};
local u5 = { "All", "Favorited", "NonFavorited" };
local u6 = "All";
local u7 = nil;
local u8 = "All";
local u9 = {
    Favorited = "rbxassetid://83373307650705",
    NonFavorited = "rbxassetid://82761222568258",
    All = "rbxassetid://90084965933996"
};
local u10 = false;
local u11 = nil;
local u12 = nil;

for _, v in CategoryList do
    u4[v.Name] = v;
end;

local function GetNextFilter(p13: string) -- Line: 60
    -- upvalues: u5 (copy)
    local table_find_ret = table.find(u5, p13);
    local v14 = `Invalid Filter "{p13}" passed to GetNextFilter`;
    assert(table_find_ret, v14);
    local v15 = table_find_ret % #u5 + 1;

    return u5[v15], v15;
end;

local function IsOfCategory(p16: userdata) -- Line: 68
    -- upvalues: u6 (ref), u4 (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy)
    if not p16 then
        return false;
    end;

    if u6 == "All" then
        return true;
    end;

    local v17 = u4[u6];

    if not v17 then
        return false;
    end;

    local Tags = v17.Tags;
    local Attribute = p16:GetAttribute(InventoryServiceEnums.ITEM_TYPE);
    local Attribute2 = p16:GetAttribute("ItemType");

    for _, v in Tags do
        if Attribute == ItemTypeEnums[v] or Attribute2 == v then
            return true;
        end;
    end;

    return false;
end;

local function IsEasterTool(p18) -- Line: 98
    -- upvalues: PlantTraitsData (copy)
    if not p18 then
        return false;
    end;

    local v19 = p18:GetAttribute("Seed") or p18:FindFirstChild("Item_String") and p18.Item_String.Value;

    return v19 and PlantTraitsData.EasterSlot[v19] == true and true or false;
end;

local u20 = false;

local function UpdateFunctionStagger() -- Line: 106
    -- upvalues: u20 (ref)
    u20 = true;
end;

task.spawn(function() -- Line: 110
    -- upvalues: u20 (ref), u7 (ref)
    while true do
        repeat
            task.wait(1);
        until u20;

        u20 = false;
        u7();
    end;
end);
local u21 = false;

local function UpdateFunctionButWithTrueBooleanStagger() -- Line: 123
    -- upvalues: u21 (ref)
    u21 = true;
end;

task.spawn(function() -- Line: 127
    -- upvalues: u21 (ref), u7 (ref)
    while true do
        repeat
            task.wait(1);
        until u21;

        u21 = false;
        u7(true);
    end;
end);

local function GetCategory(p22) -- Line: 138
    -- upvalues: u4 (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy)
    for i, v in u4 do
        local v23 = i;

        for _, v2 in v do
            if p22:GetAttribute(InventoryServiceEnums.ITEM_TYPE) == ItemTypeEnums[v23] or p22:GetAttribute("ItemType") == v2 then
                return v23;
            end;
        end;
    end;

    return "All";
end;

local u24 = {
    OpenClose = nil,
    IsOpen = false,
    StateChanged = Instance.new("BindableEvent"),
    ModuleName = "Backpack",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true
};
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local u25 = {
    FilterActive = false,
    PollinatedMutations = {
        MutationHandler:GetMutations().Pollinated_Poor,
        MutationHandler:GetMutations().Pollinated_Fair,
        MutationHandler:GetMutations().Pollinated_Good,
        MutationHandler:GetMutations().Pollinated_Godly
    }
};

function u25.IsTool(p26) -- Line: 176
    -- upvalues: InventoryService (copy), InventoryServiceEnums (copy), u25 (copy), PlantTraitsData (copy)
    if not p26 then
        return false;
    end;

    local ToolData = InventoryService:GetToolData(p26);

    if ToolData then
        local _ = ToolData.ItemData;
    end;

    if p26:GetAttribute("ItemType") == "Pollen Radar 2026" then
        return true;
    end;

    if p26:HasTag("BeeEggTool") then
        return true;
    end;

    if p26:GetAttribute(InventoryServiceEnums.Type) == "Honey Hive Seed Pack" then
        return true;
    end;

    for _, v in u25.PollinatedMutations do
        if p26:GetAttribute(v.Name) then
            return true;
        end;
    end;

    local v27 = p26:GetAttribute("Seed") or p26:FindFirstChild("Item_String") and p26.Item_String.Value;

    return v27 and PlantTraitsData.Honey[v27] == true and true or false;
end;

u24.BeeEvent = u25;

function u24.BeeEvent.IsInBeeGarden() -- Line: 200
    -- upvalues: ReplicatedStorage (copy)
    local CurrentSaveSlot = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController):GetCurrentSaveSlot();
    local v28;

    if CurrentSaveSlot == nil then
        v28 = false;
    else
        v28 = CurrentSaveSlot.IsBeeSlot == true;
    end;

    return v28;
end;

u24.HalloweenEvent = {
    FilterActive = false,
    Color = Color3.fromRGB(255, 95, 0)
};

function u24.HalloweenEvent.IsTool(p29) -- Line: 211
    -- upvalues: PlantTraitsData (copy)
    if not p29 then
        return false;
    end;

    local v30 = p29:GetAttribute("Seed") or p29:FindFirstChild("Item_String") and p29.Item_String.Value;

    return v30 and PlantTraitsData.HalloweenSlot[v30] == true and true or false;
end;

function u24.HalloweenEvent.SetFilter(p31: boolean) -- Line: 217
    -- upvalues: u24 (copy)
    u24.HalloweenEvent.FilterActive = p31;

    if u24.HalloweenEvent.Stroke then
        u24.HalloweenEvent.Stroke.Thickness = p31 and 2 or 0;
    end;

    if u24.HalloweenEvent.Button then
        u24.HalloweenEvent.Button.TextColor3 = p31 and Color3.fromRGB(255, 170, 110) or Color3.fromRGB(255, 255, 255);
        u24.HalloweenEvent.Button.Text = p31 and "Hide Halloween" or "Show Halloween";
    end;
end;

function u24.HalloweenEvent.IsInGhoulGarden() -- Line: 228
    -- upvalues: ReplicatedStorage (copy)
    local CurrentSaveSlot = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController):GetCurrentSaveSlot();
    local v32;

    if CurrentSaveSlot == nil then
        v32 = false;
    else
        v32 = CurrentSaveSlot.IsHalloweenSlot == true;
    end;

    return v32;
end;

function u24.BeeEvent.UpdateButton() -- Line: 233
    -- upvalues: u24 (copy), u20 (ref)
    local v33 = u24.BeeEvent.IsInBeeGarden();

    if u24.HalloweenEvent.Button then
        u24.HalloweenEvent.Button.Visible = u24.HalloweenEvent.IsInGhoulGarden();
    end;

    if not u24.HalloweenEvent.IsInGhoulGarden() and u24.HalloweenEvent.FilterActive then
        u24.HalloweenEvent.SetFilter(false);
        u20 = true;
    end;

    if u24.BeeEvent.Button then
        u24.BeeEvent.Button.Visible = v33;
    end;

    if not v33 and u24.BeeEvent.FilterActive then
        u24.BeeEvent.FilterActive = false;

        if u24.BeeEvent.Stroke then
            u24.BeeEvent.Stroke.Thickness = 0;
        end;

        if u24.BeeEvent.Button then
            u24.BeeEvent.Button.TextColor3 = Color3.fromRGB(255, 255, 255);
            u24.BeeEvent.Button.Text = "Show Bee";
        end;

        u20 = true;
    end;
end;

function u24.SplitQuantity(p34: string) -- Line: 266
    for _, v in { "^(.-)%s*%[[xX](%d+)%]$", "^(.-)%s*%[(%d+)[xX] Uses%]$", "^(.-)%s+[xX](%d+)$" } do
        local string_match_ret, v35 = string.match(p34, v);

        if string_match_ret and string_match_ret ~= "" then
            return string_match_ret, v35;
        end;
    end;

    local string_match_ret, v36 = string.match(p34, "^%[[xX](%d+)%]%s*(.+)$");

    if v36 then
        return v36, string_match_ret;
    end;

    return p34, nil;
end;

u24.Inspection = {
    Active = false,
    IconEnabled = "rbxassetid://86565207204026",
    IconDisabled = "rbxassetid://79637689468140"
};
local Attribute = script:GetAttribute("TextSize");
local u37 = {
    ICON_SIZE = 60,
    ICON_BUFFER = 5,
    BACKGROUND_FADE = script:GetAttribute("BackgroundTransparency"),
    BACKGROUND_COLOR = script:GetAttribute("BackgroundColor")
};
local Attribute2 = script:GetAttribute("DraggableColor");
local Attribute3 = script:GetAttribute("EquippedColor");
local Attribute4 = script:GetAttribute("SlotLockedTransparency");
local Attribute5 = script:GetAttribute("BorderColor");
local v38 = { Enum.KeyCode.Backquote };
local Attribute6 = script:GetAttribute("FullSlots");
local Attribute7 = script:GetAttribute("EmptySlots");
local Attribute8 = script:GetAttribute("SearchBoxColor");
local Attribute9 = script:GetAttribute("SearchBoxTransparency");
local Api = script:WaitForChild("Api");
Api.Parent = game.ReplicatedStorage;
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");
local Favorite_Item = GameEvents:WaitForChild("Favorite_Item");
local Favorite_Item_BE = GameEvents:WaitForChild("Favorite_Item_BE");
local u39 = nil;
local u40 = true;

local function v41() -- Line: 343
    local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui);
    local Frame = Instance.new("Frame", ScreenGui);
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(1, 0, 1, 0);
    local AbsoluteSize = Frame.AbsoluteSize;
    ScreenGui:Destroy();

    return AbsoluteSize;
end;

local Value = Enum.KeyCode.Zero.Value;
local Value2 = Enum.KeyCode.Backspace.Value;
local u42 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local GuiService2 = game:GetService("GuiService");
local ScreenGui = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui);
ScreenGui.DisplayOrder = 120;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ResetOnSpawn = false;
ScreenGui.Name = "BackpackGui";
local ContextActionService = game:GetService("ContextActionService");
local RunService2 = game:GetService("RunService");
local VRService = game:GetService("VRService");
local script_Utility = require(script.Utility);
require(script.GameTranslator);
local Icon = require(ReplicatedStorage2.Modules.Icon);
local u43 = GuiService2:IsTenFootInterface();

if u43 then
    u37.ICON_SIZE = 100;
    Attribute = 24;
end;

local u44 = false;
local v45 = UserInputService.TouchEnabled and v41().X < 1024;
local LocalPlayer = Players.LocalPlayer;
local u46 = nil;
local u47 = nil;
local u48 = nil;
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u54 = u53:FindFirstChildOfClass("Humanoid");
local Backpack = LocalPlayer:WaitForChild("Backpack");
local u55 = Icon.new();
u55:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected");
u55:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected");
u55:bindToggleKey(v38[1], v38[2]);
u55:setName("InventoryIcon");
u55:setImageScale(1.12);
u55:setOrder(-5);
u55:setCaption("Toggle the backpack.");
u55.deselectWhenOtherIconSelected = false;
local u56 = {};
local u57 = nil;
local u58 = {};
local u59 = {};
local u60 = {};
local u61 = 0;
local u62 = false;
local u63 = false;
local u64 = false;
local u65 = false;
local u66 = {};
local u67 = {};
local u68 = false;
local u69 = 0;
local VREnabled = VRService.VREnabled;
local u70 = VREnabled and Attribute7 and Attribute7 or (v45 and 6 or Attribute6);
local u71 = VREnabled and 3 or (v45 and 2 or 4);
local u72 = nil;

local function SyncInspectionHover() -- Line: 447
    -- upvalues: u24 (copy), u48 (ref), script_InspectionHover (copy), u56 (copy)
    local Active = u24.Inspection.Active;

    if Active then
        if u48 == nil then
            Active = false;
        else
            Active = u48.Visible == true;
        end;
    end;

    script_InspectionHover.SetActive(Active, u56, u48 and u48.Visible == true);
end;

local function EvaluateBackpackPanelVisibility(p73) -- Line: 455
    -- upvalues: u55 (copy), u40 (ref), VRService (copy), TradingController (copy), u10 (ref)
    return p73 and u55.enabled and (u40 and VRService.VREnabled) and (TradingController.CurrentTradeReplicator == nil and true or u10);
end;

local function ShowVRBackpackPopup() -- Line: 459
end;

local function NewGui(p74, p75) -- Line: 465
    -- upvalues: Attribute (ref)
    local Instance_new_ret = Instance.new(p74);
    Instance_new_ret.Name = p75;
    Instance_new_ret.BackgroundColor3 = Color3.new(0, 0, 0);
    Instance_new_ret.BackgroundTransparency = 1;
    Instance_new_ret.BorderColor3 = Color3.new(0, 0, 0);
    Instance_new_ret.BorderSizePixel = 0;
    Instance_new_ret.Size = UDim2.new(1, 0, 1, 0);

    if p74:match("Text") then
        Instance_new_ret.TextColor3 = Color3.new(1, 1, 1);
        Instance_new_ret.Text = "";
        Instance_new_ret.FontFace = script:GetAttribute("LabelFont");
        Instance_new_ret.TextSize = Attribute;
        Instance_new_ret.TextWrapped = true;

        if p74 == "TextButton" then
            Instance_new_ret.FontFace = script:GetAttribute("SlotFont");
        end;
    end;

    return Instance_new_ret;
end;

local function FindLowestEmpty() -- Line: 486
    -- upvalues: u70 (copy), u56 (copy)
    for i = 1, u70 do
        local v76 = u56[i];

        if not v76.Tool then
            return v76;
        end;

        local _ = i;
    end;

    return nil;
end;

local function UseGazeSelection() -- Line: 496
    -- upvalues: UserInputService (copy)
    return UserInputService.VREnabled;
end;

local function AdjustHotbarFrames() -- Line: 500
    -- upvalues: u48 (ref), u61 (ref), u70 (copy), u56 (copy)
    local Visible = u48.Visible;
    local v77;

    if Visible then
        v77 = u70;
    else
        v77 = u61;

        for i = 1, u70 do
            local v78;

            if u56[i].Hidden then
                v77 = v77 - 1;
                v78 = i;
            else
                v78 = i;
            end;
        end;
    end;

    local _ = v77 >= 1;
    local v79 = 0;

    for i = 1, u70 do
        local v80 = u56[i];
        local v81;

        if v80 and (v80.Tool or Visible) and (not v80.Hidden or Visible) then
            v79 = v79 + 1;
            v80:Readjust(v79, v77);
            v80.Frame.Visible = true;
            v81 = i;
        elseif v80 then
            v80.Frame.Visible = false;
            v81 = i;
        else
            v81 = i;
        end;
    end;
end;

local u82 = nil;

local function triggerScrollUpdate() -- Line: 531
    -- upvalues: u52 (ref), u37 (copy), u50 (ref)
    u50.CanvasSize = UDim2.new(0, 0, 0, u52.AbsoluteCellCount.Y * (u37.ICON_SIZE + u37.ICON_BUFFER) + u37.ICON_BUFFER);
end;

local function UpdateScrollingFrameCanvasSize(p83: boolean?) -- Line: 539
    -- upvalues: u82 (ref), u52 (ref), u37 (copy), u50 (ref)
    if u82 then
        pcall(task.cancel, u82);
    end;

    if not p83 then
        u82 = task.delay(0.05, function() -- Line: 548
            -- upvalues: u52 (ref), u37 (ref), u50 (ref), u82 (ref)
            u50.CanvasSize = UDim2.new(0, 0, 0, u52.AbsoluteCellCount.Y * (u37.ICON_SIZE + u37.ICON_BUFFER) + u37.ICON_BUFFER);
            u82 = nil;
        end);

        return;
    end;

    u50.CanvasSize = UDim2.new(0, 0, 0, u52.AbsoluteCellCount.Y * (u37.ICON_SIZE + u37.ICON_BUFFER) + u37.ICON_BUFFER);
    u82 = nil;
end;

local function AdjustInventoryFrames() -- Line: 555
    -- upvalues: u70 (copy), u56 (copy), UpdateScrollingFrameCanvasSize (copy)
    for i = u70 + 1, #u56 do
        local v84 = u56[i];
        local v85;

        if v84 then
            v84.Frame.LayoutOrder = v84.Index;
            v84.Frame.Visible = v84.Tool ~= nil;
            v85 = i;
        else
            v85 = i;
        end;
    end;

    UpdateScrollingFrameCanvasSize();
end;

local function UpdateBackpackLayout() -- Line: 566
    -- upvalues: u47 (ref), u37 (copy), u70 (copy), u48 (ref), u71 (copy), VREnabled (copy), u50 (ref), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy)
    u47.Size = UDim2.new(0, u37.ICON_BUFFER + u70 * (u37.ICON_SIZE + u37.ICON_BUFFER), 0, u37.ICON_BUFFER + u37.ICON_SIZE + u37.ICON_BUFFER);
    u47.Position = UDim2.new(0.5, -u47.Size.X.Offset / 2, 1, -u47.Size.Y.Offset);
    u48.Size = UDim2.new(0, u47.Size.X.Offset, 0, u47.Size.Y.Offset * u71 + 40 + (VREnabled and 80 or 0));
    u48.Position = UDim2.new(0.5, -u48.Size.X.Offset / 2, 1, u47.Position.Y.Offset - u48.Size.Y.Offset);
    u50.Size = UDim2.new(1, u50.ScrollBarThickness + 1, 1, -40 - (VREnabled and 80 or 0));
    u50.Position = UDim2.new(0, 0, 0, 40 + (VREnabled and 40 or 0));
    AdjustHotbarFrames();
    AdjustInventoryFrames();
end;

local function Clamp(p86, p87, p88) -- Line: 600
    local math_max_ret = math.max(p86, p88);

    return math.min(p87, math_max_ret);
end;

local function CheckBounds(p89, p90, p91) -- Line: 604
    local AbsolutePosition = p89.AbsolutePosition;
    local AbsoluteSize = p89.AbsoluteSize;
    local v92;

    if AbsolutePosition.X < p90 and (p90 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p91) then
        v92 = p91 <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v92 = false;
    end;

    return v92;
end;

local function GetOffset(p93, p94) -- Line: 610
    return (p93.AbsolutePosition + p93.AbsoluteSize / 2 - p94).magnitude;
end;

local function UnequipAllTools() -- Line: 615
    -- upvalues: u54 (ref)
    if u54 then
        u54:UnequipTools();
    end;
end;

local function EquipNewTool(p95) -- Line: 621
    -- upvalues: TradingController (copy), u20 (ref), u10 (ref), u54 (ref), u53 (ref)
    if TradingController:AddFromTool(p95) then
        u20 = true;

        return;
    end;

    if u10 then
        return;
    end;

    if u54 then
        u54:UnequipTools();
    end;

    p95.Parent = u53;
end;

local function ToggleFavoriteTool(p96) -- Line: 635
    -- upvalues: Favorite_Item (copy), Favorite_Item_BE (copy)
    local Tool = p96.Tool;

    if not Tool then
        return;
    end;

    if workspace:GetAttribute("InTutorial") then
        return;
    end;

    Favorite_Item:FireServer(Tool);
    task.delay(0.25, function() -- Line: 647
        -- upvalues: Favorite_Item_BE (ref), Tool (copy)
        Favorite_Item_BE:Fire(Tool);
    end);
end;

local function IsEquipped(p97) -- Line: 652
    -- upvalues: u53 (ref)
    if p97 then
        p97 = p97.Parent == u53;
    end;

    return p97;
end;

os.clock();

local function MakeSlot(p98, p99) -- Line: 658
    -- upvalues: u56 (copy), u3 (copy), NewGui (copy), VRService (copy), Attribute4 (copy), PlantTraitsData (copy), u24 (copy), Attribute2 (copy), u37 (copy), u47 (ref), InventoryServiceEnums (copy), u70 (copy), u48 (ref), UserInputService (copy), u61 (ref), u63 (ref), u44 (ref), ContextActionService (copy), u58 (copy), u57 (ref), SyncInspectionHover (copy), u53 (ref), u72 (ref), Attribute3 (copy), u60 (copy), u55 (copy), u12 (ref), UpdateScrollingFrameCanvasSize (copy), ReplicatedStorage2 (copy), u39 (ref), u54 (ref), Backpack (ref), TradingController (copy), u20 (ref), u10 (ref), Attribute5 (copy), ToggleFavoriteTool (copy), MakeSlot (copy), u51 (ref), u65 (ref), u59 (copy), Value (copy), LocalPlayer (copy), InventorySortingController (copy), u11 (ref), u7 (ref), u50 (ref)
    local v100 = p99 or #u56 + 1;
    local u101 = {
        Tool = nil,
        Index = v100,
        Frame = nil,
        Hidden = false
    };
    local u102 = nil;
    local u103 = nil;
    local u104 = nil;
    local u105 = nil;
    local u106 = nil;
    local u107 = nil;
    local u108 = nil;
    local u109 = nil;
    local u110 = nil;

    local function IsDraggable() -- Line: 685
        -- upvalues: u101 (copy), u3 (ref), u102 (ref)
        if u101.Hidden then
            return false;
        end;

        if u3 then
            return u102:GetAttribute("Draggable");
        end;

        return u102.Draggable;
    end;

    local u111 = NewGui("ImageLabel", "EasterIcon");
    u111.Size = UDim2.new(0.25, 0, 0.25, 0);
    u111.Position = UDim2.new(1, 0, 0, 2);
    u111.AnchorPoint = Vector2.new(1, 0);
    u111.Visible = false;
    u111.Image = "rbxassetid://106773525796884";
    u111.ImageColor3 = Color3.fromRGB(255, 197, 255);
    u111.ZIndex = 10;
    u101.HalloweenIcon = u111:Clone();
    u101.HalloweenIcon.Name = "HalloweenIcon";
    u101.HalloweenIcon.Image = "rbxassetid://120669580807042";
    u101.HalloweenIcon.ImageColor3 = Color3.fromRGB(255, 170, 90);

    local function UpdateSlotFading() -- Line: 713
        -- upvalues: VRService (ref), u102 (ref), u101 (copy), u3 (ref), Attribute4 (ref), PlantTraitsData (ref), u24 (ref), Attribute2 (ref), u37 (ref), u111 (copy)
        local _ = VRService.VREnabled;
        u102.SelectionImageObject = nil;
        local v112;

        if u101.Hidden then
            v112 = false;
        elseif u3 then
            v112 = u102:GetAttribute("Draggable");
        else
            v112 = u102.Draggable;
        end;

        u102.BackgroundTransparency = v112 and 0 or Attribute4;
        local v113;

        if u101.Tool then
            local Tool = u101.Tool;
            local v114;

            if Tool then
                local v115 = Tool:GetAttribute("Seed") or Tool:FindFirstChild("Item_String") and Tool.Item_String.Value;
                v114 = v115 and PlantTraitsData.EasterSlot[v115] == true and true or false;
            else
                v114 = false;
            end;

            v113 = v114 or false;
        else
            v113 = false;
        end;

        local v116 = u101.Tool and u24.BeeEvent.IsTool(u101.Tool) or false;
        local v117 = (u101.Tool and u101.Tool:GetAttribute("Anniversary20thFruit") == true and true or false) and Color3.fromRGB(255, 0, 0) or v113 and Color3.fromRGB(181, 109, 221) or (v116 and Color3.fromRGB(255, 149, 0) or u24.HalloweenEvent.IsTool(u101.Tool) and u24.HalloweenEvent.Color);

        if not v117 then
            local v118;

            if u101.Hidden then
                v118 = false;
            elseif u3 then
                v118 = u102:GetAttribute("Draggable");
            else
                v118 = u102.Draggable;
            end;

            v117 = v118 and Attribute2 or u37.BACKGROUND_COLOR;
        end;

        u102.BackgroundColor3 = v117;
        u111.Visible = v113;
        local HalloweenIcon = u101.HalloweenIcon;
        local v119;

        if u101.Tool == nil then
            v119 = false;
        else
            v119 = u24.HalloweenEvent.IsTool(u101.Tool);
        end;

        HalloweenIcon.Visible = v119;
    end;

    function u101.Readjust(p120, p121, p122) -- Line: 746
        -- upvalues: u47 (ref), u37 (ref), u102 (ref)
        u102.Position = UDim2.new(0, u47.Size.X.Offset / 2 - u37.ICON_SIZE / 2 + (u37.ICON_BUFFER + u37.ICON_SIZE) * (p121 - (p122 / 2 + 0.5)), 0, u37.ICON_BUFFER);
    end;

    function u101.Fill(u123, u124) -- Line: 754
        -- upvalues: u107 (ref), InventoryServiceEnums (ref), u101 (copy), PlantTraitsData (ref), u24 (ref), u102 (ref), u3 (ref), Attribute2 (ref), u37 (ref), u111 (copy), u105 (ref), u109 (ref), u104 (ref), u106 (ref), u70 (ref), u48 (ref), UserInputService (ref), u61 (ref), u63 (ref), u44 (ref), ContextActionService (ref), u58 (ref), u57 (ref), u56 (ref), SyncInspectionHover (ref)
        if u107 then
            u107:Disconnect();
            u107 = nil;
        end;

        if not u124 then
            return u123:Clear();
        end;

        u123.Tool = u124;
        u107 = u124:GetAttributeChangedSignal(InventoryServiceEnums.Favorite):Connect(function() -- Line: 766
            -- upvalues: u123 (copy), u124 (copy), InventoryServiceEnums (ref), u101 (ref)
            u123.Favorite = u124:GetAttribute(InventoryServiceEnums.Favorite);
            u101.Frame.FavIcon.Visible = u123.Favorite;
        end);
        xpcall(function() -- Line: 771
            -- upvalues: u123 (copy), u124 (copy), InventoryServiceEnums (ref), u101 (ref)
            u123.Favorite = u124:GetAttribute(InventoryServiceEnums.Favorite);
            u101.Frame.FavIcon.Visible = u123.Favorite;
        end, warn);

        local function assignToolData() -- Line: 776
            -- upvalues: u123 (copy), u124 (copy), PlantTraitsData (ref), u24 (ref), u102 (ref), u101 (ref), u3 (ref), Attribute2 (ref), u37 (ref), u111 (ref), InventoryServiceEnums (ref), u105 (ref), u109 (ref), u104 (ref)
            if u123.Hidden then
                return;
            end;

            local v125 = u124;
            local v126;

            if v125 then
                local v127 = v125:GetAttribute("Seed") or v125:FindFirstChild("Item_String") and v125.Item_String.Value;
                v126 = v127 and PlantTraitsData.EasterSlot[v127] == true and true or false;
            else
                v126 = false;
            end;

            local v128 = u24.BeeEvent.IsTool(u124);
            local v129 = u124:GetAttribute("Anniversary20thFruit") == true and Color3.fromRGB(255, 0, 0) or v126 and Color3.fromRGB(181, 109, 221) or (v128 and Color3.fromRGB(255, 149, 0) or u24.HalloweenEvent.IsTool(u124) and u24.HalloweenEvent.Color);

            if not v129 then
                local v130;

                if u101.Hidden then
                    v130 = false;
                elseif u3 then
                    v130 = u102:GetAttribute("Draggable");
                else
                    v130 = u102.Draggable;
                end;

                v129 = v130 and Attribute2 or u37.BACKGROUND_COLOR;
            end;

            u102.BackgroundColor3 = v129;
            u111.Visible = v126;
            u101.HalloweenIcon.Visible = u24.HalloweenEvent.IsTool(u124);
            local Name = u124.Name;
            local ToolTip = u124.ToolTip;

            if not u124:GetAttribute(InventoryServiceEnums.Uses) then
                u124:GetAttribute("Uses");
            end;

            local v131, v132 = u24.SplitQuantity(Name);
            u105.Text = v131;
            u101.Quantity.Text = not v132 and "" or `x{v132}`;
            u101.Quantity.Visible = v132 ~= nil;
            u105.TextSize = 14;
            u105.Visible = true;

            if u109 and u124:IsA("Tool") then
                u109.Text = ToolTip;
                local v133 = u109.TextBounds.X + 24;
                local v134 = u109.TextBounds.Y + 10;
                u109.Size = UDim2.new(0, v133, 0, v134);
                u109.Position = UDim2.new(0.5, -v133 / 2, 0, -v134 - 4);
            end;

            local TextureId = u124.TextureId;
            u104.Image = TextureId;

            if TextureId and TextureId ~= "" then
                u105.Visible = false;

                if string.find(Name, "Strawberry") or string.find(Name, "Exotic Enchanted Seed Pack") then
                    u105.TextSize = 12;
                end;
            end;
        end;

        assignToolData();

        if u106 then
            u106:disconnect();
            u106 = nil;
        end;

        u123.AssignToolData = assignToolData;
        u106 = u124.Changed:connect(function(p135) -- Line: 848
            -- upvalues: assignToolData (copy)
            if p135 == "TextureId" or (p135 == "Name" or p135 == "ToolTip") then
                assignToolData();
            end;
        end);
        local v136 = u123.Index <= u70;

        if not (v136 and not u48.Visible or UserInputService.VREnabled) then
            if u3 then
                u102:SetAttribute("Draggable", true);
            else
                u102.Draggable = true;
            end;
        end;

        u123:UpdateEquipView();

        if v136 then
            u61 = u61 + 1;

            if u63 and (u61 >= 1 and not u44) then
                u44 = true;
                ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            end;
        end;

        u58[u124] = u123;
        local v137;

        for i = 1, u70 do
            v137 = u56[i];

            if not v137.Tool then
                break;
            end;

            local _ = i;
        end;

        v137 = nil;
        u57 = v137;

        if u24.Inspection.Active then
            task.defer(SyncInspectionHover);
        end;
    end;

    function u101.UpdateIndex(p138, p139) -- Line: 893
        p138.Index = p139;
        p138.Frame.Name = tostring(p139);
        p138.Frame.LayoutOrder = p139;
    end;

    function u101.UpdateVisual(p140) -- Line: 899
        -- upvalues: u104 (ref), u105 (ref), u101 (copy), u109 (ref), u3 (ref), u102 (ref), u37 (ref), u111 (copy), u70 (ref), u48 (ref), UserInputService (ref), InventoryServiceEnums (ref)
        if not p140.Hidden then
            if not (p140.Index <= u70 and not u48.Visible or UserInputService.VREnabled) then
                if u3 then
                    u102:SetAttribute("Draggable", true);
                else
                    u102.Draggable = true;
                end;
            end;

            if p140.AssignToolData then
                p140.AssignToolData();
            end;

            if p140.Tool then
                u102.FavIcon.Visible = p140.Tool:GetAttribute(InventoryServiceEnums.Favorite);
            end;

            p140:UpdateEquipView();

            return;
        end;

        u104.Image = "";
        u105.Text = "";
        u101.Quantity.Visible = false;

        if u109 then
            u109.Text = "";
            u109.Visible = false;
        end;

        if u3 then
            u102:SetAttribute("Draggable", false);
        else
            u102.Draggable = false;
        end;

        u102.FavIcon.Visible = false;
        p140:UpdateEquipView(true);
        u102.BackgroundColor3 = u37.BACKGROUND_COLOR;
        u111.Visible = false;
        u101.HalloweenIcon.Visible = false;
    end;

    function u101.Clear(p141) -- Line: 948
        -- upvalues: u106 (ref), u107 (ref), u104 (ref), u105 (ref), u101 (copy), u109 (ref), u3 (ref), u102 (ref), u58 (ref), u70 (ref), u61 (ref), u44 (ref), ContextActionService (ref), u57 (ref), u56 (ref), u24 (ref), SyncInspectionHover (ref)
        if not p141.Tool then
            return;
        end;

        if u106 then
            u106:disconnect();
            u106 = nil;
        end;

        if u107 then
            u107:disconnect();
            u107 = nil;
        end;

        u104.Image = "";
        u105.Text = "";
        u101.Quantity.Visible = false;
        u101.HalloweenIcon.Visible = false;

        if u109 then
            u109.Text = "";
            u109.Visible = false;
        end;

        if u3 then
            u102:SetAttribute("Draggable", false);
        else
            u102.Draggable = false;
        end;

        u102.FavIcon.Visible = false;
        u58[p141.Tool] = nil;
        p141.Tool = nil;
        p141:UpdateEquipView(true);

        if p141.Index <= u70 then
            u61 = u61 - 1;

            if u61 < 1 then
                u44 = false;
                ContextActionService:UnbindAction("RBXHotbarEquip");
            end;
        end;

        local v142;

        for i = 1, u70 do
            v142 = u56[i];

            if not v142.Tool then
                break;
            end;

            local _ = i;
        end;

        v142 = nil;
        u57 = v142;

        if u24.Inspection.Active then
            task.defer(SyncInspectionHover);
        end;
    end;

    function u101.UpdateEquipView(p143, p144) -- Line: 1002
        -- upvalues: u53 (ref), u72 (ref), u101 (copy), u108 (ref), NewGui (ref), u102 (ref), Attribute3 (ref), UpdateSlotFading (copy)
        if p144 then
            if u108 then
                u108.Parent = nil;
            end;
        else
            local Tool = p143.Tool;

            if Tool then
                Tool = Tool.Parent == u53;
            end;

            if Tool and not p143.Hidden then
                u72 = u101;

                if not u108 then
                    u108 = NewGui("Frame", "Equipped");
                    u108.ZIndex = u102.ZIndex;
                    local UICorner = Instance.new("UICorner");
                    UICorner.CornerRadius = script:GetAttribute("CornerRadius");
                    UICorner.Parent = u108;
                    local UIStroke = Instance.new("UIStroke");
                    UIStroke.Name = "EquippedStroke";
                    UIStroke.Color = Attribute3;
                    UIStroke.Thickness = 3;
                    UIStroke.Parent = u108;
                end;

                u108.Parent = u102;
                task.defer(function() -- Line: 1021
                    -- upvalues: u108 (ref)
                    local EquippedStroke = u108:FindFirstChild("EquippedStroke");

                    if not EquippedStroke then
                        return;
                    end;

                    EquippedStroke.Thickness = 3;
                end);
            elseif u108 then
                u108.Parent = nil;
            end;
        end;

        UpdateSlotFading();
    end;

    function u101.IsEquipped(p145) -- Line: 1034
        -- upvalues: u53 (ref)
        local Tool = p145.Tool;

        if Tool then
            Tool = Tool.Parent == u53;
        end;

        return Tool;
    end;

    function u101.Delete(p146) -- Line: 1038
        -- upvalues: u60 (ref), u102 (ref), u55 (ref), u12 (ref), u56 (ref), UpdateScrollingFrameCanvasSize (ref)
        if u60[u102] then
            u60[u102] = nil;
            u55:unlock();

            if u12 then
                u12:Destroy();
                u12 = nil;
            end;
        end;

        local Index = p146.Index;
        u102:Destroy();
        table.remove(u56, Index);

        for i = Index, #u56 do
            local v147 = u56[i];
            local v148;

            if v147 then
                v147:UpdateIndex(i);
                v148 = i;
            else
                v148 = i;
            end;
        end;

        UpdateScrollingFrameCanvasSize();
    end;

    function u101.Swap(p149, p150) -- Line: 1064
        local Tool = p149.Tool;
        local Tool2 = p150.Tool;
        p149:Clear();

        if Tool2 then
            p150:Clear();
            p149:Fill(Tool2);
        end;

        if Tool then
            p150:Fill(Tool);

            return;
        end;

        p150:Clear();
    end;

    function u101.TurnNumber(p151, p152) -- Line: 1078
        -- upvalues: u110 (ref)
        if u110 then
            u110.Visible = p152;
        end;
    end;

    function u101.SetClickability(p153, p154) -- Line: 1084
        -- upvalues: UserInputService (ref), u3 (ref), u102 (ref), UpdateSlotFading (copy)
        if p153.Tool then
            if UserInputService.VREnabled then
                if u3 then
                    u102:SetAttribute("Draggable", false);
                else
                    u102.Draggable = false;
                end;
            elseif u3 then
                u102:SetAttribute("Draggable", not p154);
            else
                u102.Draggable = not p154;
            end;

            UpdateSlotFading();
        end;
    end;

    local ItemRarityFinder = require(ReplicatedStorage2.Modules.ItemRarityFinder);
    local ReversedItemTypeEnums = require(ReplicatedStorage2.Data.EnumRegistry.ReversedItemTypeEnums);
    local PetTraitsData = require(ReplicatedStorage2.Modules.PetTraitsData);

    function u101.CheckTerms(p155: table, p156: table, u157: boolean?) -- Line: 1112
        -- upvalues: InventoryServiceEnums (ref), ReversedItemTypeEnums (copy), ItemRarityFinder (copy), PlantTraitsData (ref), PetTraitsData (copy), u105 (ref), u109 (ref)
        if not (p156 and next(p156)) then
            return 0;
        end;

        local u158 = 0;

        local function checkEm(p159, p160) -- Line: 1119
            -- upvalues: u158 (ref), u157 (copy)
            local v161 = p159:lower();
            local v162 = p160:lower();

            if v162 == "" then
                return;
            end;

            local v163 = 1;
            local v164 = 0;

            while true do
                local string_find_ret, v165 = string.find(v161, v162, v163, true);

                if not string_find_ret then
                    break;
                end;

                v164 = v164 + 1;
                v163 = v165 + 1;
            end;

            u158 = u158 + v164;

            if u157 and u158 > 0 then
                return u158;
            end;
        end;

        local Tool = p155.Tool;

        if not Tool then
            return u158;
        end;

        local Attribute10 = Tool:GetAttribute(InventoryServiceEnums.ItemName);
        local v166 = ReversedItemTypeEnums[Tool:GetAttribute(InventoryServiceEnums.ITEM_TYPE)];
        local v167;

        if Attribute10 and v166 then
            v167 = ItemRarityFinder(Attribute10, v166);
        else
            v167 = nil;
        end;

        local v168 = nil;

        if Attribute10 and (v166 == "Holdable" or v166 == "Seed") then
            v168 = PlantTraitsData.GetTraitsAsString(Attribute10);
        elseif Attribute10 and v166 == "Pet" then
            v168 = PetTraitsData.GetTraitsAsString(Attribute10);
        end;

        for i in p156 do
            checkEm(Tool.Name, i);
            checkEm(u105.Text, i);

            if Tool:IsA("Tool") then
                local v169 = u109 and u109.Text or "";
                checkEm(Tool.ToolTip or "", i);
                checkEm(v169, i);
            end;

            if Attribute10 then
                checkEm(Attribute10, i);
            end;

            if v168 then
                checkEm(v168, i);
            end;

            if v167 then
                checkEm(v167, i);
            end;
        end;

        return u158;
    end;

    function u101.Select(p170) -- Line: 1192
        -- upvalues: u101 (copy), u39 (ref), u53 (ref), u54 (ref), Backpack (ref), TradingController (ref), u20 (ref), u10 (ref)
        local Tool = u101.Tool;

        if Tool then
            u39 = p170;
            local v171;

            if Tool then
                v171 = Tool.Parent == u53;
            else
                v171 = Tool;
            end;

            if v171 then
                u39 = nil;

                if u54 then
                    u54:UnequipTools();
                end;
            elseif Tool.Parent == Backpack then
                if TradingController:AddFromTool(Tool) then
                    u20 = true;

                    return;
                end;

                if u10 then
                    return;
                end;

                if u54 then
                    u54:UnequipTools();
                end;

                Tool.Parent = u53;
            end;
        end;
    end;

    u102 = NewGui("TextButton", v100);
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Parent = u102;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = script:GetAttribute("CornerRadius");
    UICorner.Parent = u102;
    UIStroke.Thickness = 0;
    u102.BackgroundColor3 = u37.BACKGROUND_COLOR;
    UIStroke.Color = Attribute5;
    u102.Text = "";
    u102.AutoButtonColor = false;
    u102.BorderSizePixel = 0;
    u102.Size = UDim2.new(0, u37.ICON_SIZE, 0, u37.ICON_SIZE);
    u102.Active = true;
    u102.Draggable = false;

    if u3 then
        u102:SetAttribute("Draggable", false);
    end;

    u102.BackgroundTransparency = Attribute4;
    u102.MouseButton1Click:Connect(function() -- Line: 1238
        -- upvalues: u101 (copy)
        changeSlot(u101);
    end);
    local os_clock_ret = os.clock();

    if UserInputService.TouchEnabled then
        local v172 = u102;
        v172.MouseButton1Click:Connect(function() -- Line: 1248
            -- upvalues: os_clock_ret (ref), ToggleFavoriteTool (ref), u101 (copy)
            if os.clock() > os_clock_ret + 0.25 then
                os_clock_ret = os.clock();

                return;
            end;

            ToggleFavoriteTool(u101);
        end);
        v172.TouchLongPress:Connect(function(p173, p174, p175) -- Line: 1256
            -- upvalues: ToggleFavoriteTool (ref), u101 (copy)
            if p174 == Enum.UserInputState.End then
                ToggleFavoriteTool(u101);
            end;
        end);
    else
        u102.MouseButton2Click:Connect(function() -- Line: 1262
            -- upvalues: ToggleFavoriteTool (ref), u101 (copy)
            ToggleFavoriteTool(u101);
        end);
    end;

    u101.Frame = u102;
    local v176 = NewGui("Frame", "SelectionObjectClipper");
    v176.Visible = false;
    v176.Parent = u102;
    local v177 = NewGui("ImageLabel", "Selector");
    v177.Size = UDim2.new(1, 0, 1, 0);
    v177.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
    v177.ScaleType = Enum.ScaleType.Slice;
    v177.SliceCenter = Rect.new(12, 12, 52, 52);
    v177.Parent = v176;
    u104 = NewGui("ImageLabel", "Icon");
    u104.Size = UDim2.new(0.8, 0, 0.8, 0);
    u104.Position = UDim2.new(0.1, 0, 0.1, 0);
    u104.Parent = u102;
    local v178 = NewGui("ImageLabel", "FavIcon");
    v178.Size = UDim2.new(0.2, 0, 0.2, 0);
    v178.Position = UDim2.new(0.8, 0, 0.8, 0);
    v178.Parent = u102;
    v178.Visible = false;
    v178.Image = "rbxassetid://80131230547874";
    v178.ImageColor3 = Color3.fromRGB(255, 0, 0);
    v178.ZIndex = 10;
    u111.Parent = u102;
    u101.HalloweenIcon.Parent = u102;
    u105 = NewGui("TextLabel", "ToolName");
    u105.Size = UDim2.new(1, -2, 1, -2);
    u105.Position = UDim2.new(0, 1, 0, 1);
    u105.Parent = u102;
    u101.Quantity = NewGui("TextLabel", "Quantity");
    u101.Quantity.AnchorPoint = Vector2.new(1, 1);
    u101.Quantity.Position = UDim2.new(1, -2, 1, -2);
    u101.Quantity.Size = UDim2.fromOffset(0, 14);
    u101.Quantity.AutomaticSize = Enum.AutomaticSize.X;
    u101.Quantity.TextSize = 13;
    u101.Quantity.TextWrapped = false;
    u101.Quantity.BackgroundTransparency = 0.35;
    u101.Quantity.ZIndex = 3;
    u101.Quantity.Visible = false;
    Instance.new("UICorner", u101.Quantity).CornerRadius = UDim.new(0, 4);
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 3);
    UIPadding.PaddingRight = UDim.new(0, 3);
    UIPadding.Parent = u101.Quantity;
    u101.Quantity.Parent = u102;
    u101.Frame.LayoutOrder = u101.Index;

    if v100 <= u70 then
        u109 = NewGui("TextLabel", "ToolTip");
        u109.ZIndex = 2;
        u109.FontFace = script:GetAttribute("ToolTipFont");
        u109.RichText = true;
        u109.TextWrapped = false;
        u109.TextYAlignment = Enum.TextYAlignment.Center;
        u109.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4);
        u109.BackgroundTransparency = 0;
        u109.Visible = false;
        u109.Parent = u102;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = script:GetAttribute("CornerRadius");
        UICorner2.Parent = u109;
        u102.MouseEnter:Connect(function() -- Line: 1339
            -- upvalues: u109 (ref)
            if u109.Text ~= "" then
                u109.Visible = true;
            end;
        end);
        u102.MouseLeave:Connect(function() -- Line: 1344
            -- upvalues: u109 (ref)
            u109.Visible = false;
        end);

        function u101.MoveToInventory(p179) -- Line: 1348
            -- upvalues: u101 (copy), u70 (ref), MakeSlot (ref), u51 (ref), u53 (ref), u54 (ref), u65 (ref)
            if u70 < u101.Index then
                return nil;
            end;

            local Tool = p179.Tool;
            p179:Clear();
            local v180 = MakeSlot(u51);
            v180:Fill(Tool);

            if Tool then
                Tool = Tool.Parent == u53;
            end;

            if Tool and u54 then
                u54:UnequipTools();
            end;

            if u65 then
                v180.Frame.Visible = false;
            end;

            return v180;
        end;

        if v100 < 10 or v100 == u70 then
            local v181 = v100 < 10 and (v100 or 0) or 0;
            u110 = NewGui("TextLabel", "Number");
            u110.Text = v181;
            u110.Size = UDim2.new(0, 15, 0, 15);
            u110.Visible = false;
            u110.Parent = u102;
            u59[Value + v181] = u101.Select;
        end;
    end;

    local Position = u102.Position;
    local u182 = 0;
    local u183 = nil;
    local u184 = nil;

    local function onDragStart(p185) -- Line: 1385
        -- upvalues: u60 (ref), u102 (ref), Position (ref), UIStroke (copy), u55 (ref), u184 (ref), u101 (copy), LocalPlayer (ref), u103 (ref), u104 (ref), u105 (ref), u110 (ref), u108 (ref), u183 (ref), u51 (ref), u48 (ref), NewGui (ref), u12 (ref)
        u60[u102] = true;
        Position = p185;
        UIStroke.Thickness = 2;
        u55:lock();

        if u184 then
            u184:Disconnect();
            u184 = nil;
        end;

        if u101.Tool then
            u184 = u101.Tool.AncestryChanged:Connect(function(p186, p187) -- Line: 1398
                -- upvalues: u101 (ref), u184 (ref), LocalPlayer (ref), u103 (ref)
                if not u101.Tool or p186 ~= u101.Tool then
                    if u184 then
                        u184:Disconnect();
                        u184 = nil;
                    end;

                    return;
                end;

                local Parent = u101.Tool.Parent;

                if Parent ~= LocalPlayer.Backpack and Parent ~= LocalPlayer.Character then
                    if u103 then
                        u103:Destroy();
                        u103 = nil;
                    end;

                    if u184 then
                        u184:Disconnect();
                        u184 = nil;
                    end;
                end;
            end);
        elseif u184 then
            u184:Disconnect();
            u184 = nil;
        end;

        u102.ZIndex = 2;
        u104.ZIndex = 2;
        u105.ZIndex = 2;
        u102.Parent.ZIndex = 2;

        if u110 then
            u110.ZIndex = 2;
        end;

        if u108 then
            u108.ZIndex = 2;

            for _, child in u108:GetChildren() do
                if not (child:IsA("UICorner") or child:IsA("UIStroke")) then
                    child.ZIndex = 2;
                end;
            end;
        end;

        u183 = u102.Parent;

        if u183 == u51 then
            local _ = u102.AbsolutePosition;
            local UDim2_new_ret = UDim2.new(0, u102.AbsolutePosition.X - u48.AbsolutePosition.X, 0, u102.AbsolutePosition.Y - u48.AbsolutePosition.Y);
            u102.Parent = u48;
            u102.Position = UDim2_new_ret;
            u103 = NewGui("Frame", "FakeSlot");
            u103.LayoutOrder = u102.LayoutOrder;
            u103.Size = u102.Size;
            u103.BackgroundTransparency = 1;
            u103.Parent = u51;
            u12 = u103;
        end;
    end;

    local function onDragStop(p188) -- Line: 1467
        -- upvalues: u60 (ref), u102 (ref), u103 (ref), u184 (ref), Position (ref), u183 (ref), UIStroke (copy), u55 (ref), u104 (ref), u105 (ref), u110 (ref), u108 (ref), u101 (copy), u48 (ref), u70 (ref), InventoryServiceEnums (ref), InventorySortingController (ref), u11 (ref), u7 (ref), u182 (ref), u57 (ref), u47 (ref), u56 (ref), u53 (ref), u54 (ref), u65 (ref)
        u60[u102] = nil;

        if u103 then
            u103:Destroy();
            u103 = nil;
        end;

        if u184 then
            u184:Disconnect();
            u184 = nil;
        end;

        local v189 = tick();
        u102.Position = Position;

        if u183 and u102.Parent ~= u183 then
            u102.Parent = u183;
        end;

        UIStroke.Thickness = 0;
        u55:unlock();
        u102.ZIndex = 1;
        u104.ZIndex = 1;
        u105.ZIndex = 1;

        if u183 then
            u183.ZIndex = 1;
        end;

        if u110 then
            u110.ZIndex = 1;
        end;

        if u108 then
            u108.ZIndex = 1;

            for _, child in u108:GetChildren() do
                if not (child:IsA("UICorner") or child:IsA("UIStroke")) then
                    child.ZIndex = 1;
                end;
            end;
        end;

        if not u101.Tool then
            return;
        end;

        local v190 = u48;
        local X = p188.X;
        local Y = p188.Y;
        local AbsolutePosition = v190.AbsolutePosition;
        local AbsoluteSize = v190.AbsoluteSize;
        local v191;

        if AbsolutePosition.X < X and (X <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < Y) then
            v191 = Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v191 = false;
        end;

        if v191 then
            if u101.Index <= u70 then
                local v192 = u101:MoveToInventory();
                local v193 = v192.Tool and (v192.Tool:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (v192.Tool:GetAttribute("PET_UUID") or v192.Tool:GetAttribute("UUID")));

                if v193 then
                    InventorySortingController:MoveEntry(v193, v192.Index);
                end;

                u11.Text = "";

                if u7 then
                    task.delay(0.01, u7, true);
                end;
            end;

            if u70 < u101.Index and v189 - u182 < 0.5 then
                if u57 then
                    local Tool = u101.Tool;
                    local v194 = Tool:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (Tool:GetAttribute("PET_UUID") or Tool:GetAttribute("UUID"));
                    local Index = u57.Index;
                    u101:Clear();
                    u57:Fill(Tool);
                    u101:Delete();

                    if v194 then
                        InventorySortingController:MoveEntry(v194, Index);
                        v189 = 0;
                    else
                        v189 = 0;
                    end;
                else
                    v189 = 0;
                end;
            end;
        else
            local v195 = u47;
            local X2 = p188.X;
            local Y2 = p188.Y;
            local AbsolutePosition2 = v195.AbsolutePosition;
            local AbsoluteSize2 = v195.AbsoluteSize;
            local v196;

            if AbsolutePosition2.X < X2 and (X2 <= AbsolutePosition2.X + AbsoluteSize2.X and AbsolutePosition2.Y < Y2) then
                v196 = Y2 <= AbsolutePosition2.Y + AbsoluteSize2.Y;
            else
                v196 = false;
            end;

            if v196 then
                local v197 = {
                    Magnitude = (1 / 0),
                    Slot = nil
                };

                for _, v in u56 do
                    if u70 >= v.Index then
                        local Frame = v.Frame;
                        local magnitude = (Frame.AbsolutePosition + Frame.AbsoluteSize / 2 - p188).magnitude;

                        if magnitude < v197.Magnitude then
                            v197.Magnitude = magnitude;
                            v197.Slot = v;
                        end;
                    end;
                end;

                local Slot = v197.Slot;

                if not Slot or Slot == u101 then
                    return;
                end;

                local v198 = u101.Tool and (u101.Tool:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (u101.Tool:GetAttribute("PET_UUID") or u101.Tool:GetAttribute("UUID")));
                local v199 = Slot.Tool and (Slot.Tool:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (Slot.Tool:GetAttribute("PET_UUID") or Slot.Tool:GetAttribute("UUID")));
                local Index = Slot.Index;
                local Index2 = u101.Index;
                u101:Swap(Slot);

                if v198 then
                    InventorySortingController:MoveEntry(v198, Index);
                end;

                if v199 then
                    task.wait();
                    InventorySortingController:MoveEntry(v199, Index2);
                end;

                if u70 < u101.Index then
                    local Tool = u101.Tool;

                    if Tool then
                        if Tool then
                            Tool = Tool.Parent == u53;
                        end;

                        if Tool and u54 then
                            u54:UnequipTools();
                        end;

                        if u65 then
                            u101.Frame.Visible = false;
                        end;
                    else
                        u101:Delete();
                    end;
                end;
            elseif u101.Index <= u70 then
                local v200 = u101:MoveToInventory();
                local v201 = v200.Tool and (v200.Tool:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (v200.Tool:GetAttribute("PET_UUID") or v200.Tool:GetAttribute("UUID")));

                if v201 then
                    InventorySortingController:MoveEntry(v201, v200.Index);
                end;

                if u7 then
                    task.delay(0.01, u7, true);
                end;
            elseif u101.Tool and (u101.Tool:IsA("Tool") and u101.Tool.CanBeDropped) then
                u101.Tool.Parent = workspace;
            end;
        end;

        u182 = v189;

        if u7 then
            task.delay(0.01, u7, true);
        end;
    end;

    if u3 then
        local u202 = nil;
        local u203 = nil;
        local u204 = nil;
        local u205 = nil;
        local u206 = nil;

        local function updatePosition(p207) -- Line: 1661
            -- upvalues: u206 (ref), u205 (ref), u102 (ref)
            assert(u206 and u205);
            local v208 = p207 - u205;
            u102.Position = UDim2.new(u206.X.Scale, u206.X.Offset + v208.X, u206.Y.Scale, u206.Y.Offset + v208.Y);
        end;

        u102.InputBegan:Connect(function(u209: userdata) -- Line: 1673
            -- upvalues: u102 (ref), u203 (ref), UserInputService (ref), onDragStart (copy), u202 (ref), u205 (ref), u206 (ref), u204 (ref), onDragStop (copy)
            if not u102:GetAttribute("Draggable") then
                return;
            end;

            if u209.UserInputType == Enum.UserInputType.MouseButton1 or (u209.UserInputType == Enum.UserInputType.Touch or u209.KeyCode == Enum.KeyCode.ButtonA) then
                u203 = true;
                local u212 = UserInputService.InputChanged:Connect(function(p210) -- Line: 1685
                    -- upvalues: u203 (ref), onDragStart (ref), u102 (ref), u202 (ref), u205 (ref), UserInputService (ref), u206 (ref)
                    if u203 then
                        u203 = false;
                        onDragStart(u102.Position);
                        u202 = true;
                        u205 = UserInputService:GetMouseLocation();
                        u206 = u102.Position;
                    end;

                    if u202 and (p210.UserInputType == Enum.UserInputType.MouseMovement or (p210.UserInputType == Enum.UserInputType.Touch or string.find(p210.UserInputType.Name, "Gamepad"))) then
                        local MouseLocation = UserInputService:GetMouseLocation();
                        assert(u206 and u205);
                        local v211 = MouseLocation - u205;
                        u102.Position = UDim2.new(u206.X.Scale, u206.X.Offset + v211.X, u206.Y.Scale, u206.Y.Offset + v211.Y);
                    end;
                end);
                local u213 = nil;
                u213 = u209:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line: 1709
                    -- upvalues: u202 (ref), u203 (ref), u213 (ref), u209 (copy), u212 (copy), u204 (ref), u206 (ref), onDragStop (ref)
                    if u202 or u203 then
                        if u209.UserInputState == Enum.UserInputState.End then
                            u212:Disconnect();
                            local v214 = u202;
                            u203 = nil;
                            u202 = nil;
                            u204 = nil;
                            u206 = nil;

                            if u213 then
                                u213:Disconnect();
                                u213 = nil;
                            end;

                            if v214 then
                                onDragStop(Vector2.new(u209.Position.X, u209.Position.Y));
                            end;
                        end;

                        return;
                    end;

                    if u213 then
                        u213:Disconnect();
                        u213 = nil;
                    end;
                end);
            end;
        end);
    else
        u102.DragBegin:Connect(function(p215) -- Line: 1742
            -- upvalues: onDragStart (copy)
            onDragStart(p215);
        end);
        u102.DragStopped:Connect(function(p216, p217) -- Line: 1746
            -- upvalues: onDragStop (copy)
            onDragStop(Vector2.new(p216, p217));
        end);
    end;

    u102.Parent = p98;
    u56[v100] = u101;

    if u70 < v100 then
        UpdateScrollingFrameCanvasSize();

        if u48.Visible and not u65 then
            u50.CanvasPosition = Vector2.new(0, (math.max(0, u50.CanvasSize.Y.Offset - u50.AbsoluteSize.Y)));
        end;
    end;

    return u101;
end;

u24.Hotbar = {
    RESTORE_TIMEOUT = 30,
    SETTLE_TIME = 2,
    SAVE_INTERVAL = 5,
    Restoring = false,
    LastArrival = 0,
    Token = 0,
    Saved = nil,
    Wanted = {},
    Held = {},
    Foreign = {}
};

function u24.Hotbar.GetToolGuid(p218) -- Line: 1797
    -- upvalues: InventoryServiceEnums (copy)
    if p218 then
        return p218:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (p218:GetAttribute("PET_UUID") or p218:GetAttribute("UUID"));
    end;

    return nil;
end;

function u24.Hotbar.Release() -- Line: 1812
    -- upvalues: u24 (copy)
    local Hotbar = u24.Hotbar;
    table.clear(Hotbar.Held);
    Hotbar.Restoring = false;
end;

function u24.Hotbar.Watch(p219) -- Line: 1819
    -- upvalues: u24 (copy)
    local Hotbar = u24.Hotbar;
    local os_clock_ret = os.clock();

    while Hotbar.Restoring and Hotbar.Token == p219 do
        task.wait(0.5);

        if os.clock() - os_clock_ret >= Hotbar.RESTORE_TIMEOUT or next(Hotbar.Wanted) == nil and os.clock() - Hotbar.LastArrival >= Hotbar.SETTLE_TIME then
            break;
        end;
    end;

    if Hotbar.Token == p219 then
        Hotbar.Release();
    end;
end;

function u24.Hotbar.Restore(p220, p221) -- Line: 1850
    -- upvalues: u24 (copy), u70 (copy), u56 (copy)
    local Hotbar = u24.Hotbar;
    table.clear(Hotbar.Wanted);
    table.clear(Hotbar.Held);
    table.clear(Hotbar.Foreign);
    Hotbar.Restoring = false;

    if type(p220) ~= "table" or next(p220) == nil then
        return false;
    end;

    local v222 = 0;

    for i, v in p220 do
        local v223 = tonumber(i);

        if v223 and (v223 >= 1 and type(v) == "string") then
            if u70 < v223 then
                Hotbar.Foreign[i] = v;
            else
                local v224 = u56[v223];

                if v224 and not v224.Tool then
                    v222 = v222 + 1;
                    local v225 = p221[v];

                    if v225 then
                        v224:Fill(v225);
                        p221[v] = nil;
                    else
                        Hotbar.Wanted[v223] = v;
                    end;
                end;
            end;
        end;
    end;

    if v222 == 0 then
        return false;
    end;

    for i = 1, u70 do
        Hotbar.Held[i] = true;
        local _ = i;
    end;

    Hotbar.Restoring = true;
    Hotbar.LastArrival = os.clock();
    Hotbar.Token = Hotbar.Token + 1;
    task.spawn(Hotbar.Watch, Hotbar.Token);

    return true;
end;

function u24.Hotbar.Resolve(p226) -- Line: 1913
    -- upvalues: u24 (copy), u56 (copy)
    local Hotbar = u24.Hotbar;
    Hotbar.LastArrival = os.clock();
    local ToolGuid = Hotbar.GetToolGuid(p226);

    if ToolGuid then
        for i, v in Hotbar.Wanted do
            if v == ToolGuid then
                Hotbar.Wanted[i] = nil;
                Hotbar.Held[i] = nil;
                local v227 = u56[i];

                if v227 and not v227.Tool then
                    return v227, false;
                end;

                break;
            end;
        end;
    end;

    return nil, true;
end;

function u24.Hotbar.Claim(p228) -- Line: 1942
    -- upvalues: u24 (copy)
    local Hotbar = u24.Hotbar;

    if not Hotbar.Restoring then
        return nil, false;
    end;

    local v229, v230, v231 = pcall(Hotbar.Resolve, p228);

    if v229 then
        return v230, v231;
    end;

    warn("Backpack | hotbar restore failed, using default placement:", v230);
    Hotbar.Release();

    return nil, false;
end;

function u24.Hotbar.Save() -- Line: 1964
    -- upvalues: u24 (copy), u70 (copy), u56 (copy), InventorySortingController (copy)
    local Hotbar = u24.Hotbar;

    if Hotbar.Restoring then
        return;
    end;

    local v232 = {};
    local v233 = {};

    for i = 1, u70 do
        local v234 = u56[i];

        if v234 then
            v234 = Hotbar.GetToolGuid(v234.Tool);
        end;

        local v235;

        if v234 then
            v232[tostring(i)] = v234;
            v233[v234] = true;
            v235 = i;
        else
            v235 = i;
        end;
    end;

    for i, v in Hotbar.Wanted do
        local v236 = u56[i];

        if not (v233[v] or (not v236 or v236.Tool)) then
            v232[tostring(i)] = v;
            v233[v] = true;
        end;
    end;

    for i, v in Hotbar.Foreign do
        if not v233[v] and v232[i] == nil then
            v232[i] = v;
            v233[v] = true;
        end;
    end;

    local v237 = {};

    for i in v232 do
        local v238 = tonumber(i);
        table.insert(v237, v238);
    end;

    table.sort(v237);
    local v239 = {};

    for _, v in v237 do
        local v240 = `{v}={v232[tostring(v)]}`;
        table.insert(v239, v240);
    end;

    local table_concat_ret = table.concat(v239, "|");

    if table_concat_ret == Hotbar.Saved then
        return;
    end;

    Hotbar.Saved = table_concat_ret;
    InventorySortingController:SetHotbar(v232);
end;

task.spawn(function() -- Line: 2029
    -- upvalues: u24 (copy)
    while true do
        task.wait(u24.Hotbar.SAVE_INTERVAL);
        xpcall(u24.Hotbar.Save, warn);
    end;
end);
local u241 = nil;

local function OnChildAdded(p242) -- Line: 2037
    -- upvalues: u53 (ref), u54 (ref), u69 (ref), u50 (ref), u62 (ref), u58 (copy), LocalPlayer (copy), u57 (ref), MakeSlot (copy), u51 (ref), u56 (copy), Backpack (ref), AdjustHotbarFrames (copy), u21 (ref), u24 (copy), u70 (copy), u48 (ref), u241 (ref)
    if not p242:IsA("Tool") then
        if p242:IsA("Humanoid") and p242.Parent == u53 then
            u54 = p242;
        end;

        return;
    end;

    local _ = p242.Parent;

    if p242.Parent == u53 then
        u69 = tick();
    end;

    local v243 = u50;
    local CanvasPosition = u50.CanvasPosition;

    if not (u62 or (p242.Parent ~= u53 or u58[p242])) then
        local StarterGear = LocalPlayer:FindFirstChild("StarterGear");

        if StarterGear and StarterGear:FindFirstChild(p242.Name) then
            u62 = true;

            for i = (u57 or MakeSlot(u51)).Index, 1, -1 do
                local v244 = u56[i];
                local v245 = i - 1;
                local v246;

                if v245 > 0 then
                    u56[v245]:Swap(v244);
                    v246 = i;
                else
                    v244:Fill(p242);
                    v246 = i;
                end;
            end;

            for _, child in pairs(u53:GetChildren()) do
                if child:IsA("Tool") and child ~= p242 then
                    child.Parent = Backpack;
                end;
            end;

            AdjustHotbarFrames();
            v243.CanvasPosition = CanvasPosition;
            u21 = true;

            return;
        end;
    end;

    local v247 = u58[p242];

    if v247 then
        v247:UpdateEquipView();
    else
        local v248, v249 = u24.Hotbar.Claim(p242);
        local v250 = v248 or v249 and MakeSlot(u51) or (u57 or MakeSlot(u51));
        v250:Fill(p242);

        if v250.Index <= u70 and not u48.Visible then
            AdjustHotbarFrames();
            v243.CanvasPosition = CanvasPosition;
        end;
    end;

    if u241 and coroutine.status(u241) == "suspended" then
        task.cancel(u241);
        u241 = nil;
    end;

    u241 = task.delay(0.2, function() -- Line: 2108
        -- upvalues: u21 (ref)
        u21 = true;
    end);
end;

local function OnChildRemoved(u251) -- Line: 2113
    -- upvalues: u69 (ref), u53 (ref), Backpack (ref), u58 (copy), u70 (copy), u48 (ref), AdjustHotbarFrames (copy)
    if not u251:IsA("Tool") then
        return;
    end;

    u69 = tick();
    local Parent = u251.Parent;

    if Parent == u53 or Parent == Backpack then
        return;
    end;

    local u252 = u58[u251];

    if u252 then
        task.defer(function() -- Line: 2129
            -- upvalues: u58 (ref), u251 (copy), u252 (copy), u70 (ref), u48 (ref), AdjustHotbarFrames (ref)
            if u58[u251] == u252 then
                u252:Clear();

                if u70 < u252.Index then
                    u252:Delete();

                    return;
                end;

                if not u48.Visible then
                    AdjustHotbarFrames();
                end;
            end;
        end);
    end;
end;

local function OnCharacterAdded(p253) -- Line: 2142
    -- upvalues: u56 (copy), u70 (copy), u57 (ref), u61 (ref), u67 (copy), u53 (ref), Backpack (ref), LocalPlayer (copy), InventorySortingController (copy), InventoryServiceEnums (copy), u24 (copy), MakeSlot (copy), u51 (ref), OnChildRemoved (copy), OnChildAdded (copy), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy)
    for i = #u56, u70 + 1, -1 do
        local v254;

        if u56[i] then
            u56[i]:Delete();
            v254 = i;
        else
            v254 = i;
        end;
    end;

    for i = 1, u70 do
        local v255;

        if u56[i] and u56[i].Tool then
            u56[i]:Clear();
            v255 = i;
        else
            v255 = i;
        end;
    end;

    local v256;

    for i = 1, u70 do
        v256 = u56[i];

        if not v256.Tool then
            break;
        end;

        local _ = i;
    end;

    v256 = nil;
    u57 = v256;
    u61 = 0;

    for _, v in u67 do
        v:Disconnect();
    end;

    table.clear(u67);
    u53 = p253;
    Backpack = LocalPlayer:WaitForChild("Backpack");
    local success, result = pcall(InventorySortingController.GetHotbarData, InventorySortingController);

    if not success then
        warn("Backpack | could not read the saved hotbar layout:", result);
        result = nil;
    end;

    local success2, result2 = pcall(InventorySortingController.GetSortedData, InventorySortingController);

    if not success2 then
        warn("Backpack | could not read the saved inventory order:", result2);
    end;

    local v257 = (not success2 or type(result2) ~= "table") and {} or result2;
    local v258 = {};

    for _, child in Backpack:GetChildren() do
        if child:IsA("Tool") then
            local v259 = child:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (child:GetAttribute("PET_UUID") or child:GetAttribute("UUID"));

            if v259 then
                v258[v259] = child;
            end;
        end;
    end;

    for _, child in p253:GetChildren() do
        if child:IsA("Tool") then
            local v260 = child:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (child:GetAttribute("PET_UUID") or child:GetAttribute("UUID"));

            if v260 then
                v258[v260] = child;
            end;
        end;
    end;

    local v261 = false;
    local success3, result3 = pcall(u24.Hotbar.Restore, result, v258);

    if success3 then
        v261 = result3;
    else
        warn("Backpack | hotbar restore failed:", result3);
        u24.Hotbar.Release();
    end;

    local v262 = {};

    for i, v in v257 do
        local v263 = {
            Index = tonumber(i) or 9999,
            Guid = v
        };
        table.insert(v262, v263);
    end;

    table.sort(v262, function(p264, p265) -- Line: 2218
        return p264.Index < p265.Index;
    end);

    for _, v in v262 do
        local v266 = v258[v.Guid];

        if v266 then
            local Index = v.Index;

            if v261 or (Index <= 0 or Index > u70) then
                MakeSlot(u51):Fill(v266);
            elseif u56[Index] then
                u56[Index]:Fill(v266);
            end;

            v258[v.Guid] = nil;
        end;
    end;

    for _, v in v258 do
        local v267, v268 = u24.Hotbar.Claim(v);
        local v269;

        if v267 then
            v269 = v;
        else
            v267 = v268 and MakeSlot(u51);

            if v267 then
                v269 = v;
            else
                v269 = v;

                for i = 1, u70 do
                    v267 = u56[i];

                    if not v267.Tool then
                        break;
                    end;

                    local _ = i;
                end;

                v267 = nil or MakeSlot(u51);
            end;
        end;

        if v267 then
            v267:Fill(v269);
        end;
    end;

    local v270;

    for i = 1, u70 do
        v270 = u56[i];

        if not v270.Tool then
            break;
        end;

        local _ = i;
    end;

    v270 = nil;
    u57 = v270;
    table.insert(u67, Backpack.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u67, Backpack.ChildAdded:Connect(OnChildAdded));
    table.insert(u67, p253.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u67, p253.ChildAdded:Connect(OnChildAdded));

    for _, child in p253:GetChildren() do
        if not child:IsA("Tool") then
            OnChildAdded(child);
        end;
    end;

    AdjustHotbarFrames();
    AdjustInventoryFrames();
end;

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
UserInputService:GetMouseLocation();

local function FindFirstNamedAtMouse(p271) -- Line: 2270
    -- upvalues: UserInputService (copy), PlayerGui (copy)
    local MouseLocation = UserInputService:GetMouseLocation();

    for _, v in PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y) do
        if v.Name:find(p271) then
            return v;
        end;
    end;
end;

local function OnInputBegan(p272, p273) -- Line: 2284
    -- upvalues: u64 (ref), u63 (ref), Value2 (copy), u59 (copy), u48 (ref), FindFirstNamedAtMouse (copy), u55 (copy)
    if p273 == false then
        local v274 = (p272.KeyCode == Enum.KeyCode.ButtonL2 or p272.UserInputType == Enum.UserInputType.Keyboard and not (u64 or not u63 and p272.KeyCode.Value ~= Value2)) and u59[p272.KeyCode.Value];

        if v274 then
            v274(p273);
        end;

        local UserInputType = p272.UserInputType;

        if (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch) and (u48.Visible and not FindFirstNamedAtMouse("CategoryFrame")) then
            u55:deselect();
        end;
    end;
end;

local function OnUISChanged(p275) -- Line: 2307
    -- upvalues: UserInputService (copy), u70 (copy), u56 (copy)
    if p275 == "KeyboardEnabled" or p275 == "VREnabled" then
        local v276 = UserInputService.KeyboardEnabled and not UserInputService.VREnabled;

        for i = 1, u70 do
            local v277;

            if u56[i] then
                u56[i]:TurnNumber(v276);
                v277 = i;
            else
                v277 = i;
            end;
        end;
    end;
end;

local u278 = nil;
local u279 = nil;

local function u280() -- Line: 2321
end;

local Vector2_new_ret = Vector2.new(0, 0);

function unbindAllGamepadEquipActions()
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus");
    ContextActionService:UnbindAction("RBXCloseInventory");
end;

local function setHotbarVisibility(p281, p282) -- Line: 2330
    -- upvalues: u70 (copy), u56 (copy)
    for i = 1, u70 do
        local v283 = u56[i];
        local v284;

        if v283 and (v283.Frame and (p282 or v283.Tool)) then
            v283.Frame.Visible = p281;
            v284 = i;
        else
            v284 = i;
        end;
    end;
end;

local function getInputDirection(p285) -- Line: 2339
    -- upvalues: Vector2_new_ret (ref)
    local v286 = p285.UserInputState == Enum.UserInputState.End and -1 or 1;

    if p285.KeyCode == Enum.KeyCode.Thumbstick1 then
        local magnitude = p285.Position.magnitude;

        if magnitude > 0.98 then
            Vector2_new_ret = Vector2.new(p285.Position.x / magnitude, -p285.Position.y / magnitude);
        else
            Vector2_new_ret = Vector2.new(0, 0);
        end;
    elseif p285.KeyCode == Enum.KeyCode.DPadLeft then
        Vector2_new_ret = Vector2.new(Vector2_new_ret.x - v286 * 1, Vector2_new_ret.y);
    elseif p285.KeyCode == Enum.KeyCode.DPadRight then
        Vector2_new_ret = Vector2.new(Vector2_new_ret.x + v286 * 1, Vector2_new_ret.y);
    elseif p285.KeyCode == Enum.KeyCode.DPadUp then
        Vector2_new_ret = Vector2.new(Vector2_new_ret.x, Vector2_new_ret.y - v286 * 1);
    elseif p285.KeyCode == Enum.KeyCode.DPadDown then
        Vector2_new_ret = Vector2.new(Vector2_new_ret.x, Vector2_new_ret.y + v286 * 1);
    else
        Vector2_new_ret = Vector2.new(0, 0);
    end;

    return Vector2_new_ret;
end;

local function _(p287, p288, p289) -- Line: 2370
    -- upvalues: getInputDirection (copy), u70 (copy), u56 (copy), u54 (ref)
    local v290 = getInputDirection(p289);

    if v290 == Vector2.new(0, 0) then
        return;
    end;

    local v291 = math.atan2(v290.y, v290.x) - -1.5707963267948966;

    if v291 < 0 then
        v291 = v291 + 6.283185307179586;
    end;

    local math_floor_ret = math.floor(v291 / 0.7853981633974483 + 1 + 0.5);
    local v292 = u70 < math_floor_ret and 1 or math_floor_ret;

    if v292 > 0 then
        local v293 = u56[v292];

        if v293 and (v293.Tool and not v293:IsEquipped()) then
            v293:Select();
        end;
    elseif u54 then
        u54:UnequipTools();
    end;
end;

function changeToolFunc(p294, p295, u296)
    -- upvalues: u10 (ref), u278 (ref), u279 (ref), u54 (ref), u53 (ref), u58 (copy), u70 (copy), u56 (copy), u72 (ref)
    if u10 then
        return;
    end;

    if p295 ~= Enum.UserInputState.Begin then
        return;
    end;

    if u278 and (u278.KeyCode == Enum.KeyCode.ButtonR1 and u296.KeyCode == Enum.KeyCode.ButtonL1 or u278.KeyCode == Enum.KeyCode.ButtonL1 and u296.KeyCode == Enum.KeyCode.ButtonR1) and tick() - u279 <= 0.06 then
        if u54 then
            u54:UnequipTools();
        end;

        u278 = u296;
        u279 = tick();

        return;
    end;

    u278 = u296;
    u279 = tick();
    delay(0.06, function() -- Line: 2432
        -- upvalues: u278 (ref), u296 (copy), u53 (ref), u54 (ref), u58 (ref), u70 (ref), u56 (ref), u72 (ref)
        if u278 ~= u296 then
            return;
        end;

        local v297 = u296.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1;
        local v298 = nil;

        if u53 and u54 then
            for _, child in ipairs(u53:GetChildren()) do
                if child:IsA("Tool") then
                    v298 = child;
                    break;
                end;
            end;
        end;

        local v299 = -1;

        if v298 then
            local v300 = u58[v298];

            if v300 and v300.Index <= u70 then
                v299 = v300.Index;
            end;
        end;

        if v299 == -1 then
            local v301 = not (u72 and (u72.Tool and u72.Index <= u70)) and -1 or u72.Index;

            if v301 == -1 then
                for i = v297 == -1 and (u70 or 1) or 1, v297 == -1 and 1 or u70, v297 do
                    if u56[i] and u56[i].Tool then
                        u56[i]:Select();

                        return;
                    end;

                    local _ = i;
                end;

                if u54 then
                    u54:UnequipTools();
                end;

                return;
            end;

            local v302 = v297 + v301;

            if u70 < v302 then
                v302 = 1;
            elseif v302 < 1 then
                v302 = u70;
            end;

            local v303 = v302;
            local v304 = false;

            while true do
                if u56[v302] and u56[v302].Tool then
                    v304 = true;
                    break;
                end;

                v302 = v302 + v297;

                if u70 < v302 then
                    v302 = 1;
                elseif v302 < 1 then
                    v302 = u70;
                end;

                if v302 == v303 or v304 then
                    break;
                end;
            end;

            if v304 then
                u56[v302]:Select();

                return;
            end;

            if u54 then
                u54:UnequipTools();
            end;

            return;
        end;

        local v305 = v297 + v299;

        if u70 < v305 then
            v305 = 1;
        elseif v305 < 1 then
            v305 = u70;
        end;

        local v306 = v305;
        local v307 = false;

        while true do
            if u56[v305] and u56[v305].Tool then
                v307 = true;
                break;
            end;

            v305 = v305 + v297;

            if u70 < v305 then
                v305 = 1;
            elseif v305 < 1 then
                v305 = u70;
            end;

            if v305 == v306 or v307 then
                break;
            end;
        end;

        if not v307 then
            if u54 then
                u54:UnequipTools();
            end;

            u72 = nil;

            return;
        end;

        if u56[v305].Tool ~= v298 then
            u56[v305]:Select();

            return;
        end;

        local v308 = 0;

        for i = 1, u70 do
            local v309;

            if u56[i] and u56[i].Tool then
                v308 = v308 + 1;
                v309 = i;
            else
                v309 = i;
            end;
        end;

        if v308 > 1 then
            u56[v305]:Select();

            return;
        end;

        if u54 then
            u54:UnequipTools();
        end;

        u72 = nil;
    end);
end;

function getGamepadSwapSlot()
    -- upvalues: u56 (copy)
    for i = 1, #u56 do
        if u56[i] and (u56[i].Frame:IsA("GuiButton") and (u56[i].Frame:FindFirstChild("UIStroke") and u56[i].Frame.UIStroke.Thickness > 0)) then
            return u56[i];
        end;

        local _ = i;
    end;
end;

function changeSlot(p310)
    -- upvalues: VRService (copy), u48 (ref)
    if VRService.VREnabled then
        local _ = u48.Visible;
    end;

    p310:Select();
end;

function vrMoveSlotToInventory()
    -- upvalues: VRService (copy), u49 (ref)
    if not VRService.VREnabled then
        return;
    end;

    local v311 = getGamepadSwapSlot();

    if v311 and v311.Tool then
        v311:WaitForChild("UIStroke").Thickness = 0;
        v311:MoveToInventory();
        u49.SelectionImageObject.Visible = false;
    end;
end;

function enableGamepadInventoryControl()
    -- upvalues: u48 (ref), u55 (copy), ContextActionService (copy), u280 (copy), UserInputService (copy), GuiService2 (copy), u47 (ref)
    local function v316(p312, p313, p314) -- Line: 2652
        -- upvalues: u48 (ref), u55 (ref)
        if p313 ~= Enum.UserInputState.Begin then
            return;
        end;

        if getGamepadSwapSlot() then
            local v315 = getGamepadSwapSlot();

            if v315 and typeof(v315) == "Instance" then
                v315:WaitForChild("UIStroke").Thickness = 0;
            end;
        elseif u48.Visible then
            u55:deselect();
        end;
    end;

    ContextActionService:BindAction("RBXBackpackHasGamepadFocus", u280, false, Enum.UserInputType.Gamepad1);
    ContextActionService:BindAction("RBXCloseInventory", v316, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart);

    if not UserInputService.VREnabled then
        GuiService2.SelectedObject = u47:FindFirstChild("1");
    end;
end;

function disableGamepadInventoryControl()
    -- upvalues: u70 (copy), u56 (copy), GuiService2 (copy), u46 (ref)
    unbindAllGamepadEquipActions();

    for i = 1, u70 do
        local v317 = u56[i];
        local v318;

        if v317 and v317.Frame then
            v317.Frame:WaitForChild("UIStroke").Thickness = 0;
            v318 = i;
        else
            v318 = i;
        end;
    end;

    if GuiService2.SelectedObject and GuiService2.SelectedObject:IsDescendantOf(u46) then
        GuiService2.SelectedObject = nil;
    end;
end;

local function bindBackpackHotbarAction() -- Line: 2698
    -- upvalues: u63 (ref), u44 (ref), ContextActionService (copy)
    if u63 and not u44 then
        u44 = true;
        ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
end;

local function unbindBackpackHotbarAction() -- Line: 2711
    -- upvalues: u44 (ref), ContextActionService (copy)
    disableGamepadInventoryControl();
    u44 = false;
    ContextActionService:UnbindAction("RBXHotbarEquip");
end;

function gamepadDisconnected()
    -- upvalues: u68 (ref)
    u68 = false;
    disableGamepadInventoryControl();
end;

function gamepadConnected()
    -- upvalues: u68 (ref), GuiService2 (copy), u46 (ref), u61 (ref), u63 (ref), u44 (ref), ContextActionService (copy), u48 (ref)
    u68 = true;
    GuiService2:AddSelectionParent("RBXBackpackSelection", u46);

    if u61 >= 1 and (u63 and not u44) then
        u44 = true;
        ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;

    if u48.Visible then
        enableGamepadInventoryControl();
    end;
end;

local function OnIconChanged(p319) -- Line: 2735
    -- upvalues: StarterGui (copy), u55 (copy), GuiService2 (copy), u63 (ref), u46 (ref), u66 (copy), u61 (ref), u44 (ref), ContextActionService (copy)
    local v320 = 0;
    local v321 = true;
    local v322;

    while true do
        if v320 >= 10 then
            v322 = v321;
            break;
        end;

        local v323;
        v323, v322 = pcall(function() -- Line: 2739
            -- upvalues: StarterGui (ref)
            return StarterGui:GetCore("TopbarEnabled");
        end);

        if v323 then
            break;
        end;

        v320 = v320 + 1;
        task.wait(0.1);
    end;

    local v324 = p319 and v322;
    local v325;

    if v324 then
        v325 = not GuiService2.MenuIsOpen;
    else
        v325 = v324;
    end;

    u55:setEnabled(v325);
    u63 = v324;
    u46.Visible = v324;

    for _, _ in pairs(u66) do

    end;

    if v324 then
        if u61 >= 1 and (u63 and not u44) then
            u44 = true;
            ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
        end;
    else
        disableGamepadInventoryControl();
        u44 = false;
        ContextActionService:UnbindAction("RBXHotbarEquip");
    end;
end;

local function MakeVRRoundButton(p326, p327) -- Line: 2772
    -- upvalues: NewGui (copy)
    local v328 = NewGui("ImageButton", p326);
    v328.Size = UDim2.new(0, 40, 0, 40);
    v328.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";
    local v329 = NewGui("ImageLabel", "Icon");
    v329.Size = UDim2.new(0.5, 0, 0.5, 0);
    v329.Position = UDim2.new(0.25, 0, 0.25, 0);
    v329.Image = p327;
    v329.Parent = v328;
    local v330 = NewGui("ImageLabel", "Selection");
    v330.Size = UDim2.new(0.9, 0, 0.9, 0);
    v330.Position = UDim2.new(0.05, 0, 0.05, 0);
    v330.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
    v328.SelectionImageObject = v330;

    return v328, v329, v330;
end;

u46 = NewGui("Frame", "Backpack");
u46.Visible = false;
u46.Parent = ScreenGui;
u47 = NewGui("Frame", "Hotbar");
u47.Parent = u46;

for i = 1, u70 do
    local v331 = MakeSlot(u47, i);
    v331.Frame.Visible = false;
    local v332;

    if u57 then
        v332 = i;
    else
        u57 = v331;
        v332 = i;
    end;
end;

u55.selected:Connect(function() -- Line: 2807
    -- upvalues: GuiService2 (copy), u24 (copy)
    if not GuiService2.MenuIsOpen then
        u24.OpenClose();
    end;
end);
u55.deselected:Connect(function() -- Line: 2812
    -- upvalues: u48 (ref), u24 (copy)
    if u48.Visible then
        u24.OpenClose();
    end;
end);
LeftBumperButton = NewGui("ImageLabel", "LeftBumper");
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40);
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2);
RightBumperButton = NewGui("ImageLabel", "RightBumper");
RightBumperButton.Size = UDim2.new(0, 40, 0, 40);
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2);
u48 = NewGui("Frame", "Inventory");
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = script:GetAttribute("CornerRadius");
UICorner.Parent = u48;
u48.BackgroundTransparency = u37.BACKGROUND_FADE;
u48.BackgroundColor3 = u37.BACKGROUND_COLOR;
u48.Active = true;
u48.Visible = false;
u48.Parent = u46;
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage2.Item_Module);
local u333 = script.CategoryTemplate:Clone();
u333.Parent = u48;

function u24.UpdateInventorySizeIndicator() -- Line: 2842
    -- upvalues: u4 (copy), u6 (ref), u333 (copy), InventoryService (copy), LocalPlayer (copy), ReplicatedStorage2 (copy)
    local v334 = u4[u6];
    local v335 = v334 and v334.Display or u6;
    u333.Visible = true;

    if u6 ~= "All" then
        if u6 == "Fruit" then
            local v336 = 0;

            for _ in InventoryService:Find("Holdable") or {} do
                v336 = v336 + 1;
            end;

            local v337 = 200 + (LocalPlayer:GetAttribute("BonusBackpackSize") or 0);
            u333.Text = `{v335} Items ({v336}/{math.ceil(v337)})`;

            return;
        end;

        if u6 ~= "Pet" and u6 ~= "PetsOnly" then
            u333.Text = `{v335} Items`;

            return;
        end;

        local Data = require(ReplicatedStorage2.Modules.DataService):GetData();

        if Data then
            Data = Data.PetsData;
        end;

        local v338 = 0;

        for _ in Data and Data.PetInventory and Data.PetInventory.Data or {} do
            v338 = v338 + 1;
        end;

        u333.Text = `{v335} Items ({v338}/{Data and (Data.MutableStats and Data.MutableStats.MaxPetsInInventory) or 0})`;

        return;
    end;

    local v339 = 0;

    for _ in InventoryService:Find("Holdable") or {} do
        v339 = v339 + 1;
    end;

    local v340 = 200 + (LocalPlayer:GetAttribute("BonusBackpackSize") or 0);
    local math_ceil_ret = math.ceil(v340);
    local Data = require(ReplicatedStorage2.Modules.DataService):GetData();

    if Data then
        Data = Data.PetsData;
    end;

    for _ in Data and Data.PetInventory and Data.PetInventory.Data or {} do
        v339 = v339 + 1;
    end;

    u333.Text = `{v335} Items ({v339}/{math_ceil_ret + (Data and (Data.MutableStats and Data.MutableStats.MaxPetsInInventory) or 0)})`;
end;

local function u343(p341) -- Line: 2914
    -- upvalues: u6 (ref), u24 (copy), u1 (copy), u20 (ref)
    if u6 == p341 then
        u24.UpdateInventorySizeIndicator();

        return;
    end;

    local v342 = u6;
    u6 = p341;
    u24.UpdateInventorySizeIndicator();
    u1:Fire(p341, v342);
    u20 = true;
end;

LocalPlayer:GetAttributeChangedSignal("BonusBackpackSize"):Connect(u24.UpdateInventorySizeIndicator);
require(ReplicatedStorage2.Modules.DataService):GetPathSignal("InventoryData"):Connect(function() -- Line: 2931
    -- upvalues: u24 (copy)
    u24.UpdateInventorySizeIndicator();
end);
require(ReplicatedStorage2.Modules.DataService):GetPathSignal("PetsData/PetInventory/Data"):Connect(function() -- Line: 2935
    -- upvalues: u24 (copy)
    u24.UpdateInventorySizeIndicator();
end);
require(ReplicatedStorage2.Modules.DataService):GetPathSignal("PetsData/MutableStats/MaxPetsInInventory"):Connect(function() -- Line: 2939
    -- upvalues: u24 (copy)
    u24.UpdateInventorySizeIndicator();
end);
u24.UpdateInventorySizeIndicator();
u24.UpdateCategory = u343;

function u24.GetCategory() -- Line: 2947
    -- upvalues: u6 (ref)
    return u6;
end;

function u24.SetTrading(p344) -- Line: 2951
    -- upvalues: u10 (ref), u2 (copy), u6 (ref), u24 (copy), u20 (ref)
    u10 = p344;
    u2:Fire(p344);

    if p344 or u6 ~= "PetsOnly" then
        if p344 and u6 == "Pet" then
            u24.UpdateCategory("PetsOnly");
        elseif p344 and (u6 ~= "PetsOnly" and u6 ~= "Fruit") then
            u24.UpdateCategory("Fruit");
        end;
    else
        u24.UpdateCategory("Pet");
    end;

    u20 = true;
end;

local v345 = script.CategoryFrame:Clone();
v345.Size = v45 and UDim2.fromScale(0.08, 1) or v345.Size;
v345.Parent = u48;
local CategoryTemplate = v345.CategoryTemplate;

local function UpdateVisibility(p346, p347) -- Line: 2985
    -- upvalues: u10 (ref), u24 (copy), u48 (ref), script_InspectionHover (copy), u56 (copy)
    local v348;

    if u10 then
        v348 = p347.Name == "PetsOnly" and true or p347.Name == "Fruit";
    else
        v348 = not p347.Hidden;
    end;

    p346.Visible = v348;
    local Active = u24.Inspection.Active;

    if Active then
        if u48 == nil then
            Active = false;
        else
            Active = u48.Visible == true;
        end;
    end;

    script_InspectionHover.SetActive(Active, u56, u48 and u48.Visible == true);
end;

local function BrightenColorHSV(p349, p350: number) -- Line: 2979
    local v351, v352, v353 = p349:ToHSV();
    local math_clamp_ret = math.clamp(v353 + p350, 0, 1);

    return Color3.fromHSV(v351, v352, math_clamp_ret);
end;

for _, v in CategoryList do
    local Name = v.Name;
    local u354 = CategoryTemplate:Clone();
    local ImageButton = u354.ImageButton;
    local BackgroundColor3 = u354.BackgroundColor3;
    local u355 = TweenService:Create(u354, TweenInfo.new(0.2), {
        BackgroundColor3 = BrightenColorHSV(BackgroundColor3, 0.2)
    });
    local u356 = TweenService:Create(u354, TweenInfo.new(0.2), {
        BackgroundColor3 = BackgroundColor3
    });
    ImageButton.MouseEnter:Connect(function() -- Line: 3006
        -- upvalues: u355 (copy)
        u355:Play();
    end);
    ImageButton.MouseLeave:Connect(function() -- Line: 3009
        -- upvalues: u356 (copy)
        u356:Play();
    end);
    ImageButton.MouseButton1Down:Connect(function() -- Line: 3013
        -- upvalues: u356 (copy)
        u356:Play();
    end);
    ImageButton.MouseButton1Up:Connect(function() -- Line: 3017
        -- upvalues: u355 (copy), u343 (ref), Name (copy)
        u355:Play();
        u343(Name);
    end);
    ImageButton.Image = v.Image;
    UpdateVisibility(u354, v);
    u354.Parent = v345;
    u2:Connect(function() -- Line: 3026
        -- upvalues: u354 (copy), v (copy), u10 (ref), u24 (copy), u48 (ref), script_InspectionHover (copy), u56 (copy)
        local v357 = v;
        local v358;

        if u10 then
            v358 = v357.Name == "PetsOnly" and true or v357.Name == "Fruit";
        else
            v358 = not v357.Hidden;
        end;

        u354.Visible = v358;
        local Active = u24.Inspection.Active;

        if Active then
            if u48 == nil then
                Active = false;
            else
                Active = u48.Visible == true;
            end;
        end;

        script_InspectionHover.SetActive(Active, u56, u48 and u48.Visible == true);
    end);
end;

u49 = NewGui("TextButton", "VRInventorySelector");
u49.Position = UDim2.new(0, 0, 0, 0);
u49.Size = UDim2.new(1, 0, 1, 0);
u49.BackgroundTransparency = 1;
u49.Text = "";
u49.Parent = u48;
local v359 = NewGui("ImageLabel", "Selector");
v359.Size = UDim2.new(1, 0, 1, 0);
v359.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
v359.ScaleType = Enum.ScaleType.Slice;
v359.SliceCenter = Rect.new(12, 12, 52, 52);
v359.Visible = false;
u49.SelectionImageObject = v359;
u49.MouseButton1Click:Connect(function() -- Line: 3047
    vrMoveSlotToInventory();
end);
u50 = NewGui("ScrollingFrame", "ScrollingFrame");
u50.Selectable = false;
u50.CanvasSize = UDim2.new(0, 0, 0, 0);
u50.Parent = u48;
u51 = NewGui("Frame", "UIGridFrame");
u51.Selectable = false;
u51.Size = UDim2.new(1, -(u37.ICON_BUFFER * 2), 1, 0);
u51.Position = UDim2.new(0, u37.ICON_BUFFER, 0, 0);
u51.Parent = u50;
u52 = Instance.new("UIGridLayout");
u52.SortOrder = Enum.SortOrder.LayoutOrder;
u52.CellSize = UDim2.new(0, u37.ICON_SIZE, 0, u37.ICON_SIZE);
u52.CellPadding = UDim2.new(0, u37.ICON_BUFFER, 0, u37.ICON_BUFFER);
u52.Parent = u51;
local u360 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u360.Size = UDim2.new(0, 34, 0, 34);
u360.Position = UDim2.new(0.5, -u360.Size.X.Offset / 2, 0, 43);
u360.Icon.Position = u360.Icon.Position - UDim2.new(0, 0, 0, 2);
u360.MouseButton1Click:Connect(function() -- Line: 3073
    -- upvalues: u50 (ref), u37 (copy)
    local Vector2_new = Vector2.new;
    local X = u50.CanvasPosition.X;
    local v361 = u50.CanvasSize.Y.Offset - u50.AbsoluteWindowSize.Y;
    local math_max_ret = math.max(0, u50.CanvasPosition.Y - (u37.ICON_BUFFER + u37.ICON_SIZE));
    u50.CanvasPosition = Vector2_new(X, (math.min(v361, math_max_ret)));
end);
local u362 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u362.Rotation = 180;
u362.Icon.Position = u362.Icon.Position - UDim2.new(0, 0, 0, 2);
u362.Size = UDim2.new(0, 34, 0, 34);
u362.Position = UDim2.new(0.5, -u362.Size.X.Offset / 2, 1, -u362.Size.Y.Offset - 3);
u362.MouseButton1Click:Connect(function() -- Line: 3090
    -- upvalues: u50 (ref), u37 (copy)
    local Vector2_new = Vector2.new;
    local X = u50.CanvasPosition.X;
    local v363 = u50.CanvasSize.Y.Offset - u50.AbsoluteWindowSize.Y;
    local math_max_ret = math.max(0, u50.CanvasPosition.Y + (u37.ICON_BUFFER + u37.ICON_SIZE));
    u50.CanvasPosition = Vector2_new(X, (math.min(v363, math_max_ret)));
end);
u50.Changed:Connect(function(p364) -- Line: 3101
    -- upvalues: u50 (ref), u360 (ref), u362 (ref)
    if p364 == "AbsoluteWindowSize" or (p364 == "CanvasPosition" or p364 == "CanvasSize") then
        local v365 = u50.CanvasPosition.Y < u50.CanvasSize.Y.Offset - u50.AbsoluteWindowSize.Y;
        u360.Visible = u50.CanvasPosition.Y ~= 0;
        u362.Visible = v365;
    end;
end);
UpdateBackpackLayout();
local u366 = script_Utility:Create("Frame")({
    Name = "GamepadHintsFrame",
    BackgroundTransparency = 1,
    Visible = false,
    Size = UDim2.new(0, u47.Size.X.Offset, 0, u43 and 95 or 60),
    Parent = u46
});

local function addGamepadHint(u367, p368) -- Line: 3122
    -- upvalues: script_Utility (copy), u366 (copy), UserInputService (copy), u43 (copy), u24 (copy)
    local v369 = script_Utility:Create("Frame")({
        Name = "HintFrame",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -5),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = u366
    });
    local u370 = script_Utility:Create("ImageLabel")({
        Name = "HintImage",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Image = UserInputService:GetImageForKeyCode(u367),
        Parent = v369
    });
    local v371 = script_Utility:Create("TextLabel")({
        Name = "HintText",
        BackgroundTransparency = 1,
        TextWrapped = true,
        Position = UDim2.new(0, u43 and 100 or 70, 0, 0),
        Size = UDim2.new(1, -(u43 and 100 or 70), 1, 0),
        Font = Enum.Font.SourceSansBold,
        FontSize = u43 and Enum.FontSize.Size36 or Enum.FontSize.Size24,
        Text = p368,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = v369
    });
    Instance.new("UITextSizeConstraint", v371).MaxTextSize = v371.TextSize;
    u24.StateChanged.Event:Connect(function() -- Line: 3157
        -- upvalues: u370 (copy), UserInputService (ref), u367 (copy)
        u370.Image = UserInputService:GetImageForKeyCode(u367);
    end);
end;

local function resizeGamepadHintsFrame() -- Line: 3162
    -- upvalues: u366 (copy), u47 (ref), u43 (copy), u48 (ref)
    u366.Size = UDim2.new(u47.Size.X.Scale, u47.Size.X.Offset, 0, u43 and 95 or 60);
    u366.Position = UDim2.new(u47.Position.X.Scale, u47.Position.X.Offset, u48.Position.Y.Scale, u48.Position.Y.Offset - u366.Size.Y.Offset);
    local Children = u366:GetChildren();
    local v372 = 0;

    for i = 1, #Children do
        Children[i].Size = UDim2.new(1, 0, 1, -5);
        Children[i].Position = UDim2.new(0, 0, 0, 0);
        v372 = v372 + (Children[i].HintText.Position.X.Offset + Children[i].HintText.TextBounds.X);
        local _ = i;
    end;

    local v373 = (u366.AbsoluteSize.X - v372) / (#Children - 1);

    for i = 1, #Children do
        Children[i].Position = i == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, Children[i - 1].Position.X.Offset + Children[i - 1].Size.X.Offset + v373, 0, 0);
        Children[i].Size = UDim2.new(0, Children[i].HintText.Position.X.Offset + Children[i].HintText.TextBounds.X, 1, -5);
        local _ = i;
    end;
end;

addGamepadHint(Enum.KeyCode.ButtonX, "Remove From Hotbar");
addGamepadHint(Enum.KeyCode.ButtonA, "Select/Swap");
addGamepadHint(Enum.KeyCode.ButtonB, "Close Backpack");
local v374 = NewGui("Frame", "Search");
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = script:GetAttribute("CornerRadius");
UICorner2.Parent = v374;
v374.BackgroundColor3 = Attribute8;
v374.BackgroundTransparency = Attribute9;
v374.Size = UDim2.new(0, 190, 0, 30);
v374.Position = UDim2.new(1, -v374.Size.X.Offset - 5, 0, 5);
v374.Parent = u48;
local u375 = NewGui("TextBox", "TextBox");
u375.PlaceholderText = "search";
u375.ClearTextOnFocus = false;
u375.FontSize = Enum.FontSize.Size24;
u375.TextXAlignment = Enum.TextXAlignment.Left;
local UIPadding = Instance.new("UIPadding");
UIPadding.Parent = u375;
UIPadding.PaddingLeft = UDim.new(0, 8);
u375.Size = v374.Size - UDim2.fromOffset(0, 0);
u375.Position = UDim2.new(0, 0, 0, 0);
u375.Parent = v374;
local u376 = script.StrokeTemplate:Clone();
u376.Enabled = false;
u376.Parent = v374;
task.spawn(function() -- Line: 3229
    -- upvalues: u376 (copy), TweenService (copy)
    while true do
        repeat
            task.wait();
        until u376.Enabled;

        local v377 = TweenService:Create(u376.UIGradient, TweenInfo.new(0.05), {
            Rotation = u376.UIGradient.Rotation + 1
        });
        v377:Play();
        v377.Completed:Wait();
    end;
end);
u11 = u375;
local u378 = NewGui("TextButton", "X");
local UICorner3 = Instance.new("UICorner");
UICorner3.CornerRadius = script:GetAttribute("CornerRadius");
UICorner3.Parent = u378;
u378.Text = "X";
u378.ZIndex = 10;
u378.TextColor3 = Color3.new(1, 1, 1);
u378.FontSize = Enum.FontSize.Size24;
u378.TextYAlignment = Enum.TextYAlignment.Bottom;
u378.BackgroundTransparency = 1;
u378.Size = UDim2.new(0, v374.Size.Y.Offset - 10, 0, v374.Size.Y.Offset - 10);
u378.Position = UDim2.new(1, -u378.Size.X.Offset - 10, 0.5, -u378.Size.Y.Offset / 2);
u378.Visible = false;
u378.BorderSizePixel = 0;
u378.Parent = v374;

local function UpdateSlots() -- Line: 3267
    -- upvalues: u56 (copy), TradingController (copy), u70 (copy), AdjustHotbarFrames (copy)
    for i, v in u56 do
        if v.Tool then
            if TradingController:IsItemInTradeFromTool(v.Tool) then
                if u70 < i then
                    v.Frame.Visible = false;
                elseif not v.Hidden then
                    v.Hidden = true;
                    v:UpdateVisual();
                end;
            elseif i <= u70 and v.Hidden then
                v.Hidden = false;
                v:UpdateVisual();
            end;
        end;
    end;

    AdjustHotbarFrames();
end;

local function search(p379) -- Line: 3289
    -- upvalues: u375 (copy), u70 (copy), u56 (copy), u65 (ref), IsOfCategory (copy), u8 (ref), u24 (copy), UpdateSlots (copy), UpdateScrollingFrameCanvasSize (copy), u378 (copy), SyncInspectionHover (copy)
    local Text = u375.Text;
    local v380 = {};

    for i in Text:gmatch("%S+") do
        v380[i:lower()] = true;
    end;

    local v381 = {};

    for i = u70 + 1, #u56 do
        local v382 = u56[i];
        local v383 = { v382, (v382:CheckTerms(v380, true)) };
        table.insert(v381, v383);
        local _ = i;
    end;

    table.sort(v381, function(p384, p385) -- Line: 3307
        return p384[2] > p385[2];
    end);
    u65 = true;

    for _, v in v381 do
        local v386 = v[1];
        local v387 = v[2];
        local Favorite = v386.Favorite;
        local v388 = IsOfCategory(v386.Tool);

        if (v387 > 0 or Text == "") and (v388 and (u8 ~= "Favorited" or Favorite) and not (u8 == "NonFavorited" and Favorite or (u24.BeeEvent.FilterActive and not u24.BeeEvent.IsTool(v386.Tool) or u24.HalloweenEvent.FilterActive and not u24.HalloweenEvent.IsTool(v386.Tool)))) then
            v386.Frame.Visible = true;
        else
            v386.Frame.Visible = false;
        end;
    end;

    UpdateSlots();
    UpdateScrollingFrameCanvasSize();
    u378.ZIndex = 3;

    if u24.Inspection.Active then
        task.defer(SyncInspectionHover);
    end;
end;

u7 = function(...) -- Line: 3345
    -- upvalues: search (copy)
    debug.profilebegin("UpdateFunction");
    search(...);
    debug.profileend();
end;

u24.UpdateFunction = u7;

local function clearResults() -- Line: 3352
    -- upvalues: u65 (ref), u70 (copy), u56 (copy), u6 (ref), IsOfCategory (copy), UpdateSlots (copy), u378 (copy), UpdateScrollingFrameCanvasSize (copy), u24 (copy), SyncInspectionHover (copy)
    u65 = false;

    for i = u70 + 1, #u56 do
        local v389 = u56[i];
        local v390;

        if v389 and v389.Tool then
            if u6 == "All" then
                v389.Frame.LayoutOrder = v389.Index;
                v389.Frame.Visible = true;
                v390 = i;
            elseif u6 == "All" then
                v390 = i;
            elseif IsOfCategory(v389.Tool) then
                v389.Frame.Visible = true;
                v390 = i;
            else
                v389.Frame.Visible = false;
                v390 = i;
            end;
        else
            v390 = i;
        end;
    end;

    UpdateSlots();
    u378.ZIndex = 0;
    UpdateScrollingFrameCanvasSize();

    if u24.Inspection.Active then
        task.defer(SyncInspectionHover);
    end;
end;

local u391 = clearResults;

local function onChanged(p392) -- Line: 3391
    -- upvalues: u10 (ref), u343 (ref), u375 (copy), search (copy), u378 (copy), u376 (copy)
    if p392 == "Text" then
        if not u10 then
            u343("All");
        end;

        local Text = u375.Text;
        search();
        local v393;

        if Text == "" then
            v393 = false;
        else
            v393 = Text ~= "";
        end;

        u378.Visible = v393;
        local v394;

        if Text == "" then
            v394 = false;
        else
            v394 = Text ~= "";
        end;

        u376.Enabled = v394;
    end;
end;

u378.MouseButton1Click:Connect(function() -- Line: 3386, Name: reset
    -- upvalues: clearResults (copy), u375 (copy)
    clearResults();
    u375.Text = "";
end);
u375.Changed:Connect(onChanged);
u375.FocusLost:Connect(function(p395) -- Line: 3403, Name: focusLost
    -- upvalues: search (copy)
    if p395 then
        search();
    end;
end);
local FavoriteOnly = script:WaitForChild("FavoriteOnly");
u375.Size = v374.Size - UDim2.fromOffset(0, 0);
u375.Position = UDim2.new(0, 0, 0, 0);
FavoriteOnly.Position = u375.Parent.Position - UDim2.fromOffset(u375.Size.Y.Offset * 1.25, 0);
FavoriteOnly.Size = UDim2.fromOffset(u375.Size.Y.Offset, u375.Size.Y.Offset);
FavoriteOnly.Parent = u375.Parent.Parent;
u24.Inspection.Button = FavoriteOnly:Clone();
u24.Inspection.Button.Name = "InspectionOnly";
u24.Inspection.Button.Position = FavoriteOnly.Position - UDim2.fromOffset(FavoriteOnly.Size.Y.Offset + 5, 0);
u24.Inspection.Button.Size = FavoriteOnly.Size;

function u24.Inspection.UpdateIcon() -- Line: 3427
    -- upvalues: u24 (copy)
    if not u24.Inspection.Button then
        return;
    end;

    local v396;

    if u24.Inspection.Active then
        v396 = u24.Inspection.IconEnabled;
    else
        v396 = u24.Inspection.IconDisabled;
    end;

    if v396 and v396 ~= "" then
        u24.Inspection.Button.ImageButton.Image = v396;
    end;
end;

u24.Inspection.UpdateIcon();
u24.Inspection.Button.Parent = FavoriteOnly.Parent;
u24.Inspection.Stroke = Instance.new("UIStroke");
u24.Inspection.Stroke.Name = "InspectionStroke";
u24.Inspection.Stroke.Enabled = false;
u24.Inspection.Stroke.Color = Color3.fromRGB(255, 255, 255);
u24.Inspection.Stroke.Thickness = 0.01;
u24.Inspection.Stroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
u24.Inspection.Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
u24.Inspection.Stroke.Parent = u48;
u24.Inspection.Gradient = Instance.new("UIGradient");
u24.Inspection.Gradient.Rotation = -180;
u24.Inspection.Gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.499, 0),
    NumberSequenceKeypoint.new(0.5, 1),
    NumberSequenceKeypoint.new(1, 1)
});
u24.Inspection.Gradient.Parent = u24.Inspection.Stroke;
task.spawn(function() -- Line: 3463
    -- upvalues: u24 (copy), TweenService (copy)
    while true do
        while u24.Inspection.Stroke.Enabled do
            u24.Inspection.Gradient.Rotation = -180;
            local v397 = TweenService:Create(u24.Inspection.Gradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                Rotation = 180
            });
            v397:Play();
            v397.Completed:Wait();
        end;

        u24.Inspection.Gradient.Rotation = -180;
        task.wait();
    end;
end);
u24.Inspection.Button.ImageButton.Activated:Connect(function() -- Line: 3480
    -- upvalues: u24 (copy), u48 (ref), script_InspectionHover (copy), u56 (copy)
    u24.Inspection.Active = not u24.Inspection.Active;
    u24.Inspection.Stroke.Enabled = u24.Inspection.Active;
    u24.Inspection.UpdateIcon();
    local Active = u24.Inspection.Active;

    if Active then
        if u48 == nil then
            Active = false;
        else
            Active = u48.Visible == true;
        end;
    end;

    script_InspectionHover.SetActive(Active, u56, u48 and u48.Visible == true);
end);
FavoriteOnly.ImageButton.Activated:Connect(function() -- Line: 3488
    -- upvalues: u8 (ref), u5 (copy), FavoriteOnly (copy), u9 (copy), u20 (ref)
    local v398 = u8;
    local table_find_ret = table.find(u5, v398);
    local v399 = `Invalid Filter "{v398}" passed to GetNextFilter`;
    assert(table_find_ret, v399);
    u8 = u5[table_find_ret % #u5 + 1];
    FavoriteOnly.ImageButton.Image = u9[u8];
    u20 = true;
end);
u24.BeeEvent.ButtonWidth = FavoriteOnly.Size.Y.Offset * 3;
u24.BeeEvent.Button = NewGui("TextButton", "BeeOnly");
u24.BeeEvent.Button.Size = UDim2.fromOffset(u24.BeeEvent.ButtonWidth, FavoriteOnly.Size.Y.Offset);
u24.BeeEvent.Button.Position = u24.Inspection.Button.Position - UDim2.fromOffset(u24.BeeEvent.ButtonWidth + 5, 0);
u24.BeeEvent.Button.Text = "Show Bee";
u24.BeeEvent.Button.TextScaled = true;
u24.BeeEvent.Button.BackgroundColor3 = Color3.fromRGB(94, 94, 94);
u24.BeeEvent.Button.BackgroundTransparency = 0.5;
u24.BeeEvent.Button.Parent = FavoriteOnly.Parent;
u24.BeeEvent.Stroke = Instance.new("UIStroke");
u24.BeeEvent.Stroke.Color = Color3.fromRGB(255, 149, 0);
u24.BeeEvent.Stroke.Thickness = 0;
u24.BeeEvent.Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
u24.BeeEvent.Stroke.Parent = u24.BeeEvent.Button;
u24.BeeEvent.Corner = Instance.new("UICorner");
u24.BeeEvent.Corner.CornerRadius = script:GetAttribute("CornerRadius");
u24.BeeEvent.Corner.Parent = u24.BeeEvent.Button;
u24.BeeEvent.Button.Activated:Connect(function() -- Line: 3515
    -- upvalues: u24 (copy), u20 (ref)
    if not u24.BeeEvent.IsInBeeGarden() then
        u24.BeeEvent.UpdateButton();

        return;
    end;

    u24.BeeEvent.FilterActive = not u24.BeeEvent.FilterActive;
    u24.BeeEvent.Stroke.Thickness = u24.BeeEvent.FilterActive and 2 or 0;
    u24.BeeEvent.Button.TextColor3 = u24.BeeEvent.FilterActive and Color3.fromRGB(255, 220, 140) or Color3.fromRGB(255, 255, 255);
    u24.BeeEvent.Button.Text = u24.BeeEvent.FilterActive and "Show Bee" or "Hide Bee";
    u20 = true;
end);
u24.HalloweenEvent.Button = u24.BeeEvent.Button:Clone();
u24.HalloweenEvent.Button.Name = "HalloweenOnly";
u24.HalloweenEvent.Button.Parent = FavoriteOnly.Parent;
u24.HalloweenEvent.Stroke = u24.HalloweenEvent.Button:FindFirstChildOfClass("UIStroke");
u24.HalloweenEvent.Stroke.Color = u24.HalloweenEvent.Color;
u24.HalloweenEvent.SetFilter(false);
u24.HalloweenEvent.Button.Activated:Connect(function() -- Line: 3535
    -- upvalues: u24 (copy), u20 (ref)
    if not u24.HalloweenEvent.IsInGhoulGarden() then
        u24.BeeEvent.UpdateButton();

        return;
    end;

    u24.HalloweenEvent.SetFilter(not u24.HalloweenEvent.FilterActive);
    u20 = true;
end);
u24.BeeEvent.UpdateButton();
task.spawn(function() -- Line: 3555
    -- upvalues: ReplicatedStorage2 (copy), u24 (copy), u20 (ref)
    while not require(ReplicatedStorage2.Modules.SaveSlotControllers.SaveSlotController):GetSaveSlotChangeSignal() do
        task.wait(0.5);
    end;

    require(ReplicatedStorage2.Modules.SaveSlotControllers.SaveSlotController):GetSaveSlotChangeSignal():Connect(function() -- Line: 3559
        -- upvalues: u24 (ref), u20 (ref)
        u24.BeeEvent.UpdateButton();
        u20 = true;
    end);
    u24.BeeEvent.UpdateButton();
end);
u24.StateChanged.Event:Connect(function(p400) -- Line: 3565
    -- upvalues: u48 (ref), u55 (copy)
    if not (p400 or u48.Visible) then
        u55:deselect();
    end;
end);

u59[Enum.KeyCode.Escape.Value] = function(p401) -- Line: 3573
    -- upvalues: u48 (ref), u55 (copy)
    if p401 then
        return;
    end;

    if u48.Visible then
        u55:deselect();
    end;
end;

u59[Enum.KeyCode.ButtonL2.Value] = function(p402) -- Line: 3580
    -- upvalues: u39 (ref), ToggleFavoriteTool (copy)
    if not u39 then
        return;
    end;

    ToggleFavoriteTool(u39);
end;

GuiService2.MenuOpened:Connect(function() -- Line: 3589
    -- upvalues: u48 (ref), u55 (copy)
    if u48.Visible then
        u55:deselect();
    end;
end);

local function u406(p403, p404, p405) -- Line: 3596
    -- upvalues: GuiService2 (copy), u70 (copy), u56 (copy), u391 (ref)
    if p404 ~= Enum.UserInputState.Begin then
        return;
    end;

    if not GuiService2.SelectedObject then
        return;
    end;

    for i = 1, u70 do
        if u56[i].Frame == GuiService2.SelectedObject and u56[i].Tool then
            u56[i]:MoveToInventory();
            u391();

            return;
        end;

        local _ = i;
    end;

    u391();
end;

local function openClose() -- Line: 3615
    -- upvalues: u60 (copy), u48 (ref), u24 (copy), script_InspectionHover (copy), u56 (copy), AdjustHotbarFrames (copy), u47 (ref), u70 (copy), u68 (ref), u42 (copy), UserInputService (copy), resizeGamepadHintsFrame (copy), u366 (copy), ContextActionService (copy), u406 (copy), u10 (ref)
    if not next(u60) then
        u48.Visible = not u48.Visible;
        local Active = u24.Inspection.Active;

        if Active then
            if u48 == nil then
                Active = false;
            else
                Active = u48.Visible == true;
            end;
        end;

        script_InspectionHover.SetActive(Active, u56, u48 and u48.Visible == true);
        local Visible = u48.Visible;
        AdjustHotbarFrames();
        u47.Active = not u47.Active;

        for i = 1, u70 do
            local v407;

            if u56[i] then
                u56[i]:SetClickability(not Visible);
                v407 = i;
            else
                v407 = i;
            end;
        end;
    end;

    if u48.Visible then
        if u68 then
            if u42[UserInputService:GetLastInputType()] then
                resizeGamepadHintsFrame();
                u366.Visible = not UserInputService.VREnabled;
            end;

            enableGamepadInventoryControl();
        end;
    else
        if u68 then
            u366.Visible = false;
        end;

        disableGamepadInventoryControl();
    end;

    if u48.Visible then
        ContextActionService:BindAction("RBXRemoveSlot", u406, false, Enum.KeyCode.ButtonX);
    else
        ContextActionService:UnbindAction("RBXRemoveSlot");
    end;

    u24.IsOpen = u48.Visible;
    u24.StateChanged:Fire(u48.Visible);

    if not u24.IsOpen and u10 then
        u24.SetTrading(false);
    end;
end;

setHotbarVisibility(false);
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
u24.OpenClose = openClose;
LocalPlayer.CharacterAdded:Connect(OnCharacterAdded);

if LocalPlayer.Character then
    OnCharacterAdded(LocalPlayer.Character);
end;

UserInputService.InputBegan:Connect(OnInputBegan);
UserInputService.TextBoxFocused:Connect(function() -- Line: 3674
    -- upvalues: u64 (ref)
    u64 = true;
end);
UserInputService.TextBoxFocusReleased:Connect(function() -- Line: 3677
    -- upvalues: u64 (ref)
    u64 = false;
end);

u59[Value2] = function() -- Line: 3681
    -- upvalues: u54 (ref)
    if u54 then
        u54:UnequipTools();
    end;
end;

UserInputService.Changed:Connect(OnUISChanged);
OnUISChanged("KeyboardEnabled");

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected();
end;

UserInputService.GamepadConnected:Connect(function(p408) -- Line: 3691
    if p408 == Enum.UserInputType.Gamepad1 then
        gamepadConnected();
    end;
end);
UserInputService.GamepadDisconnected:Connect(function(p409) -- Line: 3696
    if p409 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected();
    end;
end);

function u24.SetBackpackEnabled(p410, p411) -- Line: 3703
    -- upvalues: u40 (ref)
    u40 = p411;
end;

function u24.IsOpened(p412) -- Line: 3707
    -- upvalues: u24 (copy)
    return u24.IsOpen;
end;

function u24.GetBackpackEnabled(p413) -- Line: 3711
    -- upvalues: u40 (ref)
    return u40;
end;

function u24.GetStateChangedEvent(p414) -- Line: 3715
    -- upvalues: Backpack (ref)
    return Backpack.StateChanged;
end;

RunService2.Heartbeat:Connect(function() -- Line: 3719
    -- upvalues: OnIconChanged (copy), u40 (ref), TradingController (copy), u10 (ref)
    OnIconChanged(u40 and (TradingController.CurrentTradeReplicator == nil and true or u10));
end);
Api.Event:Connect(function(p415: string, p416: any) -- Line: 3722
    -- upvalues: u24 (copy)
    if p415 == "SetBackpackEnabled" then
        u24:SetBackpackEnabled(p416);

        return;
    end;

    if p415 == "SetInventoryOpen" then
        if type(p416) == "boolean" and p416 == true then
            u24.IsOpen = true;

            return;
        end;

        if type(p416) == "boolean" then
            u24.IsOpen = false;
        end;
    elseif p415 == "ToggleBackpack" then
        u24.OpenClose();
    end;
end);
ReplicatedStorage2.GameEvents.ABTestingEvents:WaitForChild("HideInventoryItem").Event:Connect(function(p417) -- Line: 3739
    -- upvalues: u56 (copy), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy)
    for _, v in u56 do
        local Tool = v.Tool;

        if Tool and string.find(Tool.Name, p417) then
            v:Clear();
            AdjustHotbarFrames();
            AdjustInventoryFrames();
        end;
    end;
end);

return u24;