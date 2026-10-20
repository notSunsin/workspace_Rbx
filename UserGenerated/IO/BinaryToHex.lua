-- Decompiled with Potassium's decompiler.

return function(p1: string) -- Line: 20, Name: BinaryToHex
    local string_len_ret = string.len(p1);
    local buffer_create_ret = buffer.create(string_len_ret * 2);

    for i = 0, string_len_ret - 1 do
        local string_byte_ret = string.byte(p1, i + 1);
        local bit32_rshift_ret = bit32.rshift(string_byte_ret, 4);
        local bit32_band_ret = bit32.band(string_byte_ret, 15);
        local v2;

        if bit32_rshift_ret < 10 then
            v2 = bit32_rshift_ret + 48;
        else
            v2 = bit32_rshift_ret + 87;
        end;

        buffer.writeu8(buffer_create_ret, i * 2 + 0, v2);
        local v3;

        if bit32_band_ret < 10 then
            v3 = bit32_band_ret + 48;
        else
            v3 = bit32_band_ret + 87;
        end;

        buffer.writeu8(buffer_create_ret, i * 2 + 1, v3);
        local _ = i;
    end;

    return buffer.tostring(buffer_create_ret);
end;