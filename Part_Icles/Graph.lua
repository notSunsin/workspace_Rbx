-- Decompiled with Potassium's decompiler.

local function clamp(p1, p2, p3) -- Line: 5
    if p1 < p2 then
        return p2;
    end;

    if p3 < p1 then
        return p3;
    end;

    return p1;
end;

local function lerp(p4, p5, p6) -- Line: 6
    return p4 + (p5 - p4) * p6;
end;

local u11 = {
    GenerateSeed = function(p7: userdata?) -- Line: 11, Name: GenerateSeed
        local v8 = {};

        if not p7 or typeof(p7) ~= "NumberSequence" then
            return v8;
        end;

        local Keypoints = p7.Keypoints;
        local math_random_ret = math.random();
        local v9 = math.random() >= 0.5;

        for i = 1, #Keypoints do
            local v10;

            if Keypoints[i].Envelope > 0 then
                if v9 then
                    v8[i] = math_random_ret * Keypoints[i].Envelope;
                    v10 = i;
                else
                    v8[i] = -math_random_ret * Keypoints[i].Envelope;
                    v10 = i;
                end;
            else
                v10 = i;
            end;
        end;

        return v8;
    end
};

function u11.GenerateSeeds(p12: userdata, p13: number) -- Line: 30
    -- upvalues: u11 (copy)
    local v14 = {};

    for i = 1, p13 do
        v14[i] = u11.GenerateSeed(p12);
        local _ = i;
    end;

    return v14;
end;

function u11.QueryPointsWithTime(p15: number, p16: userdata, p17: table) -- Line: 39
    local math_clamp_ret = math.clamp(p15, 0, 1);
    local Keypoints = p16.Keypoints;
    local v18 = #Keypoints;

    if v18 == 1 then
        return Keypoints[1].Value + (p17[1] or 0);
    end;

    local v19 = 1;

    while v19 < v18 - 1 do
        local v20 = (v19 + v18) // 2;

        if Keypoints[v20].Time <= math_clamp_ret then
            v19 = v20;
            v20 = v18;
        end;

        v18 = v20;
    end;

    local v21 = Keypoints[v19];
    local v22 = Keypoints[v19 + 1];
    local v23 = v22.Time - v21.Time;
    local v24 = v21.Value + (p17[v19] or 0);

    return v24 + (v22.Value + (p17[v19 + 1] or 0) - v24) * (v23 > 0 and ((math_clamp_ret - v21.Time) / v23 or 0) or 0);
end;

function u11.QueryColorPointWithTime(p25: number, p26: userdata) -- Line: 61
    local math_clamp_ret = math.clamp(p25, 0, 1);
    local Keypoints = p26.Keypoints;
    local v27 = #Keypoints;

    if v27 == 0 then
        return Color3.new(1, 1, 1);
    end;

    if v27 == 1 then
        return Keypoints[1].Value;
    end;

    if math_clamp_ret <= Keypoints[1].Time then
        return Keypoints[1].Value;
    end;

    local v28 = 1;

    while v28 < v27 - 1 do
        local v29 = (v28 + v27) // 2;

        if Keypoints[v29].Time <= math_clamp_ret then
            v28 = v29;
            v29 = v27;
        end;

        v27 = v29;
    end;

    local v30 = Keypoints[v28];
    local v31 = Keypoints[v28 + 1];
    local v32 = v31.Time - v30.Time;

    return v30.Value:Lerp(v31.Value, v32 > 0 and ((math_clamp_ret - v30.Time) / v32 or 0) or 0);
end;

function u11.IntegrateUpTo(p33: number, p34: userdata, p35: table) -- Line: 82
    local math_clamp_ret = math.clamp(p33, 0, 1);
    local Keypoints = p34.Keypoints;
    local v36 = #Keypoints;

    if v36 == 0 then
        return 0;
    end;

    if v36 == 1 then
        return (Keypoints[1].Value + (p35[1] or 0)) * math_clamp_ret;
    end;

    local v37 = 0;

    for i = 1, v36 - 1 do
        local v38 = Keypoints[i];
        local v39 = Keypoints[i + 1];

        if math_clamp_ret <= v38.Time then
            break;
        end;

        local v40 = v38.Value + (p35[i] or 0);
        local v41 = v39.Value + (p35[i + 1] or 0);
        local math_min_ret = math.min(math_clamp_ret, v39.Time);
        local v42 = v39.Time - v38.Time;
        v37 = v37 + (v40 + (v40 + (v41 - v40) * (v42 > 0 and (math_min_ret - v38.Time) / v42 or 0))) / 2 * (math_min_ret - v38.Time);

        if math_clamp_ret <= v39.Time then
            break;
        end;

        local _ = i;
    end;

    return v37;
