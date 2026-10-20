-- Decompiled with Potassium's decompiler.

local TypeRegistry = require(script.Parent.TypeRegistry);
require(script.Parent.PartConstants);

return function(u1) -- Line: 10
    -- upvalues: TypeRegistry (copy)
    if not u1.TransformCompleted then
        u1.TransformCompleted = Instance.new("BindableEvent");
    end;

    function u1.Transform(p2, u3) -- Line: 19
        -- upvalues: TypeRegistry (ref), u1 (copy)
        if u3:GetAttribute("Transformed") then
            return;
        end;

        local TypeFor = TypeRegistry.getTypeFor(u3);

        if not TypeFor then
            if u3:IsA("BasePart") and (u3:GetAttribute("IsLightning") and TypeRegistry.Types.Lightning) then
                TypeFor = TypeRegistry.Types.Lightning;
            elseif u3:IsA("BasePart") and (u3:GetAttribute("IsCameraShake") and TypeRegistry.Types.CameraShake) then
                TypeFor = TypeRegistry.Types.CameraShake;
            elseif u3:IsA("BasePart") and (u3:GetAttribute("IsRocks") and TypeRegistry.Types.Rocks) then
                TypeFor = TypeRegistry.Types.Rocks;
            else
                if not (u3:IsA("BasePart") and (u3:GetAttribute("IsRope") and TypeRegistry.Types.Rope)) then
                    return;
                end;

                TypeFor = TypeRegistry.Types.Rope;
            end;
        end;

        local v4 = TypeFor == TypeRegistry.Types.Lightning;
        local v5 = TypeFor == TypeRegistry.Types.CameraShake;
        local v6 = TypeFor == TypeRegistry.Types.Rocks;
        local v7 = TypeFor == TypeRegistry.Types.Rope;

        if TypeFor.directAccess then
            if u3:IsA("Trail") and TypeRegistry.Types.TrailEmitter then
                TypeFor = TypeRegistry.Types.TrailEmitter;
            else
                if not (u3:IsA("Beam") and TypeRegistry.Types.Beam) then
                    return;
                end;

                TypeFor = TypeRegistry.Types.Beam;
            end;
        end;

        if u3:IsA("Model") then
            return p2:TransformModel(u3, TypeFor);
        end;

        local v8 = TypeRegistry.createConfig(u3, TypeFor);
        local v9 = u3:Clone();
        v9.Name = "RenderTemplate";

        for _, child in v9:GetChildren() do
            if not (child:GetAttribute("Transformed") or child:IsA("Attachment")) then
                if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or (child.Name == "Link" or (child.Name == "AccelTarget" or (child.Name == "Target" or child.Name == "ImageFlipbooks")))) then
                    child:Destroy();
                elseif u3:IsA("PointLight") or u3:IsA("Highlight") then
                    child:Destroy();
                elseif u3:IsA("Attachment") then
                    if child.Name == "MeshFlipbooks" or (child.Name == "BeamFlipbooks" or child.Name == "GraphBlender") then
                        child:Destroy();
                    end;
                elseif u3:IsA("ImageLabel") then
                    if not child:IsA("UIComponent") then
                        child:Destroy();
                    end;
                elseif not (child:IsA("SpecialMesh") or (child:IsA("Decal") or (child:IsA("Texture") or child:IsA("SurfaceAppearance")))) then
                    child:Destroy();
                end;
            end;
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop", "PreloadTexture", "LinkMode", "LinkSource" }) do
            v9:SetAttribute(v, nil);
        end;

        if v9:IsA("BasePart") then
            v9.Anchored = true;
            v9.CanCollide = false;
            v9.CanQuery = false;
            v9.CanTouch = false;
            v9.CastShadow = false;
            v9.Massless = true;
            v9.Locked = true;
            v9.Transparency = 1;

            for _, child in ipairs(v9:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child.Transparency = 1;
                end;
            end;
        end;

        if v9:IsA("Attachment") then
            v9.CFrame = CFrame.new();
        end;

        for _, descendant in ipairs(v9:GetDescendants()) do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and not descendant:GetAttribute("Transformed") then
                descendant.Enabled = false;
            end;
        end;

        v9.Parent = u3;

        if u3:IsA("BasePart") and not (u3:IsA("Terrain") or v5) then
            local Size = u3.Size;
            local v10 = u3:FindFirstChildWhichIsA("SpecialMesh");

            if v10 then
                Size = v10.Scale;
            end;

            local Color = u3.Color;
            local Transparency = u3.Transparency;

            if u3:FindFirstChildWhichIsA("SurfaceAppearance") == nil then
                local v11 = u3:FindFirstChildWhichIsA("Decal");

                if v11 then
                    Color = v11.Color3;
                    Transparency = v11.Transparency;
                end;
            end;

            if v4 or v7 then
                local NumberSequence_new = NumberSequence.new;
                local math_min_ret = math.min(u3.Size.X, u3.Size.Y);
                v8:SetAttribute("Thickness", NumberSequence_new((math.max(0.05, math_min_ret))));
            elseif not v6 then
                v8:SetAttribute("SizeX", NumberSequence.new(Size.X));
                v8:SetAttribute("SizeY", NumberSequence.new(Size.Y));
                v8:SetAttribute("SizeZ", NumberSequence.new(Size.Z));
            end;

            v8:SetAttribute("Color", ColorSequence.new(Color));
            v8:SetAttribute("Transparency", NumberSequence.new(Transparency));
        end;

        if u3:IsA("BasePart") then
            for _, child in ipairs(u3:GetChildren()) do
                if child ~= v9 and (child:IsA("SpecialMesh") or (child:IsA("Decal") or child:IsA("Texture"))) then
                    child:Destroy();
                end;
            end;

            u3.Transparency = 1;

            if v6 then
                u3.CanCollide = false;
            end;
        elseif u3:IsA("PointLight") then
            u3.Enabled = false;
        elseif u3:IsA("Highlight") then
            u3.Enabled = false;
        elseif u3:IsA("PostProcessEffect") then
            u3.Enabled = false;
        elseif u3:IsA("ImageLabel") then
            u3.Visible = false;
        end;

        if u3:IsA("PointLight") then
            v8:SetAttribute("Shadows", u3.Shadows);
        end;

        if u3:IsA("BlurEffect") then
            v8:SetAttribute("BlurSize", NumberSequence.new(u3.Size));
        elseif u3:IsA("BloomEffect") then
            v8:SetAttribute("BloomIntensity", NumberSequence.new(u3.Intensity));
            v8:SetAttribute("BloomSize", NumberSequence.new(u3.Size));
            v8:SetAttribute("BloomThreshold", NumberSequence.new(u3.Threshold));
        elseif u3:IsA("ColorCorrectionEffect") then
            v8:SetAttribute("CCBrightness", NumberSequence.new(u3.Brightness));
            v8:SetAttribute("CCContrast", NumberSequence.new(u3.Contrast));
            v8:SetAttribute("CCSaturation", NumberSequence.new(u3.Saturation));
            v8:SetAttribute("CCTintColor", ColorSequence.new(u3.TintColor));
        elseif u3:IsA("Atmosphere") then
            v8:SetAttribute("AtmDensity", NumberSequence.new(u3.Density));
            v8:SetAttribute("AtmOffset", NumberSequence.new(u3.Offset));
            v8:SetAttribute("AtmGlare", NumberSequence.new(u3.Glare));
            v8:SetAttribute("AtmHaze", NumberSequence.new(u3.Haze));
            v8:SetAttribute("AtmColor", ColorSequence.new(u3.Color));
            v8:SetAttribute("AtmDecay", ColorSequence.new(u3.Decay));
        elseif u3:IsA("Highlight") then
            v8:SetAttribute("HLFillColor", ColorSequence.new(u3.FillColor));
            v8:SetAttribute("HLFillTransparency", NumberSequence.new(u3.FillTransparency));
            v8:SetAttribute("HLOutlineColor", ColorSequence.new(u3.OutlineColor));
            v8:SetAttribute("HLOutlineTransparency", NumberSequence.new(u3.OutlineTransparency));
            v8:SetAttribute("HLDepthMode", u3.DepthMode.Name);

            if not u3:FindFirstChild("Adornee") then
                local ObjectValue = Instance.new("ObjectValue");
                ObjectValue.Name = "Adornee";
                ObjectValue.Value = nil;
                ObjectValue.Parent = u3;
            end;
        end;

        if v9:IsA("PostProcessEffect") then
            v9.Enabled = false;
        end;

        if u3:IsA("ImageLabel") then
            if v9:IsA("ImageLabel") then
                v9.Visible = false;
            end;

            if u3.BackgroundTransparency == 0 then
                u3.BackgroundTransparency = 1;
            end;

            v8:SetAttribute("Image", u3.Image);
            v8:SetAttribute("Position", u3.Position);
            v8:SetAttribute("ImgSize", u3.Size);
            v8:SetAttribute("AnchorPoint", u3.AnchorPoint);
            v8:SetAttribute("ZIndex", u3.ZIndex);
            v8:SetAttribute("ScaleType", u3.ScaleType.Name);
            v8:SetAttribute("ResampleMode", u3.ResampleMode.Name);

            if not u3:FindFirstChild("ImageFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "ImageFlipbooks";
                Folder.Parent = u3;
            end;
        end;

        if u3:IsA("BasePart") and not (u3:IsA("Terrain") or (v4 or (v5 or (v6 or (v7 or u3:FindFirstChild("MeshFlipbooks")))))) then
            local Folder = Instance.new("Folder");
            Folder.Name = "MeshFlipbooks";
            Folder.Parent = u3;
        end;

        if u3:IsA("Trail") then
            u3.Enabled = false;

            if v9:IsA("Trail") then
                v9.Enabled = false;
            end;

            if not u3:FindFirstChild("GraphBlender") then
                local Folder = Instance.new("Folder");
                Folder.Name = "GraphBlender";
                local Configuration = Instance.new("Configuration");
                Configuration.Name = "1";
                Configuration:SetAttribute("Time", 0);
                Configuration:SetAttribute("Width", u3.WidthScale or NumberSequence.new(1));
                Configuration:SetAttribute("Transparency", u3.Transparency or NumberSequence.new(0));
                Configuration:SetAttribute("Color", u3.Color or ColorSequence.new(Color3.new(1, 1, 1)));
                Configuration:SetAttribute("_AutoTime", true);
                Configuration.Parent = Folder;
                Folder.Parent = u3;
            end;

            if not u3:FindFirstChild("TrailFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "TrailFlipbooks";
                Folder.Parent = u3;
            end;
        end;

        if u3:IsA("Beam") then
            u3.Enabled = false;
            u3.LightInfluence = 0;

            if v9:IsA("Beam") then
                v9.Enabled = false;
                v9.LightInfluence = 0;
            end;

            if not u3:FindFirstChild("BeamFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "BeamFlipbooks";
                Folder.Parent = u3;
            end;

            v8:SetAttribute("BeamBrightness", NumberSequence.new(u3.Brightness));
            v8:SetAttribute("CurveSize0", NumberSequence.new(u3.CurveSize0));
            v8:SetAttribute("CurveSize1", NumberSequence.new(u3.CurveSize1));
            v8:SetAttribute("Width0", NumberSequence.new(u3.Width0));
            v8:SetAttribute("Width1", NumberSequence.new(u3.Width1));
            v8:SetAttribute("LightEmission", NumberSequence.new(u3.LightEmission));
            v8:SetAttribute("BeamLightInfluence", NumberSequence.new(0));
            v8:SetAttribute("Segments", NumberSequence.new(u3.Segments));
            v8:SetAttribute("TextureLength", NumberSequence.new(u3.TextureLength));
            v8:SetAttribute("TextureSpeed", NumberSequence.new(u3.TextureSpeed));
            v8:SetAttribute("FaceCamera", u3.FaceCamera);
            v8:SetAttribute("ZOffset", u3.ZOffset);
            v8:SetAttribute("BeamTextureMode", u3.TextureMode.Name);
            local Folder = Instance.new("Folder");
            Folder.Name = "GraphBlender";
            local Configuration = Instance.new("Configuration");
            Configuration.Name = "1";
            Configuration:SetAttribute("Time", 0);
            Configuration:SetAttribute("Transparency", u3.Transparency);
            Configuration:SetAttribute("Color", u3.Color);
            Configuration:SetAttribute("_AutoTime", true);
            Configuration.Parent = Folder;
            Folder.Parent = u3;
        end;

        if not u3:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u3;
        end;

        if (u3:IsA("BasePart") or u3:IsA("Attachment")) and not (v4 or (v5 or (v6 or (v7 or u3:FindFirstChild("Link"))))) then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Parent = u3;
        end;

        if u3:IsA("BasePart") and not (v4 or (v5 or (v6 or (v7 or u3:FindFirstChild("AccelTarget"))))) then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "AccelTarget";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u3;
        end;

        if u3:IsA("BasePart") and not (v5 or (v6 or (v7 or u3:FindFirstChild("ShapePart")))) then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "ShapePart";
            ObjectValue.Value = u3;
            ObjectValue.Parent = u3;
        end;

        if (v4 or v7) and not u3:FindFirstChild("Target") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Target";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u3;
        end;

        u3:SetAttribute("Transformed", true);
        u3:SetAttribute("Qwinkle", true);
        u3:SetAttribute("_EvenCycleId", game:GetService("HttpService"):GenerateGUID(false));
        u3:SetAttribute("EmitCount", (u3:IsA("Beam") or (v4 or (v5 or (v6 or v7)))) and 1 or 0);
        u3:SetAttribute("EmitDuration", 0);
        u3:SetAttribute("EmitDelay", 0);
        u3:SetAttribute("IsEmitter", true);

        if u3:IsA("BasePart") or (u3:IsA("Beam") or (u3:IsA("Trail") or u3:IsA("ImageLabel"))) then
            u3:SetAttribute("PreloadTexture", false);
        end;

        u3:SetAttribute("EmissionMode", u3:IsA("Atmosphere") and "Animate" or "Emit");
        u3:SetAttribute("AnimateLoop", false);

        if u3:IsA("BasePart") and not (v4 or (v5 or (v6 or v7))) or (u3:IsA("Beam") or (u3:IsA("Attachment") or u3:IsA("Model"))) then
            u3:SetAttribute("LinkMode", "Follow");
            u3:SetAttribute("LinkSource", "None");
        end;

        pcall(function() -- Line: 343
            -- upvalues: u1 (ref), u3 (copy)
            u1.TransformCompleted:Fire(u3);
        end);
    end;

    function u1.TransformModel(p12, u13, p14) -- Line: 350
        -- upvalues: TypeRegistry (ref), u1 (copy)
        if u13:GetAttribute("Transformed") then
            return;
        end;

        TypeRegistry.createConfig(u13, p14);
        local v15 = u13:Clone();
        v15.Name = "RenderTemplate";

        for _, child in v15:GetChildren() do
            if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or (child.Name == "Link" or child.Name == "AccelTarget")) then
                child:Destroy();
            end;
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop" }) do
            v15:SetAttribute(v, nil);
        end;

        for _, descendant in v15:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.CastShadow = false;
                descendant.Massless = true;
                descendant.Locked = true;
            elseif (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and not descendant:GetAttribute("Transformed") then
                descendant.Enabled = false;
            end;
        end;

        v15.Parent = u13;

        for _, descendant in ipairs(u13:GetDescendants()) do
            if not descendant:IsDescendantOf(v15) then
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                elseif descendant:IsA("SpecialMesh") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                    descendant:Destroy();
                end;
            end;
        end;

        if not u13:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u13;
        end;

        if not u13:FindFirstChild("Link") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Parent = u13;
        end;

        u13:SetAttribute("Transformed", true);
        u13:SetAttribute("Qwinkle", true);
        u13:SetAttribute("EmitCount", 0);
        u13:SetAttribute("EmitDuration", 0);
        u13:SetAttribute("EmitDelay", 0);
        u13:SetAttribute("IsEmitter", true);
        u13:SetAttribute("PreloadTexture", false);
        u13:SetAttribute("EmissionMode", "Emit");
        u13:SetAttribute("AnimateLoop", false);
        u13:SetAttribute("LinkMode", "Follow");
        u13:SetAttribute("LinkSource", "None");
        pcall(function() -- Line: 413
            -- upvalues: u1 (ref), u13 (copy)
            u1.TransformCompleted:Fire(u13);
        end);
    end;
end;