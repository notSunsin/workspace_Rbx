-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local u1 = {
    GuessFromTouch = true,
    Platforms = {
        Computer = 1,
        Console = 2,
        Mobile = 3,
        UnknownComputerOrMobile = 4
    }
};
local u2 = {};

for i, v in u1.Platforms do
    u2[v] = i;
end;

local function _GetPlatform() -- Line: 20
    -- upvalues: GuiService (copy), u1 (copy), UserInputService (copy)
    if GuiService:IsTenFootInterface() then
        return u1.Platforms.Console;
    end;

    if UserInputService.VREnabled then
        return u1.Platforms.Computer;
    end;

    local v3 = 0;
    local v4 = 0;

    if UserInputService.GyroscopeEnabled then
        v4 = v4 + 2;
    end;

    if UserInputService.AccelerometerEnabled then
        v4 = v4 + 2;
    end;

    if UserInputService.KeyboardEnabled then
        v3 = v3 + 1;
    end;

    if UserInputService.MouseEnabled then
        v3 = v3 + 1;
    end;

    if UserInputService.GamepadEnabled then
        v3 = v3 + 1;
    end;

    if v4 ~= v3 then
        if v3 < v4 then
            return u1.Platforms.Mobile;
        end;

        return u1.Platforms.Computer;
    end;

    if not u1.GuessFromTouch then
        return u1.Platforms.UnknownComputerOrMobile;
    end;

    if UserInputService.TouchEnabled then
        return u1.Platforms.Mobile;
    end;

    return u1.Platforms.Computer;
end;

function u1.GetPlatform(p5) -- Line: 58
    -- upvalues: u1 (copy), u2 (copy)
    return u2[u1:_GetPlatform()];
end;

function u1.GetOperatingSystem(p6) -- Line: 64
    -- upvalues: u1 (copy), UserInputService (copy)
    local success, result = pcall(function() -- Line: 65
        return Version():split(".")[1] == "2";
    end);

    if success and result then
        return "ChromeOS";
    end;

    local os_date_ret = os.date("%Z", os.time());
    local Platform = u1:GetPlatform();
    local v7 = #os_date_ret <= 5;

    if Platform == "Computer" then
        return v7 and "MacOSX / Linux" or "Windows";
    end;

    if Platform ~= "Mobile" then
        if Platform ~= "Console" then
            return "Unknown";
        end;

        local ImageForKeyCode = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonA);
        local StringForKeyCode = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA);

        return (ImageForKeyCode == "rbxassetid://textures/ui/Controls/XboxController/ButtonA@2x.png" and true or StringForKeyCode == "ButtonA") and "Xbox" or ((ImageForKeyCode == "rbxasset://textures/ui/Controls/PlayStationController/ButtonCross@2x.png" and true or StringForKeyCode == "ButtonCross") and "PlayStation" or "Unknown-Console");
    end;

    local X = UserInputService:GetDeviceAcceleration().Position.X;
    local v8 = tostring(X);
    local string_split_ret = string.split(v8, ".");
    local v9 = string_split_ret[2];
    local v10 = v9 and #string_split_ret[2] or v9;

    return v10 and UserInputService.AccelerometerEnabled and (v10 <= 2 and "Android" or "iOS") or "Unknown-Mobile";
end;

return u1;