-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = { 1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748, 2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206, 2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891, 3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771, 3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452, 2361852424, 2428436474, 2756734187, 3204031479, 3329325298 };
local table_create_ret = table.create(64, 0);

function processBlocks(p2: table, p3: string, p4: number, p5: number)
    -- upvalues: table_create_ret (copy), u1 (copy)
    local v6 = table_create_ret;
    local v7 = p2[1];
    local v8 = p2[2];
    local v9 = p2[3];
    local v10 = p2[4];
    local v11 = p2[5];
    local v12 = p2[6];
    local v13 = p2[7];
    local v14 = p2[8];

    for i = p4, p5, 64 do
        local v15 = i;
        local v16 = v15;
        local v17 = v15;
        v15 = v16;
        v17 = v16;

        for i2 = 1, 16 do
            local string_byte_ret, v18, v19, v20 = string.byte(p3, v16, v16 + 3);
            local bit32_lshift_ret = bit32.lshift(string_byte_ret, 24);
            local bit32_lshift_ret2 = bit32.lshift(v18, 16);
            local bit32_lshift_ret3 = bit32.lshift(v19, 8);
            v6[i2] = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, v20);
            v16 = v16 + 4;
            local _ = i2;
        end;

        for i2 = 17, 64 do
            local v21 = v6[i2 - 2];
            local v22 = v6[i2 - 15];
            local bit32_rrotate_ret = bit32.rrotate(v21, 17);
            local bit32_rrotate_ret2 = bit32.rrotate(v21, 19);
            local bit32_rshift_ret = bit32.rshift(v21, 10);
            local v23 = bit32.bxor(bit32_rrotate_ret, bit32_rrotate_ret2, bit32_rshift_ret) + v6[i2 - 7];
            local bit32_rrotate_ret3 = bit32.rrotate(v22, 7);
            local bit32_rrotate_ret4 = bit32.rrotate(v22, 18);
            local bit32_rshift_ret2 = bit32.rshift(v22, 3);
            v6[i2] = v23 + bit32.bxor(bit32_rrotate_ret3, bit32_rrotate_ret4, bit32_rshift_ret2) + v6[i2 - 16];
            local _ = i2;
        end;

        local v24 = v14;
        local v25 = v13;
        local v26 = v12;
        local v27 = v11;
        local v28 = v10;
        local v29 = v9;
        local v30 = v8;
        local v31 = v7;

        for i2 = 1, 64 do
            local bit32_rrotate_ret = bit32.rrotate(v11, 6);
            local bit32_rrotate_ret2 = bit32.rrotate(v11, 11);
            local bit32_rrotate_ret3 = bit32.rrotate(v11, 25);
            local v32 = v14 + bit32.bxor(bit32_rrotate_ret, bit32_rrotate_ret2, bit32_rrotate_ret3) + bit32.band(v11, v12);
            local bit32_bnot_ret = bit32.bnot(v11);
            local v33 = v32 + bit32.band(bit32_bnot_ret, v13) + u1[i2] + v6[i2];
            local bit32_band_ret = bit32.band(v9, v8);
            local bit32_bxor_ret = bit32.bxor(v9, v8);
            local v34 = bit32_band_ret + bit32.band(v7, bit32_bxor_ret);
            local bit32_rrotate_ret4 = bit32.rrotate(v7, 2);
            local bit32_rrotate_ret5 = bit32.rrotate(v7, 13);
            local bit32_rrotate_ret6 = bit32.rrotate(v7, 22);
            local v35 = v34 + bit32.bxor(bit32_rrotate_ret4, bit32_rrotate_ret5, bit32_rrotate_ret6);
            v14 = v13;
            v13 = v12;
            v12 = v11;
            v11 = v10 + v33;
            v10 = v9;
            v9 = v8;
            v8 = v7;
            v7 = v33 + v35;
            local _ = i2;
        end;

        v7 = bit32.bor(v7 + v31, 0);
        v8 = bit32.bor(v8 + v30, 0);
        v9 = bit32.bor(v9 + v29, 0);
        v10 = bit32.bor(v10 + v28, 0);
        v11 = bit32.bor(v11 + v27, 0);
        v12 = bit32.bor(v12 + v26, 0);
        v13 = bit32.bor(v13 + v25, 0);
        v14 = bit32.bor(v14 + v24, 0);
    end;

    p2[1] = v7;
    p2[2] = v8;
    p2[3] = v9;
    p2[4] = v10;
    p2[5] = v11;
    p2[6] = v12;
    p2[7] = v13;
    p2[8] = v14;
end;

function sha256(p36: string)
    local v37 = { 1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225 };
    local v38 = #p36;
    local v39 = v38 % 64;

    if v38 >= 64 then
        processBlocks(v37, p36, 1, v38 - v39);
    end;

    local bit32_band_ret = bit32.band(v39 + 32, 4294967232);
    local v40 = {
        v39 == 0 and "" or string.sub(p36, -v39),
        "\128",
        string.rep("\0", (bit32_band_ret - v39 - 9) % 64),
        string.pack(">L", v38 * 8)
    };
    local table_concat_ret = table.concat(v40);
    processBlocks(v37, table_concat_ret, 1, #table_concat_ret);
    local buffer_create_ret = buffer.create(32);
    local bit32_byteswap_ret = bit32.byteswap(v37[1]);
    buffer.writeu32(buffer_create_ret, 0, bit32_byteswap_ret);
    local bit32_byteswap_ret2 = bit32.byteswap(v37[2]);
    buffer.writeu32(buffer_create_ret, 4, bit32_byteswap_ret2);
    local bit32_byteswap_ret3 = bit32.byteswap(v37[3]);
    buffer.writeu32(buffer_create_ret, 8, bit32_byteswap_ret3);
    local bit32_byteswap_ret4 = bit32.byteswap(v37[4]);
    buffer.writeu32(buffer_create_ret, 12, bit32_byteswap_ret4);
    local bit32_byteswap_ret5 = bit32.byteswap(v37[5]);
    buffer.writeu32(buffer_create_ret, 16, bit32_byteswap_ret5);
    local bit32_byteswap_ret6 = bit32.byteswap(v37[6]);
    buffer.writeu32(buffer_create_ret, 20, bit32_byteswap_ret6);
    local bit32_byteswap_ret7 = bit32.byteswap(v37[7]);
    buffer.writeu32(buffer_create_ret, 24, bit32_byteswap_ret7);
    local bit32_byteswap_ret8 = bit32.byteswap(v37[8]);
    buffer.writeu32(buffer_create_ret, 28, bit32_byteswap_ret8);

    return buffer_create_ret;
end;

local v43 = {
    Name = "SHA-256",
    BlockSize = 64,
    OutputSize = 32,

    Digest = function(p41) -- Line: 171, Name: Digest
        return buffer.tostring(sha256(p41));
    end,

    DigestBuffer = function(p42) -- Line: 174, Name: DigestBuffer
        return sha256(buffer.tostring(p42));
    end,

    DigestToBuffer = sha256
};
table.freeze(v43);

return v43;