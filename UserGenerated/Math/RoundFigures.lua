-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10);

return function(p1: number, p2: number?, p3: number?, p4: function?) -- Line: 40, Name: RoundFigures
    -- upvalues: StableExp10 (copy)
    local v5 = type(p1) == "number";
    assert(v5);
    local v6 = p2 == nil and true or type(p2) == "number";
    assert(v6);
    local v7 = p3 == nil and true or type(p3) == "number";
    assert(v7);
    local v8 = p4 == nil and true or type(p4) == "function";
    assert(v8);

    if p1 ~= p1 or (p1 == (1 / 0) or p1 == (-1 / 0)) then
        return p1;
    end;

    local v9 = p3 or 1;
    local v10 = p4 or math.round;
    local math_sign_ret = math.sign(p1);

    if math_sign_ret == 0 then
        return 0;
    end;

    local v11 = p1 * math_sign_ret;
    local math_log10_ret = math.log10(v11);
    local v12 = math.floor(math_log10_ret) - (p2 or 3) + 1;

    if v9 ~= 1 then
        v11 = v11 / v9;
    end;

    return StableExp10(v10((StableExp10(v11, -v12))) * v9, v12) * math_sign_ret;
end;