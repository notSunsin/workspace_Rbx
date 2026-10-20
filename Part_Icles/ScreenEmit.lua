-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);

return function(u1) -- Line: 8
    -- upvalues: Lighting (copy), Graph (copy), Range (copy)
    local function resolveScreenParent(p2, p3) -- Line: 11
        -- upvalues: Lighting (ref)
        if p2.EmitParent then
            return p2.EmitParent;
        end;

        return Lighting;
    end;

    local function buildGraphs(p4, p5) -- Line: 17
        return p4 == "Blur" and {
            BlurSize = p5.BlurSize,
            Timescale = p5.Timescale
        } or (p4 == "Bloom" and {
            BloomIntensity = p5.BloomIntensity,
            BloomSize = p5.BloomSize,
            BloomThreshold = p5.BloomThreshold,
            Timescale = p5.Timescale
        } or (p4 == "CC" and {
            CCBrightness = p5.CCBrightness,
            CCContrast = p5.CCContrast,
            CCSaturation = p5.CCSaturation,
            CCTintColor = p5.CCTintColor,
            Timescale = p5.Timescale
        } or (p4 == "Atmosphere" and {
            AtmDensity = p5.AtmDensity,
            AtmOffset = p5.AtmOffset,
            AtmGlare = p5.AtmGlare,
            AtmHaze = p5.AtmHaze,
            AtmColor = p5.AtmColor,
            AtmDecay = p5.AtmDecay,
            Timescale = p5.AtmTimescale
        } or {})));
    end;

    local function buildSeeds(p6) -- Line: 31
        -- upvalues: Graph (ref)
        local v7 = {};

        for i, v in pairs(p6) do
            if typeof(v) == "NumberSequence" then
                v7[i] = Graph.GenerateSeed(v);
            end;
        end;

        return v7;
    end;

    local function writeSample(p8, p9, p10, p11, p12, p13, p14) -- Line: 42
        -- upvalues: Graph (ref)
        if p8 == "Blur" and p10.BlurSize then
            p9.Size = Graph.QueryPointsWithTime(p12, p10.BlurSize, p11.BlurSize);

            return;
        end;

        if p8 == "Bloom" then
            if p10.BloomIntensity then
                p9.Intensity = Graph.QueryPointsWithTime(p12, p10.BloomIntensity, p11.BloomIntensity);
            end;

            if p10.BloomSize then
                p9.Size = Graph.QueryPointsWithTime(p12, p10.BloomSize, p11.BloomSize);
            end;

            if p10.BloomThreshold then
                p9.Threshold = Graph.QueryPointsWithTime(p12, p10.BloomThreshold, p11.BloomThreshold);
            end;
        elseif p8 == "CC" then
            if p10.CCBrightness and not p14 then
                p9.Brightness = Graph.QueryPointsWithTime(p12, p10.CCBrightness, p11.CCBrightness);
            end;

            if p10.CCContrast then
                p9.Contrast = Graph.QueryPointsWithTime(p12, p10.CCContrast, p11.CCContrast);
            end;

            if p10.CCSaturation then
                p9.Saturation = Graph.QueryPointsWithTime(p12, p10.CCSaturation, p11.CCSaturation);
            end;

            if p10.CCTintColor and not p13 then
                p9.TintColor = Graph.QueryColorPointWithTime(p12, p10.CCTintColor);
            end;
        elseif p8 == "Atmosphere" then
            if p10.AtmDensity then
                p9.Density = Graph.QueryPointsWithTime(p12, p10.AtmDensity, p11.AtmDensity);
            end;

            if p10.AtmOffset then
                p9.Offset = Graph.QueryPointsWithTime(p12, p10.AtmOffset, p11.AtmOffset);
            end;

            if p10.AtmGlare then
                p9.Glare = Graph.QueryPointsWithTime(p12, p10.AtmGlare, p11.AtmGlare);
            end;

            if p10.AtmHaze then
                p9.Haze = Graph.QueryPointsWithTime(p12, p10.AtmHaze, p11.AtmHaze);
            end;

            if p10.AtmColor and not p13 then
                p9.Color = Graph.QueryColorPointWithTime(p12, p10.AtmColor);
            end;

            if p10.AtmDecay and not p13 then
                p9.Decay = Graph.QueryColorPointWithTime(p12, p10.AtmDecay);
            end;
        end;
    end;

    local function kindHasEnabled(p15) -- Line: 65
        return p15 ~= "Atmosphere";
    end;

    local function emitClone(p16, p17, p18, p19, p20) -- Line: 70
        -- upvalues: Range (ref), buildGraphs (copy), buildSeeds (copy), writeSample (copy), Lighting (ref), Graph (ref), u1 (copy)
        local Data = p16:GetData(p18);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v21 = Data.RenderTemplate:Clone();
        v21.Archivable = false;

        if p17 ~= "Atmosphere" then
            v21.Enabled = true;
        end;

        v21:SetAttribute("_PartIcleEmit", true);
        local v22 = Range.RandomValueFromRange(Data.Lifetime);
        local v23 = v22 <= 0 and 0.001 or v22;
        local v24 = buildGraphs(p17, Data);
        local v25 = buildSeeds(v24);
        writeSample(p17, v21, v24, v25, 0);
        local v26;

        if Data.EmitParent then
            v26 = Data.EmitParent;
        else
            v26 = Lighting;
        end;

        v21.Parent = v26;
        local v27 = {
            Type = "Screen",
            CurrentStep = 0,
            Kind = p17,
            VisualPart = v21,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames or 100),
            LifeTime = v23,
            PartLife = Data.PartLife or 0,
            Graphs = v24,
            Seeds = v25,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(v24.Timescale, v25.Timescale, v23),
            _sourceItem = p18
        };
        u1._seedTsOverride(v27, p18);
        p16:_registerEmit(v27, p20);
    end;

    local function emitAnimateInternal(p28, p29, p30, p31, p32) -- Line: 104
        -- upvalues: Range (ref), buildGraphs (copy), buildSeeds (copy), writeSample (copy), Lighting (ref), Graph (ref), u1 (copy)
        if p28.ActiveAnimates[p30] then
            return;
        end;

        local Data = p28:GetData(p30);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v33 = Data.RenderTemplate:Clone();
        v33.Archivable = false;

        if p29 ~= "Atmosphere" then
            v33.Enabled = true;
        end;

        v33:SetAttribute("_PartIcleEmit", true);
        local v34 = Range.RandomValueFromRange(Data.Lifetime);
        local v35 = v34 <= 0 and 0.001 or v34;
        local v36 = buildGraphs(p29, Data);
        local v37 = buildSeeds(v36);
        writeSample(p29, v33, v36, v37, 0);
        local v38;

        if Data.EmitParent then
            v38 = Data.EmitParent;
        else
            v38 = Lighting;
        end;

        v33.Parent = v38;
        local v39 = {
            Type = "Screen",
            CurrentStep = 0,
            IsAnimate = true,
            Kind = p29,
            VisualPart = v33,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames or 100),
            LifeTime = v35,
            PartLife = Data.PartLife or 0,
            Graphs = v36,
            Seeds = v37,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(v36.Timescale, v37.Timescale, v35),
            AnimateItem = p30,
            _sourceItem = p30
        };
        u1._seedTsOverride(v39, p30);
        p28.ActiveAnimates[p30] = v39;
        p28:_registerEmit(v39, p32);
    end;

    function u1.EmitBlur(p40, p41, p42, p43) -- Line: 143
        -- upvalues: emitClone (copy)
        emitClone(p40, "Blur", p41, p42, p43);
    end;

    function u1.EmitBloom(p44, p45, p46, p47) -- Line: 144
        -- upvalues: emitClone (copy)
        emitClone(p44, "Bloom", p45, p46, p47);
    end;

    function u1.EmitColorCorrection(p48, p49, p50, p51) -- Line: 145
        -- upvalues: emitClone (copy)
        emitClone(p48, "CC", p49, p50, p51);
    end;

    function u1.EmitAtmosphere(p52, p53, p54, p55) -- Line: 146
        -- upvalues: emitClone (copy)
        emitClone(p52, "Atmosphere", p53, p54, p55);
    end;

    function u1.EmitBlurAnimate(p56, p57, p58, p59) -- Line: 148
        -- upvalues: emitAnimateInternal (copy)
        emitAnimateInternal(p56, "Blur", p57, p58, p59);
    end;

    function u1.EmitBloomAnimate(p60, p61, p62, p63) -- Line: 149
        -- upvalues: emitAnimateInternal (copy)
        emitAnimateInternal(p60, "Bloom", p61, p62, p63);
    end;

    function u1.EmitColorCorrectionAnimate(p64, p65, p66, p67) -- Line: 150
        -- upvalues: emitAnimateInternal (copy)
        emitAnimateInternal(p64, "CC", p65, p66, p67);
    end;

    function u1.EmitAtmosphereAnimate(p68, p69, p70, p71) -- Line: 151
        -- upvalues: emitAnimateInternal (copy)
        emitAnimateInternal(p68, "Atmosphere", p69, p70, p71);
    end;

    function u1.UpdateScreen(p72, p73, p74, p75) -- Line: 154
        -- upvalues: Graph (ref), writeSample (copy)
        if not (p73.VisualPart and p73.VisualPart.Parent) then
            return true;
        end;

        if p73.TotalKeyFrames <= 0 then
            return true;
        end;

        local math_max_ret = math.max((p75 - p73.StartTime) / p73.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v76;

        if p73._tsOverride == nil or p75 >= (p73._tsOverrideUntil or 0) then
            v76 = p73.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p73.Graphs.Timescale, p73.Seeds.Timescale) or 1) or 1;
        else
            v76 = p73._tsOverride;
        end;

        local LifeTime = p73.LifeTime;
        local v77 = (p73._effectiveElapsed or 0) + (p73._timeFrozen and 0 or p74 * v76);
        local v78 = v77 < 0 and 0 or v77;

        if LifeTime < v78 then
            v78 = LifeTime;
        end;

        p73._effectiveElapsed = v78;
        local v79 = v78 / LifeTime;
        local v80 = v79 > 1 and 1 or v79;
        local math_floor_ret = math.floor((v80 < 0 and 0 or v80) * p73.TotalKeyFrames);

        if math_floor_ret ~= p73.CurrentStep then
            p73.CurrentStep = math_floor_ret;
            writeSample(p73.Kind, p73.VisualPart, p73.Graphs, p73.Seeds, p73.CurrentStep / p73.TotalKeyFrames, p73.SkipColor, p73.SkipTransparency);
        end;

        return math_min_ret >= 1 and (LifeTime <= v78 or v78 <= 0);
    end;
end;