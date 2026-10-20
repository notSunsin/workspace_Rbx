-- Decompiled with Potassium's decompiler.

local u1 = ipairs;
local Color3_new_ret = Color3.new();

local function RobloxLerp(u2, u3) -- Line: 5
    return function(p4) -- Line: 6
        -- upvalues: u2 (copy), u3 (copy)
        return u2:Lerp(u3, p4);
    end;
end;

local function Lerp(p5, p6, p7) -- Line: 11
    return p5 + p7 * (p6 - p5);
end;

local function SortByTime(p8, p9) -- Line: 15
    return p8.Time < p9.Time;
end;

local function Color3Lerp(p10, p11) -- Line: 19
    -- upvalues: Color3_new_ret (copy)
    local R = p10.R;
    local G = p10.G;
    local B = p10.B;
    local v12 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4;
    local v13 = G < 0.0404482362771076 and G / 12.92 or 0.87941546140213 * (G + 0.055) ^ 2.4;
    local v14 = B < 0.0404482362771076 and B / 12.92 or 0.87941546140213 * (B + 0.055) ^ 2.4;
    local v15 = 0.2125862307855956 * v12 + 0.7151703037034108 * v13 + 0.0722004986433362 * v14;
    local v16 = 3.6590806972265884 * v12 + 11.442689580057424 * v13 + 4.114991502426484 * v14;
    local u17 = v15 > 0.008856451679035631 and 116 * v15 ^ 0.3333333333333333 - 16 or 903.296296296296 * v15;
    local u18, u19;

    if v16 > 1e-15 then
        u18 = u17 * (0.9257063972951867 * v12 - 0.8333736323779866 * v13 - 0.09209820666085898 * v14) / v16;
        u19 = u17 * (9 * v15 / v16 - 0.46832);
    else
        u18 = -0.19783 * u17;
        u19 = -0.46832 * u17;
    end;

    local R2 = p11.R;
    local G2 = p11.G;
    local B2 = p11.B;
    local v20 = R2 < 0.0404482362771076 and R2 / 12.92 or 0.87941546140213 * (R2 + 0.055) ^ 2.4;
    local v21 = G2 < 0.0404482362771076 and G2 / 12.92 or 0.87941546140213 * (G2 + 0.055) ^ 2.4;
    local v22 = B2 < 0.0404482362771076 and B2 / 12.92 or 0.87941546140213 * (B2 + 0.055) ^ 2.4;
    local v23 = 0.2125862307855956 * v20 + 0.7151703037034108 * v21 + 0.0722004986433362 * v22;
    local v24 = 3.6590806972265884 * v20 + 11.442689580057424 * v21 + 4.114991502426484 * v22;
    local u25 = v23 > 0.008856451679035631 and 116 * v23 ^ 0.3333333333333333 - 16 or 903.296296296296 * v23;
    local u26, u27;

    if v24 > 1e-15 then
        u26 = u25 * (0.9257063972951867 * v20 - 0.8333736323779866 * v21 - 0.09209820666085898 * v22) / v24;
        u27 = u25 * (9 * v23 / v24 - 0.46832);
    else
        u26 = -0.19783 * u25;
        u27 = -0.46832 * u25;
    end;

    return function(p28) -- Line: 54
        -- upvalues: u17 (ref), u25 (ref), Color3_new_ret (ref), u18 (ref), u26 (ref), u19 (ref), u27 (ref)
        local v29 = (1 - p28) * u17 + p28 * u25;

        if v29 < 0.0197955 then
            return Color3_new_ret;
        end;

        local v30 = ((1 - p28) * u18 + p28 * u26) / v29 + 0.19783;
        local v31 = ((1 - p28) * u19 + p28 * u27) / v29 + 0.46832;
        local v32 = (v29 + 16) / 116;
        local v33 = v32 > 0.20689655172413793 and v32 * v32 * v32 or 0.12841854934601665 * v32 - 0.01771290335807126;
        local v34 = v33 * v30 / v31;
        local v35 = v33 * ((3 - 0.75 * v30) / v31 - 5);
        local v36 = 7.2914074 * v34 - 1.537208 * v33 - 0.4986286 * v35;
        local v37 = -2.180094 * v34 + 1.8757561 * v33 + 0.0415175 * v35;
        local v38 = 0.1253477 * v34 - 0.2040211 * v33 + 1.0569959 * v35;

        if v36 < 0 and (v36 < v37 and v36 < v38) then
            v37 = v37 - v36;
            v38 = v38 - v36;
            v36 = 0;
        elseif v37 < 0 and v37 < v38 then
            v36 = v36 - v37;
            v38 = v38 - v37;
            v37 = 0;
        elseif v38 < 0 then
            v36 = v36 - v38;
            v37 = v37 - v38;
            v38 = 0;
        end;

        local v39 = v36 < 0.0031306684425 and 12.92 * v36 or 1.055 * v36 ^ 0.4166666666666667 - 0.055;
        local v40 = v37 < 0.0031306684425 and 12.92 * v37 or 1.055 * v37 ^ 0.4166666666666667 - 0.055;
        local v41 = v38 < 0.0031306684425 and 12.92 * v38 or 1.055 * v38 ^ 0.4166666666666667 - 0.055;

        return Color3.new(v39 > 1 and 1 or (v39 < 0 and 0 or v39), v40 > 1 and 1 or (v40 < 0 and 0 or v40), v41 > 1 and 1 or (v41 < 0 and 0 or v41));
    end;
