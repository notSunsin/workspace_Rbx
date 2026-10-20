-- Decompiled with Potassium's decompiler.

local Color3_fromRGB_ret = Color3.fromRGB(0, 162, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(78, 84, 96);
local Color3_fromRGB_ret3 = Color3.fromRGB(204, 204, 204);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret5 = Color3.fromRGB(150, 150, 150);
local HttpService = game:GetService("HttpService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local PlayerGui = game.Players.LocalPlayer.PlayerGui;
PlayerGui:WaitForChild("BackpackGui");
local ContextActionService = game:GetService("ContextActionService");
local VRService = game:GetService("VRService");
local success, result = pcall(function() -- Line: 39
    return false;
end);
local u1 = success and result;
local u5 = {
    Create = function(u2) -- Line: 48, Name: Create
        return function(p3) -- Line: 49
            -- upvalues: u2 (copy)
            local Instance_new_ret = Instance.new(u2);
            local v4 = nil;

            for i, v in pairs(p3) do
                if type(i) == "number" then
                    v.Parent = Instance_new_ret;
                elseif i == "Parent" then
                    v4 = v;
                else
                    Instance_new_ret[i] = v;
                end;
            end;

            if v4 then
                Instance_new_ret.Parent = v4;
            end;

            return Instance_new_ret;
        end;
    end
};
local u6 = {};
setmetatable(u6, {
    __mode = "k"
});
local u7 = u5.Create("ImageLabel")({
    Image = "",
    BackgroundTransparency = 1
});

function clamp(p8, p9, p10)
    local math_min_ret = math.min(p9, p10);

    return math.max(p8, math_min_ret);
end;

function ClampVector2(p11, p12, p13)
    return Vector2.new(clamp(p11.x, p12.x, p13.x), clamp(p11.y, p12.y, p13.y));
end;

local function Linear(p14, p15, p16, p17) -- Line: 90
    if p17 <= p14 then
        return p15 + p16;
    end;

    return p16 * p14 / p17 + p15;
end;

local function EaseOutQuad(p18, p19, p20, p21) -- Line: 98
    if p21 <= p18 then
        return p19 + p20;
    end;

    local v22 = p18 / p21;

    return p19 - p20 * v22 * (v22 - 2);
end;

local function EaseInOutQuad(p23, p24, p25, p26) -- Line: 107
    if p26 <= p23 then
        return p24 + p25;
    end;

    local v27 = p23 / p26;

    if v27 < 0.5 then
        return 2 * p25 * v27 * v27 + p24;
    end;

    return p24 + p25 * (2 * (2 - v27) * v27 - 1);
end;

function PropertyTweener(u28, u29, u30, u31, u32, u33, u34)
    -- upvalues: RunService (copy)
    local u35 = {
        StartTime = tick()
    };
    u35.EndTime = u35.StartTime + u32;
    u35.Cancelled = false;
    local u36 = false;
    local u37 = 0;

    local function finalize() -- Line: 128
        -- upvalues: u28 (copy), u29 (copy), u33 (copy), u30 (copy), u31 (copy), u36 (ref), u37 (ref), u34 (copy)
        if u28 then
            u28[u29] = u33(1, u30, u31 - u30, 1);
        end;

        u36 = true;
        u37 = 1;

        if u34 then
            u34();
        end;
    end;

    u28[u29] = u33(0, u30, u31 - u30, u32);
    coroutine.wrap(function() -- Line: 141
        -- upvalues: u35 (copy), u28 (copy), u29 (copy), u33 (copy), u30 (copy), u31 (copy), u32 (copy), u37 (ref), RunService (ref), u36 (ref), u34 (copy)
        local v38 = tick();

        while v38 < u35.EndTime and u28 do
            if u35.Cancelled then
                return;
            end;

            u28[u29] = u33(v38 - u35.StartTime, u30, u31 - u30, u32);
            u37 = clamp(0, 1, (v38 - u35.StartTime) / u32);
            RunService.RenderStepped:wait();
            v38 = tick();
        end;

        if u35.Cancelled == false and u28 then
            if u28 then
                u28[u29] = u33(1, u30, u31 - u30, 1);
            end;

            u36 = true;
            u37 = 1;

            if u34 then
                u34();
            end;
        end;
    end)();

    function u35.GetFinal(p39) -- Line: 157
        -- upvalues: u31 (copy)
        return u31;
    end;

    function u35.GetPercentComplete(p40) -- Line: 161
        -- upvalues: u37 (ref)
        return u37;
    end;

    function u35.IsFinished(p41) -- Line: 165
        -- upvalues: u36 (ref)
        return u36;
    end;

    function u35.Finish(p42) -- Line: 169
        -- upvalues: u36 (ref), u28 (copy), u29 (copy), u33 (copy), u30 (copy), u31 (copy), u37 (ref), u34 (copy)
        if not u36 then
            p42:Cancel();

            if u28 then
                u28[u29] = u33(1, u30, u31 - u30, 1);
            end;

            u36 = true;
            u37 = 1;

            if u34 then
                u34();
            end;
        end;
    end;

    function u35.Cancel(p43) -- Line: 176
        -- upvalues: u35 (copy)
        u35.Cancelled = true;
    end;

    return u35;
end;

local function CreateSignal() -- Line: 185
    local v44 = {};
    local BindableEvent = Instance.new("BindableEvent");
    local u45 = nil;
    local u46 = nil;

    function v44.fire(p47, ...) -- Line: 193
        -- upvalues: u45 (ref), u46 (ref), BindableEvent (copy)
        u45 = { ... };
        u46 = select("#", ...);
        BindableEvent:Fire();
    end;

    function v44.connect(p48, u49) -- Line: 199
        -- upvalues: BindableEvent (copy), u45 (ref), u46 (ref)
        if not u49 then
            error("connect(nil)", 2);
        end;

        return BindableEvent.Event:Connect(function() -- Line: 201
            -- upvalues: u49 (copy), u45 (ref), u46 (ref)
            u49(unpack(u45, 1, u46));
        end);
    end;

    function v44.wait(p50) -- Line: 206
        -- upvalues: BindableEvent (copy), u45 (ref), u46 (ref)
        BindableEvent.Event:wait();

        if not u45 then
            error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.");
        end;

        return unpack(u45, 1, u46);
    end;

    return v44;
end;

local function getViewportSize() -- Line: 217
    while not workspace.CurrentCamera do
        workspace.Changed:wait();
    end;

    while workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) or workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) do
        workspace.CurrentCamera.Changed:wait();
    end;

    return workspace.CurrentCamera.ViewportSize;
end;

local function isSmallTouchScreen() -- Line: 232
    -- upvalues: getViewportSize (copy), UserInputService (copy)
    local v51 = getViewportSize();

    return UserInputService.TouchEnabled and (v51.Y < 500 and true or v51.X < 700);
end;

local function isPortrait() -- Line: 237
    -- upvalues: getViewportSize (copy)
    local v52 = getViewportSize();

    return v52.Y > v52.X;
end;

local function isTenFootInterface() -- Line: 242
    return false;
end;

local function usesSelectedObject() -- Line: 246
    -- upvalues: VRService (copy), UserInputService (copy)
    if VRService.VREnabled then
        return false;
    end;

    return (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
end;

local function isPosOverGui(p53, p54, p55) -- Line: 255
    local x = p54.AbsolutePosition.x;
    local y = p54.AbsolutePosition.y;
    local v56 = y + p54.AbsoluteSize.y;
    local v57;

    if x < p53.x and (p53.x < x + p54.AbsoluteSize.x and y < p53.y) then
        v57 = p53.y < v56;
    else
        v57 = false;
    end;

    return v57;
end;

local function isPosOverGuiWithClipping(p58, p59) -- Line: 263
    local x = p59.AbsolutePosition.x;
    local y = p59.AbsolutePosition.y;
    local v60 = y + p59.AbsoluteSize.y;
    local v61;

    if x < p58.x and (p58.x < x + p59.AbsoluteSize.x and y < p58.y) then
        v61 = p58.y < v60;
    else
        v61 = false;
    end;

    if not v61 then
        return false;
    end;

    local v62;

    while true do
        if p59 == nil or not (p59:IsA("GuiObject") or p59:IsA("LayerCollector")) then
            v62 = not (p59 and p59:IsA("CoreGui"));
            break;
        end;

        if p59:IsA("GuiObject") and not p59.Visible then
            v62 = true;
            break;
        end;

        if p59:IsA("LayerCollector") or p59.ClipsDescendants then
            local x2 = p59.AbsolutePosition.x;
            local y2 = p59.AbsolutePosition.y;
            local v63 = y2 + p59.AbsoluteSize.y;
            local v64;

            if x2 < p58.x and (p58.x < x2 + p59.AbsoluteSize.x and y2 < p58.y) then
                v64 = p58.y < v63;
            else
                v64 = false;
            end;

            if not v64 then
                v62 = true;
                break;
            end;
        end;

        p59 = p59.Parent;
    end;

    return not v62;
end;

local function areGuisIntersecting(p65, p66) -- Line: 296
    local x = p65.AbsolutePosition.x;
    local y = p65.AbsolutePosition.y;
    local v67 = x + p65.AbsoluteSize.x;
    local v68 = y + p65.AbsoluteSize.y;
    local x2 = p66.AbsolutePosition.x;
    local y2 = p66.AbsolutePosition.y;
    local v69;

    if x < x2 + p66.AbsoluteSize.x then
        v69 = x2 < v67;
    else
        v69 = false;
    end;

    local v70;

    if y < y2 + p66.AbsoluteSize.y then
        v70 = y2 < v68;
    else
        v70 = false;
    end;

    return v69 and v70;
end;

local function isGuiVisible(p71, p72) -- Line: 311
    local v73 = p71;
    local v74;

    while true do
        if p71 == nil or not (p71:IsA("GuiObject") or p71:IsA("LayerCollector")) then
            v74 = not (p71 and p71:IsA("CoreGui"));
            break;
        end;

        if p71:IsA("GuiObject") and not p71.Visible then
            v74 = true;
            break;
        end;

        if p71:IsA("LayerCollector") or p71.ClipsDescendants then
            local x = p71.AbsolutePosition.x;
            local y = p71.AbsolutePosition.y;
            local v75 = x + p71.AbsoluteSize.x;
            local v76 = y + p71.AbsoluteSize.y;
            local x2 = v73.AbsolutePosition.x;
            local y2 = v73.AbsolutePosition.y;
            local v77;

            if x < x2 + v73.AbsoluteSize.x then
                v77 = x2 < v75;
            else
                v77 = false;
            end;

            local v78;

            if y < y2 + v73.AbsoluteSize.y then
                v78 = y2 < v76;
            else
                v78 = false;
            end;

            if not (v77 and v78) then
                v74 = true;
                break;
            end;
        end;

        p71 = p71.Parent;
    end;

    return not v74;
end;

local function addHoverState(u79, u80, u81, u82) -- Line: 340
    local function onNormalButtonStateCallback() -- Line: 341
        -- upvalues: u79 (copy), u81 (copy), u80 (copy)
        if u79.Active then
            u81(u80);
        end;
    end;

    local function onHoverButtonStateCallback() -- Line: 346
        -- upvalues: u79 (copy), u82 (copy), u80 (copy)
        if u79.Active then
            u82(u80);
        end;
    end;

    u79.MouseEnter:Connect(onHoverButtonStateCallback);
    u79.SelectionGained:Connect(onHoverButtonStateCallback);
    u79.MouseLeave:Connect(onNormalButtonStateCallback);
    u79.SelectionLost:Connect(onNormalButtonStateCallback);
    u81(u80);
end;

local function addOnResizedCallback(p83, p84) -- Line: 360
    -- upvalues: u6 (copy), getViewportSize (copy)
    u6[p83] = p84;
    local v85 = getViewportSize();
    local v86 = getViewportSize();
    p84(v85, v86.Y > v86.X);
end;

local u87 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};

