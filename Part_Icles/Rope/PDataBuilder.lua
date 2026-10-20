-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Parent.Graph);
local Range = require(script.Parent.Parent.Range);
local PartConstants = require(script.Parent.Parent.PartConstants);
local Turbulence = require(script.Parent.Parent.Turbulence);
local AxisLinks = require(script.Parent.Parent.AxisLinks);
local Anchors = require(script.Parent.Anchors);
local DirectionVectors = PartConstants.DirectionVectors;
local u1 = {};

local function liveGraph(p2) -- Line: 20
    -- upvalues: Graph (copy)
    if not p2 then
        return nil;
    end;

    if Graph.IsStatic(p2) and Graph.GetStaticValue(p2, 0) == 0 then
        return nil;
    end;

    return p2;
end;

function u1.readRopeParams(p3, p4, p5, p6) -- Line: 28
    -- upvalues: Range (copy), Graph (copy), Turbulence (copy), AxisLinks (copy), PartConstants (copy), Anchors (copy), DirectionVectors (copy)
    p3._pinMode = p4.PinMode or "BothEnds";
    p3._target = p4.Target;
    p3._pinStart = true;
    p3._pinEnd = p3._pinMode == "BothEnds" and p4.Target ~= nil and true or p3._pinMode == "Launch";
    local v7 = Range.RandomValueFromRange(p4.SegmentCount) + 0.5;
    local math_floor_ret = math.floor(v7);
    p3._segCount = math.clamp(math_floor_ret, 2, p5.segCap);
    local math_floor_ret2 = math.floor((p4.Stiffness or 4) + 0.5);
    p3._stiffness = math.clamp(math_floor_ret2, 1, 10);
    p3._bendStiffness = math.clamp(p4.BendStiffness or 0, 0, 1);
    p3._damping = math.clamp(p4.Damping or 0.03, 0, 0.5);
    p3._gravity = p4.Gravity or Vector3.new(0, -40, 0);
    p3._windAmp = Range.RandomValueFromRange(p4.WindAmplitude);
    p3._windFreq = p4.WindFrequency or 2;
    p3._growIn = math.clamp(p4.GrowIn or 0, 0, 0.9);
    p3._deathMode = p4.DeathMode or "None";
    p3._deathWindow = math.clamp(p4.DeathWindow or 0.2, 0.05, 0.9);
    local ThicknessProfile = p4.ThicknessProfile;
    local v8 = not ThicknessProfile or Graph.IsStatic(ThicknessProfile);
    local v9;

    if v8 then
        v9 = nil;
    else
        v9 = Graph.GenerateSeed(ThicknessProfile) or nil;
    end;

    for i = 1, p5.segCap do
        local v10;

        if v8 then
            p5.widthScale[i] = ThicknessProfile and (Graph.GetStaticValue(ThicknessProfile, 1) or 1) or 1;
            v10 = i;
        else
            local widthScale = p5.widthScale;
            local v11 = Graph.QueryPointsWithTime((i - 0.5) / p5.segCap, ThicknessProfile, v9);
            widthScale[i] = math.max(v11, 0.05);
            v10 = i;
        end;
    end;

    p3._motionTarget = p4.MotionTarget or "Start";
    p3._dispMode = p4.DisplacementMode or "Global";
    local PosOffsetX = p4.PosOffsetX;

    if PosOffsetX then
        if Graph.IsStatic(PosOffsetX) and Graph.GetStaticValue(PosOffsetX, 0) == 0 then
            PosOffsetX = nil;
        end;
    else
        PosOffsetX = nil;
    end;

    local PosOffsetY = p4.PosOffsetY;

    if PosOffsetY then
        if Graph.IsStatic(PosOffsetY) and Graph.GetStaticValue(PosOffsetY, 0) == 0 then
            PosOffsetY = nil;
        end;
    else
        PosOffsetY = nil;
    end;

    local PosOffsetZ = p4.PosOffsetZ;

    if PosOffsetZ then
        if Graph.IsStatic(PosOffsetZ) and Graph.GetStaticValue(PosOffsetZ, 0) == 0 then
            PosOffsetZ = nil;
        end;
    else
        PosOffsetZ = nil;
    end;

    p3.Graphs.PosOffsetX = PosOffsetX;
    p3.Graphs.PosOffsetY = PosOffsetY;
    p3.Graphs.PosOffsetZ = PosOffsetZ;
    p3._hasDisp = (PosOffsetX or (PosOffsetY or PosOffsetZ)) ~= nil;

    if PosOffsetX then
        p3.Seeds.PosOffsetX = p3.Seeds.PosOffsetX or Graph.GenerateSeed(PosOffsetX);
    end;

    if PosOffsetY then
        p3.Seeds.PosOffsetY = p3.Seeds.PosOffsetY or Graph.GenerateSeed(PosOffsetY);
    end;

    if PosOffsetZ then
        p3.Seeds.PosOffsetZ = p3.Seeds.PosOffsetZ or Graph.GenerateSeed(PosOffsetZ);
    end;

    local v12 = Turbulence.isLive(p4.Turbulence);
    p3.Graphs.Turbulence = v12;
    p3._hasTurb = v12 ~= nil;

    if v12 then
        p3.Seeds.Turbulence = p3.Seeds.Turbulence or Graph.GenerateSeed(v12);
        p3._turbFreq = p4.TurbulenceFrequency or 1;
        p3._turbSeed = p3._turbSeed or math.random() * 997 + 0.5;
    end;

    local v13 = AxisLinks.sampleRangeAxes(p4, p4.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p6);
    local u14 = PartConstants.composeRotation(p4.RotOrder or "Global", v13.RotX or 0, v13.RotY or 0, v13.RotZ or 0);
    p3._spawnRot = u14;
    local v15 = AxisLinks.sampleRangeAxes(p4, p4.AxisLinks, { "PosX", "PosY", "PosZ" }, Range, p6);
    p3._spawnOff = Vector3.new(v15.PosX or 0, v15.PosY or 0, v15.PosZ or 0);
    p3._spawnOffMode = p4.PosMode or "Local";
    p3._spawnTarget = p4.SpawnTarget or "Start";
    local u16 = Anchors.resolveStart(p3);
    local u17 = p4.SpreadAngle or Vector2.new(0, 0);

    local function composeDir(p18) -- Line: 102
        -- upvalues: DirectionVectors (ref), u14 (copy), u17 (copy), u16 (copy)
        local v19 = DirectionVectors[p18] or DirectionVectors[Enum.NormalId.Front];
        local v20 = CFrame.new()[v19.vector] * v19.multiplier;
        local v21 = CFrame.lookAt(Vector3.new(0, 0, 0), v20) * u14;

        if u17.X > 0 or u17.Y > 0 then
            local CFrame_Angles = CFrame.Angles;
            local v22 = (math.random() * 2 - 1) * u17.X;
            local math_rad_ret = math.rad(v22);
            local v23 = (math.random() * 2 - 1) * u17.Y;
            v21 = v21 * CFrame_Angles(math_rad_ret, math.rad(v23), 0);
        end;

        return u16.Rotation:VectorToWorldSpace(v21.LookVector);
    end;

    p3._motionDir = composeDir(p4.EmissionDirection);
    p3._speedDir = composeDir(p4.MotionDirection or p4.EmissionDirection);
    local Speed = p4.Speed;

    if Speed then
        if Graph.IsStatic(Speed) and Graph.GetStaticValue(Speed, 0) == 0 then
            Speed = nil;
        end;
    else
        Speed = nil;
    end;

    p3.Graphs.Speed = Speed;

    if Speed then
        p3.Seeds.Speed = p3.Seeds.Speed or Graph.GenerateSeed(Speed);
    end;

    p3._accel = p4.Acceleration or Vector3.new(0, 0, 0);
    p3._drag = p4.Drag or 0;
    p3._hasMotion = Speed ~= nil and true or p3._accel.Magnitude > 0;
    p3._motionOffset = Vector3.new(0, 0, 0);
    p3._motionAccelVel = Vector3.new(0, 0, 0);

    if p3._pinMode == "Launch" then
        local v24 = Range.RandomValueFromRange(p4.LaunchSpeed);
        local math_max_ret = math.max(v24, 1);
        p3._launchOrigin = u16.Position;
        p3._launchT = nil;
        local v25 = nil;

        if p4.Target then
            local success, result = pcall(PartConstants.resolveLinkCFrame, p4.Target);

            if success and result then
                v25 = result.Position;
            end;
        end;

        if v25 then
            local v26 = v25 - u16.Position;
            local math_max_ret2 = math.max(v26.Magnitude / math_max_ret, 0.05);
            p3._launchVel = v26 * (1 / math_max_ret2) - p3._gravity * (math_max_ret2 * 0.5);
            p3._launchT = math_max_ret2;
        else
            p3._launchVel = p3._motionDir * math_max_ret;
        end;
    end;

    local v27 = Range.RandomValueFromRange(p4.RopeLength);

    if v27 <= 0 then
        local math_max_ret = math.max(p4.Slack or 1.2, 1);
        local v28 = 10;

        if (p3._pinMode == "BothEnds" or p3._pinMode == "Launch") and p4.Target then
            local success, result = pcall(PartConstants.resolveLinkCFrame, p4.Target);

            if success and result then
                v28 = math.max((result.Position - u16.Position).Magnitude, 1);
            end;
        end;

        v27 = v28 * math_max_ret;
    end;

    p3._restLen = math.max(v27 / p3._segCount, 0.05);
