-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local ActionMenu = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CosmeticUI"):WaitForChild("ActionMenu");
local CosmeticRegistry = require(ReplicatedStorage.Data.CosmeticRegistry);
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local GetWorldToPosition = require(ReplicatedStorage.Modules.GetWorldToPosition);
local GetUIElementWithTag = require(ReplicatedStorage.Modules.GetUIElementWithTag);
local CosmeticInventoryUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticInventoryUserInterfaceService);
require(ReplicatedStorage.Modules.PlaySound);
require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
local CosmeticRotationLockUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticRotationLockUserInterfaceService);
local Actions = script:WaitForChild("Actions");
local DefaultActions = CosmeticRegistry.DefaultActions;
local ActionRegistry = CosmeticRegistry.ActionRegistry;
local ICON_INSERTION_POINT = ActionMenu:WaitForChild("ICON_INSERTION_POINT");
local UIGridLayout = ICON_INSERTION_POINT:WaitForChild("UIGridLayout");
local ICON_TEMPLATE = ICON_INSERTION_POINT:WaitForChild("ICON_TEMPLATE");
ICON_TEMPLATE.Visible = false;
local UIScale = ActionMenu:WaitForChild("UIScale");
local u1 = 1.5;

local function UpdateButtonSize() -- Line: 38
    -- upvalues: UserInputService (copy), u1 (ref), UIGridLayout (copy)
    local TouchEnabled = UserInputService.TouchEnabled;
    u1 = TouchEnabled and 2.5 or u1;
    UIGridLayout.CellSize = TouchEnabled and UDim2.fromOffset(18, 18) or UDim2.fromOffset(34, 34);
end;

local TouchEnabled = UserInputService.TouchEnabled;
u1 = TouchEnabled and 2.5 or u1;
UIGridLayout.CellSize = TouchEnabled and UDim2.fromOffset(18, 18) or UDim2.fromOffset(34, 34);
UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(function() -- Line: 50
    -- upvalues: UserInputService (copy), u1 (ref), UIGridLayout (copy)
    local TouchEnabled2 = UserInputService.TouchEnabled;
    u1 = TouchEnabled2 and 2.5 or u1;
    UIGridLayout.CellSize = TouchEnabled2 and UDim2.fromOffset(18, 18) or UDim2.fromOffset(34, 34);
end);
local u2 = {
    Target = nil,
    CurrentState = false,
    MovementStates = {}
};
local u3 = {};

for _, child in Actions:GetChildren() do
    local v4 = require(child);
    u3[child.Name] = v4(u2);
end;

local function CompleteCurrentButton() -- Line: 84
    -- upvalues: u2 (copy), u3 (copy)
    local CurrentButton = u2.CurrentButton;

    if not CurrentButton then
        return;
    end;

    u2.CurrentButton = nil;
    local Attribute = CurrentButton:GetAttribute("Action");
    local v5 = u3[Attribute];

    if v5 then
        v5.InputEnded();

        return;
    end;

    warn(Attribute, "Has no action handler!");
end;

local function InitiateCurrentButton() -- Line: 96
    -- upvalues: u2 (copy), u3 (copy)
    local CurrentButton = u2.CurrentButton;

    if not CurrentButton then
        return;
    end;

    local Attribute = CurrentButton:GetAttribute("Action");
    local v6 = u3[Attribute];

    if v6 then
        v6.InputBegan();

        return;
    end;

    warn(Attribute, "Has no action handler!");
end;

