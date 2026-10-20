-- Decompiled with Potassium's decompiler.

game:GetService("Selection");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 12
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local Modules = ReplicatedStorage.Modules;
local WaitForDescendant = require(Modules.WaitForDescendant);
local IsMouseOverUI = require(Modules.IsMouseOverUI);
local PetServices = Modules:WaitForChild("PetServices");
local ActivePetsService = require(PetServices.ActivePetsService);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetList = PetRegistry.PetList;
local DefaultPetActions = PetRegistry.DefaultPetActions;
local PetStatesRegistry = PetRegistry.PetStatesRegistry;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local PetActionUI = PlayerGui:WaitForChild("PetUI"):WaitForChild("PetActionUI");
local UIScale = PetActionUI:WaitForChild("UIScale");
local u1 = WaitForDescendant(PetActionUI, "CLOSE_BUTTON");
local u2 = WaitForDescendant(PetActionUI, "OPTION_HOLDER");
local PetActionsHandlers = script:WaitForChild("PetActionsHandlers");
local PetActionTemplates = script:WaitForChild("PetActionTemplates");
local ScriptModules = script:WaitForChild("ScriptModules");
local SetupHoverAnimations = require(ReplicatedStorage.Modules.SetupHoverAnimations);
local SetupBrightnessAnimationImage = require(ReplicatedStorage.Modules.SetupBrightnessAnimationImage);
local Radialize = require(ScriptModules:WaitForChild("Radialize"));
local PlayHoverSound = require(ReplicatedStorage.Modules.PlayHoverSound);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local u3 = {
    Active = false,
    Target = nil,
    LastStateBeforeInspection = nil
};
local u4 = nil;

local function CheckIfHoveringButton() -- Line: 60
    -- upvalues: CollectionService (copy), UserInputService (copy), GuiService (copy), IsMouseOverUI (copy), PlayerGui (copy)
    local Tagged = CollectionService:GetTagged("PetActionButton");
    local v5 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local GuiObjectsAtPosition = IsMouseOverUI.GetGuiObjectsAtPosition(v5.X, v5.Y);

    for _, v in Tagged do
        if v:IsDescendantOf(PlayerGui) and table.find(GuiObjectsAtPosition, v) then
            return true;
        end;
    end;

    return false;
end;

local Frame_Popup_Module = require(game.ReplicatedStorage.Frame_Popup_Module);
local ConfirmPetEggPurchase = PlayerGui:WaitForChild("ConfirmPetEggPurchase");

local function SetupAction(p6) -- Line: 83
    -- upvalues: PetActionTemplates (copy), PetActionsHandlers (copy), u3 (copy), u2 (copy), SetupHoverAnimations (copy), SetupBrightnessAnimationImage (copy), Frame_Popup_Module (copy), ConfirmPetEggPurchase (copy), LocalPlayer (copy), PlayClickSound (copy), PlayHoverSound (copy)
    local v7 = PetActionTemplates:FindFirstChild(p6);
    local v8 = PetActionsHandlers:FindFirstChild(p6);

    if not v8 then
        return warn("No handler for", p6);
    end;

    local u9 = require(v8);
    local Verifier = u9.Verifier;

    if Verifier and not Verifier(u3.Target) then
        return;
    end;

    local v10 = v7:Clone();
    v10.Parent = u2;
    local Inner = v10:FindFirstChild("Inner");
    local v11 = SetupHoverAnimations(Inner);
    SetupBrightnessAnimationImage(Inner);
    v11.ZIndex = 1000;

    local function ButtonPressed() -- Line: 103
        -- upvalues: u9 (copy), u3 (ref), Frame_Popup_Module (ref), ConfirmPetEggPurchase (ref), LocalPlayer (ref), PlayClickSound (ref)
        local Activate = u9.Activate;

        if Activate then
            Activate(u3.Target);
        end;

        Frame_Popup_Module.Hide(ConfirmPetEggPurchase);
        u3:Toggle(false);
        LocalPlayer:SetAttribute("DontOpenAction", true);
        task.delay(0.3, function() -- Line: 115
            -- upvalues: LocalPlayer (ref)
            LocalPlayer:SetAttribute("DontOpenAction", false);
        end);
        PlayClickSound();
    end;

    v11.MouseButton1Down:Connect(ButtonPressed);
    v11.InputBegan:Connect(function(p12) -- Line: 123
        -- upvalues: ButtonPressed (copy)
        if p12.UserInputState == Enum.UserInputState.Begin and p12.KeyCode == Enum.KeyCode.ButtonR2 then
            ButtonPressed();
        end;
    end);
    v11.MouseEnter:Connect(function() -- Line: 128
        -- upvalues: PlayHoverSound (ref)
        PlayHoverSound();
    end);
end;

function u3.SetTarget(p13: table, p14: userdata) -- Line: 133
    -- upvalues: u4 (ref), u3 (copy), u2 (copy), ActivePetsService (copy), PetList (copy), SetupAction (copy), DefaultPetActions (copy), Radialize (copy)
    u4 = nil;

    if u3.Target == p14 then
        return;
    end;

    u3.Target = p14;

    if not p14 then
        return;
    end;

    for _, child in u2:GetChildren() do
        if child:HasTag("PetActionButton") then
            child:Destroy();
        end;
    end;

    local PetDataFromPetObject = ActivePetsService:GetPetDataFromPetObject(p14);

    if not PetDataFromPetObject then
        return;
    end;

    for _, v in PetList[PetDataFromPetObject.PetType].Actions do
        SetupAction(v);
    end;

    for _, v in DefaultPetActions do
        SetupAction(v);
    end;

    Radialize(u2);
