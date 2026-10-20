-- Decompiled with Potassium's decompiler.

local v15 = {
    Default = {
        Velocity = Vector3.new(1, 1, 100),
        MinSpeedMult = 0.1,
        MaxSpeedMult = 1.3,
        FadeIn = 0.8,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 1.1,
        TrailLife = 1,

        NoiseStrength = function(p1: number) -- Line: 26, Name: NoiseStrength
            return p1 ^ 2.5;
        end,

        VelocityDrag = function(p2: vector) -- Line: 29, Name: VelocityDrag
            return p2;
        end
    },
    Explosion = {
        Velocity = Vector3.new(1, 1, 300),
        MinSpeedMult = 0.3,
        MaxSpeedMult = 1.3,
        FadeIn = 0.8,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 10,

        NoiseStrength = function(p3) -- Line: 42, Name: NoiseStrength
            return p3 ^ 2;
        end,

        VelocityDrag = function(p4: vector) -- Line: 45, Name: VelocityDrag
            return p4 - Vector3.new(0, 0, 10);
        end
    },
    Swirl = {
        Velocity = Vector3.new(1, 1, 300),
        MinSpeedMult = 0.3,
        MaxSpeedMult = 1.3,
        FadeIn = 0.8,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 14,

        NoiseStrength = function(p5) -- Line: 58, Name: NoiseStrength
            return p5 ^ 2;
        end,

        VelocityDrag = function(p6: vector) -- Line: 61, Name: VelocityDrag
            return p6 - Vector3.new(0, 0, 10);
        end
    },
    Spring = {
        Velocity = Vector3.new(1, 1, 120),
        MinSpeedMult = 0.3,
        MaxSpeedMult = 1.3,
        FadeIn = 0.8,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 1.1,

        NoiseStrength = function(p7) -- Line: 74, Name: NoiseStrength
            return p7 ^ 5;
        end,

        VelocityDrag = function(p8: vector) -- Line: 77, Name: VelocityDrag
            return p8 - Vector3.new(0, 0, 2);
        end
    },
    Line = {
        Velocity = Vector3.new(1, 1, 100),
        MinSpeedMult = 0.3,
        MaxSpeedMult = 1.3,
        FadeIn = 0.8,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 1.5,

        NoiseStrength = function(p9) -- Line: 90, Name: NoiseStrength
            return p9 ^ 2;
        end,

        VelocityDrag = function(p10: vector) -- Line: 93, Name: VelocityDrag
            return p10;
        end
    },
    LineDrag = {
        Velocity = Vector3.new(1, 1, 120),
        MinSpeedMult = 0.3,
        MaxSpeedMult = 1.3,
        FadeIn = 0.8,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 1.5,

        NoiseStrength = function(p11) -- Line: 106, Name: NoiseStrength
            return p11 ^ 2;
        end,

        VelocityDrag = function(p12: vector) -- Line: 109, Name: VelocityDrag
            return p12 - Vector3.new(0, 0, 5);
        end
    },
    Static = {
        Velocity = Vector3.new(0, 0, 0),
        MinSpeedMult = 1,
        MaxSpeedMult = 1,
        FadeIn = 1,
        FadeOut = 1,
        Resolution = 2,
        Contrast = 1.1,

        NoiseStrength = function(p13) -- Line: 122, Name: NoiseStrength
            return p13 ^ 2.5;
        end,

        VelocityDrag = function(p14: vector) -- Line: 125, Name: VelocityDrag
            return p14;
        end
    }
};
setmetatable(v15, {
    __index = function(p16, p17) -- Line: 132, Name: __index
        error(string.format("%q is not a valid member of %q", tostring(p17), script.Name), 2);
    end
});

return v15;