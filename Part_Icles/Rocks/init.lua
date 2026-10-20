-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);
local Events = require(script.Parent.Events);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local PartConstants = require(script.Parent.PartConstants);
local script_Trajectory = require(script.Trajectory);
local script_PDataBuilder = require(script.PDataBuilder);
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local u1 = setmetatable({}, {
    __mode = "k"
});

return function(u2) -- Line: 35
    -- upvalues: Pool (copy), CFrame_new_ret (copy), u1 (copy), Graph (copy), Events (copy), script_Trajectory (copy), Range (copy), script_PDataBuilder (copy), Particles (copy), NestedEmit (copy), PartConstants (copy)
    function u2._isRocks(p3) -- Line: 38
        local v4 = p3:IsA("BasePart") and p3:GetAttribute("IsRocks") == true;

        return v4;
    end;

    local function buildChunk(p5) -- Line: 45
        -- upvalues: Pool (ref)
        local v6 = Pool.copyBare(p5);
        v6.Anchored = true;
        v6.CanCollide = false;
        v6.CanQuery = false;
        v6.CanTouch = false;
        v6.Massless = false;
        v6.Locked = true;
        v6.Archivable = false;
        v6.CastShadow = true;
        v6.Transparency = 0;

        return v6, v6:FindFirstChildWhichIsA("Decal") or v6:FindFirstChildWhichIsA("Texture");
    end;

    local function chunkCapFor(p7) -- Line: 60
        local math_floor_ret = math.floor((p7.ChunkCount and p7.ChunkCount.Max or 10) + 0.5);

        return math.clamp(math_floor_ret, 1, 32);
    end;

    local function buildRig(p8) -- Line: 64
        -- upvalues: Pool (ref), CFrame_new_ret (ref), u1 (ref)
        local math_floor_ret = math.floor((p8.ChunkCount and (p8.ChunkCount.Max or 10) or 10) + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);
        local Model = Instance.new("Model");
        Model.Name = "RockBurst";
        Model.Archivable = false;
        local v9 = {
            chunkCap = math_clamp_ret,
            parts = table.create(math_clamp_ret),
            decals = table.create(math_clamp_ret),
            baseSize = table.create(math_clamp_ret),
            halfExt = table.create(math_clamp_ret),
            bounciness = table.create(math_clamp_ret),
            launchVel = table.create(math_clamp_ret),
            launchAng = table.create(math_clamp_ret),
            spawnPos = table.create(math_clamp_ret),
            spawnRot = table.create(math_clamp_ret),
            trajs = table.create(math_clamp_ret),
            touched = table.create(math_clamp_ret),
            writeCFs = table.create(math_clamp_ret)
        };

        for i = 1, math_clamp_ret do
            local v10 = Pool.copyBare(p8.RenderTemplate);
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.CanQuery = false;
            v10.CanTouch = false;
            v10.Massless = false;
            v10.Locked = true;
            v10.Archivable = false;
            v10.CastShadow = true;
            v10.Transparency = 0;
            local v11 = v10:FindFirstChildWhichIsA("Decal") or v10:FindFirstChildWhichIsA("Texture");
            v10.Name = "Chunk" .. i;
            v10.CFrame = CFrame_new_ret;
            v10.Parent = Model;
            v9.parts[i] = v10;
            v9.decals[i] = v11;
            v9.baseSize[i] = v10.Size;
            v9.writeCFs[i] = CFrame_new_ret;
            local _ = i;
        end;

        u1[Model] = v9;

        return Model, v9;
    end;

    local function acquireRocks(p12) -- Line: 101
        -- upvalues: Pool (ref), u1 (ref), buildRig (copy)
        local math_floor_ret = math.floor((p12.ChunkCount and (p12.ChunkCount.Max or 10) or 10) + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);
        local u13 = p12.Pool ~= false and Pool.acquire(p12.RenderTemplate, "Rocks");

        if u13 then
            local v14 = u1[u13];

            if v14 and (v14.chunkCap == math_clamp_ret and (v14.parts[1] and v14.parts[1].Parent == u13)) then
                u13:SetAttribute("_PartIcleEmit", true);

                return u13, v14;
            end;

            pcall(function() -- Line: 111
                -- upvalues: u13 (copy)
                u13:Destroy();
            end);
        end;

        local v15, v16 = buildRig(p12);
        v15:SetAttribute("_PartIcleEmit", true);

        return v15, v16;
    end;

    local function writeVisuals(p17, p18) -- Line: 121
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

        local v23 = Graphs.Scale and Graph.QueryPointsWithTime(p18, Graphs.Scale, Seeds.Scale);
        local _rig = p17._rig;
        local v24;

        if v23 then
            v24 = v23 ~= p17._curScale;
        else
            v24 = v23;
        end;

        if v23 then
            p17._curScale = v23;
        end;

        p17._curTrans = v19;

        for i = 1, _rig.chunkCap do
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
                v25.Size = _rig.baseSize[i] * math.max(v23, 0.01);
                v27 = i;
            else
                v27 = i;
            end;
        end;
    end;

    local function buildRockParams(u28, p29) -- Line: 154
        -- upvalues: Events (ref)
        local u30 = Events.makeHitParams(p29);
        u30.RespectCanCollide = true;
        pcall(function() -- Line: 157
            -- upvalues: u30 (copy), u28 (copy)
            u30:AddToFilter(u28:GetFolder());
            u30:AddToFilter(u28:GetPoolFolder());
        end);
        p29._rockParams = u30;

        function p29._raycastFn(p31, p32) -- Line: 162
            -- upvalues: u30 (copy)
            return workspace:Raycast(p31, p32, u30);
        end;
    end;

    local function buildTrajectories(p33) -- Line: 168
        -- upvalues: script_Trajectory (ref)
        local _rig = p33._rig;
        local _raycastFn = p33._raycastFn;
        local v34 = p33._curScale or 1;
        local v35 = 0;
        local v36 = (1 / 0);
        local v37 = nil;
        local v38 = false;

        for i = 1, p33._chunkCount do
            local v39 = script_Trajectory.build(_rig.spawnPos[i], _rig.launchVel[i], _rig.spawnRot[i], _rig.launchAng[i], _rig.halfExt[i], v34, p33._gravity, _rig.bounciness[i], p33._friction, _raycastFn);
            _rig.trajs[i] = v39;

            if v39.impactT and v39.impactT < v36 then
                v36 = v39.impactT;
                v37 = v39.hit;
            end;

            local v40;

            if v39.restT == (1 / 0) then
                v40 = i;
                v38 = true;
            elseif v35 < v39.restT then
                v35 = v39.restT;
                v40 = i;
            else
                v40 = i;
            end;
        end;

        p33._firstImpactT = v36;
        p33._firstHitInfo = v37;
        p33._maxRestT = (v35 <= 0 or (v38 or not v35)) and (1 / 0) or v35;
        p33._restWritten = false;
    end;

    local function startPhysics(p41, p42) -- Line: 199
        -- upvalues: buildRockParams (copy), buildTrajectories (copy)
        buildRockParams(p41, p42);
        buildTrajectories(p42);
    end;

    function u2.EmitRocks(p43, p44, p45, p46) -- Line: 205
        -- upvalues: Range (ref), acquireRocks (copy), script_PDataBuilder (ref), u2 (copy), writeVisuals (copy), buildRockParams (copy), buildTrajectories (copy), Pool (ref), Particles (ref), NestedEmit (ref)
        if not (p44 and p44.Parent) then
            return;
        end;

        local Data = p43:GetData(p44);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v47 = Range.RandomValueFromRange(Data.Lifetime);
        local v48, v49 = acquireRocks(Data);
        local v50 = script_PDataBuilder.build(p44, Data, v48, v49, v47 <= 0 and 0.001 or v47, p46, p45);
        u2._seedTsOverride(v50, p44);

        if Data.Pool ~= false then
            v50._sourceRT = Data.RenderTemplate;
            v50._poolKind = "Rocks";
        end;

        writeVisuals(v50, 0);
        v48.Parent = Data.EmitParent or p43:GetFolder();
        buildRockParams(p43, v50);
        buildTrajectories(v50);
        Pool.restoreTrails(v48, "Rocks");
        Particles.EnableEmit(v48, p43:_makeAliveCheck());
        v50._nestedAlive = { true };
        p43:_registerEmit(v50, p46);
        NestedEmit.walk(p43, Data.RenderTemplate, v48, v50._nestedAlive, p46);
    end;

    function u2.EmitRocksAnimate(p51, p52, p53, p54) -- Line: 233
        -- upvalues: Range (ref), buildRig (copy), script_PDataBuilder (ref), u2 (copy), writeVisuals (copy), buildRockParams (copy), buildTrajectories (copy), Particles (ref), NestedEmit (ref)
        if not (p52 and p52.Parent) then
            return;
        end;

        if p51.ActiveAnimates[p52] then
            return;
        end;

        local Data = p51:GetData(p52);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v55 = Range.RandomValueFromRange(Data.Lifetime);
        local v56, v57 = buildRig(Data);
        v56:SetAttribute("_PartIcleEmit", true);
        local v58 = script_PDataBuilder.build(p52, Data, v56, v57, v55 <= 0 and 0.001 or v55, p54, p53);
        v58.IsAnimate = true;
        v58.AnimateItem = p52;
        v58._animateLink = p53;
        u2._seedTsOverride(v58, p52);
        writeVisuals(v58, 0);
        v56.Parent = Data.EmitParent or p51:GetFolder();
        buildRockParams(p51, v58);
        buildTrajectories(v58);
        Particles.EnableEmit(v56, p51:_makeAliveCheck());
        v58._nestedAlive = { true };
        p51.ActiveAnimates[p52] = v58;
        p51:_registerEmit(v58, p54);
        NestedEmit.walk(p51, Data.RenderTemplate, v56, v58._nestedAlive, p54);
    end;

    function u2.UpdateRocks(p59, p60, p61, p62) -- Line: 263
        -- upvalues: Graph (ref), script_Trajectory (ref), Events (ref), writeVisuals (copy)
        local math_max_ret = math.max((p62 - p60.StartTime) / p60.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v63;

        if p60._tsOverride == nil or p62 >= (p60._tsOverrideUntil or 0) then
            v63 = p60.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p60.Graphs.Timescale, p60.Seeds.Timescale) or 1) or 1;
        else
            v63 = p60._tsOverride;
        end;

        local LifeTime = p60.LifeTime;
        local v64 = (p60._effectiveElapsed or 0) + (p60._timeFrozen and 0 or p61 * v63);
        local v65 = v64 < 0 and 0 or v64;

        if LifeTime < v65 then
            v65 = LifeTime;
        end;

        p60._effectiveElapsed = v65;
        local VisualPart = p60.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p60.TotalKeyFrames <= 0 then
            return true;
        end;

        local v66;

        if math_min_ret >= 1 then
            v66 = LifeTime <= v65 and true or v65 <= 0;
        else
            v66 = false;
        end;

        if not v66 then
            local _rig = p60._rig;
            local v67 = p60._sinkOut and v65 / LifeTime > 0.85;

            if v65 < p60._maxRestT or (v67 or not p60._restWritten) then
                local v68;

                if v67 then
                    local v69 = (v65 / LifeTime - 0.85) / 0.15000000000000002;
                    v68 = v69 * v69;
                else
                    v68 = 0;
                end;

                for i = 1, p60._chunkCount do
                    local u70 = _rig.trajs[i];
                    local v71;

                    if u70 then
                        local v72 = script_Trajectory.evaluate(u70, v65, p60._gravity);

                        if v68 > 0 and u70.restT < v65 then
                            local v73 = _rig.baseSize[i];
                            local v74 = math.max(v73.X, v73.Y, v73.Z) * math.max(p60._curScale or 1, 0.01) * 1.5;
                            v72 = v72.Rotation + (v72.Position - Vector3.new(0, v74 * v68, 0));
                        end;

                        _rig.writeCFs[i] = v72;

                        if p60._inheritFloor and (not _rig.touched[i] and (u70.impactT and (u70.impactT <= v65 and u70.hit))) then
                            _rig.touched[i] = true;
                            local u75 = _rig.parts[i];
                            pcall(function() -- Line: 309
                                -- upvalues: u75 (copy), u70 (copy)
                                u75.Material = u70.hit.Instance.Material;
                                u75.Color = u70.hit.Instance.Color;
                            end);
                            p60.SkipColor = true;
                            v71 = i;
                        else
                            v71 = i;
                        end;
                    else
                        v71 = i;
                    end;
                end;

                workspace:BulkMoveTo(_rig.parts, _rig.writeCFs, Enum.BulkMoveMode.FireCFrameChanged);
                local v76;

                if p60._maxRestT <= v65 then
                    v76 = not v67;
                else
                    v76 = false;
                end;

                p60._restWritten = v76;
            end;

            if not p60._hitFired and (p60.Events and (p60.Events.OnHit and (p60._firstHitInfo and p60._firstImpactT <= v65))) then
                p60._hitFired = true;
                local _firstHitInfo = p60._firstHitInfo;
                local v77 = Events.makePayload(p59, p60, "OnHit", nil);
                v77.HitInstance = _firstHitInfo.Instance;
                v77.Other = _firstHitInfo.Instance;
                v77.HitPosition = _firstHitInfo.Position;
                v77.HitNormal = _firstHitInfo.Normal;
                Events.fire(p59, p60, "OnHit", p60.EventChainCtx, v77);
            end;
        end;

        local math_max_ret2 = math.max(v65 / LifeTime, 0);
        local v78 = math.min(math_max_ret2, 1) * p60.TotalKeyFrames;
        local math_floor_ret = math.floor(v78);

        if math_floor_ret ~= p60.CurrentStep then
            p60.CurrentStep = math_floor_ret;
            writeVisuals(p60, math_floor_ret / p60.TotalKeyFrames);
        end;

        return v66;
    end;

    function u2._refreshRocksAnimate(p79, p80, p81) -- Line: 347
        -- upvalues: buildRig (copy), PartConstants (ref), script_PDataBuilder (ref), writeVisuals (copy), buildRockParams (copy), buildTrajectories (copy)
        p80.Link = nil;
        p80._gravity = p81.Gravity or 196.2;
        p80._friction = math.clamp(p81.Friction or 0.3, 0, 1);
        p80._sinkOut = p81.SinkOut ~= false;
        p80._inheritFloor = p81.InheritFloor == true;
        p80._hitFired = false;
        p80.SkipColor = nil;
        local math_floor_ret = math.floor((p81.ChunkCount and (p81.ChunkCount.Max or 10) or 10) + 0.5);

        if math.clamp(math_floor_ret, 1, 32) ~= p80._rig.chunkCap and p81.RenderTemplate then
            local VisualPart = p80.VisualPart;
            local v82;

            if VisualPart then
                v82 = VisualPart.Parent;
            else
                v82 = VisualPart;
            end;

            local v83, v84 = buildRig(p81);
            v83:SetAttribute("_PartIcleEmit", true);
            p80.VisualPart = v83;
            p80._rig = v84;
            v83.Parent = v82 or p79:GetFolder();

            if VisualPart then
                pcall(function() -- Line: 366
                    -- upvalues: VisualPart (copy)
                    VisualPart:Destroy();
                end);
            end;
        end;

        local _animateLink = p80._animateLink;
        local v85;

        if _animateLink and _animateLink.Parent then
            v85 = PartConstants.resolveLinkCFrame(_animateLink);
        else
            v85 = nil;
        end;

        local AnimateItem = p80.AnimateItem;

        if not v85 and (AnimateItem and AnimateItem.Parent) then
            v85 = AnimateItem.CFrame;
        end;

        script_PDataBuilder.rollChunks(p80, p81, p80._rig, v85 or CFrame.new());
        writeVisuals(p80, 0);
        buildRockParams(p79, p80);
        buildTrajectories(p80);
    end;
end;