-- Decompiled with Potassium's decompiler.

local PartConstants = require(script.Parent.PartConstants);
local Graph = require(script.Parent.Graph);
local v1 = {};
local u2 = { Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, -1, 0), Vector3.new(0, 0, 1), Vector3.new(0, 0, -1) };

local function _snapshotPData(p3, p4) -- Line: 62
    return {
        time = p3._effectiveElapsed or 0,
        kind = p4,
        BaseDirection = p3.BaseDirection,
        SpeedMultiplier = p3.SpeedMultiplier,
        _accelVel = p3._accelVel,
        TargetVel = p3.TargetVel,
        _spinRate = p3._spinRate,
        _spinAccumX = p3._spinAccumX,
        _spinAccumY = p3._spinAccumY,
        _spinAccumZ = p3._spinAccumZ,
        AccRotX = p3.AccRotX,
        AccRotY = p3.AccRotY,
        AccRotZ = p3.AccRotZ,
        LocalCF = p3.LocalCF,
        _localWorldCF = p3._localWorldCF,
        CurrentPosition = p3.CurrentPosition,
        _hitFired = p3._hitFired,
        LastHitCheckPos = p3.LastHitCheckPos,
        _collisionStopped = p3._collisionStopped,
        CurrentStep = p3.CurrentStep,
        AccumulatedDT = p3.AccumulatedDT,
        _displacementMirrorX = p3._displacementMirrorX,
        _displacementMirrorY = p3._displacementMirrorY,
        _displacementMirrorZ = p3._displacementMirrorZ,
        _prevWorldOff = p3._prevWorldOff,
        _prevTurbOff = p3._prevTurbOff,
        _settleEngaged = p3._settleEngaged,
        _restTimer = p3._restTimer,
        _settleRotDamp = p3._settleRotDamp,
        _settleContactPos = p3._settleContactPos,
        _settleSpawnHalf = p3._settleSpawnHalf,
        _lastHitNormal = p3._lastHitNormal
    };
end;

local function _pushHit(p5, p6) -- Line: 105
    p5._hitHistory = p5._hitHistory or {};

    if #p5._hitHistory >= 16 then
        table.remove(p5._hitHistory, 1);
    end;

    table.insert(p5._hitHistory, p6);
end;

function v1.restoreHitsOnReverse(p7, p8, p9) -- Line: 115
    local _hitHistory = p7._hitHistory;

    if not _hitHistory then
        return;
    end;

    for i = #_hitHistory, 1, -1 do
        local v10 = _hitHistory[i];
        local v11;

        if p9 < v10.time and v10.time <= p8 then
            p7.BaseDirection = v10.BaseDirection;
            p7.SpeedMultiplier = v10.SpeedMultiplier;
            p7._accelVel = v10._accelVel;
            p7.TargetVel = v10.TargetVel;
            p7._spinRate = v10._spinRate;
            p7._spinAccumX = v10._spinAccumX;
            p7._spinAccumY = v10._spinAccumY;
            p7._spinAccumZ = v10._spinAccumZ;
            p7.AccRotX = v10.AccRotX;
            p7.AccRotY = v10.AccRotY;
            p7.AccRotZ = v10.AccRotZ;
            p7.LocalCF = v10.LocalCF;
            p7._localWorldCF = v10._localWorldCF;
            p7.CurrentPosition = v10.CurrentPosition;
            p7._hitFired = v10._hitFired;
            p7.LastHitCheckPos = v10.LastHitCheckPos;
            p7._collisionStopped = v10._collisionStopped;
            p7.CurrentStep = v10.CurrentStep;
            p7.AccumulatedDT = v10.AccumulatedDT;
            p7._displacementMirrorX = v10._displacementMirrorX;
            p7._displacementMirrorY = v10._displacementMirrorY;
            p7._displacementMirrorZ = v10._displacementMirrorZ;
            p7._prevWorldOff = v10._prevWorldOff;
            p7._prevTurbOff = v10._prevTurbOff;
            p7._settleEngaged = v10._settleEngaged;
            p7._restTimer = v10._restTimer;
            p7._settleRotDamp = v10._settleRotDamp;
            p7._settleContactPos = v10._settleContactPos;
            p7._settleSpawnHalf = v10._settleSpawnHalf;
            p7._lastHitNormal = v10._lastHitNormal;
            table.remove(_hitHistory, i);
            v11 = i;
        else
            v11 = i;
        end;
    end;
end;

