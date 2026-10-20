-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local table_create_ret = table.create(80, 0);
local table_create_ret2 = table.create(80, 0);
local u1 = { 1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748, 2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206, 2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891, 3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771, 3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452, 2361852424, 2428436474, 2756734187, 3204031479, 3329325298, 3391569614, 3515267271, 3940187606, 4118630271, 116418474, 174292421, 289380356, 460393269, 685471733, 852142971, 1017036298, 1126000580, 1288033470, 1501505948, 1607167915, 1816402316 };
local u2 = { 3609767458, 602891725, 3964484399, 2173295548, 4081628472, 3053834265, 2937671579, 3664609560, 2734883394, 1164996542, 1323610764, 3590304994, 4068182383, 991336113, 633803317, 3479774868, 2666613458, 944711139, 2341262773, 2007800933, 1495990901, 1856431235, 3175218132, 2198950837, 3999719339, 766784016, 2566594879, 3203337956, 1034457026, 2466948901, 3758326383, 168717936, 1188179964, 1546045734, 1522805485, 2643833823, 2343527390, 1014477480, 1206759142, 344077627, 1290863460, 3158454273, 3505952657, 106217008, 3606008344, 1432725776, 1467031594, 851169720, 3100823752, 1363258195, 3750685593, 3785050280, 3318307427, 3812723403, 2003034995, 3602036899, 1575990012, 1125592928, 2716904306, 442776044, 593698344, 3733110249, 2999351573, 3815920427, 3928383900, 566280711, 3454069534, 4000239992, 1914138554, 2731055270, 3203993006, 320620315, 587496836, 1086792851, 365543100, 2618297676, 3409855158, 4234509866, 987167468, 1246189591 };

function lil_sig0(p3: number, p4: number)
    local bit32_rshift_ret = bit32.rshift(p3, 1);
    local bit32_lshift_ret = bit32.lshift(p4, 31);
    local bit32_rshift_ret2 = bit32.rshift(p3, 8);
    local bit32_lshift_ret2 = bit32.lshift(p4, 24);
    local bit32_rshift_ret3 = bit32.rshift(p3, 7);
    local bit32_bxor_ret = bit32.bxor(bit32_rshift_ret, bit32_lshift_ret, bit32_rshift_ret2, bit32_lshift_ret2, bit32_rshift_ret3);
    local bit32_rshift_ret4 = bit32.rshift(p4, 1);
    local bit32_lshift_ret3 = bit32.lshift(p3, 31);
    local bit32_rshift_ret5 = bit32.rshift(p4, 8);
    local bit32_lshift_ret4 = bit32.lshift(p3, 24);
    local bit32_rshift_ret6 = bit32.rshift(p4, 7);
    local bit32_lshift_ret5 = bit32.lshift(p3, 25);

    return bit32_bxor_ret, bit32.bxor(bit32_rshift_ret4, bit32_lshift_ret3, bit32_rshift_ret5, bit32_lshift_ret4, bit32_rshift_ret6, bit32_lshift_ret5);
end;

function lil_sig1(p5: number, p6: number)
    local bit32_rshift_ret = bit32.rshift(p5, 19);
    local bit32_lshift_ret = bit32.lshift(p6, 13);
    local bit32_lshift_ret2 = bit32.lshift(p5, 3);
    local bit32_rshift_ret2 = bit32.rshift(p6, 29);
    local bit32_rshift_ret3 = bit32.rshift(p5, 6);
    local bit32_bxor_ret = bit32.bxor(bit32_rshift_ret, bit32_lshift_ret, bit32_lshift_ret2, bit32_rshift_ret2, bit32_rshift_ret3);
    local bit32_rshift_ret4 = bit32.rshift(p6, 19);
    local bit32_lshift_ret3 = bit32.lshift(p5, 13);
    local bit32_lshift_ret4 = bit32.lshift(p6, 3);
    local bit32_rshift_ret5 = bit32.rshift(p5, 29);
    local bit32_rshift_ret6 = bit32.rshift(p6, 6);
    local bit32_lshift_ret5 = bit32.lshift(p5, 26);

    return bit32_bxor_ret, bit32.bxor(bit32_rshift_ret4, bit32_lshift_ret3, bit32_lshift_ret4, bit32_rshift_ret5, bit32_rshift_ret6, bit32_lshift_ret5);
