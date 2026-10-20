-- Decompiled with Potassium's decompiler.

local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(140, 140, 140);
local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local CosmeticUI = PlayerGui:WaitForChild("CosmeticUI");
local CosmeticInventory = CosmeticUI:WaitForChild("CosmeticInventory");
local BackpackGui = PlayerGui:WaitForChild("BackpackGui");
local ActivePetUI = PlayerGui:WaitForChild("ActivePetUI");
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local AdjustBrightnessHSV = require(ReplicatedStorage.Modules.AdjustBrightnessHSV);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local CosmeticService = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticService);
local GetUIElementWithTag = require(ReplicatedStorage.Modules.GetUIElementWithTag);
local Notification = require(ReplicatedStorage.Modules.Notification);
local Icon = require(ReplicatedStorage.Modules.Icon);
require(ReplicatedStorage.Modules.UpdateService);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);
local PlayHoverSound = require(ReplicatedStorage.Modules.PlayHoverSound);
local ModernInputNotificationUserInterfaceService = require(ReplicatedStorage.Modules.ModernInputNotificationUserInterfaceService);
local CosmeticCategoryList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticCategoryList);
require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local Signal = require(ReplicatedStorage.Modules.PlatformService.Signal);
WaitForDescendant(CosmeticInventory, "SQUARE_INSERTION_POINT");
local u1 = WaitForDescendant(CosmeticInventory, "ACTUAL_FRAME");
local v2 = WaitForDescendant(CosmeticInventory, "MENU_BUTTON");
local u3 = WaitForDescendant(CosmeticInventory, "UISizeConstraint");
local u4 = WaitForDescendant(CosmeticInventory, "ARROW_IMAGE");
local u5 = WaitForDescendant(CosmeticInventory, "SQUARE_INSERTION_POINT");
local COSMETIC_TEMPLATE = u5:WaitForChild("COSMETIC_TEMPLATE");
local u6 = WaitForDescendant(CosmeticInventory, "SEARCH_TEXT_BOX");
local v7 = WaitForDescendant(CosmeticInventory, "CLOSE_BUTTON");
local u8 = WaitForDescendant(CosmeticInventory, "ACTUAL_TEXTURE");
WaitForDescendant(CosmeticInventory, "TITLE_TEXT");
local u9 = WaitForDescendant(CosmeticInventory, "COSMETIC_WIDGET");
local u10 = WaitForDescendant(u9, "INVENTORY_COUNT");
local u11 = WaitForDescendant(u9, "PLACED_COUNT");
local u12 = WaitForDescendant(u9, "SEPERATION_BAR");
local u13 = WaitForDescendant(CosmeticInventory, "DELETE_BUTTON");
local v14 = WaitForDescendant(CosmeticInventory, "CATEGORY_BUTTON");
local v15 = WaitForDescendant(CosmeticInventory, "PICKUPALL_BUTTON");
WaitForDescendant(CosmeticInventory, "CATEGORY_DROPDOWN");
local u16 = WaitForDescendant(CosmeticInventory, "CATEGORY_DROPDOWN");
local u17 = WaitForDescendant(CosmeticInventory, "TITLE_TEXT");
local u18 = {};

for _, v in CosmeticCategoryList do
    u18[v.CategoryName] = v;
end;

local function ToggleCosmeticWidget(p19: boolean) -- Line: 79
    -- upvalues: TweenService (copy), u12 (copy), u9 (copy), u10 (copy), u11 (copy)
    TweenService:Create(u12, TweenInfo.new(0.2), {
        BackgroundTransparency = p19 and 0 or 1
    }):Play();
    TweenService:Create(u9.ACTUAL_TEXTURE_OTHER, TweenInfo.new(0.2), {
        ImageTransparency = p19 and 0.4 or 1
    }):Play();
    TweenService:Create(u10, TweenInfo.new(0.2), {
        TextTransparency = p19 and 0 or 1
    }):Play();
    TweenService:Create(u11, TweenInfo.new(0.2), {
        TextTransparency = p19 and 0 or 1
    }):Play();
end;

local function UpdateStats() -- Line: 98
    -- upvalues: CountDictionary (copy), CosmeticService (copy), u10 (copy), u11 (copy)
    local v20 = CountDictionary(CosmeticService:GetAllEquippedCosmetics()) or 0;
    local v21 = {};

    for _, v in CosmeticService:GetAllCosmetics() do
        if typeof(v) == "table" and v.Name then
            v21[v.Name] = true;
        end;
    end;

    for i in CosmeticService:GetPooledCounts() do
        v21[i] = true;
    end;

    local v22 = 0;

    for _ in v21 do
        v22 = v22 + 1;
    end;

    local MutableStat = CosmeticService:GetMutableStat("MaxEquippedCosmetics");
    u10.Text = `Total Items: {v22}/{CosmeticService:GetMutableStat("MaxCosmeticsInInventory")}`;
    u11.Text = `Placed Items: {v20}/{MutableStat}`;
end;

local u23 = Icon.new();
u23:setImage("rbxassetid://130953946651026", "deselected");
u23:setImage("rbxassetid://119182315828169", "selected");
u23:setName("CosmeticInventoryIcon");
u23:setImageScale(1.12);
u23:setOrder(-3);
u23:setCaption("Toggle the cosmetic inventory.");
u23.deselectWhenOtherIconSelected = false;
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 142
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local u24 = {
    BigScale = false,
    State = false,
    CurrentInventoryState = 4,
    DeletionMode = false,
    CategoryState = false,
    SelectedCategory = "ALL",
    CurrentQuery = "",
    FrameRenderData = {
        CosmeticCounterFrames = {},
        UniqueCosmeticFrames = {}
    },
    OnToggled = Signal.new()
};
local StateForGui = GuiController:GetStateForGui(CosmeticUI);
StateForGui.ChangeEnabled:Set(true);

function u24.Toggle(p25: table, p26: boolean) -- Line: 176
    -- upvalues: StateForGui (copy), GuiController (copy), CosmeticUI (copy)
    if p26 then
        if not StateForGui.Visible:Get() then
            GuiController:Open(CosmeticUI);
        end;
    elseif StateForGui.Visible:Get() then
        GuiController:Close(CosmeticUI);
    end;
end;

function u24.ChangeScaleMode(p27: table, p28: boolean) -- Line: 188
    -- upvalues: u24 (copy), u1 (copy), TweenService (copy), u4 (copy), u3 (copy), u8 (copy)
    u24.BigScale = p28;
    local Size = u1.Size;
    local v29 = u1.Size + UDim2.fromScale(0, 1);
    local v30 = TweenService:Create(u1, TweenInfo.new(0.2), {
        Size = Size
    });
    local v31 = TweenService:Create(u1, TweenInfo.new(0.2), {
        Size = v29
    });
    local v32 = TweenService:Create(u4, TweenInfo.new(0.2), {
        Position = u4.Position
    });
    local v33 = TweenService:Create(u4, TweenInfo.new(0.2), {
        Position = UDim2.fromScale(0.5, 0.5)
    });
    local v34 = TweenService:Create(u4, TweenInfo.new(0.2), {
        Rotation = 0
    });
    local v35 = TweenService:Create(u4, TweenInfo.new(0.2), {
        Rotation = 180
    });

    if p28 then
        v31 = v30 or v31;
    end;

    v31:Play();

    if p28 then
        v32 = v33 or v32;
    end;

    v32:Play();

    if p28 then
        v34 = v35 or v34;
    end;

    v34:Play();
    TweenService:Create(u3, TweenInfo.new(0.2), {
        MaxSize = p28 and Vector2.new(579.67, 115.25) or Vector2.new(579.67, 340)
    }):Play();
    u8.Image = p28 and "rbxassetid://122189350536032" or "rbxassetid://127843077446462";
