-- Decompiled with Potassium's decompiler.

local v1 = {};

local function CurrentSlot(p2: number) -- Line: 49
    local v3 = workspace:GetServerTimeNow() / p2;

    return math.floor(v3);
end;

local function PickCraving(p4: number, p5: table) -- Line: 54
    local Options = p5.Options;
    local u6 = type(Options) == "table" and (#Options or 0) or 0;

    if u6 == 0 then
        return "";
    end;

    if u6 == 1 then
        return Options[1];
    end;

    local u7 = p5.HashNum or 2654435;

    local function pick(p8: number) -- Line: 67
        -- upvalues: u7 (copy), u6 (copy)
        return p8 * u7 % 2147483647 * 48271 % 2147483647 % u6;
    end;

    local v9 = p4 * u7 % 2147483647 * 48271 % 2147483647 % u6 + 1;

    if v9 == (p4 - 1) * u7 % 2147483647 * 48271 % 2147483647 % u6 + 1 then
        v9 = v9 % u6 + 1;
    end;

    return Options[v9];
end;

function v1.GetSeed(p10: table, p11: table) -- Line: 80
    local v12 = p11.Interval or 3600;
    local v13 = workspace:GetServerTimeNow() / v12;

    return math.floor(v13) * (p11.HashNum or 2654435);
end;

function v1.GetCurrentCraving(p14: table, p15: table) -- Line: 84
    -- upvalues: PickCraving (copy)
    local v16 = p15.Interval or 3600;
    local v17 = workspace:GetServerTimeNow() / v16;

    return PickCraving(math.floor(v17), p15);
end;

return v1;