end;

return setmetatable({
    boolean = function(u42, u43) -- Line: 93, Name: boolean
        return function(p44) -- Line: 94
            -- upvalues: u42 (copy), u43 (copy)
            if p44 < 0.5 then
                return u42;
            end;

            return u43;
        end;
    end,

    number = function(u45, p46) -- Line: 103, Name: number
        local u47 = p46 - u45;

        return function(p48) -- Line: 105
            -- upvalues: u45 (copy), u47 (copy)
            return u45 + u47 * p48;
        end;
    end,

    string = function(p49, u50) -- Line: 110, Name: string
        local v51 = false;
        local string_match_ret, v52, v53, v54 = string.match(p49, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$");
        local string_match_ret2, v55, v56, v57 = string.match(u50, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$");
        local u58, u59;

        if string_match_ret and string_match_ret2 then
            u58 = 3600 * (tonumber(v52) or 0) + 60 * (tonumber(v53) or 0) + (tonumber(v54) or 0);
            local v60 = 3600 * (tonumber(v55) or 0) + 60 * (tonumber(v56) or 0) + (tonumber(v57) or 0);

            if string_match_ret == "-" then
                u58 = -u58;
            end;

            if string_match_ret2 == "-" or not v60 then
                v60 = -v60;
            end;

            u59 = (43200 + v60 - u58) % 86400 - 43200;
        else
            v51 = true;
            u58 = nil;
            u59 = nil;
        end;

        if not v51 then
            return function(p61) -- Line: 136
                -- upvalues: u58 (ref), u59 (ref)
                local v62 = (u58 + u59 * p61) % 86400;
                local math_abs_ret = math.abs(v62);

                return string.format(v62 < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u", (math_abs_ret - math_abs_ret % 3600) / 3600, (math_abs_ret % 3600 - math_abs_ret % 60) / 60, math_abs_ret % 60);
            end;
        end;

        local u63 = #u50;

        return function(p64) -- Line: 131
            -- upvalues: u63 (copy), u50 (copy)
            local v65 = 1 + u63 * p64;

            return string.sub(u50, 1, v65 < u63 and v65 and v65 or u63);
        end;
    end,

    CFrame = RobloxLerp,
    Color3 = Color3Lerp,

    NumberRange = function(p66, p67) -- Line: 151, Name: NumberRange
        local Min = p66.Min;
        local Max = p66.Max;
        local u68 = p67.Min - Min;
        local u69 = p67.Max - Max;

        return function(p70) -- Line: 155
            -- upvalues: Min (copy), u68 (copy), Max (copy), u69 (copy)
            return NumberRange.new(Min + p70 * u68, Max + p70 * u69);
        end;
    end,

    NumberSequenceKeypoint = function(p71, p72) -- Line: 160, Name: NumberSequenceKeypoint
        local Time = p71.Time;
        local Value = p71.Value;
        local Envelope = p71.Envelope;
        local u73 = p72.Time - Time;
        local u74 = p72.Value - Value;
        local u75 = p72.Envelope - Envelope;

        return function(p76) -- Line: 164
            -- upvalues: Time (copy), u73 (copy), Value (copy), u74 (copy), Envelope (copy), u75 (copy)
            return NumberSequenceKeypoint.new(Time + p76 * u73, Value + p76 * u74, Envelope + p76 * u75);
        end;
    end,

    PhysicalProperties = function(p77, p78) -- Line: 169, Name: PhysicalProperties
        local Density = p77.Density;
        local Elasticity = p77.Elasticity;
        local ElasticityWeight = p77.ElasticityWeight;
        local Friction = p77.Friction;
        local FrictionWeight = p77.FrictionWeight;
        local u79 = p78.Density - Density;
        local u80 = p78.Elasticity - Elasticity;
        local u81 = p78.ElasticityWeight - ElasticityWeight;
        local u82 = p78.Friction - Friction;
        local u83 = p78.FrictionWeight - FrictionWeight;

        return function(p84) -- Line: 180
            -- upvalues: Density (copy), u79 (copy), Elasticity (copy), u80 (copy), ElasticityWeight (copy), u81 (copy), Friction (copy), u82 (copy), FrictionWeight (copy), u83 (copy)
            return PhysicalProperties.new(Density + p84 * u79, Elasticity + p84 * u80, ElasticityWeight + p84 * u81, Friction + p84 * u82, FrictionWeight + p84 * u83);
        end;
    end,

    Ray = function(p85, p86) -- Line: 189, Name: Ray
        local Origin = p85.Origin;
        local Direction = p85.Direction;
        local Origin2 = p86.Origin;
        local Direction2 = p86.Direction;
        local X = Origin.X;
        local Y = Origin.Y;
        local Z = Origin.Z;
        local X2 = Direction.X;
        local Y2 = Direction.Y;
        local Z2 = Direction.Z;
        local u87 = Origin2.X - X;
        local u88 = Origin2.Y - Y;
        local u89 = Origin2.Z - Z;
        local u90 = Direction2.X - X2;
        local u91 = Direction2.Y - Y2;
        local u92 = Direction2.Z - Z2;

        return function(p93) -- Line: 194
            -- upvalues: X (copy), u87 (copy), Y (copy), u88 (copy), Z (copy), u89 (copy), X2 (copy), u90 (copy), Y2 (copy), u91 (copy), Z2 (copy), u92 (copy)
            return Ray.new(Vector3.new(X + p93 * u87, Y + p93 * u88, Z + p93 * u89), (Vector3.new(X2 + p93 * u90, Y2 + p93 * u91, Z2 + p93 * u92)));
        end;
    end,

    UDim = function(p94, p95) -- Line: 202, Name: UDim
        local Scale = p94.Scale;
        local Offset = p94.Offset;
        local u96 = p95.Scale - Scale;
        local u97 = p95.Offset - Offset;

        return function(p98) -- Line: 206
            -- upvalues: Scale (copy), u96 (copy), Offset (copy), u97 (copy)
            return UDim.new(Scale + p98 * u96, Offset + p98 * u97);
        end;
    end,

    UDim2 = RobloxLerp,
    Vector2 = RobloxLerp,
    Vector3 = RobloxLerp,

    Rect = function(u99, u100) -- Line: 214, Name: Rect
        return function(p101) -- Line: 215
            -- upvalues: u99 (copy), u100 (copy)
            return Rect.new(u99.Min.X + p101 * (u100.Min.X - u99.Min.X), u99.Min.Y + p101 * (u100.Min.Y - u99.Min.Y), u99.Max.X + p101 * (u100.Max.X - u99.Max.X), u99.Max.Y + p101 * (u100.Max.Y - u99.Max.Y));
        end;
    end,

    Region3 = function(u102, u103) -- Line: 223, Name: Region3
        return function(p104) -- Line: 224
            -- upvalues: u102 (copy), u103 (copy)
            local v105 = u102.CFrame * (-u102.Size / 2);
            local v106 = v105 + p104 * (u103.CFrame * (-u103.Size / 2) - v105);
            local v107 = u102.CFrame * (u102.Size / 2);
            local v108 = v107 + p104 * (u103.CFrame * (u103.Size / 2) - v107);
            local X = v106.X;
            local X2 = v108.X;
            local Y = v106.Y;
            local Y2 = v108.Y;
            local Z = v106.Z;
            local Z2 = v108.Z;
            local Region3_new = Region3.new;
            local Vector3_new_ret = Vector3.new(X < X2 and X and X or X2, Y < Y2 and Y and Y or Y2, Z < Z2 and Z and Z or Z2);

            if X2 < X then
                X2 = X or X2;
            end;

            if Y2 < Y then
                Y2 = Y or Y2;
            end;

            if Z2 < Z then
                Z2 = Z or Z2;
            end;

            return Region3_new(Vector3_new_ret, (Vector3.new(X2, Y2, Z2)));
        end;
    end,

    NumberSequence = function(u109, u110) -- Line: 242, Name: NumberSequence
        -- upvalues: u1 (copy), SortByTime (copy)
        return function(p111) -- Line: 243
            -- upvalues: u1 (ref), u109 (copy), u110 (copy), SortByTime (ref)
            local v112 = {};
            local v113 = 0;
            local v114 = {};

            for _, v in u1(u109.Keypoints) do
                local v115 = v;
                local v116 = nil;
                local v117 = nil;

                for _, v2 in u1(u110.Keypoints) do
                    if v2.Time == v115.Time then
                        v116 = v2;
                        v117 = v116;
                        local v118 = v116;
                        v116 = v117;
                        v118 = v117;
                        break;
                    end;

                    if v2.Time < v115.Time and (v116 == nil or v2.Time > v116.Time) then
                        v116 = v2;
                    elseif v2.Time > v115.Time and (v117 == nil or v2.Time < v117.Time) then
                        v117 = v2;
                    end;
                end;

                local v119, v120;

                if v117 == v116 then
                    v119 = v117.Value;
                    v120 = v117.Envelope;
                else
                    local v121 = (v115.Time - v116.Time) / (v117.Time - v116.Time);
                    v119 = (v117.Value - v116.Value) * v121 + v116.Value;
                    v120 = (v117.Envelope - v116.Envelope) * v121 + v116.Envelope;
                end;

                v113 = v113 + 1;
                v114[v113] = NumberSequenceKeypoint.new(v115.Time, (v119 - v115.Value) * p111 + v115.Value, (v120 - v115.Envelope) * p111 + v115.Envelope);
                v112[v115.Time] = true;
            end;

            for _, v in u1(u110.Keypoints) do
                if not v112[v.Time] then
                    local v122 = v;
                    local v123 = nil;
                    local v124 = nil;

                    for _, v2 in u1(u109.Keypoints) do
                        if v2.Time == v122.Time then
                            v123 = v2;
                            v124 = v123;
                            local v125 = v123;
                            v123 = v124;
                            v125 = v124;
                            break;
                        end;

                        if v2.Time < v122.Time and (v123 == nil or v2.Time > v123.Time) then
                            v123 = v2;
                        elseif v2.Time > v122.Time and (v124 == nil or v2.Time < v124.Time) then
                            v124 = v2;
                        end;
                    end;

                    local v126, v127;

                    if v124 == v123 then
                        v126 = v124.Value;
                        v127 = v124.Envelope;
                    else
                        local v128 = (v122.Time - v123.Time) / (v124.Time - v123.Time);
                        v126 = (v124.Value - v123.Value) * v128 + v123.Value;
                        v127 = (v124.Envelope - v123.Envelope) * v128 + v123.Envelope;
                    end;

                    v113 = v113 + 1;
                    v114[v113] = NumberSequenceKeypoint.new(v122.Time, (v122.Value - v126) * p111 + v126, (v122.Envelope - v127) * p111 + v127);
                end;
            end;

            table.sort(v114, SortByTime);

            return NumberSequence.new(v114);
        end;
    end,

    ColorSequence = function(u129, u130) -- Line: 310, Name: ColorSequence
        -- upvalues: u1 (copy), Color3Lerp (copy), SortByTime (copy)
        return function(p131) -- Line: 311
            -- upvalues: u1 (ref), u129 (copy), u130 (copy), Color3Lerp (ref), SortByTime (ref)
            local v132 = {};
            local v133 = 0;
            local v134 = {};

            for _, v in u1(u129.Keypoints) do
                local v135 = v;
                local v136 = nil;
                local v137 = nil;

                for _, v2 in u1(u130.Keypoints) do
                    if v2.Time == v135.Time then
                        v136 = v2;
                        v137 = v136;
                        local v138 = v136;
                        v136 = v137;
                        v138 = v137;
                        break;
                    end;

                    if v2.Time < v135.Time and (v136 == nil or v2.Time > v136.Time) then
                        v136 = v2;
                    elseif v2.Time > v135.Time and (v137 == nil or v2.Time < v137.Time) then
                        v137 = v2;
                    end;
                end;

                local v139;

                if v137 == v136 then
                    v139 = v137.Value;
                else
                    v139 = Color3Lerp(v136.Value, v137.Value)((v135.Time - v136.Time) / (v137.Time - v136.Time));
                end;

                v133 = v133 + 1;
                v134[v133] = ColorSequenceKeypoint.new(v135.Time, Color3Lerp(v135.Value, v139)(p131));
                v132[v135.Time] = true;
            end;

            for _, v in u1(u130.Keypoints) do
                if not v132[v.Time] then
                    local v140 = v;
                    local v141 = nil;
                    local v142 = nil;

                    for _, v2 in u1(u129.Keypoints) do
                        if v2.Time == v140.Time then
                            v141 = v2;
                            v142 = v141;
                            local v143 = v141;
                            v141 = v142;
                            v143 = v142;
                            break;
                        end;

                        if v2.Time < v140.Time and (v141 == nil or v2.Time > v141.Time) then
                            v141 = v2;
                        elseif v2.Time > v140.Time and (v142 == nil or v2.Time < v142.Time) then
                            v142 = v2;
                        end;
                    end;

                    local v144;

                    if v142 == v141 then
                        v144 = v142.Value;
                    else
                        v144 = Color3Lerp(v141.Value, v142.Value)((v140.Time - v141.Time) / (v142.Time - v141.Time));
                    end;

                    v133 = v133 + 1;
                    v134[v133] = ColorSequenceKeypoint.new(v140.Time, Color3Lerp(v140.Value, v144)(p131));
                end;
            end;

            table.sort(v134, SortByTime);

            return ColorSequence.new(v134);
        end;
    end
}, {
    __index = function(p145, p146) -- Line: 374, Name: __index
        error("No lerp function is defined for type " .. tostring(p146) .. ".", 4);
    end,

    __newindex = function(p147, p148) -- Line: 378, Name: __newindex
        error("No lerp function is defined for type " .. tostring(p148) .. ".", 4);
    end
});