end;

function u1.build(p29, p30, p31, p32, p33, p34, p35) -- Line: 169
    -- upvalues: Graph (copy), u1 (copy)
    local v36 = {
        Brightness = Graph.GenerateSeed(p30.Brightness),
        Transparency = Graph.GenerateSeed(p30.Transparency),
        Thickness = Graph.GenerateSeed(p30.Thickness),
        Timescale = Graph.GenerateSeed(p30.Timescale)
    };
    local v37 = {
        Type = "Rope",
        CurrentStep = 0,
        _accum = 0,
        _windPhase = 0,
        VisualPart = p31,
        _rig = p32,
        Events = p30.Events,
        StartTime = os.clock(),
        TotalKeyFrames = math.max(1, p30.TotalKeyFrames),
        LifeTime = p33,
        PartLife = p30.PartLife or 0,
        _sourceItem = p29,
        Graphs = {
            Color = p30.Color,
            Brightness = p30.Brightness,
            Transparency = p30.Transparency,
            Thickness = p30.Thickness,
            Timescale = p30.Timescale
        },
        Seeds = v36,
        _effectiveElapsed = Graph.InitialEffectiveElapsed(p30.Timescale, v36.Timescale, p33),
        _parentLink = p35,
        _windSeedA = math.random() * 1000,
        _windSeedB = 500 + math.random() * 1000
    };

    if p34 then
        local v38;

        if p34.EventOriginResolver then
            v38 = p34.EventOriginResolver();
        else
            v38 = nil;
        end;

        local v39 = v38 or p34.EventOriginCF;

        if v39 then
            v37._startCFOverride = p34.UseFullOrigin and v39 and v39 or CFrame.new(v39.Position) * p29.CFrame.Rotation;
        end;
    end;

    u1.readRopeParams(v37, p30, p32, p34);
    v37._launchArrived = false;
    v37._released = false;

    return v37;
end;

return u1;