local function MakeDefaultButton(p88, p89, u90, u91, u92) -- Line: 376
    -- upvalues: u5 (copy), u87 (copy), UserInputService (copy), GuiService (copy), VRService (copy)
    local v93 = u5.Create("ImageLabel")({
        Image = "",
        BackgroundTransparency = 1
    });
    local u94 = u5.Create("ImageButton")({
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = p88 .. "Button",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = p89,
        SelectionImageObject = v93
    });
    u5.Create("BoolValue")({
        Name = "Enabled",
        Value = true,
        Parent = u94
    });

    if u90 then
        u94.MouseButton1Click:Connect(function() -- Line: 404
            -- upvalues: u90 (copy), u87 (ref), UserInputService (ref)
            u90(u87[UserInputService:GetLastInputType()] or false);
        end);
    end;

    local function isPointerInput(p95) -- Line: 409
        return p95.UserInputType == Enum.UserInputType.MouseMovement and true or p95.UserInputType == Enum.UserInputType.Touch;
    end;

    local u96 = nil;

    local function setRowRef(p97) -- Line: 414
        -- upvalues: u96 (ref)
        u96 = p97;
    end;

    local function selectButton() -- Line: 418
        -- upvalues: u92 (copy), u91 (copy), u94 (copy), u96 (ref)
        local v98 = u92;

        if v98 == nil and u91 then
            v98 = u91.HubRef;
        end;

        if v98 and v98.Active or v98 == nil then
            u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
            local v99 = u94;

            if u96 then
                v99 = u96;
            end;

            if v98 then
                v98:ScrollToFrame(v99);
            end;
        end;
    end;

    local function deselectButton() -- Line: 439
        -- upvalues: u94 (copy)
        u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
    end;

    u94.InputBegan:Connect(function(p100) -- Line: 443
        -- upvalues: u94 (copy), u92 (copy), u91 (copy), u96 (ref)
        if u94.Selectable and (p100.UserInputType == Enum.UserInputType.MouseMovement or p100.UserInputType == Enum.UserInputType.Touch) then
            local v101 = u92;

            if v101 == nil and u91 then
                v101 = u91.HubRef;
            end;

            if v101 and v101.Active or v101 == nil then
                u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
                local v102 = u94;

                if u96 then
                    v102 = u96;
                end;

                if v101 then
                    v101:ScrollToFrame(v102);
                end;
            end;
        end;
    end);
    u94.InputEnded:Connect(function(p103) -- Line: 448
        -- upvalues: u94 (copy), GuiService (ref)
        if u94.Selectable and GuiService.SelectedCoreObject ~= u94 and (p103.UserInputType == Enum.UserInputType.MouseMovement or p103.UserInputType == Enum.UserInputType.Touch) then
            u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
        end;
    end);
    u94.SelectionGained:Connect(function() -- Line: 455
        -- upvalues: u92 (copy), u91 (copy), u94 (copy), u96 (ref)
        local v104 = u92;

        if v104 == nil and u91 then
            v104 = u91.HubRef;
        end;

        if v104 and v104.Active or v104 == nil then
            u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
            local v105 = u94;

            if u96 then
                v105 = u96;
            end;

            if v104 then
                v104:ScrollToFrame(v105);
            end;
        end;
    end);
    u94.SelectionLost:Connect(function() -- Line: 458
        -- upvalues: u94 (copy)
        u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
    end);
    GuiService.Changed:Connect(function(p106) -- Line: 462
        -- upvalues: VRService (ref), UserInputService (ref), GuiService (ref), u94 (copy), u92 (copy), u91 (copy), u96 (ref)
        if p106 ~= "SelectedCoreObject" then
            return;
        end;

        local v107;

        if VRService.VREnabled then
            v107 = false;
        else
            v107 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
        end;

        if not v107 then
            return;
        end;

        if GuiService.SelectedCoreObject == nil or GuiService.SelectedCoreObject ~= u94 then
            u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";

            return;
        end;

        if u94.Selectable then
            local v108 = u92;

            if v108 == nil and u91 then
                v108 = u91.HubRef;
            end;

            if v108 and v108.Active or v108 == nil then
                u94.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
                local v109 = u94;

                if u96 then
                    v109 = u96;
                end;

                if v108 then
                    v108:ScrollToFrame(v109);
                end;
            end;
        end;
    end);

    return u94, setRowRef;
end;

local function MakeButton(p110, p111, p112, p113, p114, p115) -- Line: 479
    -- upvalues: MakeDefaultButton (copy), u5 (copy), getViewportSize (copy), UserInputService (copy)
    local v116, v117 = MakeDefaultButton(p110, p112, p113, p114, p115);
    local v118 = u5.Create("TextLabel")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 24,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
        Name = p110 .. "TextLabel",
        Size = UDim2.new(1, 0, 1, -8),
        Position = UDim2.new(0, 0, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextYAlignment = Enum.TextYAlignment.Center,
        Font = Enum.Font.SourceSansBold,
        Text = p111,
        Parent = v116
    });
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint", v118);
    local v119 = getViewportSize();

    if UserInputService.TouchEnabled and (v119.Y < 500 and true or v119.X < 700) then
        v118.TextSize = 18;
    elseif false then
        v118.TextSize = 36;
    end;

    UITextSizeConstraint.MaxTextSize = v118.TextSize;

    return v116, v118, v117;
end;

local function MakeImageButton(p120, p121, p122, p123, p124, p125, p126) -- Line: 511
    -- upvalues: MakeDefaultButton (copy), u5 (copy)
    local v127, v128 = MakeDefaultButton(p120, p122, p124, p125, p126);

    return v127, u5.Create("ImageLabel")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
        Name = p120 .. "ImageLabel",
        Size = p123,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = p121,
        Parent = v127
    }), v128;
end;

local function AddButtonRow(p129, p130, p131, p132, p133, p134) -- Line: 530
    -- upvalues: MakeButton (copy), u5 (copy)
    local v135, v136, v137 = MakeButton(p130, p131, p132, p133, p129, p134);
    local v138 = u5.Create("Frame")({
        BackgroundTransparency = 1,
        Name = p130 .. "Row",
        Size = UDim2.new(1, 0, p132.Y.Scale, p132.Y.Offset),
        Parent = p129.Page
    });
    v135.Parent = v138;
    v135.AnchorPoint = Vector2.new(1, 0);
    v135.Position = UDim2.new(1, -20, 0, 0);

    return v138, v135, v136, v137;
end;

