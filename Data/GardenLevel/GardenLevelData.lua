-- Decompiled with Potassium's decompiler.

return {
    GetMaxLevel = function() -- Line: 56, Name: GetMaxLevel
        return 50;
    end,

    CalculateLevel = function(p1: number) -- Line: 13, Name: CalculateLevel
        local math_sqrt_ret = math.sqrt(p1 / 100);

        return math.floor(math_sqrt_ret);
    end,

    CalculateXPForLevel = function(p2: number) -- Line: 6, Name: CalculateXPForLevel
        return p2 ^ 2 * 100;
    end,

    GetXPEarnedCurrentLevel = function(p3: number) -- Line: 46, Name: GetXPEarnedCurrentLevel
        local math_sqrt_ret = math.sqrt(p3 / 100);

        return p3 - math.floor(math_sqrt_ret) ^ 2 * 100;
    end,

    GetTotalXPForNextLevel = function(p4: number) -- Line: 33, Name: GetTotalXPForNextLevel
        local math_sqrt_ret = math.sqrt(p4 / 100);
        local math_floor_ret = math.floor(math_sqrt_ret);

        return (math_floor_ret + 1) ^ 2 * 100 - math_floor_ret ^ 2 * 100;
    end
};