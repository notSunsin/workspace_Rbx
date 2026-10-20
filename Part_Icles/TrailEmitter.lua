-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local TrailGraphBlender = require(script.Parent.TrailGraphBlender);
local Pool = require(script.Parent.Pool);
local Flipbook = require(script.Parent.Flipbook);

return function(u1) -- Line: 21
    -- upvalues: Graph (copy), TrailGraphBlender (copy), Pool (copy), Range (copy), Flipbook (copy)
    local u2 = { "Brightness", "LightEmission", "LightInfluence", "TextureLength", "MinLength", "MaxLength" };

    local function _writeBlenderState(p3, p4, p5, p6, p7, p8, p9) -- Line: 26
        -- upvalues: Graph (ref)
        if not p5 or #p5 == 0 then
            return;
        end;

        if #p5 == 1 then
            p3[p4] = p5[1].Graph;

            return;
        end;

        local v10 = p8[p7] or 1;
        local v11 = #p5 - 1;

        for i = p9 < p5[v10].Time and 1 or v10, #p5 - 1 do
            if p5[i].Time <= p9 and p9 <= p5[i + 1].Time then
                v11 = i;
                break;
            end;

            local _ = i;
        end;

        p8[p7] = v11;
        local v12 = p5[v11];
        local v13 = p5[v11 + 1] or p5[#p5];
        local v14 = v13.Time - v12.Time;
        local v15 = v14 > 0 and ((p9 - v12.Time) / v14 or 0) or 0;

        if p6 then
            p6 = p6[v11];
        end;

        if p6 then
            if p4 == "Color" then
                p3[p4] = Graph.LerpColorGraphFast(v12.Graph, v13.Graph, v15, p6);

                return;
            end;

            p3[p4] = Graph.LerpGraphFast(v12.Graph, v13.Graph, v15, p6);
        end;
    end;

    function u1.UpdateTrail(p16, p17, p18, p19) -- Line: 57
        -- upvalues: Graph (ref), _writeBlenderState (copy), u2 (copy)
        local math_max_ret = math.max((p19 - p17.StartTime) / p17.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v20;

        if p17._tsOverride == nil or p19 >= (p17._tsOverrideUntil or 0) then
            v20 = p17.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p17.Graphs.Timescale, p17.Seeds.Timescale) or 1) or 1;
        else
            v20 = p17._tsOverride;
        end;

        local LifeTime = p17.LifeTime;
        local v21 = (p17._effectiveElapsed or 0) + (p17._timeFrozen and 0 or p18 * v20);
        local v22 = v21 < 0 and 0 or v21;

        if LifeTime < v22 then
            v22 = LifeTime;
        end;

        p17._effectiveElapsed = v22;

        if not (p17.VisualPart and p17.VisualPart.Parent) then
            return true;
        end;

        local math_max_ret2 = math.max(v22 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);

        if not p17.SkipColor then
            _writeBlenderState(p17.VisualPart, "WidthScale", p17.WidthStates, p17.WidthMergedTimes, "_lastWidthIdx", p17, math_min_ret2);
            _writeBlenderState(p17.VisualPart, "Color", p17.ColorStates, p17.ColorMergedTimes, "_lastColorIdx", p17, math_min_ret2);
        end;

        if not p17.SkipTransparency then
            _writeBlenderState(p17.VisualPart, "Transparency", p17.TransStates, p17.TransMergedTimes, "_lastTransIdx", p17, math_min_ret2);
        end;

        if p17.TotalKeyFrames > 0 then
            local math_floor_ret = math.floor(math_min_ret2 * p17.TotalKeyFrames);

            if math_floor_ret ~= p17.CurrentStep then
                p17.CurrentStep = math_floor_ret;
                local v23 = p17.CurrentStep / p17.TotalKeyFrames;

                for _, v in ipairs(u2) do
                    local v24 = p17.Graphs[v];

                    if v24 then
                        p17.VisualPart[v] = Graph.QueryPointsWithTime(v23, v24, p17.Seeds[v]);
                    end;
                end;
            end;
        end;

        return math_min_ret >= 1 and (LifeTime <= v22 or v22 <= 0);
    end;

    local function _collectStatesAndMergedTimes(p25) -- Line: 111
        -- upvalues: TrailGraphBlender (ref)
        local v26, v27, v28 = TrailGraphBlender.CollectStates(p25);
        local v29 = {};
        local v30 = {};
        local v31 = {};

        for i = 1, #v26 - 1 do
            v29[i] = TrailGraphBlender.PrecomputeMergedTimes(v26[i].Graph, v26[i + 1].Graph);
            local _ = i;
        end;

        for i = 1, #v27 - 1 do
            v30[i] = TrailGraphBlender.PrecomputeMergedTimes(v27[i].Graph, v27[i + 1].Graph);
            local _ = i;
        end;

        for i = 1, #v28 - 1 do
            v31[i] = TrailGraphBlender.PrecomputeMergedColorTimes(v28[i].Graph, v28[i + 1].Graph);
            local _ = i;
        end;

        return v26, v27, v28, v29, v30, v31;
    end;

    local function _buildScalarGraphs(p32) -- Line: 120
        -- upvalues: Graph (ref), u2 (copy)
        local v33 = {
            Timescale = p32.TEmitTimescale
        };
        local v34 = {
            Timescale = Graph.GenerateSeed(p32.TEmitTimescale)
        };

        for _, v in ipairs(u2) do
            local v35 = p32["TEmit" .. v] or p32[v];

            if v35 then
                v33[v] = v35;
                v34[v] = Graph.GenerateSeed(v35);
            end;
        end;

        return v33, v34;
    end;

    function u1.EmitTrail(p36, p37, p38, p39) -- Line: 135
        -- upvalues: Pool (ref), Range (ref), _collectStatesAndMergedTimes (copy), _buildScalarGraphs (copy), u2 (copy), Graph (ref), u1 (copy), Flipbook (ref)
        if not (p37 and p37.Parent) then
            return;
        end;

        local Data = p36:GetData(p37);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v40 = Pool.acquireOrClone(Data.RenderTemplate, "TrailEmitter", Data.Pool);
        v40.Archivable = false;
        v40.Enabled = true;

        if p39 and p39._parentCloneMap then
            local _parentCloneMap = p39._parentCloneMap;

            if v40.Attachment0 and _parentCloneMap[v40.Attachment0] then
                v40.Attachment0 = _parentCloneMap[v40.Attachment0];
            end;

            if v40.Attachment1 and _parentCloneMap[v40.Attachment1] then
                v40.Attachment1 = _parentCloneMap[v40.Attachment1];
            end;
        end;

        local v41 = Range.RandomValueFromRange(Data.Lifetime);
        local v42 = v41 <= 0 and 0.001 or v41;
        local v43 = Range.RandomValueFromRange(Data.TrailLife or Data.Lifetime);
        v40.Lifetime = v43 <= 0 and 0.001 or v43;
        local v44, v45, v46, v47, v48, v49 = _collectStatesAndMergedTimes(Data.GraphBlender);

        if #v44 > 0 then
            v40.WidthScale = v44[1].Graph;
        end;

        if #v45 > 0 then
            v40.Transparency = v45[1].Graph;
        end;

        if #v46 > 0 then
            v40.Color = v46[1].Graph;
        end;

        local v50, v51 = _buildScalarGraphs(Data);

        for _, v in ipairs(u2) do
            if v50[v] then
                v40[v] = Graph.QueryPointsWithTime(0, v50[v], v51[v]);
            end;
        end;

        v40.Parent = Data.EmitParent or p36:GetFolder();
        local v52 = {
            Type = "TrailEmitter",
            CurrentStep = 0,
            VisualPart = v40,
            Link = p38,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v42,
            PartLife = Data.PartLife or 0,
            WidthStates = v44,
            TransStates = v45,
            ColorStates = v46,
            WidthMergedTimes = v47,
            TransMergedTimes = v48,
            ColorMergedTimes = v49,
            Graphs = v50,
            Seeds = v51,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.TEmitTimescale, v51.Timescale, v42),
            _sourceItem = p37
        };
        u1._seedTsOverride(v52, p37);

        if Data.Pool ~= false then
            v52._sourceRT = Data.RenderTemplate;
            v52._poolKind = "TrailEmitter";
        end;

        p36:_registerEmit(v52, p39);

        if Data.TrailFlipbookMode and Data.TrailFlipbooks then
            local SortedBeamTextures = Flipbook.GetSortedBeamTextures(Data.TrailFlipbooks);

            if #SortedBeamTextures > 0 then
                Flipbook.FlipBeam(v52, {
                    FlipbookMode = Data.TrailFlipbookMode,
                    FlipbookFramerate = Data.TrailFlipbookFramerate,
                    FlipbookStartRandom = Data.TrailFlipbookStartRandom,
                    FlipbookReverse = Data.TrailFlipbookReverse
                }, SortedBeamTextures, v40, v42);
            end;
        end;
    end;

    function u1.EmitTrailAnimate(p53, p54, p55, p56) -- Line: 218
        -- upvalues: Range (ref), _collectStatesAndMergedTimes (copy), _buildScalarGraphs (copy), u2 (copy), Graph (ref), u1 (copy), Flipbook (ref)
        if not (p54 and p54.Parent) then
            return;
        end;

        if p53.ActiveAnimates[p54] then
            return;
        end;

        local Data = p53:GetData(p54);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local RenderTemplate = Data.RenderTemplate;
        local v57 = {
            Lifetime = RenderTemplate.Lifetime,
            Brightness = RenderTemplate.Brightness,
            LightEmission = RenderTemplate.LightEmission,
            LightInfluence = RenderTemplate.LightInfluence,
            TextureLength = RenderTemplate.TextureLength,
            MinLength = RenderTemplate.MinLength,
            MaxLength = RenderTemplate.MaxLength,
            Texture = RenderTemplate.Texture,
            TextureMode = RenderTemplate.TextureMode,
            FaceCamera = RenderTemplate.FaceCamera,
            WidthScale = RenderTemplate.WidthScale,
            Transparency = RenderTemplate.Transparency,
            Color = RenderTemplate.Color,
            Enabled = RenderTemplate.Enabled
        };
        RenderTemplate.Enabled = true;
        local v58 = Range.RandomValueFromRange(Data.Lifetime);
        local v59 = v58 <= 0 and 0.001 or v58;
        local v60 = Range.RandomValueFromRange(Data.TrailLife or Data.Lifetime);
        RenderTemplate.Lifetime = v60 <= 0 and 0.001 or v60;
        local v61, v62, v63, v64, v65, v66 = _collectStatesAndMergedTimes(Data.GraphBlender);

        if #v61 > 0 then
            RenderTemplate.WidthScale = v61[1].Graph;
        end;

        if #v62 > 0 then
            RenderTemplate.Transparency = v62[1].Graph;
        end;

        if #v63 > 0 then
            RenderTemplate.Color = v63[1].Graph;
        end;

        local v67, v68 = _buildScalarGraphs(Data);

        for _, v in ipairs(u2) do
            if v67[v] then
                RenderTemplate[v] = Graph.QueryPointsWithTime(0, v67[v], v68[v]);
            end;
        end;

        local v69 = {
            Type = "TrailEmitter",
            CurrentStep = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Link = p55,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v59,
            PartLife = Data.PartLife or 0,
            AnimateItem = p54,
            TrailEmitterSnapshot = v57,
            WidthStates = v61,
            TransStates = v62,
            ColorStates = v63,
            WidthMergedTimes = v64,
            TransMergedTimes = v65,
            ColorMergedTimes = v66,
            Graphs = v67,
            Seeds = v68,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.TEmitTimescale, v68.Timescale, v59),
            _sourceItem = p54
        };
        u1._seedTsOverride(v69, p54);
        p53.ActiveAnimates[p54] = v69;
        p53:_registerEmit(v69, p56);

        if Data.TrailFlipbookMode and Data.TrailFlipbooks then
            local SortedBeamTextures = Flipbook.GetSortedBeamTextures(Data.TrailFlipbooks);

            if #SortedBeamTextures > 0 then
                Flipbook.FlipBeam(v69, {
                    FlipbookMode = Data.TrailFlipbookMode,
                    FlipbookFramerate = Data.TrailFlipbookFramerate,
                    FlipbookStartRandom = Data.TrailFlipbookStartRandom,
                    FlipbookReverse = Data.TrailFlipbookReverse
                }, SortedBeamTextures, RenderTemplate, v59);
            end;
        end;
    end;
end;