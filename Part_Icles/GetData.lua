-- Decompiled with Potassium's decompiler.

local Flipbook = require(script.Parent.Flipbook);
local TypeRegistry = require(script.Parent.TypeRegistry);
local AxisLinks = require(script.Parent.AxisLinks);
local EventsSchema = require(script.Parent.EventsSchema);
local GetDataRig = require(script.Parent.GetDataRig);

local function safeEnum(u1, u2, p3) -- Line: 13
    if not u2 then
        return p3;
    end;

    local success, result = pcall(function() -- Line: 15
        -- upvalues: u1 (copy), u2 (copy)
        return u1[u2];
    end);

    if success then
        p3 = result or p3;
    end;

    return p3;
end;

local function readAxisLinks(p4) -- Line: 20
    -- upvalues: AxisLinks (copy)
    local v5 = {
        SizeX = p4:GetAttribute("SizeXLinkedTo"),
        SizeY = p4:GetAttribute("SizeYLinkedTo"),
        SizeZ = p4:GetAttribute("SizeZLinkedTo"),
        RotSpeedX = p4:GetAttribute("RotSpeedXLinkedTo"),
        RotSpeedY = p4:GetAttribute("RotSpeedYLinkedTo"),
        RotSpeedZ = p4:GetAttribute("RotSpeedZLinkedTo"),
        PosOffsetX = p4:GetAttribute("PosOffsetXLinkedTo"),
        PosOffsetY = p4:GetAttribute("PosOffsetYLinkedTo"),
        PosOffsetZ = p4:GetAttribute("PosOffsetZLinkedTo"),
        RotX = p4:GetAttribute("RotXLinkedTo"),
        RotY = p4:GetAttribute("RotYLinkedTo"),
        RotZ = p4:GetAttribute("RotZLinkedTo"),
        PosX = p4:GetAttribute("PosXLinkedTo"),
        PosY = p4:GetAttribute("PosYLinkedTo"),
        PosZ = p4:GetAttribute("PosZLinkedTo")
    };

    return AxisLinks.sanitize(v5);
end;

