-- Decompiled with Potassium's decompiler.

local ContentProvider = game:GetService("ContentProvider");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local ScreenHost = require(script.Parent.ScreenHost);
local Pool = require(script.Parent.Pool);
local StaticPass = require(script.Parent.StaticPass);

return function(u1) -- Line: 12
    -- upvalues: ScreenHost (copy), ContentProvider (copy), Graph (copy), Range (copy), StaticPass (copy), Pool (copy)
    local u2 = {};

    local function resolveImageParent(p3, p4) -- Line: 18
        -- upvalues: ScreenHost (ref)
        if p3.EmitParent then
            return p3.EmitParent;
        end;

        if p4 then
            local Parent = p4.Parent;

            while Parent and Parent ~= game do
                if Parent:GetAttribute("_PartIcleEmit") then
                    return p4.Parent;
                end;

                Parent = Parent.Parent;
            end;
        end;

        return ScreenHost.get();
    end;

    local function gatherFlipbookDecals(p5) -- Line: 31
        if not p5 then
            return nil;
        end;

        local v6 = {};

        for _, child in ipairs(p5:GetChildren()) do
            if child:IsA("Decal") then
                table.insert(v6, child);
            end;
        end;

        table.sort(v6, function(p7, p8) -- Line: 37
            local v9 = tonumber(p7.Name);
            local v10 = tonumber(p8.Name);

            if v9 and v10 then
                return v9 < v10;
            end;

            return p7.Name < p8.Name;
        end);

        return #v6 > 0 and v6 and v6 or nil;
    end;

    local function preloadEmitAssets(p11, p12) -- Line: 46
        -- upvalues: ContentProvider (ref)
        local u13 = {};

        if p12 then
            for _, v in ipairs(p12) do
                table.insert(u13, v);
            end;
        end;

        if p11.Image and p11.Image ~= "" then
            table.insert(u13, p11.Image);
        end;

        if #u13 == 0 then
            return;
        end;

        task.spawn(function() -- Line: 51
            -- upvalues: ContentProvider (ref), u13 (copy)
            pcall(ContentProvider.PreloadAsync, ContentProvider, u13);
        end);
    end;

    local function preloadAndWait(p14, p15, p16, p17) -- Line: 56
        -- upvalues: ContentProvider (ref)
        if not (p14 and p15) then
            return;
        end;

        local _preloadedAssets = p14._preloadedAssets;

        if not _preloadedAssets then
            return;
        end;

        if _preloadedAssets[p15] then
            return;
        end;

        local v18 = {};

        if p17 then
            for _, v in ipairs(p17) do
                table.insert(v18, v);
            end;
        end;

        if p16.Image and p16.Image ~= "" then
            table.insert(v18, p16.Image);
        end;

        _preloadedAssets[p15] = true;

        if #v18 == 0 then
            return;
        end;

        pcall(ContentProvider.PreloadAsync, ContentProvider, v18);
    end;

    local function resolveFrame(p19, p20, p21) -- Line: 71
        if p20 <= 0 then
            return 0;
        end;

        local FlipbookMode = p19.FlipbookMode;
        local v22;

        if FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
            local v23 = p19.LifeTime > 0 and (math.min(1, p21 / p19.LifeTime) or 1) or 1;
            local math_floor_ret = math.floor(v23 * p20);
            v22 = math.min(math_floor_ret, p20 - 1);
        elseif FlipbookMode == Enum.ParticleFlipbookMode.PingPong then
            local v24 = (p19.LifeTime > 0 and (math.min(1, p21 / p19.LifeTime) or 1) or 1) * 2;
            local v25;

            if v24 <= 1 then
                v25 = math.floor(v24 * p20);
            else
                v25 = math.floor((2 - v24) * p20);
            end;

            local math_min_ret = math.min(v25, p20 - 1);
            v22 = math.max(0, math_min_ret);
        elseif FlipbookMode == Enum.ParticleFlipbookMode.Random then
            local v26 = p19.FlipbookFramerate or 24;
            local math_floor_ret = math.floor(p21 / (v26 > 0 and 1 / v26 or 1));

            if p19._lastRandomInterval ~= math_floor_ret then
                p19._lastRandomInterval = math_floor_ret;
                p19._currentRandomFrame = math.random(0, p20 - 1);
            end;

            v22 = p19._currentRandomFrame or math.random(0, p20 - 1);
        else
            v22 = math.floor(p21 * p19.FlipbookFramerate + (p19.FlipbookStartOffset or 0) * p20) % p20;
        end;

        if p19.FlipbookReverse then
            v22 = p20 - 1 - v22;
        end;

        return v22;
    end;

    local function applyFlipbookFrame(p27, p28) -- Line: 102
        -- upvalues: resolveFrame (copy)
        if not p27.FlipbookFramerate or p27.FlipbookFramerate <= 0 then
            return;
        end;

        if p27.FlipbookSource == "Decals" and p27.FlipbookDecals then
            local v29 = #p27.FlipbookDecals;

            if v29 == 0 then
                return;
            end;

            local v30 = resolveFrame(p27, v29, p28);

            if v30 == p27._lastFlipbookFrame then
                return;
            end;

            p27._lastFlipbookFrame = v30;
            local v31 = p27.FlipbookDecals[v30 + 1];

            if v31 and v31.Texture then
                p27.VisualPart.Image = v31.Texture;
            end;
        elseif p27.FlipbookSource == "Spritesheet" then
            local math_max_ret = math.max(1, p27.GridCols or 1);
            local math_max_ret2 = math.max(1, p27.GridRows or 1);
            local v32 = resolveFrame(p27, math_max_ret * math_max_ret2, p28);
            local SheetSize = p27.SheetSize;

            if not SheetSize then
                return;
            end;

            if v32 == p27._lastFlipbookFrame then
                return;
            end;

            p27._lastFlipbookFrame = v32;
            local v33 = SheetSize.X / math_max_ret;
            local v34 = SheetSize.Y / math_max_ret2;
            p27.VisualPart.ImageRectSize = Vector2.new(v33, v34);
            p27.VisualPart.ImageRectOffset = Vector2.new(v32 % math_max_ret * v33, math.floor(v32 / math_max_ret) * v34);
        end;
    end;

    local function _simulateForward2D(p35, p36, p37, p38, p39) -- Line: 133
        -- upvalues: Graph (ref)
        local v40 = p38 / 60;
        local X = (p35.ImgAcceleration or Vector2.new()).X;
        local Y = (p35.ImgAcceleration or Vector2.new()).Y;
        local v41 = p35.ImgDrag or 0;
        local v42 = 0;
        local v43 = 0;
        local v44 = 0;
        local v45 = 0;

        for i = 1, 60 do
            local v46 = not p35.ImgSpeed and 0 or Graph.QueryPointsWithTime(i / 60, p35.ImgSpeed, p39.ImgSpeed) * 100;
            v43 = v43 + X * 100 * v40;
            v42 = v42 + Y * 100 * v40;

            if v41 > 0 then
                local math_max_ret = math.max(0, 1 - v41 * v40);
                v43 = v43 * math_max_ret;
                v42 = v42 * math_max_ret;
            end;

            v45 = v45 + (v46 * p36 + v43) * v40;
            v44 = v44 + (v46 * p37 + v42) * v40;
            local _ = i;
        end;

        return v45, v44, v43, v42;
    end;

    function u1._computeImageLabelEndState(p47, p48, p49, p50, p51, p52) -- Line: 160
        -- upvalues: _simulateForward2D (copy)
        return _simulateForward2D(p48, p49, p50, p51, p52);
    end;

    local function buildImageLabelPData(p53, p54, p55, p56) -- Line: 165
        -- upvalues: gatherFlipbookDecals (copy), Range (ref), Graph (ref), u2 (copy), _simulateForward2D (copy), StaticPass (ref)
        local v57 = gatherFlipbookDecals(p53.ImageFlipbooks);
        local v58 = p53.ImgSpreadAngle or 0;
        local v59 = (p53.ImgEmissionAngle or 90) + (math.random() * 2 - 1) * v58;
        local math_rad_ret = math.rad(v59);
        local math_cos_ret = math.cos(math_rad_ret);
        local v60 = -math.sin(math_rad_ret);
        local v61 = Range.RandomValueFromRange(p53.Lifetime);
        local v62 = v61 <= 0 and 0.001 or v61;
        local v63 = {
            ImageTransparency = p53.ImageTransparency and (Graph.GenerateSeed(p53.ImageTransparency) or {}) or {},
            BackgroundTransparency = p53.BackgroundTransparency and (Graph.GenerateSeed(p53.BackgroundTransparency) or {}) or {},
            ImgSpeed = p53.ImgSpeed and (Graph.GenerateSeed(p53.ImgSpeed) or {}) or {},
            ImgRotSpeed = p53.ImgRotSpeed and (Graph.GenerateSeed(p53.ImgRotSpeed) or {}) or {},
            SizeScaleX = p53.SizeScaleX and (Graph.GenerateSeed(p53.SizeScaleX) or {}) or {},
            SizeScaleY = p53.SizeScaleY and (Graph.GenerateSeed(p53.SizeScaleY) or {}) or {},
            Timescale = p53.ImgTimescale and (Graph.GenerateSeed(p53.ImgTimescale) or {}) or {}
        };
        local v64 = Range.RandomValueFromRange(p53.ImgRotRange or NumberRange.new(0));
        local v65 = p53.ImgSizeUDim or UDim2.fromOffset(100, 100);

        if p53.ImageTransparency then
            p54.ImageTransparency = Graph.QueryPointsWithTime(0, p53.ImageTransparency, v63.ImageTransparency);
        end;

        if p53.BackgroundTransparency then
            p54.BackgroundTransparency = Graph.QueryPointsWithTime(0, p53.BackgroundTransparency, v63.BackgroundTransparency);
        end;

        if p53.ImageColor3 then
            p54.ImageColor3 = Graph.QueryColorPointWithTime(0, p53.ImageColor3);
        end;

        if p53.BackgroundColor3 then
            p54.BackgroundColor3 = Graph.QueryColorPointWithTime(0, p53.BackgroundColor3);
        end;

        p54.Image = p53.Image or "";
        p54.ScaleType = p53.ImgScaleType or Enum.ScaleType.Stretch;
        p54.ResampleMode = p53.ImgResampleMode or Enum.ResamplerMode.Default;
        p54.AnchorPoint = p53.ImgAnchorPoint or Vector2.new(0.5, 0.5);
        p54.ZIndex = p53.ImgZIndex or 1;
        p54.Rotation = v64;
        local v66 = p53.SizeScaleX and (Graph.QueryPointsWithTime(0, p53.SizeScaleX, v63.SizeScaleX) or 1) or 1;
        local v67 = p53.SizeScaleY and (Graph.QueryPointsWithTime(0, p53.SizeScaleY, v63.SizeScaleY) or 1) or 1;
        p54.Size = UDim2.new(v65.X.Scale * v66, v65.X.Offset * v66, v65.Y.Scale * v67, v65.Y.Offset * v67);
        p54.Position = p53.ImgPosition or UDim2.fromScale(0.5, 0.5);
        local v68 = not p53.ImgFlipbookFramerate and 10 or Range.RandomValueFromRange(p53.ImgFlipbookFramerate);
        local v69 = p53.ImgFlipbookStartRandom and (p53.ImgFlipbookMode or Enum.ParticleFlipbookMode.Loop) == Enum.ParticleFlipbookMode.Loop;
        local v70 = 0;
        local v71 = 0;
        local SheetSize = p53.SheetSize;
        local v72 = p53.ImgFlipbookSource or "Decals";

        if v72 == "Spritesheet" and (not SheetSize and (p53.Image and (p53.Image ~= "" and not u2[p53.Image]))) then
            u2[p53.Image] = true;
            warn(string.format("Part-Icles: Spritesheet flipbook  -  sheet dimensions unknown for %s. Emit will render full sheet until dimensions resolve.", p53.Image));
        end;

        if v72 == "Decals" then
            p54.ImageRectSize = Vector2.new(0, 0);
            p54.ImageRectOffset = Vector2.new(0, 0);

            if v57 and #v57 > 0 then
                local v73 = #v57;

                if v69 then
                    v70 = math.random(0, v73 - 1);
                    v71 = v70 / v73;
                end;

                local v74 = v57[v70 + 1];

                if v74 and (v74.Texture and v74.Texture ~= "") then
                    p54.Image = v74.Texture;
                end;
            end;
        elseif v72 == "Spritesheet" and SheetSize then
            local math_max_ret = math.max(1, p53.ImgGridCols or 1);
            local math_max_ret2 = math.max(1, p53.ImgGridRows or 1);
            local v75 = math_max_ret * math_max_ret2;

            if v69 and v75 > 0 then
                v70 = math.random(0, v75 - 1);
                v71 = v70 / v75;
            end;

            local v76 = SheetSize.X / math_max_ret;
            local v77 = SheetSize.Y / math_max_ret2;
            p54.ImageRectSize = Vector2.new(v76, v77);
            p54.ImageRectOffset = Vector2.new(v70 % math_max_ret * v76, math.floor(v70 / math_max_ret) * v77);
        end;

        local v78 = {
            Type = "ImageLabel",
            VisualPart = p54,
            StartTime = os.clock(),
            LifeTime = v62,
            TotalKeyFrames = math.max(1, p53.TotalKeyFrames or 100),
            CurrentStep = 0,
            PartLife = p53.PartLife or 0,
            BasePosition = p53.ImgPosition or UDim2.fromScale(0.5, 0.5),
            BaseSize = v65,
            DirX = math_cos_ret,
            DirY = v60,
            EnvVelX = 0,
            EnvVelY = 0,
            PosX = 0,
            PosY = 0,
            AccelX = (p53.ImgAcceleration or Vector2.new()).X,
            AccelY = (p53.ImgAcceleration or Vector2.new()).Y,
            Drag = p53.ImgDrag or 0,
            InitialRotation = v64,
            RotMode = p53.ImgRotMode or "OverLife",
            AccRot = 0,
            InvertMotion = p53.ImgInvertMotion or false,
            Graphs = {
                ImageTransparency = p53.ImageTransparency,
                BackgroundTransparency = p53.BackgroundTransparency,
                ImgSpeed = p53.ImgSpeed,
                ImgRotSpeed = p53.ImgRotSpeed,
                SizeScaleX = p53.SizeScaleX,
                SizeScaleY = p53.SizeScaleY,
                ImageColor3 = p53.ImageColor3,
                BackgroundColor3 = p53.BackgroundColor3,
                Timescale = p53.ImgTimescale
            },
            Seeds = v63,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(p53.ImgTimescale, v63.Timescale, v62),
            FlipbookSource = p53.ImgFlipbookSource or "Decals",
            FlipbookMode = p53.ImgFlipbookMode or Enum.ParticleFlipbookMode.Loop,
            FlipbookFramerate = v68,
            FlipbookStartOffset = v71,
            FlipbookReverse = p53.ImgFlipbookReverse or false,
            FlipbookDecals = v57,
            SheetSize = SheetSize,
            GridCols = p53.ImgGridCols or 8,
            GridRows = p53.ImgGridRows or 1,
            IsAnimate = p56 or nil,
            AnimateItem = p56 and p55 and p55 or nil
        };

        if p53.ImgInvertMotion then
            local v79, v80, v81, v82 = _simulateForward2D(p53, math_cos_ret, v60, v62, v63);
            v78.PosX = v79;
            v78.PosY = v80;
            v78.EnvVelX = v81;
            v78.EnvVelY = v82;
            v78._effectiveElapsed = v62;
            v78._invertDtSign = -1;
        end;

        StaticPass.apply(v78);

        if v78._staticSizeScaleX and v78._staticSizeScaleY then
            v78._staticSizeScaleX = nil;
            v78._staticSizeScaleY = nil;
        end;

        return v78;
    end;

    function u1.EmitImageLabel(p83, p84, p85, p86) -- Line: 342
        -- upvalues: preloadAndWait (copy), Pool (ref), buildImageLabelPData (copy), u1 (copy), preloadEmitAssets (copy), resolveImageParent (copy)
        local Data = p83:GetData(p84);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        preloadAndWait(p83, Data.RenderTemplate, Data, nil);
        local v87 = Pool.acquireOrClone(Data.RenderTemplate, "ImageLabel", Data.Pool);
        v87.Archivable = false;
        v87.Visible = true;
        local ImageFlipbooks = v87:FindFirstChild("ImageFlipbooks");

        if ImageFlipbooks then
            ImageFlipbooks:Destroy();
        end;

        local v88 = buildImageLabelPData(Data, v87, p84, false);
        v88.Link = p85;
        v88._sourceItem = p84;
        u1._seedTsOverride(v88, p84);
        v88.Events = Data.Events;

        if Data.Pool ~= false then
            v88._sourceRT = Data.RenderTemplate;
            v88._poolKind = "ImageLabel";
        end;

        preloadEmitAssets(Data, v88.FlipbookDecals);
        v87.Parent = resolveImageParent(Data, p84);
        p83:_registerEmit(v88, p86);

        for _, descendant in v87:GetDescendants() do
            if descendant:GetAttribute("Transformed") and descendant:IsA("ImageLabel") then
                p83:EnableEmit(descendant, nil, p86);
            end;
        end;
    end;

    function u1.EmitImageLabelAnimate(p89, p90, p91, p92) -- Line: 376
        -- upvalues: preloadAndWait (copy), buildImageLabelPData (copy), u1 (copy), preloadEmitAssets (copy), resolveImageParent (copy)
        if p89.ActiveAnimates[p90] then
            return;
        end;

        local Data = p89:GetData(p90);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        preloadAndWait(p89, Data.RenderTemplate, Data, nil);
        local v93 = Data.RenderTemplate:Clone();
        v93.Archivable = false;
        v93.Visible = true;
        v93:SetAttribute("_PartIcleEmit", true);
        local ImageFlipbooks = v93:FindFirstChild("ImageFlipbooks");

        if ImageFlipbooks then
            ImageFlipbooks:Destroy();
        end;

        local v94 = buildImageLabelPData(Data, v93, p90, true);
        v94.Link = p91;
        v94._sourceItem = p90;
        u1._seedTsOverride(v94, p90);
        v94.Events = Data.Events;
        preloadEmitAssets(Data, v94.FlipbookDecals);
        v93.Parent = resolveImageParent(Data, p90);
        p89.ActiveAnimates[p90] = v94;
        p89:_registerEmit(v94, p92);

        for _, descendant in v93:GetDescendants() do
            if descendant:GetAttribute("Transformed") and descendant:IsA("ImageLabel") then
                p89:EnableEmit(descendant, nil, p92);
            end;
        end;
    end;

    function u1.UpdateImageLabel(p95, p96, p97, p98) -- Line: 408
        -- upvalues: Graph (ref), applyFlipbookFrame (copy)
        local VisualPart = p96.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p96.TotalKeyFrames <= 0 then
            return true;
        end;

        local math_max_ret = math.max((p98 - p96.StartTime) / p96.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v99;

        if p96._tsOverride == nil or p98 >= (p96._tsOverrideUntil or 0) then
            v99 = p96.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p96.Graphs.Timescale, p96.Seeds.Timescale) or 1) or 1;
        else
            v99 = p96._tsOverride;
        end;

        local v100 = p97 * v99;

        if p96._invertDtSign then
            v100 = v100 * p96._invertDtSign;
        end;

        local LifeTime = p96.LifeTime;
        local v101 = p96._effectiveElapsed or 0;
        local v102 = v101 + (p96._timeFrozen and 0 or v100);
        local v103 = v102 < 0 and 0 or v102;

        if LifeTime < v103 then
            v103 = LifeTime;
        end;

        p96._effectiveElapsed = v103;
        local v104 = v103 / LifeTime;
        local v105 = v104 > 1 and 1 or v104;
        local Graphs = p96.Graphs;
        local Seeds = p96.Seeds;
        p96.AccumulatedDT = (p96.AccumulatedDT or 0) + (v103 - v101);
        local math_floor_ret = math.floor((v105 < 0 and 0 or v105) * p96.TotalKeyFrames);

        if math_floor_ret ~= p96.CurrentStep then
            local AccumulatedDT = p96.AccumulatedDT;
            p96.AccumulatedDT = 0;
            p96.CurrentStep = math_floor_ret;
            local v106 = math_floor_ret / p96.TotalKeyFrames;
            local v107 = 0;

            if p96._staticImgSpeed then
                v107 = p96._staticImgSpeed * 100;
            elseif Graphs.ImgSpeed then
                v107 = Graph.QueryPointsWithTime(v106, Graphs.ImgSpeed, Seeds.ImgSpeed) * 100;
            end;

            if v107 ~= 0 and p96.Drag > 0 then
                v107 = v107 * math.exp(-p96.Drag * v103);
            end;

            p96.EnvVelX = p96.EnvVelX + p96.AccelX * 100 * AccumulatedDT;
            p96.EnvVelY = p96.EnvVelY + p96.AccelY * 100 * AccumulatedDT;

            if p96.Drag > 0 then
                local math_max_ret2 = math.max(0, 1 - p96.Drag * AccumulatedDT);
                p96.EnvVelX = p96.EnvVelX * math_max_ret2;
                p96.EnvVelY = p96.EnvVelY * math_max_ret2;
            end;

            local v108 = v107 * p96.DirY + p96.EnvVelY;
            p96.PosX = p96.PosX + (v107 * p96.DirX + p96.EnvVelX) * AccumulatedDT;
            p96.PosY = p96.PosY + v108 * AccumulatedDT;
            local BasePosition = p96.BasePosition;
            VisualPart.Position = UDim2.new(BasePosition.X.Scale, BasePosition.X.Offset + p96.PosX, BasePosition.Y.Scale, BasePosition.Y.Offset + p96.PosY);
            local v109 = nil;

            if p96._staticImgRotSpeed then
                v109 = p96._staticImgRotSpeed;
            elseif Graphs.ImgRotSpeed then
                v109 = Graph.QueryPointsWithTime(v106, Graphs.ImgRotSpeed, Seeds.ImgRotSpeed);
            end;

            if v109 then
                local v110;

                if p96.RotMode == "Speed" then
                    p96.AccRot = p96.AccRot + v109 * AccumulatedDT;
                    v110 = p96.InitialRotation + p96.AccRot;
                else
                    v110 = p96.InitialRotation + v109;
                end;

                if v110 ~= p96._lastRotation then
                    VisualPart.Rotation = v110;
                    p96._lastRotation = v110;
                end;
            end;

            if (p96._staticSizeScaleX or Graphs.SizeScaleX or (p96._staticSizeScaleY or Graphs.SizeScaleY)) and not p96.SkipSize then
                local v111 = p96._staticSizeScaleX or (Graphs.SizeScaleX and (Graph.QueryPointsWithTime(v106, Graphs.SizeScaleX, Seeds.SizeScaleX) or 1) or 1);
                local v112 = p96._staticSizeScaleY or (Graphs.SizeScaleY and (Graph.QueryPointsWithTime(v106, Graphs.SizeScaleY, Seeds.SizeScaleY) or 1) or 1);

                if v111 ~= p96._lastSizeX or v112 ~= p96._lastSizeY then
                    local BaseSize = p96.BaseSize;
                    VisualPart.Size = UDim2.new(BaseSize.X.Scale * v111, BaseSize.X.Offset * v111, BaseSize.Y.Scale * v112, BaseSize.Y.Offset * v112);
                    p96._lastSizeX = v111;
                    p96._lastSizeY = v112;
                end;
            end;

            if Graphs.ImageTransparency and not p96.SkipTransparency then
                VisualPart.ImageTransparency = Graph.QueryPointsWithTime(v106, Graphs.ImageTransparency, Seeds.ImageTransparency);
            end;

            if Graphs.BackgroundTransparency and not p96.SkipTransparency then
                VisualPart.BackgroundTransparency = Graph.QueryPointsWithTime(v106, Graphs.BackgroundTransparency, Seeds.BackgroundTransparency);
            end;

            if Graphs.ImageColor3 and not p96.SkipColor then
                VisualPart.ImageColor3 = Graph.QueryColorPointWithTime(v106, Graphs.ImageColor3);
            end;

            if Graphs.BackgroundColor3 and not p96.SkipColor then
                VisualPart.BackgroundColor3 = Graph.QueryColorPointWithTime(v106, Graphs.BackgroundColor3);
            end;
        end;

        applyFlipbookFrame(p96, v103);

        return math_min_ret >= 1 and (LifeTime <= v103 or v103 <= 0);
    end;

    function u1._refreshImageLabelAnimateNonSpatial(p113, p114, p115) -- Line: 539
        -- upvalues: Range (ref), gatherFlipbookDecals (copy), Graph (ref)
        if not p115 then
            return;
        end;

        local v116 = p115.ImgSpreadAngle or 0;
        local v117 = (p115.ImgEmissionAngle or 90) + (math.random() * 2 - 1) * v116;
        local math_rad_ret = math.rad(v117);
        local math_cos_ret = math.cos(math_rad_ret);
        local v118 = -math.sin(math_rad_ret);
        p114.DirX = math_cos_ret;
        p114.DirY = v118;

        if p115.ImgAcceleration then
            p114.AccelX = p115.ImgAcceleration.X;
            p114.AccelY = p115.ImgAcceleration.Y;
        end;

        if p115.ImgDrag ~= nil then
            p114.Drag = p115.ImgDrag;
        end;

        if p115.ImgPosition then
            p114.BasePosition = p115.ImgPosition;
        end;

        if p115.ImgSizeUDim then
            p114.BaseSize = p115.ImgSizeUDim;
        end;

        if p115.ImgRotMode then
            p114.RotMode = p115.ImgRotMode;
        end;

        if p115.ImgRotRange then
            p114.InitialRotation = Range.RandomValueFromRange(p115.ImgRotRange);
        end;

        if p115.ImgFlipbookSource then
            p114.FlipbookSource = p115.ImgFlipbookSource;
        end;

        if p115.ImgFlipbookMode then
            p114.FlipbookMode = p115.ImgFlipbookMode;
        end;

        if p115.ImgFlipbookFramerate then
            p114.FlipbookFramerate = Range.RandomValueFromRange(p115.ImgFlipbookFramerate);
        end;

        if p115.ImgFlipbookReverse ~= nil then
            p114.FlipbookReverse = p115.ImgFlipbookReverse;
        end;

        if p115.ImgGridCols then
            p114.GridCols = p115.ImgGridCols;
        end;

        if p115.ImgGridRows then
            p114.GridRows = p115.ImgGridRows;
        end;

        if p115.SheetSize ~= nil then
            p114.SheetSize = p115.SheetSize;
        end;

        if p115.ImageFlipbooks then
            p114.FlipbookDecals = gatherFlipbookDecals(p115.ImageFlipbooks);
        end;

        if p115.ImgTimescale and p114.Graphs then
            p114.Graphs.Timescale = p115.ImgTimescale;
            p114.Seeds.Timescale = Graph.GenerateSeed(p115.ImgTimescale);
        end;
    end;
end;