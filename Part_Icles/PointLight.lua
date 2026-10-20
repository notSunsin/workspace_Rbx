-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);

return function(u1) -- Line: 10
    -- upvalues: Graph (copy), Pool (copy), Range (copy)
    function u1.UpdatePointLight(p2, p3, p4, p5) -- Line: 12
        -- upvalues: Graph (ref)
        local math_max_ret = math.max((p5 - p3.StartTime) / p3.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v6;

        if p3._tsOverride == nil or p5 >= (p3._tsOverrideUntil or 0) then
            v6 = p3.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p3.Graphs.Timescale, p3.Seeds.Timescale) or 1) or 1;
        else
            v6 = p3._tsOverride;
        end;

        local LifeTime = p3.LifeTime;
        local v7 = (p3._effectiveElapsed or 0) + (p3._timeFrozen and 0 or p4 * v6);
        local v8 = v7 < 0 and 0 or v7;

        if LifeTime < v8 then
            v8 = LifeTime;
        end;

        p3._effectiveElapsed = v8;

        if not (p3.VisualPart and p3.VisualPart.Parent) then
            return true;
        end;

        if p3.TotalKeyFrames <= 0 then
            return true;
        end;

        if p3._parentAlive and not p3._parentAlive[1] then
            return true;
        end;

        local math_max_ret2 = math.max(v8 / LifeTime, 0);
        local v9 = math.min(math_max_ret2, 1) * p3.TotalKeyFrames;
        local math_floor_ret = math.floor(v9);

        if math_floor_ret ~= p3.CurrentStep then
            p3.CurrentStep = math_floor_ret;
            local v10 = p3.CurrentStep / p3.TotalKeyFrames;
            local v11 = nil;
            local v12 = nil;
            local v13;

            if p3.Graphs.PLRange then
                v13 = Graph.QueryPointsWithTime(v10, p3.Graphs.PLRange, p3.Seeds.PLRange);
                p3.VisualPart.Range = v13;
            else
                v13 = nil;
            end;

            if p3.Graphs.PLBrightness and not p3.SkipTransparency then
                v11 = Graph.QueryPointsWithTime(v10, p3.Graphs.PLBrightness, p3.Seeds.PLBrightness);
                p3.VisualPart.Brightness = v11;
            end;

            if p3.Graphs.PLColor and not p3.SkipColor then
                v12 = Graph.QueryColorPointWithTime(v10, p3.Graphs.PLColor);
                p3.VisualPart.Color = v12;
            end;

            local _extraLights = p3._extraLights;

            if _extraLights then
                for i = 1, #_extraLights do
                    local v14 = _extraLights[i];

                    if v13 then
                        v14.Range = v13;
                    end;

                    if v11 then
                        v14.Brightness = v11;
                    end;

                    local v15;

                    if v12 then
                        v14.Color = v12;
                        v15 = i;
                    else
                        v15 = i;
                    end;
                end;
            end;
        end;

        return math_min_ret >= 1 and (LifeTime <= v8 or v8 <= 0);
    end;

    function u1.EmitPointLight(p16, p17, p18, p19) -- Line: 74
        -- upvalues: Pool (ref), Range (ref), Graph (ref), u1 (copy)
        if not (p17 and p17.Parent) then
            return;
        end;

        local Data = p16:GetData(p17);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v20 = Pool.acquireOrClone(Data.RenderTemplate, "PointLight", Data.Pool);
        v20.Archivable = false;
        v20.Enabled = true;

        if Data.Shadows ~= nil then
            v20.Shadows = Data.Shadows;
        end;

        local v21 = Data.EmitParent or (p18 or p17.Parent);
        local v22 = nil;
        local v23;

        if v21 and v21:IsA("Model") then
            v23 = nil;

            for _, child in ipairs(v21:GetChildren()) do
                if child:IsA("BasePart") then
                    v23 = v23 or {};
                    v23[#v23 + 1] = child;
                end;
            end;

            if v23 then
                if v21:GetAttribute("_lightningBolt") then
                    v21 = v23[1];
                else
                    v21 = v23[math.ceil(#v23 / 2)];
                    v23 = v22;
                end;
            else
                v23 = v22;
            end;
        else
            v23 = v22;
        end;

        local v24 = Range.RandomValueFromRange(Data.Lifetime);
        local v25 = v24 <= 0 and 0.001 or v24;
        local v26 = Data.PLRange and (Graph.GenerateSeed(Data.PLRange) or {}) or {};
        local v27 = Data.PLBrightness and (Graph.GenerateSeed(Data.PLBrightness) or {}) or {};
        local v28 = Graph.GenerateSeed(Data.PLTimescale);

        if Data.PLRange then
            v20.Range = Graph.QueryPointsWithTime(0, Data.PLRange, v26);
        end;

        if Data.PLBrightness then
            v20.Brightness = Graph.QueryPointsWithTime(0, Data.PLBrightness, v27);
        end;

        if Data.PLColor then
            v20.Color = Graph.QueryColorPointWithTime(0, Data.PLColor);
        end;

        v20.Parent = v21;
        local v29;

        if v23 and #v23 > 1 then
            v20.Archivable = true;
            v29 = table.create(#v23 - 1);

            for i = 2, #v23 do
                local v30 = v20:Clone();
                v30.Archivable = false;
                v30.Parent = v23[i];
                v29[i - 1] = v30;
                local _ = i;
            end;

            v20.Archivable = false;
        else
            v29 = nil;
        end;

        local v31 = {
            Type = "PointLight",
            CurrentStep = 0,
            VisualPart = v20,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v25,
            PartLife = Data.PartLife or 0,
            Graphs = {
                PLRange = Data.PLRange,
                PLBrightness = Data.PLBrightness,
                PLColor = Data.PLColor,
                Timescale = Data.PLTimescale
            },
            Seeds = {
                PLRange = v26,
                PLBrightness = v27,
                Timescale = v28
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.PLTimescale, v28, v25),
            _sourceItem = p17,
            _extraLights = v29
        };

        if p19 and (p19._parentAlive and not Data.EmitParent) then
            v31._parentAlive = p19._parentAlive;
        end;

        u1._seedTsOverride(v31, p17);

        if Data.Pool ~= false then
            v31._sourceRT = Data.RenderTemplate;
            v31._poolKind = "PointLight";
        end;

        p16:_registerEmit(v31, p19);
    end;
end;