end;

function big_sig0(p7: number, p8: number)
    local bit32_rshift_ret = bit32.rshift(p7, 28);
    local bit32_lshift_ret = bit32.lshift(p8, 4);
    local bit32_lshift_ret2 = bit32.lshift(p7, 30);
    local bit32_rshift_ret2 = bit32.rshift(p8, 2);
    local bit32_lshift_ret3 = bit32.lshift(p7, 25);
    local bit32_rshift_ret3 = bit32.rshift(p8, 7);
    local bit32_bxor_ret = bit32.bxor(bit32_rshift_ret, bit32_lshift_ret, bit32_lshift_ret2, bit32_rshift_ret2, bit32_lshift_ret3, bit32_rshift_ret3);
    local bit32_rshift_ret4 = bit32.rshift(p8, 28);
    local bit32_lshift_ret4 = bit32.lshift(p7, 4);
    local bit32_lshift_ret5 = bit32.lshift(p8, 30);
    local bit32_rshift_ret5 = bit32.rshift(p7, 2);
    local bit32_lshift_ret6 = bit32.lshift(p8, 25);
    local bit32_rshift_ret6 = bit32.rshift(p7, 7);

    return bit32_bxor_ret, bit32.bxor(bit32_rshift_ret4, bit32_lshift_ret4, bit32_lshift_ret5, bit32_rshift_ret5, bit32_lshift_ret6, bit32_rshift_ret6);
end;

function big_sig1(p9: number, p10: number)
    local bit32_rshift_ret = bit32.rshift(p9, 14);
    local bit32_lshift_ret = bit32.lshift(p10, 18);
    local bit32_rshift_ret2 = bit32.rshift(p9, 18);
    local bit32_lshift_ret2 = bit32.lshift(p10, 14);
    local bit32_lshift_ret3 = bit32.lshift(p9, 23);
    local bit32_rshift_ret3 = bit32.rshift(p10, 9);
    local bit32_bxor_ret = bit32.bxor(bit32_rshift_ret, bit32_lshift_ret, bit32_rshift_ret2, bit32_lshift_ret2, bit32_lshift_ret3, bit32_rshift_ret3);
    local bit32_rshift_ret4 = bit32.rshift(p10, 14);
    local bit32_lshift_ret4 = bit32.lshift(p9, 18);
    local bit32_rshift_ret5 = bit32.rshift(p10, 18);
    local bit32_lshift_ret5 = bit32.lshift(p9, 14);
    local bit32_lshift_ret6 = bit32.lshift(p10, 23);
    local bit32_rshift_ret6 = bit32.rshift(p9, 9);

    return bit32_bxor_ret, bit32.bxor(bit32_rshift_ret4, bit32_lshift_ret4, bit32_rshift_ret5, bit32_lshift_ret5, bit32_lshift_ret6, bit32_rshift_ret6);
end;

