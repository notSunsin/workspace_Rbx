-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local EventsCollision = require(script.Parent.EventsCollision);
local Turbulence = require(script.Parent.Turbulence);
local DirectionVectors = PartConstants.DirectionVectors;

local function _posOffsetFrameDelta(p1, p2) -- Line: 16
    -- upvalues: Graph (copy), PartConstants (copy), Turbulence (copy)
    if not (p1.HasPosOffsetGraphs or p1.HasTurbulence) then
        return Vector3.new(0, 0, 0);
    end;

    local v3;

    if p1.HasPosOffsetGraphs then
        local v4 = p1._staticPosOffsetX or (p1.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(p2, p1.Graphs.PosOffsetX, p1.Seeds.PosOffsetX) or 0) or 0);
        local v5 = p1._staticPosOffsetY or (p1.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(p2, p1.Graphs.PosOffsetY, p1.Seeds.PosOffsetY) or 0) or 0);
        local v6 = p1._staticPosOffsetZ or (p1.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(p2, p1.Graphs.PosOffsetZ, p1.Seeds.PosOffsetZ) or 0) or 0);
        local v7 = PartConstants.resolveDisplacement(Vector3.new(v4, v5, v6), p1.DisplacementMode or "Global", p1.SpawnRotation, p1.SpawnEmitterRotation, p1._displacementMirrorX, p1._displacementMirrorY, p1._displacementMirrorZ);
        v3 = v7 - p1._prevWorldOff;
        p1._prevWorldOff = v7;
    else
        v3 = Vector3.new(0, 0, 0);
    end;

    if p1.HasTurbulence then
        v3 = v3 + Turbulence.frameDelta(p1, p2);
    end;

    return v3;
end;

local function getLinkCF(p8) -- Line: 38
    -- upvalues: PartConstants (copy)
    local Link = p8.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false;
    end;

    local v9;

    if p8.LinkMode == "RigidLocal" then
        v9 = p8._rigidLocalParentCF or CFrame.new();
    else
        v9 = PartConstants.resolveLinkCFrame(Link);
    end;

    if p8.LinkMode == "Follow" or p8.LinkMode == "Pivot" then
        return CFrame.new(v9.Position), false;
    end;

    return v9, true;
end;