end;

local CosmeticUnlockEffect = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticUnlockEffect);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 54, 37);

local function PushSpacerToEnd(p36: userdata) -- Line: 241
    -- upvalues: COSMETIC_TEMPLATE (copy)
    if not p36:IsA("GuiObject") or p36.Name == COSMETIC_TEMPLATE.Name then
        return;
    end;

    p36.LayoutOrder = 1073741824;
end;

local v37 = u5:FindFirstChildWhichIsA("UIGridLayout");

if v37 then
    v37.SortOrder = Enum.SortOrder.LayoutOrder;

    for _, child in u5:GetChildren() do
        if child:IsA("GuiObject") then
            if child.Name ~= COSMETIC_TEMPLATE.Name then
                child.LayoutOrder = 1073741824;
            end;
        end;
    end;

    u5.ChildAdded:Connect(PushSpacerToEnd);
end;

local u38 = {};
local u39 = {};
local u40 = false;
local u41 = 0;
local u42 = false;
local BindableEvent = Instance.new("BindableEvent");
local u43 = {};

local function ApplyTileOrder(p44: userdata) -- Line: 264
    p44.LayoutOrder = (p44:GetAttribute("SearchOrder") or 0) + (p44:GetAttribute("IsNew") and -100000 or 0);
end;

local function GetUnseenMap() -- Line: 269
    -- upvalues: CosmeticService (copy), u38 (copy)
    local v45 = {};
    local v46 = {};
    local v47 = 0;
    local AllCosmetics = CosmeticService:GetAllCosmetics();
    local AllEquippedCosmetics = CosmeticService:GetAllEquippedCosmetics();

    if not (AllCosmetics and AllEquippedCosmetics) then
        return v45, v46, v47;
    end;

    for i, v in AllCosmetics do
        if v.New and not (u38[i] or (AllEquippedCosmetics[i] or not v.Name)) then
            if v.Data and next(v.Data) then
                v46[i] = true;
            else
                v45[v.Name] = v45[v.Name] or {};
                table.insert(v45[v.Name], i);
            end;

            v47 = v47 + 1;
        end;
    end;

    return v45, v46, v47;
end;

local function GetOrCreateNewBadge(p48: userdata) -- Line: 298
    -- upvalues: Color3_fromRGB_ret3 (copy)
    local NEW_BADGE = p48:FindFirstChild("NEW_BADGE");

    if NEW_BADGE then
        return NEW_BADGE;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "NEW_BADGE";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.86, 0.16);
    Frame.Size = UDim2.fromScale(0.3, 0.3);
    Frame.ZIndex = 10;
    Frame.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 1;
    UIAspectRatioConstraint.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Label";
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.85, 0.85);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.ZIndex = 11;
    TextLabel.Text = "!";
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    TextLabel.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    UIStroke.Thickness = 1.5;
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Parent = TextLabel;
    Frame.Parent = p48;

    return Frame;
end;

local function SetTileNew(p49: userdata, p50: boolean) -- Line: 346
    -- upvalues: GetOrCreateNewBadge (copy)
    if p49:GetAttribute("IsNew") == p50 and (not p50 or p49:FindFirstChild("NEW_BADGE")) then
        return;
    end;

    p49:SetAttribute("IsNew", p50);

    if p50 then
        GetOrCreateNewBadge(p49).Visible = true;
    else
        local NEW_BADGE = p49:FindFirstChild("NEW_BADGE");

        if NEW_BADGE then
            NEW_BADGE.Visible = false;
        end;
    end;

    p49.LayoutOrder = (p49:GetAttribute("SearchOrder") or 0) + (p49:GetAttribute("IsNew") and -100000 or 0);
end;

