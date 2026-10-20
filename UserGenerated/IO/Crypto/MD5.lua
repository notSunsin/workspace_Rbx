-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = { 3614090360, 3905402710, 606105819, 3250441966, 4118548399, 1200080426, 2821735955, 4249261313, 1770035416, 2336552879, 4294925233, 2304563134, 1804603682, 4254626195, 2792965006, 1236535329, 4129170786, 3225465664, 643717713, 3921069994, 3593408605, 38016083, 3634488961, 3889429448, 568446438, 3275163606, 4107603335, 1163531501, 2850285829, 4243563512, 1735328473, 2368359562, 4294588738, 2272392833, 1839030562, 4259657740, 2763975236, 1272893353, 4139469664, 3200236656, 681279174, 3936430074, 3572445317, 76029189, 3654602809, 3873151461, 530742520, 3299628645, 4096336452, 1126891415, 2878612391, 4237533241, 1700485571, 2399980690, 4293915773, 2240044497, 1873313359, 4264355552, 2734768916, 1309151649, 4149444226, 3174756917, 718787259, 3951481745 };
local u2 = { 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21 };
local table_create_ret = table.create(64, 0);

function processBlocks(p3: table, p4: string, p5: number, p6: number)
    -- upvalues: table_create_ret (copy), u1 (copy), u2 (copy)
    local v7 = table_create_ret;
    local v8 = p3[1];
    local v9 = p3[2];
    local v10 = p3[3];
    local v11 = p3[4];

    for i = p5, p6, 64 do
        local v12 = i;
        local v13 = v12;
        local v14 = v12;
        v12 = v13;
        v14 = v13;

        for i2 = 1, 16 do
            local string_byte_ret, v15, v16, v17 = string.byte(p4, v13, v13 + 3);
            local bit32_lshift_ret = bit32.lshift(v17, 24);
            local bit32_lshift_ret2 = bit32.lshift(v16, 16);
            local bit32_lshift_ret3 = bit32.lshift(v15, 8);
            v7[i2] = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, string_byte_ret);
            v13 = v13 + 4;
            local _ = i2;
        end;

        local v18 = v11;
        local v19 = v10;
        local v20 = v9;
        local v21 = v8;

        for i2 = 0, 15 do
            local bit32_bxor_ret = bit32.bxor(v10, v11);
            local bit32_band_ret = bit32.band(v9, bit32_bxor_ret);
            local v22 = v8 + bit32.bxor(v11, bit32_band_ret) + u1[i2 + 1] + v7[i2 + 1];
            local v23 = v9 + bit32.lrotate(v22, u2[i2 + 1]);
            v8 = v11;
            v11 = v10;
            v10 = v9;
            v9 = v23;
            local _ = i2;
        end;

        for i2 = 16, 31 do
            local bit32_bxor_ret = bit32.bxor(v9, v10);
            local bit32_band_ret = bit32.band(v11, bit32_bxor_ret);
            local v24 = v8 + bit32.bxor(v10, bit32_band_ret) + u1[i2 + 1] + v7[(i2 * 5 + 1) % 16 + 1];
            local v25 = v9 + bit32.lrotate(v24, u2[i2 + 1]);
            v8 = v11;
            v11 = v10;
            v10 = v9;
            v9 = v25;
            local _ = i2;
        end;

        for i2 = 32, 47 do
            local v26 = v8 + bit32.bxor(v9, v10, v11) + u1[i2 + 1] + v7[(i2 * 3 + 5) % 16 + 1];
            local v27 = v9 + bit32.lrotate(v26, u2[i2 + 1]);
            v8 = v11;
            v11 = v10;
            v10 = v9;
            v9 = v27;
            local _ = i2;
        end;

        for i2 = 48, 63 do
            local bit32_bnot_ret = bit32.bnot(v11);
            local bit32_bor_ret = bit32.bor(v9, bit32_bnot_ret);
            local v28 = v8 + bit32.bxor(v10, bit32_bor_ret) + u1[i2 + 1] + v7[i2 * 7 % 16 + 1];
            local v29 = v9 + bit32.lrotate(v28, u2[i2 + 1]);
            v8 = v11;
            v11 = v10;
            v10 = v9;
            v9 = v29;
            local _ = i2;
        end;

        v8 = bit32.bor(v8 + v21);
        v9 = bit32.bor(v9 + v20);
        v10 = bit32.bor(v10 + v19);
        v11 = bit32.bor(v11 + v18);
    end;

    p3[1] = v8;
    p3[2] = v9;
    p3[3] = v10;
    p3[4] = v11;
end;

function md5(p30: string)
    local v31 = { 1732584193, 4023233417, 2562383102, 271733878 };
    local v32 = #p30;
    local v33 = v32 % 64;

    if v32 >= 64 then
        processBlocks(v31, p30, 1, v32 - v33);
    end;

    local bit32_band_ret = bit32.band(v33 + 32, 4294967232);
    local v34 = {
        v33 == 0 and "" or string.sub(p30, -v33),
        "\128",
        string.rep("\0", (bit32_band_ret - v33 - 9) % 64),
        string.pack("<L", v32 * 8)
    };
    local table_concat_ret = table.concat(v34);
    processBlocks(v31, table_concat_ret, 1, #table_concat_ret);
    local buffer_create_ret = buffer.create(16);
    buffer.writeu32(buffer_create_ret, 0, v31[1]);
    buffer.writeu32(buffer_create_ret, 4, v31[2]);
    buffer.writeu32(buffer_create_ret, 8, v31[3]);
    buffer.writeu32(buffer_create_ret, 12, v31[4]);

    return buffer_create_ret;
end;

local v37 = {
    Name = "MD5",
    BlockSize = 64,
    OutputSize = 16,

    Digest = function(p35) -- Line: 180, Name: Digest
        return buffer.tostring(md5(p35));
    end,

    DigestBuffer = function(p36) -- Line: 183, Name: DigestBuffer
        return md5(buffer.tostring(p36));
    end,

    DigestToBuffer = md5
};
table.freeze(v37);

return v37;