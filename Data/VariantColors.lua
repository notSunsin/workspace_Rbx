-- Decompiled with Potassium's decompiler.

local u1 = {
    Colors = {
        Normal = Color3.fromRGB(255, 255, 255),
        Silver = Color3.fromRGB(222, 222, 222),
        Gold = Color3.fromRGB(255, 215, 0),
        Rainbow = Color3.fromRGB(255, 0, 0),
        Diamond = Color3.fromRGB(0, 255, 247),
        Jelly = Color3.fromRGB(168, 0, 255),
        Ember = Color3.fromRGB(255, 85, 0)
    }
};

local function Color3ToHex(p2) -- Line: 14
    if not p2 then
        return nil;
    end;

    local math_floor_ret = math.floor(p2.R * 255);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, 255);
    local math_floor_ret2 = math.floor(p2.G * 255);
    local math_clamp_ret2 = math.clamp(math_floor_ret2, 0, 255);
    local math_floor_ret3 = math.floor(p2.B * 255);
    local math_clamp_ret3 = math.clamp(math_floor_ret3, 0, 255);

    return string.format("#%02X%02X%02X", math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
end;

function u1.GetColor3(p3: table, p4: string?) -- Line: 25
    -- upvalues: u1 (copy)
    if p4 then
        return u1.Colors[p4] or nil;
    end;

    return nil;
end;

function u1.GetHex(p5: table, p6: string?) -- Line: 37
    -- upvalues: u1 (copy), Color3ToHex (copy)
    if not p6 then
        return nil;
    end;

    local v7 = u1.Colors[p6];

    if v7 then
        return Color3ToHex(v7) or nil;
    end;

    return nil;
end;

return u1;