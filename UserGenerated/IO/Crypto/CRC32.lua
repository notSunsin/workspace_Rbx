-- Decompiled with Potassium's decompiler.

local u1 = {};

for i = 0, 255 do
    local v2 = i;
    local v3 = v2;
    local v4 = v2;
    v2 = v3;
    v4 = v3;

    for i2 = 1, 8 do
        local v5;

        if bit32.band(v3, 1) == 0 then
            v3 = bit32.rshift(v3, 1);
            v5 = i2;
        else
            local bit32_rshift_ret = bit32.rshift(v3, 1);
            v3 = bit32.bxor(bit32_rshift_ret, 3988292384);
            v5 = i2;
        end;
    end;

    u1[v2 + 1] = v3;
end;

local u19 = {
    Init = function() -- Line: 44, Name: Init
        return 4294967295;
    end,

    Update = function(p6: number, p7: string, p8: number?, p9: number?) -- Line: 48, Name: Update
        -- upvalues: u1 (copy)
        local v10 = p8 or 1;

        for i = v10, v10 + (p9 or string.len(p7)) - 1 do
            local string_byte_ret = string.byte(p7, i);
            local bit32_rshift_ret = bit32.rshift(p6, 8);
            local bit32_bxor_ret = bit32.bxor(p6, string_byte_ret);
            local v11 = u1[bit32.band(bit32_bxor_ret, 255) + 1];
            p6 = bit32.bxor(bit32_rshift_ret, v11);
            local _ = i;
        end;

        return p6;
    end,

    UpdateBuffer = function(p12: number, p13: buffer, p14: number?, p15: number?) -- Line: 59, Name: UpdateBuffer
        -- upvalues: u1 (copy)
        local v16 = p14 or 0;

        for i = v16, v16 + (p15 or buffer.len(p13)) - 1 do
            local buffer_readu8_ret = buffer.readu8(p13, i);
            local bit32_rshift_ret = bit32.rshift(p12, 8);
            local bit32_bxor_ret = bit32.bxor(p12, buffer_readu8_ret);
            local v17 = u1[bit32.band(bit32_bxor_ret, 255) + 1];
            p12 = bit32.bxor(bit32_rshift_ret, v17);
            local _ = i;
        end;

        return p12;
    end,

    Finish = function(p18: number) -- Line: 70, Name: Finish
        return bit32.bnot(p18);
    end
};

function u19.Digest(p20: string, p21: number?, p22: number?) -- Line: 74
    -- upvalues: u19 (copy)
    local v23 = u19.Init();
    local v24 = u19.Update(v23, p20, p21, p22);

    return u19.Finish(v24);
end;

function u19.DigestBuffer(p25: buffer, p26: number?, p27: number?) -- Line: 80
    -- upvalues: u19 (copy)
    local v28 = u19.Init();
    local v29 = u19.UpdateBuffer(v28, p25, p26, p27);

    return u19.Finish(v29);
end;

return table.freeze(u19);