-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local table_create_ret = table.create(80, 0);

function processBlocks(p1: table, p2: string, p3: number, p4: number)
    -- upvalues: table_create_ret (copy)
    local v5 = table_create_ret;
    local v6 = p1[1];
    local v7 = p1[2];
    local v8 = p1[3];
    local v9 = p1[4];
    local v10 = p1[5];

    for i = p3, p4, 64 do
        local v11 = i;
        local v12 = v11;
        local v13 = v11;
        v11 = v12;
        v13 = v12;

        for i2 = 1, 16 do
            local string_byte_ret, v14, v15, v16 = string.byte(p2, v12, v12 + 3);
            local bit32_lshift_ret = bit32.lshift(string_byte_ret, 24);
            local bit32_lshift_ret2 = bit32.lshift(v14, 16);
            local bit32_lshift_ret3 = bit32.lshift(v15, 8);
            v5[i2] = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, v16);
            v12 = v12 + 4;
            local _ = i2;
        end;

        for i2 = 17, 80 do
            local bit32_bxor_ret = bit32.bxor(v5[i2 - 3], v5[i2 - 8], v5[i2 - 14], v5[i2 - 16]);
            v5[i2] = bit32.lrotate(bit32_bxor_ret, 1);
            local _ = i2;
        end;

        local v17 = v8;
        local v18 = v10;
        local v19 = v9;
        local v20 = v7;
        local v21 = v6;

        for i2 = 1, 20 do
            local v22 = bit32.lrotate(v6, 5) + bit32.band(v7, v8);
            local bit32_bnot_ret = bit32.bnot(v7);
            local v23 = v22 + bit32.band(bit32_bnot_ret, v9) + v10 + 1518500249 + v5[i2];
            local bit32_lrotate_ret = bit32.lrotate(v7, 30);
            v10 = v9;
            v9 = v8;
            v8 = bit32_lrotate_ret;
            v7 = v6;
            v6 = v23;
            local _ = i2;
        end;

        for i2 = 21, 40 do
            local v24 = bit32.lrotate(v6, 5) + bit32.bxor(v7, v8, v9) + v10 + 1859775393 + v5[i2];
            local bit32_lrotate_ret = bit32.lrotate(v7, 30);
            v10 = v9;
            v9 = v8;
            v8 = bit32_lrotate_ret;
            v7 = v6;
            v6 = v24;
            local _ = i2;
        end;

        for i2 = 41, 60 do
            local v25 = bit32.lrotate(v6, 5) + bit32.band(v9, v8);
            local bit32_bxor_ret = bit32.bxor(v9, v8);
            local v26 = v25 + bit32.band(v7, bit32_bxor_ret) + v10 + 2400959708 + v5[i2];
            local bit32_lrotate_ret = bit32.lrotate(v7, 30);
            v10 = v9;
            v9 = v8;
            v8 = bit32_lrotate_ret;
            v7 = v6;
            v6 = v26;
            local _ = i2;
        end;

        for i2 = 61, 80 do
            local v27 = bit32.lrotate(v6, 5) + bit32.bxor(v7, v8, v9) + v10 + 3395469782 + v5[i2];
            local bit32_lrotate_ret = bit32.lrotate(v7, 30);
            v10 = v9;
            v9 = v8;
            v8 = bit32_lrotate_ret;
            v7 = v6;
            v6 = v27;
            local _ = i2;
        end;

        v6 = bit32.bor(v6 + v21, 0);
        v7 = bit32.bor(v7 + v20, 0);
        v8 = bit32.bor(v8 + v17, 0);
        v9 = bit32.bor(v9 + v19, 0);
        v10 = bit32.bor(v10 + v18, 0);
    end;

    p1[1] = v6;
    p1[2] = v7;
    p1[3] = v8;
    p1[4] = v9;
    p1[5] = v10;
end;

function sha1(p28: string)
    local v29 = { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 };
    local v30 = #p28;
    local v31 = v30 % 64;

    if v30 >= 64 then
        processBlocks(v29, p28, 1, v30 - v31);
    end;

    local bit32_band_ret = bit32.band(v31 + 32, 4294967232);
    local v32 = {
        v31 == 0 and "" or string.sub(p28, -v31),
        "\128",
        string.rep("\0", (bit32_band_ret - v31 - 9) % 64),
        string.pack(">L", v30 * 8)
    };
    local table_concat_ret = table.concat(v32);
    processBlocks(v29, table_concat_ret, 1, #table_concat_ret);
    local buffer_create_ret = buffer.create(20);
    local bit32_byteswap_ret = bit32.byteswap(v29[1]);
    buffer.writeu32(buffer_create_ret, 0, bit32_byteswap_ret);
    local bit32_byteswap_ret2 = bit32.byteswap(v29[2]);
    buffer.writeu32(buffer_create_ret, 4, bit32_byteswap_ret2);
    local bit32_byteswap_ret3 = bit32.byteswap(v29[3]);
    buffer.writeu32(buffer_create_ret, 8, bit32_byteswap_ret3);
    local bit32_byteswap_ret4 = bit32.byteswap(v29[4]);
    buffer.writeu32(buffer_create_ret, 12, bit32_byteswap_ret4);
    local bit32_byteswap_ret5 = bit32.byteswap(v29[5]);
    buffer.writeu32(buffer_create_ret, 16, bit32_byteswap_ret5);

    return buffer_create_ret;
end;

local v35 = {
    Name = "SHA-1",
    BlockSize = 64,
    OutputSize = 20,

    Digest = function(p33) -- Line: 152, Name: Digest
        return buffer.tostring(sha1(p33));
    end,

    DigestBuffer = function(p34) -- Line: 155, Name: DigestBuffer
        return sha1(buffer.tostring(p34));
    end,

    DigestToBuffer = sha1
};
table.freeze(v35);

return v35;