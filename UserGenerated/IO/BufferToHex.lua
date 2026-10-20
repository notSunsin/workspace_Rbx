-- Decompiled with Potassium's decompiler.

function BufferToHex(p1: buffer)
    local buffer_len_ret = buffer.len(p1);
    local buffer_create_ret = buffer.create(buffer_len_ret * 2);

    for i = 0, buffer_len_ret - 1 do
        local buffer_readu8_ret = buffer.readu8(p1, i);
        local bit32_rshift_ret = bit32.rshift(buffer_readu8_ret, 4);
        local bit32_band_ret = bit32.band(buffer_readu8_ret, 15);
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

return BufferToHex;