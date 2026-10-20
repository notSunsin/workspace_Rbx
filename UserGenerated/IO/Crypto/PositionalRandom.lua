-- Decompiled with Potassium's decompiler.

local function Mix(p1: number, p2: number, p3: number) -- Line: 20
    local bit32_bor_ret = bit32.bor(p1, 0);
    local bit32_bor_ret2 = bit32.bor(p2, 0);
    local bit32_bor_ret3 = bit32.bor(p3, 0);
    local bit32_rshift_ret = bit32.rshift(bit32_bor_ret3, 13);
    local bit32_bxor_ret = bit32.bxor(bit32_bor_ret - bit32_bor_ret2 - bit32_bor_ret3, bit32_rshift_ret);
    local bit32_lshift_ret = bit32.lshift(bit32_bxor_ret, 8);
    local bit32_bxor_ret2 = bit32.bxor(bit32_bor_ret2 - bit32_bor_ret3 - bit32_bxor_ret, bit32_lshift_ret);
    local bit32_rshift_ret2 = bit32.rshift(bit32_bxor_ret2, 13);
    local bit32_bxor_ret3 = bit32.bxor(bit32_bor_ret3 - bit32_bxor_ret - bit32_bxor_ret2, bit32_rshift_ret2);
    local bit32_rshift_ret3 = bit32.rshift(bit32_bxor_ret3, 12);
    local bit32_bxor_ret4 = bit32.bxor(bit32_bxor_ret - bit32_bxor_ret2 - bit32_bxor_ret3, bit32_rshift_ret3);
    local bit32_lshift_ret2 = bit32.lshift(bit32_bxor_ret4, 16);
    local bit32_bxor_ret5 = bit32.bxor(bit32_bxor_ret2 - bit32_bxor_ret3 - bit32_bxor_ret4, bit32_lshift_ret2);
    local bit32_rshift_ret4 = bit32.rshift(bit32_bxor_ret5, 5);
    local bit32_bxor_ret6 = bit32.bxor(bit32_bxor_ret3 - bit32_bxor_ret4 - bit32_bxor_ret5, bit32_rshift_ret4);
    local bit32_rshift_ret5 = bit32.rshift(bit32_bxor_ret6, 3);
    local bit32_bxor_ret7 = bit32.bxor(bit32_bxor_ret4 - bit32_bxor_ret5 - bit32_bxor_ret6, bit32_rshift_ret5);
    local bit32_lshift_ret3 = bit32.lshift(bit32_bxor_ret7, 10);
    local bit32_bxor_ret8 = bit32.bxor(bit32_bxor_ret5 - bit32_bxor_ret6 - bit32_bxor_ret7, bit32_lshift_ret3);
    local bit32_rshift_ret6 = bit32.rshift(bit32_bxor_ret8, 15);

    return bit32.bxor(bit32_bxor_ret6 - bit32_bxor_ret7 - bit32_bxor_ret8, bit32_rshift_ret6);
end;

local function Unpack64(p4: number) -- Line: 52
    if p4 >= 0 then
        return bit32.bor(p4 // 4294967296, 0), bit32.bor(p4, 0);
    end;

    local v5 = -1 - p4;

    return bit32.bnot(v5 // 4294967296), bit32.bnot(v5);
end;

local function ParseUUID(p6: string) -- Line: 65
    local string_sub_ret = string.sub(p6, 1, 8);
    local v7 = tonumber(string_sub_ret, 16);
    local v8 = string.sub(p6, 10, 13) .. string.sub(p6, 15, 18);
    local v9 = tonumber(v8, 16);
    local v10 = string.sub(p6, 20, 23) .. string.sub(p6, 25, 28);
    local v11 = tonumber(v10, 16);
    local string_sub_ret2 = string.sub(p6, 29, 36);

    return v7, v9, v11, tonumber(string_sub_ret2, 16);
end;

return table.freeze({
    Mix = Mix,

    DoubleFromInt64 = function(p12: number, p13: number) -- Line: 60, Name: DoubleFromInt64
        -- upvalues: Mix (copy)
        local v14, v15;

        if p12 < 0 then
            local v16 = -1 - p12;
            v14 = bit32.bnot(v16 // 4294967296);
            v15 = bit32.bnot(v16);
        else
            v14 = bit32.bor(p12 // 4294967296, 0);
            v15 = bit32.bor(p12, 0);
        end;

        return Mix(v15, v14, p13) / 4294967296;
    end,

    DoubleFromUUID = function(p17: string, p18: number) -- Line: 71, Name: DoubleFromUUID
        -- upvalues: Mix (copy)
        local string_sub_ret = string.sub(p17, 1, 8);
        local v19 = tonumber(string_sub_ret, 16);
        local v20 = string.sub(p17, 10, 13) .. string.sub(p17, 15, 18);
        local v21 = tonumber(v20, 16);
        local v22 = string.sub(p17, 20, 23) .. string.sub(p17, 25, 28);
        local v23 = tonumber(v22, 16);
        local string_sub_ret2 = string.sub(p17, 29, 36);
        local v24 = tonumber(string_sub_ret2, 16);

        return Mix(Mix(v19, v21, 2197175160), Mix(v23, v24, 2821953579), p18) / 4294967296;
    end,

    IntegerFromUUID = function(p25: string, p26: number, p27: number, p28: number) -- Line: 76, Name: IntegerFromUUID
        -- upvalues: Mix (copy)
        local string_sub_ret = string.sub(p25, 1, 8);
        local v29 = tonumber(string_sub_ret, 16);
        local v30 = string.sub(p25, 10, 13) .. string.sub(p25, 15, 18);
        local v31 = tonumber(v30, 16);
        local v32 = string.sub(p25, 20, 23) .. string.sub(p25, 25, 28);
        local v33 = tonumber(v32, 16);
        local string_sub_ret2 = string.sub(p25, 29, 36);
        local v34 = tonumber(string_sub_ret2, 16);
        local v35 = p27 + (p28 - p27 + 1) * (Mix(Mix(v29, v31, 2197175160), Mix(v33, v34, 2821953579), p26) / 4294967296);

        return math.floor(v35);
    end
});