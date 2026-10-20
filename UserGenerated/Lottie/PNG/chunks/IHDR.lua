-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
local u1 = {
    [0] = { 1, 2, 4, 8, 16 },
    [2] = { 8, 16 },
    [3] = { 1, 2, 4, 8 },
    [4] = { 8, 16 },
    [6] = { 8, 16 }
};

return function(p2: buffer, p3: any) -- Line: 11, Name: read
    -- upvalues: u1 (copy)
    assert(p3.length == 13, "IHDR data must be 13 bytes");
    local offset = p3.offset;
    local buffer_readu32_ret = buffer.readu32(p2, offset);
    local bit32_byteswap_ret = bit32.byteswap(buffer_readu32_ret);
    local buffer_readu32_ret2 = buffer.readu32(p2, offset + 4);
    local bit32_byteswap_ret2 = bit32.byteswap(buffer_readu32_ret2);
    local buffer_readu8_ret = buffer.readu8(p2, offset + 8);
    local buffer_readu8_ret2 = buffer.readu8(p2, offset + 9);
    local buffer_readu8_ret3 = buffer.readu8(p2, offset + 10);
    local buffer_readu8_ret4 = buffer.readu8(p2, offset + 11);
    local buffer_readu8_ret5 = buffer.readu8(p2, offset + 12);
    local v4;

    if bit32_byteswap_ret > 0 and (bit32_byteswap_ret <= 2147483648 and bit32_byteswap_ret2 > 0) then
        v4 = bit32_byteswap_ret2 <= 2147483648;
    else
        v4 = false;
    end;

    assert(v4, "invalid dimensions");
    assert(buffer_readu8_ret3 == 0, "invalid compression method");
    assert(buffer_readu8_ret4 == 0, "invalid filter method");
    assert(buffer_readu8_ret5 == 0 and true or buffer_readu8_ret5 == 1, "invalid interlace method");
    local v5 = u1[buffer_readu8_ret2];
    assert(v5 ~= nil, "invalid color type");
    local v6 = table.find(v5, buffer_readu8_ret) ~= nil;
    assert(v6, "invalid bit depth");

    return {
        width = bit32_byteswap_ret,
        height = bit32_byteswap_ret2,
        bitDepth = buffer_readu8_ret,
        colorType = buffer_readu8_ret2,
        interlaced = buffer_readu8_ret5 == 1
    };
end;