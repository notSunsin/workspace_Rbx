-- Decompiled with Potassium's decompiler.

require(script.Types);
local script_chunks = require(script.chunks);
local script_crc32 = require(script.crc32);
local script_zlib = require(script.zlib);
local u1 = {
    [0] = 1,
    [2] = 3,
    [3] = 1,
    [4] = 2,
    [6] = 4
};
local u2 = { 0, 0, 4, 0, 2, 0, 1 };
local u3 = { 0, 4, 0, 2, 0, 1, 0 };
local u4 = { 8, 8, 8, 4, 4, 2, 2 };
local u5 = { 8, 8, 4, 4, 2, 2, 1 };

return {
    decode = function(p6: buffer, p7: table?) -- Line: 38, Name: decode
        -- upvalues: script_crc32 (copy), script_chunks (copy), u1 (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy), script_zlib (copy)
        local buffer_len_ret = buffer.len(p6);
        assert(buffer_len_ret >= 8, "not a PNG");
        local v8 = buffer.readstring(p6, 0, 8) == "\137PNG\r\n\26\n";
        assert(v8, "not a PNG");
        local table_create_ret = table.create(3);
        local v9 = 8;
        local v10;

        if p7 == nil then
            v10 = false;
        elseif p7.allowIncorrectCRC == true then
            v10 = true;
        else
            v10 = false;
        end;

        local v11;

        while true do
            local buffer_readu32_ret = buffer.readu32(p6, v9);
            local bit32_byteswap_ret = bit32.byteswap(buffer_readu32_ret);
            local buffer_readstring_ret = buffer.readstring(p6, v9 + 4, 4);
            local string_match_ret = string.match(buffer_readstring_ret, "%a%a%a%a");
            local v12 = `invalid chunk type {buffer_readstring_ret}`;
            assert(string_match_ret, v12);
            local v13 = v9 + 8;
            v11 = v13 + bit32_byteswap_ret + 4;
            local v14 = `EOF while reading {buffer_readstring_ret} chunk`;
            assert(v11 <= buffer_len_ret, v14);
            local buffer_readu32_ret2 = buffer.readu32(p6, v11 - 4);
            local v15 = v10 or bit32.byteswap(buffer_readu32_ret2) == script_crc32(p6, v9 + 4, v11 - 5);
            local v16 = `incorrect checksum in {buffer_readstring_ret}`;
            assert(v15, v16);
            table.insert(table_create_ret, {
                type = buffer_readstring_ret,
                offset = v13,
                length = bit32_byteswap_ret
            });

            if buffer_len_ret <= v11 then
                break;
            end;

            v9 = v11;
        end;

        assert(v11 == buffer_len_ret, "trailing data in file");

        for _, v in table_create_ret do
            local type = v.type;
            local string_byte_ret = string.byte(type, 1, 1);

            if bit32.extract(string_byte_ret, 5) == 0 and (type ~= "IHDR" and (type ~= "IDAT" and (type ~= "PLTE" and type ~= "IEND"))) then
                error((`unhandled critical chunk {type}`));
            end;
        end;

        local v17 = table_create_ret[1];
        assert(v17.type == "IHDR", "first chunk must be IHDR");

        for i = 2, #table_create_ret do
            assert(table_create_ret[i].type ~= "IHDR", "multiple IHDR chunks are not allowed");
            local _ = i;
        end;

        local v18 = script_chunks.IHDR(p6, v17);
        local v19 = -1;
        local v20 = -1;
        local v21 = 0;

        for i, v in table_create_ret do
            if v.type == "IDAT" then
                if v19 < 0 then
                    v19 = i;
                else
                    assert(i == v20 + 1, "multiple IDAT chunks must be consecutive");
                end;

                v21 = v21 + v.length;
                v20 = i;
            end;
        end;

        assert(v19 > 0, "no IDAT chunks");
        assert(v21 > 0, "no image data in IDAT chunks");
        local v22 = nil;
        local v23 = -1;

        for i, v in table_create_ret do
            if v.type == "PLTE" then
                assert(not v22, "multiple PLTE chunks are not allowed");
                assert(i < v19, "PLTE not allowed after IDAT chunks");
                local v24;

                if v18.colorType == 0 then
                    v24 = false;
                else
                    v24 = v18.colorType ~= 4;
                end;

                assert(v24, "PLTE not allowed for color type");
                v22 = script_chunks.PLTE(p6, v, v18);
                v23 = i;
            end;
        end;

        if v18.colorType == 3 then
            assert(v22 ~= nil, "color type requires a PLTE chunk");
        end;

        local v25 = nil;

        for i, v in table_create_ret do
            if v.type == "tRNS" then
                assert(v25 == nil, "multiple tRNS chunks are not allowed");
                assert(i < v19, "tRNS not allowed after IDAT chunks");
                assert(not v22 or v23 < i, "tRNS must be after PLTE");
                local v26;

                if v18.colorType == 4 then
                    v26 = false;
                else
                    v26 = v18.colorType ~= 6;
                end;

                assert(v26, "tRNS not allowed for color type");
                v25 = script_chunks.tRNS(p6, v, v18, v22);
            end;
        end;

        local v27 = table_create_ret[#table_create_ret];
        assert(v27.type == "IEND", "final chunk must be IEND");
        assert(v27.length == 0, "IEND chunk must be empty");

        for i = 2, #table_create_ret - 1 do
            assert(table_create_ret[i].type ~= "IEND", "multiple IEND chunks are not allowed");
            local _ = i;
        end;

        local buffer_create_ret = buffer.create(v21);
        local v28 = 0;

        for _, v in table_create_ret do
            if v.type == "IDAT" then
                buffer.copy(buffer_create_ret, v28, p6, v.offset, v.length);
                v28 = v28 + v.length;
            end;
        end;

        local width = v18.width;
        local height = v18.height;
        local bitDepth = v18.bitDepth;
        local colorType = v18.colorType;
        local u29 = u1[colorType];
        local v30 = 0;

        if v18.interlaced then
            for i = 1, 7 do
                local math_ceil_ret = math.ceil((width - u3[i]) / u5[i]);
                local math_ceil_ret2 = math.ceil((height - u2[i]) / u4[i]);
                local v31;

                if math_ceil_ret > 0 and math_ceil_ret2 > 0 then
                    v30 = v30 + math_ceil_ret2 * (math.ceil(math_ceil_ret * u29 * bitDepth / 8) + 1);
                    v31 = i;
                else
                    v31 = i;
                end;
            end;
        else
            v30 = height * (math.ceil(width * u29 * bitDepth / 8) + 1);
        end;

        local u32;

        if v22 then
            u32 = v22.colors;
        else
            u32 = nil;
        end;

        local u33;

        if colorType == 3 or bitDepth >= 8 then
            u33 = nil;
        else
            u33 = 255 / (2 ^ bitDepth - 1);
        end;

        local math_ceil_ret = math.ceil(u29 * bitDepth / 8);
        local u34 = 2 ^ bitDepth - 1;
        local u35 = 0;
        local buffer_create_ret2 = buffer.create(v30);
        local v36 = script_zlib.inflate(buffer_create_ret, buffer_create_ret2) == v30;
        assert(v36, "decompressed data size mismatch");
        local buffer_create_ret3 = buffer.create(width * height * 4);
        local u37 = not v25 and -1 or v25.gray;
        local u38 = not v25 and -1 or v25.red;
        local u39 = not v25 and -1 or v25.green;
        local u40 = not v25 and -1 or v25.blue;

        local function pass(p41: number, p42: number, p43: number, p44: number) -- Line: 190
            -- upvalues: width (copy), height (copy), u29 (copy), bitDepth (copy), u35 (ref), buffer_create_ret2 (copy), math_ceil_ret (copy), colorType (copy), u37 (copy), u34 (copy), u38 (copy), u39 (copy), u40 (copy), u32 (ref), u33 (ref), buffer_create_ret3 (copy)
            local math_ceil_ret2 = math.ceil((width - p41) / p43);
            local math_ceil_ret3 = math.ceil((height - p42) / p44);

            if math_ceil_ret2 < 1 or math_ceil_ret3 < 1 then
                return;
            end;

            local math_ceil_ret4 = math.ceil(math_ceil_ret2 * u29 * bitDepth / 8);
            local u45 = u35;

            for i = 1, math_ceil_ret3 do
                local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u35);
                u35 = u35 + 1;
                local v46;

                if buffer_readu8_ret == 0 or buffer_readu8_ret == 2 and i == 1 then
                    u35 = u35 + math_ceil_ret4;
                    v46 = i;
                elseif buffer_readu8_ret == 1 then
                    v46 = i;

                    for i2 = 1, math_ceil_ret4 do
                        local v47 = i2 <= math_ceil_ret and 0 or buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret);
                        local v48 = buffer.readu8(buffer_create_ret2, u35) + v47;
                        local bit32_band_ret = bit32.band(v48, 255);
                        buffer.writeu8(buffer_create_ret2, u35, bit32_band_ret);
                        u35 = u35 + 1;
                        local _ = i2;
                    end;
                elseif buffer_readu8_ret == 2 then
                    v46 = i;

                    for i2 = 1, math_ceil_ret4 do
                        local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret4 - 1);
                        local v49 = buffer.readu8(buffer_create_ret2, u35) + buffer_readu8_ret2;
                        local bit32_band_ret = bit32.band(v49, 255);
                        buffer.writeu8(buffer_create_ret2, u35, bit32_band_ret);
                        u35 = u35 + 1;
                        local _ = i2;
                    end;
                elseif buffer_readu8_ret == 3 then
                    v46 = i;

                    for i2 = 1, math_ceil_ret4 do
                        local v50 = i2 <= math_ceil_ret and 0 or buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret);
                        local v51 = v46 == 1 and 0 or buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret4 - 1);
                        local v52 = buffer.readu8(buffer_create_ret2, u35) + bit32.rshift(v50 + v51, 1);
                        local bit32_band_ret = bit32.band(v52, 255);
                        buffer.writeu8(buffer_create_ret2, u35, bit32_band_ret);
                        u35 = u35 + 1;
                        local _ = i2;
                    end;
                elseif buffer_readu8_ret == 4 then
                    v46 = i;

                    for i2 = 1, math_ceil_ret4 do
                        local v53 = i2 <= math_ceil_ret and 0 or buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret);
                        local v54 = v46 == 1 and 0 or buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret4 - 1);
                        local v55 = (i2 <= math_ceil_ret or v46 == 1) and 0 or buffer.readu8(buffer_create_ret2, u35 - math_ceil_ret4 - math_ceil_ret - 1);
                        local math_abs_ret = math.abs(v54 - v55);
                        local math_abs_ret2 = math.abs(v53 - v55);
                        local math_abs_ret3 = math.abs(v53 + v54 - v55 * 2);

                        if math_abs_ret <= math_abs_ret2 and math_abs_ret <= math_abs_ret3 then
                            v55 = v53;
                        elseif math_abs_ret2 <= math_abs_ret3 then
                            v55 = v54;
                        end;

                        local v56 = buffer.readu8(buffer_create_ret2, u35) + v55;
                        local bit32_band_ret = bit32.band(v56, 255);
                        buffer.writeu8(buffer_create_ret2, u35, bit32_band_ret);
                        u35 = u35 + 1;
                        local _ = i2;
                    end;
                else
                    error("invalid row filter");
                    v46 = i;
                end;
            end;

            local u57 = 8;

            local function readValue() -- Line: 249
                -- upvalues: buffer_create_ret2 (ref), u45 (ref), bitDepth (ref), u57 (ref)
                local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45);
                local v58;

                if bitDepth < 8 then
                    v58 = bit32.extract(buffer_readu8_ret, u57 - bitDepth, bitDepth);
                    u57 = u57 - bitDepth;

                    if u57 == 0 then
                        u57 = 8;
                        u45 = u45 + 1;

                        return v58;
                    end;
                else
                    if bitDepth == 8 then
                        u45 = u45 + 1;

                        return buffer_readu8_ret;
                    end;

                    local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
                    local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret2, u45 + 1);
                    v58 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2);
                    u45 = u45 + 2;
                end;

                return v58;
            end;

            for i = 1, math_ceil_ret3 do
                u45 = u45 + 1;

                if u57 < 8 then
                    u57 = 8;
                    u45 = u45 + 1;
                end;

                local v59 = i;

                for i2 = 1, math_ceil_ret2 do
                    local v60 = nil;
                    local v61 = nil;
                    local v62 = nil;
                    local v63 = nil;

                    if colorType == 0 then
                        v60 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v60 = bit32.extract(v60, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v60, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v60 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        if v60 == u37 then
                            v62 = v60;
                            v61 = v62;
                            local v64 = v62;
                            v62 = v61;
                            v64 = v61;
                            v63 = 0;
                        else
                            v63 = u34;
                            v62 = v60;
                            v61 = v62;
                            local v65 = v62;
                            v62 = v61;
                            v65 = v61;
                        end;
                    elseif colorType == 2 then
                        v60 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v60 = bit32.extract(v60, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v60, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v60 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        v61 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v61 = bit32.extract(v61, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v61, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v61 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        v62 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v62 = bit32.extract(v62, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v62, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v62 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        if v60 == u38 and (v61 == u39 and v62 == u40) then
                            v63 = 0;
                        else
                            v63 = u34;
                        end;
                    elseif colorType == 3 then
                        local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            buffer_readu8_ret = bit32.extract(buffer_readu8_ret, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
                            local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret2, u45 + 1);
                            buffer_readu8_ret = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2);
                            u45 = u45 + 2;
                        end;

                        local v66 = u32[buffer_readu8_ret + 1];
                        v60 = v66.r;
                        v61 = v66.g;
                        v62 = v66.b;
                        v63 = v66.a;
                    elseif colorType == 4 then
                        v60 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v60 = bit32.extract(v60, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v60, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v60 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        v63 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v63 = bit32.extract(v63, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                                v62 = v60;
                                v61 = v62;
                                local v67 = v62;
                                v62 = v61;
                                v67 = v61;
                                v61 = v62;
                            else
                                v62 = v60;
                                v61 = v62;
                                local v68 = v62;
                                v62 = v61;
                                v68 = v61;
                                v61 = v62;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                            v62 = v60;
                            v61 = v62;
                            local v69 = v62;
                            v62 = v61;
                            v69 = v61;
                            v61 = v62;
                        else
                            local bit32_lshift_ret = bit32.lshift(v63, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v63 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                            v62 = v60;
                            v61 = v62;
                            local v70 = v62;
                            v62 = v61;
                            v70 = v61;
                            v61 = v62;
                        end;
                    elseif colorType == 6 then
                        v60 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v60 = bit32.extract(v60, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v60, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v60 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        v61 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v61 = bit32.extract(v61, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v61, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v61 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        v62 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v62 = bit32.extract(v62, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v62, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v62 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;

                        v63 = buffer.readu8(buffer_create_ret2, u45);

                        if bitDepth < 8 then
                            v63 = bit32.extract(v63, u57 - bitDepth, bitDepth);
                            u57 = u57 - bitDepth;

                            if u57 == 0 then
                                u57 = 8;
                                u45 = u45 + 1;
                            end;
                        elseif bitDepth == 8 then
                            u45 = u45 + 1;
                        else
                            local bit32_lshift_ret = bit32.lshift(v63, 8);
                            local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, u45 + 1);
                            v63 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret);
                            u45 = u45 + 2;
                        end;
                    end;

                    if u33 then
                        v60 = math.round(v60 * u33);
                        v61 = math.round(v61 * u33);
                        v62 = math.round(v62 * u33);
                        v63 = math.round(v63 * u33);
                    elseif bitDepth == 16 then
                        v60 = bit32.rshift(v60, 8);
                        v61 = bit32.rshift(v61, 8);
                        v62 = bit32.rshift(v62, 8);
                        v63 = bit32.rshift(v63, 8);
                    end;

                    local bit32_lshift_ret = bit32.lshift(v63, 24);
                    local bit32_lshift_ret2 = bit32.lshift(v62, 16);
                    local bit32_lshift_ret3 = bit32.lshift(v61, 8);
                    local bit32_bor_ret = bit32.bor(bit32_lshift_ret, bit32_lshift_ret2, bit32_lshift_ret3, v60);
                    buffer.writeu32(buffer_create_ret3, ((p42 + (v59 - 1) * p44) * width + (p41 + (i2 - 1) * p43)) * 4, bit32_bor_ret);
                    local _ = i2;
                end;
            end;
        end;

        if v18.interlaced then
            for i = 1, 7 do
                pass(u3[i], u2[i], u5[i], u4[i]);
                local _ = i;
            end;
        else
            pass(0, 0, 1, 1);
        end;

        return {
            width = width,
            height = height,
            pixels = buffer_create_ret3,

            readPixel = function(p71: number, p72: number) -- Line: 336, Name: readPixel
                -- upvalues: width (copy), height (copy), buffer_create_ret3 (copy)
                local v73;

                if p71 >= 1 and (p71 <= width and p72 >= 1) then
                    v73 = p72 <= height;
                else
                    v73 = false;
                end;

                assert(v73, "pixel out of range");
                local v74 = ((p72 - 1) * width + p71 - 1) * 4;

                return buffer.readu8(buffer_create_ret3, v74), buffer.readu8(buffer_create_ret3, v74 + 1), buffer.readu8(buffer_create_ret3, v74 + 2), buffer.readu8(buffer_create_ret3, v74 + 3);
            end
        };
    end,

    encode = function(p75: buffer, p76: table) -- Line: 354, Name: encode
        -- upvalues: script_zlib (copy), script_crc32 (copy)
        local width = p76.width;
        local height = p76.height;
        local buffer_len_ret = buffer.len(p75);
        local v77 = width * height * 4;
        local v78 = `expected {v77} bytes, got {buffer_len_ret} bytes`;
        assert(buffer_len_ret == v77, v78);
        local v79 = width * 4 + 1;
        local buffer_create_ret = buffer.create(height * v79);

        for i = 0, height - 1 do
            local v80 = i * v79;
            buffer.writeu8(buffer_create_ret, v80, 0);
            buffer.copy(buffer_create_ret, v80 + 1, p75, i * width * 4, width * 4);
            local _ = i;
        end;

        local v81, v82 = script_zlib.deflate(buffer_create_ret);
        local buffer_create_ret2 = buffer.create(33 + (8 + v82 + 4) + 12);
        buffer.writestring(buffer_create_ret2, 0, "\137PNG\r\n\26\n");
        local bit32_byteswap_ret = bit32.byteswap(13);
        buffer.writeu32(buffer_create_ret2, 8, bit32_byteswap_ret);
        buffer.writestring(buffer_create_ret2, 12, "IHDR");
        local bit32_byteswap_ret2 = bit32.byteswap(width);
        buffer.writeu32(buffer_create_ret2, 16, bit32_byteswap_ret2);
        local bit32_byteswap_ret3 = bit32.byteswap(height);
        buffer.writeu32(buffer_create_ret2, 20, bit32_byteswap_ret3);
        buffer.writeu8(buffer_create_ret2, 24, 8);
        buffer.writeu8(buffer_create_ret2, 25, 6);
        buffer.writeu8(buffer_create_ret2, 26, 0);
        buffer.writeu8(buffer_create_ret2, 27, 0);
        buffer.writeu8(buffer_create_ret2, 28, 0);
        local v83 = script_crc32(buffer_create_ret2, 12, 28);
        local bit32_byteswap_ret4 = bit32.byteswap(v83);
        buffer.writeu32(buffer_create_ret2, 29, bit32_byteswap_ret4);
        local bit32_byteswap_ret5 = bit32.byteswap(v82);
        buffer.writeu32(buffer_create_ret2, 33, bit32_byteswap_ret5);
        buffer.writestring(buffer_create_ret2, 37, "IDAT");
        buffer.copy(buffer_create_ret2, 41, v81, 0, v82);
        local v84 = 41 + v82;
        local v85 = script_crc32(buffer_create_ret2, 37, v84 - 1);
        local bit32_byteswap_ret6 = bit32.byteswap(v85);
        buffer.writeu32(buffer_create_ret2, v84, bit32_byteswap_ret6);
        buffer.writeu32(buffer_create_ret2, v84 + 4, 0);
        buffer.writestring(buffer_create_ret2, v84 + 8, "IEND");
        buffer.writeu32(buffer_create_ret2, v84 + 12, 2187346606);

        return buffer_create_ret2;
    end
};