-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures);
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10);
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString);
local u1 = { "", "k", "m", "b", "t", "q", "Qt", "Sx", "Sp", "o", "n", "d", "u", "Du", "Tr" };

return function(p2: number) -- Line: 66, Name: FormatAbbreviated
    -- upvalues: u1 (copy), StableExp10 (copy), RoundFigures (copy), TrimmedNumberString (copy)
    local v3 = type(p2) == "number";
    assert(v3);

    if p2 ~= p2 then
        return "NaN";
    end;

    if p2 == (1 / 0) then
        return "Infinity";
    end;

    if p2 == (-1 / 0) then
        return "-Infinity";
    end;

    local v4 = {};

    if p2 < 0 then
        table.insert(v4, "-");
        p2 = -p2;
    end;

    local math_floor_ret = math.floor(p2);

    if math_floor_ret >= 1000 then
        local v5 = math.log10(math_floor_ret) / 3;
        local v6 = math.floor(v5) + 1;
        local math_clamp_ret = math.clamp(v6, 1, #u1);
        local v7 = RoundFigures(StableExp10(math_floor_ret, (math_clamp_ret - 1) * -3), 3, nil, math.floor);
        table.insert(v4, TrimmedNumberString(v7));
        table.insert(v4, u1[math_clamp_ret]);
    else
        table.insert(v4, TrimmedNumberString(math_floor_ret));
    end;

    return table.concat(v4);
end;