function processBlocks(p11: table, p12: table, p13: string, p14: number, p15: number)
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy), u2 (copy), u1 (copy)
    local v16 = table_create_ret;
    local v17 = table_create_ret2;
    local v18 = p11[1];
    local v19 = p11[2];
    local v20 = p11[3];
    local v21 = p11[4];
    local v22 = p11[5];
    local v23 = p11[6];
    local v24 = p11[7];
    local v25 = p11[8];
    local v26 = p12[1];
    local v27 = p12[2];
    local v28 = p12[3];
    local v29 = p12[4];
    local v30 = p12[5];
    local v31 = p12[6];
    local v32 = p12[7];
    local v33 = p12[8];

    for i = p14, p15, 128 do
        local v34 = i;
        local v35 = v34;
        local v36 = v34;
        v34 = v35;
        v36 = v35;

        for i2 = 1, 16 do
            local string_byte_ret, v37, v38, v39, v40, v41, v42, v43 = string.byte(p13, v35, v35 + 7);
            local bit32_lshift_ret = bit32.lshift(string_byte_ret, 24);
            local bit32_lshift_ret2 = bit32.lshift(v37, 16);
            local bit32_lshift_ret3 = bit32.lshift(v38, 8);
            v16[i2] = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, v39);
            local bit32_lshift_ret4 = bit32.lshift(v40, 24);
            local bit32_lshift_ret5 = bit32.lshift(v41, 16);
            local bit32_lshift_ret6 = bit32.lshift(v42, 8);
            v17[i2] = bit32.bor(bit32_lshift_ret4, bit32_lshift_ret5, bit32_lshift_ret6, v43);
            v35 = v35 + 8;
            local _ = i2;
        end;

        for i2 = 17, 80 do
            local v44, v45 = lil_sig0(v16[i2 - 15], v17[i2 - 15]);
            local v46, v47 = lil_sig1(v16[i2 - 2], v17[i2 - 2]);
            local v48 = v17[i2 - 16] + v45 + v17[i2 - 7] + v47;
            v17[i2] = bit32.bor(v48, 0);
            v16[i2] = v16[i2 - 16] + v44 + v16[i2 - 7] + v46 + v48 // 4294967296;
            local _ = i2;
        end;

        local v49 = v27;
        local v50 = v18;
        local v51 = v23;
        local v52 = v22;
        local v53 = v25;
        local v54 = v32;
        local v55 = v26;
        local v56 = v29;
        local v57 = v20;
        local v58 = v28;
        local v59 = v31;
        local v60 = v21;
        local v61 = v19;
        local v62 = v33;
        local v63 = v24;
        local v64 = v30;

        for i2 = 1, 80 do
            local v65, v66 = big_sig0(v18, v26);
            local v67, v68 = big_sig1(v22, v30);
            local bit32_band_ret = bit32.band(v30, v31);
            local bit32_band_ret2 = bit32.band(-1 - v30, v32);
            local v69 = v33 + v68 + bit32.bor(bit32_band_ret, bit32_band_ret2, 0) + u2[i2] + v17[i2];
            local bit32_band_ret3 = bit32.band(v22, v23);
            local bit32_band_ret4 = bit32.band(-1 - v22, v24);
            local v70 = v25 + v67 + bit32.bor(bit32_band_ret3, bit32_band_ret4, 0) + u1[i2] + v16[i2] + v69 // 4294967296;
            local bit32_bor_ret = bit32.bor(v69, 0);
            local v71 = v66 + bit32.band(v28, v27);
            local bit32_bxor_ret = bit32.bxor(v28, v27);
            local v72 = v71 + bit32.band(v26, bit32_bxor_ret);
            local v73 = v65 + bit32.band(v20, v19);
            local bit32_bxor_ret2 = bit32.bxor(v20, v19);
            local v74 = v73 + bit32.band(v18, bit32_bxor_ret2);
            local v75 = bit32_bor_ret + v29;
            local bit32_bor_ret2 = bit32.bor(v75, 0);
            local v76 = bit32_bor_ret + v72;
            local bit32_bor_ret3 = bit32.bor(v76, 0);
            v33 = v32;
            v32 = v31;
            v31 = v30;
            v30 = bit32_bor_ret2;
            v25 = v24;
            v24 = v23;
            v23 = v22;
            v22 = v70 + v21 + v75 // 4294967296;
            v21 = v20;
            v20 = v19;
            v19 = v18;
            v18 = v70 + v74 + v76 // 4294967296;
            v29 = v28;
            v28 = v27;
            v27 = v26;
            v26 = bit32_bor_ret3;
            local _ = i2;
        end;

        local v77 = v55 + v26;
        v18 = bit32.bor(v50 + v18 + v77 // 4294967296, 0);
        v26 = bit32.bor(v77, 0);
        local v78 = v49 + v27;
        v19 = bit32.bor(v61 + v19 + v78 // 4294967296, 0);
        v27 = bit32.bor(v78, 0);
        local v79 = v58 + v28;
        v20 = bit32.bor(v57 + v20 + v79 // 4294967296, 0);
        v28 = bit32.bor(v79, 0);
        local v80 = v56 + v29;
        v21 = bit32.bor(v60 + v21 + v80 // 4294967296, 0);
        v29 = bit32.bor(v80, 0);
        local v81 = v64 + v30;
        v22 = bit32.bor(v52 + v22 + v81 // 4294967296, 0);
        v30 = bit32.bor(v81, 0);
        local v82 = v59 + v31;
        v23 = bit32.bor(v51 + v23 + v82 // 4294967296, 0);
        v31 = bit32.bor(v82, 0);
        local v83 = v54 + v32;
        v24 = bit32.bor(v63 + v24 + v83 // 4294967296, 0);
        v32 = bit32.bor(v83, 0);
        local v84 = v62 + v33;
        v25 = bit32.bor(v53 + v25 + v84 // 4294967296, 0);
        v33 = bit32.bor(v84, 0);
    end;

    p11[1] = v18;
    p12[1] = v26;
    p11[2] = v19;
    p12[2] = v27;
    p11[3] = v20;
    p12[3] = v28;
    p11[4] = v21;
    p12[4] = v29;
    p11[5] = v22;
    p12[5] = v30;
    p11[6] = v23;
    p12[6] = v31;
    p11[7] = v24;
    p12[7] = v32;
    p11[8] = v25;
    p12[8] = v33;
end;

function sha384(p85: string)
    local v86 = { 3418070365, 1654270250, 2438529370, 355462360, 1731405415, 2394180231, 3675008525, 1203062813 };
    local v87 = { 3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428 };
    local v88 = #p85;

    if v88 > 1125899906842624 then
        error("cannot calculate the SHA-384 hash of a string longer than 2^50 bytes", 2);
    end;

    local v89 = v88 % 128;

    if v88 >= 128 then
        processBlocks(v86, v87, p85, 1, v88 - v89);
    end;

    local bit32_band_ret = bit32.band(v89 + 64, 4294963200);
    local v90 = {
        v89 == 0 and "" or string.sub(p85, -v89),
        "\128",
        string.rep("\0", (bit32_band_ret - v89 - 17) % 128),
        string.pack(">L", v88 * 8 / 4294967296),
        string.pack(">L", (bit32.bor(v88 * 8)))
    };
    local table_concat_ret = table.concat(v90);
    processBlocks(v86, v87, table_concat_ret, 1, #table_concat_ret);
    local buffer_create_ret = buffer.create(48);

    for i = 1, 6 do
        local bit32_byteswap_ret = bit32.byteswap(v86[i]);
        buffer.writeu32(buffer_create_ret, (i - 1) * 8, bit32_byteswap_ret);
        local bit32_byteswap_ret2 = bit32.byteswap(v87[i]);
        buffer.writeu32(buffer_create_ret, (i - 1) * 8 + 4, bit32_byteswap_ret2);
        local _ = i;
    end;

    return buffer_create_ret;
end;

local v93 = {
    Name = "SHA-384",
    BlockSize = 128,
    OutputSize = 48,

    Digest = function(p91) -- Line: 341, Name: Digest
        return buffer.tostring(sha384(p91));
    end,

    DigestBuffer = function(p92) -- Line: 344, Name: DigestBuffer
        return sha384(buffer.tostring(p92));
    end,

    DigestToBuffer = sha384
};
table.freeze(v93);

return v93;