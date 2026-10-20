-- Decompiled with Potassium's decompiler.

local u1 = { "k", "m", "b", "t", "q", "Qt", "Sx", "Sp", "o", "n", "d", "u", "Du", "Tr" };

return function(p2: number, p3: number?, p4: number?) -- Line: 38, Name: FormatAbbreviated
    -- upvalues: u1 (copy)
    local v5 = type(p2) == "number";
    assert(v5);
    local v6 = p3 == nil and true or type(p3) == "number";
    assert(v6);
    local v7 = p4 == nil and true or type(p4) == "number";
    assert(v7);

    if p2 ~= p2 then
        return "NaN";
    end;

    if p2 == (1 / 0) then
        return "Infinity";
    end;

    if p2 == (-1 / 0) then
        return "-Infinity";
    end;

    local v8 = p3 or 3;
    local math_abs_ret = math.abs(p2);
    local math_pow_ret = math.pow(10, -#u1 * 3);
    local math_max_ret = math.max(math_abs_ret, math_pow_ret);
    local math_log10_ret = math.log10(math_max_ret);
    local math_ceil_ret = math.ceil(math_log10_ret);
    local v9 = 10 ^ (math.min(math_ceil_ret, #u1 * 3 + v8) - (p4 or 0) - v8);
    local v10 = math.round(math_max_ret / v9) * v9;
    local math_max_ret2 = math.max(v10, 1);
    local v11 = math.log10(math_max_ret2) / 3;
    local math_floor_ret = math.floor(v11);
    local math_min_ret = math.min(math_floor_ret, #u1);
    local v12 = v10 * math.sign(p2) / 10 ^ (math_min_ret * 3);
    local v13 = string.format("%f", v12):gsub("%.?0+$", "");

    if math_min_ret >= 1 then
        return v13 .. u1[math_min_ret];
    end;

    return v13;
end;