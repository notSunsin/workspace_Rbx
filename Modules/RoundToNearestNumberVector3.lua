-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RoundToNearestNumber = require(ReplicatedStorage.Modules.RoundToNearestNumber);

return function(p1: vector, p2: number) -- Line: 5, Name: RoundToNearestVector3
    -- upvalues: RoundToNearestNumber (copy)
    local v3 = p2 or 0.25;
    local v4 = RoundToNearestNumber(p1.X, v3);
    local v5 = RoundToNearestNumber(p1.Y, v3);

    return Vector3.new(v4, v5, RoundToNearestNumber(p1.Z, v3));
end;