local function LoadActions(p7) -- Line: 107
    -- upvalues: ActionRegistry (copy), ICON_TEMPLATE (copy), ICON_INSERTION_POINT (copy), WaitForDescendant (copy), CosmeticRotationLockUserInterfaceService (copy), TweenService (copy), u2 (copy), u3 (copy)
    for _, v in p7 do
        local v8 = ActionRegistry[v];

        if v8 then
            local u9 = ICON_TEMPLATE:Clone();
            u9:AddTag("ActionButton");
            u9:SetAttribute("Action", v);
            u9.Parent = ICON_INSERTION_POINT;
            local v10 = WaitForDescendant(u9, "IMAGE_ICON");
            v10.Image = v8.Image;
            u9.LayoutOrder = v8.LayoutOrder;
            u9.Visible = true;
            u9.Name = v;

            if v8.StartingImageColor then
                v10.ImageColor3 = CosmeticRotationLockUserInterfaceService:GetCurrentColor();
            end;

            local SENSOR = u9:WaitForChild("SENSOR");
            local Vignette = u9:WaitForChild("Vignette");
            local UIStroke = u9:WaitForChild("UIStroke");

            local function ToggleVignette(p11) -- Line: 131
                -- upvalues: TweenService (ref), Vignette (copy), UIStroke (copy)
                TweenService:Create(Vignette, TweenInfo.new(0.2), {
                    BackgroundTransparency = p11 and 0.5 or 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.2), {
                    Color = p11 and Color3.fromRGB(255, 157, 0) or Color3.fromRGB(61, 32, 19),
                    Thickness = p11 and 3 or 1.55
                }):Play();
            end;

            SENSOR.MouseLeave:Connect(function() -- Line: 143
                -- upvalues: ToggleVignette (copy)
                ToggleVignette(false);
            end);
            SENSOR.MouseEnter:Connect(function() -- Line: 147
                -- upvalues: ToggleVignette (copy)
                ToggleVignette(true);
            end);
            SENSOR.MouseButton1Down:Connect(function() -- Line: 151
                -- upvalues: ToggleVignette (copy), u2 (ref), u3 (ref), u9 (copy)
                ToggleVignette(false);
                local CurrentButton = u2.CurrentButton;

                if CurrentButton then
                    u2.CurrentButton = nil;
                    local Attribute = CurrentButton:GetAttribute("Action");
                    local v12 = u3[Attribute];

                    if v12 then
                        v12.InputEnded();
                    else
                        warn(Attribute, "Has no action handler!");
                    end;
                end;

                u2.CurrentButton = u9;
                local CurrentButton2 = u2.CurrentButton;

                if not CurrentButton2 then
                    return;
                end;

                local Attribute = CurrentButton2:GetAttribute("Action");
                local v13 = u3[Attribute];

                if v13 then
                    v13.InputBegan();

                    return;
                end;

                warn(Attribute, "Has no action handler!");
            end);
            SENSOR.MouseButton1Up:Connect(function() -- Line: 158
                -- upvalues: ToggleVignette (copy)
                ToggleVignette(true);
            end);
            u9.Parent = ICON_INSERTION_POINT;
        else
            warn(v, "Has no action data!");
        end;
    end;
end;

function u2.SetTarget(p14, p15) -- Line: 166
    -- upvalues: u2 (copy), CollectionService (copy), LoadActions (copy), DefaultActions (copy)
    u2.Target = p15;

    for _, v in CollectionService:GetTagged("ActionButton") do
        v:Destroy();
    end;

    LoadActions(DefaultActions);
end;

function u2.Toggle(p16, p17) -- Line: 177
    -- upvalues: u2 (copy), TweenService (copy), UIScale (copy), u1 (ref)
    if u2.CurrentState == p17 then
        return;
    end;

    u2.CurrentState = p17;
    TweenService:Create(UIScale, TweenInfo.new(0.2), {
        Scale = p17 and u1 or 0
    }):Play();
end;

function u2.HardDisable(p18) -- Line: 186
    -- upvalues: u2 (copy), u3 (copy)
    u2:Toggle(false);
    u2.Target = nil;
    local CurrentButton = u2.CurrentButton;

    if not CurrentButton then
        return;
    end;

    u2.CurrentButton = nil;
    local Attribute = CurrentButton:GetAttribute("Action");
    local v19 = u3[Attribute];

    if v19 then
        v19.InputEnded();

        return;
    end;

    warn(Attribute, "Has no action handler!");
end;

u2:Toggle(false);
game:GetService("RunService").Heartbeat:Connect(function() -- Line: 195
    -- upvalues: CosmeticInventoryUserInterfaceService (copy), u2 (copy), GetWorldToPosition (copy), ActionMenu (copy)
    local v20 = not (CosmeticInventoryUserInterfaceService.State and u2.Target) or u2.Target and not u2.Target:IsDescendantOf(workspace);

    if v20 then
        u2:HardDisable();

        return;
    end;

    local Target = u2.Target;

    if not Target then
        return;
    end;

    local v21, v22 = GetWorldToPosition(Target:GetPivot().Position);
    ActionMenu.Position = v21;
    ActionMenu.Visible = v22;
end);