local function PulseIcon() -- Line: 365
    -- upvalues: TradeWorldController (copy), u23 (copy), TweenService (copy)
    if TradeWorldController:IsInWorld() then
        return;
    end;

    local Instance2 = u23:getInstance("IconImage");

    if not Instance2 then
        return;
    end;

    local UnseenPulseScale = Instance2:FindFirstChild("UnseenPulseScale");

    if not UnseenPulseScale then
        if Instance2:FindFirstChildWhichIsA("UIScale") then
            return;
        end;

        UnseenPulseScale = Instance.new("UIScale");
        UnseenPulseScale.Name = "UnseenPulseScale";
        UnseenPulseScale.Parent = Instance2;
    end;

    local v51 = TweenService:Create(UnseenPulseScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = 1.3
    });
    v51:Play();
    v51.Completed:Once(function() -- Line: 381
        -- upvalues: TweenService (ref), UnseenPulseScale (ref)
        TweenService:Create(UnseenPulseScale, TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
end;

local function StartPulseLoop() -- Line: 386
    -- upvalues: u42 (ref), u41 (ref), StateForGui (copy), PulseIcon (copy)
    if u42 or u41 <= 0 then
        return;
    end;

    u42 = true;
    task.spawn(function() -- Line: 390
        -- upvalues: u41 (ref), StateForGui (ref), PulseIcon (ref), u42 (ref)
        while u41 > 0 do
            if not StateForGui.Visible:Get() then
                PulseIcon();
            end;

            task.wait(3);
        end;

        u42 = false;
    end);
end;

local function SyncIconNotices(p52: number) -- Line: 402
    -- upvalues: TradeWorldController (copy), u23 (copy), BindableEvent (copy)
    if TradeWorldController:IsInWorld() then
        return;
    end;

    local math_min_ret = math.min(p52, 100);

    if u23.totalNotices == math_min_ret then
        return;
    end;

    BindableEvent:Fire();

    for i = 1, math_min_ret do
        u23:notify(BindableEvent.Event);
        local _ = i;
    end;
end;

local function UpdateUnseenVisuals() -- Line: 414
    -- upvalues: GetUnseenMap (copy), u41 (ref), u24 (copy), SetTileNew (copy), SyncIconNotices (copy), u42 (ref), StateForGui (copy), PulseIcon (copy)
    local v53, v54, v55 = GetUnseenMap();
    u41 = v55;

    for i, v in u24.FrameRenderData.CosmeticCounterFrames do
        SetTileNew(v, v53[i] ~= nil);
    end;

    for i, v in u24.FrameRenderData.UniqueCosmeticFrames do
        SetTileNew(v, v54[i] == true);
    end;

    SyncIconNotices(v55);

    if not u42 then
        if u41 <= 0 then
            return;
        end;

        u42 = true;
        task.spawn(function() -- Line: 390
            -- upvalues: u41 (ref), StateForGui (ref), PulseIcon (ref), u42 (ref)
            while u41 > 0 do
                if not StateForGui.Visible:Get() then
                    PulseIcon();
                end;

                task.wait(3);
            end;

            u42 = false;
        end);
    end;
end;

local function FlushSeen() -- Line: 430
    -- upvalues: u40 (ref), u39 (copy), ReplicatedStorage (copy)
    u40 = false;
    local v56 = {};

    for i in u39 do
        table.insert(v56, i);

        if #v56 >= 500 then
            ReplicatedStorage.GameEvents.CosmeticNotice:FireServer(v56);
            v56 = {};
        end;
    end;

    table.clear(u39);

    if #v56 > 0 then
        ReplicatedStorage.GameEvents.CosmeticNotice:FireServer(v56);
    end;
end;

local function MarkSeen(p57: table) -- Line: 448
    -- upvalues: u38 (copy), u39 (copy), u40 (ref), FlushSeen (copy), UpdateUnseenVisuals (copy)
    local v58 = false;

    for _, v in p57 do
        if not u38[v] then
            u38[v] = true;
            u39[v] = true;
            v58 = true;
        end;
    end;

    if not v58 then
        return;
    end;

    if not u40 then
        u40 = true;
        task.delay(0.5, FlushSeen);
    end;

    UpdateUnseenVisuals();
end;

local function MarkFrameSeen(p59: userdata) -- Line: 468
    -- upvalues: GetUnseenMap (copy), MarkSeen (copy)
    if not p59:GetAttribute("IsNew") then
        return;
    end;

    local v60, v61 = GetUnseenMap();
    local Attribute = p59:GetAttribute("CounterCosmeticName");

    if Attribute and v60[Attribute] then
        MarkSeen(v60[Attribute]);

        return;
    end;

    local Attribute2 = p59:GetAttribute("UniqueCosmeticUUID");

    if Attribute2 and v61[Attribute2] then
        MarkSeen({ Attribute2 });
    end;
end;

local function MarkAllUnseenSeen() -- Line: 485
    -- upvalues: GetUnseenMap (copy), MarkSeen (copy)
    local v62, v63 = GetUnseenMap();
    local v64 = {};

    for _, v in v62 do
        for _, v3 in v do
            table.insert(v64, v3);
        end;
    end;

    for i in v63 do
        table.insert(v64, i);
    end;

    MarkSeen(v64);
end;

local function PlayNewUnlockEffects() -- Line: 502
    -- upvalues: CosmeticService (copy), u43 (copy), CosmeticList (copy), StateForGui (copy), TradeWorldController (copy), CosmeticUnlockEffect (copy), u23 (copy), PulseIcon (copy)
    local AllCosmetics = CosmeticService:GetAllCosmetics();

    if not AllCosmetics then
        return;
    end;

    local v65 = {};

    for i, v in AllCosmetics do
        if not u43[i] then
            u43[i] = true;

            if v.New then
                local v66 = v.Name and CosmeticList[v.Name];

                if v66 and v66.Icon then
                    table.insert(v65, v66.Icon);
                end;
            end;
        end;
    end;

    if #v65 == 0 then
        return;
    end;

    if StateForGui.Visible:Get() or TradeWorldController:IsInWorld() then
        return;
    end;

    CosmeticUnlockEffect:Play(v65, u23.widget, PulseIcon);
end;

local AllCosmetics = CosmeticService:GetAllCosmetics();

if AllCosmetics then
    for i in AllCosmetics do
        u43[i] = true;
    end;
end;

function u24.Search(p67: table, p68: string) -- Line: 534
    -- upvalues: u24 (copy), CosmeticService (copy), CosmeticList (copy)
    local v69 = p68:lower();
    u24.CurrentQuery = v69;
    local CosmeticCounterFrames = u24.FrameRenderData.CosmeticCounterFrames;
    local UniqueCosmeticFrames = u24.FrameRenderData.UniqueCosmeticFrames;
    local AllCosmetics2 = CosmeticService:GetAllCosmetics();
    local SelectedCategory = u24.SelectedCategory;
    local string_split_ret = string.split(v69, " ");

    for i, v in CosmeticCounterFrames do
        v.Visible = true;
        local v70 = CosmeticList[i];
        local v71 = SelectedCategory ~= "ALL" and not table.find(v70.Tags, SelectedCategory) and true or false;
        local v72 = i:lower();
        local v73 = v;
        local v74 = 0;

        for _, v3 in string_split_ret do
            if v72:find(v3) then
                v74 = v74 + 1;
            end;
        end;

        if v72:find(v69) then
            v74 = v74 + 1;
        end;

        if v69 ~= "" and (v70 and v70.Events) then
            for _, v3 in v70.Events do
                local v75 = v3:lower();

                for _, v4 in string_split_ret do
                    if v75:find(v4) then
                        v74 = v74 + 1;
                    end;
                end;
            end;
        end;

        if v74 <= 0 and v69 ~= "" or v71 then
            v73.Visible = false;
        else
            v73.LayoutOrder = -v74;
            v73.Visible = true;
        end;
    end;

    for i, v in UniqueCosmeticFrames do
        v.Visible = true;
        local Name = AllCosmetics2[i].Name;

        if Name then
            local v76 = CosmeticList[Name];
            local v77 = SelectedCategory ~= "ALL" and not table.find(v76.Tags, SelectedCategory) and true or false;
            local v78 = Name:lower();
            local v79 = v;
            local v80 = 0;

            for _, v3 in string_split_ret do
                if v78:find(v3) then
                    v80 = v80 + 1;
                end;
            end;

            if v78:find(v69) then
                v80 = v80 + 1;
            end;

            if v69 ~= "" and (v76 and v76.Events) then
                for _, v3 in v76.Events do
                    local v81 = v3:lower();

                    for _, v4 in string_split_ret do
                        if v81:find(v4) then
                            v80 = v80 + 1;
                        end;
                    end;
                end;
            end;

            if v80 <= 0 and v69 ~= "" or v77 then
                v79.Visible = false;
            else
                v79.LayoutOrder = -v80;
                v79.Visible = true;
            end;
        end;
    end;
end;

local Color3_fromRGB_ret4 = Color3.fromRGB(255, 94, 73);
local u82 = AdjustBrightnessHSV(Color3_fromRGB_ret4, -0.35);
local Color3_fromRGB_ret5 = Color3.fromRGB(255, 255, 255);
local u83 = AdjustBrightnessHSV(Color3_fromRGB_ret5, -0.35);
local UIStroke = u13:WaitForChild("UIStroke");
local u84 = WaitForDescendant(u13, "DELETE_ICON");
local SENSOR = u13:WaitForChild("SENSOR");

local function ToggleDeleteSensorHover(p85) -- Line: 648
    -- upvalues: u83 (copy), u82 (copy), TweenService (copy), UIStroke (copy), u84 (copy), u13 (copy)
    local v86 = p85 and u83 or u82;
    TweenService:Create(UIStroke, TweenInfo.new(0.1), {
        Color = v86
    }):Play();
    TweenService:Create(u84, TweenInfo.new(0.1), {
        ImageColor3 = v86
    }):Play();
    TweenService:Create(u13, TweenInfo.new(0.1), {
        BackgroundColor3 = v86
    }):Play();
end;

local function ToggleActualColor(p87) -- Line: 664
    -- upvalues: Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), TweenService (copy), UIStroke (copy), u84 (copy), u13 (copy)
    local v88 = p87 and Color3_fromRGB_ret4 or Color3_fromRGB_ret5;
    TweenService:Create(UIStroke, TweenInfo.new(0.1), {
        Color = v88
    }):Play();
    TweenService:Create(u84, TweenInfo.new(0.1), {
        ImageColor3 = v88
    }):Play();
    TweenService:Create(u13, TweenInfo.new(0.1), {
        BackgroundColor3 = v88
    }):Play();
end;

local u89 = {};

function u24.ToggleDeletionMode(p90, p91) -- Line: 685
    -- upvalues: u24 (copy), ToggleActualColor (copy), u17 (copy), TweenService (copy), u89 (copy)
    u24.DeletionMode = p91;
    ToggleActualColor(u24.DeletionMode);
    u17.Text = p91 and "DELETION MODE ACTIVE" or "All Cosmetics";
    TweenService:Create(u17, TweenInfo.new(0.2), {
        TextColor3 = u24.DeletionMode and Color3.fromRGB(255, 94, 73) or Color3.fromRGB(255, 255, 255)
    }):Play();
    table.clear(u89);
end;

SENSOR.MouseEnter:Connect(function() -- Line: 700
    -- upvalues: PlayHoverSound (copy), ToggleDeleteSensorHover (copy), u24 (copy)
    PlayHoverSound();
    ToggleDeleteSensorHover(u24.DeletionMode);
end);
SENSOR.MouseLeave:Connect(function() -- Line: 705
    -- upvalues: ToggleActualColor (copy), u24 (copy)
    ToggleActualColor(u24.DeletionMode);
end);
SENSOR.MouseButton1Down:Connect(function() -- Line: 709
    -- upvalues: ToggleActualColor (copy), u24 (copy)
    ToggleActualColor(u24.DeletionMode);
end);
SENSOR.MouseButton1Click:Connect(function() -- Line: 713
    -- upvalues: u24 (copy)
    u24:ToggleDeletionMode(not u24.DeletionMode);
end);

local function ToggleDeleteUI(p92: userdata, p93: boolean) -- Line: 718
    -- upvalues: TweenService (copy)
    local DeletionStuff = p92:WaitForChild("DeletionStuff");
    local DELETE_ICON = DeletionStuff:WaitForChild("DELETE_ICON");
    TweenService:Create(DeletionStuff:WaitForChild("UIStroke"), TweenInfo.new(0.2), {
        Transparency = p93 and 0 or 1
    }):Play();
    TweenService:Create(DELETE_ICON, TweenInfo.new(0.2), {
        ImageTransparency = p93 and 0 or 1
    }):Play();
    TweenService:Create(DeletionStuff, TweenInfo.new(0.2), {
        BackgroundTransparency = p93 and 0.6 or 1
    }):Play();
end;

local Color3_fromRGB_ret6 = Color3.fromRGB(255, 255, 255);
local u94 = WaitForDescendant(v15, "PICKUPALL_ICON");
local u95 = AdjustBrightnessHSV(Color3_fromRGB_ret6, -0.35);
local SENSOR2 = v15:WaitForChild("SENSOR");

local function UpdateColor(p96) -- Line: 744
    -- upvalues: Color3_fromRGB_ret6 (copy), u95 (copy), TweenService (copy), u94 (copy)
    TweenService:Create(u94, TweenInfo.new(0.1), {
        ImageColor3 = p96 and Color3_fromRGB_ret6 or u95
    }):Play();
end;

local function GetCosmeticsCount() -- Line: 751
    -- upvalues: CosmeticService (copy)
    local AllEquippedCosmetics = CosmeticService:GetAllEquippedCosmetics();

    if not AllEquippedCosmetics then
        return 0;
    end;

    local v97 = 0;

    for _ in AllEquippedCosmetics do
        v97 = v97 + 1;
    end;

    return v97;
end;

local Random_new_ret = Random.new();
local CosmeticPickupEffect = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticPickupEffect);
local u98 = false;

