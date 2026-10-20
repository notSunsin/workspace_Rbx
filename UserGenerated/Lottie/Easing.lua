-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);

local function SampleCurve(p1: number, p2: number, p3: number, p4: number) -- Line: 20
    return ((p1 * p4 + p2) * p4 + p3) * p4;
end;

local function SampleDerivative(p5: number, p6: number, p7: number, p8: number) -- Line: 24
    return (p5 * 3 * p8 + p6 * 2) * p8 + p7;
end;

local function SolveCubicBezier(p9: number, p10: number, p11: number, p12: number, p13: number) -- Line: 28
    if p13 <= 0 then
        return 0;
    end;

    if p13 >= 1 then
        return 1;
    end;

    if p9 == p10 and p11 == p12 then
        return p13;
    end;

    local v14 = p9 * 3;
    local v15 = (p11 - p9) * 3 - v14;
    local v16 = 1 - v14 - v15;
    local v17 = p10 * 3;
    local v18 = (p12 - p10) * 3 - v17;
    local v19 = 1 - v17 - v18;
    local v20 = p13;

    for i = 1, 8 do
        local v21 = ((v16 * p13 + v15) * p13 + v14) * p13 - v20;

        if math.abs(v21) < 1e-7 then
            return ((v19 * p13 + v18) * p13 + v17) * p13;
        end;

        local v22 = (v16 * 3 * p13 + v15 * 2) * p13 + v14;

        if math.abs(v22) < 1e-7 then
            break;
        end;

        p13 = p13 - v21 / v22;
        local _ = i;
    end;

    local v23 = v20;
    local v24 = 0;
    local v25 = 1;

    for i = 1, 16 do
        local v26 = ((v16 * v20 + v15) * v20 + v14) * v20 - v23;

        if math.abs(v26) < 1e-7 then
            break;
        end;

        if v26 > 0 then
            v25 = v20;
            v20 = v24;
        end;

        v24 = v20;
        v20 = (v20 + v25) * 0.5;
        local _ = i;
    end;

    return ((v19 * v20 + v18) * v20 + v17) * v20;
end;

local function NormalizeHandle(p27: any, p28: number?) -- Line: 80
    return type(p27) ~= "number" and (p27[p28 or 1] or 0) or p27;
end;

local function LerpScalar(p29: number, p30: number, p31: number) -- Line: 90
    return p29 + (p30 - p29) * p31;
end;

