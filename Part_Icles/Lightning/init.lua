-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);
local PartConstants = require(script.Parent.PartConstants);
local AxisLinks = require(script.Parent.AxisLinks);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local Turbulence = require(script.Parent.Turbulence);
local Events = require(script.Parent.Events);
local script_BoltGen = require(script.BoltGen);
local DirectionVectors = PartConstants.DirectionVectors;
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local script_Rig = require(script.Rig);
local buildRig = script_Rig.buildRig;
local acquireBolt = script_Rig.acquireBolt;
local layoutFor = script_Rig.layoutFor;
local u1 = -1;
local u2 = 0;
local u3 = false;
local u4 = 0;

return function(u5) -- Line: 52
    -- upvalues: CFrame_new_ret (copy), script_BoltGen (copy), Graph (copy), Events (copy), Range (copy), acquireBolt (copy), u2 (ref), Pool (copy), Particles (copy), NestedEmit (copy), buildRig (copy), u1 (ref), u3 (ref), u4 (ref), Turbulence (copy), DirectionVectors (copy), AxisLinks (copy), PartConstants (copy), layoutFor (copy)
    function u5._isLightning(p6) -- Line: 55
        local v7 = p6:IsA("BasePart") and p6:GetAttribute("IsLightning") == true;

        return v7;
    end;

    local script_Endpoints = require(script.Endpoints);
    local sampleShape = script_Endpoints.sampleShape;
    local resolveEndpoints = script_Endpoints.resolveEndpoints;

    local function rebuildRevealMask(p8, p9, p10) -- Line: 69
        -- upvalues: CFrame_new_ret (ref)
        local v11 = p8.maxReveal or 0;
        local v12 = 0;

        for i = 1, p8.partCount do
            local v13 = p8.revealOrder[i];
            local v14 = p8.revealDist[v13];
            local v15;

            if p10 then
                if v14 == (1 / 0) then
                    v15 = false;
                else
                    v15 = v14 + p8.segLen[v13] >= v11 - p9;
                end;
            else
                v15 = v14 <= p9;
            end;

            local v16;

            if v15 then
                p8.writeCFs[v13] = p8.rollCFs[v13];
                v12 = i;
                v16 = v12;
                local v17 = v12;
                v12 = v16;
                v17 = v16;
            else
                p8.writeCFs[v13] = CFrame_new_ret;
                v16 = i;
            end;
        end;

        return v12;
    end;

    local function flushCFrames(p18, p19) -- Line: 94
        -- upvalues: rebuildRevealMask (copy)
        local _rig = p18._rig;
        local v20 = p18._lSpeed ~= 0;

        if v20 then
            p18._revealPtr = rebuildRevealMask(_rig, p18._tipDist or 0, p18._growReversed);
        end;

        local v21 = v20 and _rig.writeCFs or _rig.rollCFs;

        if p19 then
            for i = 1, _rig.partCount do
                _rig.parts[i].CFrame = v21[i];
                local _ = i;
            end;

            return;
        end;

        workspace:BulkMoveTo(_rig.parts, v21, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    local function writeSizes(p22, p23, p24) -- Line: 111
        -- upvalues: script_BoltGen (ref)
        for i = 1, script_BoltGen.planSizes(p22, p23, p24) do
            local v25 = p22.sizeWriteIdx[i];
            local math_max_ret = math.max(0.05, p23 * p22.widthScale[v25]);
            p22.parts[v25].Size = Vector3.new(math_max_ret, math_max_ret, p22.segLen[v25]);
            local _ = i;
        end;
    end;

    local function applyRoll(u26, p27) -- Line: 121
        -- upvalues: resolveEndpoints (copy), script_BoltGen (ref), CFrame_new_ret (ref), Graph (ref), writeSizes (copy), flushCFrames (copy)
        local _rig = u26._rig;
        local u28, u29, v30 = resolveEndpoints(u26);
        u26._totalLen = script_BoltGen.roll(_rig, u26, u29, v30, CFrame_new_ret);

        if u26._shapeMode ~= "Jitter" then
            script_BoltGen.applyScroll(_rig, u26, u26._scrollPhase or 0);
            script_BoltGen.applyScrollForks(_rig, u26, u26._scrollPhase or 0);
        end;

        local v31 = script_BoltGen.diffLive(_rig);
        local Gradient = u26.Graphs.Gradient;

        if not p27 and v31 > 0 then
            local _curTrans = u26._curTrans;
            local v32;

            if Gradient then
                v32 = nil;
            else
                v32 = u26._curColor or nil;
            end;

            for i = 1, v31 do
                local v33 = _rig.newlyLiveIdx[i];
                local v34 = _rig.parts[v33];

                if _curTrans then
                    v34.Transparency = _curTrans;
                end;

                if v32 then
                    v34.Color = v32;
                end;

                local v35 = _rig.decals[v33];
                local v36;

                if v35 then
                    if _curTrans then
                        v35.Transparency = _curTrans;
                    end;

                    if v32 then
                        v35.Color3 = v32;
                        v36 = i;
                    else
                        v36 = i;
                    end;
                else
                    v36 = i;
                end;
            end;
        end;

        if Gradient and not u26.SkipColor then
            local v37 = 1 / math.max(_rig.maxReveal or 0, 0.0001);
            local _curTint = u26._curTint;

            for i = 1, _rig.partCount do
                local v38;

                if _rig.prevLive[i] then
                    local math_clamp_ret = math.clamp((_rig.revealDist[i] + _rig.segLen[i] * 0.5) * v37, 0, 1);
                    local v39 = Graph.QueryColorPointWithTime(math_clamp_ret, Gradient);
                    _rig.gradColor[i] = v39;

                    if p27 then
                        v38 = i;
                    else
                        if _curTint then
                            v39 = Color3.new(math.min(v39.R * _curTint.R, 1), math.min(v39.G * _curTint.G, 1), (math.min(v39.B * _curTint.B, 1))) or v39;
                        end;

                        _rig.parts[i].Color = v39;
                        local v40 = _rig.decals[i];

                        if v40 then
                            v40.Color3 = v39;
                            v38 = i;
                        else
                            v38 = i;
                        end;
                    end;
                else
                    v38 = i;
                end;
            end;
        end;

        writeSizes(_rig, u26._curThick or 0.15, p27);
        pcall(function() -- Line: 173
            -- upvalues: u26 (copy), u29 (copy), u28 (copy)
            u26.VisualPart.WorldPivot = CFrame.new(u29) * u28.Rotation;
        end);
        flushCFrames(u26, p27);
    end;

    local function writeVisuals(p41, p42) -- Line: 180
        -- upvalues: Graph (ref), writeSizes (copy)
        local Graphs = p41.Graphs;
        local Seeds = p41.Seeds;
        local v43 = Graphs.Transparency and (Graph.QueryPointsWithTime(p42, Graphs.Transparency, Seeds.Transparency) or 0) or 0;

        if p41.SkipTransparency then
            v43 = p41._curTrans or v43;
        end;

        local v44 = Graphs.Brightness and (Graph.QueryPointsWithTime(p42, Graphs.Brightness, Seeds.Brightness) or 1) or 1;
        local v45;

        if Graphs.Color and not p41.SkipColor then
            local v46 = Graph.QueryColorPointWithTime(p42, Graphs.Color);
            v45 = Color3.new(math.min(v46.R * v44, 1), math.min(v46.G * v44, 1), (math.min(v46.B * v44, 1)));
        else
            v45 = nil;
        end;

        local v47 = Graphs.Thickness and Graph.QueryPointsWithTime(p42, Graphs.Thickness, Seeds.Thickness);
        local _rig = p41._rig;
        local v48;

        if v47 then
            v48 = v47 ~= p41._curThick;
        else
            v48 = v47;
        end;

        if v47 then
            p41._curThick = v47;
        end;

        p41._curTrans = v43;

        if v45 then
            p41._curColor = v45;
            p41._curTint = v45;
        end;

        local Gradient = Graphs.Gradient;

        for i = 1, _rig.partCount do
            local v49;

            if _rig.prevLive[i] then
                local v50 = _rig.parts[i];
                v50.Transparency = v43;
                local v51 = _rig.decals[i];

                if v51 then
                    v51.Transparency = v43;
                end;

                if v45 then
                    local v52;

                    if Gradient then
                        local v53 = _rig.gradColor[i];

                        if v53 then
                            v52 = Color3.new(math.min(v53.R * v45.R, 1), math.min(v53.G * v45.G, 1), (math.min(v53.B * v45.B, 1)));
                        else
                            v52 = v45;
                        end;
                    else
                        v52 = v45;
                    end;

                    v50.Color = v52;

                    if v51 then
                        v51.Color3 = v52;
                        v49 = i;
                    else
                        v49 = i;
                    end;
                else
                    v49 = i;
                end;
            else
                v49 = i;
            end;
        end;

        if v48 then
            writeSizes(_rig, v47, false);
        end;
    end;

    local script_PDataBuilder = require(script.PDataBuilder);
    local build = script_PDataBuilder.build;

    local function buildSeekParams(u54, p55) -- Line: 231
        -- upvalues: Events (ref)
        if p55._endpointMode ~= "Seek" then
            return;
        end;

        local u56 = Events.makeHitParams(p55);
        u56.RespectCanCollide = true;
        pcall(function() -- Line: 235
            -- upvalues: u56 (copy), u54 (copy)
            u56:AddToFilter(u54:GetFolder());
            u56:AddToFilter(u54:GetPoolFolder());
        end);

        function p55._seekRayFn(p57, p58) -- Line: 239
            -- upvalues: u56 (copy)
            return workspace:Raycast(p57, p58, u56);
        end;
    end;

    local function fireSeekHit(p59, p60) -- Line: 247
        -- upvalues: script_Endpoints (copy), Events (ref)
        if not p60._seekNewHit then
            return;
        end;

        if not script_Endpoints.glideArrived(p60) then
            return;
        end;

        p60._seekNewHit = nil;

        if not (p60.Events and (p60.Events.OnHit and p60._seekHit)) then
            return;
        end;

        local _seekHit = p60._seekHit;
        local v61 = Events.makePayload(p59, p60, "OnHit", nil);
        v61.HitInstance = _seekHit.Instance;
        v61.Other = _seekHit.Instance;
        v61.HitPosition = _seekHit.Position;
        v61.HitNormal = _seekHit.Normal;
        Events.fire(p59, p60, "OnHit", p60.EventChainCtx, v61);
    end;

    function u5.EmitLightning(p62, p63, p64, p65) -- Line: 263
        -- upvalues: Range (ref), acquireBolt (ref), build (copy), u5 (copy), Graph (ref), buildSeekParams (copy), u2 (ref), applyRoll (copy), writeVisuals (copy), Pool (ref), Particles (ref), NestedEmit (ref), fireSeekHit (copy)
        if not (p63 and p63.Parent) then
            return;
        end;

        local Data = p62:GetData(p63);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v66 = Range.RandomValueFromRange(Data.Lifetime);
        local v67, v68 = acquireBolt(Data);
        local v69 = build(p63, Data, v67, v68, v66 <= 0 and 0.001 or v66, p65);
        v69._parentLink = p64;

        if p65 then
            local v70;

            if p65.EventOriginResolver then
                v70 = p65.EventOriginResolver();
            else
                v70 = nil;
            end;

            local v71 = v70 or p65.EventOriginCF;

            if v71 then
                v69._startCFOverride = p65.UseFullOrigin and v71 and v71 or CFrame.new(v71.Position) * p63.CFrame.Rotation;
            end;
        end;

        u5._seedTsOverride(v69, p63);

        if Data.Pool ~= false then
            v69._sourceRT = Data.RenderTemplate;
            v69._poolKind = "Lightning";
        end;

        v69._curThick = Data.Thickness and (Graph.QueryPointsWithTime(0, Data.Thickness, v69.Seeds.Thickness) or 0.15) or 0.15;
        buildSeekParams(p62, v69);
        u2 = u2 + 1;
        applyRoll(v69, true);
        writeVisuals(v69, 0);
        v67.Parent = Data.EmitParent or p62:GetFolder();
        Pool.restoreTrails(v67, "Lightning");
        Particles.EnableEmit(v67, p62:_makeAliveCheck());
        p62:_registerEmit(v69, p65);
        NestedEmit.walk(p62, Data.RenderTemplate, v67, v69._nestedAlive, p65);
        fireSeekHit(p62, v69);
    end;

    function u5.EmitLightningAnimate(p72, p73, p74, p75) -- Line: 313
        -- upvalues: Range (ref), buildRig (ref), build (copy), u5 (copy), Graph (ref), buildSeekParams (copy), u2 (ref), applyRoll (copy), writeVisuals (copy), Particles (ref), NestedEmit (ref), fireSeekHit (copy)
        if not (p73 and p73.Parent) then
            return;
        end;

        if p72.ActiveAnimates[p73] then
            return;
        end;

        local Data = p72:GetData(p73);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v76 = Range.RandomValueFromRange(Data.Lifetime);
        local v77, v78 = buildRig(Data);
        v77:SetAttribute("_PartIcleEmit", true);
        local v79 = build(p73, Data, v77, v78, v76 <= 0 and 0.001 or v76, p75);
        v79._parentLink = p74;
        v79.IsAnimate = true;
        v79.AnimateItem = p73;
        u5._seedTsOverride(v79, p73);
        v79._curThick = Data.Thickness and (Graph.QueryPointsWithTime(0, Data.Thickness, v79.Seeds.Thickness) or 0.15) or 0.15;
        buildSeekParams(p72, v79);
        u2 = u2 + 1;
        applyRoll(v79, true);
        writeVisuals(v79, 0);
        v77.Parent = Data.EmitParent or p72:GetFolder();
        Particles.EnableEmit(v77, p72:_makeAliveCheck());
        p72.ActiveAnimates[p73] = v79;
        p72:_registerEmit(v79, p75);
        NestedEmit.walk(p72, Data.RenderTemplate, v77, v79._nestedAlive, p75);
        fireSeekHit(p72, v79);
    end;

    function u5.UpdateLightning(p80, p81, p82, p83) -- Line: 349
        -- upvalues: Graph (ref), u1 (ref), u2 (ref), u3 (ref), u4 (ref), Turbulence (ref), applyRoll (copy), fireSeekHit (copy), script_Endpoints (copy), rebuildRevealMask (copy), CFrame_new_ret (ref), script_BoltGen (ref), writeSizes (copy), writeVisuals (copy)
        local math_max_ret = math.max((p83 - p81.StartTime) / p81.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v84;

        if p81._tsOverride == nil or p83 >= (p81._tsOverrideUntil or 0) then
            v84 = p81.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p81.Graphs.Timescale, p81.Seeds.Timescale) or 1) or 1;
        else
            v84 = p81._tsOverride;
        end;

        local v85 = p82 * v84;
        local LifeTime = p81.LifeTime;
        local v86 = p81._effectiveElapsed or 0;
        local v87 = v86 + (p81._timeFrozen and 0 or v85);
        local v88 = v87 < 0 and 0 or v87;

        if LifeTime < v88 then
            v88 = LifeTime;
        end;

        p81._effectiveElapsed = v88;
        local VisualPart = p81.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p81.TotalKeyFrames <= 0 then
            return true;
        end;

        local v89;

        if math_min_ret >= 1 then
            v89 = LifeTime <= v88 and true or v88 <= 0;
        else
            v89 = false;
        end;

        local _rig = p81._rig;

        if p83 ~= u1 then
            u1 = p83;
            u2 = 0;

            if p82 > 0.025 then
                u3 = true;
                u4 = 0;
            elseif u3 then
                if p82 < 0.01818181818181818 then
                    u4 = u4 + 1;

                    if u4 >= 2 then
                        u3 = false;
                    end;
                else
                    u4 = 0;
                end;
            end;
        end;

        if not v89 then
            local v90 = v88 - v86;

            if p81._hasMotion and v90 ~= 0 then
                local math_max_ret2 = math.max(v88 / LifeTime, 0);
                local math_min_ret2 = math.min(math_max_ret2, 1);
                local v91 = p81.Graphs.Speed and (Graph.QueryPointsWithTime(math_min_ret2, p81.Graphs.Speed, p81.Seeds.Speed) or 0) or 0;

                if p81._drag ~= 0 then
                    v91 = v91 * math.exp(-p81._drag * v88);
                end;

                p81._motionAccelVel = p81._motionAccelVel + p81._accel * v90;
                p81._motionOffset = p81._motionOffset + (p81._lastDirWorld or Vector3.new(0, 0, 0)) * (v91 * v90) + p81._motionAccelVel * v90;
            end;

            if p81._hasDisp then
                local math_max_ret2 = math.max(v88 / LifeTime, 0);
                local math_min_ret2 = math.min(math_max_ret2, 1);
                local v92 = p81.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(math_min_ret2, p81.Graphs.PosOffsetX, p81.Seeds.PosOffsetX) or 0) or 0;
                local v93 = p81.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(math_min_ret2, p81.Graphs.PosOffsetY, p81.Seeds.PosOffsetY) or 0) or 0;
                local v94 = p81.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(math_min_ret2, p81.Graphs.PosOffsetZ, p81.Seeds.PosOffsetZ) or 0) or 0;
                p81._dispRaw = Vector3.new(v92, v93, v94);
            end;

            if p81._hasTurb then
                local math_max_ret2 = math.max(v88 / LifeTime, 0);
                local math_min_ret2 = math.min(math_max_ret2, 1);
                p81._turbRaw = Turbulence.sampleRaw(p81.Graphs.Turbulence, p81.Seeds.Turbulence, p81._turbSeed, p81._turbFreq, LifeTime, math_min_ret2);
            end;

            if p81._rollPending and p81._rollPendingStamp ~= p83 then
                p81._rollPending = nil;
                p81._rollPendingStamp = nil;
                p81._jitterAccum = 0;
                u2 = u2 + 1;
                applyRoll(p81, false);
                fireSeekHit(p80, p81);
            end;

            if script_Endpoints.glideStep(p81, (math.abs(v90))) and p81._jitterInterval == (1 / 0) then
                if u3 and u2 >= 8 then
                    p81._rollPending = true;
                    p81._rollPendingStamp = p83;
                else
                    u2 = u2 + 1;
                    applyRoll(p81, false);
                    fireSeekHit(p80, p81);
                end;
            end;

            p81._jitterAccum = p81._jitterAccum + math.abs(v85);

            if p81._jitterAccum >= p81._jitterInterval and not p81._rollPending then
                if u3 and u2 >= 8 then
                    p81._rollPending = true;
                    p81._rollPendingStamp = p83;
                else
                    p81._jitterAccum = 0;
                    u2 = u2 + 1;
                    applyRoll(p81, false);
                    fireSeekHit(p80, p81);
                end;
            end;

            if p81._lSpeed ~= 0 then
                local v95 = math.abs(p81._lSpeed) * v88;

                if v95 ~= p81._tipDist then
                    p81._tipDist = v95;

                    if p81._growReversed then
                        if p81._shapeMode == "Jitter" then
                            local _rig2 = p81._rig;
                            local v96 = p81._lSpeed ~= 0;

                            if v96 then
                                p81._revealPtr = rebuildRevealMask(_rig2, p81._tipDist or 0, p81._growReversed);
                            end;

                            workspace:BulkMoveTo(_rig2.parts, v96 and _rig2.writeCFs or _rig2.rollCFs, Enum.BulkMoveMode.FireCFrameChanged);
                        end;
                    elseif p81._shapeMode == "Jitter" then
                        local revealOrder = _rig.revealOrder;
                        local revealDist = _rig.revealDist;
                        local writeCFs = _rig.writeCFs;
                        local rollCFs = _rig.rollCFs;
                        local _revealPtr = p81._revealPtr;
                        local v97 = false;

                        while _revealPtr < _rig.partCount and revealDist[revealOrder[_revealPtr + 1]] <= v95 do
                            _revealPtr = _revealPtr + 1;
                            local v98 = revealOrder[_revealPtr];
                            writeCFs[v98] = rollCFs[v98];
                            v97 = true;
                        end;

                        while _revealPtr > 0 and v95 < revealDist[revealOrder[_revealPtr]] do
                            writeCFs[revealOrder[_revealPtr]] = CFrame_new_ret;
                            _revealPtr = _revealPtr - 1;
                            v97 = true;
                        end;

                        p81._revealPtr = _revealPtr;

                        if v97 then
                            workspace:BulkMoveTo(_rig.parts, _rig.writeCFs, Enum.BulkMoveMode.FireCFrameChanged);
                        end;
                    end;
                end;
            end;

            if p81._shapeMode ~= "Jitter" then
                p81._scrollPhase = p81._scrollPhase + p81._scrollSpeed * (p81._timeFrozen and 0 or v85);
                script_BoltGen.applyScroll(_rig, p81, p81._scrollPhase);
                script_BoltGen.applyScrollForks(_rig, p81, p81._scrollPhase);
                writeSizes(_rig, p81._curThick or 0.15, false);
                local _rig2 = p81._rig;
                local v99 = p81._lSpeed ~= 0;

                if v99 then
                    p81._revealPtr = rebuildRevealMask(_rig2, p81._tipDist or 0, p81._growReversed);
                end;

                workspace:BulkMoveTo(_rig2.parts, v99 and _rig2.writeCFs or _rig2.rollCFs, Enum.BulkMoveMode.FireCFrameChanged);
            end;
        end;

        local math_max_ret2 = math.max(v88 / LifeTime, 0);
        local v100 = math.min(math_max_ret2, 1) * p81.TotalKeyFrames;
        local math_floor_ret = math.floor(v100);

        if math_floor_ret ~= p81.CurrentStep then
            p81.CurrentStep = math_floor_ret;
            writeVisuals(p81, math_floor_ret / p81.TotalKeyFrames);
        end;

        return v89;
    end;

    function u5._refreshLightningAnimate(p101, p102, p103) -- Line: 526
        -- upvalues: Range (ref), buildSeekParams (copy), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), script_PDataBuilder (copy), Turbulence (ref), sampleShape (copy), layoutFor (ref), buildRig (ref), Graph (ref), u2 (ref), applyRoll (copy), writeVisuals (copy), fireSeekHit (copy)
        p102.Link = nil;
        p102._endpointMode = p103.TargetMode == "Seek" and "Seek" or (p103.TargetMode == "Point" and (p103.Target and p103.Target.Parent) and "Point" or "Directional");
        p102._target = p103.Target;
        local v104 = Range.RandomValueFromRange(p103.SeekRadius);
        p102._seekRadius = math.max(v104, 1);
        p102._seekRetarget = p103.SeekRetarget == true;
        p102._seekBias = math.clamp(p103.SeekBias or 0, 0, 1);
        p102._retargetSpeed = math.max(p103.RetargetSpeed or 0, 0);
        p102._seekHit = nil;
        p102._seekFallbackDir = nil;
        p102._seekNewHit = nil;
        p102._seekCurrentPos = nil;
        p102._seekGoalPos = nil;
        buildSeekParams(p101, p102);
        p102._length = math.max(0.1, Range.RandomValueFromRange(p103.Length));
        p102._amplitude = Range.RandomValueFromRange(p103.Amplitude);
        p102._decay = Range.RandomValueFromRange(p103.AmplitudeDecay);
        p102._forkChance = Range.RandomValueFromRange(p103.ForkChance);
        local v105 = Range.RandomValueFromRange(p103.ForkDepth) + 0.5;
        p102._forkDepth = math.floor(v105);
        p102._forkLenScale = Range.RandomValueFromRange(p103.ForkLengthScale);
        p102._sag = Range.RandomValueFromRange(p103.Sag);
        p102._sagShape = Range.RandomValueFromRange(p103.SagShape);
        p102._shapeMode = p103.ShapeMode or "Jitter";
        p102._scrollSpeed = Range.RandomValueFromRange(p103.ScrollSpeed);
        p102._waves = math.max(0.25, Range.RandomValueFromRange(p103.Waves));
        p102._scrollPhase = 0;
        p102._noiseSeedA = math.random() * 1000;
        p102._noiseSeedB = 500 + math.random() * 1000;
        local v106 = Range.RandomValueFromRange(p103.JitterRate);
        p102._jitterInterval = v106 > 0 and 1 / v106 or (1 / 0);
        p102._jitterAccum = 0;
        p102._lSpeed = p103.GrowthSpeed or 0;
        p102._growReversed = (p103.GrowthSpeed or 0) < 0;
        p102._tipDist = 0;
        p102._revealPtr = 0;
        local v107 = DirectionVectors[p103.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v108 = CFrame.new()[v107.vector] * v107.multiplier;
        local v109 = p103.SpreadAngle or Vector2.new(0, 0);
        local v110 = AxisLinks.sampleRangeAxes(p103, p103.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, nil);
        local v111 = PartConstants.composeRotation(p103.RotOrder or "Global", v110.RotX or 0, v110.RotY or 0, v110.RotZ or 0);
        local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), v108);

        if p103.DirMode == "Local" then
            CFrame_lookAt_ret = CFrame_lookAt_ret * v111;
        end;

        if v109.X > 0 or v109.Y > 0 then
            local CFrame_Angles = CFrame.Angles;
            local v112 = (math.random() * 2 - 1) * v109.X;
            local math_rad_ret = math.rad(v112);
            local v113 = (math.random() * 2 - 1) * v109.Y;
            CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame_Angles(math_rad_ret, math.rad(v113), 0);
        end;

        p102._dirLocalVec = CFrame_lookAt_ret.LookVector;
        p102._dirGlobal = p103.DirMode == "Global";
        p102._originRot = v111;
        local v114 = AxisLinks.sampleRangeAxes(p103, p103.AxisLinks, { "PosX", "PosY", "PosZ" }, Range, nil);
        local v115 = v114.PosX or 0;
        local v116 = v114.PosY or 0;
        local v117 = v114.PosZ or 0;

        if v115 == 0 and (v116 == 0 and v117 == 0) then
            p102._originOffset = nil;
        else
            p102._originOffset = Vector3.new(v115, v116, v117);
            p102._originOffsetGlobal = p103.PosMode == "Global";
        end;

        p102._accel = p103.Acceleration or Vector3.new(0, 0, 0);
        p102._drag = p103.Drag or 0;
        p102._dispMode = p103.DisplacementMode or "Global";
        p102._motionOffset = Vector3.new(0, 0, 0);
        p102._motionAccelVel = Vector3.new(0, 0, 0);
        p102._dispRaw = nil;
        p102._hasMotion = script_PDataBuilder.liveGraph(p103.Speed) ~= nil and true or p102._accel.Magnitude > 0;
        p102._hasDisp = (script_PDataBuilder.liveGraph(p103.PosOffsetX) ~= nil or script_PDataBuilder.liveGraph(p103.PosOffsetY) ~= nil) and true or script_PDataBuilder.liveGraph(p103.PosOffsetZ) ~= nil;
        p102.Graphs.Gradient = script_PDataBuilder.liveColor(p103.Gradient);
        p102.Graphs.Turbulence = Turbulence.isLive(p103.Turbulence);
        p102._hasTurb = p102.Graphs.Turbulence ~= nil;
        p102._turbFreq = p103.TurbulenceFrequency or 1;
        p102._turbSeed = math.random() * 997 + 0.5;
        p102._turbRaw = nil;
        sampleShape(p102, p103, p102.AnimateItem);

        if layoutFor(p103) ~= p102._rig.partCount and p103.RenderTemplate then
            local VisualPart = p102.VisualPart;
            local v118;

            if VisualPart then
                v118 = VisualPart.Parent;
            else
                v118 = VisualPart;
            end;

            local v119, v120 = buildRig(p103);
            v119:SetAttribute("_PartIcleEmit", true);
            p102.VisualPart = v119;
            p102._rig = v120;
            v119.Parent = v118 or p101:GetFolder();

            if VisualPart then
                pcall(function() -- Line: 616
                    -- upvalues: VisualPart (copy)
                    VisualPart:Destroy();
                end);
            end;
        end;

        local v121 = Range.RandomValueFromRange(p103.SegmentCount) + 0.5;
        local math_floor_ret = math.floor(v121);
        p102._segCount = math.clamp(math_floor_ret, 2, p102._rig.mainSegs);
        p102._curThick = p103.Thickness and Graph.QueryPointsWithTime(0, p103.Thickness, p102.Seeds.Thickness) or p102._curThick;
        p102._rollPending = nil;
        p102._rollPendingStamp = nil;
        u2 = u2 + 1;
        applyRoll(p102, false);
        writeVisuals(p102, 0);
        fireSeekHit(p101, p102);
    end;
end;