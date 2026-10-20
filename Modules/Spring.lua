-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local math_exp = math.exp;
local math_sin = math.sin;
local math_cos = math.cos;
local math_min = math.min;
local math_sqrt = math.sqrt;
local math_round = math.round;

local function magnitudeSq(p1: table) -- Line: 51
    local v2 = 0;

    for _, v in p1 do
        v2 = v2 + v ^ 2;
    end;

    return v2;
end;

local function distanceSq(p3: table, p4: table) -- Line: 59
    local v5 = 0;

    for i, v in p3 do
        v5 = v5 + (p4[i] - v) ^ 2;
    end;

    return v5;
end;

local u6 = {};
u6.__index = u6;

function u6.new(p7: number, p8: number, p9: any, p10: any, p11: any) -- Line: 89
    -- upvalues: u6 (copy)
    local v12 = p11.toIntermediate(p9);
    local v13 = {
        d = p7,
        f = p8,
        g = v12,
        p = v12,
        v = table.create(#v12, 0),
        typedat = p11,
        rawGoal = p10
    };

    return setmetatable(v13, u6);
end;

function u6.setGoal(p14, p15) -- Line: 105
    p14.rawGoal = p15;
    p14.g = p14.typedat.toIntermediate(p15);
end;

function u6.setDampingRatio(p16: any, p17: number) -- Line: 110
    p16.d = p17;
end;

function u6.setFrequency(p18: any, p19: number) -- Line: 114
    p18.f = p19;
end;

function u6.canSleep(p20) -- Line: 118
    local v21 = 0;

    for _, v in p20.v do
        v21 = v21 + v ^ 2;
    end;

    if v21 > 0.0001 then
        return false;
    end;

    local g = p20.g;
    local v22 = 0;

    for i, v in p20.p do
        v22 = v22 + (g[i] - v) ^ 2;
    end;

    return v22 <= 6.781684027777778e-8;
end;

function u6.step(p23: any, p24: number) -- Line: 130
    -- upvalues: math_exp (copy), math_sqrt (copy), math_cos (copy), math_sin (copy)
    local d = p23.d;
    local v25 = p23.f * 2 * 3.141592653589793;
    local g = p23.g;
    local p = p23.p;
    local v = p23.v;

    if d == 1 then
        local v26 = math_exp(-v25 * p24);
        local v27 = p24 * v26;
        local v28 = v26 + v27 * v25;
        local v29 = v26 - v27 * v25;
        local v30 = v27 * v25 * v25;

        for i = 1, #p do
            local v31 = p[i] - g[i];
            p[i] = v31 * v28 + v[i] * v27 + g[i];
            v[i] = v[i] * v29 - v31 * v30;
            local _ = i;
        end;
    elseif d < 1 then
        local v32 = math_exp(-d * v25 * p24);
        local v33 = math_sqrt(1 - d * d);
        local v34 = math_cos(p24 * v25 * v33);
        local v35 = math_sin(p24 * v25 * v33);
        local v36;

        if v33 > 0.00001 then
            v36 = v35 / v33;
        else
            local v37 = p24 * v25;
            v36 = v37 + (v37 * v37 * (v33 * v33) * (v33 * v33) / 20 - v33 * v33) * (v37 * v37 * v37) / 6;
        end;

        local v38;

        if v25 * v33 > 0.00001 then
            v38 = v35 / (v25 * v33);
        else
            local v39 = v25 * v33;
            v38 = p24 + (p24 * p24 * (v39 * v39) * (v39 * v39) / 20 - v39 * v39) * (p24 * p24 * p24) / 6;
        end;

        for i = 1, #p do
            local v40 = p[i] - g[i];
            p[i] = (v40 * (v34 + v36 * d) + v[i] * v38) * v32 + g[i];
            v[i] = (v[i] * (v34 - v36 * d) - v40 * (v36 * v25)) * v32;
            local _ = i;
        end;
    else
        local v41 = math_sqrt(d * d - 1);
        local v42 = -v25 * (d - v41);
        local v43 = -v25 * (d + v41);
        local v44 = math_exp(v42 * p24);
        local v45 = math_exp(v43 * p24);

        for i = 1, #p do
            local v46 = p[i] - g[i];
            local v47 = (v[i] - v46 * v42) / (2 * v25 * v41);
            local v48 = v44 * (v46 - v47);
            p[i] = v48 + v47 * v45 + g[i];
            v[i] = v48 * v42 + v47 * v45 * v43;
            local _ = i;
        end;
    end;

    return p23.typedat.fromIntermediate(p23.p);
end;

local u49 = {};
u49.__index = u49;

local function angleBetween(p50, p51) -- Line: 246
    local _, v52 = p51:ToObjectSpace(p50):ToAxisAngle();

    return math.abs(v52);
end;

local function matrixToAxis(p53) -- Line: 251
    local v54, v55 = p53:ToAxisAngle();

    return v54 * v55;
end;

local function axisToMatrix(p56: vector) -- Line: 256
    local Magnitude = p56.Magnitude;

    if Magnitude > 1e-6 then
        return CFrame.fromAxisAngle(p56.Unit, Magnitude);
    end;

    return CFrame.identity;
end;

function u49.new(p57: number, p58: number, p59, p60) -- Line: 264
    -- upvalues: u49 (copy)
    return setmetatable({
        v = Vector3.new(0, 0, 0),
        d = p57,
        f = p58,
        g = p60,
        p = p59
    }, u49);
end;

function u49.setGoal(p61: any, p62) -- Line: 277
    p61.g = p62;
end;

function u49.setDampingRatio(p63: any, p64: number) -- Line: 281
    p63.d = p64;
end;

function u49.setFrequency(p65: any, p66: number) -- Line: 285
    p65.f = p66;
end;

function u49.canSleep(p67) -- Line: 289
    local _, v68 = p67.g:ToObjectSpace(p67.p):ToAxisAngle();

    return math.abs(v68) < 0.00017453292519943296 and p67.v.Magnitude < 0.0017453292519943296;
end;

function u49.step(p69: any, p70: number) -- Line: 295
    -- upvalues: math_exp (copy), math_sqrt (copy), math_cos (copy), math_sin (copy)
    local d = p69.d;
    local v71 = p69.f * 2 * 3.141592653589793;
    local g = p69.g;
    local v = p69.v;
    local v72, v73 = (p69.p * g:Inverse()):ToAxisAngle();
    local v74 = v72 * v73;
    local v75 = math_exp(-d * v71 * p70);
    local v76, v77;

    if d == 1 then
        local _ = p70 * v75;
        local v78 = (v74 * (1 + v71 * p70) + v * p70) * v75;
        local Magnitude = v78.Magnitude;
        local v79;

        if Magnitude > 1e-6 then
            v79 = CFrame.fromAxisAngle(v78.Unit, Magnitude);
        else
            v79 = CFrame.identity;
        end;

        v76 = v79 * g;
        v77 = (v * (1 - p70 * v71) - v74 * (p70 * v71 * v71)) * v75;
    elseif d < 1 then
        local v80 = math_sqrt(1 - d * d);
        local v81 = math_cos(p70 * v71 * v80);
        local v82 = math_sin(p70 * v71 * v80);
        local v83 = v82 / v80;
        local v84 = (v74 * (v81 + v83 * d) + v * (v82 / (v71 * v80))) * v75;
        local Magnitude = v84.Magnitude;
        local v85;

        if Magnitude > 1e-6 then
            v85 = CFrame.fromAxisAngle(v84.Unit, Magnitude);
        else
            v85 = CFrame.identity;
        end;

        v76 = v85 * g;
        v77 = (v * (v81 - v83 * d) - v74 * (v83 * v71)) * v75;
    else
        local v86 = math_sqrt(d * d - 1);
        local v87 = -v71 * (d - v86);
        local v88 = -v71 * (d + v86);
        local v89 = (v - v74 * v87) / (2 * v71 * v86);
        local v90 = (v74 - v89) * math_exp(v87 * p70);
        local v91 = v89 * math_exp(v88 * p70);
        local v92 = v90 + v91;
        local Magnitude = v92.Magnitude;
        local v93;

        if Magnitude > 1e-6 then
            v93 = CFrame.fromAxisAngle(v92.Unit, Magnitude);
        else
            v93 = CFrame.identity;
        end;

        v76 = v93 * g;
        v77 = v90 * v87 + v91 * v88;
    end;

    p69.p = v76;
    p69.v = v77;

    return v76;
end;

local u96 = {
    springType = u6.new,

    toIntermediate = function(p94) -- Line: 353, Name: toIntermediate
        return { p94.X, p94.Y, p94.Z };
    end,

    fromIntermediate = function(p95: table) -- Line: 357, Name: fromIntermediate
        return Vector3.new(p95[1], p95[2], p95[3]);
    end
};
local u97 = {};
u97.__index = u97;

function u97.new(p98: number, p99: number, p100, p101, p102: any) -- Line: 367
    -- upvalues: u6 (copy), u96 (copy), u49 (copy), u97 (copy)
    local v103 = {
        rawGoal = p101,
        _position = u6.new(p98, p99, p100.Position, p101.Position, u96),
        _rotation = u49.new(p98, p99, p100.Rotation, p101.Rotation)
    };

    return setmetatable(v103, u97);
end;

function u97.setGoal(p104: table, p105) -- Line: 384
    p104.rawGoal = p105;
    p104._position:setGoal(p105.Position);
    p104._rotation:setGoal(p105.Rotation);
end;

function u97.setDampingRatio(p106: table, p107: number) -- Line: 390
    p106._position:setDampingRatio(p107);
    p106._rotation:setDampingRatio(p107);
end;

function u97.setFrequency(p108: table, p109: number) -- Line: 395
    p108._position:setFrequency(p109);
    p108._rotation:setFrequency(p109);
end;

function u97.canSleep(p110) -- Line: 400
    local v111 = p110._position:canSleep() and p110._rotation:canSleep();

    return v111;
end;

function u97.step(p112, p113) -- Line: 404
    local v114 = p112._position:step(p113);

    return p112._rotation:step(p113) + v114;
end;

local function inverseGammaCorrectD65(p115) -- Line: 415
    return p115 < 0.0404482362771076 and p115 / 12.92 or 0.87941546140213 * (p115 + 0.055) ^ 2.4;
end;

local function gammaCorrectD65(p116) -- Line: 419
    return p116 < 0.0031306684425 and 12.92 * p116 or 1.055 * p116 ^ 0.4166666666666667 - 0.055;
end;

local function rgbToLuv(p117) -- Line: 423
    local R = p117.R;
    local G = p117.G;
    local B = p117.B;
    local v118 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4;
    local v119 = G < 0.0404482362771076 and G / 12.92 or 0.87941546140213 * (G + 0.055) ^ 2.4;
    local v120 = B < 0.0404482362771076 and B / 12.92 or 0.87941546140213 * (B + 0.055) ^ 2.4;
    local v121 = 0.9257063972951867 * v118 - 0.8333736323779866 * v119 - 0.09209820666085898 * v120;
    local v122 = 0.2125862307855956 * v118 + 0.7151703037034108 * v119 + 0.0722004986433362 * v120;
    local v123 = 3.6590806972265884 * v118 + 11.442689580057424 * v119 + 4.114991502426484 * v120;
    local v124 = v122 > 0.008856451679035631 and 116 * v122 ^ 0.3333333333333333 - 16 or 903.296296296296 * v122;
    local v125, v126;

    if v123 > 1e-14 then
        v125 = v124 * v121 / v123;
        v126 = v124 * (9 * v122 / v123 - 0.46832);
    else
        v125 = -0.19783 * v124;
        v126 = -0.46832 * v124;
    end;

    return { v124, v125, v126 };
end;

local function luvToRgb(p127: table) -- Line: 452
    -- upvalues: math_min (copy)
    local v128 = p127[1];

    if v128 < 0.0197955 then
        return Color3.new(0, 0, 0);
    end;

    local v129 = p127[2] / v128 + 0.19783;
    local v130 = p127[3] / v128 + 0.46832;
    local v131 = (v128 + 16) / 116;
    local v132 = v131 > 0.20689655172413793 and v131 * v131 * v131 or v131 * 0.12841854934601665 - 0.01771290335807126;
    local v133 = v132 * v129 / v130;
    local v134 = v132 * ((3 - v129 * 0.75) / v130 - 5);
    local v135 = v133 * 7.2914074 - v132 * 1.537208 - v134 * 0.4986286;
    local v136 = v133 * -2.180094 + v132 * 1.8757561 + v134 * 0.0415175;
    local v137 = v133 * 0.1253477 - v132 * 0.2040211 + v134 * 1.0569959;

    if v135 < 0 and (v135 < v136 and v135 < v137) then
        v136 = v136 - v135;
        v137 = v137 - v135;
        v135 = 0;
    elseif v136 < 0 and v136 < v137 then
        v135 = v135 - v136;
        v137 = v137 - v136;
        v136 = 0;
    elseif v137 < 0 then
        v135 = v135 - v137;
        v136 = v136 - v137;
        v137 = 0;
    end;

    return Color3.new(math_min(v135 < 0.0031306684425 and 12.92 * v135 or 1.055 * v135 ^ 0.4166666666666667 - 0.055, 1), math_min(v136 < 0.0031306684425 and 12.92 * v136 or 1.055 * v136 ^ 0.4166666666666667 - 0.055, 1), (math_min(v137 < 0.0031306684425 and 12.92 * v137 or 1.055 * v137 ^ 0.4166666666666667 - 0.055, 1)));
end;

local u154 = {
    boolean = {
        springType = u6.new,

        toIntermediate = function(p138) -- Line: 498, Name: toIntermediate
            return { p138 and 1 or 0 };
        end,

        fromIntermediate = function(p139) -- Line: 502, Name: fromIntermediate
            return p139[1] >= 0.5;
        end
    },
    number = {
        springType = u6.new,

        toIntermediate = function(p140) -- Line: 510, Name: toIntermediate
            return { p140 };
        end,

        fromIntermediate = function(p141) -- Line: 514, Name: fromIntermediate
            return p141[1];
        end
    },
    NumberRange = {
        springType = u6.new,

        toIntermediate = function(p142) -- Line: 522, Name: toIntermediate
            return { p142.Min, p142.Max };
        end,

        fromIntermediate = function(p143) -- Line: 526, Name: fromIntermediate
            return NumberRange.new(p143[1], p143[2]);
        end
    },
    UDim = {
        springType = u6.new,

        toIntermediate = function(p144) -- Line: 534, Name: toIntermediate
            return { p144.Scale, p144.Offset };
        end,

        fromIntermediate = function(p145: table) -- Line: 538, Name: fromIntermediate
            -- upvalues: math_round (copy)
            return UDim.new(p145[1], (math_round(p145[2])));
        end
    },
    UDim2 = {
        springType = u6.new,

        toIntermediate = function(p146) -- Line: 546, Name: toIntermediate
            local X = p146.X;
            local Y = p146.Y;

            return {
                X.Scale,
                X.Offset,
                Y.Scale,
                Y.Offset
            };
        end,

        fromIntermediate = function(p147: table) -- Line: 552, Name: fromIntermediate
            -- upvalues: math_round (copy)
            return UDim2.new(p147[1], math_round(p147[2]), p147[3], (math_round(p147[4])));
        end
    },
    Vector2 = {
        springType = u6.new,

        toIntermediate = function(p148) -- Line: 560, Name: toIntermediate
            return { p148.X, p148.Y };
        end,

        fromIntermediate = function(p149: table) -- Line: 564, Name: fromIntermediate
            return Vector2.new(p149[1], p149[2]);
        end
    },
    Vector3 = u96,
    Color3 = {
        springType = u6.new,
        toIntermediate = rgbToLuv,
        fromIntermediate = luvToRgb
    },
    ColorSequence = {
        springType = u6.new,

        toIntermediate = function(p150) -- Line: 581, Name: toIntermediate
            -- upvalues: rgbToLuv (ref)
            local Keypoints = p150.Keypoints;
            local v151 = rgbToLuv(Keypoints[1].Value);
            local v152 = rgbToLuv(Keypoints[#Keypoints].Value);

            return {
                v151[1],
                v151[2],
                v151[3],
                v152[1],
                v152[2],
                v152[3]
            };
        end,

        fromIntermediate = function(p153: table) -- Line: 593, Name: fromIntermediate
            -- upvalues: luvToRgb (ref)
            return ColorSequence.new(luvToRgb({ p153[1], p153[2], p153[3] }), luvToRgb({ p153[4], p153[5], p153[6] }));
        end
    },
    CFrame = {
        springType = u97.new,
        toIntermediate = error,
        fromIntermediate = error
    }
};
local u161 = {
    Pivot = {
        class = "PVInstance",

        get = function(p155: userdata) -- Line: 619, Name: get
            return p155:GetPivot();
        end,

        set = function(p156: userdata, p157) -- Line: 622, Name: set
            p156:PivotTo(p157);
        end
    },
    Scale = {
        class = "Model",

        get = function(p158: userdata) -- Line: 628, Name: get
            return p158:GetScale();
        end,

        set = function(p159: userdata, p160: number) -- Line: 631, Name: set
            p159:ScaleTo(p160);
        end
    }
};

local function getProperty(p162: userdata, p163: string) -- Line: 637
    -- upvalues: u161 (copy)
    local v164 = u161[p163];

    if v164 and p162:IsA(v164.class) then
        return v164.get(p162);
    end;

    return p162[p163];
end;

local function setProperty(p165: userdata, p166: string, p167: any) -- Line: 646
    -- upvalues: u161 (copy)
    local v168 = u161[p166];

    if v168 and p165:IsA(v168.class) then
        v168.set(p165, p167);

        return;
    end;

    p165[p166] = p167;
end;

local u169 = {};
local u170 = {};
RunService.Heartbeat:Connect(function(p171) -- Line: 659
    -- upvalues: u169 (copy), u161 (copy), u170 (copy)
    for i, v in u169 do
        local v172 = i;
        local v173 = v;

        for i2, v2 in v do
            if v2:canSleep() then
                v173[i2] = nil;
                local rawGoal = v2.rawGoal;
                local v174 = u161[i2];

                if v174 and v172:IsA(v174.class) then
                    v174.set(v172, rawGoal);
                else
                    v172[i2] = rawGoal;
                end;
            else
                local v175 = v2:step(p171);
                local v176 = u161[i2];

                if v176 and v172:IsA(v176.class) then
                    v176.set(v172, v175);
                else
                    v172[i2] = v175;
                end;
            end;
        end;

        if not next(v173) then
            u169[v172] = nil;
            local v177 = u170[v172];

            if v177 then
                u170[v172] = nil;

                for _, v2 in v177 do
                    task.spawn(v2);
                end;
            end;
        end;
    end;
end);

local function assertType(p178: number, p179: string, p180: string, p181: any) -- Line: 688
    if not p180:find((typeof(p181))) then
        error(`bad argument #{p178} to {p179} ({p180} expected, got {typeof(p181)})`, 3);
    end;
end;

return table.freeze({
    target = function(p182: userdata, p183: number, p184: number, p185: table) -- Line: 697, Name: target
        -- upvalues: u169 (copy), u161 (copy), u154 (copy)
        if not ("Instance"):find((typeof(p182))) then
            error(`bad argument #{1} to spr.target (Instance expected, got {typeof(p182)})`, 3);
        end;

        if not ("number"):find((typeof(p183))) then
            error(`bad argument #{2} to spr.target (number expected, got {typeof(p183)})`, 3);
        end;

        if not ("number"):find((typeof(p184))) then
            error(`bad argument #{3} to spr.target (number expected, got {typeof(p184)})`, 3);
        end;

        if not ("table"):find((typeof(p185))) then
            error(`bad argument #{4} to spr.target (table expected, got {typeof(p185)})`, 3);
        end;

        if p183 ~= p183 or p183 < 0 then
            error(("expected damping ratio >= 0; got %.2f"):format(p183), 2);
        end;

        if p184 ~= p184 or p184 < 0 then
            error(("expected undamped frequency >= 0; got %.2f"):format(p184), 2);
        end;

        local v186 = u169[p182];

        if not v186 then
            v186 = {};
            u169[p182] = v186;
        end;

        for i, v in p185 do
            local v187 = u161[i];
            local v188;

            if v187 and p182:IsA(v187.class) then
                v188 = v187.get(p182);
            else
                v188 = p182[i];
            end;

            if typeof(v) ~= typeof(v188) then
                error(`bad property {i} to spr.target ({typeof(v188)} expected, got {typeof(v)})`, 2);
            end;

            if p184 == (1 / 0) then
                local v189 = u161[i];

                if v189 and p182:IsA(v189.class) then
                    v189.set(p182, v);
                else
                    p182[i] = v;
                end;

                v186[i] = nil;
            else
                local v190 = v186[i];

                if not v190 then
                    local v191 = u154[typeof(v)];

                    if not v191 then
                        error("unsupported type: " .. typeof(v), 2);
                    end;

                    v190 = v191.springType(p183, p184, v188, v, v191);
                    v186[i] = v190;
                end;

                v190:setGoal(v);
                v190:setDampingRatio(p183);
                v190:setFrequency(p184);
            end;
        end;

        if not next(v186) then
            u169[p182] = nil;
        end;
    end,

    stop = function(p192: userdata, p193: string?) -- Line: 754, Name: stop
        -- upvalues: u169 (copy)
        if not ("Instance"):find((typeof(p192))) then
            error(`bad argument #{1} to spr.stop (Instance expected, got {typeof(p192)})`, 3);
        end;

        if not ("string|nil"):find((typeof(p193))) then
            error(`bad argument #{2} to spr.stop (string|nil expected, got {typeof(p193)})`, 3);
        end;

        if p193 then
            local v194 = u169[p192];

            if v194 then
                v194[p193] = nil;
            end;
        else
            u169[p192] = nil;
        end;
    end,

    completed = function(p195: userdata, p196: function) -- Line: 770, Name: completed
        -- upvalues: u170 (copy)
        if not ("Instance"):find((typeof(p195))) then
            error(`bad argument #{1} to spr.completed (Instance expected, got {typeof(p195)})`, 3);
        end;

        if not ("function"):find((typeof(p196))) then
            error(`bad argument #{2} to spr.completed (function expected, got {typeof(p196)})`, 3);
        end;

        local v197 = u170[p195];

        if v197 then
            table.insert(v197, p196);

            return;
        end;

        u170[p195] = { p196 };
    end
});