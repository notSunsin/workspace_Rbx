-- Decompiled with Potassium's decompiler.

local function mult(p1: number, p2: number) -- Line: 37
    local v3 = bit32.band(p1, 65535) * p2;
    local v4 = bit32.rshift(p1, 16) * p2;
    local bit32_band_ret = bit32.band(v4, 65535);

    return v3 + bit32.lshift(bit32_band_ret, 16);
end;

return function(p5: string, p6: number?) -- Line: 50, Name: xxhash32
    local v7 = p6 == nil and 0 or bit32.bor(p6, 0);
    local v8 = #p5;
    local v9 = 1;
    local v10 = 1;
    local v11;

    if v8 >= 16 then
        local v12 = v7 + 2654435761 + 2246822519;
        local v13 = v7 + 2246822519;
        local v14 = v7 - 2654435761;

        for i = 0, v8 - 16, 16 do
            local string_byte_ret, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29 = string.byte(p5, v10, v10 + 15);
            local bit32_lshift_ret = bit32.lshift(v17, 24);
            local bit32_lshift_ret2 = bit32.lshift(v16, 16);
            local bit32_lshift_ret3 = bit32.lshift(v15, 8);
            local bit32_bor_ret = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, string_byte_ret);
            local v30 = bit32.band(bit32_bor_ret, 65535) * 2246822519;
            local v31 = bit32.rshift(bit32_bor_ret, 16) * 2246822519;
            local bit32_band_ret = bit32.band(v31, 65535);
            local v32 = v12 + (v30 + bit32.lshift(bit32_band_ret, 16));
            local bit32_lrotate_ret = bit32.lrotate(v32, 13);
            local v33 = bit32.band(bit32_lrotate_ret, 65535) * 2654435761;
            local v34 = bit32.rshift(bit32_lrotate_ret, 16) * 2654435761;
            local bit32_band_ret2 = bit32.band(v34, 65535);
            v12 = v33 + bit32.lshift(bit32_band_ret2, 16);
            local bit32_lshift_ret4 = bit32.lshift(v21, 24);
            local bit32_lshift_ret5 = bit32.lshift(v20, 16);
            local bit32_lshift_ret6 = bit32.lshift(v19, 8);
            local bit32_bor_ret2 = bit32.bor(bit32_lshift_ret4, bit32_lshift_ret5, bit32_lshift_ret6, v18);
            local v35 = bit32.band(bit32_bor_ret2, 65535) * 2246822519;
            local v36 = bit32.rshift(bit32_bor_ret2, 16) * 2246822519;
            local bit32_band_ret3 = bit32.band(v36, 65535);
            local v37 = v13 + (v35 + bit32.lshift(bit32_band_ret3, 16));
            local bit32_lrotate_ret2 = bit32.lrotate(v37, 13);
            local v38 = bit32.band(bit32_lrotate_ret2, 65535) * 2654435761;
            local v39 = bit32.rshift(bit32_lrotate_ret2, 16) * 2654435761;
            local bit32_band_ret4 = bit32.band(v39, 65535);
            v13 = v38 + bit32.lshift(bit32_band_ret4, 16);
            local bit32_lshift_ret7 = bit32.lshift(v25, 24);
            local bit32_lshift_ret8 = bit32.lshift(v24, 16);
            local bit32_lshift_ret9 = bit32.lshift(v23, 8);
            local bit32_bor_ret3 = bit32.bor(bit32_lshift_ret7, bit32_lshift_ret8, bit32_lshift_ret9, v22);
            local v40 = bit32.band(bit32_bor_ret3, 65535) * 2246822519;
            local v41 = bit32.rshift(bit32_bor_ret3, 16) * 2246822519;
            local bit32_band_ret5 = bit32.band(v41, 65535);
            local v42 = v7 + (v40 + bit32.lshift(bit32_band_ret5, 16));
            local bit32_lrotate_ret3 = bit32.lrotate(v42, 13);
            local v43 = bit32.band(bit32_lrotate_ret3, 65535) * 2654435761;
            local v44 = bit32.rshift(bit32_lrotate_ret3, 16) * 2654435761;
            local bit32_band_ret6 = bit32.band(v44, 65535);
            v7 = v43 + bit32.lshift(bit32_band_ret6, 16);
            local bit32_lshift_ret10 = bit32.lshift(v29, 24);
            local bit32_lshift_ret11 = bit32.lshift(v28, 16);
            local bit32_lshift_ret12 = bit32.lshift(v27, 8);
            local bit32_bor_ret4 = bit32.bor(bit32_lshift_ret10, bit32_lshift_ret11, bit32_lshift_ret12, v26);
            local v45 = bit32.band(bit32_bor_ret4, 65535) * 2246822519;
            local v46 = bit32.rshift(bit32_bor_ret4, 16) * 2246822519;
            local bit32_band_ret7 = bit32.band(v46, 65535);
            local v47 = v14 + (v45 + bit32.lshift(bit32_band_ret7, 16));
            local bit32_lrotate_ret4 = bit32.lrotate(v47, 13);
            local v48 = bit32.band(bit32_lrotate_ret4, 65535) * 2654435761;
            local v49 = bit32.rshift(bit32_lrotate_ret4, 16) * 2654435761;
            local bit32_band_ret8 = bit32.band(v49, 65535);
            v14 = v48 + bit32.lshift(bit32_band_ret8, 16);
            v9 = v9 + 4;
            v10 = v10 + 16;
            local _ = i;
        end;

        v11 = bit32.lrotate(v12, 1) + bit32.lrotate(v13, 7) + bit32.lrotate(v7, 12) + bit32.lrotate(v14, 18);
    else
        v11 = bit32.bor(v7 + 374761393, 0);
    end;

    local bit32_bor_ret = bit32.bor(v11 + v8, 0);

    for i = v9, v8 // 4 do
        local string_byte_ret, v50, v51, v52 = string.byte(p5, v10, v10 + 3);
        local bit32_lshift_ret = bit32.lshift(v52, 24);
        local bit32_lshift_ret2 = bit32.lshift(v51, 16);
        local bit32_lshift_ret3 = bit32.lshift(v50, 8);
        local bit32_bor_ret2 = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, string_byte_ret);
        local v53 = bit32.band(bit32_bor_ret2, 65535) * 3266489917;
        local v54 = bit32.rshift(bit32_bor_ret2, 16) * 3266489917;
        local bit32_band_ret = bit32.band(v54, 65535);
        local v55 = bit32_bor_ret + (v53 + bit32.lshift(bit32_band_ret, 16));
        local bit32_lrotate_ret = bit32.lrotate(v55, 17);
        local v56 = bit32.band(bit32_lrotate_ret, 65535) * 668265263;
        local v57 = bit32.rshift(bit32_lrotate_ret, 16) * 668265263;
        local bit32_band_ret2 = bit32.band(v57, 65535);
        bit32_bor_ret = v56 + bit32.lshift(bit32_band_ret2, 16);
        v9 = v9 + 1;
        v10 = v10 + 4;
        local _ = i;
    end;

    for i = -(v8 % 4), -1 do
        local string_byte_ret = string.byte(p5, i);
        local v58 = bit32.band(string_byte_ret, 65535) * 374761393;
        local v59 = bit32.rshift(string_byte_ret, 16) * 374761393;
        local bit32_band_ret = bit32.band(v59, 65535);
        local v60 = bit32_bor_ret + (v58 + bit32.lshift(bit32_band_ret, 16));
        local bit32_lrotate_ret = bit32.lrotate(v60, 11);
        local v61 = bit32.band(bit32_lrotate_ret, 65535) * 2654435761;
        local v62 = bit32.rshift(bit32_lrotate_ret, 16) * 2654435761;
        local bit32_band_ret2 = bit32.band(v62, 65535);
        bit32_bor_ret = v61 + bit32.lshift(bit32_band_ret2, 16);
        local _ = i;
    end;

    local bit32_rshift_ret = bit32.rshift(bit32_bor_ret, 15);
    local bit32_bxor_ret = bit32.bxor(bit32_bor_ret, bit32_rshift_ret);
    local v63 = bit32.band(bit32_bxor_ret, 65535) * 2246822519;
    local v64 = bit32.rshift(bit32_bxor_ret, 16) * 2246822519;
    local bit32_band_ret = bit32.band(v64, 65535);
    local v65 = v63 + bit32.lshift(bit32_band_ret, 16);
    local bit32_rshift_ret2 = bit32.rshift(v65, 13);
    local bit32_bxor_ret2 = bit32.bxor(v65, bit32_rshift_ret2);
    local v66 = bit32.band(bit32_bxor_ret2, 65535) * 3266489917;
    local v67 = bit32.rshift(bit32_bxor_ret2, 16) * 3266489917;
    local bit32_band_ret2 = bit32.band(v67, 65535);
    local v68 = v66 + bit32.lshift(bit32_band_ret2, 16);
    local bit32_rshift_ret3 = bit32.rshift(v68, 16);

    return bit32.bxor(v68, bit32_rshift_ret3);
end;