local function Activate() -- Line: 213
    -- upvalues: u2 (copy), u3 (copy), GetUIElementWithTag (copy)
    local CurrentButton = u2.CurrentButton;

    if CurrentButton then
        u2.CurrentButton = nil;
        local Attribute = CurrentButton:GetAttribute("Action");
        local v23 = u3[Attribute];

        if v23 then
            v23.InputEnded();
        else
            warn(Attribute, "Has no action handler!");
        end;
    end;

    local v24 = GetUIElementWithTag("ActionButton");

    if not v24 then
        u2:HardDisable();

        return;
    end;

    u2.CurrentButton = v24;
    local CurrentButton2 = u2.CurrentButton;

    if not CurrentButton2 then
        return;
    end;

    local Attribute = CurrentButton2:GetAttribute("Action");
    local v25 = u3[Attribute];

    if v25 then
        v25.InputBegan();

        return;
    end;

    warn(Attribute, "Has no action handler!");
end;

local u29 = {
    [Enum.UserInputType.MouseButton1] = {
        Activate = function() -- Line: 226
            -- upvalues: GetUIElementWithTag (copy), u2 (copy)
            if GetUIElementWithTag("ActionButton") then
                return;
            end;

            u2:HardDisable();
        end
    },
    [Enum.KeyCode.ButtonR2] = { function() -- Line: 234
            -- upvalues: u2 (copy), u3 (copy), GetUIElementWithTag (copy)
            local CurrentButton = u2.CurrentButton;

            if CurrentButton then
                u2.CurrentButton = nil;
                local Attribute = CurrentButton:GetAttribute("Action");
                local v26 = u3[Attribute];

                if v26 then
                    v26.InputEnded();
                else
                    warn(Attribute, "Has no action handler!");
                end;
            end;

            local v27 = GetUIElementWithTag("ActionButton");

            if not v27 then
                u2:HardDisable();

                return;
            end;

            u2.CurrentButton = v27;
            local CurrentButton2 = u2.CurrentButton;

            if not CurrentButton2 then
                return;
            end;

            local Attribute = CurrentButton2:GetAttribute("Action");
            local v28 = u3[Attribute];

            if v28 then
                v28.InputBegan();

                return;
            end;

            warn(Attribute, "Has no action handler!");
        end }
};
local u32 = {
    [Enum.UserInputType.MouseButton1] = {
        Deactivate = function() -- Line: 242
            -- upvalues: u2 (copy), u3 (copy)
            local CurrentButton = u2.CurrentButton;

            if not CurrentButton then
                return;
            end;

            u2.CurrentButton = nil;
            local Attribute = CurrentButton:GetAttribute("Action");
            local v30 = u3[Attribute];

            if v30 then
                v30.InputEnded();

                return;
            end;

            warn(Attribute, "Has no action handler!");
        end
    },
    [Enum.KeyCode.ButtonR2] = { function() -- Line: 247
            -- upvalues: u2 (copy), u3 (copy)
            local CurrentButton = u2.CurrentButton;

            if not CurrentButton then
                return;
            end;

            u2.CurrentButton = nil;
            local Attribute = CurrentButton:GetAttribute("Action");
            local v31 = u3[Attribute];

            if v31 then
                v31.InputEnded();

                return;
            end;

            warn(Attribute, "Has no action handler!");
        end }
};
UserInputService.TouchEnded:Connect(function() -- Line: 257
    -- upvalues: u2 (copy), u3 (copy)
    local CurrentButton = u2.CurrentButton;

    if not CurrentButton then
        return;
    end;

    u2.CurrentButton = nil;
    local Attribute = CurrentButton:GetAttribute("Action");
    local v33 = u3[Attribute];

    if v33 then
        v33.InputEnded();

        return;
    end;

    warn(Attribute, "Has no action handler!");
end);
UserInputService.InputBegan:Connect(function(u34, p35) -- Line: 261
    -- upvalues: u29 (copy)
    local v36 = u29[u34.KeyCode] or u29[u34.UserInputType];

    if not v36 then
        return;
    end;

    for _, v in v36 do
        task.spawn(function() -- Line: 265
            -- upvalues: v (copy), u34 (copy)
            v(u34);
        end);
    end;
end);
UserInputService.InputEnded:Connect(function(u37, p38) -- Line: 272
    -- upvalues: u32 (copy)
    local v39 = u32[u37.KeyCode] or u32[u37.UserInputType];

    if not v39 then
        return;
    end;

    for _, v in v39 do
        task.spawn(function() -- Line: 276
            -- upvalues: v (copy), u37 (copy)
            v(u37);
        end);
    end;
end);

return u2;