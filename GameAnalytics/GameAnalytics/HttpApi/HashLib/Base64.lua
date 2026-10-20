-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};

for i = 65, 90 do
    table.insert(u1, i);
    local _ = i;
end;

for i = 97, 122 do
    table.insert(u1, i);
    local _ = i;
end;

table.insert(u1, 48);
table.insert(u1, 49);
table.insert(u1, 50);
table.insert(u1, 51);
table.insert(u1, 52);
table.insert(u1, 53);
table.insert(u1, 54);
table.insert(u1, 55);
table.insert(u1, 56);
table.insert(u1, 57);
table.insert(u1, 43);
table.insert(u1, 47);

for i, v in ipairs(u1) do
    u2[v] = i;
end;

local v3 = {};
local bit32_rshift = bit32.rshift;
local bit32_lshift = bit32.lshift;
local bit32_band = bit32.band;

function v3.Encode(p4) -- Line: 38
    -- upvalues: bit32_rshift (copy), bit32_band (copy), bit32_lshift (copy), u1 (copy)
    local v5 = 0;
    local v6 = {};

    for i = 1, #p4, 3 do
        local string_byte_ret, v7, v8 = string.byte(p4, i, i + 2);
        local v9 = bit32_rshift(string_byte_ret, 2);
        local v10 = bit32_lshift(bit32_band(string_byte_ret, 3), 4) + bit32_rshift(v7 or 0, 4);
        local v11 = bit32_lshift(bit32_band(v7 or 0, 15), 2) + bit32_rshift(v8 or 0, 6);
        local v12 = bit32_band(v8 or 0, 63);
        local v13 = v5 + 1;
        v6[v13] = u1[v9 + 1];
        local v14 = v13 + 1;
        v6[v14] = u1[v10 + 1];
        local v15 = v14 + 1;
        v6[v15] = v7 and u1[v11 + 1] or 61;
        v5 = v15 + 1;
        v6[v5] = v8 and u1[v12 + 1] or 61;
        local _ = i;
    end;

    local v16 = 0;
    local v17 = {};

    for i = 1, v5, 4096 do
        v16 = v16 + 1;
        local v18 = i + 4096 - 1;
        v17[v16] = string.char(table.unpack(v6, i, v5 < v18 and v5 and v5 or v18));
        local _ = i;
    end;

    return table.concat(v17);
end;

function v3.Decode(p19) -- Line: 86
    -- upvalues: u2 (copy), bit32_lshift (copy), bit32_rshift (copy), bit32_band (copy)
    local v20 = 0;
    local v21 = {};

    for i = 1, #p19, 4 do
        local string_byte_ret, v22, v23, v24 = string.byte(p19, i, i + 3);
        local v25 = u2[v22] - 1;
        local v26 = (u2[v23] or 1) - 1;
        local v27 = (u2[v24] or 1) - 1;
        local v28 = bit32_lshift(u2[string_byte_ret] - 1, 2) + bit32_rshift(v25, 4);
        local v29 = bit32_lshift(bit32_band(v25, 15), 4) + bit32_rshift(v26, 2);
        local v30 = bit32_lshift(bit32_band(v26, 3), 6) + v27;
        v20 = v20 + 1;
        v21[v20] = v28;

        if v23 ~= 61 then
            v20 = v20 + 1;
            v21[v20] = v29;
        end;

        local v31;

        if v24 == 61 then
            v31 = i;
        else
            v20 = v20 + 1;
            v21[v20] = v30;
            v31 = i;
        end;
    end;

    local v32 = 0;
    local v33 = {};

    for i = 1, v20, 4096 do
        v32 = v32 + 1;
        local v34 = i + 4096 - 1;
        v33[v32] = string.char(table.unpack(v21, i, v20 < v34 and v20 and v20 or v34));
        local _ = i;
    end;

    return table.concat(v33);
end;

return v3;