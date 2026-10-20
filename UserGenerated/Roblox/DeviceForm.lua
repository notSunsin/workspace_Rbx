-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local TextService = game:GetService("TextService");
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");

local function SafeGet(u1: any, u2: string, p3: any) -- Line: 34
    local success, result = pcall(function() -- Line: 35
        -- upvalues: u1 (copy), u2 (copy)
        return u1[u2];
    end);

    if success then
        return result;
    end;

    return p3;
end;

local function IsWindows() -- Line: 41
    -- upvalues: GuiService (copy)
    local u4 = GuiService;
    local u5 = "IsWindows";
    local success, result = pcall(function() -- Line: 35
        -- upvalues: u4 (copy), u5 (copy)
        return u4[u5];
    end);

    if success then
        return result;
    end;

    return false;
end;

local function GetCharacterSize(p6: number) -- Line: 45
    -- upvalues: TextService (copy)
    return TextService:GetTextSize(utf8.char(p6), 16, Enum.Font.SourceSans, Vector2.new(1000, 1000));
end;

local TextSize = TextService:GetTextSize(utf8.char(65535), 16, Enum.Font.SourceSans, Vector2.new(1000, 1000));

local function IsValidCharacter(p7: number) -- Line: 51
    -- upvalues: TextService (copy), TextSize (copy)
    return TextService:GetTextSize(utf8.char(p7), 16, Enum.Font.SourceSans, Vector2.new(1000, 1000)) ~= TextSize;
end;

return table.freeze({
    DetectorVersion = "heuristic_v1",

    Get = function() -- Line: 106, Name: Get
        -- upvalues: UserInputService (copy), GuiService (copy)
        if UserInputService.VREnabled then
            return Enum.DeviceForm.VR;
        end;

        if GuiService:IsTenFootInterface() then
            return Enum.DeviceForm.Console;
        end;

        local u8 = GuiService;
        local u9 = "IsWindows";
        local success, result = pcall(function() -- Line: 35
            -- upvalues: u8 (copy), u9 (copy)
            return u8[u9];
        end);

        if not success then
            result = false;
        end;

        if result then
            return Enum.DeviceForm.Desktop;
        end;

        if UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled then
            return Enum.DeviceForm.Phone;
        end;

        if UserInputService.MouseEnabled then
            return Enum.DeviceForm.Desktop;
        end;

        if UserInputService.TouchEnabled then
            return Enum.DeviceForm.Phone;
        end;

        if UserInputService.GamepadEnabled then
            return Enum.DeviceForm.Console;
        end;

        return nil;
    end,

    GetPlatform = function() -- Line: 57, Name: GetPlatform
        -- upvalues: UserInputService (copy), GuiService (copy), VRService (copy), TextService (copy), TextSize (copy)
        local v10 = tostring(version());
        local u11 = "";
        pcall(function() -- Line: 60
            -- upvalues: u11 (ref), UserInputService (ref)
            u11 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect):lower();
        end);
        local v12 = v10:find("^0%.") ~= nil;
        local v13 = GuiService:IsTenFootInterface() and v10:find("^1%.") ~= nil;
        local v14 = v10:find("^2%.") ~= nil;
        local v15 = UserInputService.VREnabled and VRService.VREnabled;
        local u16 = GuiService;
        local u17 = "IsWindows";
        local success, result = pcall(function() -- Line: 35
            -- upvalues: u16 (copy), u17 (copy)
            return u16[u17];
        end);

        if not success then
            result = false;
        end;

        local v18 = TextService:GetTextSize(utf8.char(63743), 16, Enum.Font.SourceSans, Vector2.new(1000, 1000)) ~= TextSize;

        if v13 then
            local v19 = u11:find("xbox") ~= nil;
            local v20 = u11:find("ps4") ~= nil;
            local v21 = u11:find("ps5") ~= nil;

            if v19 or result then
                return Enum.Platform.XBoxOne;
            end;

            if v20 then
                return Enum.Platform.PS4;
            end;

            if v21 then
                return Enum.Platform.PS5;
            end;
        else
            if v14 then
                if result then
                    return Enum.Platform.UWP;
                end;

                if v15 then
                    return Enum.Platform.MetaOS;
                end;

                if v18 then
                    return Enum.Platform.IOS;
                end;

                if UserInputService.TouchEnabled then
                    return Enum.Platform.Android;
                end;

                return Enum.Platform.Linux;
            end;

            if v12 then
                if result then
                    return Enum.Platform.Windows;
                end;

                return Enum.Platform.OSX;
            end;
        end;

        return Enum.Platform.None;
    end
});