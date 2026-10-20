-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local EventsCollision = require(script.Parent.EventsCollision);
local Turbulence = require(script.Parent.Turbulence);
local DirectionVectors = PartConstants.DirectionVectors;

local function getLinkCF(p1) -- Line: 15
    -- upvalues: PartConstants (copy)
    local Link = p1.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false;
    end;

    local v2;

    if p1.LinkMode == "RigidLocal" then
        v2 = p1._rigidLocalParentCF or CFrame.new();
    else
        v2 = PartConstants.resolveLinkCFrame(Link);
    end;

    if p1.LinkMode == "Follow" or p1.LinkMode == "Pivot" then
        return CFrame.new(v2.Position), false;
    end;

    return v2, true;
end;

local function getAttachmentLinkCF(p3) -- Line: 33
    -- upvalues: PartConstants (copy)
    local Link = p3.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false, false;
    end;

    local v4 = p3.VisualPart and p3.VisualPart.Parent;

    if not v4 then
        return CFrame.new(), false, false;
    end;

    local v5;

    if p3.LinkMode == "RigidLocal" then
        v5 = p3._rigidLocalParentCF or CFrame.new();
    else
        v5 = PartConstants.resolveLinkCFrame(Link);
    end;

    local v6 = (v4:IsA("BasePart") and v4.CFrame or CFrame.new()):ToObjectSpace(v5);

    if p3.LinkMode == "Follow" or p3.LinkMode == "Pivot" then
        return CFrame.new(v6.Position), false, true;
    end;

    return v6, true, true;
end;

local function getTargetPosition(p7) -- Line: 54
    if not (p7 and p7.Parent) then
        return nil;
    end;

    if p7:IsA("Bone") then
        return p7.TransformedWorldCFrame.Position;
    end;

    if p7:IsA("BasePart") then
        return p7.Position;
    end;

    if p7:IsA("Attachment") then
        return p7.WorldPosition;
    end;

    if p7:IsA("Camera") then
        return p7.CFrame.Position;
    end;

    if p7:IsA("Model") then
        local success, result = pcall(p7.GetPivot, p7);

        if success and result then
            return result.Position;
        end;
    end;

    return nil;
end;

local function _posOffsetFrameDelta(p8, p9, p10) -- Line: 76
    -- upvalues: Graph (copy), PartConstants (copy), Turbulence (copy)
    if not (p8.HasPosOffsetGraphs or p8.HasTurbulence) then
        return Vector3.new(0, 0, 0), false;
    end;

    local v11;

    if p8.HasPosOffsetGraphs then
        local v12 = p8._staticPosOffsetX or (p8.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(p9, p8.Graphs.PosOffsetX, p8.Seeds.PosOffsetX) or 0) or 0);
        local v13 = p8._staticPosOffsetY or (p8.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(p9, p8.Graphs.PosOffsetY, p8.Seeds.PosOffsetY) or 0) or 0);
        local v14 = p8._staticPosOffsetZ or (p8.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(p9, p8.Graphs.PosOffsetZ, p8.Seeds.PosOffsetZ) or 0) or 0);
        local v15 = PartConstants.resolveDisplacement(Vector3.new(v12, v13, v14), p8.DisplacementMode or "Global", p8.SpawnRotation, p8.SpawnEmitterRotation, p8._displacementMirrorX, p8._displacementMirrorY, p8._displacementMirrorZ);
        v11 = v15 - p8._prevWorldOff;
        p8._prevWorldOff = v15;
    else
        v11 = Vector3.new(0, 0, 0);
    end;

    if p8.HasTurbulence then
        v11 = v11 + Turbulence.frameDelta(p8, p9);
    end;

    if p10 then
        p10 = (p8.DisplacementMode or "Global") == "Local";
    end;

    return v11, p10;
end;

local function _composeLocalDelta(p16, p17, p18, p19, p20, p21) -- Line: 105
    if p17 then
        return (p16:VectorToObjectSpace(p18) + (p20 and p19 and p19 or p16:VectorToObjectSpace(p19))) * p21;
    end;

    return (p18 + p19) * p21;
end;

