-- Decompiled with Potassium's decompiler.

local bit32_bxor = bit32.bxor;
local buffer_copy = buffer.copy;
local buffer_create = buffer.create;
local buffer_len = buffer.len;
local buffer_readu8 = buffer.readu8;
local buffer_readu32 = buffer.readu32;
local _ = buffer.tostring;
local buffer_writestring = buffer.writestring;
local buffer_writeu8 = buffer.writeu8;
local buffer_writeu32 = buffer.writeu32;
local _ = math.floor;
local math_random = math.random;
local string_pack = string.pack;
local u1 = buffer_create(16);

local function addByteCtr(p2: buffer, p3: number, p4: number, p5: number, p6: boolean) -- Line: 44
    -- upvalues: buffer_readu8 (copy), buffer_writeu8 (copy)
    if not p6 then
        local v7 = buffer_readu8(p2, p5) + p3;
        buffer_writeu8(p2, p5, v7);

        if v7 >= 256 then
            for i = p5 - 1, p4, -1 do
                local v8 = buffer_readu8(p2, i) + 1;
                buffer_writeu8(p2, i, v8);

                if v8 < 256 then
                    break;
                end;

                local _ = i;
            end;
        end;
    end;

    local v9 = buffer_readu8(p2, p4) + p3;
    buffer_writeu8(p2, p4, v9);

    if v9 >= 256 then
        for i = p4 + 1, p5 do
            local v10 = buffer_readu8(p2, i) + 1;
            buffer_writeu8(p2, i, v10);

            if v10 < 256 then
            end;

            local _ = i;
        end;
    end;
end;

