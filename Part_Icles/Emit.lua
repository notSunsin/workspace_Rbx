-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local AxisLinks = require(script.Parent.AxisLinks);
local Particles = require(script.Parent.Particles);
local Flipbook = require(script.Parent.Flipbook);
require(script.Parent.Events);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local StaticPass = require(script.Parent.StaticPass);
local Turbulence = require(script.Parent.Turbulence);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

local function _findBasePartAncestor(p1) -- Line: 24
    local Parent = p1.Parent;

    while Parent do
        if Parent:IsA("BasePart") then
            return Parent;
        end;

        Parent = Parent.Parent;
    end;

    return nil;
end;

return function(u2) -- Line: 33
    -- upvalues: Range (copy), PartConstants (copy), DirectionVectors (copy), shapeFunctions (copy), AxisLinks (copy), Graph (copy), Pool (copy), Turbulence (copy), Particles (copy), StaticPass (copy), Flipbook (copy), NestedEmit (copy)
    function u2.EmitPart(p3, p4, p5, p6) -- Line: 39
        -- upvalues: Range (ref), PartConstants (ref), DirectionVectors (ref), shapeFunctions (ref), AxisLinks (ref), Graph (ref), Pool (ref), Turbulence (ref), Particles (ref), u2 (copy), StaticPass (ref), Flipbook (ref), NestedEmit (ref)
        if not (p4 and p4.Parent) then
            return;
        end;

        local Data = p3:GetData(p4);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v7;

        if p6 and p6.IgnoreLink then
            v7 = nil;
        else
            v7 = p5 or Data.Link;
        end;

        local v8 = Range.RandomValueFromRange(Data.Lifetime);
        local v9 = v8 <= 0 and 0.001 or v8;
        local v10 = nil;

        if p6 then
            if p6.EventOriginResolver then
                v10 = p6.EventOriginResolver();
            end;

            v10 = v10 or p6.EventOriginCF;
        end;

        if v10 then
            if not (p6 and p6.UseFullOrigin) then
                v10 = CFrame.new(v10.Position) * p4.CFrame.Rotation;
            end;
        elseif v7 then
            local v11 = PartConstants.resolveLinkCFrame(v7);
            local Position = v11.Position;

            if Data.LinkMode == "Follow" then
                v10 = CFrame.new(Position) * p4.CFrame.Rotation;
            elseif v7 == p4 then
                v10 = p4.CFrame;
            else
                v10 = CFrame.new(Position) * v11.Rotation * p4.CFrame.Rotation;
            end;
        else
            v10 = p4.CFrame;
        end;

        local v12 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v13 = v10[v12.vector] * v12.multiplier;
        local Vector3_new_ret = Vector3.new();
        local v14 = nil;
        local v15;

        if Data.UseShape then
            local v16 = shapeFunctions[Data.ParticleData.Shape];

            if v16 then
                local v17;

                if Data.ShapePart then
                    v17 = Data.ShapePart.CFrame or v10;
                else
                    v17 = v10;
                end;

                local v18, v19, v20 = v16(Data.ShapePart or p4, Data.ParticleData);
                local ShapeInOut = Data.ParticleData.ShapeInOut;

                if ShapeInOut == Enum.ParticleEmitterShapeInOut.Inward then
                    v20 = -v20;
                elseif ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and math.random() < 0.5 then
                    v20 = -v20;
                end;

                v14 = (v17 - v17.Position):VectorToWorldSpace(v20);

                if Data.ParticleData.LookAtInitially then
                    local v21, v22, v23 = v10:ToEulerAnglesXYZ();
                    v15 = CFrame.new((v17 * CFrame.new(v18)).Position) * v19 * CFrame.Angles(v21, v22, v23);
                else
                    v15 = CFrame.new((v17 * CFrame.new(v18)).Position) * v10.Rotation;
                end;
            else
                v15 = CFrame.new((v10 * CFrame.new(Vector3_new_ret)).Position) * v10.Rotation;
            end;
        else
            v15 = CFrame.new((v10 * CFrame.new(Vector3_new_ret)).Position) * v10.Rotation;
        end;

        local v24 = Data.DirMode or "RigidLocal";
        local v25 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p6);
        local v26 = PartConstants.composeRotation(Data.RotOrder or "Global", v25.RotX, v25.RotY, v25.RotZ);
        local v27 = 1;
        local v28 = p3._parentScaleMap and p3._parentScaleMap[p4];

        if v28 and v28.ScaleMotion ~= false then
            v27 = PartConstants.getParentScaleFactor(v28, os.clock(), Graph);
        end;

        local v29 = PartConstants.applyPositionOffset(v15 * v26, Data, v7, p4, Range, AxisLinks, p6, nil, v27);

        if v24 == "Global" then
            v29 = CFrame.new(v29.Position) * v26;
        end;

        if v14 then
            v13 = v14;
        elseif v24 == "Local" then
            v13 = v29[v12.vector] * v12.multiplier;
        elseif v24 == "Global" then
            v13 = CFrame.new()[v12.vector] * v12.multiplier;
        end;

        local v30, v31;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v30 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v31 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v30 = 0;
            v31 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v30), math.rad(v31), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v13) * CFrame_Angles_ret).LookVector;
        local v32 = {
            SizeX = Graph.GenerateSeed(Data.SizeX),
            SizeY = Graph.GenerateSeed(Data.SizeY),
            SizeZ = Graph.GenerateSeed(Data.SizeZ),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Brightness = Graph.GenerateSeed(Data.Brightness),
            Transparency = Graph.GenerateSeed(Data.Transparency),
            AccelStrength = Graph.GenerateSeed(Data.AccelStrength),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v32, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v33, v34;

        if InvertMotion then
            v33, v34 = p3:PreSimulateForward(Data, v32, v29, LookVector, CFrame_Angles_ret, v7, v9, nil, v29.Rotation * v26:Inverse());
        else
            v33 = nil;
            v34 = nil;
        end;

        local v35 = Pool.acquireOrCopyBare(Data.RenderTemplate, "Part", Data.Pool);
        v35.Archivable = false;
        local v36;

        if v7 then
            v36 = PartConstants.resolveLinkCFrame(v7);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v36 = CFrame.new(v36.Position) or v36;
            end;
        else
            v36 = CFrame.new();
        end;

        if InvertMotion and v33 then
            v29 = v33[v34 or Data.TotalKeyFrames] or v33[0];
            v35.CFrame = v36 * v29;
        else
            if v7 then
                v29 = v36:ToObjectSpace(v29) or v29;
            end;

            v35.CFrame = v36 * v29;
        end;

        local u37 = {
            Type = "Part",
            VisualPart = v35,
            Link = v7,
            LinkMode = Data.LinkMode
        };

        if Data.LinkMode ~= "RigidLocal" or not (v7 and v36) then
            v36 = nil;
        end;

        u37._rigidLocalParentCF = v36;
        u37.Events = Data.Events;
        u37.SpecialMesh = v35:FindFirstChildOfClass("SpecialMesh");
        u37.Decal = v35:FindFirstChildOfClass("Decal");
        u37.SurfaceAppearance = v35:FindFirstChildOfClass("SurfaceAppearance");
        u37.StartTime = os.clock();
        u37.TotalKeyFrames = InvertMotion and v34 and v34 or math.max(1, Data.TotalKeyFrames);
        u37.CurrentStep = 0;
        u37.AccumulatedDT = 0;
        u37.LifeTime = v9;
        u37.PartLife = Data.PartLife;
        u37.CurrentPosition = v35.Position;
        u37.LocalCF = v29;
        u37.BaseDirection = LookVector;
        u37._accelVel = Vector3.new(0, 0, 0);
        u37.SpeedMultiplier = 1;
        u37._spinRate = Vector3.new(0, 0, 0);
        u37._spinAccumX = 0;
        u37._spinAccumY = 0;
        u37._spinAccumZ = 0;
        u37.EmissionDirection = Data.EmissionDirection;
        u37.SpreadRotation = CFrame_Angles_ret;
        u37.Acceleration = Data.ParticleData.Acceleration;
        u37.Drag = Data.ParticleData.Drag;
        u37.VelocityVectored = Data.VelocityVectored;
        u37.InvertMotion = InvertMotion;
        u37.SimLocalCFrames = v33;
        u37.RotMode = Data.RotMode or "OverLife";
        u37.RotOrder = Data.RotOrder or "Global";
        u37.AccRotX = 0;
        u37.AccRotY = 0;
        u37.AccRotZ = 0;
        u37.Orientation = Data.Orientation;
        u37.ZOffset = Data.ZOffset;
        u37._localWorldCF = v29;
        u37.SpawnRotation = v29.Rotation;
        u37.SpawnEmitterRotation = v29.Rotation * v26:Inverse();
        u37.DisplacementMode = Data.DisplacementMode;
        u37._sleepRadius = v35 and v35:IsA("BasePart") and (v35.Size.Magnitude * 0.5 or 1) or 1;
        u37._prevWorldOff = Vector3.new(0, 0, 0);
        u37.HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil;
        local v38;

        if Data.AccelerationTowardsInstance == true and (Data.AccelTarget ~= nil and Data.AccelStrength ~= nil) then
            v38 = not Data.InvertMotion;
        else
            v38 = false;
        end;

        u37.HasTargetAccel = v38;
        u37.AccelTarget = Data.AccelTarget;
        u37.TargetVel = Vector3.new(0, 0, 0);
        u37.NeedsFullIteration = Data.VelocityVectored;
        local v39;

        if Data.RotMode == "Speed" then
            v39 = not Data.VelocityVectored;
        else
            v39 = false;
        end;

        u37.NeedsRotAccum = v39;
        u37.HasDrag = Data.ParticleData.Drag ~= 0;
        u37.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        u37.HasDecal = v35:FindFirstChildOfClass("Decal") ~= nil;
        u37.Graphs = {
            SizeX = Data.SizeX,
            SizeY = Data.SizeY,
            SizeZ = Data.SizeZ,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Speed = Data.Speed,
            Brightness = Data.Brightness,
            Transparency = Data.Transparency,
            Color = Data.Color,
            AccelStrength = Data.AccelStrength,
            Timescale = Data.Timescale
        };
        u37.Seeds = v32;
        u37._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v32.Timescale, v9);

        if u37.HasPosOffsetGraphs then
            local v40 = u37.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u37.Graphs.PosOffsetX, u37.Seeds.PosOffsetX) or 0) or 0;
            local v41 = u37.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u37.Graphs.PosOffsetY, u37.Seeds.PosOffsetY) or 0) or 0;
            local v42 = u37.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u37.Graphs.PosOffsetZ, u37.Seeds.PosOffsetZ) or 0) or 0;
            local v43 = PartConstants.resolveDisplacement(Vector3.new(v40, v41, v42), Data.DisplacementMode or "Global", u37.SpawnRotation, u37.SpawnEmitterRotation);
            u37._prevWorldOff = v43;

            if v40 ~= 0 or (v41 ~= 0 or v42 ~= 0) then
                u37.LocalCF = u37.LocalCF + v43;
                u37.VisualPart.CFrame = u37.VisualPart.CFrame + v43;
            end;
        end;

        Turbulence.buildInto(u37, Data);
        local v44 = Graph.QueryPointsWithTime(0, u37.Graphs.SizeX, u37.Seeds.SizeX);
        local v45 = Graph.QueryPointsWithTime(0, u37.Graphs.SizeY, u37.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v44, v45, Graph.QueryPointsWithTime(0, u37.Graphs.SizeZ, u37.Seeds.SizeZ));
        local v46 = Graph.QueryPointsWithTime(0, u37.Graphs.Transparency, u37.Seeds.Transparency);
        local u47 = Graph.QueryColorPointWithTime(0, u37.Graphs.Color);
        local u48 = Graph.QueryPointsWithTime(0, u37.Graphs.Brightness, u37.Seeds.Brightness);

        if u37.SpecialMesh then
            u37.SpecialMesh.Scale = Vector3_new_ret2;
        else
            u37.VisualPart.Size = Vector3_new_ret2;
        end;

        if u37.SurfaceAppearance then
            u37.VisualPart.Transparency = v46;
            u37.VisualPart.Color = Color3.fromRGB(u47.R * 255, u47.G * 255, u47.B * 255);
            u37.SurfaceAppearance.Color = Color3.fromRGB(u47.R * 255, u47.G * 255, u47.B * 255);
            pcall(function() -- Line: 328
                -- upvalues: u37 (copy), u47 (copy), u48 (copy)
                u37.SurfaceAppearance.EmissiveTint = Color3.new(u47.R * u48, u47.G * u48, u47.B * u48);
            end);
        elseif u37.Decal then
            u37.Decal.Transparency = v46;
            u37.Decal.Color3 = Color3.fromRGB(u47.R * 255 * u48, u47.G * 255 * u48, u47.B * 255 * u48);
        else
            u37.VisualPart.Transparency = v46;
            u37.VisualPart.Color = Color3.fromRGB(u47.R * 255, u47.G * 255, u47.B * 255);
        end;

        for _, descendant in v35:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        v35.Parent = Data.EmitParent or p3:GetFolder();

        for _, descendant in v35:GetDescendants() do
            if descendant:IsA("Trail") and not descendant:GetAttribute("Transformed") then
                local Parent = descendant.Parent;
                local v49 = descendant;
                local v50 = false;

                while Parent and Parent ~= v35 do
                    if Parent:GetAttribute("Transformed") then
                        v50 = true;
                        break;
                    end;

                    Parent = Parent.Parent;
                end;

                if not v50 and v49:GetAttribute("EmitDuration") ~= nil then
                    if v49.Enabled ~= true then
                        v49.Enabled = true;
                    end;

                    if v49:GetAttribute("_pooledTrailEnabled") ~= nil then
                        v49:SetAttribute("_pooledTrailEnabled", true);
                    end;
                end;
            end;
        end;

        Pool.restoreTrails(v35, "Part");
        local v51 = p3:_makeAliveCheck();

        for _, child in v35:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v51);
            end;

            Particles.EnableEmitSingle(child, v51);
        end;

        if p3._parentScaleMap and p3._parentScaleMap[p4] then
            u37.ParentScale = p3._parentScaleMap[p4];
        end;

        u37._sourceItem = p4;
        u2._seedTsOverride(u37, p4);

        if Data.Pool ~= false then
            u37._sourceRT = Data.RenderTemplate;
            u37._poolKind = "Part";
        end;

        StaticPass.apply(u37);
        p3:_applyEmitVisualPasses(u37);
        p3:_registerEmit(u37, p6);

        if Data.CachedMeshTextures and #Data.CachedMeshTextures > 0 then
            local v52 = u37.SurfaceAppearance or u37.Decal;

            if not v52 then
                if v35:IsA("MeshPart") then
                    v52 = v35;
                end;
            end;

            if v52 then
                Flipbook.Flip(u37, Data.ParticleData, Data.CachedMeshTextures, v52, v9);
            end;
        end;

        u37._nestedAlive = { true };
        NestedEmit.walkWithScale(p3, Data.RenderTemplate, v35, u37._nestedAlive, p6, u37.ParentScale, u37);
    end;

    function u2.EmitAttachment(p53, p54, p55, p56) -- Line: 413
        -- upvalues: Range (ref), PartConstants (ref), DirectionVectors (ref), AxisLinks (ref), Graph (ref), Pool (ref), Turbulence (ref), u2 (copy), StaticPass (ref), Particles (ref), NestedEmit (ref)
        if not (p54 and p54.Parent) then
            return;
        end;

        local Data = p53:GetData(p54);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v57;

        if p56 and p56.IgnoreLink then
            v57 = nil;
        else
            v57 = p55 or Data.Link;
        end;

        local v58 = Range.RandomValueFromRange(Data.Lifetime);
        local v59 = v58 <= 0 and 0.001 or v58;
        local WorldCFrame = p54.WorldCFrame;
        local v60 = nil;

        if p56 then
            if p56.EventOriginResolver then
                v60 = p56.EventOriginResolver();
            end;

            v60 = v60 or p56.EventOriginCF;
        end;

        if v60 then
            if not (p56 and p56.UseFullOrigin) then
                v60 = CFrame.new(v60.Position) * WorldCFrame.Rotation;
            end;
        elseif v57 then
            local v61 = PartConstants.resolveLinkCFrame(v57);

            if Data.LinkMode == "Follow" then
                v60 = CFrame.new(v61.Position) * WorldCFrame.Rotation;
            elseif v57 == p54 then
                v60 = WorldCFrame;
            else
                v60 = CFrame.new(v61.Position) * v61.Rotation * WorldCFrame.Rotation;
            end;
        else
            v60 = WorldCFrame;
        end;

        local EmitParent = Data.EmitParent;

        if not EmitParent then
            EmitParent = p54.Parent;

            while true do
                if not EmitParent then
                    EmitParent = nil;
                    break;
                end;

                if EmitParent:IsA("BasePart") then
                    break;
                end;

                EmitParent = EmitParent.Parent;
            end;

            if not EmitParent then
                EmitParent = p53:GetFolder();
            end;
        end;

        local v62 = EmitParent and EmitParent:IsA("BasePart") and EmitParent.CFrame or CFrame.new();
        local v63 = v62:ToObjectSpace(v60);
        local v64 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v65 = Data.DirMode or "RigidLocal";
        local v66 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p56);
        local v67 = PartConstants.composeRotation(Data.RotOrder or "Global", v66.RotX, v66.RotY, v66.RotZ);
        local v68 = v63 * v67;
        local v69;

        if v65 == "Local" then
            v69 = v68[v64.vector] * v64.multiplier;
        elseif v65 == "Global" then
            v69 = CFrame.new()[v64.vector] * v64.multiplier;

            if EmitParent and EmitParent:IsA("BasePart") then
                v69 = EmitParent.CFrame:VectorToObjectSpace(v69);
            end;
        else
            v69 = v63[v64.vector] * v64.multiplier;
        end;

        local v70 = 1;
        local v71 = p53._parentScaleMap and p53._parentScaleMap[p54];

        if v71 and v71.ScaleMotion ~= false then
            v70 = PartConstants.getParentScaleFactor(v71, os.clock(), Graph);
        end;

        local v72 = PartConstants.applyPositionOffset(v68, Data, v57, p54, Range, AxisLinks, p56, v62, v70);

        if v65 == "Global" then
            if EmitParent and EmitParent:IsA("BasePart") then
                v72 = CFrame.new(v72.Position) * EmitParent.CFrame.Rotation:Inverse() * v67;
            else
                v72 = CFrame.new(v72.Position) * v67;
            end;
        end;

        local v73, v74;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v73 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v74 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v73 = 0;
            v74 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v73), math.rad(v74), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v69) * CFrame_Angles_ret).LookVector;
        local v75 = {
            Speed = Graph.GenerateSeed(Data.Speed),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v75, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v76, v77;

        if InvertMotion then
            v76, v77 = p53:PreSimulateAttachmentForward(Data, v75, v72, LookVector, CFrame_Angles_ret, v59, nil, v72.Rotation * v67:Inverse());
        else
            v76 = nil;
            v77 = nil;
        end;

        local v78 = Pool.acquireOrCopyBare(Data.RenderTemplate, "Attachment", Data.Pool);
        v78.Archivable = false;

        if InvertMotion and v76 then
            v72 = v76[v77 or Data.TotalKeyFrames] or v76[0];
        end;

        v78.CFrame = v72;
        v78.Parent = EmitParent;
        Pool.restoreTrails(v78, "Attachment");

        if v57 then
            local v79 = PartConstants.resolveLinkCFrame(v57);
            local v80 = (EmitParent and (EmitParent:IsA("BasePart") and EmitParent.CFrame) or CFrame.new()):ToObjectSpace(v79);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v80 = CFrame.new(v80.Position);
            end;

            v72 = v80:ToObjectSpace(v72);
        end;

        local v81;

        if Data.LinkMode == "RigidLocal" and v57 then
            v81 = PartConstants.resolveLinkCFrame(v57);
        else
            v81 = nil;
        end;

        local v82 = {
            Type = "Attachment",
            VisualPart = v78,
            Link = v57,
            LinkMode = Data.LinkMode,
            _rigidLocalParentCF = v81,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = InvertMotion and v77 and v77 or math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v59,
            PartLife = Data.PartLife,
            LocalCF = v72,
            _localWorldCF = v72,
            BaseDirection = LookVector,
            _accelVel = Vector3.new(0, 0, 0),
            SpeedMultiplier = 1,
            _spinRate = Vector3.new(0, 0, 0),
            _spinAccumX = 0,
            _spinAccumY = 0,
            _spinAccumZ = 0,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v76,
            RotMode = Data.RotMode or "OverLife",
            RotOrder = Data.RotOrder or "Global",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            Orientation = Data.Orientation,
            ZOffset = Data.ZOffset,
            SpawnRotation = v72.Rotation,
            SpawnEmitterRotation = v72.Rotation * v67:Inverse(),
            DisplacementMode = Data.DisplacementMode,
            _sleepRadius = 1,
            _prevWorldOff = Vector3.new(0, 0, 0),
            HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v83;

        if Data.RotMode == "Speed" then
            v83 = not Data.VelocityVectored;
        else
            v83 = false;
        end;

        v82.NeedsRotAccum = v83;
        v82.HasDrag = Data.ParticleData.Drag ~= 0;
        v82.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v82.Graphs = {
            Speed = Data.Speed,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Timescale = Data.Timescale
        };
        v82.Seeds = v75;
        v82._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v75.Timescale, v59);

        if v82.HasPosOffsetGraphs then
            local v84 = v82.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v82.Graphs.PosOffsetX, v82.Seeds.PosOffsetX) or 0) or 0;
            local v85 = v82.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v82.Graphs.PosOffsetY, v82.Seeds.PosOffsetY) or 0) or 0;
            local v86 = v82.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v82.Graphs.PosOffsetZ, v82.Seeds.PosOffsetZ) or 0) or 0;
            local v87 = PartConstants.resolveDisplacement(Vector3.new(v84, v85, v86), Data.DisplacementMode or "Global", v82.SpawnRotation, v82.SpawnEmitterRotation);
            v82._prevWorldOff = v87;

            if v84 ~= 0 or (v85 ~= 0 or v86 ~= 0) then
                v82.LocalCF = v82.LocalCF + v87;
                v82.VisualPart.CFrame = v82.VisualPart.CFrame + v87;
            end;
        end;

        Turbulence.buildInto(v82, Data);
        v82._sourceItem = p54;
        u2._seedTsOverride(v82, p54);

        if p53._parentScaleMap and p53._parentScaleMap[p54] then
            v82.ParentScale = p53._parentScaleMap[p54];
        end;

        if Data.Pool ~= false then
            v82._sourceRT = Data.RenderTemplate;
            v82._poolKind = "Attachment";
        end;

        StaticPass.apply(v82);
        p53:_applyEmitVisualPasses(v82);
        p53:_registerEmit(v82, p56);

        for _, descendant in v78:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local v88 = p53:_makeAliveCheck();

        for _, child in v78:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v88);
            end;

            Particles.EnableEmitSingle(child, v88);
        end;

        v82._nestedAlive = { true };
        NestedEmit.walkWithScale(p53, Data.RenderTemplate, v78, v82._nestedAlive, p56, v82.ParentScale, v82);
    end;

    function u2.EmitBeam(p89, p90, p91, p92) -- Line: 688
        -- upvalues: Pool (ref), Graph (ref), Range (ref), u2 (copy), Flipbook (ref)
        if not (p90 and p90.Parent) then
            return;
        end;

        local Data = p89:GetData(p90);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v93 = Pool.acquireOrClone(Data.RenderTemplate, "Beam", Data.Pool);
        v93.Archivable = false;
        v93.Enabled = true;

        if Data.FaceCamera ~= nil then
            v93.FaceCamera = Data.FaceCamera;
        end;

        if Data.ZOffset ~= nil then
            v93.ZOffset = Data.ZOffset;
        end;

        if Data.TextureMode ~= nil then
            v93.TextureMode = Data.TextureMode;
        end;

        if p92 and p92._parentCloneMap then
            local _parentCloneMap = p92._parentCloneMap;

            if v93.Attachment0 and _parentCloneMap[v93.Attachment0] then
                v93.Attachment0 = _parentCloneMap[v93.Attachment0];
            end;

            if v93.Attachment1 and _parentCloneMap[v93.Attachment1] then
                v93.Attachment1 = _parentCloneMap[v93.Attachment1];
            end;
        end;

        local v94 = {};

        for i, v in pairs(Data.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    v93[i] = Graph.GetStaticValue(v, v93[i]);
                else
                    local v95 = Graph.GenerateSeed(v);
                    v94[i] = {
                        Sequence = v,
                        Seed = v95
                    };

                    if i ~= "TextureSpeed" then
                        local v96 = Graph.QueryPointsWithTime(0, v, v95);

                        if i == "Segments" then
                            local math_round_ret = math.round(v96);
                            v96 = math.max(20, math_round_ret);
                        end;

                        v93[i] = v96;
                    end;
                end;
            end;
        end;

        if v94.TextureSpeed then
            v93.TextureSpeed = 0;
        end;

        local v97, v98 = Graph.CollectGraphStates(Data.GraphBlender);
        local v99 = {};

        for i = 1, #v97 - 1 do
            v99[i] = Graph.PrecomputeMergedTimes(v97[i].Graph, v97[i + 1].Graph);
            local _ = i;
        end;

        local v100 = {};

        for i = 1, #v98 - 1 do
            v100[i] = Graph.PrecomputeMergedColorTimes(v98[i].Graph, v98[i + 1].Graph);
            local _ = i;
        end;

        if #v97 > 0 then
            v93.Transparency = v97[1].Graph;
        end;

        if #v98 > 0 then
            v93.Color = v98[1].Graph;
        end;

        v93.Parent = Data.EmitParent or p89:GetFolder();
        local v101 = Range.RandomValueFromRange(Data.Lifetime);
        local v102 = v101 <= 0 and 0.001 or v101;
        local v103 = Graph.GenerateSeed(Data.BeamTimescale);
        local v104 = {
            Type = "Beam",
            CurrentStep = 0,
            VisualPart = v93,
            Link = p91,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v102,
            PartLife = Data.PartLife or 0,
            AnimatedProps = v94,
            TransStates = v97,
            ColorStates = v98,
            TransMergedTimes = v99,
            ColorMergedTimes = v100,
            Graphs = {
                Timescale = Data.BeamTimescale
            },
            Seeds = {
                Timescale = v103
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.BeamTimescale, v103, v102)
        };

        if p89._parentScaleMap and p89._parentScaleMap[p90] then
            v104.ParentScale = p89._parentScaleMap[p90];
            v104._baseWidth0 = v93.Width0;
            v104._baseWidth1 = v93.Width1;
            v104._baseCurveSize0 = v93.CurveSize0;
            v104._baseCurveSize1 = v93.CurveSize1;
            v104._baseTextureLength = v93.TextureLength;
            v104._baseSegments = v93.Segments;
        end;

        v104._sourceItem = p90;
        u2._seedTsOverride(v104, p90);

        if Data.Pool ~= false then
            v104._sourceRT = Data.RenderTemplate;
            v104._poolKind = "Beam";
        end;

        p89:_registerEmit(v104, p92);

        if Data.CachedBeamTextures and (#Data.CachedBeamTextures > 0 and Data.FlipbookParticle) then
            Flipbook.FlipBeam(v104, Data.FlipbookParticle, Data.CachedBeamTextures, v93, v102);
        end;
    end;
end;