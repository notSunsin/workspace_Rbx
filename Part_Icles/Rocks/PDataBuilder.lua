-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Parent.Graph);
local Range = require(script.Parent.Parent.Range);
local PartConstants = require(script.Parent.Parent.PartConstants);
local DirectionVectors = PartConstants.DirectionVectors;
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local u1 = {};

local function rollRange(p2) -- Line: 19
    -- upvalues: Range (copy)
    return Range.RandomValueFromRange(p2);
end;

local function rollAxis(p3, p4, p5, p6) -- Line: 24
    -- upvalues: Range (copy)
    if p4 and p6 > 0 then
        return p3.Min + (p3.Max - p3.Min) * ((p5 - 0.5) / p6);
    end;

    return Range.RandomValueFromRange(p3);
end;

local function randomAxis() -- Line: 32
    local v7 = math.random() * 2 - 1;
    local v8 = math.random() * 2 - 1;
    local v9 = math.random() * 2 - 1;
    local Vector3_new_ret = Vector3.new(v7, v8, v9);

    return Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit;
end;

local function launchDir(p10, p11, p12, p13) -- Line: 41
    -- upvalues: DirectionVectors (copy)
    local v14 = DirectionVectors[p10.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
    local v15 = CFrame.new()[v14.vector] * v14.multiplier;

    if p10.BurstMode ~= "Ring" then
        local v16 = p10.SpreadAngle or Vector2.new(0, 0);
        local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), v15);

        if v16.X > 0 or v16.Y > 0 then
            local CFrame_Angles = CFrame.Angles;
            local v17 = (math.random() * 2 - 1) * v16.X;
            local math_rad_ret = math.rad(v17);
            local v18 = (math.random() * 2 - 1) * v16.Y;
            CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame_Angles(math_rad_ret, math.rad(v18), 0);
        end;

        return p11.Rotation:VectorToWorldSpace(CFrame_lookAt_ret.LookVector);
    end;

    local v19 = v15:Cross(Vector3.new(1, 0, 0));

    if v19.Magnitude < 0.01 then
        v19 = v15:Cross(Vector3.new(0, 0, 1));
    end;

    local Unit = v19.Unit;
    local v20 = v15:Cross(Unit);
    local v21 = (p12 - 0.5) / p13 * 2 * 3.141592653589793 + (math.random() - 0.5) * 0.2;
    local math_rad_ret = math.rad(p10.SpreadAngle.X);
    local v22 = (Unit * math.cos(v21) + v20 * math.sin(v21)) * math.cos(math_rad_ret) + v15 * math.sin(math_rad_ret);

    return p11.Rotation:VectorToWorldSpace(v22);
end;