local function LerpArray(p32: table, p33: table, p34: number) -- Line: 94
    local table_create_ret = table.create(#p32);

    for i = 1, #p32 do
        table_create_ret[i] = p32[i] + ((p33[i] or p32[i]) - p32[i]) * p34;
        local _ = i;
    end;

    return table_create_ret;
end;

local function LerpBezierShape(p35: any, p36: any, p37: number) -- Line: 102
    local table_create_ret = table.create(#p35.v);
    local table_create_ret2 = table.create(#p35.i);
    local table_create_ret3 = table.create(#p35.o);

    for i = 1, #p35.v do
        local v38 = p35.v[i];
        local v39 = p36.v[i];
        local v40 = p35.i[i];
        local v41 = p36.i[i];
        local v42 = p35.o[i];
        local v43 = p36.o[i];
        table_create_ret[i] = { v38[1] + (v39[1] - v38[1]) * p37, v38[2] + (v39[2] - v38[2]) * p37 };
        table_create_ret2[i] = { v40[1] + (v41[1] - v40[1]) * p37, v40[2] + (v41[2] - v40[2]) * p37 };
        table_create_ret3[i] = { v42[1] + (v43[1] - v42[1]) * p37, v42[2] + (v43[2] - v42[2]) * p37 };
        local _ = i;
    end;

    return {
        v = table_create_ret,
        i = table_create_ret2,
        o = table_create_ret3,
        c = p35.c
    };
end;

local function FindKeyframes(p44: table, p45: number) -- Line: 119
    local v46 = #p44;

    if v46 == 0 then
        return nil, nil, 0;
    end;

    if v46 == 1 then
        return p44[1], nil, 0;
    end;

    local v47 = p44[1];

    if p45 <= v47.t then
        return v47, nil, 0;
    end;

    for i = 2, v46 do
        local v48 = p44[i];

        if p45 < v48.t then
            return p44[i - 1], v48, i - 1;
        end;

        local _ = i;
    end;

    return p44[v46], nil, v46;
end;

local function ExtractValue(p49: table?) -- Line: 145
    if p49 == nil then
        return nil;
    end;

    if #p49 == 0 then
        return nil;
    end;

    if type(p49[1]) == "table" then
        return p49[1];
    end;

    return p49;
end;

local function Evaluate(p50: any, p51: number) -- Line: 161
    -- upvalues: FindKeyframes (copy), SolveCubicBezier (copy), LerpArray (copy), LerpBezierShape (copy)
    local a = p50.a;
    local k = p50.k;

    if a == nil or a == 0 then
        if type(k) == "number" then
            return k;
        end;

        if type(k) ~= "table" then
            return nil;
        end;

        if #k > 0 and type(k[1]) == "table" then
            return k[1];
        end;

        return k;
    end;

    local v52, v53, _ = FindKeyframes(k, p51);

    if v52 == nil then
        return nil;
    end;

    if v53 == nil then
        local s = v52.s;

        if s == nil or #s == 0 then
            s = nil;
        elseif type(s[1]) == "table" then
            s = s[1];
        end;

        if s ~= nil then
            return s;
        end;

        local e = v52.e;

        if e == nil then
            return nil;
        end;

        if #e == 0 then
            return nil;
        end;

        if type(e[1]) == "table" then
            return e[1];
        end;

        return e;
    end;

    if v52.h == 1 then
        local s = v52.s;

        if s == nil then
            return nil;
        end;

        if #s == 0 then
            return nil;
        end;

        if type(s[1]) == "table" then
            return s[1];
        end;

        return s;
    end;

    local t = v52.t;
    local v54 = v53.t - t;

    if v54 <= 0 then
        local s = v52.s;

        if s == nil then
            return nil;
        end;

        if #s == 0 then
            return nil;
        end;

        if type(s[1]) == "table" then
            return s[1];
        end;

        return s;
    end;

    local math_clamp_ret = math.clamp((p51 - t) / v54, 0, 1);
    local s = v52.s;

    if s == nil or #s == 0 then
        s = nil;
    elseif type(s[1]) == "table" then
        s = s[1];
    end;

    local s2 = v53.s;

    if s2 == nil or #s2 == 0 then
        s2 = nil;
    elseif type(s2[1]) == "table" then
        s2 = s2[1];
    end;

    if not s2 then
        s2 = v52.e;

        if s2 == nil or #s2 == 0 then
            s2 = nil;
        elseif type(s2[1]) == "table" then
            s2 = s2[1];
        end;
    end;

    if s == nil or s2 == nil then
        return s or s2;
    end;

    local o = v52.o;
    local i = v52.i;

    if o and i then
        local x = o.x;
        local v55 = type(x) ~= "number" and (x[1] or 0) or x;
        local y = o.y;
        local v56 = type(y) ~= "number" and (y[1] or 0) or y;
        local x2 = i.x;
        local v57 = type(x2) ~= "number" and (x2[1] or 0) or x2;
        local y2 = i.y;
        math_clamp_ret = SolveCubicBezier(v55, v56, v57, type(y2) ~= "number" and (y2[1] or 0) or y2, math_clamp_ret);
    end;

    if type(s) == "number" then
        return s + (s2 - s) * math_clamp_ret;
    end;

    if type(s) ~= "table" then
        return s;
    end;

    if #s > 0 and type(s[1]) == "number" then
        return LerpArray(s, s2, math_clamp_ret);
    end;

    return LerpBezierShape(s, s2, math_clamp_ret);
end;

return table.freeze({
    SolveCubicBezier = SolveCubicBezier,
    Evaluate = Evaluate,

    EvaluateScalar = function(p58: any, p59: number) -- Line: 242, Name: EvaluateScalar
        -- upvalues: Evaluate (copy)
        if p58 == nil then
            return p59;
        end;

        local v60 = Evaluate(p58, 0);

        if v60 == nil then
            return p59;
        end;

        if type(v60) == "number" then
            return v60;
        end;

        if type(v60) == "table" then
            return v60[1] or p59;
        end;

        return p59;
    end,

    EvaluateScalarAtFrame = function(p61: any, p62: number, p63: number) -- Line: 259, Name: EvaluateScalarAtFrame
        -- upvalues: Evaluate (copy)
        if p61 == nil then
            return p63;
        end;

        local v64 = Evaluate(p61, p62);

        if v64 == nil then
            return p63;
        end;

        if type(v64) == "number" then
            return v64;
        end;

        if type(v64) == "table" then
            return v64[1] or p63;
        end;

        return p63;
    end,

    EvaluateVector = function(p65: any, p66: number, p67: table) -- Line: 276, Name: EvaluateVector
        -- upvalues: Evaluate (copy)
        if p65 == nil then
            return p67;
        end;

        local v68 = Evaluate(p65, p66);

        if v68 == nil then
            return p67;
        end;

        if type(v68) == "table" then
            return v68;
        end;

        return type(v68) == "number" and { v68 } or p67;
    end,

    EvaluateColor = function(p69: any, p70: number) -- Line: 293, Name: EvaluateColor
        -- upvalues: Evaluate (copy)
        if p69 == nil then
            return Color3.new(1, 1, 1);
        end;

        local v71 = Evaluate(p69, p70);

        if v71 == nil then
            return Color3.new(1, 1, 1);
        end;

        if type(v71) == "table" then
            return Color3.new(v71[1] or 1, v71[2] or 1, v71[3] or 1);
        end;

        return Color3.new(1, 1, 1);
    end,

    EvaluateBezierShape = function(p72: any, p73: number) -- Line: 308, Name: EvaluateBezierShape
        -- upvalues: Evaluate (copy)
        if p72 == nil then
            return nil;
        end;

        local v74 = Evaluate(p72, p73);

        if v74 == nil then
            return nil;
        end;

        if type(v74) == "table" and (#v74 > 0 and type(v74[1]) ~= "number") then
            return v74;
        end;

        return nil;
    end,

    LerpArray = LerpArray
});