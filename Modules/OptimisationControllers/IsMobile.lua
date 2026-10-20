-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.PlatformProvider);
require(ReplicatedStorage.Modules.IsDev);

return function() -- Line: 8, Name: IsMobile
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled;
end;