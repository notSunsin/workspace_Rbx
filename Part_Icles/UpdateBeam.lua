-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);

return function(p1) -- Line: 12
    -- upvalues: Graph (copy), PartConstants (copy)
    function p1.UpdateBeam(p2, p3, p4, p5) -- Line: 17
        -- upvalues: Graph (ref), PartConstants (ref)
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

        local math_max_ret2 = math.max(v8 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        local TransStates = p3.TransStates;
        local ColorStates = p3.ColorStates;

        if not p3.SkipTransparency then
            if TransStates and #TransStates >= 2 then
                local v9 = p3._lastTransIdx or 1;
                local v10 = #TransStates - 1;

                for i = math_min_ret2 < TransStates[v9].Time and 1 or v9, #TransStates - 1 do
                    if TransStates[i].Time <= math_min_ret2 and math_min_ret2 <= TransStates[i + 1].Time then
                        v10 = i;
                        break;
                    end;

                    local _ = i;
                end;

                p3._lastTransIdx = v10;
                local v11 = TransStates[v10];
                local v12 = TransStates[v10 + 1] or TransStates[#TransStates];
                local v13 = v12.Time - v11.Time;
                local v14 = v13 > 0 and ((math_min_ret2 - v11.Time) / v13 or 0) or 0;
                local v15 = p3.TransMergedTimes[v10];

                if v15 then
                    p3.VisualPart.Transparency = Graph.LerpGraphFast(v11.Graph, v12.Graph, v14, v15);
                else
                    p3.VisualPart.Transparency = Graph.LerpGraph(v11.Graph, v12.Graph, v14);
                end;
            elseif TransStates and #TransStates == 1 then
                p3.VisualPart.Transparency = TransStates[1].Graph;
            end;
        end;

        if not p3.SkipColor then
            if ColorStates and #ColorStates >= 2 then
                local v16 = p3._lastColorIdx or 1;
                local v17 = #ColorStates - 1;

                for i = math_min_ret2 < ColorStates[v16].Time and 1 or v16, #ColorStates - 1 do
                    if ColorStates[i].Time <= math_min_ret2 and math_min_ret2 <= ColorStates[i + 1].Time then
                        v17 = i;
                        break;
                    end;

                    local _ = i;
                end;

                p3._lastColorIdx = v17;
                local v18 = ColorStates[v17];
                local v19 = ColorStates[v17 + 1] or ColorStates[#ColorStates];
                local v20 = v19.Time - v18.Time;
                local v21 = v20 > 0 and ((math_min_ret2 - v18.Time) / v20 or 0) or 0;
                local v22 = p3.ColorMergedTimes[v17];

                if v22 then
                    p3.VisualPart.Color = Graph.LerpColorGraphFast(v18.Graph, v19.Graph, v21, v22);
                else
                    p3.VisualPart.Color = Graph.LerpColorGraph(v18.Graph, v19.Graph, v21);
                end;
            elseif ColorStates and #ColorStates == 1 then
                p3.VisualPart.Color = ColorStates[1].Graph;
            end;
        end;

        local TextureSpeed = p3.AnimatedProps.TextureSpeed;

        if TextureSpeed then
            local v23 = Graph.IntegrateUpTo(math_min_ret2, TextureSpeed.Sequence, TextureSpeed.Seed);
            p3.VisualPart:SetTextureOffset(-v23 * p3.LifeTime % 1);
        end;

        for i, v in pairs(p3.AnimatedProps) do
            if i ~= "TextureSpeed" then
                local v24 = Graph.QueryPointsWithTime(math_min_ret2, v.Sequence, v.Seed);

                if i == "Segments" then
                    local math_round_ret = math.round(v24);
                    v24 = math.max(20, math_round_ret);
                end;

                p3.VisualPart[i] = v24;
            end;
        end;

        if p3.ParentScale then
            local ParentScale = p3.ParentScale;
            local ParentScaleFactor = PartConstants.getParentScaleFactor(ParentScale, p5, Graph);
            local VisualPart = p3.VisualPart;
            local AnimatedProps = p3.AnimatedProps;
            VisualPart.Width0 = (AnimatedProps.Width0 and VisualPart.Width0 or p3._baseWidth0) * ParentScaleFactor;
            VisualPart.Width1 = (AnimatedProps.Width1 and VisualPart.Width1 or p3._baseWidth1) * ParentScaleFactor;
            VisualPart.CurveSize0 = (AnimatedProps.CurveSize0 and VisualPart.CurveSize0 or p3._baseCurveSize0) * ParentScaleFactor;
            VisualPart.CurveSize1 = (AnimatedProps.CurveSize1 and VisualPart.CurveSize1 or p3._baseCurveSize1) * ParentScaleFactor;

            if ParentScale.ScaleTextureLength ~= false then
                VisualPart.TextureLength = (AnimatedProps.TextureLength and VisualPart.TextureLength or p3._baseTextureLength) * ParentScaleFactor;
            end;

            local math_round_ret = math.round((AnimatedProps.Segments and VisualPart.Segments or p3._baseSegments) * ParentScaleFactor);
            VisualPart.Segments = math.max(20, math_round_ret);
        end;

        return math_min_ret >= 1 and (LifeTime <= v8 or v8 <= 0);
    end;
end;