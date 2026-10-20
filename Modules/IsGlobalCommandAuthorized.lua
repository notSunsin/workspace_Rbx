-- Decompiled with Potassium's decompiler.

local u1 = { 10916243, 425901043, 327423121, 7627847305, 339310190, 14838908, 3296891394, 33372493, 355661302 };
local RunService = game:GetService("RunService");

if require(game:GetService("ReplicatedStorage").Modules.IsDev)() then
    table.insert(u1, 9099919347);
    table.insert(u1, 91074774);
    table.insert(u1, 49215350);
    table.insert(u1, 11492897308);
    table.insert(u1, 381042662);
    table.insert(u1, 14745425);
end;

return function(p2: userdata) -- Line: 25, Name: IsGlobalCommandAuthorized
    -- upvalues: RunService (copy), u1 (copy)
    return RunService:IsStudio() and true or table.find(u1, p2.UserId);
end;