local function CreateDropDown(p139, u140, u141) -- Line: 545
    -- upvalues: HttpService (copy), u5 (copy), PlayerGui (copy), VRService (copy), UserInputService (copy), GuiService (copy), ContextActionService (copy), MakeButton (copy)
    local Color3_fromRGB_ret6 = Color3.fromRGB(178, 178, 178);
    local Color3_fromRGB_ret7 = Color3.fromRGB(229, 229, 229);
    local Color3_fromRGB_ret8 = Color3.fromRGB(255, 255, 255);
    local u142 = nil;
    local u143 = {
        CurrentIndex = nil
    };
    Instance.new("BindableEvent").Name = "IndexChanged";

    if type(p139) ~= "table" then
        error("CreateDropDown dropDownStringTable (first arg) is not a table", 2);

        return u143;
    end;

    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Name = "IndexChanged";
    local u144 = true;
    local u145 = HttpService:GenerateGUID(false);
    local u146 = nil;
    local u147 = p139;
    local u148 = u5.Create("ImageButton")({
        Name = "DropDownFullscreenFrame",
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 10,
        Active = true,
        Visible = false,
        Selectable = false,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Parent = PlayerGui.RobloxGui
    });

    local function onVREnabled(p149) -- Line: 592
        -- upvalues: VRService (ref), PlayerGui (ref), u148 (copy), u143 (copy), u147 (ref)
        if p149 ~= "VREnabled" then
            return;
        end;

        if VRService.VREnabled then
            u148.Parent = require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):GetGUI();
            u148.BackgroundTransparency = 1;
        else
            u148.Parent = PlayerGui.RobloxGui;
            u148.BackgroundTransparency = 0.2;
        end;

        if u143.UpdateDropDownList then
            u143:UpdateDropDownList(u147);
        end;
    end;

    VRService.Changed:Connect(onVREnabled);
    onVREnabled("VREnabled");
    local u150 = u5.Create("ImageLabel")({
        Name = "DropDownSelectionFrame",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        BackgroundTransparency = 1,
        ZIndex = 10,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = UDim2.new(0.6, 0, 0.9, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = u148
    });
    local u151 = u5.Create("ScrollingFrame")({
        Name = "DropDownScrollingFrame",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10,
        Size = UDim2.new(1, -20, 1, -25),
        Position = UDim2.new(0, 10, 0, 10),
        Parent = u150
    });
    local u152 = nil;
    local u153 = false;

    local function u157(p154, p155) -- Line: 640
        -- upvalues: u143 (copy), u144 (ref), u141 (copy), u148 (copy), VRService (ref), UserInputService (ref), GuiService (ref), u142 (ref), u152 (ref), ContextActionService (ref), u145 (copy), u146 (ref), u153 (ref), PlayerGui (ref)
        if p154 ~= nil and p155 ~= Enum.UserInputState.Begin then
            return;
        end;

        u143.DropDownFrame.Selectable = u144;
        u141:SetActive(true);

        if u148.Visible then
            local v156;

            if VRService.VREnabled then
                v156 = false;
            else
                v156 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v156 then
                GuiService.SelectedCoreObject = u142;
            end;
        end;

        u148.Visible = false;

        if u152 then
            u152:Disconnect();
        end;

        ContextActionService:UnbindAction(u145 .. "Action");
        ContextActionService:UnbindAction(u145 .. "FreezeAction");
        u146.Value = u144;
        u153 = false;

        if VRService.VREnabled then
            require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(u148, 0);
        end;
    end;

    local function u158() -- Line: 664
    end;

    local function u160() -- Line: 666
        -- upvalues: u144 (ref), u143 (copy), u153 (ref), u148 (copy), VRService (ref), PlayerGui (ref), u142 (ref), GuiService (ref), u152 (ref), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret6 (copy), ContextActionService (ref), u145 (copy), u158 (copy), u157 (copy), u141 (copy), u146 (ref)
        if not u144 then
            return;
        end;

        u143.DropDownFrame.Selectable = false;
        u153 = true;
        u148.Visible = true;

        if VRService.VREnabled then
            require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(u148, 0.5);
        end;

        u142 = u143.DropDownFrame;

        if u143.CurrentIndex and u143.CurrentIndex > 0 then
            GuiService.SelectedCoreObject = u143.Selections[u143.CurrentIndex];
        end;

        u152 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- Line: 683
            -- upvalues: u143 (ref), GuiService (ref), Color3_fromRGB_ret8 (ref), VRService (ref), Color3_fromRGB_ret7 (ref), Color3_fromRGB_ret6 (ref)
            for i = 1, #u143.Selections do
                local v159;

                if GuiService.SelectedCoreObject == u143.Selections[i] then
                    u143.Selections[i].TextColor3 = Color3_fromRGB_ret8;
                    v159 = i;
                else
                    u143.Selections[i].TextColor3 = VRService.VREnabled and Color3_fromRGB_ret7 or Color3_fromRGB_ret6;
                    v159 = i;
                end;
            end;
        end);
        ContextActionService:BindActionAtPriority(u145 .. "FreezeAction", u158, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.Keyboard, Enum.UserInputType.Gamepad1);
        ContextActionService:BindActionAtPriority(u145 .. "Action", u157, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape);
        u141:SetActive(false);
        u146.Value = false;
    end;

    u143.DropDownFrame = MakeButton("DropDownFrame", "Choose One", UDim2.new(0.6, 0, 0, 50), u160, nil, u141);
    u143.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0);
    u143.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5);
    u146 = u143.DropDownFrame.Enabled;
    local DropDownFrameTextLabel = u143.DropDownFrame.DropDownFrameTextLabel;
    DropDownFrameTextLabel.Position = UDim2.new(0, 15, 0, 0);
    DropDownFrameTextLabel.Size = UDim2.new(1, -50, 1, -8);
    DropDownFrameTextLabel.ClipsDescendants = true;
    DropDownFrameTextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    local u161 = u5.Create("ImageLabel")({
        Name = "DropDownImage",
        Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
        BackgroundTransparency = 1,
        ZIndex = 2,
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.new(0, 15, 0, 10),
        Position = UDim2.new(1, -12, 0.5, 0),
        Parent = u143.DropDownFrame
    });
    u143.DropDownImage = u161;

    local function setSelection(p162) -- Line: 727
        -- upvalues: u143 (copy), DropDownFrameTextLabel (copy), BindableEvent (copy)
        local v163 = false;

        for i, v in pairs(u143.Selections) do
            if i == p162 then
                DropDownFrameTextLabel.Text = v.Text;
                u143.CurrentIndex = i;
                v163 = true;
            end;
        end;

        if v163 then
            BindableEvent:Fire(p162);
        end;
    end;

    local function setSelectionByValue(p164) -- Line: 743
        -- upvalues: u143 (copy), DropDownFrameTextLabel (copy), BindableEvent (copy)
        local v165 = false;

        for i, v in pairs(u143.Selections) do
            if v.Text == p164 then
                DropDownFrameTextLabel.Text = v.Text;
                u143.CurrentIndex = i;
                v165 = true;
            end;
        end;

        if v165 then
            BindableEvent:Fire(u143.CurrentIndex);
        end;

        return v165;
    end;

    local u166 = false;

    local function processInput(p167) -- Line: 761
        -- upvalues: GuiService (ref), u143 (copy), u166 (ref), u160 (copy)
        if p167.UserInputState == Enum.UserInputState.Begin then
            if p167.KeyCode == Enum.KeyCode.Return and (GuiService.SelectedCoreObject == u143.DropDownFrame or u143.SelectionInfo and u143.SelectionInfo[GuiService.SelectedCoreObject]) then
                u166 = true;
            end;
        elseif p167.UserInputState == Enum.UserInputState.End and (p167.KeyCode == Enum.KeyCode.Return and u166) then
            u166 = false;

            if GuiService.SelectedCoreObject == u143.DropDownFrame then
                u160();

                return;
            end;

            if u143.SelectionInfo and u143.SelectionInfo[GuiService.SelectedCoreObject] then
                u143.SelectionInfo[GuiService.SelectedCoreObject].Clicked();
            end;
        end;
    end;

    local function setIsFaded(p168) -- Line: 781
        -- upvalues: u143 (copy)
        if p168 then
            u143.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5;
            u143.DropDownFrame.ImageTransparency = 0.5;
            u143.DropDownImage.ImageTransparency = 0.5;

            return;
        end;

        u143.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
        u143.DropDownFrame.ImageTransparency = 0;
        u143.DropDownImage.ImageTransparency = 0;
    end;

    u143.IndexChanged = BindableEvent.Event;

    function u143.SetSelectionIndex(p169, p170) -- Line: 797
        -- upvalues: setSelection (copy)
        setSelection(p170);
    end;

    function u143.SetSelectionByValue(p171, p172) -- Line: 801
        -- upvalues: setSelectionByValue (copy)
        return setSelectionByValue(p172);
    end;

    function u143.ResetSelectionIndex(p173) -- Line: 805
        -- upvalues: u143 (copy), DropDownFrameTextLabel (copy), u157 (copy)
        u143.CurrentIndex = nil;
        DropDownFrameTextLabel.Text = "Choose One";
        u157();
    end;

    function u143.GetSelectedIndex(p174) -- Line: 811
        -- upvalues: u143 (copy)
        return u143.CurrentIndex;
    end;

    function u143.SetZIndex(p175, p176) -- Line: 815
        -- upvalues: u143 (copy), u161 (copy), DropDownFrameTextLabel (copy)
        u143.DropDownFrame.ZIndex = p176;
        u161.ZIndex = p176;
        DropDownFrameTextLabel.ZIndex = p176;
    end;

    function u143.SetInteractable(p177, p178) -- Line: 821
        -- upvalues: u144 (ref), u143 (copy), u157 (copy), VRService (ref), u146 (ref), u153 (ref)
        u144 = p178;
        u143.DropDownFrame.Selectable = u144;

        if u144 then
            u143.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
            u143.DropDownFrame.ImageTransparency = 0;
            u143.DropDownImage.ImageTransparency = 0;

            if not VRService.VREnabled then
                u143:SetZIndex(2);
            end;
        else
            u157();

            if VRService.VREnabled then
                u143.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5;
                u143.DropDownFrame.ImageTransparency = 0.5;
                u143.DropDownImage.ImageTransparency = 0.5;
            else
                u143.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
                u143.DropDownFrame.ImageTransparency = 0;
                u143.DropDownImage.ImageTransparency = 0;
            end;

            if not VRService.VREnabled then
                u143:SetZIndex(1);
            end;
        end;

        if p178 then
            p178 = not u153;
        end;

        u146.Value = p178;
    end;

    function u143.UpdateDropDownList(p179, p180) -- Line: 842
        -- upvalues: u147 (ref), u143 (copy), VRService (ref), u5 (ref), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret6 (copy), u151 (copy), u140 (copy), DropDownFrameTextLabel (copy), Color3_fromRGB_ret8 (copy), u157 (copy), BindableEvent (copy), UserInputService (ref), GuiService (ref), u145 (copy), u148 (copy), u150 (copy)
        u147 = p180;

        if u143.Selections then
            for i = 1, #u143.Selections do
                u143.Selections[i]:Destroy();
                local _ = i;
            end;
        end;

        u143.Selections = {};
        u143.SelectionInfo = {};
        local VREnabled = VRService.VREnabled;
        local v181 = VREnabled and Enum.Font.SourceSansBold or Enum.Font.SourceSans;
        local v182 = VREnabled and 70 or 50;
        local v183 = v182 + 1;
        local v184 = VREnabled and 36 or 24;
        local u185 = VREnabled and 600 or 400;

        for i, v in pairs(p180) do
            local v186 = u5.Create("Frame")({
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0)
            });
            local u187 = u5.Create("TextButton")({
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ZIndex = 10,
                Name = "Selection" .. tostring(i),
                Size = UDim2.new(1, -28, 0, v182),
                Position = UDim2.new(0, 14, 0, (i - 1) * v183),
                TextColor3 = VRService.VREnabled and Color3_fromRGB_ret7 or Color3_fromRGB_ret6,
                Font = v181,
                TextSize = v184,
                Text = v,
                SelectionImageObject = v186,
                Parent = u151
            });

            if i == u140 then
                u143.CurrentIndex = i;
                DropDownFrameTextLabel.Text = v;
                u187.TextColor3 = Color3_fromRGB_ret8;
            elseif not u140 and i == 1 then
                u187.TextColor3 = Color3_fromRGB_ret8;
            end;

            local function v188() -- Line: 896
                -- upvalues: DropDownFrameTextLabel (ref), u187 (copy), u157 (ref), u143 (ref), i (copy), BindableEvent (ref)
                DropDownFrameTextLabel.Text = u187.Text;
                u157();
                u143.CurrentIndex = i;
                BindableEvent:Fire(i);
            end;

            u187.MouseButton1Click:Connect(v188);
            u187.MouseEnter:Connect(function() -- Line: 905
                -- upvalues: VRService (ref), UserInputService (ref), GuiService (ref), u187 (copy)
                local v189;

                if VRService.VREnabled then
                    v189 = false;
                else
                    v189 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
                end;

                if v189 then
                    GuiService.SelectedCoreObject = u187;
                end;
            end);
            u143.Selections[i] = u187;
            u143.SelectionInfo[u187] = {
                Clicked = v188
            };
        end;

        GuiService:RemoveSelectionGroup(u145);
        GuiService:AddSelectionTuple(u145, unpack(u143.Selections));
        u151.CanvasSize = UDim2.new(1, -20, 0, #p180 * v183);

        local function updateDropDownSize() -- Line: 920
            -- upvalues: u151 (ref), u148 (ref), u150 (ref), u185 (copy)
            if u151.CanvasSize.Y.Offset < u148.AbsoluteSize.Y - 10 then
                u150.Size = UDim2.new(0, u185, 0, u151.CanvasSize.Y.Offset + 25);

                return;
            end;

            u150.Size = UDim2.new(0, u185, 0.9, 0);
        end;

        u148.Changed:Connect(function(p190) -- Line: 929
            -- upvalues: updateDropDownSize (copy)
            if p190 ~= "AbsoluteSize" then
                return;
            end;

            updateDropDownSize();
        end);
        updateDropDownSize();
    end;

    u143:UpdateDropDownList(p139);
    u148.MouseButton1Click:Connect(u157);
    u141.PoppedMenu:Connect(function(p191) -- Line: 942
        -- upvalues: u148 (copy), u157 (copy)
        if p191 == u148 then
            u157();
        end;
    end);

    return u143;
end;

local function CreateSelector(p192, u193) -- Line: 952
    -- upvalues: u5 (copy), u7 (copy), Color3_fromRGB_ret3 (copy), UserInputService (copy), Color3_fromRGB_ret4 (copy), addHoverState (copy), VRService (copy), GuiService (copy), EaseOutQuad (copy), Color3_fromRGB_ret5 (copy), u6 (copy), getViewportSize (copy)
    local u194 = 0;
    local u195 = {
        HubRef = nil
    };

    if type(p192) ~= "table" then
        error("CreateSelector selectionStringTable (first arg) is not a table", 2);

        return u195;
    end;

    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Name = "IndexChanged";
    local u196 = true;
    u195.CurrentIndex = 0;
    u195.SelectorFrame = u5.Create("ImageButton")({
        Name = "Selector",
        Image = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        NextSelectionLeft = u195.SelectorFrame,
        NextSelectionRight = u195.SelectorFrame,
        Size = UDim2.new(0.6, 0, 0, 50),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        SelectionImageObject = u7
    });
    local u197 = u5.Create("ImageButton")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u7,
        Parent = u195.SelectorFrame
    });
    local u198 = u5.Create("ImageButton")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u7,
        Parent = u195.SelectorFrame
    });
    local u199 = u5.Create("ImageLabel")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Left.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        ImageColor3 = Color3_fromRGB_ret3,
        Parent = u197
    });
    local u200 = u5.Create("ImageLabel")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Right.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        ImageColor3 = Color3_fromRGB_ret3,
        Parent = u198
    });

    if not UserInputService.TouchEnabled then
        local function v202(p201) -- Line: 1043
            -- upvalues: Color3_fromRGB_ret3 (ref)
            p201.ImageColor3 = Color3_fromRGB_ret3;
        end;

        local function v204(p203) -- Line: 1044
            -- upvalues: Color3_fromRGB_ret4 (ref)
            p203.ImageColor3 = Color3_fromRGB_ret4;
        end;

        addHoverState(u197, u199, v202, v204);
        addHoverState(u198, u200, v202, v204);
    end;

    u195.Selections = {};
    local u205 = {};
    local u206 = {};
    local u207 = u5.Create("ImageButton")({
        Name = "AutoSelectButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 2,
        Position = UDim2.new(0, u197.Size.X.Offset, 0, 0),
        Size = UDim2.new(1, u197.Size.X.Offset * -2, 1, 0),
        Parent = u195.SelectorFrame,
        SelectionImageObject = u7
    });
    u207.MouseButton1Click:Connect(function() -- Line: 1064
        -- upvalues: u196 (ref), u195 (copy), VRService (ref), UserInputService (ref), GuiService (ref)
        if not u196 then
            return;
        end;

        if #u195.Selections <= 1 then
            return;
        end;

        local v208 = u195.CurrentIndex + 1;
        u195:SetSelectionIndex(#u195.Selections < v208 and 1 or v208);
        local v209;

        if VRService.VREnabled then
            v209 = false;
        else
            v209 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
        end;

        if v209 then
            GuiService.SelectedCoreObject = u195.SelectorFrame;
        end;
    end);
    u206[u207] = true;

    local function u212(p210, p211) -- Line: 1079
        -- upvalues: u195 (copy), u197 (copy), u205 (ref), EaseOutQuad (ref), BindableEvent (copy)
        for i, v in pairs(u195.Selections) do
            local UDim2_new_ret = UDim2.new(0, u197.Size.X.Offset, 0, 0);
            local UDim2_new_ret2 = UDim2.new(0, u197.Size.X.Offset * p211 * 3, 0, 0);

            if u205[v] then
                UDim2_new_ret2 = UDim2.new(0, u197.Size.X.Offset * -p211 * 3, 0, 0);
            end;

            if UDim2_new_ret2.X.Offset < 0 then
                UDim2_new_ret2 = UDim2.new(0, UDim2_new_ret2.X.Offset + v.AbsoluteSize.X / 4, 0, 0);
            end;

            if i == p210 then
                u205[v] = true;
                v.Position = UDim2_new_ret2;
                v.Visible = true;
                PropertyTweener(v, "TextTransparency", 1, 0, 0.165, EaseOutQuad);

                if v:IsDescendantOf(game) then
                    v:TweenPosition(UDim2_new_ret, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true);
                else
                    v.Position = UDim2_new_ret;
                end;

                u195.CurrentIndex = i;
                BindableEvent:Fire(p210);
            elseif u205[v] then
                u205[v] = false;
                PropertyTweener(v, "TextTransparency", 0, 1, 0.165, EaseOutQuad);

                if v:IsDescendantOf(game) then
                    v:TweenPosition(UDim2_new_ret2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.135, true);
                else
                    v.Position = UDim2.new(UDim2_new_ret2);
                end;
            end;
        end;
    end;

    local function stepFunc(p213, p214) -- Line: 1118
        -- upvalues: u196 (ref), VRService (ref), UserInputService (ref), GuiService (ref), u195 (copy), u212 (copy)
        if not u196 then
            return;
        end;

        if p213 ~= nil and (p213.UserInputType ~= Enum.UserInputType.MouseButton1 and (p213.UserInputType ~= Enum.UserInputType.Gamepad1 and (p213.UserInputType ~= Enum.UserInputType.Gamepad2 and (p213.UserInputType ~= Enum.UserInputType.Gamepad3 and (p213.UserInputType ~= Enum.UserInputType.Gamepad4 and p213.UserInputType ~= Enum.UserInputType.Keyboard))))) then
            return;
        end;

        local v215;

        if VRService.VREnabled then
            v215 = false;
        else
            v215 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
        end;

        if v215 then
            GuiService.SelectedCoreObject = u195.SelectorFrame;
        end;

        local v216 = p214 + u195.CurrentIndex;
        u212(#u195.Selections < v216 and 1 or (v216 < 1 and #u195.Selections or v216), u195.CurrentIndex < v216 and 1 or -1);
    end;

    local u217 = nil;

    local function connectToGuiService() -- Line: 1149
        -- upvalues: u217 (ref), GuiService (ref), u195 (copy), u206 (copy), VRService (ref)
        u217 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- Line: 1150
            -- upvalues: u195 (ref), GuiService (ref), u206 (ref), VRService (ref)
            if #u195.Selections <= 0 then
                return;
            end;

            if GuiService.SelectedCoreObject == u195.SelectorFrame then
                u195.Selections[u195.CurrentIndex].TextTransparency = 0;

                return;
            end;

            if GuiService.SelectedCoreObject == nil or not u206[GuiService.SelectedCoreObject] then
                u195.Selections[u195.CurrentIndex].TextTransparency = 0.5;

                return;
            end;

            if VRService.VREnabled then
                u195.Selections[u195.CurrentIndex].TextTransparency = 0;

                return;
            end;

            GuiService.SelectedCoreObject = u195.SelectorFrame;
        end);
    end;

    u195.IndexChanged = BindableEvent.Event;

    function u195.SetSelectionIndex(p218, p219) -- Line: 1174
        -- upvalues: u212 (copy)
        u212(p219, 1);
    end;

    function u195.GetSelectedIndex(p220) -- Line: 1178
        -- upvalues: u195 (copy)
        return u195.CurrentIndex;
    end;

    function u195.SetZIndex(p221, p222) -- Line: 1182
        -- upvalues: u197 (copy), u198 (copy), u199 (copy), u200 (copy), u195 (copy)
        u197.ZIndex = p222;
        u198.ZIndex = p222;
        u199.ZIndex = p222;
        u200.ZIndex = p222;

        for i = 1, #u195.Selections do
            u195.Selections[i].ZIndex = p222;
            local _ = i;
        end;
    end;

    function u195.SetInteractable(p223, p224) -- Line: 1193
        -- upvalues: u196 (ref), u195 (copy), u197 (copy), u198 (copy), u199 (copy), Color3_fromRGB_ret5 (ref), u200 (copy), Color3_fromRGB_ret3 (ref)
        u196 = p224;
        u195.SelectorFrame.Selectable = u196;
        u197.Active = u196;
        u198.Active = u196;

        if u196 then
            for _, v in pairs(u195.Selections) do
                v.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;

            u199.ImageColor3 = Color3_fromRGB_ret3;
            u200.ImageColor3 = Color3_fromRGB_ret3;

            return;
        end;

        for _, v in pairs(u195.Selections) do
            v.TextColor3 = Color3.fromRGB(49, 49, 49);
        end;

        u199.ImageColor3 = Color3_fromRGB_ret5;
        u200.ImageColor3 = Color3_fromRGB_ret5;
    end;

    function u195.UpdateOptions(p225, p226) -- Line: 1215
        -- upvalues: u195 (copy), u205 (ref), u5 (ref), u197 (copy), u193 (copy), u198 (copy)
        for _, v in pairs(u195.Selections) do
            v:Destroy();
        end;

        u205 = {};
        u195.Selections = {};

        for i, v in pairs(p226) do
            local v227 = u5.Create("TextLabel")({
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                TextTransparency = 0.5,
                TextSize = 24,
                ZIndex = 2,
                Visible = false,
                Name = "Selection" .. tostring(i),
                Size = UDim2.new(1, u197.Size.X.Offset * -2, 1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextYAlignment = Enum.TextYAlignment.Center,
                Font = Enum.Font.SourceSans,
                Text = v,
                Parent = u195.SelectorFrame
            });

            if false then
                v227.TextSize = 36;
            end;

            if i == u193 then
                u195.CurrentIndex = i;
                v227.Position = UDim2.new(0, u197.Size.X.Offset, 0, 0);
                v227.Visible = true;
                u205[v227] = true;
            else
                u205[v227] = false;
            end;

            u195.Selections[i] = v227;
        end;

        local v228 = #u195.Selections > 1;
        u197.Visible = v228;
        u198.Visible = v228;
    end;

    VRService.Changed:Connect(function(p229) -- Line: 1264, Name: onVREnabled
        -- upvalues: VRService (ref), u197 (copy), u198 (copy), u207 (copy)
        if p229 ~= "VREnabled" then
            return;
        end;

        local VREnabled = VRService.VREnabled;
        u197.Selectable = VREnabled;
        u198.Selectable = VREnabled;
        u207.Selectable = VREnabled;
    end);
    local VREnabled = VRService.VREnabled;
    u197.Selectable = VREnabled;
    u198.Selectable = VREnabled;
    u207.Selectable = VREnabled;
    u197.InputBegan:Connect(function(p230) -- Line: 1276
        -- upvalues: u196 (ref), VRService (ref), UserInputService (ref), GuiService (ref), u195 (copy), u212 (copy)
        if p230.UserInputType == Enum.UserInputType.Touch then
            if not u196 then
                return;
            end;

            local v231;

            if VRService.VREnabled then
                v231 = false;
            else
                v231 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v231 then
                GuiService.SelectedCoreObject = u195.SelectorFrame;
            end;

            local v232 = -1 + u195.CurrentIndex;
            u212(#u195.Selections < v232 and 1 or (v232 < 1 and #u195.Selections or v232), u195.CurrentIndex < v232 and 1 or -1);
        end;
    end);
    u197.MouseButton1Click:Connect(function() -- Line: 1281
        -- upvalues: UserInputService (ref), u196 (ref), VRService (ref), GuiService (ref), u195 (copy), u212 (copy)
        if not UserInputService.TouchEnabled then
            if not u196 then
                return;
            end;

            local v233;

            if VRService.VREnabled then
                v233 = false;
            else
                v233 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v233 then
                GuiService.SelectedCoreObject = u195.SelectorFrame;
            end;

            local v234 = -1 + u195.CurrentIndex;
            u212(#u195.Selections < v234 and 1 or (v234 < 1 and #u195.Selections or v234), u195.CurrentIndex < v234 and 1 or -1);
        end;
    end);
    u198.InputBegan:Connect(function(p235) -- Line: 1286
        -- upvalues: u196 (ref), VRService (ref), UserInputService (ref), GuiService (ref), u195 (copy), u212 (copy)
        if p235.UserInputType == Enum.UserInputType.Touch then
            if not u196 then
                return;
            end;

            local v236;

            if VRService.VREnabled then
                v236 = false;
            else
                v236 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v236 then
                GuiService.SelectedCoreObject = u195.SelectorFrame;
            end;

            local v237 = 1 + u195.CurrentIndex;
            u212(#u195.Selections < v237 and 1 or (v237 < 1 and #u195.Selections or v237), u195.CurrentIndex < v237 and 1 or -1);
        end;
    end);
    u198.MouseButton1Click:Connect(function() -- Line: 1291
        -- upvalues: UserInputService (ref), u196 (ref), VRService (ref), GuiService (ref), u195 (copy), u212 (copy)
        if not UserInputService.TouchEnabled then
            if not u196 then
                return;
            end;

            local v238;

            if VRService.VREnabled then
                v238 = false;
            else
                v238 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v238 then
                GuiService.SelectedCoreObject = u195.SelectorFrame;
            end;

            local v239 = 1 + u195.CurrentIndex;
            u212(#u195.Selections < v239 and 1 or (v239 < 1 and #u195.Selections or v239), u195.CurrentIndex < v239 and 1 or -1);
        end;
    end);
    local u240 = true;
    u195:UpdateOptions(p192);
    UserInputService.InputBegan:Connect(function(p241) -- Line: 1300
        -- upvalues: u196 (ref), u240 (ref), GuiService (ref), u195 (copy), VRService (ref), UserInputService (ref), u212 (copy)
        if not u196 then
            return;
        end;

        if not u240 then
            return;
        end;

        if p241.UserInputType ~= Enum.UserInputType.Gamepad1 and p241.UserInputType ~= Enum.UserInputType.Keyboard then
            return;
        end;

        if GuiService.SelectedCoreObject ~= u195.SelectorFrame then
            return;
        end;

        if p241.KeyCode ~= Enum.KeyCode.DPadLeft and (p241.KeyCode ~= Enum.KeyCode.Left and p241.KeyCode ~= Enum.KeyCode.A) then
            if p241.KeyCode == Enum.KeyCode.DPadRight or (p241.KeyCode == Enum.KeyCode.Right or p241.KeyCode == Enum.KeyCode.D) then
                if not u196 then
                    return;
                end;

                if p241 ~= nil and (p241.UserInputType ~= Enum.UserInputType.MouseButton1 and (p241.UserInputType ~= Enum.UserInputType.Gamepad1 and (p241.UserInputType ~= Enum.UserInputType.Gamepad2 and (p241.UserInputType ~= Enum.UserInputType.Gamepad3 and (p241.UserInputType ~= Enum.UserInputType.Gamepad4 and p241.UserInputType ~= Enum.UserInputType.Keyboard))))) then
                    return;
                end;

                local v242;

                if VRService.VREnabled then
                    v242 = false;
                else
                    v242 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
                end;

                if v242 then
                    GuiService.SelectedCoreObject = u195.SelectorFrame;
                end;

                local v243 = 1 + u195.CurrentIndex;
                u212(#u195.Selections < v243 and 1 or (v243 < 1 and #u195.Selections or v243), u195.CurrentIndex < v243 and 1 or -1);
            end;

            return;
        end;

        if not u196 then
            return;
        end;

        if p241 ~= nil and (p241.UserInputType ~= Enum.UserInputType.MouseButton1 and (p241.UserInputType ~= Enum.UserInputType.Gamepad1 and (p241.UserInputType ~= Enum.UserInputType.Gamepad2 and (p241.UserInputType ~= Enum.UserInputType.Gamepad3 and (p241.UserInputType ~= Enum.UserInputType.Gamepad4 and p241.UserInputType ~= Enum.UserInputType.Keyboard))))) then
            return;
        end;

        local v244;

        if VRService.VREnabled then
            v244 = false;
        else
            v244 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
        end;

        if v244 then
            GuiService.SelectedCoreObject = u195.SelectorFrame;
        end;

        local v245 = -1 + u195.CurrentIndex;
        u212(#u195.Selections < v245 and 1 or (v245 < 1 and #u195.Selections or v245), u195.CurrentIndex < v245 and 1 or -1);
    end);
    UserInputService.InputChanged:Connect(function(p246) -- Line: 1314
        -- upvalues: u196 (ref), u240 (ref), u194 (ref), GuiService (ref), u195 (copy), stepFunc (copy)
        if not u196 then
            return;
        end;

        if not u240 then
            u194 = 0;

            return;
        end;

        if p246.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return;
        end;

        local SelectedCoreObject = GuiService.SelectedCoreObject;

        if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u195.SelectorFrame.Parent)) then
            return;
        end;

        if p246.KeyCode ~= Enum.KeyCode.Thumbstick1 then
            return;
        end;

        if p246.Position.X > 0.8 and (p246.Delta.X > 0 and u194 ~= 1) then
            u194 = 1;
            stepFunc(p246, u194);

            return;
        end;

        if p246.Position.X >= -0.8 or (p246.Delta.X >= 0 or u194 == -1) then
            if math.abs(p246.Position.X) < 0.8 then
                u194 = 0;
            end;

            return;
        end;

        u194 = -1;
        stepFunc(p246, u194);
    end);
    u195.SelectorFrame.AncestryChanged:Connect(function(p247, p248) -- Line: 1337
        -- upvalues: u240 (ref), u217 (ref), GuiService (ref), u195 (copy), u206 (copy), VRService (ref)
        u240 = p248;

        if u240 then
            u217 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- Line: 1150
                -- upvalues: u195 (ref), GuiService (ref), u206 (ref), VRService (ref)
                if #u195.Selections <= 0 then
                    return;
                end;

                if GuiService.SelectedCoreObject == u195.SelectorFrame then
                    u195.Selections[u195.CurrentIndex].TextTransparency = 0;

                    return;
                end;

                if GuiService.SelectedCoreObject == nil or not u206[GuiService.SelectedCoreObject] then
                    u195.Selections[u195.CurrentIndex].TextTransparency = 0.5;

                    return;
                end;

                if VRService.VREnabled then
                    u195.Selections[u195.CurrentIndex].TextTransparency = 0;

                    return;
                end;

                GuiService.SelectedCoreObject = u195.SelectorFrame;
            end);
        elseif u217 then
            u217:Disconnect();
        end;
    end);

    u6[u195.SelectorFrame] = function(p249, p250) -- Line: 1346, Name: onResized
        -- upvalues: u195 (copy)
        local v251 = p250 and 16 or 24;

        for _, v in pairs(u195.Selections) do
            v.TextSize = v251;
        end;
    end;

    getViewportSize();
    local v252 = getViewportSize();
    local v253 = v252.Y > v252.X and 16 or 24;

    for _, v in pairs(u195.Selections) do
        v.TextSize = v253;
    end;

    u217 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- Line: 1150
        -- upvalues: u195 (copy), GuiService (ref), u206 (copy), VRService (ref)
        if #u195.Selections <= 0 then
            return;
        end;

        if GuiService.SelectedCoreObject == u195.SelectorFrame then
            u195.Selections[u195.CurrentIndex].TextTransparency = 0;

            return;
        end;

        if GuiService.SelectedCoreObject == nil or not u206[GuiService.SelectedCoreObject] then
            u195.Selections[u195.CurrentIndex].TextTransparency = 0.5;

            return;
        end;

        if VRService.VREnabled then
            u195.Selections[u195.CurrentIndex].TextTransparency = 0;

            return;
        end;

        GuiService.SelectedCoreObject = u195.SelectorFrame;
    end);

    return u195;
end;

local function ShowAlert(p254, p255, u256, u257, p258) -- Line: 1365
    -- upvalues: PlayerGui (copy), VRService (copy), u5 (copy), HttpService (copy), ContextActionService (copy), GuiService (copy), MakeButton (copy), UserInputService (copy)
    local RobloxGui = PlayerGui.RobloxGui;

    if RobloxGui:FindFirstChild("AlertViewFullScreen") then
        return;
    end;

    local u259 = nil;

    local function v262(p260) -- Line: 1374
        -- upvalues: VRService (ref), PlayerGui (ref), RobloxGui (ref), u259 (ref)
        if p260 ~= "VREnabled" then
            return;
        end;

        local v261 = nil;

        if VRService.VREnabled then
            v261 = require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu");
            RobloxGui = v261:GetGUI();
        else
            RobloxGui = PlayerGui.RobloxGui;
        end;

        if u259 and u259.Parent ~= nil then
            u259.Parent = RobloxGui;

            if VRService.VREnabled then
                v261:SetSubpanelDepth(u259, 0.5);
            end;
        end;
    end;

    local u263 = VRService.Changed:Connect(v262);
    Color3.fromRGB(59, 166, 241);
    Color3.fromRGB(255, 255, 255);
    u259 = u5.Create("ImageLabel")({
        Name = "AlertViewBacking",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        ZIndex = 9,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = UDim2.new(0, 400, 0, 350),
        Position = UDim2.new(0.5, -200, 0.5, -175),
        Parent = RobloxGui
    });
    v262("VREnabled");

    if p258 or VRService.VREnabled then
        u259.ImageTransparency = 0;
    else
        u259.Size = UDim2.new(0.8, 0, 0, 350);
        u259.Position = UDim2.new(0.1, 0, 0.1, 0);
    end;

    if PlayerGui.RobloxGui.AbsoluteSize.Y <= u259.Size.Y.Offset then
        u259.Size = UDim2.new(u259.Size.X.Scale, u259.Size.X.Offset, u259.Size.Y.Scale, PlayerGui.RobloxGui.AbsoluteSize.Y);
        u259.Position = UDim2.new(u259.Position.X.Scale, -u259.Size.X.Offset / 2, 0.5, -u259.Size.Y.Offset / 2);
    end;

    u5.Create("TextLabel")({
        Name = "AlertViewText",
        BackgroundTransparency = 1,
        TextSize = 36,
        TextWrapped = true,
        ZIndex = 10,
        Size = UDim2.new(0.95, 0, 0.6, 0),
        Position = UDim2.new(0.025, 0, 0.05, 0),
        Font = Enum.Font.SourceSansBold,
        Text = p254,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = u259
    });
    u5.Create("ImageLabel")({
        Image = "",
        BackgroundTransparency = 1
    });
    local u264 = HttpService:GenerateGUID(false);

    local function v267(p265, p266) -- Line: 1449
        -- upvalues: VRService (ref), u259 (ref), PlayerGui (ref), u257 (copy), ContextActionService (ref), u264 (copy), GuiService (ref), u256 (copy), u263 (copy)
        if VRService.VREnabled and (p266 == Enum.UserInputState.Begin or p266 == Enum.UserInputState.Cancel) then
            return;
        end;

        if not u259 then
            return;
        end;

        if VRService.VREnabled then
            require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(u259, 0);
        end;

        u259:Destroy();
        u259 = nil;

        if u257 then
            u257();
        end;

        ContextActionService:UnbindAction(u264);
        GuiService.SelectedCoreObject = nil;

        if u256 then
            u256:ShowBar();
        end;

        if u263 then
            u263:Disconnect();
        end;
    end;

    local UDim2_new_ret = UDim2.new(1, -20, 0, 60);
    local UDim2_new_ret2 = UDim2.new(0, 10, 0.65, 0);

    if not p258 then
        UDim2_new_ret = UDim2.new(0, 200, 0, 50);
        UDim2_new_ret2 = UDim2.new(0.5, -100, 0.65, 0);
    end;

    local v268, v269 = MakeButton("AlertViewButton", p255, UDim2_new_ret, v267);
    v268.Position = UDim2_new_ret2;
    v268.NextSelectionLeft = v268;
    v268.NextSelectionRight = v268;
    v268.NextSelectionUp = v268;
    v268.NextSelectionDown = v268;
    v268.ZIndex = 9;
    v269.ZIndex = v268.ZIndex;
    v268.Parent = u259;
    local v270;

    if VRService.VREnabled then
        v270 = false;
    else
        v270 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
    end;

    if v270 then
        GuiService.SelectedCoreObject = v268;
    end;

    GuiService.SelectedCoreObject = v268;
    ContextActionService:BindActionAtPriority(u264, v267, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA);

    if u256 and not VRService.VREnabled then
        u256:HideBar();
        u256.Pages.CurrentPage:Hide(1, 1);
    end;
end;

local function CreateNewSlider(p271, p272, u273) -- Line: 1506
    -- upvalues: HttpService (copy), u5 (copy), u7 (copy), UserInputService (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), addHoverState (copy), getViewportSize (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), VRService (copy), GuiService (copy), RunService (copy)
    local u274 = {};
    local u275 = tonumber(p271);
    local u276 = p272;
    local u277 = 0;
    local u278 = nil;
    local u279 = true;
    local u280 = HttpService:GenerateGUID(false);

    if u275 > 0 then
        local BindableEvent = Instance.new("BindableEvent");
        BindableEvent.Name = "ValueChanged";
        u274.SliderFrame = u5.Create("ImageButton")({
            Name = "Slider",
            Image = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            ZIndex = 2,
            NextSelectionLeft = u274.SliderFrame,
            NextSelectionRight = u274.SliderFrame,
            Size = UDim2.new(0.6, 0, 0, 50),
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            SelectionImageObject = u7
        });
        u274.StepsContainer = u5.Create("Frame")({
            Name = "StepsContainer",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, -100, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Parent = u274.SliderFrame
        });
        local u281 = u5.Create("ImageButton")({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            Active = true,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = u7,
            Parent = u274.SliderFrame
        });
        local u282 = u5.Create("ImageButton")({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            Active = true,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = u7,
            Parent = u274.SliderFrame
        });
        local u283 = u5.Create("ImageLabel")({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/Less.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30),
            Parent = u281,
            ImageColor3 = UserInputService.TouchEnabled and Color3_fromRGB_ret4 or Color3_fromRGB_ret3
        });
        local u284 = u5.Create("ImageLabel")({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/More.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30),
            Parent = u282,
            ImageColor3 = UserInputService.TouchEnabled and Color3_fromRGB_ret4 or Color3_fromRGB_ret3
        });

        if not UserInputService.TouchEnabled then
            local function v286(p285) -- Line: 1615
                -- upvalues: Color3_fromRGB_ret3 (ref)
                p285.ImageColor3 = Color3_fromRGB_ret3;
            end;

            local function v288(p287) -- Line: 1616
                -- upvalues: Color3_fromRGB_ret4 (ref)
                p287.ImageColor3 = Color3_fromRGB_ret4;
            end;

            addHoverState(u281, u283, v286, v288);
            addHoverState(u282, u284, v286, v288);
        end;

        u274.Steps = {};
        local v289 = getViewportSize();
        local _ = UserInputService.TouchEnabled and (v289.Y < 500 and true or v289.X < 700);
        local v290 = 1 / u275;

        for i = 1, u275 do
            local v291 = u5.Create("ImageButton")({
                BackgroundTransparency = 0.36,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Active = false,
                Image = "",
                ZIndex = 3,
                Selectable = false,
                ImageTransparency = 0.36,
                Name = "Step" .. tostring(i),
                BackgroundColor3 = Color3_fromRGB_ret,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new((i - 1) * v290, 2, 0.5, 0),
                Size = UDim2.new(v290, -4, 0.48, 0),
                Parent = u274.StepsContainer,
                SelectionImageObject = u7
            });

            if u276 < i then
                v291.BackgroundColor3 = Color3_fromRGB_ret2;
            end;

            if i == 1 or i == u275 then
                v291.BackgroundTransparency = 1;
                v291.ScaleType = Enum.ScaleType.Slice;
                v291.SliceCenter = Rect.new(3, 3, 32, 21);

                if i <= u276 then
                    if i == 1 then
                        v291.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png";
                    else
                        v291.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png";
                    end;
                elseif i == 1 then
                    v291.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png";
                else
                    v291.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png";
                end;
            end;

            u274.Steps[#u274.Steps + 1] = v291;
            local _ = i;
        end;

        local function hideSelection() -- Line: 1680
            -- upvalues: u275 (copy), u274 (copy), Color3_fromRGB_ret2 (ref)
            for i = 1, u275 do
                u274.Steps[i].BackgroundColor3 = Color3_fromRGB_ret2;
                local v292;

                if i == 1 then
                    u274.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png";
                    v292 = i;
                elseif i == u275 then
                    u274.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png";
                    v292 = i;
                else
                    v292 = i;
                end;
            end;
        end;

        local function showSelection() -- Line: 1690
            -- upvalues: u275 (copy), u276 (ref), u274 (copy), Color3_fromRGB_ret (ref)
            for i = 1, u275 do
                if u276 < i then
                    break;
                end;

                u274.Steps[i].BackgroundColor3 = Color3_fromRGB_ret;
                local v293;

                if i == 1 then
                    u274.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png";
                    v293 = i;
                elseif i == u275 then
                    u274.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png";
                    v293 = i;
                else
                    v293 = i;
                end;
            end;
        end;

        local function setCurrentStep(p294) -- Line: 1711
            -- upvalues: u273 (ref), u281 (copy), u282 (copy), u275 (copy), u276 (ref), hideSelection (copy), showSelection (copy), u278 (ref), BindableEvent (copy)
            if not u273 then
                u273 = 0;
            end;

            u281.Visible = true;
            u282.Visible = true;

            if p294 <= u273 then
                p294 = u273;
                u281.Visible = false;
            end;

            if u275 <= p294 then
                p294 = u275;
                u282.Visible = false;
            end;

            if u276 == p294 then
                return;
            end;

            u276 = p294;
            hideSelection();
            showSelection();
            u278 = tick();
            BindableEvent:Fire(u276);
        end;

        local function isActivateEvent(p295) -- Line: 1737
            if not p295 then
                return false;
            end;

            local v296;

            if p295.UserInputType == Enum.UserInputType.MouseButton1 or p295.UserInputType == Enum.UserInputType.Touch then
                v296 = true;
            elseif p295.UserInputType == Enum.UserInputType.Gamepad1 then
                v296 = p295.KeyCode == Enum.KeyCode.ButtonA;
            else
                v296 = false;
            end;

            return v296;
        end;

        local function mouseDownFunc(p297, p298, p299) -- Line: 1741
            -- upvalues: u279 (ref), VRService (ref), UserInputService (ref), GuiService (ref), u274 (copy), u277 (ref), u276 (ref), u275 (copy), setCurrentStep (copy)
            if not u279 then
                return;
            end;

            if p297 == nil then
                return;
            end;

            local v300;

            if p297 then
                if p297.UserInputType == Enum.UserInputType.MouseButton1 or p297.UserInputType == Enum.UserInputType.Touch then
                    v300 = true;
                elseif p297.UserInputType == Enum.UserInputType.Gamepad1 then
                    v300 = p297.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v300 = false;
                end;
            else
                v300 = false;
            end;

            if not v300 then
                return;
            end;

            local v301;

            if VRService.VREnabled then
                v301 = false;
            else
                v301 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v301 and not VRService.VREnabled then
                GuiService.SelectedCoreObject = u274.SliderFrame;
            end;

            if VRService.VREnabled then
                u277 = 0;
            elseif p299 then
                u277 = p298 - u276;
            else
                u277 = 0;
                local u302 = nil;
                local u304 = UserInputService.InputChanged:Connect(function(p303) -- Line: 1761
                    -- upvalues: u275 (ref), u274 (ref), setCurrentStep (ref)
                    if p303.UserInputType ~= Enum.UserInputType.MouseMovement then
                        return;
                    end;

                    local X = p303.Position.X;

                    for i = 1, u275 do
                        local X2 = u274.Steps[i].AbsolutePosition.X;

                        if X2 <= X and X <= X2 + u274.Steps[i].AbsoluteSize.X then
                            setCurrentStep(i);

                            return;
                        end;

                        if i == 1 and X < X2 then
                            setCurrentStep(0);

                            return;
                        end;

                        if i == u275 and X2 <= X then
                            setCurrentStep(i);

                            return;
                        end;

                        local _ = i;
                    end;
                end);
                u302 = UserInputService.InputEnded:Connect(function(p305) -- Line: 1780
                    -- upvalues: u277 (ref), u302 (ref), u304 (ref)
                    local v306;

                    if p305 then
                        if p305.UserInputType == Enum.UserInputType.MouseButton1 or p305.UserInputType == Enum.UserInputType.Touch then
                            v306 = true;
                        elseif p305.UserInputType == Enum.UserInputType.Gamepad1 then
                            v306 = p305.KeyCode == Enum.KeyCode.ButtonA;
                        else
                            v306 = false;
                        end;
                    else
                        v306 = false;
                    end;

                    if not v306 then
                        return;
                    end;

                    u277 = 0;
                    u302:Disconnect();
                    u304:Disconnect();
                end);
            end;

            setCurrentStep(p298);
        end;

        local function mouseUpFunc(p307) -- Line: 1795
            -- upvalues: u279 (ref), u277 (ref)
            if not u279 then
                return;
            end;

            local v308;

            if p307 then
                if p307.UserInputType == Enum.UserInputType.MouseButton1 or p307.UserInputType == Enum.UserInputType.Touch then
                    v308 = true;
                elseif p307.UserInputType == Enum.UserInputType.Gamepad1 then
                    v308 = p307.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v308 = false;
                end;
            else
                v308 = false;
            end;

            if not v308 then
                return;
            end;

            u277 = 0;
        end;

        local function touchClickFunc(p309, p310, p311) -- Line: 1802
            -- upvalues: mouseDownFunc (copy)
            mouseDownFunc(p309, p310, p311);
        end;

        u274.ValueChanged = BindableEvent.Event;

        function u274.SetValue(p312, p313) -- Line: 1809
            -- upvalues: setCurrentStep (copy)
            setCurrentStep(p313);
        end;

        function u274.GetValue(p314) -- Line: 1813
            -- upvalues: u276 (ref)
            return u276;
        end;

        function u274.SetInteractable(p315, p316) -- Line: 1817
            -- upvalues: u277 (ref), u279 (ref), u274 (copy), hideSelection (copy), showSelection (copy)
            u277 = 0;
            u279 = p316;
            u274.SliderFrame.Selectable = p316;

            if u279 then
                showSelection();

                return;
            end;

            hideSelection();
        end;

        function u274.SetZIndex(p317, p318) -- Line: 1828
            -- upvalues: u281 (copy), u282 (copy), u283 (copy), u284 (copy), u274 (copy)
            u281.ZIndex = p318;
            u282.ZIndex = p318;
            u283.ZIndex = p318;
            u284.ZIndex = p318;

            for i = 1, #u274.Steps do
                u274.Steps[i].ZIndex = p318;
                local _ = i;
            end;
        end;

        function u274.SetMinStep(p319, p320) -- Line: 1839
            -- upvalues: u275 (copy), u273 (ref), u276 (ref), u281 (copy), u282 (copy)
            if p320 >= 0 and p320 <= u275 then
                u273 = p320;
            end;

            if u276 <= u273 then
                u276 = u273;
                u281.Visible = false;
            end;

            if u275 <= u276 then
                u276 = u275;
                u282.Visible = false;
            end;
        end;

        u281.InputBegan:Connect(function(p321) -- Line: 1856
            -- upvalues: u276 (ref), u279 (ref), VRService (ref), UserInputService (ref), GuiService (ref), u274 (copy), u277 (ref), setCurrentStep (copy)
            local v322 = u276 - 1;

            if not u279 then
                return;
            end;

            if p321 == nil then
                return;
            end;

            local v323;

            if p321 then
                if p321.UserInputType == Enum.UserInputType.MouseButton1 or p321.UserInputType == Enum.UserInputType.Touch then
                    v323 = true;
                elseif p321.UserInputType == Enum.UserInputType.Gamepad1 then
                    v323 = p321.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v323 = false;
                end;
            else
                v323 = false;
            end;

            if not v323 then
                return;
            end;

            local v324;

            if VRService.VREnabled then
                v324 = false;
            else
                v324 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v324 and not VRService.VREnabled then
                GuiService.SelectedCoreObject = u274.SliderFrame;
            end;

            if VRService.VREnabled then
                u277 = 0;
            else
                u277 = v322 - u276;
            end;

            setCurrentStep(v322);
        end);
        u281.InputEnded:Connect(function(p325) -- Line: 1857
            -- upvalues: u279 (ref), u277 (ref)
            if not u279 then
                return;
            end;

            local v326;

            if p325 then
                if p325.UserInputType == Enum.UserInputType.MouseButton1 or p325.UserInputType == Enum.UserInputType.Touch then
                    v326 = true;
                elseif p325.UserInputType == Enum.UserInputType.Gamepad1 then
                    v326 = p325.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v326 = false;
                end;
            else
                v326 = false;
            end;

            if not v326 then
                return;
            end;

            u277 = 0;
        end);
        u282.InputBegan:Connect(function(p327) -- Line: 1858
            -- upvalues: u276 (ref), u279 (ref), VRService (ref), UserInputService (ref), GuiService (ref), u274 (copy), u277 (ref), setCurrentStep (copy)
            local v328 = u276 + 1;

            if not u279 then
                return;
            end;

            if p327 == nil then
                return;
            end;

            local v329;

            if p327 then
                if p327.UserInputType == Enum.UserInputType.MouseButton1 or p327.UserInputType == Enum.UserInputType.Touch then
                    v329 = true;
                elseif p327.UserInputType == Enum.UserInputType.Gamepad1 then
                    v329 = p327.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v329 = false;
                end;
            else
                v329 = false;
            end;

            if not v329 then
                return;
            end;

            local v330;

            if VRService.VREnabled then
                v330 = false;
            else
                v330 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v330 and not VRService.VREnabled then
                GuiService.SelectedCoreObject = u274.SliderFrame;
            end;

            if VRService.VREnabled then
                u277 = 0;
            else
                u277 = v328 - u276;
            end;

            setCurrentStep(v328);
        end);
        u282.InputEnded:Connect(function(p331) -- Line: 1859
            -- upvalues: u279 (ref), u277 (ref)
            if not u279 then
                return;
            end;

            local v332;

            if p331 then
                if p331.UserInputType == Enum.UserInputType.MouseButton1 or p331.UserInputType == Enum.UserInputType.Touch then
                    v332 = true;
                elseif p331.UserInputType == Enum.UserInputType.Gamepad1 then
                    v332 = p331.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v332 = false;
                end;
            else
                v332 = false;
            end;

            if not v332 then
                return;
            end;

            u277 = 0;
        end);

        local function v334(p333) -- Line: 1861
            -- upvalues: VRService (ref), u281 (copy), u279 (ref), u282 (copy), u274 (copy), u275 (copy)
            if p333 ~= "VREnabled" then
                return;
            end;

            if VRService.VREnabled then
                u281.Selectable = u279;
                u282.Selectable = u279;
                u274.SliderFrame.Selectable = u279;

                for i = 1, u275 do
                    u274.Steps[i].Selectable = u279;
                    u274.Steps[i].Active = u279;
                    local _ = i;
                end;

                return;
            end;

            u281.Selectable = false;
            u282.Selectable = false;
            u274.SliderFrame.Selectable = u279;

            for i = 1, u275 do
                u274.Steps[i].Selectable = false;
                u274.Steps[i].Active = false;
                local _ = i;
            end;
        end;

        VRService.Changed:Connect(v334);
        v334("VREnabled");

        local function modifySelection(p335) -- Line: 1701
            -- upvalues: u275 (copy), u274 (copy)
            for i = 1, u275 do
                local v336;

                if i == 1 or i == u275 then
                    u274.Steps[i].ImageTransparency = p335;
                    v336 = i;
                else
                    u274.Steps[i].BackgroundTransparency = p335;
                    v336 = i;
                end;
            end;
        end;

        for i = 1, u275 do
            u274.Steps[i].InputBegan:Connect(function(p337) -- Line: 1888
                -- upvalues: mouseDownFunc (copy), i (copy)
                mouseDownFunc(p337, i);
            end);
            u274.Steps[i].InputEnded:Connect(function(p338) -- Line: 1891
                -- upvalues: u279 (ref), u277 (ref)
                if not u279 then
                    return;
                end;

                local v339;

                if p338 then
                    if p338.UserInputType == Enum.UserInputType.MouseButton1 or p338.UserInputType == Enum.UserInputType.Touch then
                        v339 = true;
                    elseif p338.UserInputType == Enum.UserInputType.Gamepad1 then
                        v339 = p338.KeyCode == Enum.KeyCode.ButtonA;
                    else
                        v339 = false;
                    end;
                else
                    v339 = false;
                end;

                if not v339 then
                    return;
                end;

                u277 = 0;
            end);
            local _ = i;
        end;

        u274.SliderFrame.InputBegan:Connect(function(p340) -- Line: 1895
            -- upvalues: VRService (ref), GuiService (ref), u274 (copy), mouseDownFunc (copy), u276 (ref)
            if VRService.VREnabled then
                local SelectedCoreObject = GuiService.SelectedCoreObject;

                if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u274.SliderFrame.Parent)) then
                    return;
                end;
            end;

            mouseDownFunc(p340, u276);
        end);
        u274.SliderFrame.InputEnded:Connect(function(p341) -- Line: 1902
            -- upvalues: VRService (ref), GuiService (ref), u274 (copy), u279 (ref), u277 (ref)
            if VRService.VREnabled then
                local SelectedCoreObject = GuiService.SelectedCoreObject;

                if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u274.SliderFrame.Parent)) then
                    return;
                end;
            end;

            if not u279 then
                return;
            end;

            local v342;

            if p341 then
                if p341.UserInputType == Enum.UserInputType.MouseButton1 or p341.UserInputType == Enum.UserInputType.Touch then
                    v342 = true;
                elseif p341.UserInputType == Enum.UserInputType.Gamepad1 then
                    v342 = p341.KeyCode == Enum.KeyCode.ButtonA;
                else
                    v342 = false;
                end;
            else
                v342 = false;
            end;

            if not v342 then
                return;
            end;

            u277 = 0;
        end);

        local function u343() -- Line: 1911
            -- upvalues: u278 (ref), setCurrentStep (copy), u276 (ref), u277 (ref)
            if u278 == nil then
                return;
            end;

            if tick() - u278 >= 0.2 then
                setCurrentStep(u276 + u277);
            end;
        end;

        local u344 = true;
        local u345 = {
            [Enum.KeyCode.Thumbstick1] = true,
            [Enum.KeyCode.DPadLeft] = -1,
            [Enum.KeyCode.DPadRight] = 1,
            [Enum.KeyCode.Left] = -1,
            [Enum.KeyCode.Right] = 1,
            [Enum.KeyCode.A] = -1,
            [Enum.KeyCode.D] = 1,
            [Enum.KeyCode.ButtonA] = true
        };
        UserInputService.InputBegan:Connect(function(p346) -- Line: 1935
            -- upvalues: u279 (ref), u344 (ref), GuiService (ref), u274 (copy), u345 (copy), u277 (ref), setCurrentStep (copy), u276 (ref)
            if not u279 then
                return;
            end;

            if not u344 then
                return;
            end;

            if p346.UserInputType ~= Enum.UserInputType.Gamepad1 and p346.UserInputType ~= Enum.UserInputType.Keyboard then
                return;
            end;

            local SelectedCoreObject = GuiService.SelectedCoreObject;

            if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u274.SliderFrame.Parent)) then
                return;
            end;

            if u345[p346.KeyCode] ~= -1 then
                if u345[p346.KeyCode] == 1 then
                    u277 = 1;
                    setCurrentStep(u276 + 1);
                end;

                return;
            end;

            u277 = -1;
            setCurrentStep(u276 - 1);
        end);
        UserInputService.InputEnded:Connect(function(p347) -- Line: 1952
            -- upvalues: u279 (ref), GuiService (ref), u274 (copy), u345 (copy), u277 (ref)
            if not u279 then
                return;
            end;

            if p347.UserInputType ~= Enum.UserInputType.Gamepad1 and p347.UserInputType ~= Enum.UserInputType.Keyboard then
                return;
            end;

            local SelectedCoreObject = GuiService.SelectedCoreObject;

            if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u274.SliderFrame.Parent)) then
                return;
            end;

            if u345[p347.KeyCode] then
                u277 = 0;
            end;
        end);
        UserInputService.InputChanged:Connect(function(p348) -- Line: 1964
            -- upvalues: u279 (ref), u277 (ref), u344 (ref), GuiService (ref), u274 (copy), setCurrentStep (copy), u276 (ref)
            if not u279 then
                u277 = 0;

                return;
            end;

            if not u344 then
                u277 = 0;

                return;
            end;

            if p348.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            local SelectedCoreObject = GuiService.SelectedCoreObject;

            if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u274.SliderFrame.Parent)) then
                return;
            end;

            if p348.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return;
            end;

            if p348.Position.X > 0.8 and (p348.Delta.X > 0 and u277 ~= 1) then
                u277 = 1;
                setCurrentStep(u276 + 1);

                return;
            end;

            if p348.Position.X >= -0.8 or (p348.Delta.X >= 0 or u277 == -1) then
                if math.abs(p348.Position.X) < 0.8 then
                    u277 = 0;
                end;

                return;
            end;

            u277 = -1;
            setCurrentStep(u276 - 1);
        end);
        local u349 = false;
        GuiService.Changed:Connect(function(p350) -- Line: 1991
            -- upvalues: GuiService (ref), u274 (copy), modifySelection (copy), u349 (ref), u278 (ref), RunService (ref), u280 (copy), u343 (copy)
            if p350 ~= "SelectedCoreObject" then
                return;
            end;

            local SelectedCoreObject = GuiService.SelectedCoreObject;

            if SelectedCoreObject then
                SelectedCoreObject = SelectedCoreObject:IsDescendantOf(u274.SliderFrame.Parent);
            end;

            if SelectedCoreObject then
                modifySelection(0);

                if not u349 then
                    u349 = true;
                    u278 = tick();
                    RunService:BindToRenderStep(u280, Enum.RenderPriority.Input.Value + 1, u343);
                end;
            else
                modifySelection(0.36);

                if u349 then
                    u349 = false;
                    RunService:UnbindFromRenderStep(u280);
                end;
            end;
        end);
        u274.SliderFrame.AncestryChanged:Connect(function(p351, p352) -- Line: 2012
            -- upvalues: u344 (ref)
            u344 = p352;
        end);
        setCurrentStep(u276);

        return u274;
    end;

    error(
        "CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer",
        2
    );