return function(p22) -- Line: 112
    -- upvalues: Graph (copy), EventsCollision (copy), PartConstants (copy), getLinkCF (copy), DirectionVectors (copy), getTargetPosition (copy), _posOffsetFrameDelta (copy), getAttachmentLinkCF (copy)
    function p22.UpdatePart(p23, u24, p25, p26) -- Line: 117
        -- upvalues: Graph (ref), EventsCollision (ref), PartConstants (ref), getLinkCF (ref), DirectionVectors (ref), getTargetPosition (ref), _posOffsetFrameDelta (ref)
        local math_max_ret = math.max((p26 - u24.StartTime) / u24.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v27;

        if u24._tsOverride == nil or p26 >= (u24._tsOverrideUntil or 0) then
            v27 = u24.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, u24.Graphs.Timescale, u24.Seeds.Timescale) or 1) or 1;
        else
            v27 = u24._tsOverride;
        end;

        local v28 = p25 * v27;
        local LifeTime = u24.LifeTime;
        local v29 = u24._effectiveElapsed or 0;
        local v30 = v29 + (u24._timeFrozen and 0 or v28);

        if v28 < 0 and (u24._hitHistory and #u24._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(u24, v29, v30);
        end;

        local v31 = v30 < 0 and 0 or v30;

        if LifeTime < v31 then
            v31 = LifeTime;
        end;

        u24._effectiveElapsed = v31;
        local v32 = v31 - v29;
        u24._lastEffectiveDt = v32;
        local v33 = LifeTime <= v31;
        local v34 = v31 <= 0;

        if not (u24.VisualPart and u24.VisualPart.Parent) then
            return true;
        end;

        if u24.TotalKeyFrames <= 0 then
            return true;
        end;

        local v35 = math_min_ret >= 1;

        if u24._collisionStopped then
            if v35 then
                v35 = v33 or v34;
            end;

            return v35;
        end;

        local v36, v37, v38;

        if u24.ParentScale then
            v36 = PartConstants.getParentScaleFactor(u24.ParentScale, p26, Graph);
            v37 = PartConstants.getParentScaleFactor(u24.ParentScale, p26, Graph, "motion");
            v38 = PartConstants.getParentScaleFactor(u24.ParentScale, p26, Graph, "rotation");
        else
            v36 = 1;
            v37 = 1;
            v38 = 1;
        end;

        if v35 then
            v35 = v33 or v34;
        end;

        local math_max_ret2 = math.max(v31 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        u24.AccumulatedDT = u24.AccumulatedDT + v32;
        local math_floor_ret = math.floor(math_min_ret2 * u24.TotalKeyFrames);

        if math_floor_ret ~= u24.CurrentStep then
            local CurrentStep = u24.CurrentStep;
            local v39 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local v40 = u24.AccumulatedDT / math_abs_ret;
            local AccumulatedDT = u24.AccumulatedDT;
            u24.AccumulatedDT = 0;
            local _spinRate = u24._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                u24._spinAccumX = (u24._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                u24._spinAccumY = (u24._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                u24._spinAccumZ = (u24._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v41 = u24.SpeedMultiplier or 1;

            if u24.InvertMotion then
                u24.CurrentStep = math_floor_ret;
                local v42 = u24.SimLocalCFrames[u24.TotalKeyFrames - math_floor_ret] or u24.SimLocalCFrames[0];
                local v43 = getLinkCF(u24);
                u24.VisualPart.CFrame = v43 * v42;
                u24._localWorldCF = v42;
                u24.CurrentPosition = u24.VisualPart.Position;
            elseif u24.NeedsFullIteration then
                local HasDrag = u24.HasDrag;
                local HasAccel = u24.HasAccel;
                local v44, v45 = getLinkCF(u24);
                local v46 = DirectionVectors[u24.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                local LocalCF = u24.LocalCF;
                local AccRotX = u24.AccRotX;
                local AccRotY = u24.AccRotY;
                local AccRotZ = u24.AccRotZ;
                local BaseDirection = u24.BaseDirection;
                local v47 = u24._accelVel or Vector3.new(0, 0, 0);
                local TargetVel = u24.TargetVel;
                local Position = u24.VisualPart.Position;
                local RotMode = u24.RotMode;
                local v48 = u24.RotOrder or "Global";
                local v49 = nil;
                local v50 = nil;

                for i = CurrentStep + v39, math_floor_ret, v39 do
                    local v51 = i / u24.TotalKeyFrames;
                    local v52 = v51 * u24.LifeTime;
                    local v53 = u24._speedOverride or (u24._staticSpeed or Graph.QueryPointsWithTime(v51, u24.Graphs.Speed, u24.Seeds.Speed)) * v41;

                    if HasDrag then
                        v53 = v53 * math.exp(-u24.Drag * v52) or v53;
                    end;

                    local v54;

                    if HasAccel then
                        v47 = v47 + PartConstants.applyContactAccel(u24.Acceleration, u24, v40) * v40;
                        v54 = (BaseDirection * v53 + v47) * v40;
                    else
                        v54 = BaseDirection * (v53 * v40);
                    end;

                    if u24.HasTargetAccel then
                        local v55 = getTargetPosition(u24.AccelTarget);

                        if v55 then
                            local v56 = v55 - Position;
                            local Magnitude = v56.Magnitude;

                            if Magnitude > 0.0001 then
                                local v57 = u24._staticAccelStrength or Graph.QueryPointsWithTime(v51, u24.Graphs.AccelStrength, u24.Seeds.AccelStrength);

                                if v57 and v57 ~= 0 then
                                    TargetVel = TargetVel + v56 * (v57 * v40 / Magnitude);
                                    v54 = v54 + TargetVel * v40;
                                end;
                            end;
                        end;
                    end;

                    local v58, v59 = _posOffsetFrameDelta(u24, v51, v45);
                    local v60;

                    if v45 then
                        v60 = (v44:VectorToObjectSpace(v54) + (v59 and v58 and v58 or v44:VectorToObjectSpace(v58))) * v37;
                    else
                        v60 = (v54 + v58) * v37;
                    end;

                    LocalCF = CFrame.new(v60) * LocalCF;
                    local v61 = (u24._settleRotDamp or 1) * v38;
                    local v62 = (u24._staticRotSpeedX or Graph.QueryPointsWithTime(v51, u24.Graphs.RotSpeedX, u24.Seeds.RotSpeedX)) * v61;
                    local v63 = (u24._staticRotSpeedY or Graph.QueryPointsWithTime(v51, u24.Graphs.RotSpeedY, u24.Seeds.RotSpeedY)) * v61;
                    local v64 = (u24._staticRotSpeedZ or Graph.QueryPointsWithTime(v51, u24.Graphs.RotSpeedZ, u24.Seeds.RotSpeedZ)) * v61;
                    local v65 = u24._spinAccumX or 0;
                    local v66 = u24._spinAccumY or 0;
                    local v67 = u24._spinAccumZ or 0;
                    local v68;

                    if RotMode == "Speed" then
                        AccRotX = AccRotX + v62 * v40;
                        AccRotY = AccRotY + v63 * v40;
                        AccRotZ = AccRotZ + v64 * v40;
                        v68 = PartConstants.composeRotation(v48, AccRotX + v65, AccRotY + v66, AccRotZ + v67);
                    else
                        v68 = PartConstants.composeRotation(v48, v62 + v65, v63 + v66, v64 + v67);
                    end;

                    v49 = v44 * LocalCF * v68;
                    v50 = LocalCF * v68;
                    Position = v49.Position;
                    BaseDirection = (v49 * u24.SpreadRotation)[v46.vector] * v46.multiplier;
                    local _ = i;
                end;

                u24.LocalCF = LocalCF;
                u24.AccRotX = AccRotX;
                u24.AccRotY = AccRotY;
                u24.AccRotZ = AccRotZ;
                u24.BaseDirection = BaseDirection;
                u24._accelVel = v47;
                u24.TargetVel = TargetVel;
                u24.CurrentPosition = Position;
                u24.CurrentStep = math_floor_ret;

                if v49 then
                    u24.VisualPart.CFrame = v49;
                    u24._localWorldCF = v50;
                end;
            elseif u24.NeedsRotAccum then
                local HasDrag = u24.HasDrag;
                local HasAccel = u24.HasAccel;
                local v69 = u24._accelVel or Vector3.new(0, 0, 0);
                local v70 = Vector3.new(0, 0, 0);
                local v71 = 0;

                for i = CurrentStep + v39, math_floor_ret, v39 do
                    local v72 = i / u24.TotalKeyFrames;
                    local v73 = v72 * u24.LifeTime;
                    local v74 = u24._speedOverride or (u24._staticSpeed or Graph.QueryPointsWithTime(v72, u24.Graphs.Speed, u24.Seeds.Speed)) * v41;

                    if HasDrag then
                        v74 = v74 * math.exp(-u24.Drag * v73);
                    end;

                    v71 = v71 + v74 * v40;

                    if HasAccel then
                        v69 = v69 + PartConstants.applyContactAccel(u24.Acceleration, u24, v40) * v40;
                        v70 = v70 + v69 * v40;
                    end;

                    local v75 = (u24._settleRotDamp or 1) * v38;
                    local v76 = (u24._staticRotSpeedX or Graph.QueryPointsWithTime(v72, u24.Graphs.RotSpeedX, u24.Seeds.RotSpeedX)) * v75;
                    local v77 = (u24._staticRotSpeedY or Graph.QueryPointsWithTime(v72, u24.Graphs.RotSpeedY, u24.Seeds.RotSpeedY)) * v75;
                    local v78 = (u24._staticRotSpeedZ or Graph.QueryPointsWithTime(v72, u24.Graphs.RotSpeedZ, u24.Seeds.RotSpeedZ)) * v75;
                    u24.AccRotX = u24.AccRotX + v76 * v40;
                    u24.AccRotY = u24.AccRotY + v77 * v40;
                    u24.AccRotZ = u24.AccRotZ + v78 * v40;
                    local _ = i;
                end;

                u24._accelVel = v69;
                local v79 = u24.BaseDirection * v71 + v70;

                if u24.HasTargetAccel then
                    local v80 = getTargetPosition(u24.AccelTarget);

                    if v80 then
                        local v81 = v80 - u24.VisualPart.Position;
                        local Magnitude = v81.Magnitude;

                        if Magnitude > 0.0001 then
                            local v82 = v40 * (math_floor_ret - CurrentStep);
                            local v83 = u24._staticAccelStrength or Graph.QueryPointsWithTime((CurrentStep + 1 + math_floor_ret) * 0.5 / u24.TotalKeyFrames, u24.Graphs.AccelStrength, u24.Seeds.AccelStrength);

                            if v83 and v83 ~= 0 then
                                u24.TargetVel = u24.TargetVel + v81 * (v83 * v82 / Magnitude);
                                v79 = v79 + u24.TargetVel * v82;
                            end;
                        end;
                    end;
                end;

                local v84, v85 = getLinkCF(u24);
                local v86, v87 = _posOffsetFrameDelta(u24, math_floor_ret / u24.TotalKeyFrames, v85);
                local v88;

                if v85 then
                    v88 = (v84:VectorToObjectSpace(v79) + (v87 and v86 and v86 or v84:VectorToObjectSpace(v86))) * v37;
                else
                    v88 = (v79 + v86) * v37;
                end;

                u24.LocalCF = CFrame.new(v88) * u24.LocalCF;
                local v89 = PartConstants.composeRotation(u24.RotOrder or "Global", u24.AccRotX + (u24._spinAccumX or 0), u24.AccRotY + (u24._spinAccumY or 0), u24.AccRotZ + (u24._spinAccumZ or 0));
                u24.VisualPart.CFrame = v84 * u24.LocalCF * v89;
                u24._localWorldCF = u24.LocalCF * v89;
                u24.CurrentPosition = u24.VisualPart.Position;
                u24.CurrentStep = math_floor_ret;
            else
                local HasAccel = u24.HasAccel;
                local v90 = 0;
                local v91 = Vector3.new(0, 0, 0);
                local v92 = u24._accelVel or Vector3.new(0, 0, 0);

                if u24.HasDrag then
                    for i = CurrentStep + v39, math_floor_ret, v39 do
                        local v93 = i / u24.TotalKeyFrames;
                        local v94 = v93 * u24.LifeTime;
                        v90 = v90 + (u24._speedOverride or (u24._staticSpeed or Graph.QueryPointsWithTime(v93, u24.Graphs.Speed, u24.Seeds.Speed)) * v41) * math.exp(-u24.Drag * v94) * v40;
                        local v95;

                        if HasAccel then
                            v92 = v92 + PartConstants.applyContactAccel(u24.Acceleration, u24, v40) * v40;
                            v91 = v91 + v92 * v40;
                            v95 = i;
                        else
                            v95 = i;
                        end;
                    end;
                else
                    local v96 = 1 / u24.TotalKeyFrames;
                    local v97 = CurrentStep * v96;
                    local v98 = math_floor_ret * v96;
                    local _speedOverride = u24._speedOverride;

                    if _speedOverride then
                        v90 = _speedOverride * (v98 - v97) * u24.LifeTime;
                    elseif u24._staticSpeed then
                        v90 = u24._staticSpeed * v41 * (v98 - v97) * u24.LifeTime;
                    else
                        v90 = u24.LifeTime * v41 * (Graph.IntegrateUpTo(v98, u24.Graphs.Speed, u24.Seeds.Speed) - Graph.IntegrateUpTo(v97, u24.Graphs.Speed, u24.Seeds.Speed));
                    end;

                    if HasAccel then
                        local v99 = (v98 - v97) * u24.LifeTime;
                        local v100 = PartConstants.applyContactAccel(u24.Acceleration, u24, v99);
                        v91 = v92 * v99 + v100 * (v99 * v99 * 0.5);
                        v92 = v92 + v100 * v99;
                    end;
                end;

                u24._accelVel = v92;
                local v101 = u24.BaseDirection * v90 + v91;

                if u24.HasTargetAccel then
                    local v102 = getTargetPosition(u24.AccelTarget);

                    if v102 then
                        local v103 = v102 - u24.VisualPart.Position;
                        local Magnitude = v103.Magnitude;

                        if Magnitude > 0.0001 then
                            local v104 = v40 * (math_floor_ret - CurrentStep);
                            local v105 = u24._staticAccelStrength or Graph.QueryPointsWithTime((CurrentStep + 1 + math_floor_ret) * 0.5 / u24.TotalKeyFrames, u24.Graphs.AccelStrength, u24.Seeds.AccelStrength);

                            if v105 and v105 ~= 0 then
                                u24.TargetVel = u24.TargetVel + v103 * (v105 * v104 / Magnitude);
                                v101 = v101 + u24.TargetVel * v104;
                            end;
                        end;
                    end;
                end;

                local v106, v107 = getLinkCF(u24);
                local v108, v109 = _posOffsetFrameDelta(u24, math_floor_ret / u24.TotalKeyFrames, v107);
                local v110;

                if v107 then
                    v110 = (v106:VectorToObjectSpace(v101) + (v109 and v108 and v108 or v106:VectorToObjectSpace(v108))) * v37;
                else
                    v110 = (v101 + v108) * v37;
                end;

                u24.LocalCF = CFrame.new(v110) * u24.LocalCF;
                local v111 = math_floor_ret / u24.TotalKeyFrames;
                local v112 = (u24._settleRotDamp or 1) * v38;
                local v113 = (u24._staticRotSpeedX or Graph.QueryPointsWithTime(v111, u24.Graphs.RotSpeedX, u24.Seeds.RotSpeedX)) * v112 + (u24._spinAccumX or 0);
                local v114 = (u24._staticRotSpeedY or Graph.QueryPointsWithTime(v111, u24.Graphs.RotSpeedY, u24.Seeds.RotSpeedY)) * v112 + (u24._spinAccumY or 0);
                local v115 = u24._staticRotSpeedZ or Graph.QueryPointsWithTime(v111, u24.Graphs.RotSpeedZ, u24.Seeds.RotSpeedZ);
                local v116 = PartConstants.composeRotation(u24.RotOrder or "Global", v113, v114, v115 * v112 + (u24._spinAccumZ or 0));
                u24.VisualPart.CFrame = v106 * u24.LocalCF * v116;
                u24._localWorldCF = u24.LocalCF * v116;
                u24.CurrentPosition = u24.VisualPart.Position;
                u24.CurrentStep = math_floor_ret;
            end;

            local v117 = math_floor_ret / u24.TotalKeyFrames;

            if not u24.SkipSize then
                local v118 = u24._staticSizeX or Graph.QueryPointsWithTime(v117, u24.Graphs.SizeX, u24.Seeds.SizeX);
                local v119 = u24._staticSizeY or Graph.QueryPointsWithTime(v117, u24.Graphs.SizeY, u24.Seeds.SizeY);
                local v120 = u24._staticSizeZ or Graph.QueryPointsWithTime(v117, u24.Graphs.SizeZ, u24.Seeds.SizeZ);

                if v36 ~= 1 then
                    v118 = v118 * v36;
                    v119 = v119 * v36;
                    v120 = v120 * v36;
                end;

                if u24.SpecialMesh then
                    u24.SpecialMesh.Scale = Vector3.new(v118, v119, v120);
                else
                    u24.VisualPart.Size = Vector3.new(v118, v119, v120);
                end;
            end;

            local v121 = u24._staticTransparency or Graph.QueryPointsWithTime(v117, u24.Graphs.Transparency, u24.Seeds.Transparency);

            if u24.SurfaceAppearance then
                local u122 = u24._staticBrightness or Graph.QueryPointsWithTime(v117, u24.Graphs.Brightness, u24.Seeds.Brightness);
                local u123 = Graph.QueryColorPointWithTime(v117, u24.Graphs.Color);

                if not u24.SkipTransparency then
                    u24.VisualPart.Transparency = v121;
                end;

                if not u24.SkipColor then
                    u24.VisualPart.Color = Color3.fromRGB(u123.R * 255, u123.G * 255, u123.B * 255);
                    u24.SurfaceAppearance.Color = Color3.fromRGB(u123.R * 255, u123.G * 255, u123.B * 255);
                    pcall(function() -- Line: 475
                        -- upvalues: u24 (copy), u123 (copy), u122 (copy)
                        u24.SurfaceAppearance.EmissiveTint = Color3.new(u123.R * u122, u123.G * u122, u123.B * u122);
                    end);

                    return v35;
                end;
            elseif u24.HasDecal then
                local v124 = u24._staticBrightness or Graph.QueryPointsWithTime(v117, u24.Graphs.Brightness, u24.Seeds.Brightness);
                local v125 = Graph.QueryColorPointWithTime(v117, u24.Graphs.Color);

                if not u24.SkipTransparency then
                    u24.Decal.Transparency = v121;
                end;

                if not u24.SkipColor then
                    u24.Decal.Color3 = Color3.fromRGB(v125.R * 255 * v124, v125.G * 255 * v124, v125.B * 255 * v124);

                    return v35;
                end;
            else
                local v126 = Graph.QueryColorPointWithTime(v117, u24.Graphs.Color);

                if not u24.SkipTransparency then
                    u24.VisualPart.Transparency = v121;
                end;

                if not u24.SkipColor then
                    u24.VisualPart.Color = Color3.fromRGB(v126.R * 255, v126.G * 255, v126.B * 255);
                end;
            end;
        end;

        return v35;
    end;

    function p22.UpdateAttachment(p127, p128, p129, p130) -- Line: 494
        -- upvalues: Graph (ref), EventsCollision (ref), PartConstants (ref), getAttachmentLinkCF (ref), _posOffsetFrameDelta (ref), DirectionVectors (ref)
        local math_max_ret = math.max((p130 - p128.StartTime) / p128.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v131;

        if p128._tsOverride == nil or p130 >= (p128._tsOverrideUntil or 0) then
            v131 = p128.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p128.Graphs.Timescale, p128.Seeds.Timescale) or 1) or 1;
        else
            v131 = p128._tsOverride;
        end;

        local v132 = p129 * v131;
        local LifeTime = p128.LifeTime;
        local v133 = p128._effectiveElapsed or 0;
        local v134 = v133 + (p128._timeFrozen and 0 or v132);

        if v132 < 0 and (p128._hitHistory and #p128._hitHistory > 0) then
            EventsCollision.restoreHitsOnReverse(p128, v133, v134);
        end;

        local v135 = v134 < 0 and 0 or v134;

        if LifeTime < v135 then
            v135 = LifeTime;
        end;

        p128._effectiveElapsed = v135;
        local v136 = v135 - v133;
        p128._lastEffectiveDt = v136;
        local v137 = LifeTime <= v135;
        local v138 = v135 <= 0;

        if not (p128.VisualPart and p128.VisualPart.Parent) then
            return true;
        end;

        if p128.TotalKeyFrames <= 0 then
            return true;
        end;

        local v139 = math_min_ret >= 1;

        if p128._collisionStopped then
            if v139 then
                v139 = v137 or v138;
            end;

            return v139;
        end;

        local v140, v141;

        if p128.ParentScale then
            PartConstants.getParentScaleFactor(p128.ParentScale, p130, Graph);
            v140 = PartConstants.getParentScaleFactor(p128.ParentScale, p130, Graph, "motion");
            v141 = PartConstants.getParentScaleFactor(p128.ParentScale, p130, Graph, "rotation");
        else
            v141 = 1;
            v140 = 1;
        end;

        if v139 then
            v139 = v137 or v138;
        end;

        local math_max_ret2 = math.max(v135 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        p128.AccumulatedDT = p128.AccumulatedDT + v136;
        local math_floor_ret = math.floor(math_min_ret2 * p128.TotalKeyFrames);

        if math_floor_ret ~= p128.CurrentStep then
            local CurrentStep = p128.CurrentStep;
            local v142 = CurrentStep < math_floor_ret and 1 or -1;
            local math_abs_ret = math.abs(math_floor_ret - CurrentStep);
            local v143 = p128.AccumulatedDT / math_abs_ret;
            local AccumulatedDT = p128.AccumulatedDT;
            p128.AccumulatedDT = 0;
            local _spinRate = p128._spinRate;

            if _spinRate and (_spinRate.X ~= 0 or (_spinRate.Y ~= 0 or _spinRate.Z ~= 0)) then
                p128._spinAccumX = (p128._spinAccumX or 0) + _spinRate.X * AccumulatedDT;
                p128._spinAccumY = (p128._spinAccumY or 0) + _spinRate.Y * AccumulatedDT;
                p128._spinAccumZ = (p128._spinAccumZ or 0) + _spinRate.Z * AccumulatedDT;
            end;

            local v144 = p128.SpeedMultiplier or 1;
            local v145, v146 = getAttachmentLinkCF(p128);

            if p128.InvertMotion then
                p128.CurrentStep = math_floor_ret;
                local v147 = p128.SimLocalCFrames[p128.TotalKeyFrames - math_floor_ret] or p128.SimLocalCFrames[0];
                p128.VisualPart.CFrame = v145 * v147;
                p128.LocalCF = v147;
                p128._localWorldCF = v147;

                return v139;
            end;

            if p128.NeedsFullIteration then
                local HasDrag = p128.HasDrag;
                local HasAccel = p128.HasAccel;
                local v148 = p128._accelVel or Vector3.new(0, 0, 0);
                local v149 = p128._spinAccumX or 0;
                local v150 = p128._spinAccumY or 0;
                local v151 = p128._spinAccumZ or 0;
                local v152 = p128.RotOrder or "Global";

                for i = CurrentStep + v142, math_floor_ret, v142 do
                    local v153 = i / p128.TotalKeyFrames;
                    local v154 = v153 * p128.LifeTime;
                    local v155 = p128._speedOverride or (p128._staticSpeed or Graph.QueryPointsWithTime(v153, p128.Graphs.Speed, p128.Seeds.Speed)) * v144;

                    if HasDrag then
                        v155 = v155 * math.exp(-p128.Drag * v154) or v155;
                    end;

                    local v156;

                    if HasAccel then
                        v148 = v148 + PartConstants.applyContactAccel(p128.Acceleration, p128, v143) * v143;
                        v156 = (p128.BaseDirection * v155 + v148) * v143;
                    else
                        v156 = p128.BaseDirection * (v155 * v143);
                    end;

                    local v157, v158 = _posOffsetFrameDelta(p128, v153, v146);
                    local v159;

                    if v146 then
                        v159 = (v145:VectorToObjectSpace(v156) + (v158 and v157 and v157 or v145:VectorToObjectSpace(v157))) * v140;
                    else
                        v159 = (v156 + v157) * v140;
                    end;

                    p128.LocalCF = CFrame.new(v159) * p128.LocalCF;
                    local v160 = (p128._settleRotDamp or 1) * v141;
                    local v161 = (p128._staticRotSpeedX or Graph.QueryPointsWithTime(v153, p128.Graphs.RotSpeedX, p128.Seeds.RotSpeedX)) * v160;
                    local v162 = (p128._staticRotSpeedY or Graph.QueryPointsWithTime(v153, p128.Graphs.RotSpeedY, p128.Seeds.RotSpeedY)) * v160;
                    local v163 = (p128._staticRotSpeedZ or Graph.QueryPointsWithTime(v153, p128.Graphs.RotSpeedZ, p128.Seeds.RotSpeedZ)) * v160;
                    local v164;

                    if p128.RotMode == "Speed" then
                        p128.AccRotX = p128.AccRotX + v161 * v143;
                        p128.AccRotY = p128.AccRotY + v162 * v143;
                        p128.AccRotZ = p128.AccRotZ + v163 * v143;
                        v164 = PartConstants.composeRotation(v152, p128.AccRotX + v149, p128.AccRotY + v150, p128.AccRotZ + v151);
                    else
                        v164 = PartConstants.composeRotation(v152, v161 + v149, v162 + v150, v163 + v151);
                    end;

                    p128.VisualPart.CFrame = v145 * p128.LocalCF * v164;
                    p128._localWorldCF = p128.LocalCF * v164;
                    local v165 = DirectionVectors[p128.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                    p128.BaseDirection = (p128.VisualPart.CFrame * p128.SpreadRotation)[v165.vector] * v165.multiplier;
                    local _ = i;
                end;

                p128._accelVel = v148;
                p128.CurrentStep = math_floor_ret;

                return v139;
            end;

            if p128.NeedsRotAccum then
                local HasDrag = p128.HasDrag;
                local HasAccel = p128.HasAccel;
                local v166 = p128._accelVel or Vector3.new(0, 0, 0);
                local v167 = Vector3.new(0, 0, 0);
                local v168 = 0;

                for i = CurrentStep + v142, math_floor_ret, v142 do
                    local v169 = i / p128.TotalKeyFrames;
                    local v170 = v169 * p128.LifeTime;
                    local v171 = p128._speedOverride or (p128._staticSpeed or Graph.QueryPointsWithTime(v169, p128.Graphs.Speed, p128.Seeds.Speed)) * v144;

                    if HasDrag then
                        v171 = v171 * math.exp(-p128.Drag * v170);
                    end;

                    v168 = v168 + v171 * v143;

                    if HasAccel then
                        v166 = v166 + PartConstants.applyContactAccel(p128.Acceleration, p128, v143) * v143;
                        v167 = v167 + v166 * v143;
                    end;

                    local v172 = (p128._settleRotDamp or 1) * v141;
                    local v173 = (p128._staticRotSpeedX or Graph.QueryPointsWithTime(v169, p128.Graphs.RotSpeedX, p128.Seeds.RotSpeedX)) * v172;
                    local v174 = (p128._staticRotSpeedY or Graph.QueryPointsWithTime(v169, p128.Graphs.RotSpeedY, p128.Seeds.RotSpeedY)) * v172;
                    local v175 = (p128._staticRotSpeedZ or Graph.QueryPointsWithTime(v169, p128.Graphs.RotSpeedZ, p128.Seeds.RotSpeedZ)) * v172;
                    p128.AccRotX = p128.AccRotX + v173 * v143;
                    p128.AccRotY = p128.AccRotY + v174 * v143;
                    p128.AccRotZ = p128.AccRotZ + v175 * v143;
                    local _ = i;
                end;

                p128._accelVel = v166;
                local v176 = p128.BaseDirection * v168 + v167;
                local v177, v178 = _posOffsetFrameDelta(p128, math_floor_ret / p128.TotalKeyFrames, v146);
                local v179;

                if v146 then
                    v179 = (v145:VectorToObjectSpace(v176) + (v178 and v177 and v177 or v145:VectorToObjectSpace(v177))) * v140;
                else
                    v179 = (v176 + v177) * v140;
                end;

                p128.LocalCF = CFrame.new(v179) * p128.LocalCF;
                local v180 = PartConstants.composeRotation(p128.RotOrder or "Global", p128.AccRotX + (p128._spinAccumX or 0), p128.AccRotY + (p128._spinAccumY or 0), p128.AccRotZ + (p128._spinAccumZ or 0));
                p128.VisualPart.CFrame = v145 * p128.LocalCF * v180;
                p128._localWorldCF = p128.LocalCF * v180;
                p128.CurrentStep = math_floor_ret;

                return v139;
            end;

            local HasAccel = p128.HasAccel;
            local v181 = 0;
            local v182 = Vector3.new(0, 0, 0);
            local v183 = p128._accelVel or Vector3.new(0, 0, 0);

            if p128.HasDrag then
                for i = CurrentStep + v142, math_floor_ret, v142 do
                    local v184 = i / p128.TotalKeyFrames;
                    local v185 = v184 * p128.LifeTime;
                    v181 = v181 + (p128._speedOverride or (p128._staticSpeed or Graph.QueryPointsWithTime(v184, p128.Graphs.Speed, p128.Seeds.Speed)) * v144) * math.exp(-p128.Drag * v185) * v143;
                    local v186;

                    if HasAccel then
                        v183 = v183 + PartConstants.applyContactAccel(p128.Acceleration, p128, v143) * v143;
                        v182 = v182 + v183 * v143;
                        v186 = i;
                    else
                        v186 = i;
                    end;
                end;
            else
                local v187 = 1 / p128.TotalKeyFrames;
                local v188 = CurrentStep * v187;
                local v189 = math_floor_ret * v187;
                local _speedOverride = p128._speedOverride;

                if _speedOverride then
                    v181 = _speedOverride * (v189 - v188) * p128.LifeTime;
                elseif p128._staticSpeed then
                    v181 = p128._staticSpeed * v144 * (v189 - v188) * p128.LifeTime;
                else
                    v181 = p128.LifeTime * v144 * (Graph.IntegrateUpTo(v189, p128.Graphs.Speed, p128.Seeds.Speed) - Graph.IntegrateUpTo(v188, p128.Graphs.Speed, p128.Seeds.Speed));
                end;

                if HasAccel then
                    local v190 = (v189 - v188) * p128.LifeTime;
                    local v191 = PartConstants.applyContactAccel(p128.Acceleration, p128, v190);
                    v182 = v183 * v190 + v191 * (v190 * v190 * 0.5);
                    v183 = v183 + v191 * v190;
                end;
            end;

            p128._accelVel = v183;
            local v192 = p128.BaseDirection * v181 + v182;
            local v193, v194 = _posOffsetFrameDelta(p128, math_floor_ret / p128.TotalKeyFrames, v146);
            local v195;

            if v146 then
                v195 = (v145:VectorToObjectSpace(v192) + (v194 and v193 and v193 or v145:VectorToObjectSpace(v193))) * v140;
            else
                v195 = (v192 + v193) * v140;
            end;

            p128.LocalCF = CFrame.new(v195) * p128.LocalCF;
            local v196 = math_floor_ret / p128.TotalKeyFrames;
            local v197 = (p128._settleRotDamp or 1) * v141;
            local v198 = (p128._staticRotSpeedX or Graph.QueryPointsWithTime(v196, p128.Graphs.RotSpeedX, p128.Seeds.RotSpeedX)) * v197 + (p128._spinAccumX or 0);
            local v199 = (p128._staticRotSpeedY or Graph.QueryPointsWithTime(v196, p128.Graphs.RotSpeedY, p128.Seeds.RotSpeedY)) * v197 + (p128._spinAccumY or 0);
            local v200 = p128._staticRotSpeedZ or Graph.QueryPointsWithTime(v196, p128.Graphs.RotSpeedZ, p128.Seeds.RotSpeedZ);
            local v201 = PartConstants.composeRotation(p128.RotOrder or "Global", v198, v199, v200 * v197 + (p128._spinAccumZ or 0));
            p128.VisualPart.CFrame = v145 * p128.LocalCF * v201;
            p128._localWorldCF = p128.LocalCF * v201;
            p128.CurrentStep = math_floor_ret;
        end;

        return v139;
    end;
end;