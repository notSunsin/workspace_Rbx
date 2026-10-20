-- Decompiled with Potassium's decompiler.

local buffer_copy = buffer.copy;
local buffer_create = buffer.create;
local buffer_fill = buffer.fill;
local buffer_len = buffer.len;
local buffer_readu8 = buffer.readu8;
local buffer_writeu8 = buffer.writeu8;
local math_random = math.random;
local v1 = {};

local function nonPad(p2) -- Line: 26
    return p2;
end;

v1.None = table.freeze({
    Overwrite = false,
    Pad = nonPad,
    Unpad = nonPad
});

local function anxPad(p3: buffer, p4: buffer, p5: number) -- Line: 41
    -- upvalues: buffer_len (copy), buffer_copy (copy), buffer_fill (copy), buffer_writeu8 (copy), buffer_create (copy)
    local v6 = buffer_len(p3);
    local v7 = v6 - v6 % p5;

    if not p4 then
        local v8 = v7 + p5;
        local v9 = buffer_create(v8);
        buffer_copy(v9, 0, p3, 0, v6);
        buffer_writeu8(v9, v8 - 1, p5 - v6 % p5);

        return v9;
    end;

    local v10 = buffer_len(p4) >= v6 + p5;
    assert(v10, "Output buffer out of bounds");
    local v11 = p5 - v6 % p5;
    buffer_copy(p4, 0, p3, 0, v6);
    buffer_fill(p4, v6, 0, v11 - 1);
    buffer_writeu8(p4, v7 + p5 - 1, v11);

    return p4;
end;

local function anxUnpad(p12: buffer, p13: buffer, p14: number) -- Line: 59
    -- upvalues: buffer_len (copy), buffer_readu8 (copy), buffer_create (copy), buffer_copy (copy)
    local v15 = buffer_len(p12);
    local v16 = buffer_readu8(p12, v15 - 1);
    local v17 = v15 - v16;
    local v18;

    if v16 > 0 then
        v18 = v16 <= p14;
    else
        v18 = false;
    end;

    assert(v18, "Got unexpected padding");

    for i = v17, v15 - 2 do
        local v19;

        if buffer_readu8(p12, i) == 0 then
            v19 = i;
        else
            error("Got unexpected padding");
            v19 = i;
        end;
    end;

    if p13 then
        local v20 = v17 <= buffer_len(p13);
        assert(v20, "Output buffer out of bounds");
    else
        p13 = buffer_create(v17);
    end;

    buffer_copy(p13, 0, p12, 0, v17);

    return p13;
end;

local function i10Pad(p21: buffer, p22: buffer, p23: number) -- Line: 82
    -- upvalues: buffer_len (copy), buffer_create (copy), buffer_copy (copy), math_random (copy), buffer_writeu8 (copy)
    local v24 = buffer_len(p21);
    local v25 = v24 - v24 % p23;

    if p22 then
        local v26 = buffer_len(p22) >= v24 + p23;
        assert(v26, "Output buffer out of bounds");
    else
        p22 = buffer_create(v25 + p23);
    end;

    buffer_copy(p22, 0, p21, 0, v24);

    for i = v24, v25 + p23 - 2 do
        buffer_writeu8(p22, i, (math_random(0, 255)));
        local _ = i;
    end;

    buffer_writeu8(p22, v25 + p23 - 1, p23 - v24 % p23);

    return p22;
end;

local function i10Unpad(p27: buffer, p28: buffer, p29: number) -- Line: 97
    -- upvalues: buffer_len (copy), buffer_readu8 (copy), buffer_create (copy), buffer_copy (copy)
    local v30 = buffer_len(p27);
    local v31 = buffer_readu8(p27, v30 - 1);
    local v32 = v30 - v31;
    local v33;

    if v31 > 0 then
        v33 = v31 <= p29;
    else
        v33 = false;
    end;

    assert(v33, "Got unexpected padding");

    if p28 then
        local v34 = v32 <= buffer_len(p28);
        assert(v34, "Output buffer out of bounds");
    else
        p28 = buffer_create(v32);
    end;

    buffer_copy(p28, 0, p27, 0, v32);

    return p28;
end;

local function pksPad(p35: buffer, p36: buffer, p37: number) -- Line: 115
    -- upvalues: buffer_len (copy), buffer_create (copy), buffer_copy (copy), buffer_fill (copy)
    local v38 = buffer_len(p35);
    local v39 = v38 - v38 % p37;

    if p36 then
        local v40 = buffer_len(p36) >= v38 + p37;
        assert(v40, "Output buffer out of bounds");
    else
        p36 = buffer_create(v39 + p37);
    end;

    local v41 = p37 - v38 % p37;
    buffer_copy(p36, 0, p35, 0, v38);
    buffer_fill(p36, v38, v41, v41);

    return p36;
end;

