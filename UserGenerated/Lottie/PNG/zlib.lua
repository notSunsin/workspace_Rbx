-- Decompiled with Potassium's decompiler.

local u1 = { 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258 };
local u2 = {};
local u3 = {};
local u4 = { 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0 };
local u5 = {};
local u6 = { 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577 };

local function createHuffmanTable(p7: table) -- Line: 56
    local table_create_ret = table.create(15, 0);
    table_create_ret[0] = 0;

    for _, v in p7 do
        if v > 0 then
            table_create_ret[v] = (table_create_ret[v] or 0) + 1;
        end;
    end;

    local table_create_ret2 = table.create(15);
    local v8 = 1;

    for i = 1, 15 do
        v8 = bit32.lshift(v8 + table_create_ret[i - 1], 1);
        table_create_ret2[i] = v8;
        local _ = i;
    end;

    local v9 = {};
    local v10 = {};
    local v11 = {};

    for i, v in p7 do
        if v > 0 then
            v9[table_create_ret2[v]] = i - 1;
            v10[i - 1] = bit32.extract(table_create_ret2[v], 0, v);
            v11[i - 1] = v;
            table_create_ret2[v] = table_create_ret2[v] + 1;
        end;
    end;

    return v9, v10, v11;
end;

local v12 = { 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8 };
local u13 = { 16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15 };
local u14 = { 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13 };

for i = 3, 258 do
    local v15 = i;
    local v16 = nil;

    for i2 = #u1, 1, -1 do
        if u1[i2] <= v15 then
            v16 = i2;
            break;
        end;

        local _ = i2;
    end;

    u2[v15] = 256 + v16;
    u3[v15] = v15 - u1[v16];
    u5[v15] = u4[v16 - 8] or 0;
end;

local u17 = {};

for i = 1, 1024 do
    local v18 = i;
    local v19 = nil;

    for i2 = #u6, 1, -1 do
        if u6[i2] <= v18 then
            v19 = i2;
            break;
        end;

        local _ = i2;
    end;

    u17[v18] = v19;
end;

local u20, u21, u22 = createHuffmanTable(v12);
local u23, u24, u25 = createHuffmanTable(table.create(32, 5));

local function getStoreSize(p26: number) -- Line: 118
    return math.ceil(p26 / 32768) * 5 + p26;
end;

local function getDistIdx(p27: number) -- Line: 122
    -- upvalues: u17 (copy)
    return p27 >= 1025 and (p27 < 1537 and 21 or (p27 < 2049 and 22 or (p27 < 3073 and 23 or (p27 < 4097 and 24 or (p27 < 6145 and 25 or (p27 < 8193 and 26 or (p27 < 12289 and 27 or (p27 < 16385 and 28 or (p27 < 24577 and 29 or 30))))))))) or u17[p27];
end;

local function adler32(p28: buffer, p29: number, p30: number) -- Line: 139
    local v31 = 1;
    local v32 = 0;
    local v33 = 0;

    for i = p29, p29 + p30 - 1 do
        v31 = v31 + buffer.readu8(p28, i);
        v32 = v32 + v31;
        v33 = v33 + 1;
        local v34;

        if v33 == 8400000 then
            v31 = v31 % 65521;
            v32 = v32 % 65521;
            v34 = i;
            v33 = 0;
        else
            v34 = i;
        end;
    end;

    local bit32_lshift_ret = bit32.lshift(v32 % 65521, 16);

    return bit32.bor(bit32_lshift_ret, v31 % 65521);
end;

