-- Decompiled with Potassium's decompiler.

local bit32_band = bit32.band;
local bit32_lshift = bit32.lshift;
local bit32_rshift = bit32.rshift;
local bit32_lrotate = bit32.lrotate;
local bit32_bxor = bit32.bxor;
local bit32_bor = bit32.bor;
local buffer_len = buffer.len;
local buffer_readu32 = buffer.readu32;
local buffer_readu8 = buffer.readu8;
local buffer_readu16 = buffer.readu16;
local buffer_fromstring = buffer.fromstring;

function mul32(p1: number, p2: number)
    -- upvalues: bit32_band (copy), bit32_rshift (copy), bit32_lshift (copy)
    return bit32_band(p1, 65535) * p2 + bit32_lshift(bit32_band(bit32_rshift(p1, 16) * p2, 65535), 16);
end;

function DigestBufferUnsafe(p3: buffer, p4: number, p5: number, p6: number?)
    -- upvalues: bit32_bor (copy), buffer_readu32 (copy), bit32_lrotate (copy), bit32_bxor (copy), bit32_lshift (copy), bit32_band (copy), buffer_readu8 (copy), buffer_readu16 (copy), bit32_rshift (copy)
    if p6 == nil then
        p6 = 0;
    else
        local v7 = bit32_bor(p6, 0) == p6;
        assert(v7);
    end;

    while p4 < p4 + p5 - 3 do
        local v8 = buffer_readu32(p3, p4);
        local v9 = bit32_lrotate(mul32(v8, 3432918353), 15);
        p6 = bit32_lshift(bit32_lrotate(bit32_bxor(p6, (mul32(v9, 461845907))), 13) * 5, 0) + 3864292196;
        p4 = p4 + 4;
    end;

    local v10 = bit32_band(p5, 3);

    if v10 > 0 then
        local v11;

        if v10 == 3 then
            v11 = buffer_readu8(p3, p4) + bit32_lshift(buffer_readu16(p3, p4 + 1), 8);
        elseif v10 == 2 then
            v11 = buffer_readu16(p3, p4);
        else
            v11 = buffer_readu8(p3, p4);
        end;

        local v12 = bit32_lrotate(mul32(v11, 3432918353), 15);
        p6 = bit32_bxor(p6, (mul32(v12, 461845907)));
    end;

    local v13 = bit32_bxor(p6, p5);
    local v14 = bit32_bxor(v13, (bit32_rshift(v13, 16)));
    local v15 = mul32(v14, 2246822507);
    local v16 = bit32_bxor(v15, (bit32_rshift(v15, 13)));
    local v17 = mul32(v16, 3266489909);

    return bit32_bxor(v17, (bit32_rshift(v17, 16)));
end;

function DigestBufferCustom(p18: buffer, p19: number, p20: number, p21: number?)
    -- upvalues: buffer_len (copy)
    local v22 = type(p18) == "buffer";
    assert(v22);
    local v23;

    if type(p19) == "number" and p19 >= 0 then
        v23 = p19 <= buffer_len(p18);
    else
        v23 = false;
    end;

    assert(v23);
    local v24;

    if type(p20) == "number" and p20 >= 0 then
        v24 = p20 <= buffer_len(p18) - p19;
    else
        v24 = false;
    end;

    assert(v24);

    return DigestBufferUnsafe(p18, p19, p20, p21);
end;

function DigestBuffer(p25: buffer, p26: number?)
    -- upvalues: buffer_len (copy)
    return DigestBufferUnsafe(p25, 0, buffer_len(p25), p26);
end;

function Digest(p27: string, p28: number?)
    -- upvalues: buffer_fromstring (copy), buffer_len (copy)
    local v29 = buffer_fromstring(p27);

    return DigestBufferUnsafe(v29, 0, buffer_len(v29), p28);
end;

local v30 = {
    DigestBufferCustom = DigestBufferCustom,
    DigestBuffer = DigestBuffer,
    Digest = Digest
};
table.freeze(v30);

return v30;