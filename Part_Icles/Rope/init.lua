-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local Turbulence = require(script.Parent.Turbulence);
local PartConstants = require(script.Parent.PartConstants);
local script_VerletSim = require(script.VerletSim);
local script_Anchors = require(script.Anchors);
local script_PDataBuilder = require(script.PDataBuilder);
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local u1 = setmetatable({}, {
    __mode = "k"
});

return function(u2) -- Line: 32
    -- upvalues: Pool (copy), CFrame_new_ret (copy), u1 (copy), Graph (copy), Range (copy), script_PDataBuilder (copy), script_Anchors (copy), Particles (copy), NestedEmit (copy), Turbulence (copy), PartConstants (copy), script_VerletSim (copy)
    function u2._isRope(p3) -- Line: 35
        local v4 = p3:IsA("BasePart") and p3:GetAttribute("IsRope") == true;

        return v4;
    end;

    local function buildSegment(p5) -- Line: 41
        -- upvalues: Pool (ref)
        local v6 = Pool.copyBare(p5);
        v6.Anchored = true;
        v6.CanCollide = false;
        v6.CanQuery = false;
        v6.CanTouch = false;
        v6.Massless = true;
        v6.Locked = true;
        v6.Archivable = false;

        return v6, v6:FindFirstChildWhichIsA("Decal") or v6:FindFirstChildWhichIsA("Texture");
    end;

    local function segCapFor(p7) -- Line: 54
        local math_floor_ret = math.floor((p7.SegmentCount and p7.SegmentCount.Max or 12) + 0.5);

        return math.clamp(math_floor_ret, 2, 48);
    end;

    local function buildRig(p8) -- Line: 58
        -- upvalues: Pool (ref), CFrame_new_ret (ref), u1 (ref)
        local math_floor_ret = math.floor((p8.SegmentCount and (p8.SegmentCount.Max or 12) or 12) + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 2, 48);
        local Model = Instance.new("Model");
        Model.Name = "Rope";
        Model.Archivable = false;
        Model:SetAttribute("_lightningBolt", true);
        local v9 = {
            segCap = math_clamp_ret,
            partCount = math_clamp_ret,
            parts = table.create(math_clamp_ret),
            decals = table.create(math_clamp_ret),
            segLen = table.create(math_clamp_ret),
            widthScale = table.create(math_clamp_ret),
            writeCFs = table.create(math_clamp_ret),
            posBuf = table.create(math_clamp_ret + 1),
            prevPosBuf = table.create(math_clamp_ret + 1)
        };

        for i = 1, math_clamp_ret do
            local v10 = Pool.copyBare(p8.RenderTemplate);
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.CanQuery = false;
            v10.CanTouch = false;
            v10.Massless = true;
            v10.Locked = true;
            v10.Archivable = false;
            local v11 = v10:FindFirstChildWhichIsA("Decal") or v10:FindFirstChildWhichIsA("Texture");
            v10.Name = "Seg" .. i;
            v10.CFrame = CFrame_new_ret;
            v10.Parent = Model;
            v9.parts[i] = v10;
            v9.decals[i] = v11;
            v9.segLen[i] = 0.05;
            v9.widthScale[i] = 1;
            v9.writeCFs[i] = CFrame_new_ret;
            local _ = i;
        end;

        u1[Model] = v9;

        return Model, v9;
    end;

    local function acquireRope(p12) -- Line: 92
        -- upvalues: Pool (ref), u1 (ref), buildRig (copy)
        local math_floor_ret = math.floor((p12.SegmentCount and (p12.SegmentCount.Max or 12) or 12) + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 2, 48);
        local u13 = p12.Pool == true and Pool.acquire(p12.RenderTemplate, "Rope");

        if u13 then
            local v14 = u1[u13];

            if v14 and (v14.segCap == math_clamp_ret and (v14.parts[1] and v14.parts[1].Parent == u13)) then
                u13:SetAttribute("_PartIcleEmit", true);

                return u13, v14;
            end;

            pcall(function() -- Line: 102
                -- upvalues: u13 (copy)
                u13:Destroy();
            end);
        end;

        local v15, v16 = buildRig(p12);
        v15:SetAttribute("_PartIcleEmit", true);

        return v15, v16;
    end;

    local function writeVisuals(p17, p18) -- Line: 112
        -- upvalues: Graph (ref)
        local Graphs = p17.Graphs;
        local Seeds = p17.Seeds;
        local v19 = Graphs.Transparency and (Graph.QueryPointsWithTime(p18, Graphs.Transparency, Seeds.Transparency) or 0) or 0;

        if p17.SkipTransparency then
            v19 = p17._curTrans or v19;
        end;

        local v20 = Graphs.Brightness and (Graph.QueryPointsWithTime(p18, Graphs.Brightness, Seeds.Brightness) or 1) or 1;
        local v21;

        if Graphs.Color and not p17.SkipColor then
            local v22 = Graph.QueryColorPointWithTime(p18, Graphs.Color);
            v21 = Color3.new(math.min(v22.R * v20, 1), math.min(v22.G * v20, 1), (math.min(v22.B * v20, 1)));
        else
            v21 = nil;
        end;

        local v23 = Graphs.Thickness and Graph.QueryPointsWithTime(p18, Graphs.Thickness, Seeds.Thickness);
        local _rig = p17._rig;
        local v24;

        if v23 then
            v24 = v23 ~= p17._curThick;
        else
            v24 = v23;
        end;

        if v23 then
            p17._curThick = v23;
        end;

        p17._curTrans = v19;

        for i = 1, _rig.segCap do
            local v25 = _rig.parts[i];
            v25.Transparency = v19;

            if v21 then
                v25.Color = v21;
            end;

            local v26 = _rig.decals[i];

            if v26 then
                v26.Transparency = v19;

                if v21 then
                    v26.Color3 = v21;
                end;
            end;

            local v27;

            if v24 then
                local math_max_ret = math.max(0.05, v23 * _rig.widthScale[i]);
                v25.Size = Vector3.new(math_max_ret, math_max_ret, _rig.segLen[i]);
                v27 = i;
            else
                v27 = i;
            end;
        end;
    end;

    local function writeSegments(p28, p29) -- Line: 146
        -- upvalues: CFrame_new_ret (ref)
        local _rig = p28._rig;
        local posBuf = _rig.posBuf;
        local _segCount = p28._segCount;
        local v30 = p28._curThick or 0.15;

        for i = 1, _segCount do
            local v31 = posBuf[i];
            local v32 = posBuf[i + 1];
            local Magnitude = (v32 - v31).Magnitude;
            local v33 = (v31 + v32) * 0.5;

            if Magnitude > 0.0001 then
                _rig.writeCFs[i] = CFrame.lookAt(v33, v32);
            else
                _rig.writeCFs[i] = CFrame.new(v33);
            end;

            local v34;

            if math.abs(Magnitude - _rig.segLen[i]) > 0.01 then
                _rig.segLen[i] = math.max(Magnitude, 0.05);
                local math_max_ret = math.max(0.05, v30 * _rig.widthScale[i]);
                _rig.parts[i].Size = Vector3.new(math_max_ret, math_max_ret, _rig.segLen[i]);
                v34 = i;
            else
                v34 = i;
            end;
        end;

        for i = _segCount + 1, _rig.segCap do
            _rig.writeCFs[i] = CFrame_new_ret;
            local _ = i;
        end;

        if p29 then
            for i = 1, _rig.segCap do
                _rig.parts[i].CFrame = _rig.writeCFs[i];
                local _ = i;
            end;

            return;
        end;

        workspace:BulkMoveTo(_rig.parts, _rig.writeCFs, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    function u2.EmitRope(p35, p36, p37, p38) -- Line: 181
        -- upvalues: Range (ref), acquireRope (copy), script_PDataBuilder (ref), u2 (copy), script_Anchors (ref), Graph (ref), writeSegments (copy), writeVisuals (copy), Pool (ref), Particles (ref), NestedEmit (ref)
        if not (p36 and p36.Parent) then
            return;
        end;

        local Data = p35:GetData(p36);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v39 = Range.RandomValueFromRange(Data.Lifetime);
        local v40, v41 = acquireRope(Data);
        local v42 = script_PDataBuilder.build(p36, Data, v40, v41, v39 <= 0 and 0.001 or v39, p38, p37);
        u2._seedTsOverride(v42, p36);

        if Data.Pool == true then
            v42._sourceRT = Data.RenderTemplate;
            v42._poolKind = "Rope";
        end;

        script_Anchors.seedPose(v42);
        v42._curThick = Data.Thickness and (Graph.QueryPointsWithTime(0, Data.Thickness, v42.Seeds.Thickness) or 0.15) or 0.15;
        writeSegments(v42, true);
        writeVisuals(v42, 0);
        v40.Parent = Data.EmitParent or p35:GetFolder();
        Pool.restoreTrails(v40, "Rope");
        Particles.EnableEmit(v40, p35:_makeAliveCheck());
        v42._nestedAlive = { true };
        p35:_registerEmit(v42, p38);
        NestedEmit.walk(p35, Data.RenderTemplate, v40, v42._nestedAlive, p38);
    end;

    function u2.EmitRopeAnimate(p43, p44, p45, p46) -- Line: 211
        -- upvalues: Range (ref), buildRig (copy), script_PDataBuilder (ref), u2 (copy), script_Anchors (ref), Graph (ref), writeSegments (copy), writeVisuals (copy), Particles (ref), NestedEmit (ref)
        if not (p44 and p44.Parent) then
            return;
        end;

        if p43.ActiveAnimates[p44] then
            return;
        end;

        local Data = p43:GetData(p44);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v47 = Range.RandomValueFromRange(Data.Lifetime);
        local v48, v49 = buildRig(Data);
        v48:SetAttribute("_PartIcleEmit", true);
        local v50 = script_PDataBuilder.build(p44, Data, v48, v49, v47 <= 0 and 0.001 or v47, p46, p45);
        v50.IsAnimate = true;
        v50.AnimateItem = p44;
        u2._seedTsOverride(v50, p44);
        script_Anchors.seedPose(v50);
        v50._curThick = Data.Thickness and (Graph.QueryPointsWithTime(0, Data.Thickness, v50.Seeds.Thickness) or 0.15) or 0.15;
        writeSegments(v50, true);
        writeVisuals(v50, 0);
        v48.Parent = Data.EmitParent or p43:GetFolder();
        Particles.EnableEmit(v48, p43:_makeAliveCheck());
        v50._nestedAlive = { true };
        p43.ActiveAnimates[p44] = v50;
        p43:_registerEmit(v50, p46);
        NestedEmit.walk(p43, Data.RenderTemplate, v48, v50._nestedAlive, p46);
    end;

    function u2.UpdateRope(p51, p52, p53, p54) -- Line: 243
        -- upvalues: Graph (ref), Turbulence (ref), script_Anchors (ref), PartConstants (ref), script_VerletSim (ref), writeSegments (copy), writeVisuals (copy)
        local math_max_ret = math.max((p54 - p52.StartTime) / p52.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v55;

        if p52._tsOverride == nil or p54 >= (p52._tsOverrideUntil or 0) then
            v55 = p52.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p52.Graphs.Timescale, p52.Seeds.Timescale) or 1) or 1;
        else
            v55 = p52._tsOverride;
        end;

        local v56 = p53 * v55;
        local LifeTime = p52.LifeTime;
        local v57 = p52._effectiveElapsed or 0;
        local v58 = v57 + (p52._timeFrozen and 0 or v56);
        local v59 = v58 < 0 and 0 or v58;

        if LifeTime < v59 then
            v59 = LifeTime;
        end;

        p52._effectiveElapsed = v59;
        local VisualPart = p52.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p52.TotalKeyFrames <= 0 then
            return true;
        end;

        local v60;

        if math_min_ret >= 1 then
            v60 = LifeTime <= v59 and true or v59 <= 0;
        else
            v60 = false;
        end;

        if not v60 then
            local v61;

            if p52._timeFrozen == true then
                v61 = 0;
            else
                local math_abs_ret = math.abs(v56);
                v61 = math.min(math_abs_ret, 0.25);
            end;

            local math_clamp_ret = math.clamp(v59 - v57, -0.25, 0.25);
            local math_max_ret2 = math.max(v59 / LifeTime, 0);
            local math_min_ret2 = math.min(math_max_ret2, 1);
            local v62 = (p52._growIn <= 0 or math_min_ret2 >= p52._growIn) and 1 or math.max(math_min_ret2 / p52._growIn, 0.02);

            if p52._deathMode == "Retract" then
                local v63 = 1 - p52._deathWindow;

                if v63 < math_min_ret2 then
                    v62 = v62 * math.max(1 - (math_min_ret2 - v63) / p52._deathWindow, 0.02);
                end;
            elseif p52._deathMode == "Release" and (not p52._released and 1 - p52._deathWindow < math_min_ret2) then
                p52._released = true;
                p52._pinStart = false;
                p52._pinEnd = false;
            end;

            p52._restLenEff = p52._restLen * v62;

            if p52._hasMotion and math_clamp_ret ~= 0 then
                local v64 = p52.Graphs.Speed and (Graph.QueryPointsWithTime(math_min_ret2, p52.Graphs.Speed, p52.Seeds.Speed) or 0) or 0;

                if p52._drag ~= 0 then
                    v64 = v64 * math.exp(-p52._drag * v59);
                end;

                p52._motionAccelVel = p52._motionAccelVel + p52._accel * math_clamp_ret;
                p52._motionOffset = p52._motionOffset + (p52._speedDir or p52._motionDir) * (v64 * math_clamp_ret) + p52._motionAccelVel * math_clamp_ret;
            end;

            if p52._hasDisp or (p52._hasTurb or p52._hasMotion) then
                local v65;

                if p52._hasDisp then
                    local Graphs = p52.Graphs;
                    local Seeds = p52.Seeds;
                    local v66 = Graphs.PosOffsetX and (Graph.QueryPointsWithTime(math_min_ret2, Graphs.PosOffsetX, Seeds.PosOffsetX) or 0) or 0;
                    local v67 = Graphs.PosOffsetY and (Graph.QueryPointsWithTime(math_min_ret2, Graphs.PosOffsetY, Seeds.PosOffsetY) or 0) or 0;
                    local v68 = Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(math_min_ret2, Graphs.PosOffsetZ, Seeds.PosOffsetZ) or 0) or 0;
                    v65 = Vector3.new(v66, v67, v68);
                else
                    v65 = Vector3.new(0, 0, 0);
                end;

                if p52._hasTurb then
                    v65 = v65 + Turbulence.sampleRaw(p52.Graphs.Turbulence, p52.Seeds.Turbulence, p52._turbSeed, p52._turbFreq, LifeTime, math_min_ret2);
                end;

                if p52._dispMode ~= "Global" then
                    v65 = script_Anchors.resolveStart(p52).Rotation:VectorToWorldSpace(v65);
                end;

                if p52._hasMotion then
                    v65 = v65 + p52._motionOffset;
                end;

                p52._anchorOffWorld = v65;
            else
                p52._anchorOffWorld = nil;
            end;

            if p52._pinMode == "Launch" then
                if p52._launchArrived then
                    if p52._launchT then
                        local _target = p52._target;

                        if _target and _target.Parent then
                            p52._launchPos = PartConstants.resolveLinkCFrame(_target).Position;
                        end;
                    end;
                elseif p52._launchT and p52._launchT <= v59 then
                    p52._launchArrived = true;
                    local _target = p52._target;

                    if _target and _target.Parent then
                        p52._launchPos = PartConstants.resolveLinkCFrame(_target).Position;
                    end;
                else
                    local v69 = p52._launchVel * v59 + p52._gravity * (0.5 * v59 * v59);

                    if not p52._launchT then
                        local v70 = p52._restLen * p52._segCount;

                        if v70 <= v69.Magnitude then
                            v69 = v69.Unit * v70;
                            p52._launchArrived = true;
                        end;
                    end;

                    p52._launchPos = p52._launchOrigin + v69;
                end;
            end;

            if v61 > 1e-6 then
                p52._windPhase = p52._windPhase + p52._windFreq * v61;
                local _rig = p52._rig;
                local math_min_ret3 = math.min(v61, script_VerletSim.SUBSTEP);
                local v71 = p52._accum + v61;
                local v72 = 0;

                while math_min_ret3 <= v71 and v72 < script_VerletSim.MAX_SUBSTEPS do
                    script_Anchors.repin(p52);
                    script_VerletSim.step(_rig.posBuf, _rig.prevPosBuf, p52._segCount, p52, math_min_ret3, p52._windPhase);
                    v71 = v71 - math_min_ret3;
                    v72 = v72 + 1;
                end;

                p52._accum = v72 == script_VerletSim.MAX_SUBSTEPS and 0 or v71;
                script_Anchors.repin(p52);
                writeSegments(p52, false);
            end;
        end;

        local math_max_ret2 = math.max(v59 / LifeTime, 0);
        local v73 = math.min(math_max_ret2, 1) * p52.TotalKeyFrames;
        local math_floor_ret = math.floor(v73);

        if math_floor_ret ~= p52.CurrentStep then
            p52.CurrentStep = math_floor_ret;
            writeVisuals(p52, math_floor_ret / p52.TotalKeyFrames);
        end;

        return v60;
    end;

    function u2._refreshRopeAnimate(p74, p75, p76) -- Line: 396
        -- upvalues: buildRig (copy), script_PDataBuilder (ref), script_Anchors (ref), Graph (ref), writeSegments (copy), writeVisuals (copy)
        p75.Link = nil;
        local _segCount = p75._segCount;
        local _restLen = p75._restLen;
        local math_floor_ret = math.floor((p76.SegmentCount and (p76.SegmentCount.Max or 12) or 12) + 0.5);
        local v77;

        if math.clamp(math_floor_ret, 2, 48) == p75._rig.segCap or not p76.RenderTemplate then
            v77 = false;
        else
            local VisualPart = p75.VisualPart;
            local v78;

            if VisualPart then
                v78 = VisualPart.Parent;
            else
                v78 = VisualPart;
            end;

            local v79, v80 = buildRig(p76);
            v79:SetAttribute("_PartIcleEmit", true);
            p75.VisualPart = v79;
            p75._rig = v80;
            v79.Parent = v78 or p74:GetFolder();

            if VisualPart then
                pcall(function() -- Line: 412
                    -- upvalues: VisualPart (copy)
                    VisualPart:Destroy();
                end);
                v77 = true;
            else
                v77 = true;
            end;
        end;

        script_PDataBuilder.readRopeParams(p75, p76, p75._rig);
        p75._accum = 0;
        p75._released = false;
        p75.SkipColor = nil;

        if v77 or (p75._segCount ~= _segCount or math.abs((p75._restLen or 0) - (_restLen or 0)) > 0.0001) then
            script_Anchors.seedPose(p75);
            p75._launchArrived = false;
            p75._launchPos = nil;
        end;

        p75._curThick = p76.Thickness and Graph.QueryPointsWithTime(0, p76.Thickness, p75.Seeds.Thickness) or p75._curThick;
        writeSegments(p75, false);
        writeVisuals(p75, 0);
    end;
end;