-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

local function readU16(p1: buffer, p2: number, p3: number) -- Line: 3
    local buffer_readu8_ret = buffer.readu8(p1, p2);
    local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
    local buffer_readu8_ret2 = buffer.readu8(p1, p2 + 1);
    local bit32_bor_ret = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2);

    return bit32.extract(bit32_bor_ret, 0, p3);
end;

return function(p4: buffer, p5: any, p6: any, p7: any) -- Line: 11, Name: read
    local v8 = -1;
    local v9 = -1;
    local v10 = -1;
    local v11 = -1;

    if p6.colorType == 0 then
        assert(p5.length == 2, "invalid tRNS length for color type");
        local offset = p5.offset;
        local bitDepth = p6.bitDepth;
        local buffer_readu8_ret = buffer.readu8(p4, offset);
        local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
        local buffer_readu8_ret2 = buffer.readu8(p4, offset + 1);
        local bit32_bor_ret = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2);
        v8 = bit32.extract(bit32_bor_ret, 0, bitDepth);
    elseif p6.colorType == 2 then
        assert(p5.length == 6, "invalid tRNS length for color type");
        local offset = p5.offset;
        local bitDepth = p6.bitDepth;
        local buffer_readu8_ret = buffer.readu8(p4, offset);
        local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
        local buffer_readu8_ret2 = buffer.readu8(p4, offset + 1);
        local bit32_bor_ret = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2);
        v9 = bit32.extract(bit32_bor_ret, 0, bitDepth);
        local v12 = p5.offset + 2;
        local bitDepth2 = p6.bitDepth;
        local buffer_readu8_ret3 = buffer.readu8(p4, v12);
        local bit32_lshift_ret2 = bit32.lshift(buffer_readu8_ret3, 8);
        local buffer_readu8_ret4 = buffer.readu8(p4, v12 + 1);
        local bit32_bor_ret2 = bit32.bor(bit32_lshift_ret2, buffer_readu8_ret4);
        v10 = bit32.extract(bit32_bor_ret2, 0, bitDepth2);
        local v13 = p5.offset + 4;
        local bitDepth3 = p6.bitDepth;
        local buffer_readu8_ret5 = buffer.readu8(p4, v13);
        local bit32_lshift_ret3 = bit32.lshift(buffer_readu8_ret5, 8);
        local buffer_readu8_ret6 = buffer.readu8(p4, v13 + 1);
        local bit32_bor_ret3 = bit32.bor(bit32_lshift_ret3, buffer_readu8_ret6);
        v11 = bit32.extract(bit32_bor_ret3, 0, bitDepth3);
    else
        local length = p5.length;
        assert(p7, "tRNS requires PLTE for color type");
        assert(length <= #p7.colors, "tRNS specified too many PLTE alphas");

        for i = 1, length do
            p7.colors[i].a = buffer.readu8(p4, p5.offset + i - 1);
            local _ = i;
        end;
    end;

    return {
        gray = v8,
        red = v9,
        green = v10,
        blue = v11
    };
end;