end;

local u15 = nil;

function u3.Toggle(p16, p17) -- Line: 169
    -- upvalues: u3 (copy), TweenService (copy), UIScale (copy), ActivePetsService (copy), PetStatesRegistry (copy), u15 (ref), u1 (copy), UserInputService (copy)
    if u3.Active == p17 then
        return;
    end;

    u3.Active = p17;
    TweenService:Create(UIScale, TweenInfo.new(0.1), {
        Scale = p17 and 1 or 0
    }):Play();
    local Target = u3.Target;

    if Target then
        local Attribute = Target:GetAttribute("UUID");
        local Attribute2 = Target:GetAttribute("OWNER");

        if p17 then
            u3.LastStateBeforeInspection = PetStatesRegistry[ActivePetsService:GetServerState(Attribute2, Attribute).CurrentState];
            u15 = tick();
            game.Workspace:SetAttribute("LastMenu", u15);
            game:GetService("GamepadService"):EnableGamepadCursor(u1);

            if UserInputService.GamepadEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
                game:GetService("RunService"):BindToRenderStep("LockOn", Enum.RenderPriority.Camera.Value + 1, function(p18) -- Line: 196
                    -- upvalues: Target (copy)
                    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.Position, Target:GetPivot().Position), p18 * 2);
                end);
            end;
        elseif not p17 then
            u3.Target = nil;

            if u3.LastStateBeforeInspection then
                if game.Workspace:GetAttribute("LastMenu") == u15 then
                    game:GetService("GamepadService"):DisableGamepadCursor();
                end;

                task.spawn(function() -- Line: 216
                    game:GetService("RunService"):UnbindFromRenderStep("LockOn");
                end);
            end;
        end;
    end;
end;

local function GetWorldToPosition(p19) -- Line: 224
    -- upvalues: workspace_CurrentCamera (ref)
    if p19 then
        local v20, v21 = workspace_CurrentCamera:WorldToScreenPoint(p19);

        return UDim2.fromOffset(v20.X, v20.Y), v21;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 231
    -- upvalues: u3 (copy), workspace_CurrentCamera (ref), PetActionUI (copy)
    if not u3.Active then
        return;
    end;

    if not u3.Target then
        u3:Toggle(false);

        return;
    end;

    local v22 = u3.Target.Position + Vector3.new(0, 2.5 + u3.Target.Size.Y / 2, 0);
    local v23, v24;

    if v22 then
        local v25;
        v25, v23 = workspace_CurrentCamera:WorldToScreenPoint(v22);
        v24 = UDim2.fromOffset(v25.X, v25.Y);
    else
        v23 = nil;
        v24 = nil;
    end;

    PetActionUI.Position = v23 and v24 and v24 or UDim2.fromScale(2, 2);
end);
u1.SENSOR.MouseButton1Down:Connect(function() -- Line: 241
    -- upvalues: u3 (copy), LocalPlayer (copy)
    u3:Toggle(false);
    LocalPlayer:SetAttribute("DontOpenAction", true);
    task.delay(0.3, function() -- Line: 247
        -- upvalues: LocalPlayer (ref)
        LocalPlayer:SetAttribute("DontOpenAction", false);
    end);
end);

function u3.Close() -- Line: 252
    -- upvalues: u3 (copy), LocalPlayer (copy)
    u3:Toggle(false);
    LocalPlayer:SetAttribute("DontOpenAction", true);
    task.delay(0.3, function() -- Line: 256
        -- upvalues: LocalPlayer (ref)
        LocalPlayer:SetAttribute("DontOpenAction", false);
    end);
end;

local function DisableIfNoHover() -- Line: 261
    -- upvalues: u3 (copy), CheckIfHoveringButton (copy), LocalPlayer (copy)
    if not u3.Active then
        return;
    end;

    if CheckIfHoveringButton() then
        return;
    end;

    u3:Toggle(false);
    LocalPlayer:SetAttribute("DontOpenAction", true);
    task.delay(0.3, function() -- Line: 270
        -- upvalues: LocalPlayer (ref)
        LocalPlayer:SetAttribute("DontOpenAction", false);
    end);
end;

local u26 = {
    [Enum.UserInputType.MouseButton1] = {
        Activate = function() -- Line: 277
        end
    }
};
local u27 = {
    [Enum.UserInputType.MouseButton1] = {
        Deactivate = function() -- Line: 285
            -- upvalues: DisableIfNoHover (copy)
            DisableIfNoHover();
        end
    }
};
UserInputService.InputBegan:Connect(function(p28, p29) -- Line: 291
    -- upvalues: u26 (copy)
    if p29 then
        return;
    end;

    local v30 = u26[p28.KeyCode] or u26[p28.UserInputType];

    if not v30 then
        return;
    end;

    for _, v in v30 do
        task.spawn(v);
    end;
end);
UserInputService.InputEnded:Connect(function(p31, p32) -- Line: 302
    -- upvalues: u27 (copy)
    if p32 then
        return;
    end;

    local v33 = u27[p31.KeyCode] or u27[p31.UserInputType];

    if not v33 then
        return;
    end;

    for _, v in v33 do
        task.spawn(v);
    end;
end);
UserInputService.TouchTap:Connect(function() -- Line: 312
    -- upvalues: DisableIfNoHover (copy)
    DisableIfNoHover();
end);

return u3;