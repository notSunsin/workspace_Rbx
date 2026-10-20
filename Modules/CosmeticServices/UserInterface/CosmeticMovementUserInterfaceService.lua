-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Fingers = require(ReplicatedStorage.Modules.Fingers);
local MovementIcon = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CosmeticUI"):WaitForChild("MovementIcon");
MovementIcon.Visible = false;
local u1 = {
    Active = false
};
local u2 = nil;

local function UpdatePosition() -- Line: 23
    -- upvalues: UserInputService (copy), GuiService (copy), MovementIcon (copy)
    local MouseLocation = UserInputService:GetMouseLocation();
    local GuiInset = GuiService:GetGuiInset();
    local _ = (FingerPosition or MouseLocation).X;
    MovementIcon.Position = UDim2.fromOffset(MouseLocation.X + GuiInset.X, MouseLocation.Y - GuiInset.Y);
end;

function u1.Toggle(p3, p4) -- Line: 31
    -- upvalues: u2 (ref), Fingers (copy), u1 (copy), UserInputService (copy), GuiService (copy), MovementIcon (copy)
    u2 = Fingers:GetOne();
    u1.Active = p4;
    local MouseLocation = UserInputService:GetMouseLocation();
    local GuiInset = GuiService:GetGuiInset();
    local _ = (FingerPosition or MouseLocation).X;
    MovementIcon.Position = UDim2.fromOffset(MouseLocation.X + GuiInset.X, MouseLocation.Y - GuiInset.Y);
    MovementIcon.Visible = p4;
end;

RunService.RenderStepped:Connect(function() -- Line: 38
    -- upvalues: u1 (copy), UserInputService (copy), GuiService (copy), MovementIcon (copy)
    if not u1.Active then
        return;
    end;

    local MouseLocation = UserInputService:GetMouseLocation();
    local GuiInset = GuiService:GetGuiInset();
    local _ = (FingerPosition or MouseLocation).X;
    MovementIcon.Position = UDim2.fromOffset(MouseLocation.X + GuiInset.X, MouseLocation.Y - GuiInset.Y);
end);

return u1;