local v21 = {
    ECB = {
        FwdMode = function(p11, p12, p13, p14) -- Line: 81, Name: FwdMode
            -- upvalues: buffer_len (copy)
            local v15 = buffer_len(p13) - 16;
            assert(v15 % 16 == 0, "Input length must be a multiple of 16 bytes");

            for i = 0, v15, 16 do
                p11(p13, i, p14, i);
                local _ = i;
            end;
        end,

        InvMode = function(p16, p17, p18, p19) -- Line: 88, Name: InvMode
            -- upvalues: buffer_len (copy)
            local v20 = buffer_len(p18) - 16;
            assert(v20 % 16 == 0, "Input length must be a multiple of 16 bytes");

            for i = 0, v20, 16 do
                p17(p18, i, p19, i);
                local _ = i;
            end;
        end
    }
};
table.freeze(v21.ECB);
v21.CBC = {
    FwdMode = function(p22, p23, p24, p25, p26, p27) -- Line: 105, Name: FwdMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v28 = buffer_len(p24) - 16;
        assert(v28 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v29 = p27 or u1;
        local v30 = buffer_len(v29) == 16;
        assert(v30, "Initialization vector must be 16 bytes long");
        buffer_writeu32(p25, 0, (bit32_bxor(buffer_readu32(p24, 0), (buffer_readu32(v29, 0)))));
        buffer_writeu32(p25, 4, (bit32_bxor(buffer_readu32(p24, 4), (buffer_readu32(v29, 4)))));
        buffer_writeu32(p25, 8, (bit32_bxor(buffer_readu32(p24, 8), (buffer_readu32(v29, 8)))));
        buffer_writeu32(p25, 12, (bit32_bxor(buffer_readu32(p24, 12), (buffer_readu32(v29, 12)))));
        p22(p25, 0, p25, 0);

        for i = 16, v28, 16 do
            buffer_writeu32(p25, i, (bit32_bxor(buffer_readu32(p24, i), (buffer_readu32(p25, i - 16)))));
            buffer_writeu32(p25, i + 4, (bit32_bxor(buffer_readu32(p24, i + 4), (buffer_readu32(p25, i - 12)))));
            buffer_writeu32(p25, i + 8, (bit32_bxor(buffer_readu32(p24, i + 8), (buffer_readu32(p25, i - 8)))));
            buffer_writeu32(p25, i + 12, (bit32_bxor(buffer_readu32(p24, i + 12), (buffer_readu32(p25, i - 4)))));
            p22(p25, i, p25, i);
            local _ = i;
        end;
    end,

    InvMode = function(p31, p32, p33, p34, p35, p36) -- Line: 123, Name: InvMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v37 = buffer_len(p33) - 16;
        assert(v37 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v38 = p36 or u1;
        local v39 = buffer_len(v38) == 16;
        assert(v39, "Initialization vector must be 16 bytes long");
        local v40 = buffer_readu32(p33, 0);
        local v41 = buffer_readu32(p33, 4);
        local v42 = buffer_readu32(p33, 8);
        local v43 = buffer_readu32(p33, 12);
        p32(p33, 0, p34, 0);
        buffer_writeu32(p34, 0, (bit32_bxor(buffer_readu32(p34, 0), (buffer_readu32(v38, 0)))));
        buffer_writeu32(p34, 4, (bit32_bxor(buffer_readu32(p34, 4), (buffer_readu32(v38, 4)))));
        buffer_writeu32(p34, 8, (bit32_bxor(buffer_readu32(p34, 8), (buffer_readu32(v38, 8)))));
        buffer_writeu32(p34, 12, (bit32_bxor(buffer_readu32(p34, 12), (buffer_readu32(v38, 12)))));

        for i = 16, v37, 16 do
            local v44 = buffer_readu32(p33, i);
            local v45 = buffer_readu32(p33, i + 4);
            local v46 = buffer_readu32(p33, i + 8);
            local v47 = buffer_readu32(p33, i + 12);
            p32(p33, i, p34, i);
            buffer_writeu32(p34, i, (bit32_bxor(buffer_readu32(p34, i), v40)));
            buffer_writeu32(p34, i + 4, (bit32_bxor(buffer_readu32(p34, i + 4), v41)));
            buffer_writeu32(p34, i + 8, (bit32_bxor(buffer_readu32(p34, i + 8), v42)));
            buffer_writeu32(p34, i + 12, (bit32_bxor(buffer_readu32(p34, i + 12), v43)));
            v40 = v44;
            v43 = v47;
            v42 = v46;
            v41 = v45;
            local _ = i;
        end;
    end
};
table.freeze(v21.CBC);
v21.PCBC = {
    FwdMode = function(p48, p49, p50, p51, p52, p53) -- Line: 161, Name: FwdMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v54 = buffer_len(p50) - 16;
        assert(v54 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v55 = p53 or u1;
        local v56 = buffer_len(v55) == 16;
        assert(v56, "Initialization vector must be 16 bytes long");
        local v57 = buffer_readu32(p50, 0);
        local v58 = buffer_readu32(p50, 4);
        local v59 = buffer_readu32(p50, 8);
        local v60 = buffer_readu32(p50, 12);
        buffer_writeu32(p51, 0, (bit32_bxor(v57, (buffer_readu32(v55, 0)))));
        buffer_writeu32(p51, 4, (bit32_bxor(v58, (buffer_readu32(v55, 4)))));
        buffer_writeu32(p51, 8, (bit32_bxor(v59, (buffer_readu32(v55, 8)))));
        buffer_writeu32(p51, 12, (bit32_bxor(v60, (buffer_readu32(v55, 12)))));
        p48(p51, 0, p51, 0);

        for i = 16, v54, 16 do
            local v61 = buffer_readu32(p50, i);
            local v62 = buffer_readu32(p50, i + 4);
            local v63 = buffer_readu32(p50, i + 8);
            local v64 = buffer_readu32(p50, i + 12);
            buffer_writeu32(p51, i, (bit32_bxor(v57, v61, (buffer_readu32(p51, i - 16)))));
            buffer_writeu32(p51, i + 4, (bit32_bxor(v58, v62, (buffer_readu32(p51, i - 12)))));
            buffer_writeu32(p51, i + 8, (bit32_bxor(v59, v63, (buffer_readu32(p51, i - 8)))));
            buffer_writeu32(p51, i + 12, (bit32_bxor(v60, v64, (buffer_readu32(p51, i - 4)))));
            p48(p51, i, p51, i);
            v58 = v62;
            v57 = v61;
            v60 = v64;
            v59 = v63;
            local _ = i;
        end;
    end,

    InvMode = function(p65, p66, p67, p68, p69, p70) -- Line: 189, Name: InvMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v71 = buffer_len(p67) - 16;
        assert(v71 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v72 = p70 or u1;
        local v73 = buffer_len(v72) == 16;
        assert(v73, "Initialization vector must be 16 bytes long");
        local v74 = buffer_readu32(p67, 0);
        local v75 = buffer_readu32(p67, 4);
        local v76 = buffer_readu32(p67, 8);
        local v77 = buffer_readu32(p67, 12);
        p66(p67, 0, p68, 0);
        local v78 = bit32_bxor(buffer_readu32(p68, 0), (buffer_readu32(v72, 0)));
        local v79 = bit32_bxor(buffer_readu32(p68, 4), (buffer_readu32(v72, 4)));
        local v80 = bit32_bxor(buffer_readu32(p68, 8), (buffer_readu32(v72, 8)));
        local v81 = bit32_bxor(buffer_readu32(p68, 12), (buffer_readu32(v72, 12)));
        buffer_writeu32(p68, 0, v78);
        buffer_writeu32(p68, 4, v79);
        buffer_writeu32(p68, 8, v80);
        buffer_writeu32(p68, 12, v81);
        local v82 = 12;
        local v83 = 0;
        local v84 = 4;
        local v85 = 8;

        for i = 16, v71, 16 do
            v83 = v83 + 16;
            v84 = v84 + 16;
            v85 = v85 + 16;
            v82 = v82 + 16;
            local v86 = buffer_readu32(p67, v83);
            local v87 = buffer_readu32(p67, v84);
            local v88 = buffer_readu32(p67, v85);
            local v89 = buffer_readu32(p67, v82);
            p66(p67, i, p68, i);
            v78 = bit32_bxor(v74, v78, (buffer_readu32(p68, v83)));
            v79 = bit32_bxor(v75, v79, (buffer_readu32(p68, v84)));
            v80 = bit32_bxor(v76, v80, (buffer_readu32(p68, v85)));
            v81 = bit32_bxor(v77, v81, (buffer_readu32(p68, v82)));
            buffer_writeu32(p68, v83, v78);
            buffer_writeu32(p68, v84, v79);
            buffer_writeu32(p68, v85, v80);
            buffer_writeu32(p68, v82, v81);
            v75 = v87;
            v74 = v86;
            v77 = v89;
            v76 = v88;
            local _ = i;
        end;
    end
};
table.freeze(v21.PCBC);

local function cfbFwd(p90: any, p91: any, p92: any, p93: any, p94: table, p95: any) -- Line: 243
    -- upvalues: buffer_len (copy), u1 (copy), buffer_create (copy), buffer_readu8 (copy), bit32_bxor (copy), buffer_writeu8 (copy), buffer_copy (copy)
    local SegmentSize = p94.SegmentSize;
    local v96 = buffer_len(p92);
    assert(v96 % SegmentSize == 0, "Input length must be a multiple of segment size");
    local v97 = p95 or u1;
    local v98 = buffer_len(v97) == 16;
    assert(v98, "Initialization vector must be 16 bytes long");
    local v99 = p94.CommonTemp or buffer_create(31);

    if v96 == SegmentSize then
        p90(v97, 0, v99, 0);

        for i = 0, SegmentSize - 1 do
            buffer_writeu8(p93, i, (bit32_bxor(buffer_readu8(p92, i), (buffer_readu8(v99, i)))));
            local _ = i;
        end;

        return;
    end;

    local v100 = v96 - SegmentSize;
    local v101 = 16 - SegmentSize;
    p90(v97, 0, v99, 0);

    for i = 0, SegmentSize - 1 do
        buffer_writeu8(p93, i, (bit32_bxor(buffer_readu8(p92, i), (buffer_readu8(v99, i)))));
        local _ = i;
    end;

    buffer_copy(v99, 0, v97, SegmentSize, v101);
    buffer_copy(v99, v101, p93, 0, SegmentSize);

    for i = SegmentSize, v100 - SegmentSize, SegmentSize do
        buffer_copy(v99, 16, v99, SegmentSize, v101);
        p90(v99, 0, v99, 0);
        local v102 = 0;

        for i2 = i, i + SegmentSize - 1 do
            buffer_writeu8(p93, i2, (bit32_bxor(buffer_readu8(p92, i2), (buffer_readu8(v99, v102)))));
            v102 = v102 + 1;
            local _ = i2;
        end;

        buffer_copy(v99, 0, v99, 16, v101);
        buffer_copy(v99, v101, p93, i, SegmentSize);
    end;

    p90(v99, 0, v99, 0);
    local v103 = 0;

    for i = v100, v96 - 1 do
        buffer_writeu8(p93, i, (bit32_bxor(buffer_readu8(p92, i), (buffer_readu8(v99, v103)))));
        v103 = v103 + 1;
        local _ = i;
    end;
end;

local function cfbInv(p104: any, p105: any, p106: any, p107: any, p108: table, p109: any) -- Line: 284
    -- upvalues: buffer_len (copy), u1 (copy), buffer_create (copy), buffer_readu8 (copy), bit32_bxor (copy), buffer_writeu8 (copy), buffer_copy (copy)
    local v110 = buffer_len(p106);
    local SegmentSize = p108.SegmentSize;
    assert(v110 % SegmentSize == 0, "Input length must be a multiple of segment size");
    local v111 = p109 or u1;
    local v112 = buffer_len(v111) == 16;
    assert(v112, "Initialization vector must be 16 bytes long");
    local v113 = p108.CommonTemp or buffer_create(31);

    if v110 == SegmentSize then
        p104(v111, 0, v113, 0);

        for i = 0, SegmentSize - 1 do
            buffer_writeu8(p107, i, (bit32_bxor(buffer_readu8(p106, i), (buffer_readu8(v113, i)))));
            local _ = i;
        end;

        return;
    end;

    local v114 = v110 - SegmentSize;
    local v115 = 16 - SegmentSize;
    p104(v111, 0, v113, 0);

    for i = 0, SegmentSize - 1 do
        buffer_writeu8(p107, i, (bit32_bxor(buffer_readu8(p106, i), (buffer_readu8(v113, i)))));
        local _ = i;
    end;

    buffer_copy(v113, 0, v111, SegmentSize, v115);
    buffer_copy(v113, v115, p106, 0, SegmentSize);

    for i = SegmentSize, v114 - SegmentSize, SegmentSize do
        buffer_copy(v113, 16, v113, SegmentSize, v115);
        p104(v113, 0, v113, 0);
        local v116 = 0;

        for i2 = i, i + SegmentSize - 1 do
            buffer_writeu8(p107, i2, (bit32_bxor(buffer_readu8(p106, i2), (buffer_readu8(v113, v116)))));
            v116 = v116 + 1;
            local _ = i2;
        end;

        buffer_copy(v113, 0, v113, 16, v115);
        buffer_copy(v113, v115, p106, i, SegmentSize);
    end;

    p104(v113, 0, v113, 0);
    local v117 = 0;

    for i = v114, v110 - 1 do
        buffer_writeu8(p107, i, (bit32_bxor(buffer_readu8(p106, i), (buffer_readu8(v113, v117)))));
        v117 = v117 + 1;
        local _ = i;
    end;
end;

local function ofbMode(p118: any, p119: any, p120: buffer, p121: buffer, p122: any, p123: buffer) -- Line: 334
    -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
    local v124 = buffer_len(p120) - 16;
    assert(v124 % 16 == 0, "Input length must be a multiple of 16 bytes");
    local v125 = p123 or u1;
    local v126 = buffer_len(v125) == 16;
    assert(v126, "Initialization vector must be 16 bytes long");
    local v127 = buffer_readu32(p120, 0);
    local v128 = buffer_readu32(p120, 4);
    local v129 = buffer_readu32(p120, 8);
    local v130 = buffer_readu32(p120, 12);
    p118(v125, 0, p121, 0);
    local v131 = bit32_bxor(v127, (buffer_readu32(p121, 0)));
    local v132 = bit32_bxor(v128, (buffer_readu32(p121, 4)));
    local v133 = bit32_bxor(v129, (buffer_readu32(p121, 8)));
    local v134 = bit32_bxor(v130, (buffer_readu32(p121, 12)));

    for i = 16, v124, 16 do
        local v135 = buffer_readu32(p120, i);
        local v136 = buffer_readu32(p120, i + 4);
        local v137 = buffer_readu32(p120, i + 8);
        local v138 = buffer_readu32(p120, i + 12);
        p118(p121, i - 16, p121, i);
        buffer_writeu32(p121, i - 16, v131);
        buffer_writeu32(p121, i - 12, v132);
        buffer_writeu32(p121, i - 8, v133);
        buffer_writeu32(p121, i - 4, v134);
        v131 = bit32_bxor(v135, (buffer_readu32(p121, i)));
        v132 = bit32_bxor(v136, (buffer_readu32(p121, i + 4)));
        v133 = bit32_bxor(v137, (buffer_readu32(p121, i + 8)));
        v134 = bit32_bxor(v138, (buffer_readu32(p121, i + 12)));
        local _ = i;
    end;

    buffer_writeu32(p121, v124, v131);
    buffer_writeu32(p121, v124 + 4, v132);
    buffer_writeu32(p121, v124 + 8, v133);
    buffer_writeu32(p121, v124 + 12, v134);
end;

v21.OFB = {
    FwdMode = ofbMode,
    InvMode = ofbMode
};
table.freeze(v21.OFB);

local function ctrMode(p139: any, p140: any, p141: any, p142: any, p143: table) -- Line: 391
    -- upvalues: buffer_len (copy), buffer_writestring (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy), addByteCtr (copy)
    local v144 = buffer_len(p141) - 16;
    assert(v144 % 16 == 0, "Input length must be a multiple of 16 bytes");
    local CommonTemp = p143.CommonTemp;
    local InitValue = p143.InitValue;
    local Prefix = p143.Prefix;
    local Suffix = p143.Suffix;
    local Step = p143.Step;
    local LittleEndian = p143.LittleEndian;
    local v145 = #Prefix;
    local v146 = v145 + #InitValue - 1;
    buffer_writestring(CommonTemp, 0, Prefix);
    buffer_writestring(CommonTemp, v145, InitValue);
    buffer_writestring(CommonTemp, v146 + 1, Suffix);
    local v147 = buffer_readu32(p141, 0);
    local v148 = buffer_readu32(p141, 4);
    local v149 = buffer_readu32(p141, 8);
    local v150 = buffer_readu32(p141, 12);
    p139(CommonTemp, 0, p142, 0);
    buffer_writeu32(p142, 0, (bit32_bxor(buffer_readu32(p142, 0), v147)));
    buffer_writeu32(p142, 4, (bit32_bxor(buffer_readu32(p142, 4), v148)));
    buffer_writeu32(p142, 8, (bit32_bxor(buffer_readu32(p142, 8), v149)));
    buffer_writeu32(p142, 12, (bit32_bxor(buffer_readu32(p142, 12), v150)));

    for i = 16, v144, 16 do
        local v151 = buffer_readu32(p141, i);
        local v152 = buffer_readu32(p141, i + 4);
        local v153 = buffer_readu32(p141, i + 8);
        local v154 = buffer_readu32(p141, i + 12);
        addByteCtr(CommonTemp, Step, v145, v146, LittleEndian);
        p139(CommonTemp, 0, p142, i);
        buffer_writeu32(p142, i, (bit32_bxor(v151, (buffer_readu32(p142, i)))));
        buffer_writeu32(p142, i + 4, (bit32_bxor(v152, (buffer_readu32(p142, i + 4)))));
        buffer_writeu32(p142, i + 8, (bit32_bxor(v153, (buffer_readu32(p142, i + 8)))));
        buffer_writeu32(p142, i + 12, (bit32_bxor(v154, (buffer_readu32(p142, i + 12)))));
        local _ = i;
    end;
end;

local v157 = {
    __index = function(p155: any, p156: string) -- Line: 442, Name: __index
        -- upvalues: cfbFwd (copy), cfbInv (copy), buffer_create (copy), ctrMode (copy), string_pack (copy), math_random (copy)
        return p156 == "CFB" and {
            SegmentSize = 16,
            FwdMode = cfbFwd,
            InvMode = cfbInv,
            CommonTemp = buffer_create(31)
        } or (p156 == "CTR" and {
            Prefix = "",
            Suffix = "",
            Step = 1,
            LittleEndian = false,
            FwdMode = ctrMode,
            InvMode = ctrMode,
            InitValue = string_pack("I2I2I2I2I2I2I2I2", math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535)),
            CommonTemp = buffer_create(16)
        } or nil);
    end,

    __newindex = function() -- Line: 472, Name: __newindex
    end
};
setmetatable(v21, v157);
v21.CFB = {};
v21.CTR = {};
table.freeze(v21);
v157.__metatable = "This metatable is locked";

return v21;