local function PickupAllStaggered() -- Line: 774
    -- upvalues: u98 (ref), CosmeticService (copy), CosmeticPickupEffect (copy), PlaySound (copy), Random_new_ret (copy)
    if u98 then
        return;
    end;

    local AllEquippedCosmetics = CosmeticService:GetAllEquippedCosmetics();

    if not AllEquippedCosmetics then
        return;
    end;

    local u99 = {};

    for i in AllEquippedCosmetics do
        table.insert(u99, i);
    end;

    u98 = true;
    task.spawn(function() -- Line: 791
        -- upvalues: u99 (copy), CosmeticService (ref), CosmeticPickupEffect (ref), PlaySound (ref), Random_new_ret (ref), u98 (ref)
        for _, v in u99 do
            if CosmeticService:IsCosmeticEquipped(v) then
                CosmeticPickupEffect:Play(v);
                CosmeticService:Unequip(v);
                PlaySound("rbxassetid://139578759536123", Random_new_ret:NextNumber(0.8, 1.2)).Volume = 0.5;
                task.wait(0.1);
            end;
        end;

        u98 = false;
    end);
end;

SENSOR2.MouseEnter:Connect(function() -- Line: 807
    -- upvalues: PlayHoverSound (copy), UpdateColor (copy)
    PlayHoverSound();
    UpdateColor(true);
end);
SENSOR2.MouseLeave:Connect(function() -- Line: 813
    -- upvalues: u95 (copy), TweenService (copy), u94 (copy)
    TweenService:Create(u94, TweenInfo.new(0.1), {
        ImageColor3 = u95
    }):Play();
end);
SENSOR2.MouseButton1Down:Connect(function() -- Line: 817
    -- upvalues: Color3_fromRGB_ret6 (copy), u95 (copy), TweenService (copy), u94 (copy)
    TweenService:Create(u94, TweenInfo.new(0.1), {
        ImageColor3 = Color3_fromRGB_ret6 or u95
    }):Play();
end);
SENSOR2.MouseButton1Up:Connect(function() -- Line: 820
    -- upvalues: u95 (copy), TweenService (copy), u94 (copy)
    TweenService:Create(u94, TweenInfo.new(0.1), {
        ImageColor3 = u95
    }):Play();
end);
SENSOR2.MouseButton1Click:Connect(function() -- Line: 824
    -- upvalues: u98 (ref), CosmeticService (copy), Notification (copy), ConfirmationPromptController (copy), PickupAllStaggered (copy)
    if u98 then
        return;
    end;

    local AllEquippedCosmetics = CosmeticService:GetAllEquippedCosmetics();
    local v100;

    if AllEquippedCosmetics then
        v100 = 0;

        for _ in AllEquippedCosmetics do
            v100 = v100 + 1;
        end;
    else
        v100 = 0;
    end;

    if v100 <= 0 then
        Notification:CreateNotification("You have no cosmetics to pickup!");

        return;
    end;

    ConfirmationPromptController:Open({
        Title = "Pick Up All Cosmetics",
        Middle = "This action is irreversible.",
        Footer = "",
        Header = `Are you sure you want to pick up all {v100} cosmetics?`
    }, {
        ConfirmCallback = function() -- Line: 844, Name: ConfirmCallback
            -- upvalues: PickupAllStaggered (ref)
            PickupAllStaggered();
        end
    });
end);
local Color3_fromRGB_ret7 = Color3.fromRGB(255, 255, 255);
local u101 = AdjustBrightnessHSV(Color3_fromRGB_ret7, -0.35);
v14:WaitForChild("UIStroke");
local u102 = WaitForDescendant(v14, "CATEGORY_ICON");
local SENSOR3 = v14:WaitForChild("SENSOR");
local UIAspectRatioConstraint = v14:WaitForChild("UIAspectRatioConstraint");
u16:WaitForChild("UIStroke");
local INSERTION_POINT = u16:WaitForChild("INSERTION_POINT");
local TEMPLATE = INSERTION_POINT:WaitForChild("TEMPLATE");
local u103 = {};

