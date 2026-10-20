-- Decompiled with Potassium's decompiler.

local v1 = {};

local function support(p2, p3, p4, p5) -- Line: 32
    local v6 = p2.XVector:Dot(p4);
    local v7 = math.abs(v6) * p3.X;
    local v8 = p2.YVector:Dot(p4);
    local v9 = v7 + math.abs(v8) * p3.Y;
    local v10 = p2.ZVector:Dot(p4);

    return (v9 + math.abs(v10) * p3.Z) * p5;
end;

local function spinCF(p11, p12, p13) -- Line: 38
    local Magnitude = p12.Magnitude;

    if Magnitude * p13 < 0.0001 then
        return p11;
    end;

    return CFrame.fromAxisAngle(p12 * (1 / Magnitude), Magnitude * p13) * p11;
end;

local function planeCrossTime(p14, p15, p16, p17, p18, p19) -- Line: 48
    local v20 = 0.5 * p16:Dot(p17);
    local v21 = p15:Dot(p17);
    local v22 = p14:Dot(p17) - p18;

    if math.abs(v20) < 1e-6 then
        if math.abs(v21) < 1e-9 then
            return nil;
        end;

        local v23 = -v22 / v21;

        if v23 >= 0 and v23 <= p19 then
            return v23;
        end;

        return nil;
    end;

    local v24 = v21 * v21 - 4 * v20 * v22;

    if v24 < 0 then
        return nil;
    end;

    local math_sqrt_ret = math.sqrt(v24);
    local v25 = (-v21 - math_sqrt_ret) / (2 * v20);
    local v26 = (-v21 + math_sqrt_ret) / (2 * v20);

    if v26 >= v25 then
        local v27 = v25;
        v25 = v26;
        v26 = v27;
    end;

    if v26 >= 0 and v26 <= p19 then
        return v26;
    end;

    if v25 >= 0 and v25 <= p19 then
        return v25;
    end;

    return nil;
end;

local function restPose(p28, p29, p30) -- Line: 75
    local v31 = p28.XVector:Dot(p30);
    local v32 = p28.YVector:Dot(p30);
    local v33 = p28.ZVector:Dot(p30);
    local v34 = math.abs(v31) / math.max(p29.X, 0.05);
    local v35 = math.abs(v32) / math.max(p29.Y, 0.05);
    local v36 = math.abs(v33) / math.max(p29.Z, 0.05);
    local v37, v38;

    if v35 <= v34 and v36 <= v34 then
        v37 = p28.XVector * (v31 >= 0 and 1 or -1);
        v38 = p29.X;
    elseif v36 <= v35 then
        v37 = p28.YVector * (v32 >= 0 and 1 or -1);
        v38 = p29.Y;
    else
        v37 = p28.ZVector * (v33 >= 0 and 1 or -1);
        v38 = p29.Z;
    end;

    local v39 = v37:Dot(p30);
    local math_clamp_ret = math.clamp(v39, -1, 1);
    local v40 = v37:Cross(p30);

    if v40.Magnitude > 0.00001 and math_clamp_ret < 0.9999 then
        return CFrame.fromAxisAngle(v40.Unit, (math.acos(math_clamp_ret))) * p28, v38;
    end;

    return p28, v38;
end;

