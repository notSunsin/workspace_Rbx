-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local Signal = require(script:WaitForChild("Signal"));
local u1 = {
    PC = {
        Enum.UserInputType.Keyboard,
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.MouseButton2,
        Enum.UserInputType.MouseButton3,
        Enum.UserInputType.MouseWheel,
        Enum.UserInputType.MouseMovement
    },
    Mobile = { Enum.UserInputType.Touch },
    Console = {
        Enum.UserInputType.Gamepad1,
        Enum.UserInputType.Gamepad2,
        Enum.UserInputType.Gamepad3,
        Enum.UserInputType.Gamepad4,
        Enum.UserInputType.Gamepad5,
        Enum.UserInputType.Gamepad6,
        Enum.UserInputType.Gamepad7,
        Enum.UserInputType.Gamepad8,
        Enum.KeyCode.ButtonX,
        Enum.KeyCode.ButtonA,
        Enum.KeyCode.ButtonB,
        Enum.KeyCode.ButtonY,
        Enum.KeyCode.ButtonL1,
        Enum.KeyCode.ButtonL2,
        Enum.KeyCode.ButtonL3,
        Enum.KeyCode.ButtonSelect,
        Enum.KeyCode.ButtonStart,
        Enum.KeyCode.ButtonR1,
        Enum.KeyCode.ButtonR2,
        Enum.KeyCode.ButtonR3
    }
};
local u2 = Signal.new();
local u3 = {
    CurrentPlatform = "PC",
    PlatformChanged = u2
};
local u4 = nil;

function u3.GetPlatform(p5) -- Line: 51
    -- upvalues: u3 (copy), UserInputService (copy), u1 (copy), u4 (ref)
    local CurrentPlatform = u3.CurrentPlatform;
    local LastInputType = UserInputService:GetLastInputType();

    for i, v in u1 do
        if table.find(v, LastInputType) or table.find(v, u4) then
            u3.CurrentPlatform = i;

            return i;
        end;
    end;

    return CurrentPlatform;
end;

UserInputService.InputChanged:Connect(function(p6) -- Line: 66
    -- upvalues: u3 (copy), u2 (copy)
    local CurrentPlatform = u3.CurrentPlatform;
    local Platform = u3:GetPlatform();

    if CurrentPlatform == Platform then
        return;
    end;

    u2:Fire(Platform);
end);
UserInputService.InputBegan:Connect(function(p7) -- Line: 72
    -- upvalues: u4 (ref), u3 (copy), u2 (copy)
    u4 = p7.KeyCode;
    local CurrentPlatform = u3.CurrentPlatform;
    local Platform = u3:GetPlatform();

    if CurrentPlatform == Platform then
        return;
    end;

    u2:Fire(Platform);
end);

return u3;