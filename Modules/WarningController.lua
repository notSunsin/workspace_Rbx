-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");

function v1.Acknowledge(p2, p3) -- Line: 5
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.WarningService.Acknowledge:FireServer(p3);
end;

return v1;