function u1.rollChunks(p23, p24, u25, p26) -- Line: 68
    -- upvalues: Range (copy), Graph (copy), launchDir (copy), CFrame_new_ret (copy)
    local v27 = p24.RenderTemplate and p24.RenderTemplate:IsA("BasePart") and (p24.RenderTemplate.Size or Vector3.new(1, 1, 1)) or Vector3.new(1, 1, 1);
    local v28 = Range.RandomValueFromRange(p24.ChunkCount) + 0.5;
    local math_floor_ret = math.floor(v28);
    local math_clamp_ret = math.clamp(math_floor_ret, 1, u25.chunkCap);
    p23._chunkCount = math_clamp_ret;
    local u29 = p24.Scale and (Graph.QueryPointsWithTime(0, p24.Scale, p23.Seeds.Scale) or 1) or 1;
    p23._curScale = u29;

    for i = 1, u25.chunkCap do
        local u30 = u25.parts[i];
        local v31;

        if i <= math_clamp_ret then
            local PosX = p24.PosX;
            local v32;

            if p24.PosXEven and math_clamp_ret > 0 then
                v32 = PosX.Min + (PosX.Max - PosX.Min) * ((i - 0.5) / math_clamp_ret);
            else
                v32 = Range.RandomValueFromRange(PosX);
            end;

            local PosY = p24.PosY;
            local v33;

            if p24.PosYEven and math_clamp_ret > 0 then
                v33 = PosY.Min + (PosY.Max - PosY.Min) * ((i - 0.5) / math_clamp_ret);
            else
                v33 = Range.RandomValueFromRange(PosY);
            end;

            local PosZ = p24.PosZ;
            local v34;

            if p24.PosZEven and math_clamp_ret > 0 then
                v34 = PosZ.Min + (PosZ.Max - PosZ.Min) * ((i - 0.5) / math_clamp_ret);
            else
                v34 = Range.RandomValueFromRange(PosZ);
            end;

            local u35;

            if p24.PosMode == "Global" then
                u35 = p26.Position + Vector3.new(v32, v33, v34);
            else
                u35 = (p26 * CFrame.new(v32, v33, v34)).Position;
            end;

            u25.baseSize[i] = v27 * Range.RandomValueFromRange(p24.ChunkScale);
            u25.halfExt[i] = u25.baseSize[i] * 0.5;
            local v36 = p24.Speed and (Graph.QueryPointsWithTime(0, p24.Speed, Graph.GenerateSeed(p24.Speed)) or 0) or 0;
            local v37 = launchDir(p24, p26, i, math_clamp_ret) * v36;
            local v38 = math.random() * 2 - 1;
            local v39 = math.random() * 2 - 1;
            local v40 = math.random() * 2 - 1;
            local Vector3_new_ret = Vector3.new(v38, v39, v40);
            local v41 = Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit;
            local v42 = Range.RandomValueFromRange(p24.TumbleSpeed);
            local v43 = math.rad(v42) * (math.random() < 0.5 and -1 or 1);
            local CFrame_Angles_ret = CFrame.Angles(math.random() * 6.283, math.random() * 6.283, math.random() * 6.283);
            u25.launchVel[i] = v37;
            u25.launchAng[i] = v41 * v43;
            u25.spawnPos[i] = u35;
            u25.spawnRot[i] = CFrame_Angles_ret;
            u25.trajs[i] = nil;
            local bounciness = u25.bounciness;
            local v44 = Range.RandomValueFromRange(p24.Bounciness);
            bounciness[i] = math.clamp(v44, 0, 1);
            u25.touched[i] = false;
            u25.writeCFs[i] = CFrame_Angles_ret + u35;
            pcall(function() -- Line: 104
                -- upvalues: u30 (copy), u25 (copy), i (copy), u29 (copy), CFrame_Angles_ret (copy), u35 (ref)
                u30.Size = u25.baseSize[i] * math.max(u29, 0.01);
                u30.CFrame = CFrame_Angles_ret + u35;
            end);
            v31 = i;
        else
            pcall(function() -- Line: 109
                -- upvalues: u30 (copy), CFrame_new_ret (ref)
                u30.Anchored = true;
                u30.CanCollide = false;
                u30.CanTouch = false;
                u30.CFrame = CFrame_new_ret;
            end);
            u25.launchVel[i] = Vector3.new(0, 0, 0);
            u25.launchAng[i] = Vector3.new(0, 0, 0);
            u25.spawnPos[i] = CFrame_new_ret.Position;
            u25.spawnRot[i] = CFrame.identity;
            u25.trajs[i] = nil;
            u25.touched[i] = false;
            u25.writeCFs[i] = CFrame_new_ret;
            v31 = i;
        end;
    end;
end;

function u1.build(p45, p46, p47, p48, p49, p50, p51) -- Line: 126
    -- upvalues: Graph (copy), PartConstants (copy), u1 (copy)
    local v52 = {
        Scale = Graph.GenerateSeed(p46.Scale),
        Brightness = Graph.GenerateSeed(p46.Brightness),
        Transparency = Graph.GenerateSeed(p46.Transparency),
        Timescale = Graph.GenerateSeed(p46.Timescale)
    };
    local v53 = {
        Type = "Rocks",
        CurrentStep = 0,
        _hitFired = false,
        _ownsOnHit = true,
        VisualPart = p47,
        _rig = p48,
        Events = p46.Events,
        StartTime = os.clock(),
        TotalKeyFrames = math.max(1, p46.TotalKeyFrames),
        LifeTime = p49,
        PartLife = p46.PartLife or 0,
        _sourceItem = p45,
        Graphs = {
            Scale = p46.Scale,
            Brightness = p46.Brightness,
            Transparency = p46.Transparency,
            Timescale = p46.Timescale,
            Color = p46.Color
        },
        Seeds = v52,
        _effectiveElapsed = Graph.InitialEffectiveElapsed(p46.Timescale, v52.Timescale, p49),
        _gravity = p46.Gravity or 196.2,
        _friction = math.clamp(p46.Friction or 0.3, 0, 1),
        _sinkOut = p46.SinkOut ~= false,
        _inheritFloor = p46.InheritFloor == true
    };
    local v54 = nil;

    if p50 then
        local v55;

        if p50.EventOriginResolver then
            v55 = p50.EventOriginResolver();
        else
            v55 = nil;
        end;

        local v56 = v55 or p50.EventOriginCF;

        if v56 then
            v54 = p50.UseFullOrigin and v56 and v56 or CFrame.new(v56.Position) * p45.CFrame.Rotation;
        end;
    end;

    if not v54 and (p51 and p51.Parent) then
        v54 = PartConstants.resolveLinkCFrame(p51);
    end;

    u1.rollChunks(v53, p46, p48, v54 or p45.CFrame);

    return v53;
end;

return u1;