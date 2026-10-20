-- Decompiled with Potassium's decompiler.

local u1 = {
    [48] = 0,
    [49] = 1,
    [50] = 2,
    [51] = 3,
    [52] = 4,
    [53] = 5,
    [54] = 6,
    [55] = 7,
    [56] = 8,
    [57] = 9,
    [65] = 10,
    [66] = 11,
    [67] = 12,
    [68] = 13,
    [69] = 14,
    [70] = 15,
    [97] = 10,
    [98] = 11,
    [99] = 12,
    [100] = 13,
    [101] = 14,
    [102] = 15
};

return function(p2: string) -- Line: 45, Name: HexToBuffer
    -- upvalues: u1 (copy)
    local v3 = #p2;
    assert(v3 % 2 == 0, "hex length must be even");
    local buffer_create_ret = buffer.create(v3 // 2);
    local v4 = 0;

    for i = 1, v3, 2 do
        local string_byte_ret, v5 = string.byte(p2, i, i + 1);
        local v6 = u1[string_byte_ret];

        if not v6 then
            error((`invalid hex at {i}`));
        end;

        local v7 = u1[v5];

        if not v7 then
            error((`invalid hex at {i + 1}`));
        end;

        buffer.writeu8(buffer_create_ret, v4, v6 * 16 + v7);
        v4 = v4 + 1;
        local _ = i;
    end;

    return buffer_create_ret;
end;