end;

function u11.IsStatic(p43: userdata) -- Line: 110
    if not p43 then
        return true;
    end;

    local Keypoints = p43.Keypoints;

    if #Keypoints == 1 then
        return Keypoints[1].Envelope == 0;
    end;

    local Value = Keypoints[1].Value;

    if Keypoints[1].Envelope ~= 0 then
        return false;
    end;

    for i = 2, #Keypoints do
        if Keypoints[i].Value ~= Value or Keypoints[i].Envelope ~= 0 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function u11.GetStaticValue(p44: userdata, p45: number) -- Line: 123
    if p44 and #p44.Keypoints ~= 0 then
        return p44.Keypoints[1].Value;
    end;

    return p45;
end;

local function _mergeSequenceTimes(p46, p47) -- Line: 131
    local v48 = {};
    local v49 = {};

    for _, v in ipairs({ p46, p47 }) do
        for _, v2 in ipairs(v.Keypoints) do
            if not v48[v2.Time] then
                v48[v2.Time] = true;
                table.insert(v49, v2.Time);
            end;
        end;
    end;

    table.sort(v49);

    return v49;
end;

function u11.BlendGraphWithTime(p50: userdata, p51: userdata, p52: userdata, p53: number) -- Line: 146
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v54 = p53 or 1;
    local v55 = _mergeSequenceTimes(p50, p51);
    local v56 = u11.QueryPointsWithTime(v54 < 0 and 0 or (v54 > 1 and 1 or v54), p52, {});
    local v57 = {};

    for _, v in ipairs(v55) do
        local v58 = u11.QueryPointsWithTime(v, p50, {});
        local v59 = u11.QueryPointsWithTime(v, p51, {});
        table.insert(v57, NumberSequenceKeypoint.new(v, v58 + (v59 - v58) * v56));
    end;

    return NumberSequence.new(v57);
end;

function u11.BlendColorGraphWithTime(p60: userdata, p61: userdata, p62: userdata, p63: number) -- Line: 160
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v64 = p63 or 1;
    local v65 = _mergeSequenceTimes(p60, p61);
    local v66 = u11.QueryPointsWithTime(v64 < 0 and 0 or (v64 > 1 and 1 or v64), p62, {});
    local v67 = {};

    for _, v in ipairs(v65) do
        local v68 = u11.QueryColorPointWithTime(v, p60);
        local v69 = u11.QueryColorPointWithTime(v, p61);
        table.insert(v67, ColorSequenceKeypoint.new(v, v68:Lerp(v69, v66)));
    end;

    return ColorSequence.new(v67);
end;

function u11.LerpGraph(p70: userdata, p71: userdata, p72: number) -- Line: 175
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v73 = p72 or 0;
    local v74 = v73 < 0 and 0 or (v73 > 1 and 1 or v73);
    local v75 = _mergeSequenceTimes(p70, p71);
    local v76 = {};

    for _, v in ipairs(v75) do
        local v77 = u11.QueryPointsWithTime(v, p70, {});
        local v78 = u11.QueryPointsWithTime(v, p71, {});
        table.insert(v76, NumberSequenceKeypoint.new(v, v77 + (v78 - v77) * v74));
    end;

    return NumberSequence.new(v76);
end;

function u11.LerpColorGraph(p79: userdata, p80: userdata, p81: number) -- Line: 187
    -- upvalues: _mergeSequenceTimes (copy), u11 (copy)
    local v82 = p81 or 0;
    local v83 = v82 < 0 and 0 or (v82 > 1 and 1 or v82);
    local v84 = _mergeSequenceTimes(p79, p80);
    local v85 = {};

    for _, v in ipairs(v84) do
        local v86 = u11.QueryColorPointWithTime(v, p79);
        local v87 = u11.QueryColorPointWithTime(v, p80);
        table.insert(v85, ColorSequenceKeypoint.new(v, v86:Lerp(v87, v83)));
    end;

    return ColorSequence.new(v85);