function u24.SetCategory(p104: table, p105: string) -- Line: 866
    -- upvalues: u18 (copy), u102 (copy), u24 (copy), u17 (copy)
    u102.Image = u18[p105].Icon;
    u24.SelectedCategory = p105;
    u17.Text = `{`{p105:sub(1, 1):upper()}{p105:sub(2, #p105):lower()}`} Cosmetics`;
end;

local u106 = false;

function u24.ToggleCategoryDropdown(p107: table, p108: boolean) -- Line: 880
    -- upvalues: u106 (ref), u24 (copy), TweenService (copy), u102 (copy), CosmeticCategoryList (copy), u103 (copy), TEMPLATE (copy), Color3_fromRGB_ret7 (copy), u101 (copy), PlayHoverSound (copy), INSERTION_POINT (copy), u16 (copy), UIAspectRatioConstraint (copy)
    if u106 then
        return;
    end;

    u106 = true;
    u24.CategoryState = p108;
    u24:Search(u24.CurrentQuery);
    TweenService:Create(u102, TweenInfo.new(0.2), {
        ImageTransparency = p108 and 1 or 0
    }):Play();

    for i, v in CosmeticCategoryList do
        local CategoryName = v.CategoryName;
        local v109 = u103[CategoryName];

        if not v109 then
            v109 = TEMPLATE:Clone();
            u103[CategoryName] = v109;
            local CATEGORY_ICON_TEMPLATE = v109.CATEGORY_ICON_TEMPLATE;
            v109.Visible = true;
            CATEGORY_ICON_TEMPLATE.ImageTransparency = 1;
            local SENSOR4 = v109:WaitForChild("SENSOR");

            local function u111(p110) -- Line: 914
                -- upvalues: Color3_fromRGB_ret7 (ref), u101 (ref), TweenService (ref), CATEGORY_ICON_TEMPLATE (copy)
                TweenService:Create(CATEGORY_ICON_TEMPLATE, TweenInfo.new(0.1), {
                    ImageColor3 = p110 and Color3_fromRGB_ret7 or u101
                }):Play();
            end;

            CATEGORY_ICON_TEMPLATE.ImageColor3 = u101;
            SENSOR4.MouseEnter:Connect(function() -- Line: 923
                -- upvalues: PlayHoverSound (ref), u111 (copy)
                PlayHoverSound();
                u111(true);
            end);
            SENSOR4.MouseLeave:Connect(function() -- Line: 929
                -- upvalues: u101 (ref), TweenService (ref), CATEGORY_ICON_TEMPLATE (copy)
                TweenService:Create(CATEGORY_ICON_TEMPLATE, TweenInfo.new(0.1), {
                    ImageColor3 = u101
                }):Play();
            end);
            SENSOR4.MouseButton1Down:Connect(function() -- Line: 933
                -- upvalues: Color3_fromRGB_ret7 (ref), u101 (ref), TweenService (ref), CATEGORY_ICON_TEMPLATE (copy)
                TweenService:Create(CATEGORY_ICON_TEMPLATE, TweenInfo.new(0.1), {
                    ImageColor3 = Color3_fromRGB_ret7 or u101
                }):Play();
            end);
            SENSOR4.MouseButton1Up:Connect(function() -- Line: 936
                -- upvalues: u101 (ref), TweenService (ref), CATEGORY_ICON_TEMPLATE (copy)
                TweenService:Create(CATEGORY_ICON_TEMPLATE, TweenInfo.new(0.1), {
                    ImageColor3 = u101
                }):Play();
            end);
            SENSOR4.MouseButton1Click:Connect(function() -- Line: 940
                -- upvalues: u24 (ref), CategoryName (copy)
                u24:SetCategory(CategoryName);
                u24:ToggleCategoryDropdown(false);
            end);
            CATEGORY_ICON_TEMPLATE.Image = v.Icon;
            v109.Parent = INSERTION_POINT;
        end;

        v109.LayoutOrder = i;
    end;

    local v112 = u103[u24.SelectedCategory];

    if v112 then
        v112.LayoutOrder = -1000;
        v112.CATEGORY_ICON_TEMPLATE.ImageTransparency = p108 and 0 or 1;
    end;

    if p108 then
        u16.Visible = true;
        local v113 = TweenService:Create(UIAspectRatioConstraint, TweenInfo.new(0.3), {
            AspectRatio = p108 and #CosmeticCategoryList or 1
        });
        v113:Play();
        v113.Completed:Wait();

        for _, v in CosmeticCategoryList do
            local v114 = u103[v.CategoryName];

            if v ~= v114 then
                local v115 = TweenService:Create(v114.CATEGORY_ICON_TEMPLATE, TweenInfo.new(0.1), {
                    ImageTransparency = p108 and 0 or 1
                });
                v115:Play();
                v115.Completed:Wait();
            end;
        end;
    end;

    if not p108 then
        for i = #CosmeticCategoryList, 1, -1 do
            local v116 = CosmeticCategoryList[i];
            local v117 = u103[v116.CategoryName];
            local v118;

            if v116 == v117 then
                v118 = i;
            else
                local v119 = TweenService:Create(v117.CATEGORY_ICON_TEMPLATE, TweenInfo.new(0.1), {
                    ImageTransparency = p108 and 0 or 1
                });
                v119:Play();
                v119.Completed:Wait();
                v118 = i;
            end;
        end;

        u16.Visible = false;
        local v120 = TweenService:Create(UIAspectRatioConstraint, TweenInfo.new(0.3), {
            AspectRatio = p108 and #CosmeticCategoryList or 1
        });
        v120:Play();
        v120.Completed:Wait();
    end;

    u106 = false;
end;

local function u122(p121) -- Line: 1013
    -- upvalues: Color3_fromRGB_ret7 (copy), u101 (copy), TweenService (copy), u102 (copy)
    TweenService:Create(u102, TweenInfo.new(0.1), {
        ImageColor3 = p121 and Color3_fromRGB_ret7 or u101
    }):Play();
end;

u102.ImageColor3 = u101;
SENSOR3.MouseEnter:Connect(function() -- Line: 1024
    -- upvalues: PlayHoverSound (copy), u122 (copy)
    PlayHoverSound();
    u122(true);
end);
SENSOR3.MouseLeave:Connect(function() -- Line: 1030
    -- upvalues: u101 (copy), TweenService (copy), u102 (copy)
    TweenService:Create(u102, TweenInfo.new(0.1), {
        ImageColor3 = u101
    }):Play();
end);
SENSOR3.MouseButton1Down:Connect(function() -- Line: 1034
    -- upvalues: Color3_fromRGB_ret7 (copy), u101 (copy), TweenService (copy), u102 (copy)
    TweenService:Create(u102, TweenInfo.new(0.1), {
        ImageColor3 = Color3_fromRGB_ret7 or u101
    }):Play();
end);
SENSOR3.MouseButton1Up:Connect(function() -- Line: 1037
    -- upvalues: u101 (copy), TweenService (copy), u102 (copy)
    TweenService:Create(u102, TweenInfo.new(0.1), {
        ImageColor3 = u101
    }):Play();
end);
SENSOR3.MouseButton1Click:Connect(function() -- Line: 1041
    -- upvalues: u24 (copy)
    u24:ToggleCategoryDropdown(not u24.CategoryState);
end);
local UIScale = CosmeticInventory.UIScale;
local SENSOR4 = v2.SENSOR;
local u123 = TweenService:Create(v2.ANIMATED_TEXTURE, TweenInfo.new(0.2), {
    ImageColor3 = v2.ANIMATED_TEXTURE.ImageColor3
});
local u124 = TweenService:Create(v2.ANIMATED_TEXTURE, TweenInfo.new(0.2), {
    ImageColor3 = AdjustBrightnessHSV(v2.ANIMATED_TEXTURE.ImageColor3, 0.2)
});
SENSOR4.MouseLeave:Connect(function() -- Line: 1058
    -- upvalues: u123 (copy)
    u123:Play();
end);
SENSOR4.MouseEnter:Connect(function() -- Line: 1062
    -- upvalues: u124 (copy), PlayHoverSound (copy)
    u124:Play();
    PlayHoverSound();
end);
SENSOR4.MouseButton1Click:Connect(function() -- Line: 1067
    -- upvalues: u24 (copy)
    u24:ChangeScaleMode(not u24.BigScale);
end);
task.spawn(function() -- Line: 1071
    -- upvalues: workspace_CurrentCamera (ref), TweenService (copy), UIScale (copy)
    while true do
        local v125;

        repeat
            task.wait(0.1);
            v125 = workspace_CurrentCamera.ViewportSize.X;
        until v125 ~= nil;

        TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = math.min(0.0011111111111111111 * v125, 1.5)
        }):Play();
    end;
end);
local _ = CosmeticInventory.UIScale;
local SENSOR5 = v7.SENSOR;
local u126 = TweenService:Create(v7.ANIMATED_TEXTURE, TweenInfo.new(0.2), {
    ImageColor3 = v7.ANIMATED_TEXTURE.ImageColor3
});
local u127 = TweenService:Create(v7.ANIMATED_TEXTURE, TweenInfo.new(0.2), {
    ImageColor3 = AdjustBrightnessHSV(v7.ANIMATED_TEXTURE.ImageColor3, 0.2)
});
SENSOR5.MouseLeave:Connect(function() -- Line: 1099
    -- upvalues: u126 (copy)
    u126:Play();
end);
SENSOR5.MouseEnter:Connect(function() -- Line: 1103
    -- upvalues: u127 (copy), PlayHoverSound (copy)
    u127:Play();
    PlayHoverSound();
end);
SENSOR5.MouseButton1Click:Connect(function() -- Line: 1108
    -- upvalues: u24 (copy), u23 (copy)
    u24:Toggle(false);
    u23:deselect();
end);

