-- Decompiled with Potassium's decompiler.

local function MatClone(p1: table) -- Line: 23
    local table_clone_ret = table.clone(p1);

    for i = 1, #table_clone_ret do
        table_clone_ret[i] = table.clone(table_clone_ret[i]);
        local _ = i;
    end;

    return table_clone_ret;
end;

local function MatZero(p2: number) -- Line: 31
    local table_create_ret = table.create(p2);

    for i = 1, p2 do
        table_create_ret[i] = table.create(p2, 0);
        local _ = i;
    end;

    return table_create_ret;
end;

local function MatIdent(p3: number) -- Line: 39
    -- upvalues: MatZero (copy)
    local v4 = MatZero(p3);

    for i = 1, p3 do
        v4[i][i] = 1;
        local _ = i;
    end;

    return v4;
end;

local function MatMul(p5: table, p6: table) -- Line: 47
    local v7 = #p5[1];
    local v8 = #p6[1];
    local v9 = {};

    for i = 1, #p5 do
        local table_create_ret = table.create(v8, 0);
        local v10 = i;

        for i2 = 1, v8 do
            local v11 = i2;
            local v12 = 0;

            for i3 = 1, v7 do
                local bit32_band_ret = bit32.band(p5[v10][i3], p6[i3][v11]);
                v12 = bit32.bxor(v12, bit32_band_ret);
                local _ = i3;
            end;

            table_create_ret[v11] = v12;
        end;

        v9[v10] = table_create_ret;
    end;

    return v9;
end;

local function MatMulVec(p13: table, p14: table) -- Line: 64
    local v15 = #p13;
    local v16 = #p13[1];
    local table_create_ret = table.create(v15, 0);

    for i = 1, v15 do
        local v17 = i;
        local v18 = 0;

        for i2 = 1, v16 do
            local bit32_band_ret = bit32.band(p13[v17][i2], p14[i2]);
            v18 = bit32.bxor(v18, bit32_band_ret);
            local _ = i2;
        end;

        table_create_ret[v17] = v18;
    end;

    return table_create_ret;
end;

local function MatSum(p19: table, p20: table) -- Line: 77
    -- upvalues: MatZero (copy)
    local v21 = #p19;
    local v22 = #p19[1];
    local v23 = MatZero(v21);

    for i = 1, v21 do
        local v24 = i;

        for i2 = 1, v22 do
            v23[v24][i2] = bit32.bxor(p19[v24][i2], p20[v24][i2]);
            local _ = i2;
        end;
    end;

    return v23;
end;

local function MatInverse(p25: table) -- Line: 88
    -- upvalues: MatClone (copy), MatZero (copy)
    local v26 = #p25;
    local v27 = MatClone(p25);
    local v28 = MatZero(v26);

    for i = 1, v26 do
        v28[i][i] = 1;
        local _ = i;
    end;

    for i = 1, v26 do
        local v29 = i;
        local v30 = nil;

        for i2 = i, v26 do
            if v27[i2][v29] == 1 then
                v30 = i2;
                break;
            end;

            local _ = i2;
        end;

        assert(v30, "not invertible");
        local v31 = v27[v29];
        v27[v29] = v27[v30];
        v27[v30] = v31;
        local v32 = v28[v29];
        v28[v29] = v28[v30];
        v28[v30] = v32;

        for i2 = 1, v26 do
            local v33;

            if i2 == v29 or v27[i2][v29] ~= 1 then
                v33 = i2;
            else
                v33 = i2;

                for i3 = 1, v26 do
                    v27[v33][i3] = bit32.bxor(v27[v33][i3], v27[v29][i3]);
                    v28[v33][i3] = bit32.bxor(v28[v33][i3], v28[v29][i3]);
                    local _ = i3;
                end;
            end;
        end;
    end;

    return v28;
end;

local function MatPow(p34: table, p35: number) -- Line: 115
    -- upvalues: MatZero (copy), MatInverse (copy), MatClone (copy), MatMul (copy)
    local v36 = #p34;
    local v37 = MatZero(v36);

    for i = 1, v36 do
        v37[i][i] = 1;
        local _ = i;
    end;

    local v38;

    if p35 < 0 then
        v38 = MatInverse(p34);
    else
        v38 = MatClone(p34);
    end;

    local math_abs_ret = math.abs(p35);

    while math_abs_ret > 0 do
        if math.fmod(math_abs_ret, 2) >= 0.5 then
            v37 = MatMul(v37, v38);
        end;

        v38 = MatMul(v38, v38);
        math_abs_ret = math.floor(math_abs_ret / 2);
    end;

    return v37;
