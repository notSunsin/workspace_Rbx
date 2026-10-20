-- Decompiled with Potassium's decompiler.

local CameraShakeInstance = require(script.Parent.CameraShakeInstance);
local u14 = {
    Bump = function() -- Line: 26, Name: Bump
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v1.RotationInfluence = Vector3.new(1, 1, 1);

        return v1;
    end,

    Damage = function() -- Line: 33, Name: Damage
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(1.5, 4, 0.1, 0.75);
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v2.RotationInfluence = Vector3.new(1, 1, 1);

        return v2;
    end,

    Explosion = function() -- Line: 42, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(5, 10, 0, 1.5);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v3.RotationInfluence = Vector3.new(4, 1, 1);

        return v3;
    end,

    BigExplosion = function() -- Line: 48, Name: BigExplosion
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(10, 15, 0, 1.5);
        v4.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);
        v4.RotationInfluence = Vector3.new(4, 1, 1);

        return v4;
    end,

    AbruptExplosion = function() -- Line: 54, Name: AbruptExplosion
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(5, 10, 0, 1.5);
        v5.PositionInfluence = Vector3.new(2, 0.5, 2);
        v5.RotationInfluence = Vector3.new(4, 1, 1);

        return v5;
    end,

    SmallExplosion = function() -- Line: 60, Name: SmallExplosion
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(5, 10, 0, 0.75);
        v6.PositionInfluence = Vector3.new(2, 0.5, 2);
        v6.RotationInfluence = Vector3.new(4, 1, 1);

        return v6;
    end,

    VerySmallExplosion = function() -- Line: 67, Name: VerySmallExplosion
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(2, 10, 0, 0.75);
        v7.PositionInfluence = Vector3.new(2, 0.5, 2);
        v7.RotationInfluence = Vector3.new(4, 1, 1);

        return v7;
    end,

    Earthquake = function() -- Line: 77, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v8.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v8.RotationInfluence = Vector3.new(1, 1, 4);

        return v8;
    end,

    WeakEarthquake = function() -- Line: 84, Name: WeakEarthquake
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v9.PositionInfluence = Vector3.new(0.05, 0.05, 0.05);
        v9.RotationInfluence = Vector3.new(0.25, 0.25, 1);

        return v9;
    end,

    BadTrip = function() -- Line: 93, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v10.PositionInfluence = Vector3.new(0, 0, 0.15);
        v10.RotationInfluence = Vector3.new(2, 1, 4);

        return v10;
    end,

    HandheldCamera = function() -- Line: 103, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v11 = CameraShakeInstance.new(1, 0.25, 2, 10);
        v11.PositionInfluence = Vector3.new(0.01, 0.01, 0.01);
        v11.RotationInfluence = Vector3.new(0, 0, 0);

        return v11;
    end,

    Vibration = function() -- Line: 113, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v12 = CameraShakeInstance.new(0.4, 20, 2, 2);
        v12.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v12.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v12;
    end,

    RoughDriving = function() -- Line: 123, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v13 = CameraShakeInstance.new(1, 2, 1, 1);
        v13.PositionInfluence = Vector3.new(0, 0, 0);
        v13.RotationInfluence = Vector3.new(1, 1, 1);

        return v13;
    end
};

return setmetatable({}, {
    __index = function(p15, p16) -- Line: 135, Name: __index
        -- upvalues: u14 (copy)
        local v17 = u14[p16];

        if type(v17) == "function" then
            return v17();
        end;

        error("No preset found with index \"" .. p16 .. "\"");
    end
});