local function applySnapCFrame(p12, p13) -- Line: 157
    local VisualPart = p12.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    if p12.Type == "Model" then
        VisualPart:PivotTo(p13);

        return;
    end;

    if p12.Type ~= "Attachment" then
        VisualPart.CFrame = p13;

        return;
    end;

    local Parent = VisualPart.Parent;

    if Parent and Parent:IsA("BasePart") then
        p13 = Parent.CFrame:ToObjectSpace(p13) or p13;
    end;

    VisualPart.CFrame = p13;
end;

local function readWorldCF(p14) -- Line: 170
    local VisualPart = p14.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return CFrame.new();
    end;

    if p14.Type == "Model" then
        return VisualPart:GetPivot();
    end;

    if p14.Type ~= "Attachment" then
        return VisualPart.CFrame;
    end;

    local Parent = VisualPart.Parent;

    return Parent and Parent:IsA("BasePart") and Parent.CFrame * VisualPart.CFrame or VisualPart.CFrame;
end;

local function bounceParentCF(p15) -- Line: 183
    -- upvalues: PartConstants (copy)
    local Link = p15.Link;

    if not (Link and Link.Parent) then
        return CFrame.new();
    end;

    local v16;

    if p15.LinkMode == "RigidLocal" then
        v16 = p15._rigidLocalParentCF or CFrame.new();
    else
        v16 = PartConstants.resolveLinkCFrame(Link);
    end;

    if not v16 then
        return CFrame.new();
    end;

    if p15.LinkMode == "Follow" or p15.LinkMode == "Pivot" then
        return CFrame.new(v16.Position);
    end;

    return v16;
end;

local function attachmentBounceLocalPos(p17, p18) -- Line: 200
    -- upvalues: PartConstants (copy)
    local VisualPart = p17.VisualPart;

    if VisualPart then
        VisualPart = VisualPart.Parent;
    end;

    local v19 = VisualPart and (VisualPart:IsA("BasePart") and VisualPart.CFrame) or CFrame.new();
    local Link = p17.Link;
    local v20;

    if Link and Link.Parent then
        local v21;

        if p17.LinkMode == "RigidLocal" then
            v21 = p17._rigidLocalParentCF or CFrame.new();
        else
            v21 = PartConstants.resolveLinkCFrame(Link);
        end;

        v20 = v19:ToObjectSpace(v21);

        if p17.LinkMode == "Follow" or p17.LinkMode == "Pivot" then
            v20 = CFrame.new(v20.Position);
        end;
    else
        v20 = CFrame.new();
    end;

    return v20:PointToObjectSpace((v19:PointToObjectSpace(p18)));
end;

local function handleKillOrStop(p22, p23, p24, p25) -- Line: 228
    -- upvalues: _snapshotPData (copy), readWorldCF (copy), applySnapCFrame (copy), attachmentBounceLocalPos (copy), bounceParentCF (copy)
    local v26;

    if p25 == "Kill" then
        v26 = nil;
    else
        v26 = _snapshotPData(p23, "Stop") or nil;
    end;

    local v27 = readWorldCF(p23);
    local v28 = CFrame.new(p24.Position) * (v27 - v27.Position);
    applySnapCFrame(p23, v28);
    p23.CurrentPosition = p24.Position;

    if p25 == "Kill" then
        if p22._killParticle then
            p22:_killParticle(p23, {
                fireOnDeath = true
            });
        end;
    else
        if p23.LocalCF then
            local v29;

            if p23.Type == "Attachment" then
                v29 = attachmentBounceLocalPos(p23, p24.Position);
            else
                v29 = bounceParentCF(p23):PointToObjectSpace(p24.Position);
            end;

            p23.LocalCF = CFrame.new(v29) * (p23.LocalCF - p23.LocalCF.Position);
            p23._localWorldCF = p23.LocalCF;
        end;

        p23._postUpdateCF = v28;
        p23._collisionStopped = true;
        p23.LastHitCheckPos = p24.Position;
        p23._hitFired = true;

        if v26 then
            p23._hitHistory = p23._hitHistory or {};

            if #p23._hitHistory >= 16 then
                table.remove(p23._hitHistory, 1);
            end;

            table.insert(p23._hitHistory, v26);
        end;
    end;
end;

