-- Decompiled with Potassium's decompiler.

return {
    LightEffectPart = function(p1) -- Line: 2, Name: LightEffectPart
        return {
            OffTransparency = 0.25,
            OffReflectance = 0.25,
            Part = p1,
            OnColor = p1.Color,
            OnMaterial = p1.Material,
            OnTransparency = p1.Transparency,
            OnReflectance = p1.Reflectance,
            OffColor = Color3.fromRGB(12, 11, 7),
            OffMaterial = Enum.Material.SmoothPlastic
        };
    end,

    LightEffectParticles = function(p2) -- Line: 17, Name: LightEffectParticles
        return {
            OffLightEmission = 0,
            Emitter = p2,
            OnLightEmission = p2.LightEmission
        };
    end,

    LightEffectSource = function(p3) -- Line: 25, Name: LightEffectSource
        return {
            Light = p3,
            OnColor = p3.Color,
            OffColor = p3.Color
        };
    end,

    ParticleEffectAttachment = function(p4) -- Line: 33, Name: ParticleEffectAttachment
        return p4;
    end,

    SwingEffectModel = function(p5) -- Line: 37, Name: SwingEffectModel
        return p5;
    end,

    CustomEffectImagePart = function(p6) -- Line: 41, Name: CustomEffectImagePart
        return {
            ImgPart = p6,
            Decal = p6.Decal,
            SurfaceGui = p6.SurfaceGui,
            SurfaceLight = p6.SurfaceLight
        };
    end
};