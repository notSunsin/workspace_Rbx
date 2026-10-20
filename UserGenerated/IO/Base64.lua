-- Decompiled with Potassium's decompiler.

local buffer_create_ret = buffer.create(64);
local buffer_create_ret2 = buffer.create(256);

for i = 1, 64 do
    local v1 = i - 1;
    local string_byte_ret = string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", i);
    buffer.writeu8(buffer_create_ret, v1, string_byte_ret);
    buffer.writeu8(buffer_create_ret2, string_byte_ret, v1);
    local _ = i;
end;

function encode(p2: buffer, p3: number?)
    -- upvalues: buffer_create_ret (copy)
    local v4 = p3 or buffer.len(p2);
    local math_ceil_ret = math.ceil(v4 / 3);
    local v5 = math_ceil_ret * 4;
    local buffer_create_ret3 = buffer.create(v5);

    for i = 1, math_ceil_ret - 1 do
        local v6 = (i - 1) * 4;
        local buffer_readu32_ret = buffer.readu32(p2, (i - 1) * 3);
        local bit32_byteswap_ret = bit32.byteswap(buffer_readu32_ret);
        local bit32_rshift_ret = bit32.rshift(bit32_byteswap_ret, 26);
        local bit32_rshift_ret2 = bit32.rshift(bit32_byteswap_ret, 20);
        local bit32_band_ret = bit32.band(bit32_rshift_ret2, 63);
        local bit32_rshift_ret3 = bit32.rshift(bit32_byteswap_ret, 14);
        local bit32_band_ret2 = bit32.band(bit32_rshift_ret3, 63);
        local bit32_rshift_ret4 = bit32.rshift(bit32_byteswap_ret, 8);
        local bit32_band_ret3 = bit32.band(bit32_rshift_ret4, 63);
        local buffer_readu8_ret = buffer.readu8(buffer_create_ret, bit32_rshift_ret);
        buffer.writeu8(buffer_create_ret3, v6, buffer_readu8_ret);
        local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret, bit32_band_ret);
        buffer.writeu8(buffer_create_ret3, v6 + 1, buffer_readu8_ret2);
        local buffer_readu8_ret3 = buffer.readu8(buffer_create_ret, bit32_band_ret2);
        buffer.writeu8(buffer_create_ret3, v6 + 2, buffer_readu8_ret3);
        local buffer_readu8_ret4 = buffer.readu8(buffer_create_ret, bit32_band_ret3);
        buffer.writeu8(buffer_create_ret3, v6 + 3, buffer_readu8_ret4);
        local _ = i;
    end;

    local v7 = v4 % 3;

    if v7 == 1 then
        local buffer_readu8_ret = buffer.readu8(p2, v4 - 1);
        local bit32_rshift_ret = bit32.rshift(buffer_readu8_ret, 2);
        local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 4);
        local bit32_band_ret = bit32.band(bit32_lshift_ret, 63);
        local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret, bit32_rshift_ret);
        buffer.writeu8(buffer_create_ret3, v5 - 4, buffer_readu8_ret2);
        local buffer_readu8_ret3 = buffer.readu8(buffer_create_ret, bit32_band_ret);
        buffer.writeu8(buffer_create_ret3, v5 - 3, buffer_readu8_ret3);
        buffer.writeu8(buffer_create_ret3, v5 - 2, 61);
        buffer.writeu8(buffer_create_ret3, v5 - 1, 61);

        return buffer_create_ret3;
    end;

    if v7 ~= 2 then
        if v7 == 0 and v4 ~= 0 then
            local buffer_readu8_ret = buffer.readu8(p2, v4 - 3);
            local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 16);
            local buffer_readu8_ret2 = buffer.readu8(p2, v4 - 2);
            local bit32_lshift_ret2 = bit32.lshift(buffer_readu8_ret2, 8);
            local buffer_readu8_ret3 = buffer.readu8(p2, v4 - 1);
            local bit32_bor_ret = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, buffer_readu8_ret3);
            local bit32_rshift_ret = bit32.rshift(bit32_bor_ret, 18);
            local bit32_rshift_ret2 = bit32.rshift(bit32_bor_ret, 12);
            local bit32_band_ret = bit32.band(bit32_rshift_ret2, 63);
            local bit32_rshift_ret3 = bit32.rshift(bit32_bor_ret, 6);
            local bit32_band_ret2 = bit32.band(bit32_rshift_ret3, 63);
            local bit32_band_ret3 = bit32.band(bit32_bor_ret, 63);
            local buffer_readu8_ret4 = buffer.readu8(buffer_create_ret, bit32_rshift_ret);
            buffer.writeu8(buffer_create_ret3, v5 - 4, buffer_readu8_ret4);
            local buffer_readu8_ret5 = buffer.readu8(buffer_create_ret, bit32_band_ret);
            buffer.writeu8(buffer_create_ret3, v5 - 3, buffer_readu8_ret5);
            local buffer_readu8_ret6 = buffer.readu8(buffer_create_ret, bit32_band_ret2);
            buffer.writeu8(buffer_create_ret3, v5 - 2, buffer_readu8_ret6);
            local buffer_readu8_ret7 = buffer.readu8(buffer_create_ret, bit32_band_ret3);
            buffer.writeu8(buffer_create_ret3, v5 - 1, buffer_readu8_ret7);
        end;

        return buffer_create_ret3;
    end;

    local buffer_readu8_ret = buffer.readu8(p2, v4 - 2);
    local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
    local buffer_readu8_ret2 = buffer.readu8(p2, v4 - 1);
    local bit32_bor_ret = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2);
    local bit32_rshift_ret = bit32.rshift(bit32_bor_ret, 10);
    local bit32_rshift_ret2 = bit32.rshift(bit32_bor_ret, 4);
    local bit32_band_ret = bit32.band(bit32_rshift_ret2, 63);
    local bit32_lshift_ret2 = bit32.lshift(bit32_bor_ret, 2);
    local bit32_band_ret2 = bit32.band(bit32_lshift_ret2, 63);
    local buffer_readu8_ret3 = buffer.readu8(buffer_create_ret, bit32_rshift_ret);
    buffer.writeu8(buffer_create_ret3, v5 - 4, buffer_readu8_ret3);
    local buffer_readu8_ret4 = buffer.readu8(buffer_create_ret, bit32_band_ret);
    buffer.writeu8(buffer_create_ret3, v5 - 3, buffer_readu8_ret4);
    local buffer_readu8_ret5 = buffer.readu8(buffer_create_ret, bit32_band_ret2);
    buffer.writeu8(buffer_create_ret3, v5 - 2, buffer_readu8_ret5);
    buffer.writeu8(buffer_create_ret3, v5 - 1, 61);

    return buffer_create_ret3;
