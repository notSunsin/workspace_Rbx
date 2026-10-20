-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FormatOdds = require(ReplicatedStorage.UserGenerated.Strings.FormatOdds);
local FormatPercent = require(ReplicatedStorage.UserGenerated.Strings.FormatPercent);

return function(p1: number, p2: number?) -- Line: 31, Name: FormatChance
    -- upvalues: FormatOdds (copy), FormatPercent (copy)
    local v3 = type(p1) == "number";
    assert(v3);
    local v4 = p2 == nil and true or type(p2) == "number";
    assert(v4);
    local math_clamp_ret = math.clamp(p1, 0, 1);
    local math_clamp_ret2 = math.clamp(p2 or math_clamp_ret, 0, 1);

    if math_clamp_ret > 0 and (math_clamp_ret2 <= 0.0002 and math_clamp_ret <= 0.001) then
        return FormatOdds(math_clamp_ret);
    end;

    return FormatPercent(math_clamp_ret);
end;