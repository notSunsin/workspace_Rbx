-- Decompiled with Potassium's decompiler.

local v1 = {};
local math_sin = math.sin;
local math_cos = math.cos;
local math_abs = math.abs;
local math_max = math.max;
local math_pow = math.pow;

function v1.Circle(p2: table) -- Line: 17
    -- upvalues: math_sin (copy), math_cos (copy)
    return p2.CFrame * CFrame.new(math_sin(p2.Time) * p2.Radius, 0, math_cos(p2.Time) * p2.Radius);
end;

function v1.Heart(p3: table) -- Line: 27
    -- upvalues: math_sin (copy), math_pow (copy), math_cos (copy)
    return p3.CFrame * CFrame.new(math_pow(math_sin(p3.Time), 3) * 16 * p3.Radius / 17, 0, (math_cos(p3.Time) * 13 - math_cos(p3.Time * 2) * 5 - math_cos(p3.Time * 3) * 2 - math_cos(p3.Time * 4)) * p3.Radius / 17);
end;

function v1.Star(p4: table) -- Line: 41
    -- upvalues: math_cos (copy), math_sin (copy)
    local Time = p4.Time;
    local v5 = p4.Radius * (math_cos(Time * 5) * 0.35 + 0.65);

    return p4.CFrame * CFrame.new(math_sin(Time) * v5, 0, math_cos(Time) * v5);
end;

function v1.Triangle(p6: table) -- Line: 48
    -- upvalues: math_cos (copy), math_sin (copy)
    local Time = p6.Time;
    local v7 = p6.Radius * (math_cos(Time * 3) * 0.25 + 0.75);

    return p6.CFrame * CFrame.new(math_sin(Time) * v7, 0, math_cos(Time) * v7);
end;

function v1.Square(p8: table) -- Line: 55
    -- upvalues: math_sin (copy), math_cos (copy), math_abs (copy), math_max (copy)
    local Time = p8.Time;
    local v9 = math_sin(Time);
    local v10 = math_cos(Time);
    local v11 = math_max(math_abs(v9), (math_abs(v10)));

    if v11 == 0 then
        return p8.CFrame;
    end;

    return p8.CFrame * CFrame.new(v9 / v11 * p8.Radius, 0, v10 / v11 * p8.Radius);
end;

function v1.Diamond(p12: table) -- Line: 73
    -- upvalues: math_sin (copy), math_cos (copy), math_abs (copy)
    local Time = p12.Time;
    local v13 = math_sin(Time);
    local v14 = math_cos(Time);
    local v15 = math_abs(v13) + math_abs(v14);

    if v15 == 0 then
        return p12.CFrame;
    end;

    return p12.CFrame * CFrame.new(v13 / v15 * p12.Radius, 0, v14 / v15 * p12.Radius);
end;

function v1.Infinity(p16: table) -- Line: 91
    -- upvalues: math_sin (copy), math_cos (copy)
    local Time = p16.Time;
    local v17 = math_sin(Time);
    local v18 = math_sin(Time) * math_cos(Time);

    return p16.CFrame * CFrame.new(v17 * p16.Radius, 0, v18 * p16.Radius);
end;

return v1;