local function GenerateItemMap() -- Line: 1116
    -- upvalues: CosmeticService (copy)
    local AllEquippedCosmetics = CosmeticService:GetAllEquippedCosmetics();
    local AllCosmetics2 = CosmeticService:GetAllCosmetics();
    local v128 = {
        ReturnedItemMap = {},
        UniqueItemMap = {}
    };
    local ReturnedItemMap = v128.ReturnedItemMap;
    local UniqueItemMap = v128.UniqueItemMap;

    for i, v in AllCosmetics2 do
        if not AllEquippedCosmetics[i] and typeof(v) == "table" then
            local Name = v.Name;

            if Name then
                local Data = v.Data;

                if typeof(Data) == "table" then
                    if not ReturnedItemMap[Name] then
                        ReturnedItemMap[Name] = 0;
                    end;

                    if next(Data) then
                        UniqueItemMap[i] = true;
                    else
                        ReturnedItemMap[Name] = ReturnedItemMap[Name] + 1;
                    end;
                else
                    warn(i, "Cosmetic is corrupted and has no ArbitraryData");
                end;
            else
                warn(i, "Cosmetic is corrupted and has no name!");
            end;
        end;
    end;

    for i, v in CosmeticService:GetPooledCounts() do
        ReturnedItemMap[i] = (ReturnedItemMap[i] or 0) + v;
    end;

    return v128;
end;

local function CleanupCosmeticCounter(p129) -- Line: 1153
    -- upvalues: u24 (copy)
    if not p129 or typeof(p129) ~= "string" then
        return;
    end;

    local CosmeticCounterFrames = u24.FrameRenderData.CosmeticCounterFrames;
    local v130 = CosmeticCounterFrames[p129];

    if v130 then
        v130:Destroy();
        CosmeticCounterFrames[p129] = nil;
    end;
end;

local function CleanupCosmeticUnique(p131) -- Line: 1165
    -- upvalues: u24 (copy)
    if not p131 or typeof(p131) ~= "string" then
        return;
    end;

    local UniqueCosmeticFrames = u24.FrameRenderData.UniqueCosmeticFrames;
    local v132 = UniqueCosmeticFrames[p131];

    if v132 then
        v132:Destroy();
        UniqueCosmeticFrames[p131] = nil;
    end;
end;

local function FindUnequippedCounterCosmeticId(p133) -- Line: 1178
    -- upvalues: CosmeticService (copy), u89 (copy)
    local AllEquippedCosmetics = CosmeticService:GetAllEquippedCosmetics();
    local AllCosmetics2 = CosmeticService:GetAllCosmetics();
    local PlacedInAnySlot = CosmeticService:GetPlacedInAnySlot();

    for _, v in (CosmeticService:GetPooledCounts()[p133] or 0) > 0 and { true } or { true, false } do
        local v134 = v;

        for i, v3 in AllCosmetics2 do
            if not (u89[i] or (AllEquippedCosmetics[i] or v134 and PlacedInAnySlot[i])) and typeof(v3) == "table" then
                local Name = v3.Name;

                if Name then
                    if Name == p133 then
                        local Data = v3.Data;

                        if typeof(Data) == "table" then
                            if not next(Data) then
                                return i;
                            end;
                        else
                            warn(i, "Cosmetic is corrupted and has no ArbitraryData");
                        end;
                    end;
                else
                    warn(i, "Cosmetic is corrupted and has no name!");
                end;
            end;
        end;
    end;
end;

local function NotifyRefilling(p135: string) -- Line: 1205
    -- upvalues: CosmeticService (copy), Notification (copy)
    if (CosmeticService:GetPooledCounts()[p135] or 0) > 0 then
        Notification:CreateNotification((`Getting more {p135} ready, try again in a moment!`));
    end;
end;