return {
    inflate = function(u35: buffer, p36: buffer) -- Line: 156, Name: inflate
        -- upvalues: u20 (copy), u23 (copy), u13 (copy), createHuffmanTable (copy), u1 (copy), u4 (copy), u6 (copy), u14 (copy), adler32 (copy)
        local v37, v38, v39, v40, v41, u42, v43, u44, v45, v46, v47, v48, v49, v50, v51, v52;
        local v53 = 0;

        while true do
            local v54, v55, v56;

            if v53 == 0 then
                v53 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, 0);
                local buffer_readu8_ret2 = buffer.readu8(u35, 1);
                local v57 = bit32.extract(buffer_readu8_ret, 0, 4) == 8;
                assert(v57, "invalid zlib comp method");
                local v58 = bit32.extract(buffer_readu8_ret, 4, 4) <= 7;
                assert(v58, "invalid zlib window size");
                local v59 = bit32.extract(buffer_readu8_ret2, 5, 1) == 0;
                assert(v59, "preset dictionary is not allowed");
                local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
                local v60 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2) % 31 == 0;
                assert(v60, "zlib header sum mismatch");
                u42 = 2;
                u44 = 0;

                local function readBit() -- Line: 167
                    -- upvalues: u35 (copy), u42 (ref), u44 (ref)
                    local buffer_readu8_ret3 = buffer.readu8(u35, u42);
                    local bit32_extract_ret = bit32.extract(buffer_readu8_ret3, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    return bit32_extract_ret;
                end;

                local function readBits(p61: number) -- Line: 177
                    -- upvalues: u35 (copy), u42 (ref), u44 (ref)
                    local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, p61);
                    u44 = u44 + p61;
                    u42 = u42 + bit32.rshift(u44, 3);
                    u44 = bit32.band(u44, 7);

                    return buffer_readbits_ret;
                end;

                local function readHuffmanTable(p62: table) -- Line: 185
                    -- upvalues: u35 (copy), u42 (ref), u44 (ref)
                    local buffer_readu8_ret3 = buffer.readu8(u35, u42);
                    local bit32_extract_ret = bit32.extract(buffer_readu8_ret3, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    local v63 = 2 + bit32_extract_ret;

                    while not p62[v63] do
                        local buffer_readu8_ret4 = buffer.readu8(u35, u42);
                        local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret4, u44);
                        u44 = u44 + 1;

                        if u44 == 8 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v63 = 2 * v63 + bit32_extract_ret2;
                    end;

                    return p62[v63];
                end;

                v37 = 0;
                local v64;

                while true do
                    local buffer_readu8_ret3 = buffer.readu8(u35, u42);
                    v38 = bit32.extract(buffer_readu8_ret3, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    v64 = buffer.readbits(u35, u42 * 8 + u44, 2);
                    u44 = u44 + 2;
                    u42 = u42 + bit32.rshift(u44, 3);
                    u44 = bit32.band(u44, 7);
                    assert(v64 ~= 3, "reserved btype");

                    if v64 ~= 0 then
                        break;
                    end;

                    if u44 > 0 then
                        u42 = u42 + 1;
                        u44 = 0;
                    end;

                    local buffer_readu16_ret = buffer.readu16(u35, u42);
                    local buffer_readu16_ret2 = buffer.readu16(u35, u42 + 2);
                    local v65 = bit32.bxor(buffer_readu16_ret, buffer_readu16_ret2) == 65535;
                    assert(v65, "len ~= nlen");
                    u42 = u42 + 4;
                    buffer.copy(p36, v37, u35, u42, buffer_readu16_ret);
                    v37 = v37 + buffer_readu16_ret;
                    u42 = u42 + buffer_readu16_ret;
                    ::l0::;

                    if v38 == 1 then
                        if u44 > 0 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v43 = adler32(p36, 0, buffer.len(p36));
                        v41 = buffer.readu32(u35, u42);
                        v40 = v43 == bit32.byteswap(v41);
                        assert(v40, "adler-32 checksum mismatch");

                        return v37;
                    end;
                end;

                v46 = u20;
                v45 = u23;

                if v64 ~= 2 then
                    ::l2::;
                    v54 = 2;
                    v55 = buffer.readu8(u35, u42);
                    v56 = bit32.extract(v55, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    v48 = v54 + v56;
                    v53 = 3;
                    continue;
                end;

                local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 5);
                u44 = u44 + 5;
                u42 = u42 + bit32.rshift(u44, 3);
                u44 = bit32.band(u44, 7);
                v39 = buffer_readbits_ret + 257;
                local buffer_readbits_ret2 = buffer.readbits(u35, u42 * 8 + u44, 5);
                u44 = u44 + 5;
                u42 = u42 + bit32.rshift(u44, 3);
                u44 = bit32.band(u44, 7);
                v49 = buffer_readbits_ret2 + 1;
                local buffer_readbits_ret3 = buffer.readbits(u35, u42 * 8 + u44, 4);
                u44 = u44 + 4;
                u42 = u42 + bit32.rshift(u44, 3);
                u44 = bit32.band(u44, 7);
                local table_create_ret = table.create(19, 0);

                for i = 1, buffer_readbits_ret3 + 4 do
                    local v66 = u13[i] + 1;
                    local buffer_readbits_ret4 = buffer.readbits(u35, u42 * 8 + u44, 3);
                    u44 = u44 + 3;
                    u42 = u42 + bit32.rshift(u44, 3);
                    u44 = bit32.band(u44, 7);
                    table_create_ret[v66] = buffer_readbits_ret4;
                    local _ = i;
                end;

                v50 = createHuffmanTable(table_create_ret);
                v47 = table.create(v39);
                v51 = nil;
                v53 = 1;
                continue;
            elseif v53 == 1 then
                v53 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, u42);
                local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u44);
                u44 = u44 + 1;

                if u44 == 8 then
                    u44 = 0;
                    u42 = u42 + 1;
                end;

                local v67 = 2 + bit32_extract_ret;

                while not v50[v67] do
                    local buffer_readu8_ret2 = buffer.readu8(u35, u42);
                    local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    v67 = 2 * v67 + bit32_extract_ret2;
                end;

                local v68 = v50[v67];
                local v69 = 1;

                if v68 <= 15 then
                    v51 = v68;
                elseif v68 == 16 then
                    local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 2);
                    u44 = u44 + 2;
                    u42 = u42 + bit32.rshift(u44, 3);
                    u44 = bit32.band(u44, 7);
                    v69 = buffer_readbits_ret + 3;
                elseif v68 == 17 then
                    v51 = 0;
                    local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 3);
                    u44 = u44 + 3;
                    u42 = u42 + bit32.rshift(u44, 3);
                    u44 = bit32.band(u44, 7);
                    v69 = buffer_readbits_ret + 3;
                elseif v68 == 18 then
                    v51 = 0;
                    local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 7);
                    u44 = u44 + 7;
                    u42 = u42 + bit32.rshift(u44, 3);
                    u44 = bit32.band(u44, 7);
                    v69 = buffer_readbits_ret + 11;
                end;

                for i = 1, v69 do
                    table.insert(v47, v51);
                    local _ = i;
                end;

                if v39 <= #v47 then
                    v46 = createHuffmanTable(v47);
                    local table_create_ret = table.create(v49);
                    local v70 = nil;
                    local buffer_readu8_ret2 = buffer.readu8(u35, u42);
                    local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    local v71 = 2 + bit32_extract_ret2;

                    while not v50[v71] do
                        local buffer_readu8_ret3 = buffer.readu8(u35, u42);
                        local bit32_extract_ret3 = bit32.extract(buffer_readu8_ret3, u44);
                        u44 = u44 + 1;

                        if u44 == 8 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v71 = 2 * v71 + bit32_extract_ret3;
                    end;

                    local v72 = v50[v71];
                    local v73 = 1;

                    if v72 <= 15 then
                        v70 = v72;
                    elseif v72 == 16 then
                        local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 2);
                        u44 = u44 + 2;
                        u42 = u42 + bit32.rshift(u44, 3);
                        u44 = bit32.band(u44, 7);
                        v73 = buffer_readbits_ret + 3;
                    elseif v72 == 17 then
                        v70 = 0;
                        local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 3);
                        u44 = u44 + 3;
                        u42 = u42 + bit32.rshift(u44, 3);
                        u44 = bit32.band(u44, 7);
                        v73 = buffer_readbits_ret + 3;
                    elseif v72 == 18 then
                        v70 = 0;
                        local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, 7);
                        u44 = u44 + 7;
                        u42 = u42 + bit32.rshift(u44, 3);
                        u44 = bit32.band(u44, 7);
                        v73 = buffer_readbits_ret + 11;
                    end;

                    for i = 1, v73 do
                        table.insert(table_create_ret, v70);
                        local _ = i;
                    end;

                    if v49 <= #table_create_ret then
                        v45 = createHuffmanTable(table_create_ret);
                        v54 = 2;
                        v55 = buffer.readu8(u35, u42);
                        v56 = bit32.extract(v55, u44);
                        u44 = u44 + 1;

                        if u44 == 8 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v48 = v54 + v56;
                        v53 = 3;
                        continue;
                    end;

                    goto l6;
                end;

                v53 = 1;
                continue;
            elseif v53 == 2 then
                v53 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, u42);
                local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u44);
                u44 = u44 + 1;

                if u44 == 8 then
                    u44 = 0;
                    u42 = u42 + 1;
                end;

                v48 = 2 * v48 + bit32_extract_ret;
                v53 = 3;
                continue;
            elseif v53 == 3 then
                v53 = -1;

                if v46[v48] then
                    v53 = 4;
                    continue;
                else
                    v53 = 2;
                    continue;
                end;

                v53 = 4;
                continue;
            elseif v53 == 4 then
                v53 = -1;
                v52 = v46[v48];

                if v52 < 256 then
                    buffer.writeu8(p36, v37, v52);
                    v37 = v37 + 1;
                elseif v52 > 256 then
                    local v74 = u1[v52 - 256];

                    if v52 > 268 then
                        local v75 = u4[v52 - 264];
                        local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, v75);
                        u44 = u44 + v75;
                        u42 = u42 + bit32.rshift(u44, 3);
                        u44 = bit32.band(u44, 7);
                        v74 = v74 + buffer_readbits_ret;
                    elseif v52 > 264 then
                        local buffer_readu8_ret = buffer.readu8(u35, u42);
                        local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u44);
                        u44 = u44 + 1;

                        if u44 == 8 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v74 = v74 + bit32_extract_ret;
                    end;

                    local buffer_readu8_ret = buffer.readu8(u35, u42);
                    local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u44);
                    u44 = u44 + 1;

                    if u44 == 8 then
                        u44 = 0;
                        u42 = u42 + 1;
                    end;

                    local v76 = 2 + bit32_extract_ret;

                    while not v45[v76] do
                        local buffer_readu8_ret2 = buffer.readu8(u35, u42);
                        local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u44);
                        u44 = u44 + 1;

                        if u44 == 8 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v76 = 2 * v76 + bit32_extract_ret2;
                    end;

                    local v77 = v45[v76];
                    local v78 = u6[v77 + 1];

                    if v77 > 5 then
                        local v79 = u14[v77];
                        local buffer_readbits_ret = buffer.readbits(u35, u42 * 8 + u44, v79);
                        u44 = u44 + v79;
                        u42 = u42 + bit32.rshift(u44, 3);
                        u44 = bit32.band(u44, 7);
                        v78 = v78 + buffer_readbits_ret;
                    elseif v77 > 3 then
                        local buffer_readu8_ret2 = buffer.readu8(u35, u42);
                        local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u44);
                        u44 = u44 + 1;

                        if u44 == 8 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v78 = v78 + bit32_extract_ret2;
                    end;

                    if v74 <= v78 then
                        buffer.copy(p36, v37, p36, v37 - v78, v74);
                        v37 = v37 + v74;
                    else
                        repeat
                            local math_min_ret = math.min(v74, v78);
                            buffer.copy(p36, v37, p36, v37 - v78, math_min_ret);
                            v37 = v37 + math_min_ret;
                            v74 = v74 - math_min_ret;
                            v78 = v78 + math_min_ret;
                        until v74 == 0;
                    end;

                    v53 = 5;
                    continue;
                end;

                v53 = 5;
                continue;
            elseif v53 == 5 then
                v53 = -1;

                if v52 == 256 then
                    if v38 == 1 then
                        if u44 > 0 then
                            u44 = 0;
                            u42 = u42 + 1;
                        end;

                        v43 = adler32(p36, 0, buffer.len(p36));
                        v41 = buffer.readu32(u35, u42);
                        v40 = v43 == bit32.byteswap(v41);
                        assert(v40, "adler-32 checksum mismatch");

                        return v37;
                    end;
                end;

                v54 = 2;
                v55 = buffer.readu8(u35, u42);
                v56 = bit32.extract(v55, u44);
                u44 = u44 + 1;

                if u44 == 8 then
                    u44 = 0;
                    u42 = u42 + 1;
                end;

                v48 = v54 + v56;
                v53 = 3;
                continue;
                break;
            else
                break;
            end;
        end;
    end,

    deflate = function(p80: buffer) -- Line: 322, Name: deflate
        -- upvalues: u21 (copy), u22 (copy), u2 (copy), u3 (copy), u5 (copy), getDistIdx (copy), u24 (copy), u25 (copy), u6 (copy), u14 (copy), adler32 (copy)
        local buffer_len_ret = buffer.len(p80);
        local buffer_create_ret = buffer.create(math.ceil(buffer_len_ret / 32768) * 5 + buffer_len_ret + 6);
        buffer.writeu16(buffer_create_ret, 0, 24184);
        local u81 = 2;
        local u82 = 0;

        local function writeBits(p83: number, p84: number) -- Line: 333
            -- upvalues: buffer_create_ret (copy), u81 (ref), u82 (ref)
            buffer.writebits(buffer_create_ret, u81 * 8 + u82, p84, p83);
            u82 = u82 + p84;
            u81 = u81 + bit32.rshift(u82, 3);
            u82 = bit32.band(u82, 7);
        end;

        local function writeHuffmanBits(p85: number, p86: number) -- Line: 341
            -- upvalues: buffer_create_ret (copy), u81 (ref), u82 (ref)
            local bit32_rshift_ret = bit32.rshift(p85, 1);
            local bit32_band_ret = bit32.band(bit32_rshift_ret, 1431655765);
            local bit32_lshift_ret = bit32.lshift(p85, 1);
            local bit32_band_ret2 = bit32.band(bit32_lshift_ret, 2863311530);
            local bit32_bor_ret = bit32.bor(bit32_band_ret, bit32_band_ret2);
            local bit32_rshift_ret2 = bit32.rshift(bit32_bor_ret, 2);
            local bit32_band_ret3 = bit32.band(bit32_rshift_ret2, 858993459);
            local bit32_lshift_ret2 = bit32.lshift(bit32_bor_ret, 2);
            local bit32_band_ret4 = bit32.band(bit32_lshift_ret2, 3435973836);
            local bit32_bor_ret2 = bit32.bor(bit32_band_ret3, bit32_band_ret4);
            local bit32_rshift_ret3 = bit32.rshift(bit32_bor_ret2, 4);
            local bit32_band_ret5 = bit32.band(bit32_rshift_ret3, 252645135);
            local bit32_lshift_ret3 = bit32.lshift(bit32_bor_ret2, 4);
            local bit32_band_ret6 = bit32.band(bit32_lshift_ret3, 4042322160);
            local bit32_bor_ret3 = bit32.bor(bit32_band_ret5, bit32_band_ret6);
            local bit32_rshift_ret4 = bit32.rshift(bit32_bor_ret3, 8);
            local bit32_band_ret7 = bit32.band(bit32_rshift_ret4, 16711935);
            local bit32_lshift_ret4 = bit32.lshift(bit32_bor_ret3, 8);
            local bit32_band_ret8 = bit32.band(bit32_lshift_ret4, 4278255360);
            local bit32_bor_ret4 = bit32.bor(bit32_band_ret7, bit32_band_ret8);
            local bit32_rshift_ret5 = bit32.rshift(bit32_bor_ret4, 16);
            local bit32_lshift_ret5 = bit32.lshift(bit32_bor_ret4, 16);
            local bit32_bor_ret5 = bit32.bor(bit32_rshift_ret5, bit32_lshift_ret5);
            local bit32_rshift_ret6 = bit32.rshift(bit32_bor_ret5, 32 - p86);
            local v87 = bit32.lshift(1, p86) - 1;
            local bit32_band_ret9 = bit32.band(bit32_rshift_ret6, v87);
            buffer.writebits(buffer_create_ret, u81 * 8 + u82, p86, bit32_band_ret9);
            u82 = u82 + p86;
            u81 = u81 + bit32.rshift(u82, 3);
            u82 = bit32.band(u82, 7);
        end;

        local function writeLitOrLen(p88: number) -- Line: 351
            -- upvalues: writeHuffmanBits (copy), u21 (ref), u22 (ref)
            writeHuffmanBits(u21[p88], u22[p88]);
        end;

        local function writeBackRef(p89: number, p90: number) -- Line: 355
            -- upvalues: u2 (ref), writeHuffmanBits (copy), u21 (ref), u22 (ref), u3 (ref), u5 (ref), buffer_create_ret (copy), u81 (ref), u82 (ref), getDistIdx (ref), u24 (ref), u25 (ref), u6 (ref), u14 (ref)
            local v91 = u2[p90];
            writeHuffmanBits(u21[v91], u22[v91]);

            if p90 > 10 then
                local v92 = u5[p90];
                buffer.writebits(buffer_create_ret, u81 * 8 + u82, v92, u3[p90]);
                u82 = u82 + v92;
                u81 = u81 + bit32.rshift(u82, 3);
                u82 = bit32.band(u82, 7);
            end;

            local v93 = getDistIdx(p89);
            writeHuffmanBits(u24[v93 - 1], u25[v93 - 1]);

            if v93 > 3 then
                local v94 = u14[v93 - 1];
                buffer.writebits(buffer_create_ret, u81 * 8 + u82, v94, p89 - u6[v93]);
                u82 = u82 + v94;
                u81 = u81 + bit32.rshift(u82, 3);
                u82 = bit32.band(u82, 7);
            end;
        end;

        local function getLitOrLenSize(p95: number) -- Line: 367
            -- upvalues: u22 (ref)
            return u22[p95];
        end;

        local function getBackRefSize(p96: number, p97: number) -- Line: 371
            -- upvalues: getDistIdx (ref), u2 (ref), u22 (ref), u5 (ref), u25 (ref), u14 (ref)
            local v98 = getDistIdx(p96);

            return u22[u2[p97]] + u5[p97] + u25[v98 - 1] + (u14[v98 - 1] or 0);
        end;

        local u99 = {};
        local u100 = {};
        local u101 = {};
        local u102 = 0;

        local function insertNode(p103: number, p104: number) -- Line: 384
            -- upvalues: u102 (ref), u99 (copy), u100 (copy)
            u102 = u102 + 1;
            u99[u102] = p103;
            u100[u102] = p104;

            return u102;
        end;

        local function clearTables() -- Line: 391
            -- upvalues: u99 (copy), u100 (copy), u101 (copy), u102 (ref)
            table.clear(u99);
            table.clear(u100);
            table.clear(u101);
            u102 = 0;
        end;

        for i = 0, buffer_len_ret - 1, 32768 do
            local math_min_ret = math.min(buffer_len_ret, i + 32768);
            local v105 = i;
            local v106 = v105;
            local v107 = v105;
            v105 = v106;
            v107 = v106;
            local v108 = {};
            local v109 = 0;

            while v106 < math_min_ret - 3 do
                local buffer_readu32_ret = buffer.readu32(p80, v106);
                local bit32_band_ret = bit32.band(buffer_readu32_ret, 16777215);
                local v110 = u101[bit32_band_ret] or 0;
                u102 = u102 + 1;
                u99[u102] = v106;
                u100[u102] = v110;
                local v111 = u102;
                u101[bit32_band_ret] = v111;
                local v112 = u100[v111];
                local v113 = -1;
                local v114 = 0;
                local v115 = 0;
                local v116, v117;

                while true do
                    if not (v112 and ((u99[v112] or (-1 / 0)) >= v106 - 32510 and (v114 < 12 and v115 < 96))) then
                        v116 = v113;
                        v117 = v115;
                        break;
                    end;

                    v117 = 3;
                    v116 = u99[v112];
                    local v118;

                    if math.min(math_min_ret, v106 + 258) > v106 + v115 and buffer.readu8(p80, v116 + v115) ~= buffer.readu8(p80, v106 + v115) then
                        v118 = true;
                    else
                        v118 = false;
                    end;

                    while not (v118 or (v117 >= 258 or (v106 + v117 >= math_min_ret or buffer.readu8(p80, v116 + v117) ~= buffer.readu8(p80, v106 + v117)))) do
                        v117 = v117 + 1;
                    end;

                    if v115 < v117 then
                        if v117 >= 258 then
                            break;
                        end;
                    else
                        v116 = v113;
                        v117 = v115;
                    end;

                    v112 = u100[v112];
                    v114 = v114 + 1;
                    v115 = v117;
                    v113 = v116;
                end;

                if v117 == 0 then
                    local buffer_readu8_ret = buffer.readu8(p80, v106);
                    v109 = v109 + u22[buffer_readu8_ret];
                    local vector_create_ret = vector.create(0, buffer_readu8_ret);
                    table.insert(v108, vector_create_ret);
                    v106 = v106 + 1;
                else
                    local v119 = getDistIdx(v106 - v116);
                    v109 = v109 + (u22[u2[v117]] + u5[v117] + u25[v119 - 1] + (u14[v119 - 1] or 0));
                    local vector_create_ret = vector.create(1, v106 - v116, v117);
                    table.insert(v108, vector_create_ret);

                    for i2 = v106 + 1, math.min(v106 + v117 - 1, math_min_ret - 4) do
                        local buffer_readu32_ret2 = buffer.readu32(p80, i2);
                        local bit32_band_ret2 = bit32.band(buffer_readu32_ret2, 16777215);
                        local v120 = u101[bit32_band_ret2] or 0;
                        u102 = u102 + 1;
                        u99[u102] = i2;
                        u100[u102] = v120;
                        u101[bit32_band_ret2] = u102;
                        local _ = i2;
                    end;

                    v106 = v106 + v117;
                end;
            end;

            while v106 < math_min_ret do
                local buffer_readu8_ret = buffer.readu8(p80, v106);
                v109 = v109 + u22[buffer_readu8_ret];
                local vector_create_ret = vector.create(0, buffer_readu8_ret);
                table.insert(v108, vector_create_ret);
                v106 = v106 + 1;
            end;

            local v121 = v109 + u22[256];
            table.insert(v108, Vector3.new(0, 256, 0));

            if math_min_ret == buffer_len_ret then
                buffer.writebits(buffer_create_ret, u81 * 8 + u82, 1, 1);
                u82 = u82 + 1;
                u81 = u81 + bit32.rshift(u82, 3);
                u82 = bit32.band(u82, 7);
            else
                buffer.writebits(buffer_create_ret, u81 * 8 + u82, 1, 0);
                u82 = u82 + 1;
                u81 = u81 + bit32.rshift(u82, 3);
                u82 = bit32.band(u82, 7);
            end;

            local v122 = math_min_ret - v105;

            if math.ceil(v121 / 8) + 1 < math.ceil(v122 / 32768) * 5 + v122 then
                buffer.writebits(buffer_create_ret, u81 * 8 + u82, 2, 1);
                u82 = u82 + 2;
                u81 = u81 + bit32.rshift(u82, 3);
                u82 = bit32.band(u82, 7);

                for _, v in v108 do
                    if v.x == 0 then
                        local y = v.y;
                        writeHuffmanBits(u21[y], u22[y]);
                    else
                        writeBackRef(v.y, v.z);
                    end;
                end;
            else
                buffer.writebits(buffer_create_ret, u81 * 8 + u82, 2, 0);
                u82 = u82 + 2;
                u81 = u81 + bit32.rshift(u82, 3);
                u82 = bit32.band(u82, 7);

                if u82 > 0 then
                    u81 = u81 + 1;
                    u82 = 0;
                end;

                buffer.writeu16(buffer_create_ret, u81, v122);
                local bit32_bxor_ret = bit32.bxor(65535, v122);
                buffer.writeu16(buffer_create_ret, u81 + 2, bit32_bxor_ret);
                buffer.copy(buffer_create_ret, u81 + 4, p80, v105, v122);
                u81 = u81 + (v122 + 4);
            end;

            if u102 > 50000 then
                table.clear(u99);
                table.clear(u100);
                table.clear(u101);
                u102 = 0;
            end;
        end;

        if u82 > 0 then
            u81 = u81 + 1;
        end;

        local v123 = adler32(p80, 0, buffer.len(p80));
        local bit32_byteswap_ret = bit32.byteswap(v123);
        buffer.writeu32(buffer_create_ret, u81, bit32_byteswap_ret);

        return buffer_create_ret, u81 + 4;
    end
};