end;

local u353 = 50;
local u354 = {};

local function AddNewRow(u355, u356, p357, p358, p359, p360) -- Line: 2025
    -- upvalues: u354 (copy), u5 (copy), u353 (ref), u7 (copy), u1 (copy), getViewportSize (copy), u6 (copy), CreateNewSlider (copy), CreateSelector (copy), CreateDropDown (copy), VRService (copy), UserInputService (copy), GuiService (copy), PlayerGui (copy)
    local v361 = p357 ~= "TextBox";
    local v362 = not u354[u355] and 0 or u354[u355];
    local u363 = u5.Create("ImageButton")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = u356 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 18, 18),
        Size = UDim2.new(1, 0, 0, u353),
        Position = UDim2.new(0, 0, 0, v362),
        SelectionImageObject = u7,
        Parent = u355.Page
    });
    u363.ImageColor3 = u363.BackgroundColor3;

    if u363 and p360 then
        u363.Position = UDim2.new(u363.Position.X.Scale, u363.Position.X.Offset, u363.Position.Y.Scale, u363.Position.Y.Offset + p360);
    end;

    local u364 = u5.Create("TextLabel")({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = u356 .. "Label",
        Text = u356,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = u363
    });
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    if u1 then
        u364.Size = UDim2.new(0.35, 0, 1, 0);
        u364.TextScaled = true;
        u364.TextWrapped = true;
        UITextSizeConstraint.Parent = u364;
        UITextSizeConstraint.MaxTextSize = 16;
    end;

    if not v361 then
        u364.Text = "";
    end;

    local function onResized(p365, p366) -- Line: 2088
        -- upvalues: u364 (ref), UITextSizeConstraint (copy)
        if p366 then
            u364.TextSize = 16;
        else
            u364.TextSize = 24;
        end;

        UITextSizeConstraint.MaxTextSize = u364.TextSize;
    end;

    getViewportSize();
    local v367 = getViewportSize();

    if v367.Y > v367.X then
        u364.TextSize = 16;
    else
        u364.TextSize = 24;
    end;

    UITextSizeConstraint.MaxTextSize = u364.TextSize;
    u6[u363] = onResized;
    getViewportSize();
    local v368 = getViewportSize();

    if v368.Y > v368.X then
        u364.TextSize = 16;
    else
        u364.TextSize = 24;
    end;

    UITextSizeConstraint.MaxTextSize = u364.TextSize;
    local u369 = nil;
    local u370 = nil;

    if p357 == "Slider" then
        u370 = CreateNewSlider(p358, p359);
        u370.SliderFrame.Parent = u363;
        u369 = u370.SliderFrame;
    elseif p357 == "Selector" then
        u370 = CreateSelector(p358, p359);
        u370.SelectorFrame.Parent = u363;
        u369 = u370.SelectorFrame;
    elseif p357 == "DropDown" then
        u370 = CreateDropDown(p358, p359, u355.HubRef);
        u370.DropDownFrame.Parent = u363;
        u369 = u370.DropDownFrame;
    elseif p357 == "TextBox" then
        local u371 = false;
        local u372 = false;
        local v373 = u5.Create("ImageLabel")({
            Image = "",
            BackgroundTransparency = 1
        });
        u370 = {
            HubRef = nil
        };
        local u374 = u5.Create("TextBox")({
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            TextWrapped = true,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.6, 0, 1, 0),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = u356,
            TextColor3 = Color3.fromRGB(49, 49, 49),
            TextYAlignment = Enum.TextYAlignment.Top,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v373,
            Parent = u363
        });
        u369 = u374;
        u374.Focused:Connect(function() -- Line: 2146
            -- upvalues: VRService (ref), UserInputService (ref), GuiService (ref), u374 (copy), u356 (copy)
            local v375;

            if VRService.VREnabled then
                v375 = false;
            else
                v375 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v375 then
                GuiService.SelectedCoreObject = u374;
            end;

            if u374.Text == u356 then
                u374.Text = "";
            end;
        end);
        u374.FocusLost:Connect(function(p376, p377) -- Line: 2155
            -- upvalues: u372 (ref)
            u372 = false;
        end);

        if p360 then
            u374.Position = UDim2.new(u374.Position.X.Scale, u374.Position.X.Offset, u374.Position.Y.Scale, u374.Position.Y.Offset + p360);
        end;

        u369.SelectionGained:Connect(function() -- Line: 2163
            -- upvalues: VRService (ref), UserInputService (ref), u374 (copy), u370 (ref), u369 (ref)
            local v378;

            if VRService.VREnabled then
                v378 = false;
            else
                v378 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v378 then
                u374.BackgroundTransparency = 0.1;

                if u370.HubRef then
                    u370.HubRef:ScrollToFrame(u369);
                end;
            end;
        end);
        u369.SelectionLost:Connect(function() -- Line: 2172
            -- upvalues: VRService (ref), UserInputService (ref), u374 (copy)
            local v379;

            if VRService.VREnabled then
                v379 = false;
            else
                v379 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v379 then
                u374.BackgroundTransparency = 0.5;
            end;
        end);

        local function v381(p380) -- Line: 2189
            -- upvalues: GuiService (ref), u369 (ref), u372 (ref), u374 (copy)
            if p380.UserInputState == Enum.UserInputState.Begin and (p380.KeyCode == Enum.KeyCode.Return and GuiService.SelectedCoreObject == u369) then
                u372 = true;
                u374:CaptureFocus();
            end;
        end;

        u374.MouseEnter:Connect(function() -- Line: 2178
            -- upvalues: PlayerGui (ref), u369 (ref), VRService (ref), UserInputService (ref), u355 (copy), GuiService (ref), u371 (ref)
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame");

            if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
                return;
            end;

            local v382 = u369;

            if v382 and (v382.Visible and v382.ZIndex > 1) then
                local v383;

                if VRService.VREnabled then
                    v383 = false;
                else
                    v383 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
                end;

                if v383 and u355.Active then
                    GuiService.SelectedCoreObject = v382;
                    u371 = true;
                end;
            end;
        end);
        UserInputService.InputBegan:Connect(v381);
    elseif p357 == "TextEntry" then
        local u384 = false;
        local u385 = false;
        local v386 = u5.Create("ImageLabel")({
            Image = "",
            BackgroundTransparency = 1
        });
        u370 = {
            HubRef = nil
        };
        local u387 = u5.Create("TextBox")({
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextWrapped = false,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.4, -10, 0, 40),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = u356,
            TextColor3 = Color3.fromRGB(178, 178, 178),
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v386,
            Parent = u363
        });
        u369 = u387;
        u387.Focused:Connect(function() -- Line: 2236
            -- upvalues: VRService (ref), UserInputService (ref), GuiService (ref), u387 (copy), u356 (copy)
            local v388;

            if VRService.VREnabled then
                v388 = false;
            else
                v388 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v388 then
                GuiService.SelectedCoreObject = u387;
            end;

            if u387.Text == u356 then
                u387.Text = "";
            end;
        end);
        u387.FocusLost:Connect(function(p389, p390) -- Line: 2245
            -- upvalues: u385 (ref)
            u385 = false;
        end);

        if p360 then
            u387.Position = UDim2.new(u387.Position.X.Scale, u387.Position.X.Offset, u387.Position.Y.Scale, u387.Position.Y.Offset + p360);
        end;

        u369.SelectionGained:Connect(function() -- Line: 2253
            -- upvalues: VRService (ref), UserInputService (ref), u387 (copy), u370 (ref), u369 (ref)
            local v391;

            if VRService.VREnabled then
                v391 = false;
            else
                v391 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v391 then
                u387.BackgroundTransparency = 0.8;

                if u370.HubRef then
                    u370.HubRef:ScrollToFrame(u369);
                end;
            end;
        end);
        u369.SelectionLost:Connect(function() -- Line: 2262
            -- upvalues: VRService (ref), UserInputService (ref), u387 (copy)
            local v392;

            if VRService.VREnabled then
                v392 = false;
            else
                v392 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v392 then
                u387.BackgroundTransparency = 1;
            end;
        end);

        local function v394(p393) -- Line: 2279
            -- upvalues: GuiService (ref), u369 (ref), u385 (ref), u387 (copy)
            if p393.UserInputState == Enum.UserInputState.Begin and (p393.KeyCode == Enum.KeyCode.Return and GuiService.SelectedCoreObject == u369) then
                u385 = true;
                u387:CaptureFocus();
            end;
        end;

        u363.MouseEnter:Connect(function() -- Line: 2268
            -- upvalues: PlayerGui (ref), u369 (ref), VRService (ref), UserInputService (ref), u355 (copy), GuiService (ref), u384 (ref)
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame");

            if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
                return;
            end;

            local v395 = u369;

            if v395 and (v395.Visible and v395.ZIndex > 1) then
                local v396;

                if VRService.VREnabled then
                    v396 = false;
                else
                    v396 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
                end;

                if v396 and u355.Active then
                    GuiService.SelectedCoreObject = v395;
                    u384 = true;
                end;
            end;
        end);

        function u370.SetZIndex(p397, p398) -- Line: 2291
            -- upvalues: u387 (copy)
            u387.ZIndex = p398;
        end;

        function u370.SetInteractable(p399, p400) -- Line: 2295
            -- upvalues: u387 (copy)
            u387.Selectable = p400;

            if p400 then
                u387.TextColor3 = Color3.fromRGB(178, 178, 178);
                u387.ZIndex = 2;

                return;
            end;

            u387.TextColor3 = Color3.fromRGB(49, 49, 49);
            u387.ZIndex = 1;
        end;

        function u370.SetValue(p401, p402) -- Line: 2306
            -- upvalues: u387 (copy)
            u387.Text = p402;
        end;

        local BindableEvent = Instance.new("BindableEvent");
        BindableEvent.Name = "ValueChanged";
        u387.FocusLost:Connect(function() -- Line: 2313
            -- upvalues: BindableEvent (copy), u387 (copy)
            BindableEvent:Fire(u387.Text);
        end);
        u370.ValueChanged = BindableEvent.Event;
        UserInputService.InputBegan:Connect(v394);
    end;

    u370.Name = u356 .. "ValueChanger";
    local v403 = v362 + u353;

    if p360 then
        v403 = v403 + p360;
    end;

    u354[u355] = v403;

    if v361 then
        u363.MouseEnter:Connect(function() -- Line: 2332
            -- upvalues: PlayerGui (ref), u370 (ref), VRService (ref), UserInputService (ref), u355 (copy), GuiService (ref)
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame");

            if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
                return;
            end;

            local v404 = u370.SliderFrame or u370.SliderFrame or u370.DropDownFrame or u370.SelectorFrame;

            if v404 and (v404.Visible and v404.ZIndex > 1) then
                local v405;

                if VRService.VREnabled then
                    v405 = false;
                else
                    v405 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
                end;

                if v405 and u355.Active then
                    GuiService.SelectedCoreObject = v404;
                end;
            end;
        end);
        VRService.Changed:Connect(function(p406) -- Line: 2354, Name: onVREnabled
            -- upvalues: VRService (ref), u363 (ref), u369 (ref), GuiService (ref)
            if p406 == "VREnabled" then
                if VRService.VREnabled then
                    u363.Selectable = true;
                    u363.Active = true;
                    u369.Active = true;
                    GuiService.Changed:Connect(function(p407) -- Line: 2360
                        -- upvalues: GuiService (ref), u363 (ref)
                        if p407 == "SelectedCoreObject" then
                            local SelectedCoreObject = GuiService.SelectedCoreObject;

                            if SelectedCoreObject and (SelectedCoreObject == u363 or SelectedCoreObject:IsDescendantOf(u363)) then
                                u363.ImageTransparency = 0.5;
                                u363.BackgroundTransparency = 1;

                                return;
                            end;

                            u363.ImageTransparency = 1;
                            u363.BackgroundTransparency = 1;
                        end;
                    end);

                    return;
                end;

                u363.Selectable = false;
                u363.Active = false;
            end;
        end);

        if VRService.VREnabled then
            u363.Selectable = true;
            u363.Active = true;
            u369.Active = true;
            GuiService.Changed:Connect(function(p408) -- Line: 2360
                -- upvalues: GuiService (ref), u363 (ref)
                if p408 == "SelectedCoreObject" then
                    local SelectedCoreObject = GuiService.SelectedCoreObject;

                    if SelectedCoreObject and (SelectedCoreObject == u363 or SelectedCoreObject:IsDescendantOf(u363)) then
                        u363.ImageTransparency = 0.5;
                        u363.BackgroundTransparency = 1;

                        return;
                    end;

                    u363.ImageTransparency = 1;
                    u363.BackgroundTransparency = 1;
                end;
            end);
        else
            u363.Selectable = false;
            u363.Active = false;
        end;

        u369.SelectionGained:Connect(function() -- Line: 2381
            -- upvalues: VRService (ref), UserInputService (ref), u363 (ref), u370 (ref)
            local v409;

            if VRService.VREnabled then
                v409 = false;
            else
                v409 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v409 then
                if VRService.VREnabled then
                    u363.ImageTransparency = 0.5;
                    u363.BackgroundTransparency = 1;
                else
                    u363.ImageTransparency = 1;
                    u363.BackgroundTransparency = 0.5;
                end;

                if u370.HubRef then
                    u370.HubRef:ScrollToFrame(u363);
                end;
            end;
        end);
        u369.SelectionLost:Connect(function() -- Line: 2396
            -- upvalues: VRService (ref), UserInputService (ref), u363 (ref)
            local v410;

            if VRService.VREnabled then
                v410 = false;
            else
                v410 = (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
            end;

            if v410 then
                u363.ImageTransparency = 1;
                u363.BackgroundTransparency = 1;
            end;
        end);
    end;

    u355:AddRow(u363, u364, u370, p360, false);
    u370.Selection = u369;

    return u363, u364, u370;
end;

local function AddNewRowObject(p411, p412, p413, p414) -- Line: 2411
    -- upvalues: u354 (copy), u5 (copy), u353 (ref), u7 (copy), u6 (copy), getViewportSize (copy), GuiService (copy), VRService (copy)
    local v415 = not u354[p411] and 0 or u354[p411];
    local u416 = u5.Create("ImageButton")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = p412 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10),
        Size = UDim2.new(1, 0, 0, u353),
        Position = UDim2.new(0, 0, 0, v415),
        SelectionImageObject = u7,
        Parent = p411.Page
    });
    u416.ImageColor3 = u416.BackgroundColor3;
    u416.SelectionGained:Connect(function() -- Line: 2437
        -- upvalues: u416 (copy)
        u416.BackgroundTransparency = 0.5;
    end);
    u416.SelectionLost:Connect(function() -- Line: 2440
        -- upvalues: u416 (copy)
        u416.BackgroundTransparency = 1;
    end);
    local u417 = u5.Create("TextLabel")({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = p412 .. "Label",
        Text = p412,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = u416
    });

    u6[u416] = function(p418, p419) -- Line: 2458, Name: onResized
        -- upvalues: u417 (copy)
        if p419 then
            u417.TextSize = 16;

            return;
        end;

        u417.TextSize = 24;
    end;

    getViewportSize();
    local v420 = getViewportSize();

    if v420.Y > v420.X then
        u417.TextSize = 16;
    else
        u417.TextSize = 24;
    end;

    if p414 then
        u416.Position = UDim2.new(u416.Position.X.Scale, u416.Position.X.Offset, u416.Position.Y.Scale, u416.Position.Y.Offset + p414);
    end;

    local v421 = v415 + u353;

    if p414 then
        v421 = v421 + p414;
    end;

    u354[p411] = v421;
    u416.MouseEnter:Connect(function() -- Line: 2479
        -- upvalues: u416 (copy), GuiService (ref)
        if u416.Visible then
            GuiService.SelectedCoreObject = u416;
        end;
    end);
    p413.SelectionImageObject = u7;
    p413.SelectionGained:Connect(function() -- Line: 2488
        -- upvalues: VRService (ref), u416 (copy)
        if VRService.VREnabled then
            u416.ImageTransparency = 0.5;
            u416.BackgroundTransparency = 1;

            return;
        end;

        u416.ImageTransparency = 1;
        u416.BackgroundTransparency = 0.5;
    end);
    p413.SelectionLost:Connect(function() -- Line: 2497
        -- upvalues: u416 (copy)
        u416.ImageTransparency = 1;
        u416.BackgroundTransparency = 1;
    end);
    p413.Parent = u416;
    p411:AddRow(u416, u417, p413, p414, true);

    return u416;
