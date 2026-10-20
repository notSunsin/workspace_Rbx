-- Decompiled with Potassium's decompiler.

return {
    HueShiftRandom = function(p1: userdata, p2, p3: number, p4: number) -- Line: 4, Name: HueShiftRandom
        local v5, v6, v7 = p2:ToHSV();
        local v8 = p3 or -0.05;
        local v9 = v5 + p1:NextNumber(v8, p4 or -v8);
        local math_clamp_ret = math.clamp(v9, 0.01, 0.99);

        return Color3.fromHSV(math_clamp_ret, v6, v7), math_clamp_ret, v6, v7;
    end,

    ValShiftRandom = function(p10: userdata, p11, p12: number, p13: number) -- Line: 18, Name: ValShiftRandom
        local v14, v15, v16 = p11:ToHSV();
        local v17 = p12 or -0.05;
        local v18 = v16 + p10:NextNumber(v17, p13 or -v17);
        local math_clamp_ret = math.clamp(v18, 0.01, 0.99);

        return Color3.fromHSV(v14, v15, math_clamp_ret), v14, v15, math_clamp_ret;
    end,

    SatShiftRandom = function(p19: userdata, p20, p21: number, p22: number) -- Line: 32, Name: SatShiftRandom
        local v23, v24, v25 = p20:ToHSV();
        local v26 = p21 or -0.05;
        local v27 = v24 + p19:NextNumber(v26, p22 or -v26);
        local math_clamp_ret = math.clamp(v27, 0.01, 0.99);

        return Color3.fromHSV(v23, math_clamp_ret, v25), v23, math_clamp_ret, v25;
    end,

    RandomiseValueByPercent = function(p28: userdata, p29: number, p30: number) -- Line: 48, Name: RandomiseValueByPercent
        local v31 = p30 / 100;

        return p29 + p29 * (p28:NextNumber() * v31 * 2 - v31);
    end,

    CreateRandomAngleRad = function(p32: userdata, p33: number) -- Line: 55, Name: CreateRandomAngleRad
        local v34 = p32:NextNumber() * p33 - p33 / 2;

        return math.rad(v34);
    end
};