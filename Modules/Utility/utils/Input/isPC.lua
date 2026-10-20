-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

return function() -- Line: 3, Name: isPC
    -- upvalues: UserInputService (copy)
    return UserInputService.MouseEnabled and UserInputService.KeyboardEnabled;
end;