end;

function decode(p8: buffer)
    -- upvalues: buffer_create_ret2 (copy)
    local buffer_len_ret = buffer.len(p8);
    local math_ceil_ret = math.ceil(buffer_len_ret / 4);
    local v9 = 0;

    if buffer_len_ret ~= 0 then
        if buffer.readu8(p8, buffer_len_ret - 1) == 61 then
            v9 = v9 + 1;
        end;

        if buffer.readu8(p8, buffer_len_ret - 2) == 61 then
            v9 = v9 + 1;
        end;
    end;

    local buffer_create_ret3 = buffer.create(math_ceil_ret * 3 - v9);

    for i = 1, math_ceil_ret - 1 do
        local v10 = (i - 1) * 4;
        local v11 = (i - 1) * 3;
        local buffer_readu8_ret = buffer.readu8(p8, v10);
        local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret);
        local buffer_readu8_ret3 = buffer.readu8(p8, v10 + 1);
        local buffer_readu8_ret4 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret3);
        local buffer_readu8_ret5 = buffer.readu8(p8, v10 + 2);
        local buffer_readu8_ret6 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret5);
        local buffer_readu8_ret7 = buffer.readu8(p8, v10 + 3);
        local buffer_readu8_ret8 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret7);
        local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret2, 18);
        local bit32_lshift_ret2 = bit32.lshift(buffer_readu8_ret4, 12);
        local bit32_lshift_ret3 = bit32.lshift(buffer_readu8_ret6, 6);
        local bit32_bor_ret = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, buffer_readu8_ret8);
        local bit32_rshift_ret = bit32.rshift(bit32_bor_ret, 16);
        local bit32_rshift_ret2 = bit32.rshift(bit32_bor_ret, 8);
        local bit32_band_ret = bit32.band(bit32_rshift_ret2, 255);
        local bit32_band_ret2 = bit32.band(bit32_bor_ret, 255);
        buffer.writeu8(buffer_create_ret3, v11, bit32_rshift_ret);
        buffer.writeu8(buffer_create_ret3, v11 + 1, bit32_band_ret);
        buffer.writeu8(buffer_create_ret3, v11 + 2, bit32_band_ret2);
        local _ = i;
    end;

    if buffer_len_ret ~= 0 then
        local v12 = (math_ceil_ret - 1) * 4;
        local v13 = (math_ceil_ret - 1) * 3;
        local buffer_readu8_ret = buffer.readu8(p8, v12);
        local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret);
        local buffer_readu8_ret3 = buffer.readu8(p8, v12 + 1);
        local buffer_readu8_ret4 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret3);
        local buffer_readu8_ret5 = buffer.readu8(p8, v12 + 2);
        local buffer_readu8_ret6 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret5);
        local buffer_readu8_ret7 = buffer.readu8(p8, v12 + 3);
        local buffer_readu8_ret8 = buffer.readu8(buffer_create_ret2, buffer_readu8_ret7);
        local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret2, 18);
        local bit32_lshift_ret2 = bit32.lshift(buffer_readu8_ret4, 12);
        local bit32_lshift_ret3 = bit32.lshift(buffer_readu8_ret6, 6);
        local bit32_bor_ret = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, buffer_readu8_ret8);

        if v9 <= 2 then
            local bit32_rshift_ret = bit32.rshift(bit32_bor_ret, 16);
            buffer.writeu8(buffer_create_ret3, v13, bit32_rshift_ret);

            if v9 <= 1 then
                local bit32_rshift_ret2 = bit32.rshift(bit32_bor_ret, 8);
                local bit32_band_ret = bit32.band(bit32_rshift_ret2, 255);
                buffer.writeu8(buffer_create_ret3, v13 + 1, bit32_band_ret);

                if v9 == 0 then
                    local bit32_band_ret2 = bit32.band(bit32_bor_ret, 255);
                    buffer.writeu8(buffer_create_ret3, v13 + 2, bit32_band_ret2);
                end;
            end;
        end;
    end;

    return buffer_create_ret3;
end;

function Encode(p14: string)
    return buffer.tostring(encode(buffer.fromstring(p14)));
end;

function Decode(p15: string)
    return buffer.tostring(decode(buffer.fromstring(p15)));
end;

return table.freeze({
    Encode = Encode,
    Decode = Decode,
    EncodeBuffer = encode,
    DecodeBuffer = decode
});