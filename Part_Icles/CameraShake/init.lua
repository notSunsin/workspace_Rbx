-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local PartConstants = require(script.Parent.PartConstants);
local script_Apply = require(script.Apply);
local u1 = false;

return function(u2) -- Line: 29
    -- upvalues: Graph (copy), RunService (copy), u1 (ref), Range (copy), PartConstants (copy), script_Apply (copy)
    function u2._isCameraShake(p3) -- Line: 32
        local v4 = p3:IsA("BasePart") and p3:GetAttribute("IsCameraShake") == true;

        return v4;
    end;

    local function buildPData(p5, p6, p7, p8) -- Line: 36
        -- upvalues: Graph (ref)
        local v9 = {
            ShakeAmplitude = Graph.GenerateSeed(p6.ShakeAmplitude),
            ShakeRotAmplitude = Graph.GenerateSeed(p6.ShakeRotAmplitude),
            Timescale = Graph.GenerateSeed(p6.Timescale)
        };
        local v10 = {
            Type = "CameraShake",
            VisualPart = nil,
            CurrentStep = -1,
            PartLife = 0,
            Events = p6.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, p6.TotalKeyFrames),
            LifeTime = p7,
            _sourceItem = p5,
            Graphs = {
                ShakeAmplitude = p6.ShakeAmplitude,
                ShakeRotAmplitude = p6.ShakeRotAmplitude,
                Timescale = p6.Timescale
            },
            Seeds = v9,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(p6.Timescale, v9.Timescale, p7),
            _shakeFreq = p6.ShakeFrequency or 10,
            _falloff = p6.ShakeFalloff or 0,
            _shakeSeed = math.random() * 997 + 0.5,
            _lastOriginPos = p5.Position
        };

        if p8 then
            local v11;

            if p8.EventOriginResolver then
                v11 = p8.EventOriginResolver();
            else
                v11 = nil;
            end;

            local v12 = v11 or p8.EventOriginCF;

            if v12 then
                v10._originOverride = v12.Position;
            end;
        end;

        return v10;
    end;

    function u2.EmitCameraShake(p13, p14, p15, p16) -- Line: 75
        -- upvalues: RunService (ref), u1 (ref), Range (ref), buildPData (copy), u2 (copy)
        if not (p14 and p14.Parent) then
            return;
        end;

        if not RunService:IsClient() then
            if not u1 then
                u1 = true;
                warn("[Part-Icles] CameraShake ignored on the server (no camera).");
            end;

            return;
        end;

        local Data = p13:GetData(p14);

        if not Data then
            return;
        end;

        local v17 = Range.RandomValueFromRange(Data.Lifetime);
        local v18 = buildPData(p14, Data, v17 <= 0 and 0.001 or v17, p16);
        v18._parentLink = p15;
        u2._seedTsOverride(v18, p14);
        p13:_registerEmit(v18, p16);
    end;

    function u2.EmitCameraShakeAnimate(p19, p20, p21, p22) -- Line: 99
        -- upvalues: RunService (ref), Range (ref), buildPData (copy), u2 (copy)
        if not (p20 and p20.Parent) then
            return;
        end;

        if p19.ActiveAnimates[p20] then
            return;
        end;

        if not RunService:IsClient() then
            return;
        end;

        local Data = p19:GetData(p20);

        if not Data then
            return;
        end;

        local v23 = Range.RandomValueFromRange(Data.Lifetime);
        local v24 = buildPData(p20, Data, v23 <= 0 and 0.001 or v23, p22);
        v24._parentLink = p21;
        v24.IsAnimate = true;
        v24.AnimateItem = p20;
        u2._seedTsOverride(v24, p20);
        p19.ActiveAnimates[p20] = v24;
        p19:_registerEmit(v24, p22);
    end;

    function u2.UpdateCameraShake(p25, p26, p27, p28) -- Line: 121
        -- upvalues: Graph (ref), PartConstants (ref), script_Apply (ref)
        local math_max_ret = math.max((p28 - p26.StartTime) / p26.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v29;

        if p26._tsOverride == nil or p28 >= (p26._tsOverrideUntil or 0) then
            v29 = p26.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p26.Graphs.Timescale, p26.Seeds.Timescale) or 1) or 1;
        else
            v29 = p26._tsOverride;
        end;

        local LifeTime = p26.LifeTime;
        local v30 = (p26._effectiveElapsed or 0) + (p26._timeFrozen and 0 or p27 * v29);
        local v31 = v30 < 0 and 0 or v30;

        if LifeTime < v31 then
            v31 = LifeTime;
        end;

        p26._effectiveElapsed = v31;

        if p26.TotalKeyFrames <= 0 then
            return true;
        end;

        local v32;

        if math_min_ret >= 1 then
            v32 = LifeTime <= v31 and true or v31 <= 0;
        else
            v32 = false;
        end;

        if v32 then
            return true;
        end;

        local _originOverride = p26._originOverride;

        if not _originOverride then
            local _parentLink = p26._parentLink;

            if _parentLink and _parentLink.Parent then
                _originOverride = PartConstants.resolveLinkCFrame(_parentLink).Position;
            else
                local _sourceItem = p26._sourceItem;
                _originOverride = _sourceItem and (_sourceItem.Parent and _sourceItem.Position) or p26._lastOriginPos;
            end;
        end;

        p26._lastOriginPos = _originOverride;
        local math_max_ret2 = math.max(v31 / LifeTime, 0);
        local v33 = math.min(math_max_ret2, 1) * p26.TotalKeyFrames;
        local math_floor_ret = math.floor(v33);

        if math_floor_ret ~= p26.CurrentStep then
            p26.CurrentStep = math_floor_ret;
            local v34 = math_floor_ret / p26.TotalKeyFrames;
            p26._curAmp = p26.Graphs.ShakeAmplitude and (Graph.QueryPointsWithTime(v34, p26.Graphs.ShakeAmplitude, p26.Seeds.ShakeAmplitude) or 0) or 0;
            p26._curRotAmp = p26.Graphs.ShakeRotAmplitude and (Graph.QueryPointsWithTime(v34, p26.Graphs.ShakeRotAmplitude, p26.Seeds.ShakeRotAmplitude) or 0) or 0;
        end;

        local _falloff = p26._falloff;
        local v35;

        if _falloff > 0 then
            local workspace_CurrentCamera = workspace.CurrentCamera;
            v35 = not workspace_CurrentCamera and 0 or math.clamp(1 - (workspace_CurrentCamera.CFrame.Position - _originOverride).Magnitude / _falloff, 0, 1);
        else
            v35 = 1;
        end;

        local v36 = (p26._curAmp or 0) * v35;
        local v37 = math.rad(p26._curRotAmp or 0) * v35;

        if v36 ~= 0 or v37 ~= 0 then
            local v38 = v31 * p26._shakeFreq;
            local _shakeSeed = p26._shakeSeed;
            script_Apply.accumulate(v36 * math.noise(v38, _shakeSeed, 0.17), v36 * math.noise(v38, _shakeSeed, 137.7), v36 * math.noise(v38, _shakeSeed, 291.3), v37 * math.noise(v38, _shakeSeed, 431.1), v37 * math.noise(v38, _shakeSeed, 557.5), v37 * math.noise(v38, _shakeSeed, 683.9));
        end;

        return false;
    end;

    function u2._refreshCameraShakeAnimate(p39, p40, p41) -- Line: 190
        p40.Link = nil;
        p40._shakeFreq = p41.ShakeFrequency or 10;
        p40._falloff = p41.ShakeFalloff or 0;
        p40._curAmp = nil;
        p40._curRotAmp = nil;
        p40.CurrentStep = -1;
    end;
end;