local function handleBounce(p30, p31, p32, p33) -- Line: 261
    -- upvalues: _snapshotPData (copy), Graph (copy), PartConstants (copy), attachmentBounceLocalPos (copy), bounceParentCF (copy), readWorldCF (copy), applySnapCFrame (copy)
    local Normal = p31.Normal;
    local OnHit = p30.Events.OnHit;
    p30._bouncinessJitter = p30._bouncinessJitter or 1 + (math.random() - 0.5) * 0.4;
    p30._frictionJitter = p30._frictionJitter or 1 + (math.random() - 0.5) * 0.4;
    p30._restClampJitter = p30._restClampJitter or 1 + (math.random() - 0.5) * 0.4;
    p30._sleepTimeJitter = p30._sleepTimeJitter or 1 + (math.random() - 0.5) * 0.4;
    local v34 = (OnHit.Bounciness or 0.7) * p30._bouncinessJitter;
    local v35 = (OnHit.Friction or 0.2) * p30._frictionJitter;
    local v36 = OnHit.Spin or 0.5;
    local v37 = (not p33 or p33 <= 0) and 0.016666666666666666 or p33;
    local v38 = _snapshotPData(p30, "Bounce");
    p30._lastHitNormal = Normal;
    local v39 = (p32 / v37):Dot(Normal);
    local v40 = math.abs(v39) < 0.5 * (p30._restClampJitter or 1) and 0 or v34;
    local BaseDirection = p30.BaseDirection;

    if BaseDirection then
        local v41 = BaseDirection:Dot(Normal) * Normal;
        local v42 = -v40 * v41 + (1 - v35) * (BaseDirection - v41);
        local Magnitude = v42.Magnitude;

        if Magnitude > 0.0001 then
            p30.BaseDirection = v42.Unit;
            p30.SpeedMultiplier = (p30.SpeedMultiplier or 1) * Magnitude;
        else
            p30.SpeedMultiplier = 0;
        end;
    end;

    local _accelVel = p30._accelVel;

    if _accelVel then
        local v43 = _accelVel:Dot(Normal) * Normal;
        p30._accelVel = -v40 * v43 + (1 - v35) * (_accelVel - v43);
    end;

    local TargetVel = p30.TargetVel;

    if TargetVel then
        local v44 = TargetVel:Dot(Normal) * Normal;
        p30.TargetVel = -v40 * v44 + (1 - v35) * (TargetVel - v44);
    end;

    local v45 = p30._spinRate or Vector3.new(0, 0, 0);
    local v46 = (p32 - p32:Dot(Normal) * Normal) / v37;
    local Magnitude = (p32 / v37).Magnitude;
    local v47 = v46.Magnitude <= 0.0001 and Vector3.new(0, 0, 0) or Normal:Cross(v46) * (v36 * 3.33);
    local math_min_ret = math.min(1, Magnitude / 1);
    p30._spinRate = v45 * (1 - v35) * math_min_ret + v47;

    if Magnitude < 1 then
        if not p30._settleEngaged then
            local VisualPart = p30.VisualPart;

            if VisualPart and VisualPart:IsA("BasePart") then
                local v48 = VisualPart.Size.Magnitude * 0.5;
                p30._settleSpawnHalf = v48;
                p30._settleContactPos = VisualPart.Position - Normal * v48;
            end;
        end;

        p30._settleEngaged = true;
    end;

    if p30.HasPosOffsetGraphs then
        local function _reflect(p49) -- Line: 352
            -- upvalues: Normal (copy)
            return p49 - 2 * p49:Dot(Normal) * Normal;
        end;

        local v50 = p30._displacementMirrorX or Vector3.new(1, 0, 0);
        local v51 = p30._displacementMirrorY or Vector3.new(0, 1, 0);
        local v52 = p30._displacementMirrorZ or Vector3.new(0, 0, 1);
        p30._displacementMirrorX = v50 - 2 * v50:Dot(Normal) * Normal;
        p30._displacementMirrorY = v51 - 2 * v51:Dot(Normal) * Normal;
        p30._displacementMirrorZ = v52 - 2 * v52:Dot(Normal) * Normal;
        local v53 = (p30.CurrentStep or 0) / math.max(p30.TotalKeyFrames, 1);
        local v54 = p30.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(v53, p30.Graphs.PosOffsetX, p30.Seeds.PosOffsetX) or 0) or 0;
        local v55 = p30.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(v53, p30.Graphs.PosOffsetY, p30.Seeds.PosOffsetY) or 0) or 0;
        local v56 = p30.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(v53, p30.Graphs.PosOffsetZ, p30.Seeds.PosOffsetZ) or 0) or 0;
        p30._prevWorldOff = PartConstants.resolveDisplacement(Vector3.new(v54, v55, v56), p30.DisplacementMode or "Global", p30.SpawnRotation, p30.SpawnEmitterRotation, p30._displacementMirrorX, p30._displacementMirrorY, p30._displacementMirrorZ);
    end;

    local v57 = p31.Position + Normal * 0.05;

    if p30.LocalCF then
        local v58;

        if p30.Type == "Attachment" then
            v58 = attachmentBounceLocalPos(p30, v57);
        else
            v58 = bounceParentCF(p30):PointToObjectSpace(v57);
        end;

        p30.LocalCF = CFrame.new(v58) * (p30.LocalCF - p30.LocalCF.Position);
        p30._localWorldCF = p30.LocalCF;
    end;

    local v59 = readWorldCF(p30);
    local v60 = CFrame.new(v57) * (v59 - v59.Position);
    applySnapCFrame(p30, v60);
    p30._postUpdateCF = v60;
    p30.CurrentPosition = v57;
    p30.LastHitCheckPos = v57;
    p30._hitFired = false;
    p30._hitHistory = p30._hitHistory or {};

    if #p30._hitHistory >= 16 then
        table.remove(p30._hitHistory, 1);
    end;

    table.insert(p30._hitHistory, v38);