return function(p10) -- Line: 53
    -- upvalues: Graph (copy), EventsCollision (copy), getLinkCF (copy), PartConstants (copy), _posOffsetFrameDelta (copy), DirectionVectors (copy)
    function p10.UpdateModel(p11, p12, p13, p14) -- Line: 58
        -- upvalues: Graph (ref), EventsCollision (ref), getLinkCF (ref), PartConstants (ref), _posOffsetFrameDelta (ref), DirectionVectors (ref)
        local math_max_ret = math.max((p14 - p12.StartTime) / p12.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v15;

        if p12._tsOverride == nil or p14 >= (p12._tsOverrideUntil or 0) then
            v15 = p12.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p12.Graphs.Timescale, p12.Seeds.Timescale) or 1) or 1;
        else
            v15 = p12._tsOverride;
        end;

        local v16 = p13 * v15;
        local LifeTime = p12.LifeTime;
        local v17 = p12._effectiveElapsed or 0;
        local v18 = v17 + (p12._timeFrozen and 0 or v16);

        if v16 < 0 and (p12._hitHistory and #p12._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(p12, v17, v18);
        end;

        local v19 = v18 < 0 and 0 or v18;

        if LifeTime < v19 then
            v19 = LifeTime;
        end;

        p12._effectiveElapsed = v19;
        local v20 = v19 - v17;
        p12._lastEffectiveDt = v20;
        local v21 = LifeTime <= v19;
        local v22 = v19 <= 0;

        if not (p12.VisualPart and p12.VisualPart.Parent) then
            return true;
        end;

        if p12.TotalKeyFrames <= 0 then
            return true;
        end;

        local v23 = math_min_ret >= 1;

        if p12._collisionStopped then
            if v23 then
                v23 = v21 or v22;
            end;

            return v23;
        end;

        if v23 then
            v23 = v21 or v22;
        end;

        local math_max_ret2 = math.max(v19 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        p12.AccumulatedDT = p12.AccumulatedDT + v20;
        local math_floor_ret = math.floor(math_min_ret2 * p12.TotalKeyFrames);

        if math_floor_ret ~= p12.CurrentStep then
            local CurrentStep = p12.CurrentStep;
            local v24 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local AccumulatedDT = p12.AccumulatedDT;
            local v25 = AccumulatedDT / math_abs_ret;
            p12.AccumulatedDT = 0;
            local _spinRate = p12._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                p12._spinAccumX = (p12._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                p12._spinAccumY = (p12._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                p12._spinAccumZ = (p12._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v26 = p12.SpeedMultiplier or 1;
            local v27 = p12._spinAccumX or 0;
            local v28 = p12._spinAccumY or 0;
            local v29 = p12._spinAccumZ or 0;
            local v30 = p12.RotOrder or "Global";

            if p12.InvertMotion then
                p12.CurrentStep = math_floor_ret;
                local v31 = p12.SimLocalCFrames[p12.TotalKeyFrames - math_floor_ret] or p12.SimLocalCFrames[0];
                local v32 = getLinkCF(p12);
                p12.VisualPart:PivotTo(v32 * v31);
                p12._localWorldCF = v31;
                p12.CurrentPosition = p12.VisualPart:GetPivot().Position;
            elseif p12.NeedsFullIteration then
                local HasDrag = p12.HasDrag;
                local HasAccel = p12.HasAccel;
                local v33 = p12._accelVel or Vector3.new(0, 0, 0);

                for i = CurrentStep + v24, math_floor_ret, v24 do
                    local v34 = i / p12.TotalKeyFrames;
                    local v35 = v34 * p12.LifeTime;
                    local v36 = p12._speedOverride or (p12._staticSpeed or Graph.QueryPointsWithTime(v34, p12.Graphs.Speed, p12.Seeds.Speed)) * v26;

                    if HasDrag then
                        v36 = v36 * math.exp(-p12.Drag * v35) or v36;
                    end;

                    local v37;

                    if HasAccel then
                        v33 = v33 + PartConstants.applyContactAccel(p12.Acceleration, p12, v25) * v25;
                        v37 = (p12.BaseDirection * v36 + v33) * v25;
                    else
                        v37 = p12.BaseDirection * (v36 * v25);
                    end;

                    local v38 = v37 + _posOffsetFrameDelta(p12, v34);
                    local v39, v40 = getLinkCF(p12);

                    if v40 then
                        v38 = v39:VectorToObjectSpace(v38) or v38;
                    end;

                    p12.LocalCF = CFrame.new(v38) * p12.LocalCF;
                    local v41 = p12._settleRotDamp or 1;
                    local v42 = (p12._staticRotSpeedX or Graph.QueryPointsWithTime(v34, p12.Graphs.RotSpeedX, p12.Seeds.RotSpeedX)) * v41;
                    local v43 = (p12._staticRotSpeedY or Graph.QueryPointsWithTime(v34, p12.Graphs.RotSpeedY, p12.Seeds.RotSpeedY)) * v41;
                    local v44 = (p12._staticRotSpeedZ or Graph.QueryPointsWithTime(v34, p12.Graphs.RotSpeedZ, p12.Seeds.RotSpeedZ)) * v41;
                    local v45;

                    if p12.RotMode == "Speed" then
                        p12.AccRotX = p12.AccRotX + v42 * v25;
                        p12.AccRotY = p12.AccRotY + v43 * v25;
                        p12.AccRotZ = p12.AccRotZ + v44 * v25;
                        v45 = PartConstants.composeRotation(v30, p12.AccRotX + v27, p12.AccRotY + v28, p12.AccRotZ + v29);
                    else
                        v45 = PartConstants.composeRotation(v30, v42 + v27, v43 + v28, v44 + v29);
                    end;

                    p12.VisualPart:PivotTo(v39 * p12.LocalCF * v45);
                    p12._localWorldCF = p12.LocalCF * v45;
                    p12.CurrentPosition = p12.VisualPart:GetPivot().Position;
                    local v46 = p12.VisualPart:GetPivot() * p12.SpreadRotation;
                    local v47 = DirectionVectors[p12.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                    p12.BaseDirection = v46[v47.vector] * v47.multiplier;
                    local _ = i;
                end;

                p12._accelVel = v33;
                p12.CurrentStep = math_floor_ret;
            elseif p12.NeedsRotAccum then
                local HasDrag = p12.HasDrag;
                local HasAccel = p12.HasAccel;
                local v48 = p12._accelVel or Vector3.new(0, 0, 0);
                local v49 = Vector3.new(0, 0, 0);
                local v50 = 0;

                for i = CurrentStep + v24, math_floor_ret, v24 do
                    local v51 = i / p12.TotalKeyFrames;
                    local v52 = v51 * p12.LifeTime;
                    local v53 = p12._speedOverride or (p12._staticSpeed or Graph.QueryPointsWithTime(v51, p12.Graphs.Speed, p12.Seeds.Speed)) * v26;

                    if HasDrag then
                        v53 = v53 * math.exp(-p12.Drag * v52);
                    end;

                    v50 = v50 + v53 * v25;

                    if HasAccel then
                        v48 = v48 + PartConstants.applyContactAccel(p12.Acceleration, p12, v25) * v25;
                        v49 = v49 + v48 * v25;
                    end;

                    local v54 = p12._settleRotDamp or 1;
                    local v55 = (p12._staticRotSpeedX or Graph.QueryPointsWithTime(v51, p12.Graphs.RotSpeedX, p12.Seeds.RotSpeedX)) * v54;
                    local v56 = (p12._staticRotSpeedY or Graph.QueryPointsWithTime(v51, p12.Graphs.RotSpeedY, p12.Seeds.RotSpeedY)) * v54;
                    local v57 = (p12._staticRotSpeedZ or Graph.QueryPointsWithTime(v51, p12.Graphs.RotSpeedZ, p12.Seeds.RotSpeedZ)) * v54;
                    p12.AccRotX = p12.AccRotX + v55 * v25;
                    p12.AccRotY = p12.AccRotY + v56 * v25;
                    p12.AccRotZ = p12.AccRotZ + v57 * v25;
                    local _ = i;
                end;

                p12._accelVel = v48;
                local v58 = p12.BaseDirection * v50 + v49 + _posOffsetFrameDelta(p12, math_floor_ret / p12.TotalKeyFrames);
                local v59, v60 = getLinkCF(p12);

                if v60 then
                    v58 = v59:VectorToObjectSpace(v58) or v58;
                end;

                p12.LocalCF = CFrame.new(v58) * p12.LocalCF;
                local v61 = PartConstants.composeRotation(v30, p12.AccRotX + v27, p12.AccRotY + v28, p12.AccRotZ + v29);
                p12.VisualPart:PivotTo(v59 * p12.LocalCF * v61);
                p12._localWorldCF = p12.LocalCF * v61;
                p12.CurrentPosition = p12.VisualPart:GetPivot().Position;
                p12.CurrentStep = math_floor_ret;
            else
                local HasDrag = p12.HasDrag;
                local HasAccel = p12.HasAccel;
                local v62 = p12._accelVel or Vector3.new(0, 0, 0);
                local v63 = Vector3.new(0, 0, 0);
                local v64 = 0;

                for i = CurrentStep + v24, math_floor_ret, v24 do
                    local v65 = i / p12.TotalKeyFrames;
                    local v66 = v65 * p12.LifeTime;
                    local v67 = p12._speedOverride or (p12._staticSpeed or Graph.QueryPointsWithTime(v65, p12.Graphs.Speed, p12.Seeds.Speed)) * v26;

                    if HasDrag then
                        v67 = v67 * math.exp(-p12.Drag * v66);
                    end;

                    v64 = v64 + v67 * v25;
                    local v68;

                    if HasAccel then
                        v62 = v62 + PartConstants.applyContactAccel(p12.Acceleration, p12, v25) * v25;
                        v63 = v63 + v62 * v25;
                        v68 = i;
                    else
                        v68 = i;
                    end;
                end;

                p12._accelVel = v62;
                local v69 = p12.BaseDirection * v64 + v63 + _posOffsetFrameDelta(p12, math_floor_ret / p12.TotalKeyFrames);
                local v70, v71 = getLinkCF(p12);

                if v71 then
                    v69 = v70:VectorToObjectSpace(v69) or v69;
                end;

                p12.LocalCF = CFrame.new(v69) * p12.LocalCF;
                local v72 = math_floor_ret / p12.TotalKeyFrames;
                local v73 = p12._settleRotDamp or 1;
                local v74 = (p12._staticRotSpeedX or Graph.QueryPointsWithTime(v72, p12.Graphs.RotSpeedX, p12.Seeds.RotSpeedX)) * v73;
                local v75 = (p12._staticRotSpeedY or Graph.QueryPointsWithTime(v72, p12.Graphs.RotSpeedY, p12.Seeds.RotSpeedY)) * v73;
                local v76 = p12._staticRotSpeedZ or Graph.QueryPointsWithTime(v72, p12.Graphs.RotSpeedZ, p12.Seeds.RotSpeedZ);
                local v77 = PartConstants.composeRotation(v30, v74 + v27, v75 + v28, v76 * v73 + v29);
                p12.VisualPart:PivotTo(v70 * p12.LocalCF * v77);
                p12._localWorldCF = p12.LocalCF * v77;
                p12.CurrentPosition = p12.VisualPart:GetPivot().Position;
                p12.CurrentStep = math_floor_ret;
            end;

            local v78 = p12._staticScale or Graph.QueryPointsWithTime(math_floor_ret / p12.TotalKeyFrames, p12.Graphs.Scale, p12.Seeds.Scale);
            local v79 = math.max(0.001, v78) * PartConstants.getParentScaleFactor(p12.ParentScale, p14, Graph);
            p12.VisualPart:ScaleTo(v79);

            if p12._visualBeams then
                for _, v in ipairs(p12._visualBeams) do
                    if v.Parent and v.Segments < 20 then
                        v.Segments = 20;
                    end;
                end;
            end;
        end;

        return v23;
    end;
end;