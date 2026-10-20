-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

return function() -- Line: 3, Name: isConsole
    -- upvalues: UserInputService (copy)
    return UserInputService.GamepadEnabled;
end;