-- Decompiled with Potassium's decompiler.

local u1 = { 0, 2, 2, 2 };

return function(p2: number) -- Line: 22, Name: FormatDuration
    -- upvalues: u1 (copy)
    local v3 = type(p2) == "number";
    assert(v3);

    if p2 == (1 / 0) then
        return "Infinity";
    end;

    if p2 ~= p2 then
        return "NaN";
    end;

    local math_max_ret = math.max(0, p2);
    local math_ceil_ret = math.ceil(math_max_ret);
    local v4 = math_ceil_ret % 60;
    local v5 = math_ceil_ret // 60;
    local v6 = v5 // 60;
    local v7 = {
        v6 // 24,
        v6 % 24,
        v5 % 60,
        v4
    };
    local v8 = #v7;

    for i, v in ipairs(v7) do
        if v > 0 then
            v8 = i;
            break;
        end;
    end;

    if v8 == #v7 then
        return tostring(v4) .. "s";
    end;

    local v9 = { (tostring(v7[v8])) };

    for i = v8 + 1, #v7 do
        local v10 = tostring(v7[i]);
        local _ = i;

        while #v10 < u1[i] do
            v10 = "0" .. v10;
        end;

        table.insert(v9, ":" .. v10);
    end;

    return table.concat(v9);
end;