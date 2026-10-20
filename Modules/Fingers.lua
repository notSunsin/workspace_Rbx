-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local u1 = {};
UserInputService.InputBegan:Connect(function(p2) -- Line: 5
    -- upvalues: u1 (copy)
    if p2.UserInputType ~= Enum.UserInputType.Touch then
        return;
    end;

    u1[p2] = true;
end);
UserInputService.InputEnded:Connect(function(p3) -- Line: 10
    -- upvalues: u1 (copy)
    if p3.UserInputType ~= Enum.UserInputType.Touch then
        return;
    end;

    u1[p3] = nil;
end);

return {
    Get = function(p4) -- Line: 17, Name: Get
        -- upvalues: u1 (copy)
        return u1;
    end,

    GetOne = function(p5) -- Line: 21, Name: GetOne
        -- upvalues: u1 (copy)
        return next(u1);
    end
};