end;

local function L(p39: number, p40: number) -- Line: 130
    -- upvalues: MatZero (copy)
    local v41 = MatZero(p40);

    for i = 1, p40 - p39 do
        v41[i][i + p39] = 1;
        local _ = i;
    end;

    return v41;
end;

local function R(p42: number, p43: number) -- Line: 138
    -- upvalues: MatZero (copy)
    local v44 = MatZero(p43);

    for i = p42 + 1, p43 do
        v44[i][i - p42] = 1;
        local _ = i;
    end;

    return v44;
end;

local function Embed(p45: table, p46: number, p47: number, p48: number) -- Line: 146
    -- upvalues: MatZero (copy)
    local v49 = MatZero(p46);

    for i = 1, #p45 do
        local v50 = i;

        for i2 = 1, #p45[1] do
            v49[p47 + v50][p48 + i2] = p45[v50][i2];
            local _ = i2;
        end;
    end;

    return v49;
end;

local function ToColumnVector128(p51: number, p52: number, p53: number, p54: number) -- Line: 156
    local table_create_ret = table.create(128, 0);

    for i = 0, 31 do
        local bit32_rshift_ret = bit32.rshift(p51, i);
        table_create_ret[32 - i] = bit32.band(bit32_rshift_ret, 1);
        local bit32_rshift_ret2 = bit32.rshift(p52, i);
        table_create_ret[64 - i] = bit32.band(bit32_rshift_ret2, 1);
        local bit32_rshift_ret3 = bit32.rshift(p53, i);
        table_create_ret[96 - i] = bit32.band(bit32_rshift_ret3, 1);
        local bit32_rshift_ret4 = bit32.rshift(p54, i);
        table_create_ret[128 - i] = bit32.band(bit32_rshift_ret4, 1);
        local _ = i;
    end;

    return table_create_ret;
end;

local function FromColumnVector128(p55: table) -- Line: 167
    local v56 = 0;
    local v57 = 0;
    local v58 = 0;
    local v59 = 0;

    for i = 0, 31 do
        local bit32_lshift_ret = bit32.lshift(p55[32 - i], i);
        v56 = bit32.bor(v56, bit32_lshift_ret);
        local bit32_lshift_ret2 = bit32.lshift(p55[64 - i], i);
        v57 = bit32.bor(v57, bit32_lshift_ret2);
        local bit32_lshift_ret3 = bit32.lshift(p55[96 - i], i);
        v58 = bit32.bor(v58, bit32_lshift_ret3);
        local bit32_lshift_ret4 = bit32.lshift(p55[128 - i], i);
        v59 = bit32.bor(v59, bit32_lshift_ret4);
        local _ = i;
    end;

    return v56, v57, v58, v59;
end;

local u66 = (function() -- Line: 178, Name: BuildMatTransform
    -- upvalues: MatIdent (copy), L (copy), MatMul (copy), MatSum (copy), Embed (copy), R (copy)
    local v60 = MatIdent(32);
    local v61 = MatIdent(128);
    local v62 = MatMul(MatSum(v61, (Embed(L(11, 32), 128, 0, 0))), v61);
    local v63 = MatMul(MatSum(v61, (Embed(R(8, 32), 128, 0, 0))), v62);
    local v64 = MatMul(MatSum(v61, (Embed(v60, 128, 0, 96))), v63);
    local v65 = MatMul(MatSum(v61, (Embed(R(19, 32), 128, 0, 96))), v64);

    return MatMul(MatSum(L(32, 128), (R(96, 128))), v65);
end)();

return table.freeze({
    ToColumnVector128 = ToColumnVector128,
    FromColumnVector128 = FromColumnVector128,

    MatTransform = function() -- Line: 211, Name: MatTransform
        -- upvalues: MatClone (copy), u66 (copy)
        return MatClone(u66);
    end,

    Transform = function(p67: number, p68: number, p69: number, p70: number, p71: number) -- Line: 215, Name: Transform
        -- upvalues: ToColumnVector128 (copy), MatMulVec (copy), MatPow (copy), MatClone (copy), u66 (copy), FromColumnVector128 (copy)
        local v72 = ToColumnVector128(p67, p68, p69, p70);

        return FromColumnVector128((MatMulVec(MatPow(MatClone(u66), p71), v72)));
    end
});