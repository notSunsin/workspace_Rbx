-- Decompiled with Potassium's decompiler.

return function(p1: buffer) -- Line: 4, Name: UnpackPositions
    local v2 = {};

    for i = 0, buffer.readu16(p1, 0) - 1 do
        local v3 = i * 8 + 2;
        local buffer_readu16_ret = buffer.readu16(p1, v3);
        local v4 = buffer.readi16(p1, v3 + 2) / 10;
        local v5 = buffer.readi16(p1, v3 + 4) / 10;
        local v6 = buffer.readi16(p1, v3 + 6) / 10;
        v2[buffer_readu16_ret] = Vector3.new(v4, v5, v6);
        local _ = i;
    end;

    return v2;
end;