end;

local u502 = {
    Create = function(p422, u423) -- Line: 2511, Name: Create
        return function(p424) -- Line: 2512
            -- upvalues: u423 (copy)
            local Instance_new_ret = Instance.new(u423);
            local v425 = nil;

            for i, v in pairs(p424) do
                if type(i) == "number" then
                    v.Parent = Instance_new_ret;
                elseif i == "Parent" then
                    v425 = v;
                else
                    Instance_new_ret[i] = v;
                end;
            end;

            if v425 then
                Instance_new_ret.Parent = v425;
            end;

            return Instance_new_ret;
        end;
    end,

    RayPlaneIntersection = function(p426, p427, p428, p429) -- Line: 2533, Name: RayPlaneIntersection
        local unit = p428.unit;
        local Unit = p427.Unit;
        local v430 = unit:Dot(Unit.Direction);

        if v430 == 0 then
            return nil;
        end;

        local v431 = unit:Dot(p429 - Unit.Origin) / v430;

        if v431 < 0 then
            return nil;
        end;

        return Unit.Origin + Unit.Direction * v431;
    end,

    GetEaseLinear = function(p432) -- Line: 2551, Name: GetEaseLinear
        -- upvalues: Linear (copy)
        return Linear;
    end,

    GetEaseOutQuad = function(p433) -- Line: 2554, Name: GetEaseOutQuad
        -- upvalues: EaseOutQuad (copy)
        return EaseOutQuad;
    end,

    GetEaseInOutQuad = function(p434) -- Line: 2557, Name: GetEaseInOutQuad
        -- upvalues: EaseInOutQuad (copy)
        return EaseInOutQuad;
    end,

    CreateNewSlider = function(p435, p436, p437, p438) -- Line: 2561, Name: CreateNewSlider
        -- upvalues: CreateNewSlider (copy)
        return CreateNewSlider(p436, p437, p438);
    end,

    CreateNewSelector = function(p439, p440, p441) -- Line: 2565, Name: CreateNewSelector
        -- upvalues: CreateSelector (copy)
        return CreateSelector(p440, p441);
    end,

    CreateNewDropDown = function(p442, p443, p444) -- Line: 2569, Name: CreateNewDropDown
        -- upvalues: CreateDropDown (copy)
        return CreateDropDown(p443, p444, nil);
    end,

    AddNewRow = function(p445, p446, p447, p448, p449, p450, p451) -- Line: 2573, Name: AddNewRow
        -- upvalues: AddNewRow (copy)
        return AddNewRow(p446, p447, p448, p449, p450, p451);
    end,

    AddNewRowObject = function(p452, p453, p454, p455, p456) -- Line: 2577, Name: AddNewRowObject
        -- upvalues: AddNewRowObject (copy)
        return AddNewRowObject(p453, p454, p455, p456);
    end,

    ShowAlert = function(p457, p458, p459, p460, p461, p462) -- Line: 2581, Name: ShowAlert
        -- upvalues: ShowAlert (copy)
        ShowAlert(p458, p459, p460, p461, p462);
    end,

    IsSmallTouchScreen = function(p463) -- Line: 2585, Name: IsSmallTouchScreen
        -- upvalues: getViewportSize (copy), UserInputService (copy)
        local v464 = getViewportSize();

        return UserInputService.TouchEnabled and (v464.Y < 500 and true or v464.X < 700);
    end,

    IsPortrait = function(p465) -- Line: 2589, Name: IsPortrait
        -- upvalues: getViewportSize (copy)
        local v466 = getViewportSize();

        return v466.Y > v466.X;
    end,

    MakeStyledButton = function(p467, p468, p469, p470, p471, p472, p473) -- Line: 2593, Name: MakeStyledButton
        -- upvalues: MakeButton (copy)
        return MakeButton(p468, p469, p470, p471, p472, p473);
    end,

    MakeStyledImageButton = function(p474, p475, p476, p477, p478, p479, p480, p481) -- Line: 2597, Name: MakeStyledImageButton
        -- upvalues: MakeImageButton (copy)
        return MakeImageButton(p475, p476, p477, p478, p479, p480, p481);
    end,

    AddButtonRow = function(p482, p483, p484, p485, p486, p487, p488) -- Line: 2601, Name: AddButtonRow
        -- upvalues: AddButtonRow (copy)
        return AddButtonRow(p483, p484, p485, p486, p487, p488);
    end,

    CreateSignal = function(p489) -- Line: 2605, Name: CreateSignal
        -- upvalues: CreateSignal (copy)
        return CreateSignal();
    end,

    UsesSelectedObject = function(p490) -- Line: 2609, Name: UsesSelectedObject
        -- upvalues: VRService (copy), UserInputService (copy)
        if VRService.VREnabled then
            return false;
        end;

        return (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false;
    end,

    TweenProperty = function(p491, p492, p493, p494, p495, p496, p497, p498) -- Line: 2613, Name: TweenProperty
        return PropertyTweener(p492, p493, p494, p495, p496, p497, p498);
    end,

    OnResized = function(p499, p500, p501) -- Line: 2617, Name: OnResized
        -- upvalues: addOnResizedCallback (copy)
        return addOnResizedCallback(p500, p501);
    end
};

function u502.FireOnResized(p503) -- Line: 2621
    -- upvalues: getViewportSize (copy), u502 (copy), u6 (copy)
    local v504 = getViewportSize();
    local v505 = u502:IsPortrait();

    for _, v in pairs(u6) do
        v(v504, v505);
    end;
end;

function u502.Lerp(p506, p507, p508, p509) -- Line: 2632
    return (1 - p507) * p508 + p507 * p509;
end;

function u502.Round(p510, p511) -- Line: 2637
    return p511 % 1 >= 0.5 and math.ceil(p511) or math.floor(p511);
end;

return u502;