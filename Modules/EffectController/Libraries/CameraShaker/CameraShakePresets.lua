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

    Dash = function() -- Line: 35, Name: Dash
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(1.5, 2, 0.1, 0.75);
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v2.RotationInfluence = Vector3.new(1, 1, 1);

        return v2;
    end,

    Explosion = function() -- Line: 44, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(1.75, 9, 0, 1.25);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v3.RotationInfluence = Vector3.new(4, 1, 1);

        return v3;
    end,

    BlowUp = function() -- Line: 53, Name: BlowUp
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(5, 10, 0.05, 0.75);
        v4.PositionInfluence = Vector3.new(0.1, 0.1, 0.1);
        v4.RotationInfluence = Vector3.new(1, 0.5, 0.85);

        return v4;
    end,

    HeavilyHurt = function() -- Line: 63, Name: HeavilyHurt
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(3, 8, 0.05, 0.85);
        v5.PositionInfluence = Vector3.new(0.18, 0.15, 0.15);
        v5.RotationInfluence = Vector3.new(0.86, 0.56, 0.63);

        return v5;
    end,

    WindBreak = function() -- Line: 73, Name: WindBreak
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(6, 5, 0.05, 0.5);
        v6.PositionInfluence = Vector3.new(0.08, 0.08, 0.08);
        v6.RotationInfluence = Vector3.new(0.45, 0.3, 0.35);

        return v6;
    end,

    Shoot = function() -- Line: 83, Name: Shoot
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(2, 6, 0.05, 0.65);
        v7.PositionInfluence = Vector3.new(0.05, 0.05, 0.125);
        v7.RotationInfluence = Vector3.new(0.6, 0.6, 0.6);

        return v7;
    end,

    M1 = function() -- Line: 92, Name: M1
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(0.5, 6, 0.05, 0.65);
        v8.PositionInfluence = Vector3.new(0.05, 0.05, 0.125);
        v8.RotationInfluence = Vector3.new(0.6, 0.6, 0.6);

        return v8;
    end,

    Earthquake = function() -- Line: 101, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v9.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v9.RotationInfluence = Vector3.new(1, 1, 4);

        return v9;
    end,

    BadTrip = function() -- Line: 111, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v10.PositionInfluence = Vector3.new(0, 0, 0.15);
        v10.RotationInfluence = Vector3.new(2, 1, 4);

        return v10;
    end,

    HandheldCamera = function() -- Line: 121, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v11 = CameraShakeInstance.new(1, 0.25, 5, 10);
        v11.PositionInfluence = Vector3.new(0, 0, 0);
        v11.RotationInfluence = Vector3.new(1, 0.5, 0.5);

        return v11;
    end,

    Vibration = function() -- Line: 131, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v12 = CameraShakeInstance.new(2, 20, 0, 0.2);
        v12.PositionInfluence = Vector3.new(0.25, 0.15, 0);
        v12.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v12;
    end,

    RoughDriving = function() -- Line: 141, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v13 = CameraShakeInstance.new(1, 2, 1, 1);
        v13.PositionInfluence = Vector3.new(0, 0, 0);
        v13.RotationInfluence = Vector3.new(1, 1, 1);

        return v13;
    end
};

return setmetatable({}, {
    __index = function(p15, p16) -- Line: 153, Name: __index
        -- upvalues: u14 (copy)
        local v17 = u14[p16];

        if type(v17) == "function" then
            return v17();
        end;

        error("No preset found with index \"" .. p16 .. "\"");
    end
});