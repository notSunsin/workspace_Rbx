-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

return function() -- Line: 3, Name: isMobile
    -- upvalues: UserInputService (copy)
    local TouchEnabled = UserInputService.TouchEnabled;

    if TouchEnabled then
        TouchEnabled = not (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled) and not UserInputService.GamepadEnabled;
    end;

    return TouchEnabled;
end;