local function pksUnpad(p42: buffer, p43: buffer, p44: number) -- Line: 128
    -- upvalues: buffer_len (copy), buffer_readu8 (copy), buffer_create (copy), buffer_copy (copy)
    local v45 = buffer_len(p42);
    local v46 = buffer_readu8(p42, v45 - 1);
    local v47 = v45 - v46;
    local v48;

    if v46 > 0 then
        v48 = v46 <= p44;
    else
        v48 = false;
    end;

    assert(v48, "Got unexpected padding");

    for i = v47, v45 - 2 do
        local v49;

        if buffer_readu8(p42, i) == v46 then
            v49 = i;
        else
            error("Got unexpected padding");
            v49 = i;
        end;
    end;

    if p43 then
        local v50 = v47 <= buffer_len(p43);
        assert(v50, "Output buffer out of bounds");
    else
        p43 = buffer_create(v47);
    end;

    buffer_copy(p43, 0, p42, 0, v47);

    return p43;
end;

local function ii7Pad(p51: buffer, p52: buffer, p53: number) -- Line: 151
    -- upvalues: buffer_len (copy), buffer_fill (copy), buffer_create (copy), buffer_copy (copy), buffer_writeu8 (copy)
    local v54 = buffer_len(p51);

    if p52 then
        local v55 = buffer_len(p52) >= v54 + p53;
        assert(v55, "Output buffer out of bounds");
        buffer_fill(p52, v54 + 1, 0, p53 - v54 % p53 - 1);
    else
        p52 = buffer_create(v54 + p53 - v54 % p53);
    end;

    buffer_copy(p52, 0, p51, 0, v54);
    buffer_writeu8(p52, v54, 128);

    return p52;
end;

local function ii7Unpad(p56: buffer, p57: buffer, p58: number) -- Line: 163
    -- upvalues: buffer_len (copy), buffer_readu8 (copy), buffer_create (copy), buffer_copy (copy)
    local v59 = buffer_len(p56) - 1;

    for i = v59, v59 - p58, -1 do
        local v60 = buffer_readu8(p56, i);

        if v60 == 128 then
            if p57 then
                local v61 = i <= buffer_len(p57);
                assert(v61, "Output buffer out of bounds");
            else
                p57 = buffer_create(i);
            end;

            buffer_copy(p57, 0, p56, 0, i);

            return p57;
        end;

        assert(v60 == 0, "Got unexpected padding");
        local _ = i;
    end;

    error("Got unexpected padding");

    return buffer_create(0);
end;

local function zroPad(p62: buffer, p63: buffer, p64: number) -- Line: 188
    -- upvalues: buffer_len (copy), buffer_fill (copy), buffer_create (copy), buffer_copy (copy)
    local v65 = buffer_len(p62);

    if p63 then
        local v66 = buffer_len(p63) >= v65 + p64;
        assert(v66, "Output buffer out of bounds");
        buffer_fill(p63, v65, 0, p64 - v65 % p64);
    else
        p63 = buffer_create(v65 + p64 - v65 % p64);
    end;

    buffer_copy(p63, 0, p62, 0, v65);

    return p63;
end;

local function zroUnpad(p67: buffer, p68: buffer, p69: number) -- Line: 199
    -- upvalues: buffer_len (copy), buffer_readu8 (copy), buffer_create (copy), buffer_copy (copy)
    local v70 = buffer_len(p67) - 1;

    for i = v70, v70 - p69, -1 do
        if buffer_readu8(p67, i) == 0 then
            local v71 = i + 1;

            if p68 then
                local v72 = v71 <= buffer_len(p68);
                assert(v72, "Output buffer out of bounds");
            else
                p68 = buffer_create(v71);
            end;

            buffer_copy(p68, 0, p67, 0, v71);

            return p68;
        end;

        local _ = i;
    end;

    buffer_copy(p68, 0, p67, 0, v70 - p69 - 1);

    return p68;
end;

local v75 = {
    __index = function(p73: any, p74: string) -- Line: 220, Name: __index
        -- upvalues: anxPad (copy), i10Pad (copy), i10Unpad (copy), pksPad (copy), pksUnpad (copy), ii7Pad (copy), ii7Unpad (copy), zroPad (copy), zroUnpad (copy)
        return p74 == "AnsiX923" and {
            Overwrite = nil,
            Pad = anxPad,
            Unpad = anxPad
        } or (p74 == "Iso10126" and {
            Overwrite = nil,
            Pad = i10Pad,
            Unpad = i10Unpad
        } or (p74 == "Pkcs7" and {
            Overwrite = nil,
            Pad = pksPad,
            Unpad = pksUnpad
        } or (p74 == "Iso7816_4" and {
            Overwrite = nil,
            Pad = ii7Pad,
            Unpad = ii7Unpad
        } or (p74 == "Zero" and {
            Overwrite = nil,
            Pad = zroPad,
            Unpad = zroUnpad
        } or nil))));
    end,

    __newindex = function() -- Line: 249, Name: __newindex
    end
};
setmetatable(v1, v75);
v1.AnsiX923 = {};
v1.Iso10126 = {};
v1.Pkcs7 = {};
v1.Iso7816_4 = {};
v1.Zero = {};
table.freeze(v1);
v75.__metatable = "This metatable is locked";

return v1;