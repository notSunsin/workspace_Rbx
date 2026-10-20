-- Decompiled with Potassium's decompiler.

return {
    MOVEMENT_CONFIG = {
        MOVEMENT_ROUNDING = 1,
        MAX_RAY_DISTANCE = 1000,
        NEAR_ZERO_EPSILON = 0.001,
        Y_HEIGHT_CLAMP = NumberRange.new(-10, 100),
        RAY_SIZE = NumberRange.new(-10, 100)
    },
    ROTATION_CONFIG = {
        ROTATION_ROUNDING_PIXEL = 25,
        ROTATION_STEP_DEGREE = 15
    },
    DEFAULT_PLACEMENT_CONFIG = {
        CFRAME_OFFSET = CFrame.new(0, 0, -5)
    }
};