return function(p6) -- Line: 31
    -- upvalues: TypeRegistry (copy), EventsSchema (copy), readAxisLinks (copy), GetDataRig (copy), safeEnum (copy), Flipbook (copy)
    function p6.GetData(p7, p8) -- Line: 35
        -- upvalues: TypeRegistry (ref), EventsSchema (ref), readAxisLinks (ref), GetDataRig (ref), safeEnum (ref), Flipbook (ref)
        local v9 = {};
        local Config = TypeRegistry.getConfig(p8);

        if not Config then
            return nil;
        end;

        local EmitParent = p8:FindFirstChild("EmitParent");
        v9.EmitParent = EmitParent and (EmitParent:IsA("ObjectValue") and EmitParent.Value) or nil;
        local Link = p8:FindFirstChild("Link");
        local v10 = Link and (Link:IsA("ObjectValue") and Link.Value) or nil;
        local v11 = p8:GetAttribute("LinkSource") or (v10 and "Object" or "None");

        if v11 == "Camera" then
            v9.Link = workspace.CurrentCamera;
        elseif v11 == "Object" then
            v9.Link = v10;
        else
            v9.Link = nil;
        end;

        v9.LinkMode = p8:GetAttribute("LinkMode") or "Follow";
        v9.RenderTemplate = p8:FindFirstChild("RenderTemplate");
        v9.Events = EventsSchema.readEnabled(p8);
        local v12 = Config:GetAttribute("TotalKeyFrames") or 0;
        v9.TotalKeyFrames = v12 > 0 and v12 and v12 or 100;

        function v9.CheckEnabled() -- Line: 66
            -- upvalues: Config (copy)
            local v13;

            if Config.Parent == nil then
                v13 = false;
            else
                v13 = Config:GetAttribute("Enabled") == true;
            end;

            return v13;
        end;

        if p8:IsA("Model") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.DirMode = Config:GetAttribute("DirMode") or (Config:GetAttribute("VelocityVectored") and "Local" or "RigidLocal");
            v9.VelocityVectored = v9.DirMode == "Local";
            v9.InvertMotion = Config:GetAttribute("InvertMotion") or false;
            v9.RotMode = Config:GetAttribute("RotMode") or "OverLife";
            v9.RotOrder = Config:GetAttribute("RotOrder") or "Global";
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            local Enum_NormalId = Enum.NormalId;
            local Attribute = Config:GetAttribute("EmissionDirection");
            local Top = Enum.NormalId.Top;

            if Attribute then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_NormalId (copy), Attribute (copy)
                    return Enum_NormalId[Attribute];
                end);

                if success then
                    Top = result or Top;
                end;
            end;

            v9.EmissionDirection = Top;
            v9.ParticleData = {
                SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0),
                Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0),
                Drag = Config:GetAttribute("Drag") or 0
            };
            v9.Speed = Config:GetAttribute("Speed");
            v9.Scale = Config:GetAttribute("Scale");
            v9.Timescale = Config:GetAttribute("Timescale");
            v9.RotX = Config:GetAttribute("RotX") or NumberRange.new(0);
            v9.RotY = Config:GetAttribute("RotY") or NumberRange.new(0);
            v9.RotZ = Config:GetAttribute("RotZ") or NumberRange.new(0);
            v9.RotXEven = Config:GetAttribute("RotXEven") == true;
            v9.RotYEven = Config:GetAttribute("RotYEven") == true;
            v9.RotZEven = Config:GetAttribute("RotZEven") == true;
            v9.PosX = Config:GetAttribute("PosX") or NumberRange.new(0);
            v9.PosY = Config:GetAttribute("PosY") or NumberRange.new(0);
            v9.PosZ = Config:GetAttribute("PosZ") or NumberRange.new(0);
            v9.PosXEven = Config:GetAttribute("PosXEven") == true;
            v9.PosYEven = Config:GetAttribute("PosYEven") == true;
            v9.PosZEven = Config:GetAttribute("PosZEven") == true;
            v9.PosMode = Config:GetAttribute("PosMode") or "Local";
            v9.DisplacementMode = Config:GetAttribute("DisplacementMode") or "Global";
            v9.RotSpeedX = Config:GetAttribute("RotSpeedX");
            v9.RotSpeedY = Config:GetAttribute("RotSpeedY");
            v9.RotSpeedZ = Config:GetAttribute("RotSpeedZ");
            v9.PosOffsetX = Config:GetAttribute("PosOffsetX");
            v9.PosOffsetY = Config:GetAttribute("PosOffsetY");
            v9.PosOffsetZ = Config:GetAttribute("PosOffsetZ");
            v9.Turbulence = Config:GetAttribute("Turbulence");
            v9.TurbulenceFrequency = Config:GetAttribute("TurbulenceFrequency") or 1;
            v9.Orientation = Config:GetAttribute("Orientation") or "None";
            v9.ZOffset = Config:GetAttribute("ZOffset") or 0;
            v9.AxisLinks = readAxisLinks(Config);
            v9.Pool = Config:GetAttribute("Pool");
            v9.ScaleTextureLength = Config:GetAttribute("ScaleTextureLength");
            v9.ScaleMotion = Config:GetAttribute("ScaleMotion") ~= false;
            v9.ScaleRotation = Config:GetAttribute("ScaleRotation") == true;

            return v9;
        end;

        if p8:IsA("BlurEffect") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.BlurSize = Config:GetAttribute("BlurSize");
            v9.Timescale = Config:GetAttribute("Timescale");

            return v9;
        end;

        if p8:IsA("BloomEffect") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.BloomIntensity = Config:GetAttribute("BloomIntensity");
            v9.BloomSize = Config:GetAttribute("BloomSize");
            v9.BloomThreshold = Config:GetAttribute("BloomThreshold");
            v9.Timescale = Config:GetAttribute("Timescale");

            return v9;
        end;

        if p8:IsA("ColorCorrectionEffect") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.CCBrightness = Config:GetAttribute("CCBrightness");
            v9.CCContrast = Config:GetAttribute("CCContrast");
            v9.CCSaturation = Config:GetAttribute("CCSaturation");
            v9.CCTintColor = Config:GetAttribute("CCTintColor");
            v9.Timescale = Config:GetAttribute("Timescale");

            return v9;
        end;

        if p8:IsA("Atmosphere") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.AtmDensity = Config:GetAttribute("AtmDensity");
            v9.AtmOffset = Config:GetAttribute("AtmOffset");
            v9.AtmGlare = Config:GetAttribute("AtmGlare");
            v9.AtmHaze = Config:GetAttribute("AtmHaze");
            v9.AtmColor = Config:GetAttribute("AtmColor");
            v9.AtmDecay = Config:GetAttribute("AtmDecay");
            v9.AtmTimescale = Config:GetAttribute("AtmTimescale");

            return v9;
        end;

        if p8:IsA("ImageLabel") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.ImageTransparency = Config:GetAttribute("ImageTransparency");
            v9.BackgroundTransparency = Config:GetAttribute("BackgroundTransparency");
            v9.ImgSpeed = Config:GetAttribute("ImgSpeed");
            v9.SizeScaleX = Config:GetAttribute("SizeScaleX");
            v9.SizeScaleY = Config:GetAttribute("SizeScaleY");
            v9.ImgRotRange = Config:GetAttribute("ImgRotRange") or NumberRange.new(0);
            v9.ImgRotSpeed = Config:GetAttribute("ImgRotSpeed");
            v9.ImgRotMode = Config:GetAttribute("ImgRotMode") or "OverLife";
            v9.ImageColor3 = Config:GetAttribute("ImageColor3");
            v9.BackgroundColor3 = Config:GetAttribute("BackgroundColor3");
            v9.Image = Config:GetAttribute("Image") or "";
            v9.ImgPosition = Config:GetAttribute("Position") or UDim2.fromScale(0.5, 0.5);
            v9.ImgSizeUDim = Config:GetAttribute("ImgSize") or UDim2.fromOffset(100, 100);
            v9.ImgAnchorPoint = Config:GetAttribute("AnchorPoint") or Vector2.new(0.5, 0.5);
            v9.ImgZIndex = Config:GetAttribute("ZIndex") or 1;
            local Enum_ScaleType = Enum.ScaleType;
            local Attribute = Config:GetAttribute("ScaleType");
            local Stretch = Enum.ScaleType.Stretch;

            if Attribute then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ScaleType (copy), Attribute (copy)
                    return Enum_ScaleType[Attribute];
                end);

                if success then
                    Stretch = result or Stretch;
                end;
            end;

            v9.ImgScaleType = Stretch;
            local Enum_ResamplerMode = Enum.ResamplerMode;
            local Attribute2 = Config:GetAttribute("ResampleMode");
            local Default = Enum.ResamplerMode.Default;

            if Attribute2 then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ResamplerMode (copy), Attribute2 (copy)
                    return Enum_ResamplerMode[Attribute2];
                end);

                if success then
                    Default = result or Default;
                end;
            end;

            v9.ImgResampleMode = Default;
            v9.ImgEmissionAngle = Config:GetAttribute("EmissionAngle") or 90;
            v9.ImgSpreadAngle = Config:GetAttribute("ImgSpreadAngle") or 0;
            v9.ImgAcceleration = Config:GetAttribute("ImgAcceleration") or Vector2.new(0, 0);
            v9.ImgDrag = Config:GetAttribute("ImgDrag") or 0;
            v9.ImgInvertMotion = Config:GetAttribute("ImgInvertMotion") or false;
            v9.ImgFlipbookSource = Config:GetAttribute("ImgFlipbookSource") or "Decals";
            local Enum_ParticleFlipbookMode = Enum.ParticleFlipbookMode;
            local Attribute3 = Config:GetAttribute("ImgFlipbookMode");
            local Loop = Enum.ParticleFlipbookMode.Loop;

            if Attribute3 then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ParticleFlipbookMode (copy), Attribute3 (copy)
                    return Enum_ParticleFlipbookMode[Attribute3];
                end);

                if success then
                    Loop = result or Loop;
                end;
            end;

            v9.ImgFlipbookMode = Loop;
            v9.ImgFlipbookStartRandom = Config:GetAttribute("ImgFlipbookStartRandom") or false;
            v9.ImgGridCols = Config:GetAttribute("GridCols") or 8;
            v9.ImgGridRows = Config:GetAttribute("GridRows") or 1;
            v9.ImgFlipbookFramerate = Config:GetAttribute("ImgFlipbookFramerate") or NumberRange.new(10);
            v9.ImgFlipbookReverse = Config:GetAttribute("ImgFlipbookReverse") or false;
            local Attribute4 = Config:GetAttribute("_SheetSize");
            local Attribute5 = Config:GetAttribute("_SheetAsset");
            local v14;

            if type(v9.Image) == "string" then
                v14 = v9.Image:match("rbxassetid://(%d+)") or (v9.Image:match("^(%d+)$") or nil);
            else
                v14 = nil;
            end;

            if typeof(Attribute4) == "Vector2" and (Attribute5 and Attribute5 == v14) then
                v9.SheetSize = Attribute4;
            end;

            v9.ImageFlipbooks = p8:FindFirstChild("ImageFlipbooks");
            v9.ImgTimescale = Config:GetAttribute("ImgTimescale");
            v9.Pool = Config:GetAttribute("Pool");

            return v9;
        end;

        if p8:IsA("PointLight") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.PLRange = Config:GetAttribute("PLRange");
            v9.PLBrightness = Config:GetAttribute("PLBrightness");
            v9.PLColor = Config:GetAttribute("PLColor");
            v9.PLTimescale = Config:GetAttribute("PLTimescale");
            v9.Shadows = Config:GetAttribute("Shadows");
            v9.Pool = Config:GetAttribute("Pool");

            return v9;
        end;

        if p8:IsA("Highlight") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.HLFillColor = Config:GetAttribute("HLFillColor");
            v9.HLFillTransparency = Config:GetAttribute("HLFillTransparency");
            v9.HLOutlineColor = Config:GetAttribute("HLOutlineColor");
            v9.HLOutlineTransparency = Config:GetAttribute("HLOutlineTransparency");
            v9.HLTimescale = Config:GetAttribute("HLTimescale");
            local Enum_HighlightDepthMode = Enum.HighlightDepthMode;
            local Attribute = Config:GetAttribute("HLDepthMode");
            local AlwaysOnTop = Enum.HighlightDepthMode.AlwaysOnTop;

            if Attribute then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_HighlightDepthMode (copy), Attribute (copy)
                    return Enum_HighlightDepthMode[Attribute];
                end);

                if success then
                    AlwaysOnTop = result or AlwaysOnTop;
                end;
            end;

            v9.HLDepthMode = AlwaysOnTop;
            local Adornee = p8:FindFirstChild("Adornee");
            v9.Adornee = Adornee and (Adornee:IsA("ObjectValue") and Adornee.Value) or nil;
            v9.Pool = Config:GetAttribute("Pool");

            return v9;
        end;

        if p8:IsA("Trail") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(2);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.TEmitTimescale = Config:GetAttribute("TEmitTimescale");
            v9.TEmitBrightness = Config:GetAttribute("TEmitBrightness");
            v9.TEmitLightEmission = Config:GetAttribute("TEmitLightEmission");
            v9.TEmitLightInfluence = Config:GetAttribute("TEmitLightInfluence");
            v9.TEmitTextureLength = Config:GetAttribute("TEmitTextureLength");
            v9.TEmitMinLength = Config:GetAttribute("TEmitMinLength");
            v9.TEmitMaxLength = Config:GetAttribute("TEmitMaxLength");
            v9.TrailLife = Config:GetAttribute("TEmitTrailLife") or NumberRange.new(2);
            local Enum_ParticleFlipbookMode = Enum.ParticleFlipbookMode;
            local Attribute = Config:GetAttribute("TEmitFlipbookMode");
            local OneShot = Enum.ParticleFlipbookMode.OneShot;

            if Attribute then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ParticleFlipbookMode (copy), Attribute (copy)
                    return Enum_ParticleFlipbookMode[Attribute];
                end);

                if success then
                    OneShot = result or OneShot;
                end;
            end;

            v9.TrailFlipbookMode = OneShot;
            v9.TrailFlipbookFramerate = Config:GetAttribute("TEmitFlipbookFramerate") or NumberRange.new(30);
            v9.TrailFlipbookStartRandom = Config:GetAttribute("TEmitFlipbookStartRandom");
            v9.TrailFlipbookReverse = Config:GetAttribute("TEmitFlipbookReverse");
            v9.TrailFlipbooks = p8:FindFirstChild("TrailFlipbooks");
            v9.GraphBlender = p8:FindFirstChild("GraphBlender");
            v9.Pool = Config:GetAttribute("Pool");

            return v9;
        end;

        if p8:IsA("Attachment") then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;
            v9.DirMode = Config:GetAttribute("DirMode") or (Config:GetAttribute("VelocityVectored") and "Local" or "RigidLocal");
            v9.VelocityVectored = v9.DirMode == "Local";
            v9.InvertMotion = Config:GetAttribute("InvertMotion") or false;
            v9.RotMode = Config:GetAttribute("RotMode") or "OverLife";
            v9.RotOrder = Config:GetAttribute("RotOrder") or "Global";
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            local Enum_NormalId = Enum.NormalId;
            local Attribute = Config:GetAttribute("EmissionDirection");
            local Top = Enum.NormalId.Top;

            if Attribute then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_NormalId (copy), Attribute (copy)
                    return Enum_NormalId[Attribute];
                end);

                if success then
                    Top = result or Top;
                end;
            end;

            v9.EmissionDirection = Top;
            v9.ParticleData = {
                SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0),
                Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0),
                Drag = Config:GetAttribute("Drag") or 0
            };
            v9.Speed = Config:GetAttribute("Speed");
            v9.Timescale = Config:GetAttribute("Timescale");
            v9.RotX = Config:GetAttribute("RotX") or NumberRange.new(0);
            v9.RotY = Config:GetAttribute("RotY") or NumberRange.new(0);
            v9.RotZ = Config:GetAttribute("RotZ") or NumberRange.new(0);
            v9.RotXEven = Config:GetAttribute("RotXEven") == true;
            v9.RotYEven = Config:GetAttribute("RotYEven") == true;
            v9.RotZEven = Config:GetAttribute("RotZEven") == true;
            v9.PosX = Config:GetAttribute("PosX") or NumberRange.new(0);
            v9.PosY = Config:GetAttribute("PosY") or NumberRange.new(0);
            v9.PosZ = Config:GetAttribute("PosZ") or NumberRange.new(0);
            v9.PosXEven = Config:GetAttribute("PosXEven") == true;
            v9.PosYEven = Config:GetAttribute("PosYEven") == true;
            v9.PosZEven = Config:GetAttribute("PosZEven") == true;
            v9.PosMode = Config:GetAttribute("PosMode") or "Local";
            v9.DisplacementMode = Config:GetAttribute("DisplacementMode") or "Global";
            v9.RotSpeedX = Config:GetAttribute("RotSpeedX");
            v9.RotSpeedY = Config:GetAttribute("RotSpeedY");
            v9.RotSpeedZ = Config:GetAttribute("RotSpeedZ");
            v9.PosOffsetX = Config:GetAttribute("PosOffsetX");
            v9.PosOffsetY = Config:GetAttribute("PosOffsetY");
            v9.PosOffsetZ = Config:GetAttribute("PosOffsetZ");
            v9.Turbulence = Config:GetAttribute("Turbulence");
            v9.TurbulenceFrequency = Config:GetAttribute("TurbulenceFrequency") or 1;
            v9.Orientation = Config:GetAttribute("Orientation") or "None";
            v9.ZOffset = Config:GetAttribute("ZOffset") or 0;
            v9.AxisLinks = readAxisLinks(Config);
            v9.Pool = Config:GetAttribute("Pool");

            return v9;
        end;

        if p8:IsA("BasePart") and p8:GetAttribute("IsRocks") == true then
            return GetDataRig.readRocks(v9, p8, Config, safeEnum);
        end;

        if p8:IsA("BasePart") and p8:GetAttribute("IsRope") == true then
            v9.AxisLinks = readAxisLinks(Config);

            return GetDataRig.readRope(v9, p8, Config, safeEnum);
        end;

        if p8:IsA("BasePart") and p8:GetAttribute("IsCameraShake") == true then
            v9.PartLife = 0;
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(0.5);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.ShakeAmplitude = Config:GetAttribute("ShakeAmplitude");
            v9.ShakeRotAmplitude = Config:GetAttribute("ShakeRotAmplitude");
            v9.ShakeFrequency = Config:GetAttribute("ShakeFrequency") or 10;
            v9.ShakeFalloff = Config:GetAttribute("ShakeFalloff") or 0;
            v9.Timescale = Config:GetAttribute("Timescale");

            return v9;
        end;

        if not p8:IsA("BasePart") or p8:GetAttribute("IsLightning") ~= true then
            v9.PartLife = Config:GetAttribute("PartLife") or 0;

            if p8:IsA("Beam") then
                v9.GraphBlender = p8:FindFirstChild("GraphBlender");
                v9.Lifetime = Config:GetAttribute("BeamLifetime") or NumberRange.new(1);
                v9.Rate = Config:GetAttribute("Rate") or 10;
                v9.BeamFlipbooks = p8:FindFirstChild("BeamFlipbooks");
                local v15 = {};
                local Enum_ParticleFlipbookMode = Enum.ParticleFlipbookMode;
                local Attribute = Config:GetAttribute("BeamFlipbookMode");
                local v16;

                if Attribute then
                    local success, result = pcall(function() -- Line: 15
                        -- upvalues: Enum_ParticleFlipbookMode (copy), Attribute (copy)
                        return Enum_ParticleFlipbookMode[Attribute];
                    end);
                    v16 = success and result and result or nil;
                else
                    v16 = nil;
                end;

                v15.FlipbookMode = v16;
                v15.FlipbookFramerate = Config:GetAttribute("BeamFlipbookFramerate") or nil;
                v15.FlipbookStartRandom = Config:GetAttribute("BeamFlipbookStartRandom") or false;
                v15.FlipbookReverse = Config:GetAttribute("BeamFlipbookReverse") or false;
                v9.FlipbookParticle = v15;

                if v9.BeamFlipbooks then
                    v9.CachedBeamTextures = Flipbook.GetSortedBeamTextures(v9.BeamFlipbooks);
                end;

                v9.FaceCamera = Config:GetAttribute("FaceCamera");
                v9.ZOffset = Config:GetAttribute("ZOffset");
                local Enum_TextureMode = Enum.TextureMode;
                local Attribute2 = Config:GetAttribute("BeamTextureMode");
                local v17;

                if Attribute2 then
                    local success, result = pcall(function() -- Line: 15
                        -- upvalues: Enum_TextureMode (copy), Attribute2 (copy)
                        return Enum_TextureMode[Attribute2];
                    end);
                    v17 = success and result and result or nil;
                else
                    v17 = nil;
                end;

                v9.TextureMode = v17;
                v9.BeamProps = {
                    Brightness = Config:GetAttribute("BeamBrightness"),
                    CurveSize0 = Config:GetAttribute("CurveSize0"),
                    CurveSize1 = Config:GetAttribute("CurveSize1"),
                    Width0 = Config:GetAttribute("Width0"),
                    Width1 = Config:GetAttribute("Width1"),
                    LightEmission = Config:GetAttribute("LightEmission"),
                    LightInfluence = Config:GetAttribute("BeamLightInfluence"),
                    Segments = Config:GetAttribute("Segments"),
                    TextureLength = Config:GetAttribute("TextureLength"),
                    TextureSpeed = Config:GetAttribute("TextureSpeed")
                };
                v9.BeamTimescale = Config:GetAttribute("BeamTimescale");
                v9.Pool = Config:GetAttribute("Pool");

                return v9;
            end;

            v9.MeshFlipbooks = p8:FindFirstChild("MeshFlipbooks");

            if v9.MeshFlipbooks then
                v9.CachedMeshTextures = Flipbook.GetSortedTextures(v9.MeshFlipbooks);
            end;

            v9.DirMode = Config:GetAttribute("DirMode") or (Config:GetAttribute("VelocityVectored") and "Local" or "RigidLocal");
            v9.VelocityVectored = v9.DirMode == "Local";
            v9.InvertMotion = Config:GetAttribute("InvertMotion") or false;
            v9.RotMode = Config:GetAttribute("RotMode") or "OverLife";
            v9.RotOrder = Config:GetAttribute("RotOrder") or "Global";
            v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v9.Rate = Config:GetAttribute("Rate") or 10;
            v9.AccelerationTowardsInstance = Config:GetAttribute("AccelerationTowardsInstance") or false;
            v9.AccelStrength = Config:GetAttribute("AccelStrength") or NumberSequence.new(0);
            local AccelTarget = p8:FindFirstChild("AccelTarget");
            local v18 = AccelTarget and (AccelTarget:IsA("ObjectValue") and AccelTarget.Value) or nil;

            if v18 and (v18:IsA("BasePart") or (v18:IsA("Attachment") or (v18:IsA("Camera") or (v18:IsA("Model") or v18:IsA("Bone"))))) then
                v9.AccelTarget = v18;
            else
                v9.AccelTarget = nil;
            end;

            local ShapePart = p8:FindFirstChild("ShapePart");
            local v19 = ShapePart and (ShapePart:IsA("ObjectValue") and ShapePart.Value) or nil;

            if v19 and (v19:IsA("BasePart") and v19.Parent) then
                v9.ShapePart = v19;
            else
                v9.ShapePart = nil;
            end;

            local Enum_ParticleEmitterShape = Enum.ParticleEmitterShape;
            local Attribute = Config:GetAttribute("Shape");
            local Box = Enum.ParticleEmitterShape.Box;

            if Attribute then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ParticleEmitterShape (copy), Attribute (copy)
                    return Enum_ParticleEmitterShape[Attribute];
                end);

                if success then
                    Box = result or Box;
                end;
            end;

            v9.Shape = Box;
            local Enum_ParticleEmitterShapeInOut = Enum.ParticleEmitterShapeInOut;
            local Attribute2 = Config:GetAttribute("ShapeInOut");
            local Outward = Enum.ParticleEmitterShapeInOut.Outward;

            if Attribute2 then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ParticleEmitterShapeInOut (copy), Attribute2 (copy)
                    return Enum_ParticleEmitterShapeInOut[Attribute2];
                end);

                if success then
                    Outward = result or Outward;
                end;
            end;

            v9.ShapeInOut = Outward;
            local Enum_NormalId = Enum.NormalId;
            local Attribute3 = Config:GetAttribute("EmissionDirection");
            local Top = Enum.NormalId.Top;

            if Attribute3 then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_NormalId (copy), Attribute3 (copy)
                    return Enum_NormalId[Attribute3];
                end);

                if success then
                    Top = result or Top;
                end;
            end;

            v9.EmissionDirection = Top;
            v9.UseShape = Config:GetAttribute("UseShape") == true;
            v9.LookAtInitially = Config:GetAttribute("LookAtInitially") == true;
            local v20 = {
                Shape = v9.Shape,
                ShapeInOut = v9.ShapeInOut
            };
            local v21 = Config:GetAttribute("ShapePartial") or 0;
            v20.ShapePartial = math.clamp(v21, 0, 1);
            v20.UseShape = v9.UseShape;
            v20.LookAtInitially = v9.LookAtInitially;
            v20.EmissionDirection = v9.EmissionDirection;
            v20.SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0);
            v20.Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0);
            v20.Drag = Config:GetAttribute("Drag") or 0;
            local Enum_ParticleFlipbookMode = Enum.ParticleFlipbookMode;
            local Attribute4 = Config:GetAttribute("FlipbookMode");
            local v22;

            if Attribute4 then
                local success, result = pcall(function() -- Line: 15
                    -- upvalues: Enum_ParticleFlipbookMode (copy), Attribute4 (copy)
                    return Enum_ParticleFlipbookMode[Attribute4];
                end);
                v22 = success and result and result or nil;
            else
                v22 = nil;
            end;

            v20.FlipbookMode = v22;
            v20.FlipbookFramerate = Config:GetAttribute("FlipbookFramerate") or nil;
            v20.FlipbookStartRandom = Config:GetAttribute("FlipbookStartRandom") or false;
            v20.FlipbookReverse = Config:GetAttribute("FlipbookReverse") or false;
            v9.ParticleData = v20;
            v9.Transparency = Config:GetAttribute("Transparency");
            v9.Color = Config:GetAttribute("Color");
            v9.Speed = Config:GetAttribute("Speed");
            v9.Brightness = Config:GetAttribute("Brightness");
            v9.Timescale = Config:GetAttribute("Timescale");
            v9.AxisLinks = readAxisLinks(Config);
            v9.SizeX = Config:GetAttribute("SizeX");
            v9.SizeY = Config:GetAttribute("SizeY");
            v9.SizeZ = Config:GetAttribute("SizeZ");
            v9.RotX = Config:GetAttribute("RotX") or NumberRange.new(0);
            v9.RotY = Config:GetAttribute("RotY") or NumberRange.new(0);
            v9.RotZ = Config:GetAttribute("RotZ") or NumberRange.new(0);
            v9.RotXEven = Config:GetAttribute("RotXEven") == true;
            v9.RotYEven = Config:GetAttribute("RotYEven") == true;
            v9.RotZEven = Config:GetAttribute("RotZEven") == true;
            v9.PosX = Config:GetAttribute("PosX") or NumberRange.new(0);
            v9.PosY = Config:GetAttribute("PosY") or NumberRange.new(0);
            v9.PosZ = Config:GetAttribute("PosZ") or NumberRange.new(0);
            v9.PosXEven = Config:GetAttribute("PosXEven") == true;
            v9.PosYEven = Config:GetAttribute("PosYEven") == true;
            v9.PosZEven = Config:GetAttribute("PosZEven") == true;
            v9.PosMode = Config:GetAttribute("PosMode") or "Local";
            v9.DisplacementMode = Config:GetAttribute("DisplacementMode") or "Global";
            v9.RotSpeedX = Config:GetAttribute("RotSpeedX");
            v9.RotSpeedY = Config:GetAttribute("RotSpeedY");
            v9.RotSpeedZ = Config:GetAttribute("RotSpeedZ");
            v9.PosOffsetX = Config:GetAttribute("PosOffsetX");
            v9.PosOffsetY = Config:GetAttribute("PosOffsetY");
            v9.PosOffsetZ = Config:GetAttribute("PosOffsetZ");
            v9.Turbulence = Config:GetAttribute("Turbulence");
            v9.TurbulenceFrequency = Config:GetAttribute("TurbulenceFrequency") or 1;
            v9.Orientation = Config:GetAttribute("Orientation") or "None";
            v9.ZOffset = Config:GetAttribute("ZOffset") or 0;
            v9.Pool = Config:GetAttribute("Pool");

            return v9;
        end;

        v9.PartLife = Config:GetAttribute("PartLife") or 0;
        v9.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
        v9.Rate = Config:GetAttribute("Rate") or 10;
        v9.TargetMode = Config:GetAttribute("TargetMode") or "Directional";
        local Target = p8:FindFirstChild("Target");
        v9.Target = Target and (Target:IsA("ObjectValue") and Target.Value) or nil;
        v9.Length = Config:GetAttribute("Length") or NumberRange.new(20);
        v9.GrowthSpeed = Config:GetAttribute("GrowthSpeed") or 0;
        v9.SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0);
        local Enum_NormalId = Enum.NormalId;
        local Attribute = Config:GetAttribute("EmissionDirection");
        local Top = Enum.NormalId.Top;

        if Attribute then
            local success, result = pcall(function() -- Line: 15
                -- upvalues: Enum_NormalId (copy), Attribute (copy)
                return Enum_NormalId[Attribute];
            end);

            if success then
                Top = result or Top;
            end;
        end;

        v9.EmissionDirection = Top;

        local function asRange(p23, p24) -- Line: 387
            if typeof(p23) == "NumberRange" then
                return p23;
            end;

            if typeof(p23) == "number" then
                return NumberRange.new(p23);
            end;

            return p24;
        end;

        local Attribute2 = Config:GetAttribute("SegmentCount");
        local NumberRange_new_ret = NumberRange.new(12);

        if typeof(Attribute2) == "NumberRange" then
            NumberRange_new_ret = Attribute2;
        elseif typeof(Attribute2) == "number" then
            NumberRange_new_ret = NumberRange.new(Attribute2);
        end;

        v9.SegmentCount = NumberRange_new_ret;
        local Attribute3 = Config:GetAttribute("Amplitude");
        local NumberRange_new_ret2 = NumberRange.new(0.15);

        if typeof(Attribute3) == "NumberRange" then
            NumberRange_new_ret2 = Attribute3;
        elseif typeof(Attribute3) == "number" then
            NumberRange_new_ret2 = NumberRange.new(Attribute3);
        end;

        v9.Amplitude = NumberRange_new_ret2;
        local Attribute4 = Config:GetAttribute("AmplitudeDecay");
        local NumberRange_new_ret3 = NumberRange.new(0.5);

        if typeof(Attribute4) == "NumberRange" then
            NumberRange_new_ret3 = Attribute4;
        elseif typeof(Attribute4) == "number" then
            NumberRange_new_ret3 = NumberRange.new(Attribute4);
        end;

        v9.AmplitudeDecay = NumberRange_new_ret3;
        local Attribute5 = Config:GetAttribute("JitterRate");
        local NumberRange_new_ret4 = NumberRange.new(15);

        if typeof(Attribute5) == "NumberRange" then
            NumberRange_new_ret4 = Attribute5;
        elseif typeof(Attribute5) == "number" then
            NumberRange_new_ret4 = NumberRange.new(Attribute5);
        end;

        v9.JitterRate = NumberRange_new_ret4;
        local Attribute6 = Config:GetAttribute("ForkChance");
        local NumberRange_new_ret5 = NumberRange.new(0);

        if typeof(Attribute6) == "NumberRange" then
            NumberRange_new_ret5 = Attribute6;
        elseif typeof(Attribute6) == "number" then
            NumberRange_new_ret5 = NumberRange.new(Attribute6);
        end;

        v9.ForkChance = NumberRange_new_ret5;
        local Attribute7 = Config:GetAttribute("ForkDepth");
        local NumberRange_new_ret6 = NumberRange.new(0);

        if typeof(Attribute7) == "NumberRange" then
            NumberRange_new_ret6 = Attribute7;
        elseif typeof(Attribute7) == "number" then
            NumberRange_new_ret6 = NumberRange.new(Attribute7);
        end;

        v9.ForkDepth = NumberRange_new_ret6;
        local Attribute8 = Config:GetAttribute("ForkLengthScale");
        local NumberRange_new_ret7 = NumberRange.new(0.4);

        if typeof(Attribute8) == "NumberRange" then
            NumberRange_new_ret7 = Attribute8;
        elseif typeof(Attribute8) == "number" then
            NumberRange_new_ret7 = NumberRange.new(Attribute8);
        end;

        v9.ForkLengthScale = NumberRange_new_ret7;
        local Attribute9 = Config:GetAttribute("Sag");
        local NumberRange_new_ret8 = NumberRange.new(0);

        if typeof(Attribute9) == "NumberRange" then
            NumberRange_new_ret8 = Attribute9;
        elseif typeof(Attribute9) == "number" then
            NumberRange_new_ret8 = NumberRange.new(Attribute9);
        end;

        v9.Sag = NumberRange_new_ret8;
        local Attribute10 = Config:GetAttribute("SagShape");
        local NumberRange_new_ret9 = NumberRange.new(1);

        if typeof(Attribute10) == "NumberRange" then
            NumberRange_new_ret9 = Attribute10;
        elseif typeof(Attribute10) == "number" then
            NumberRange_new_ret9 = NumberRange.new(Attribute10);
        end;

        v9.SagShape = NumberRange_new_ret9;
        local Attribute11 = Config:GetAttribute("SeekRadius");
        local NumberRange_new_ret10 = NumberRange.new(30);

        if typeof(Attribute11) == "NumberRange" then
            NumberRange_new_ret10 = Attribute11;
        elseif typeof(Attribute11) == "number" then
            NumberRange_new_ret10 = NumberRange.new(Attribute11);
        end;

        v9.SeekRadius = NumberRange_new_ret10;
        v9.SeekRetarget = Config:GetAttribute("SeekRetarget") == true;
        v9.SeekBias = Config:GetAttribute("SeekBias") or 0;
        v9.RetargetSpeed = Config:GetAttribute("RetargetSpeed") or 0;
        v9.Gradient = Config:GetAttribute("Gradient");
        v9.ShapeMode = Config:GetAttribute("ShapeMode") or "Jitter";
        local Attribute12 = Config:GetAttribute("ScrollSpeed");
        local NumberRange_new_ret11 = NumberRange.new(1);

        if typeof(Attribute12) == "NumberRange" then
            NumberRange_new_ret11 = Attribute12;
        elseif typeof(Attribute12) == "number" then
            NumberRange_new_ret11 = NumberRange.new(Attribute12);
        end;

        v9.ScrollSpeed = NumberRange_new_ret11;
        local Attribute13 = Config:GetAttribute("Waves");
        local NumberRange_new_ret12 = NumberRange.new(3);

        if typeof(Attribute13) == "NumberRange" then
            NumberRange_new_ret12 = Attribute13;
        elseif typeof(Attribute13) == "number" then
            NumberRange_new_ret12 = NumberRange.new(Attribute13);
        end;

        v9.Waves = NumberRange_new_ret12;
        v9.UseShape = Config:GetAttribute("UseShape") == true;
        local Enum_ParticleEmitterShape = Enum.ParticleEmitterShape;
        local Attribute14 = Config:GetAttribute("Shape");
        local Box = Enum.ParticleEmitterShape.Box;

        if Attribute14 then
            local success, result = pcall(function() -- Line: 15
                -- upvalues: Enum_ParticleEmitterShape (copy), Attribute14 (copy)
                return Enum_ParticleEmitterShape[Attribute14];
            end);

            if success then
                Box = result or Box;
            end;
        end;

        v9.Shape = Box;
        local Enum_ParticleEmitterShapeInOut = Enum.ParticleEmitterShapeInOut;
        local Attribute15 = Config:GetAttribute("ShapeInOut");
        local Outward = Enum.ParticleEmitterShapeInOut.Outward;

        if Attribute15 then
            local success, result = pcall(function() -- Line: 15
                -- upvalues: Enum_ParticleEmitterShapeInOut (copy), Attribute15 (copy)
                return Enum_ParticleEmitterShapeInOut[Attribute15];
            end);

            if success then
                Outward = result or Outward;
            end;
        end;

        v9.ShapeInOut = Outward;
        v9.ShapePartial = Config:GetAttribute("ShapePartial") or 0;
        v9.ShapeDirection = Config:GetAttribute("ShapeDirection") or "Emitter";
        local ShapePart = p8:FindFirstChild("ShapePart");
        v9.ShapePart = ShapePart and (ShapePart:IsA("ObjectValue") and ShapePart.Value) or nil;
        v9.PosX = Config:GetAttribute("PosX") or NumberRange.new(0);
        v9.PosY = Config:GetAttribute("PosY") or NumberRange.new(0);
        v9.PosZ = Config:GetAttribute("PosZ") or NumberRange.new(0);
        v9.PosXEven = Config:GetAttribute("PosXEven") == true;
        v9.PosYEven = Config:GetAttribute("PosYEven") == true;
        v9.PosZEven = Config:GetAttribute("PosZEven") == true;
        v9.PosMode = Config:GetAttribute("PosMode") or "Local";
        v9.RotX = Config:GetAttribute("RotX") or NumberRange.new(0);
        v9.RotY = Config:GetAttribute("RotY") or NumberRange.new(0);
        v9.RotZ = Config:GetAttribute("RotZ") or NumberRange.new(0);
        v9.RotXEven = Config:GetAttribute("RotXEven") == true;
        v9.RotYEven = Config:GetAttribute("RotYEven") == true;
        v9.RotZEven = Config:GetAttribute("RotZEven") == true;
        v9.RotOrder = Config:GetAttribute("RotOrder") or "Global";
        v9.DirMode = Config:GetAttribute("DirMode") or "RigidLocal";
        v9.AxisLinks = readAxisLinks(Config);
        v9.Speed = Config:GetAttribute("Speed");
        v9.Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0);
        v9.Drag = Config:GetAttribute("Drag") or 0;
        v9.PosOffsetX = Config:GetAttribute("PosOffsetX");
        v9.PosOffsetY = Config:GetAttribute("PosOffsetY");
        v9.PosOffsetZ = Config:GetAttribute("PosOffsetZ");
        v9.DisplacementMode = Config:GetAttribute("DisplacementMode") or "Global";
        v9.Turbulence = Config:GetAttribute("Turbulence");
        v9.TurbulenceFrequency = Config:GetAttribute("TurbulenceFrequency") or 1;
        v9.Color = Config:GetAttribute("Color");
        v9.Brightness = Config:GetAttribute("Brightness");
        v9.Transparency = Config:GetAttribute("Transparency");
        v9.Thickness = Config:GetAttribute("Thickness");
        v9.Timescale = Config:GetAttribute("Timescale");
        v9.Pool = Config:GetAttribute("Pool");

        return v9;
    end;
end;