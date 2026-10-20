-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local AxisLinks = require(script.Parent.AxisLinks);
local Particles = require(script.Parent.Particles);
require(script.Parent.TypeRegistry);
local Events = require(script.Parent.Events);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local StaticPass = require(script.Parent.StaticPass);
local Turbulence = require(script.Parent.Turbulence);
local DirectionVectors = PartConstants.DirectionVectors;

return function(u1) -- Line: 19
    -- upvalues: Range (copy), DirectionVectors (copy), AxisLinks (copy), PartConstants (copy), Graph (copy), Pool (copy), Turbulence (copy), Particles (copy), StaticPass (copy), NestedEmit (copy), Events (copy)
    function u1.EmitModel(u2, p3, p4, p5) -- Line: 22
        -- upvalues: Range (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Pool (ref), Turbulence (ref), Particles (ref), u1 (copy), StaticPass (ref), NestedEmit (ref)
        if not (p3 and p3.Parent) then
            return;
        end;

        local Data = u2:GetData(p3);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v6;

        if p5 and p5.IgnoreLink then
            v6 = nil;
        else
            v6 = p4 or Data.Link;
        end;

        local v7 = Range.RandomValueFromRange(Data.Lifetime);
        local v8 = v7 <= 0 and 0.001 or v7;
        local Pivot = p3:GetPivot();
        local v9 = nil;

        if p5 then
            if p5.EventOriginResolver then
                v9 = p5.EventOriginResolver();
            end;

            v9 = v9 or p5.EventOriginCF;
        end;

        if v9 then
            if not (p5 and p5.UseFullOrigin) then
                v9 = CFrame.new(v9.Position) * Pivot.Rotation;
            end;
        else
            v9 = Pivot;
        end;

        local v10 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v11 = v9[v10.vector] * v10.multiplier;
        local v12 = Data.DirMode or "RigidLocal";
        local v13 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p5);
        local v14 = PartConstants.composeRotation(Data.RotOrder or "Global", v13.RotX, v13.RotY, v13.RotZ);
        local v15 = PartConstants.applyPositionOffset(v9 * v14, Data, v6, p3, Range, AxisLinks, p5);

        if v12 == "Global" then
            v15 = CFrame.new(v15.Position) * v14;
        end;

        if v12 == "Local" then
            v11 = v15[v10.vector] * v10.multiplier;
        elseif v12 == "Global" then
            v11 = CFrame.new()[v10.vector] * v10.multiplier;
        end;

        local v16, v17;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v16 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v17 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v16 = 0;
            v17 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v16), math.rad(v17), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v11) * CFrame_Angles_ret).LookVector;
        local v18 = {
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Scale = Graph.GenerateSeed(Data.Scale),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v18, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v19, v20;

        if InvertMotion then
            v19, v20 = u2:PreSimulateForward(Data, v18, v15, LookVector, CFrame_Angles_ret, v6, v8, nil, v15.Rotation * v14:Inverse());
        else
            v19 = nil;
            v20 = nil;
        end;

        local u21 = Pool.acquireOrCopyBare(Data.RenderTemplate, "Model", Data.Pool);
        u21.Archivable = false;
        local RenderTemplate = Data.RenderTemplate;

        if RenderTemplate and u21:GetAttribute("_pooledModelScale") == nil then
            local success, result = pcall(function() -- Line: 118
                -- upvalues: RenderTemplate (copy)
                return RenderTemplate:GetScale();
            end);

            if success and result then
                u21:SetAttribute("_pooledModelScale", result);
            end;
        end;

        local Attribute = u21:GetAttribute("_pooledModelScale");

        if Attribute then
            pcall(function() -- Line: 122
                -- upvalues: u21 (copy), Attribute (copy)
                u21:ScaleTo(Attribute);
            end);
        end;

        local v22;

        if v6 then
            v22 = PartConstants.resolveLinkCFrame(v6);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v22 = CFrame.new(v22.Position) or v22;
            end;
        else
            v22 = CFrame.new();
        end;

        if InvertMotion and v19 then
            v15 = v19[v20 or Data.TotalKeyFrames] or v19[0];
            u21:PivotTo(v22 * v15);
        else
            if v6 then
                v15 = v22:ToObjectSpace(v15) or v15;
            end;

            u21:PivotTo(v22 * v15);
        end;

        local v23 = {
            Type = "Model",
            VisualPart = u21,
            Link = v6,
            LinkMode = Data.LinkMode
        };

        if Data.LinkMode ~= "RigidLocal" or not (v6 and v22) then
            v22 = nil;
        end;

        v23._rigidLocalParentCF = v22;
        v23.Events = Data.Events;
        v23.StartTime = os.clock();
        v23.TotalKeyFrames = InvertMotion and v20 and v20 or math.max(1, Data.TotalKeyFrames);
        v23.CurrentStep = 0;
        v23.AccumulatedDT = 0;
        v23.LifeTime = v8;
        v23.PartLife = Data.PartLife;
        v23.CurrentPosition = u21:GetPivot().Position;
        v23.LocalCF = v15;
        v23.BaseDirection = LookVector;
        v23._accelVel = Vector3.new(0, 0, 0);
        v23.SpeedMultiplier = 1;
        v23._spinRate = Vector3.new(0, 0, 0);
        v23._spinAccumX = 0;
        v23._spinAccumY = 0;
        v23._spinAccumZ = 0;
        v23.EmissionDirection = Data.EmissionDirection;
        v23.SpreadRotation = CFrame_Angles_ret;
        v23.Acceleration = Data.ParticleData.Acceleration;
        v23.Drag = Data.ParticleData.Drag;
        v23.VelocityVectored = Data.VelocityVectored;
        v23.InvertMotion = InvertMotion;
        v23.SimLocalCFrames = v19;
        v23.RotMode = Data.RotMode or "OverLife";
        v23.RotOrder = Data.RotOrder or "Global";
        v23.AccRotX = 0;
        v23.AccRotY = 0;
        v23.AccRotZ = 0;
        v23.Orientation = Data.Orientation;
        v23.ZOffset = Data.ZOffset;
        v23._localWorldCF = v15;
        v23.SpawnRotation = v15.Rotation;
        v23.SpawnEmitterRotation = v15.Rotation * v14:Inverse();
        v23.DisplacementMode = Data.DisplacementMode;
        v23._sleepRadius = 1;
        v23._prevWorldOff = Vector3.new(0, 0, 0);
        v23.HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil;
        v23.NeedsFullIteration = Data.VelocityVectored;
        local v24;

        if Data.RotMode == "Speed" then
            v24 = not Data.VelocityVectored;
        else
            v24 = false;
        end;

        v23.NeedsRotAccum = v24;
        v23.HasDrag = Data.ParticleData.Drag ~= 0;
        v23.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v23.Graphs = {
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Speed = Data.Speed,
            Scale = Data.Scale,
            Timescale = Data.Timescale
        };
        v23.Seeds = v18;
        v23._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v18.Timescale, v8);

        if v23.HasPosOffsetGraphs then
            local v25 = v23.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v23.Graphs.PosOffsetX, v23.Seeds.PosOffsetX) or 0) or 0;
            local v26 = v23.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v23.Graphs.PosOffsetY, v23.Seeds.PosOffsetY) or 0) or 0;
            local v27 = v23.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v23.Graphs.PosOffsetZ, v23.Seeds.PosOffsetZ) or 0) or 0;
            local v28 = PartConstants.resolveDisplacement(Vector3.new(v25, v26, v27), Data.DisplacementMode or "Global", v23.SpawnRotation, v23.SpawnEmitterRotation);
            v23._prevWorldOff = v28;

            if v25 ~= 0 or (v26 ~= 0 or v27 ~= 0) then
                v23.LocalCF = v23.LocalCF + v28;
                v23.VisualPart:PivotTo(v23.VisualPart:GetPivot() + v28);
            end;
        end;

        Turbulence.buildInto(v23, Data);
        local v29 = {};

        for _, descendant in u21:GetDescendants() do
            if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                table.insert(v29, descendant);
            end;
        end;

        if #v29 > 0 then
            v23._visualBeams = v29;
        end;

        if u2._parentScaleMap and u2._parentScaleMap[p3] then
            v23.ParentScale = u2._parentScaleMap[p3];
        end;

        u21:ScaleTo(math.max(0.001, Graph.QueryPointsWithTime(0, v23.Graphs.Scale, v23.Seeds.Scale)) * PartConstants.getParentScaleFactor(v23.ParentScale, v23.StartTime, Graph));

        for _, v in ipairs(v29) do
            if v.Segments < 20 then
                v.Segments = 20;
            end;
        end;

        u21.Parent = Data.EmitParent or u2:GetFolder();
        Pool.restoreTrails(u21, "Model");

        for _, descendant in u21:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local v30 = u2:_makeAliveCheck();

        for _, descendant in u21:GetDescendants() do
            Particles.EnableEmitSingle(descendant, v30);
        end;

        v23._sourceItem = p3;
        u1._seedTsOverride(v23, p3);

        if Data.Pool ~= false then
            v23._sourceRT = Data.RenderTemplate;
            v23._poolKind = "Model";
        end;

        StaticPass.apply(v23);
        u2:_applyEmitVisualPasses(v23);
        u2:_registerEmit(v23, p5);
        v23._nestedAlive = { true };
        u2._parentScaleMap = u2._parentScaleMap or {};
        local u31 = {
            Graph = v23.Graphs.Scale,
            Seed = v23.Seeds.Scale,
            StaticValue = v23._staticScale or (v23.Graphs.Scale == nil and 1 or nil),
            TotalKeyFrames = v23.TotalKeyFrames,
            StartTime = v23.StartTime,
            LifeTime = v23.LifeTime,
            ScaleTextureLength = Data.ScaleTextureLength ~= false,
            ScaleMotion = Data.ScaleMotion ~= false,
            ScaleRotation = Data.ScaleRotation == true,
            Parent = v23.ParentScale
        };
        local u32 = {};
        NestedEmit.walk(u2, Data.RenderTemplate, u21, v23._nestedAlive, p5, function(p33) -- Line: 278
            -- upvalues: u2 (copy), u31 (copy), u32 (copy)
            u2._parentScaleMap[p33] = u31;
            u32[#u32 + 1] = p33;
        end);
        v23._scaleMapKeys = u32;
    end;

    function u1.EmitModelAnimate(p34, u35, p36, p37) -- Line: 286
        -- upvalues: Range (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Turbulence (ref), Particles (ref), u1 (copy), StaticPass (ref), Events (ref)
        if not (u35 and u35.Parent) then
            return;
        end;

        local Data = p34:GetData(u35);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v38 = p36 or Data.Link;
        local v39 = Range.RandomValueFromRange(Data.Lifetime);
        local v40 = v39 <= 0 and 0.001 or v39;
        local RenderTemplate = Data.RenderTemplate;
        local Pivot = RenderTemplate:GetPivot();
        local Pivot2 = u35:GetPivot();
        local v41 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v42 = Pivot2[v41.vector] * v41.multiplier;
        local v43 = Data.DirMode or "RigidLocal";
        local v44 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p37);
        local v45 = PartConstants.composeRotation(Data.RotOrder or "Global", v44.RotX, v44.RotY, v44.RotZ);
        local v46 = PartConstants.applyPositionOffset(Pivot2 * v45, Data, v38, u35, Range, AxisLinks, p37);

        if v43 == "Global" then
            v46 = CFrame.new(v46.Position) * v45;
        end;

        if v43 == "Local" then
            v42 = v46[v41.vector] * v41.multiplier;
        elseif v43 == "Global" then
            v42 = CFrame.new()[v41.vector] * v41.multiplier;
        end;

        local v47, v48;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v47 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v48 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v47 = 0;
            v48 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v47), math.rad(v48), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v42) * CFrame_Angles_ret).LookVector;
        local v49 = {
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Scale = Graph.GenerateSeed(Data.Scale),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v49, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v50, v51;

        if InvertMotion then
            v50, v51 = p34:PreSimulateForward(Data, v49, v46, LookVector, CFrame_Angles_ret, v38, v40, nil, v46.Rotation * v45:Inverse());
        else
            v50 = nil;
            v51 = nil;
        end;

        local v52;

        if v38 then
            v52 = PartConstants.resolveLinkCFrame(v38);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v52 = CFrame.new(v52.Position) or v52;
            end;
        else
            v52 = CFrame.new();
        end;

        if InvertMotion and v50 then
            v46 = v50[v51 or Data.TotalKeyFrames] or v50[0];
        elseif v38 then
            v46 = v52:ToObjectSpace(v46) or v46;
        end;

        RenderTemplate:PivotTo(v52 * v46);
        local v53 = {
            Type = "Model",
            VisualPart = RenderTemplate,
            Link = v38,
            LinkMode = Data.LinkMode
        };

        if Data.LinkMode ~= "RigidLocal" or not (v38 and v52) then
            v52 = nil;
        end;

        v53._rigidLocalParentCF = v52;
        v53.Events = Data.Events;
        v53.StartTime = os.clock();
        v53.TotalKeyFrames = InvertMotion and v51 and v51 or math.max(1, Data.TotalKeyFrames);
        v53.CurrentStep = 0;
        v53.AccumulatedDT = 0;
        v53.LifeTime = v40;
        v53.PartLife = Data.PartLife or 0;
        v53.CurrentPosition = RenderTemplate:GetPivot().Position;
        v53.LocalCF = v46;
        v53.BaseDirection = LookVector;
        v53._accelVel = Vector3.new(0, 0, 0);
        v53.SpeedMultiplier = 1;
        v53._spinRate = Vector3.new(0, 0, 0);
        v53._spinAccumX = 0;
        v53._spinAccumY = 0;
        v53._spinAccumZ = 0;
        v53.EmissionDirection = Data.EmissionDirection;
        v53.SpreadRotation = CFrame_Angles_ret;
        v53.Acceleration = Data.ParticleData.Acceleration;
        v53.Drag = Data.ParticleData.Drag;
        v53.VelocityVectored = Data.VelocityVectored;
        v53.InvertMotion = InvertMotion;
        v53.SimLocalCFrames = v50;
        v53.RotMode = Data.RotMode or "OverLife";
        v53.RotOrder = Data.RotOrder or "Global";
        v53.AccRotX = 0;
        v53.AccRotY = 0;
        v53.AccRotZ = 0;
        v53.Orientation = Data.Orientation;
        v53.ZOffset = Data.ZOffset;
        v53._localWorldCF = v46;
        v53.SpawnRotation = v46.Rotation;
        v53.SpawnEmitterRotation = v46.Rotation * v45:Inverse();
        v53.DisplacementMode = Data.DisplacementMode;
        v53._sleepRadius = 1;
        v53._prevWorldOff = Vector3.new(0, 0, 0);
        v53.HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil;
        v53.NeedsFullIteration = Data.VelocityVectored;
        local v54;

        if Data.RotMode == "Speed" then
            v54 = not Data.VelocityVectored;
        else
            v54 = false;
        end;

        v53.NeedsRotAccum = v54;
        v53.HasDrag = Data.ParticleData.Drag ~= 0;
        v53.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v53.Graphs = {
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Speed = Data.Speed,
            Scale = Data.Scale,
            Timescale = Data.Timescale
        };
        v53.Seeds = v49;
        v53._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v49.Timescale, v40);
        v53.IsAnimate = true;
        v53.AnimateItem = u35;
        v53.InitialAnchorCF = Pivot;
        v53.InitialLocalCF = v46;
        local success, result = pcall(function() -- Line: 432
            -- upvalues: u35 (copy)
            return u35:GetScale();
        end);
        v53.InitialScale = success and result and result or 1;

        if v53.HasPosOffsetGraphs then
            local v55 = v53.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v53.Graphs.PosOffsetX, v53.Seeds.PosOffsetX) or 0) or 0;
            local v56 = v53.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v53.Graphs.PosOffsetY, v53.Seeds.PosOffsetY) or 0) or 0;
            local v57 = v53.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v53.Graphs.PosOffsetZ, v53.Seeds.PosOffsetZ) or 0) or 0;
            local v58 = PartConstants.resolveDisplacement(Vector3.new(v55, v56, v57), Data.DisplacementMode or "Global", v53.SpawnRotation, v53.SpawnEmitterRotation);
            v53._prevWorldOff = v58;

            if v55 ~= 0 or (v56 ~= 0 or v57 ~= 0) then
                v53.LocalCF = v53.LocalCF + v58;
                v53.VisualPart:PivotTo(v53.VisualPart:GetPivot() + v58);
            end;
        end;

        Turbulence.buildInto(v53, Data);
        local v59 = {};

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                table.insert(v59, descendant);
            end;
        end;

        if #v59 > 0 then
            v53._visualBeams = v59;
        end;

        if p34._parentScaleMap and p34._parentScaleMap[u35] then
            v53.ParentScale = p34._parentScaleMap[u35];
        end;

        RenderTemplate:ScaleTo(math.max(0.001, Graph.QueryPointsWithTime(0, v53.Graphs.Scale, v53.Seeds.Scale)) * PartConstants.getParentScaleFactor(v53.ParentScale, v53.StartTime, Graph));

        for _, v in ipairs(v59) do
            if v.Segments < 20 then
                v.Segments = 20;
            end;
        end;

        local v60 = p34:_makeAliveCheck();

        for _, descendant in RenderTemplate:GetDescendants() do
            Particles.EnableEmitSingle(descendant, v60);
        end;

        v53._sourceItem = u35;
        u1._seedTsOverride(v53, u35);
        StaticPass.apply(v53);
        p34.ActiveAnimates[u35] = v53;
        p34:_applyEmitVisualPasses(v53);
        p34:_registerEmit(v53, p37);
        p34._parentScaleMap = p34._parentScaleMap or {};
        local v61 = {
            Graph = v53.Graphs.Scale,
            Seed = v53.Seeds.Scale,
            StaticValue = v53._staticScale or (v53.Graphs.Scale == nil and 1 or nil),
            TotalKeyFrames = v53.TotalKeyFrames,
            StartTime = v53.StartTime,
            LifeTime = v53.LifeTime,
            ScaleTextureLength = Data.ScaleTextureLength ~= false,
            ScaleMotion = Data.ScaleMotion ~= false,
            ScaleRotation = Data.ScaleRotation == true,
            Parent = v53.ParentScale
        };
        local v62 = {};

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:GetAttribute("Transformed") then
                p34._parentScaleMap[descendant] = v61;
                v62[#v62 + 1] = descendant;
                p34:EnableEmit(descendant, descendant.Parent, Events.descendCtx(p37));
            end;
        end;

        v53._scaleMapKeys = v62;
    end;
end;