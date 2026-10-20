-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RotationXIcon = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CosmeticUI"):WaitForChild("RotationXIcon");
local ActualIcon = RotationXIcon:WaitForChild("ActualIcon");
local RoundToNearestNumber = require(ReplicatedStorage.Modules.RoundToNearestNumber);
local CosmeticRegistry = require(ReplicatedStorage.Data.CosmeticRegistry);
RotationXIcon.Visible = false;
local ROTATION_CONFIG = CosmeticRegistry.InputConfig.ROTATION_CONFIG;
local u1 = {
    Active = false,
    CurrentOffset = 0
};
local u2 = 0;

local function UpdatePosition() -- Line: 27
    -- upvalues: UserInputService (copy), GuiService (copy), RotationXIcon (copy)
    local MouseLocation = UserInputService:GetMouseLocation();
    local GuiInset = GuiService:GetGuiInset();
    RotationXIcon.Position = UDim2.fromOffset(MouseLocation.X + GuiInset.X, MouseLocation.Y - GuiInset.Y);
end;

function u1.Toggle(p3, p4) -- Line: 34
    -- upvalues: u1 (copy), UserInputService (copy), u2 (ref), GuiService (copy), RotationXIcon (copy), ActualIcon (copy)
    u1.CurrentOffset = 0;
    u1.Active = p4;
    u2 = UserInputService:GetMouseLocation().Y;
    local MouseLocation = UserInputService:GetMouseLocation();
    local GuiInset = GuiService:GetGuiInset();
    RotationXIcon.Position = UDim2.fromOffset(MouseLocation.X + GuiInset.X, MouseLocation.Y - GuiInset.Y);
    ActualIcon.Position = UDim2.fromScale(0.5, 0.5);
    RotationXIcon.Visible = p4;
end;

RunService.RenderStepped:Connect(function() -- Line: 49
    -- upvalues: u1 (copy), UserInputService (copy), u2 (ref), RoundToNearestNumber (copy), ROTATION_CONFIG (copy), ActualIcon (copy)
    if not u1.Active then
        return;
    end;

    local Y = UserInputService:GetMouseLocation().Y;
    local v5 = u1;
    v5.CurrentOffset = v5.CurrentOffset + (Y - u2);
    u2 = Y;
    local v6 = RoundToNearestNumber(u1.CurrentOffset, ROTATION_CONFIG.ROTATION_ROUNDING_PIXEL);
    ActualIcon.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(0, v6);
end);
local u9 = {
    [Enum.KeyCode.DPadLeft] = {
        Test = function() -- Line: 66
            -- upvalues: u1 (copy)
            local v7 = u1;
            v7.CurrentOffset = v7.CurrentOffset - 30;
        end
    },
    [Enum.KeyCode.DPadRight] = {
        Test = function() -- Line: 71
            -- upvalues: u1 (copy)
            local v8 = u1;
            v8.CurrentOffset = v8.CurrentOffset + 30;
        end
    }
};
local u10 = {};
UserInputService.InputBegan:Connect(function(u11, p12) -- Line: 81
    -- upvalues: u9 (copy)
    local v13 = u9[u11.KeyCode] or u9[u11.UserInputType];

    if not v13 then
        return;
    end;

    for _, v in v13 do
        task.spawn(function() -- Line: 85
            -- upvalues: v (copy), u11 (copy)
            v(u11);
        end);
    end;
end);
UserInputService.InputEnded:Connect(function(u14, p15) -- Line: 91
    -- upvalues: u10 (copy)
    local v16 = u10[u14.KeyCode] or u10[u14.UserInputType];

    if not v16 then
        return;
    end;

    for _, v in v16 do
        task.spawn(function() -- Line: 95
            -- upvalues: v (copy), u14 (copy)
            v(u14);
        end);
    end;
end);

return u1;