local function RenderCosmeticsInInventory() -- Line: 1211
    -- upvalues: GenerateItemMap (copy), u24 (copy), CosmeticService (copy), CosmeticList (copy), COSMETIC_TEMPLATE (copy), WaitForDescendant (copy), TweenService (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Notification (copy), FindUnequippedCounterCosmeticId (copy), NotifyRefilling (copy), u89 (copy), ModernInputNotificationUserInterfaceService (copy), CountDictionary (copy), LocalPlayer (copy), PlaySound (copy), PlayHoverSound (copy), GetUIElementWithTag (copy), ToggleDeleteUI (copy), ItemInfoHover (copy), u5 (copy)
    local v136 = GenerateItemMap();
    local UniqueCosmeticFrames = u24.FrameRenderData.UniqueCosmeticFrames;
    local CosmeticCounterFrames = u24.FrameRenderData.CosmeticCounterFrames;
    local ReturnedItemMap = v136.ReturnedItemMap;
    local UniqueItemMap = v136.UniqueItemMap;
    local AllCosmetics2 = CosmeticService:GetAllCosmetics();

    for i, _ in CosmeticCounterFrames do
        if ReturnedItemMap[i] then
            if ReturnedItemMap[i] <= 0 and i then
                if typeof(i) == "string" then
                    local CosmeticCounterFrames2 = u24.FrameRenderData.CosmeticCounterFrames;
                    local v137 = CosmeticCounterFrames2[i];

                    if v137 then
                        v137:Destroy();
                        CosmeticCounterFrames2[i] = nil;
                    end;
                end;
            end;
        elseif i then
            if typeof(i) == "string" then
                local CosmeticCounterFrames2 = u24.FrameRenderData.CosmeticCounterFrames;
                local v138 = CosmeticCounterFrames2[i];

                if v138 then
                    v138:Destroy();
                    CosmeticCounterFrames2[i] = nil;
                end;
            end;
        end;
    end;

    for i, _ in UniqueCosmeticFrames do
        if not UniqueItemMap[i] and i then
            if typeof(i) == "string" then
                local UniqueCosmeticFrames2 = u24.FrameRenderData.UniqueCosmeticFrames;
                local v139 = UniqueCosmeticFrames2[i];

                if v139 then
                    v139:Destroy();
                    UniqueCosmeticFrames2[i] = nil;
                end;
            end;
        end;
    end;

    for i, v in ReturnedItemMap do
        if v > 0 then
            local u140 = CosmeticList[i];

            if u140 then
                local u141 = CosmeticCounterFrames[i];

                if not u141 then
                    u141 = COSMETIC_TEMPLATE:Clone();
                    local v142 = WaitForDescendant(u141, "SENSOR");
                    local u143 = TweenService:Create(u141.ActualFrame, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3_fromRGB_ret
                    });
                    local u144 = TweenService:Create(u141.ActualFrame, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3_fromRGB_ret2
                    });
                    v142.MouseButton1Down:Connect(function() -- Line: 1252
                        -- upvalues: u144 (copy)
                        u144:Play();
                    end);
                    v142.MouseButton1Up:Connect(function() -- Line: 1256
                        -- upvalues: u143 (copy), u24 (ref), u140 (copy), Notification (ref), i (copy), FindUnequippedCounterCosmeticId (ref), NotifyRefilling (ref), u89 (ref), ModernInputNotificationUserInterfaceService (ref), CosmeticService (ref), CountDictionary (ref), LocalPlayer (ref), PlaySound (ref)
                        u143:Play();

                        if u24.DeletionMode then
                            if u140.Undeletable then
                                Notification:CreateNotification((`{i} is undeletable.`));

                                return;
                            end;

                            local u145 = FindUnequippedCounterCosmeticId(i);

                            if not u145 then
                                return NotifyRefilling(i);
                            end;

                            u89[u145] = true;
                            ModernInputNotificationUserInterfaceService:CreateNotification({
                                Icon = u140.Icon,
                                Text = `Are you sure you want to destroy "{i}"?`,

                                OnConfirm = function(p146) -- Line: 1271, Name: OnConfirm
                                    -- upvalues: CosmeticService (ref), u145 (copy), u89 (ref)
                                    CosmeticService:DestroyCosmetic(u145);
                                    u89[p146.OccupiedUUID] = nil;
                                end,

                                OnDecline = function(p147) -- Line: 1275, Name: OnDecline
                                    -- upvalues: u89 (ref)
                                    u89[p147.OccupiedUUID] = nil;
                                end
                            }).OccupiedUUID = u145;

                            return;
                        end;

                        if CosmeticService:HasMaxEquipped() then
                            return Notification:CreateNotification((`Cannot place anymore you have max placed objects! {CountDictionary(CosmeticService:GetAllEquippedCosmetics())}`));
                        end;

                        if not CosmeticService:CanEquipAtLocation(LocalPlayer) then
                            return Notification:CreateNotification("Cannot place cosmetic out of farm!");
                        end;

                        local v148 = FindUnequippedCounterCosmeticId(i);

                        if not v148 then
                            return NotifyRefilling(i);
                        end;

                        CosmeticService:Equip(v148);
                        task.delay(0.2, function() -- Line: 1291
                            -- upvalues: PlaySound (ref)
                            PlaySound("rbxassetid://99990810464653").Volume = 0.5;
                        end);
                    end);
                    v142.MouseEnter:Connect(function() -- Line: 1297
                        -- upvalues: u143 (copy), PlayHoverSound (ref), GetUIElementWithTag (ref), u141 (ref), u144 (copy), u24 (ref), ToggleDeleteUI (ref)
                        u143:Play();
                        PlayHoverSound();
                        task.spawn(function() -- Line: 1301
                            -- upvalues: GetUIElementWithTag (ref), u141 (ref), u144 (ref)
                            repeat
                                task.wait();
                            until GetUIElementWithTag("CosmeticItemTemplate") ~= u141;

                            u144:Play();
                        end);

                        if u24.DeletionMode then
                            ToggleDeleteUI(u141, true);
                        end;
                    end);
                    v142.MouseLeave:Connect(function() -- Line: 1317
                        -- upvalues: ToggleDeleteUI (ref), u141 (ref), u144 (copy)
                        ToggleDeleteUI(u141, false);
                        u144:Play();
                    end);
                    local v149 = `CosmeticInventory_{i}`;
                    ItemInfoHover:AddItemToData(v149, {
                        DescriptionOnly = true,
                        DisplayName = `{i}`,
                        Description = `{u140.Description}`,
                        ItemImage = `{u140.Icon}`,
                        Properties = {
                            Rarity = u140.Rarity
                        }
                    });
                    u141:SetAttribute("UUID", v149);
                    u141:SetAttribute("CounterCosmeticName", i);
                    u141:AddTag("ItemInfoHoverTag");
                    u141.Visible = true;
                    u141.Parent = u5;
                    CosmeticCounterFrames[i] = u141;
                end;

                local v150 = WaitForDescendant(u141, "COUNTER_TEXT");
                v150.Text = `x{v}`;
                WaitForDescendant(u141, "ITEM_ICON").Image = u140.Icon;
                v150.Visible = v >= 2;
            else
                warn(i, "has no attached registry data! Skipping render.");
            end;
        end;
    end;

    for i in UniqueItemMap do
        local u151 = AllCosmetics2[i];

        if u151 then
            local Name = u151.Name;
            local u152 = CosmeticList[Name];

            if u152 then
                local u153 = UniqueCosmeticFrames[i];

                if not u153 then
                    u153 = COSMETIC_TEMPLATE:Clone();
                    local v154 = WaitForDescendant(u153, "SENSOR");
                    local u155 = TweenService:Create(u153.ActualFrame, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3_fromRGB_ret
                    });
                    local u156 = TweenService:Create(u153.ActualFrame, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3_fromRGB_ret2
                    });
                    v154.MouseButton1Down:Connect(function() -- Line: 1372
                        -- upvalues: u156 (copy)
                        u156:Play();
                    end);
                    v154.MouseButton1Up:Connect(function() -- Line: 1376
                        -- upvalues: u155 (copy), u24 (ref), u152 (copy), Notification (ref), u151 (copy), ModernInputNotificationUserInterfaceService (ref), Name (copy), CosmeticService (ref), i (copy), CountDictionary (ref), LocalPlayer (ref), PlaySound (ref)
                        u155:Play();

                        if u24.DeletionMode then
                            if u152.Undeletable then
                                Notification:CreateNotification((`{u151.Name} is undeletable.`));

                                return;
                            end;

                            ModernInputNotificationUserInterfaceService:CreateNotification({
                                Icon = u152.Icon,
                                Text = `Are you sure you want to destroy "{Name}"?`,

                                OnConfirm = function() -- Line: 1391, Name: OnConfirm
                                    -- upvalues: CosmeticService (ref), i (ref)
                                    CosmeticService:DestroyCosmetic(i);
                                end
                            });

                            return;
                        end;

                        if CosmeticService:HasMaxEquipped() then
                            return Notification:CreateNotification((`Cannot place anymore you have max placed objects! {CountDictionary(CosmeticService:GetAllEquippedCosmetics())}`));
                        end;

                        if not CosmeticService:CanEquipAtLocation(LocalPlayer) then
                            return Notification:CreateNotification("Cannot place cosmetic out of farm!");
                        end;

                        CosmeticService:Equip(i);
                        PlaySound("rbxassetid://99990810464653").Volume = 0.5;
                    end);
                    v154.MouseEnter:Connect(function() -- Line: 1407
                        -- upvalues: u155 (copy), PlayHoverSound (ref), GetUIElementWithTag (ref), u153 (ref), u156 (copy), u24 (ref), ToggleDeleteUI (ref)
                        u155:Play();
                        PlayHoverSound();
                        task.spawn(function() -- Line: 1410
                            -- upvalues: GetUIElementWithTag (ref), u153 (ref), u156 (ref)
                            repeat
                                task.wait();
                            until GetUIElementWithTag("CosmeticItemTemplate") ~= u153;

                            u156:Play();
                        end);

                        if u24.DeletionMode then
                            ToggleDeleteUI(u153, true);
                        end;
                    end);
                    v154.MouseLeave:Connect(function() -- Line: 1426
                        -- upvalues: ToggleDeleteUI (ref), u153 (ref), u156 (copy)
                        ToggleDeleteUI(u153, false);
                        u156:Play();
                    end);
                    u153:SetAttribute("UniqueCosmeticUUID", i);
                    u153.Visible = true;
                    u153.Parent = u5;
                    UniqueCosmeticFrames[i] = u153;
                end;

                WaitForDescendant(u153, "ITEM_ICON").Image = u152.Icon;
            else
                warn(Name, i, "has no attached registry data! Skipping render.");
            end;
        end;
    end;