function v1.build(p41, p42, p43, p44, p45, p46, p47, p48, p49, p50) -- Line: 102
    -- upvalues: support (copy), planeCrossTime (copy), restPose (copy)
    local v51 = {};
    local Vector3_new_ret = Vector3.new(0, -p47, 0);
    local v52 = 0;
    local v53 = {
        impactT = nil,
        hit = nil,
        restT = (1 / 0),
        segs = v51
    };

    for i = 0, 3 do
        local v54 = i == 0 and 6 or 4;
        local v55 = math.max(p42.Y, 0) / math.max(p47, 1) * 2 + 1.5;
        local math_min_ret = math.min(v55, 6);
        local v56 = math_min_ret / v54;
        local v57 = p41;
        local v58 = nil;
        local v59 = nil;

        for i2 = 1, v54 do
            local v60 = i2 * v56;
            local v61 = p41 + p42 * v60 + Vector3_new_ret * (0.5 * v60 * v60);
            local v62 = v61 - v57;

            if v62.Magnitude > 0.0001 then
                local Unit = v62.Unit;
                local v63 = support(p43, p45, Unit, p46);
                local v64 = p50(v57, v62 + Unit * v63);

                if v64 then
                    local math_clamp_ret = math.clamp((v64.Position - v57).Magnitude / (v62.Magnitude + v63), 0, 1);
                    local v65 = (i2 - 1) * v56 + v56 * math_clamp_ret;
                    local Magnitude = p44.Magnitude;
                    local v66;

                    if Magnitude * v65 < 0.0001 then
                        v66 = p43;
                    else
                        v66 = CFrame.fromAxisAngle(p44 * (1 / Magnitude), Magnitude * v65) * p43;
                    end;

                    local v67 = support(v66, p45, v64.Normal, p46);
                    local v68 = v64.Position:Dot(v64.Normal) + v67;
                    v59 = planeCrossTime(p41, p42, Vector3_new_ret, v64.Normal, v68, math_min_ret) or v65;
                    v58 = v64;
                    break;
                end;
            end;

            local _ = i2;
            v57 = v61;
        end;

        if not v58 then
            v51[#v51 + 1] = {
                kind = 1,
                t0 = v52,
                p0 = p41,
                v0 = p42,
                rot0 = p43,
                w = p44
            };

            return v53;
        end;

        local Normal = v58.Normal;
        local v69 = p42 + Vector3_new_ret * v59;
        local Magnitude = p44.Magnitude;
        local v70;

        if Magnitude * v59 < 0.0001 then
            v70 = p43;
        else
            v70 = CFrame.fromAxisAngle(p44 * (1 / Magnitude), Magnitude * v59) * p43;
        end;

        local v71 = support(v70, p45, Normal, p46);
        local v72 = p41 + p42 * v59 + Vector3_new_ret * (0.5 * v59 * v59);
        v51[#v51 + 1] = {
            kind = 1,
            t0 = v52,
            p0 = p41,
            v0 = p42,
            rot0 = p43,
            w = p44
        };
        v52 = v52 + v59;

        if not v53.impactT then
            v53.impactT = v52;
            v53.hit = v58;
        end;

        local v73 = v69:Dot(Normal);
        local v74 = v69 - Normal * v73;

        if -v73 * p48 <= 6 or (Normal.Y <= 0.3 or i >= 3) then
            local Magnitude2 = v74.Magnitude;
            local math_max_ret = math.max(p49 * p47 * 0.5, 10);
            local math_min_ret2 = math.min(Magnitude2 / math_max_ret, 2);
            local v75 = Magnitude2 > 0.001 and v74.Unit or Vector3.new(1, 0, 0);
            local v76, v77 = restPose(v70, p45, Normal);
            local u78 = v58.Position:Dot(Normal);

            local function planeSeat(p79, p80) -- Line: 184
                -- upvalues: Normal (copy), u78 (copy)
                return p79 + Normal * (u78 + p80 - p79:Dot(Normal));
            end;

            local v81 = v72 + Normal * (u78 + v71 - v72:Dot(Normal));
            local v82 = v81 + v75 * (Magnitude2 * math_min_ret2 - math_max_ret * 0.5 * math_min_ret2 * math_min_ret2);
            local v83 = v82 + Normal * (u78 + v77 * p46 - v82:Dot(Normal));
            v51[#v51 + 1] = {
                kind = 2,
                t0 = v52,
                dur = math.max(math_min_ret2, 0.15),
                p0 = v81,
                p1 = v83,
                rot0 = v70,
                rotF = v76
            };
            local v84 = v52 + math.max(math_min_ret2, 0.15);
            v51[#v51 + 1] = {
                kind = 3,
                t0 = v84,
                cf = v76 + v83
            };
            v53.restT = v84;

            return v53;
        end;

        p42 = v74 * (1 - p49) + Normal * (-v73 * p48);
        local v85 = Normal:Cross(v74);

        if v85.Magnitude > 0.0001 and v74.Magnitude > 0.5 then
            p44 = v85.Unit * (v74.Magnitude / math.max(v71, 0.1));
        end;

        p43 = v70;
        p41 = v72;
    end;

    return v53;
end;

function v1.evaluate(p86, p87, p88) -- Line: 201
    local segs = p86.segs;
    local v89 = segs[1];

    for i = 2, #segs do
        if segs[i].t0 > p87 then
            break;
        end;

        v89 = segs[i];
        local _ = i;
    end;

    if v89.kind ~= 1 then
        if v89.kind ~= 2 then
            return v89.cf;
        end;

        local math_clamp_ret = math.clamp((p87 - v89.t0) / v89.dur, 0, 1);
        local v90 = 1 - (1 - math_clamp_ret) * (1 - math_clamp_ret);

        return v89.rot0:Lerp(v89.rotF, v90) + v89.p0:Lerp(v89.p1, v90);
    end;

    local math_max_ret = math.max(p87 - v89.t0, 0);
    local v91 = v89.p0 + v89.v0 * math_max_ret + Vector3.new(0, -0.5 * p88 * math_max_ret * math_max_ret, 0);
    local rot0 = v89.rot0;
    local w = v89.w;
    local Magnitude = w.Magnitude;

    if Magnitude * math_max_ret >= 0.0001 then
        rot0 = CFrame.fromAxisAngle(w * (1 / Magnitude), Magnitude * math_max_ret) * rot0;
    end;

    return rot0 + v91;
end;

return v1;