end;

function u11.PrecomputeMergedTimes(p88: userdata, p89: userdata) -- Line: 200
    -- upvalues: _mergeSequenceTimes (copy)
    return _mergeSequenceTimes(p88, p89);
end;

function u11.PrecomputeMergedColorTimes(p90: userdata, p91: userdata) -- Line: 204
    -- upvalues: _mergeSequenceTimes (copy)
    return _mergeSequenceTimes(p90, p91);
end;

function u11.LerpGraphFast(p92: userdata, p93: userdata, p94: number, p95: table) -- Line: 209
    -- upvalues: u11 (copy)
    local v96 = p94 or 0;
    local v97 = v96 < 0 and 0 or (v96 > 1 and 1 or v96);

    if v97 == 0 then
        return p92;
    end;

    if v97 == 1 then
        return p93;
    end;

    local v98 = {};

    for _, v in ipairs(p95) do
        local v99 = u11.QueryPointsWithTime(v, p92, {});
        local v100 = u11.QueryPointsWithTime(v, p93, {});
        table.insert(v98, NumberSequenceKeypoint.new(v, v99 + (v100 - v99) * v97));
    end;

    return NumberSequence.new(v98);
end;

function u11.LerpColorGraphFast(p101: userdata, p102: userdata, p103: number, p104: table) -- Line: 222
    -- upvalues: u11 (copy)
    local v105 = p103 or 0;
    local v106 = v105 < 0 and 0 or (v105 > 1 and 1 or v105);

    if v106 == 0 then
        return p101;
    end;

    if v106 == 1 then
        return p102;
    end;

    local v107 = {};

    for _, v in ipairs(p104) do
        local v108 = u11.QueryColorPointWithTime(v, p101);
        local v109 = u11.QueryColorPointWithTime(v, p102);
        table.insert(v107, ColorSequenceKeypoint.new(v, v108:Lerp(v109, v106)));
    end;

    return ColorSequence.new(v107);
end;

function u11.CollectGraphStates(p110) -- Line: 236
    local v111 = {};
    local v112 = {};

    if not p110 then
        return v111, v112;
    end;

    for _, child in pairs(p110:GetChildren()) do
        if child:IsA("Configuration") then
            local Attribute = child:GetAttribute("Time");

            if Attribute == nil then
                local v113 = tonumber(string.match(child.Name, "%d+"));
                Attribute = v113 and v113 - 1 or 0;
            end;

            local Attribute2 = child:GetAttribute("Transparency");

            if Attribute2 and typeof(Attribute2) == "NumberSequence" then
                table.insert(v111, {
                    Time = Attribute,
                    Graph = Attribute2
                });
            end;

            local Attribute3 = child:GetAttribute("Color");

            if Attribute3 and typeof(Attribute3) == "ColorSequence" then
                table.insert(v112, {
                    Time = Attribute,
                    Graph = Attribute3
                });
            end;
        end;
    end;

    table.sort(v111, function(p114, p115) -- Line: 257
        return p114.Time < p115.Time;
    end);
    table.sort(v112, function(p116, p117) -- Line: 258
        return p116.Time < p117.Time;
    end);

    for _, v in ipairs({ v111, v112 }) do
        if #v > 1 and v[#v].Time > 1 then
            local Time = v[#v].Time;

            if Time > 0 then
                for _, v2 in ipairs(v) do
                    v2.Time = v2.Time / Time;
                end;
            end;
        end;
    end;

    return v111, v112;
end;

function u11.InitialEffectiveElapsed(p118, p119, p120) -- Line: 272
    -- upvalues: u11 (copy)
    return p118 and typeof(p118) == "NumberSequence" and (u11.QueryPointsWithTime(0, p118, p119 or {}) < 0 and p120 and p120 or 0) or 0;
end;

function u11.ScaleSequence(p121, p122) -- Line: 280
    if not p121 or typeof(p121) ~= "NumberSequence" then
        return p121;
    end;

    local Keypoints = p121.Keypoints;
    local math_abs_ret = math.abs(p122);
    local v123 = {};

    for _, v in ipairs(Keypoints) do
        table.insert(v123, NumberSequenceKeypoint.new(v.Time, v.Value * p122, v.Envelope * math_abs_ret));
    end;

    return NumberSequence.new(v123);
end;

return u11;