end;

RenderCosmeticsInInventory();
UpdateUnseenVisuals();
UpdateStats();
DataService:GetPathSignal("CosmeticData/MutableStats/@"):Connect(function() -- Line: 1446
    -- upvalues: UpdateStats (copy)
    UpdateStats();
end);
local u157 = false;

local function QueueRender() -- Line: 1452
    -- upvalues: u157 (ref), UpdateStats (copy), RenderCosmeticsInInventory (copy), UpdateUnseenVisuals (copy), PlayNewUnlockEffects (copy)
    if u157 then
        return;
    end;

    u157 = true;
    task.defer(function() -- Line: 1455
        -- upvalues: u157 (ref), UpdateStats (ref), RenderCosmeticsInInventory (ref), UpdateUnseenVisuals (ref), PlayNewUnlockEffects (ref)
        u157 = false;
        UpdateStats();
        RenderCosmeticsInInventory();
        UpdateUnseenVisuals();
        PlayNewUnlockEffects();
    end);
end;

DataService:GetPathSignal("CosmeticData/@"):Connect(QueueRender);
DataService:GetPathSignal("SaveSlots/@"):Connect(QueueRender);
u6:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1468
    -- upvalues: u24 (copy), u6 (copy)
    u24:Search(u6.Text);
end);
StateForGui.Visible:Observe(function(p158: boolean, p159: boolean?) -- Line: 1472
    -- upvalues: u23 (copy)
    if p158 then
        u23:select();

        return;
    end;

    u23:deselect();
end);
UserInputService.InputEnded:Connect(function(p160, p161) -- Line: 1480
    -- upvalues: LocalPlayer (copy), UserInputService (copy), u24 (copy), u23 (copy)
    if LocalPlayer:GetAttribute("FirstTimePlayer") then
        return;
    end;

    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if p161 then
        return;
    end;

    if p160.KeyCode ~= Enum.KeyCode.B then
        return;
    end;

    u24:Toggle(not u24.State);

    if u24.State then
        u23:select();

        return;
    end;

    u23:deselect();
end);
u23.toggled:Connect(function(p162, p163) -- Line: 1494
    -- upvalues: LocalPlayer (copy), u24 (copy)
    if p163 ~= "User" then
        return;
    end;

    if LocalPlayer:GetAttribute("FirstTimePlayer") then
        return;
    end;

    u24:Toggle(p162);
end);
LocalPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Connect(function() -- Line: 1500
    -- upvalues: u23 (copy), LocalPlayer (copy)
    u23:setEnabled(not LocalPlayer:GetAttribute("FirstTimePlayer"));
end);
u23:setEnabled(not LocalPlayer:GetAttribute("FirstTimePlayer"));
local u164 = nil;
local u165 = false;
StateForGui.Visible:Observe(function(u166: boolean) -- Line: 1508
    -- upvalues: ReplicatedStorage (copy), u165 (ref), MarkAllUnseenSeen (copy), u24 (copy), u164 (ref), TweenService (copy), CosmeticInventory (copy), GamepadService (copy), INSERTION_POINT (copy), COSMETIC_TEMPLATE (copy), BackpackGui (copy), ActivePetUI (copy)
    if u166 then
        ReplicatedStorage.GameEvents.CosmeticNotice:FireServer();
    elseif u165 then
        MarkAllUnseenSeen();
    end;

    u165 = u166;
    u24.State = u166;
    u24.OnToggled:Fire(u166);

    if u164 then
        u164:Cancel();
        u164 = nil;
    end;

    local u167 = TweenService:Create(CosmeticInventory, TweenInfo.new(0.2), {
        Position = u166 and UDim2.fromScale(0.5, 0.97) or UDim2.fromScale(0.5, 1.5)
    });
    u167:Play();
    u164 = u167;

    if u166 then
        CosmeticInventory.Visible = true;
    end;

    u167.Completed:Once(function() -- Line: 1538
        -- upvalues: u167 (copy), u166 (copy), CosmeticInventory (ref), GamepadService (ref), INSERTION_POINT (ref), COSMETIC_TEMPLATE (ref), u164 (ref)
        if u167.PlaybackState ~= Enum.PlaybackState.Completed then
            return;
        end;

        if u166 then
            GamepadService:EnableGamepadCursor(INSERTION_POINT:FindFirstChildOfClass(COSMETIC_TEMPLATE.Name) or CosmeticInventory);
        else
            CosmeticInventory.Visible = false;
        end;

        if u164 == u167 then
            u164 = nil;
        end;
    end);
    BackpackGui.Enabled = not u166;
    ActivePetUI.Enabled = not u166;

    if not u166 then
        u24:ChangeScaleMode(true);
    end;
end);
task.spawn(function() -- Line: 1562
    -- upvalues: TradeWorldController (copy), u23 (copy), GuiService (copy), u24 (copy), UpdateUnseenVisuals (copy)
    if TradeWorldController:IsInWorld() then
        u23:destroy();

        return;
    end;

    GuiService.MenuOpened:Connect(function() -- Line: 1568
        -- upvalues: u24 (ref)
        u24:Toggle(false);
    end);
    UpdateUnseenVisuals();
end);

return u24;