end;

function v1.applySettle(p61, p62) -- Line: 399
    -- upvalues: readWorldCF (copy), u2 (copy), applySnapCFrame (copy)
    if not p61 or p61._collisionStopped then
        return;
    end;

    if not p61._settleEngaged then
        return;
    end;

    if p61.NeedsFullIteration then
        return;
    end;

    if p62 and p62 > 0 then
        local math_exp_ret = math.exp(-6 * p62);
        p61._spinRate = (p61._spinRate or Vector3.new(0, 0, 0)) * math_exp_ret;
        p61._settleRotDamp = (p61._settleRotDamp or 1) * math.exp(-6 * p62);
    end;

    local _lastHitNormal = p61._lastHitNormal;

    if not _lastHitNormal or _lastHitNormal.Magnitude < 0.0001 then
        return;
    end;

    local VisualPart = p61.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local v63 = readWorldCF(p61);
    local v64 = -_lastHitNormal;
    local v65 = u2[1];
    local v66 = (-1 / 0);

    for _, v in ipairs(u2) do
        local v67 = v63:VectorToWorldSpace(v):Dot(v64);

        if v66 < v67 then
            v65 = v;
            v66 = v67;
        end;
    end;

    local v68 = v63:VectorToWorldSpace(v65);
    local v69 = v68:Dot(v64);
    local math_clamp_ret = math.clamp(v69, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret);
    local v70 = v68:Cross(v64);

    if v70.Magnitude > 0.0001 and (math_acos_ret > 0.0001 and (p62 and p62 > 0)) then
        local Magnitude = (p61.Acceleration or Vector3.new(0, 0, 0)).Magnitude;

        if Magnitude > 1 then
            local v71 = math.sin(math_acos_ret) * Magnitude * 0.5;
            p61._spinRate = (p61._spinRate or Vector3.new(0, 0, 0)) + v70.Unit * v71 * p62;
        end;
    end;

    if p61._settleContactPos and (p61._settleSpawnHalf and VisualPart:IsA("BasePart")) then
        applySnapCFrame(p61, CFrame.new(p61._settleContactPos + _lastHitNormal * (VisualPart.Size.Magnitude * 0.5)) * (v63 - v63.Position));
    end;

    local v72 = (p61._spinRate or Vector3.new(0, 0, 0)).Magnitude * (p61._sleepRadius or 1) * 0.017453292519943295;

    if math.abs(p61.SpeedMultiplier or 0) + (p61._accelVel or Vector3.new(0, 0, 0)).Magnitude + v72 < 0.1 then
        p61._restTimer = (p61._restTimer or 0) + p62;
    else
        p61._restTimer = 0;
    end;

    if (p61._restTimer or 0) >= 0.5 * (p61._sleepTimeJitter or 1) and math_acos_ret < 0.02 then
        p61._collisionStopped = true;
        p61._spinRate = Vector3.new(0, 0, 0);
        p61._accelVel = Vector3.new(0, 0, 0);
        p61.SpeedMultiplier = 0;
        p61.TargetVel = Vector3.new(0, 0, 0);
    end;
end;

function v1.handle(p73, p74, p75, p76, p77) -- Line: 475
    -- upvalues: handleKillOrStop (copy), handleBounce (copy)
    local v78 = p74.Events.OnHit.Collision or "Off";
    local v79 = v78 == "Bounce" and p74.InvertMotion and "Kill" or v78;
    local v80 = p74.IsAnimate and (v79 == "Kill" or (v79 == "Stop" or v79 == "Bounce")) and "Off" or v79;

    if v80 == "Kill" or v80 == "Stop" then
        handleKillOrStop(p73, p74, p75, v80);

        return "snap";
    end;

    if v80 == "Bounce" then
        handleBounce(p74, p75, p76, p77);

        return "snap";
    end;

    p74._hitFired = true;

    return "off";
end;

return v1;