-- Decompiled with Potassium's decompiler.

local bit32_bxor = bit32.bxor;
local bit32_rrotate = bit32.rrotate;
local buffer_copy = buffer.copy;
local buffer_create = buffer.create;
local buffer_fromstring = buffer.fromstring;
local buffer_len = buffer.len;
local buffer_readu8 = buffer.readu8;
local buffer_readu16 = buffer.readu16;
local buffer_readu32 = buffer.readu32;
local buffer_tostring = buffer.tostring;
local buffer_writestring = buffer.writestring;
local buffer_writeu8 = buffer.writeu8;
local buffer_writeu16 = buffer.writeu16;
local buffer_writeu32 = buffer.writeu32;
local math_floor = math.floor;
local string_sub = string.sub;
local u1 = buffer_create(131072);
local u2 = buffer_create(65536);
local u3 = buffer_create(65536);
local u4 = buffer_create(65536);
local u5 = buffer_create(65536);
local u6 = buffer_create(65536);
local v7 = buffer_create(256);
local v8 = buffer_create(256);
local v9 = buffer_create(256);
local v10 = buffer_create(256);
local v11 = buffer_create(256);
buffer_writeu8(v7, 0, 99);
local v12 = 1;
local v13 = 1;

local function gfmul(p14: number, p15: number) -- Line: 748
    -- upvalues: bit32_bxor (copy), math_floor (copy)
    local v16 = 0;

    for i = 0, 7 do
        if p15 % 2 == 1 then
            v16 = bit32_bxor(v16, p14);
        end;

        if p14 >= 128 then
            p14 = bit32_bxor(p14 * 2 % 256, 27);
        else
            p14 = p14 * 2 % 256;
        end;

        p15 = math_floor(p15 / 2);
        local _ = i;
    end;

    return v16;
end;

local function keySchedule(p17: any, p18: number, p19: buffer, p20: boolean) -- Line: 159
    -- upvalues: buffer_copy (copy), buffer_writestring (copy), buffer_readu32 (copy), bit32_rrotate (copy), u1 (copy), math_floor (copy), buffer_readu16 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
    if p20 then
        buffer_copy(p19, 0, p17, 0, p18);
    else
        buffer_writestring(p19, 0, p17, p18);
    end;

    local v21 = bit32_rrotate(buffer_readu32(p19, p18 - 4), 8);
    local v22 = 0.5;

    if p18 == 32 then
        for i = 32, 192, 32 do
            v22 = v22 * 2 % 229;
            local v23 = bit32_bxor(buffer_readu32(p19, i - 32), buffer_readu16(u1, math_floor(v21 / 65536) * 2) * 65536 + buffer_readu16(u1, v21 % 65536 * 2), v22);
            buffer_writeu32(p19, i, v23);
            local v24 = bit32_bxor(buffer_readu32(p19, i - 28), v23);
            buffer_writeu32(p19, i + 4, v24);
            local v25 = bit32_bxor(buffer_readu32(p19, i - 24), v24);
            buffer_writeu32(p19, i + 8, v25);
            local v26 = bit32_bxor(buffer_readu32(p19, i - 20), v25);
            buffer_writeu32(p19, i + 12, v26);
            local v27 = bit32_bxor(buffer_readu32(p19, i - 16), buffer_readu16(u1, math_floor(v26 / 65536) * 2) * 65536 + buffer_readu16(u1, v26 % 65536 * 2));
            buffer_writeu32(p19, i + 16, v27);
            local v28 = bit32_bxor(buffer_readu32(p19, i - 12), v27);
            buffer_writeu32(p19, i + 20, v28);
            local v29 = bit32_bxor(buffer_readu32(p19, i - 8), v28);
            buffer_writeu32(p19, i + 24, v29);
            local v30 = bit32_bxor(buffer_readu32(p19, i - 4), v29);
            buffer_writeu32(p19, i + 28, v30);
            v21 = bit32_rrotate(v30, 8);
            local _ = i;
        end;

        local v31 = bit32_bxor(buffer_readu32(p19, 192), buffer_readu16(u1, math_floor(v21 / 65536) * 2) * 65536 + buffer_readu16(u1, v21 % 65536 * 2), 64);
        buffer_writeu32(p19, 224, v31);
        local v32 = bit32_bxor(buffer_readu32(p19, 196), v31);
        buffer_writeu32(p19, 228, v32);
        local v33 = bit32_bxor(buffer_readu32(p19, 200), v32);
        buffer_writeu32(p19, 232, v33);
        buffer_writeu32(p19, 236, (bit32_bxor(buffer_readu32(p19, 204), v33)));

        return p19;
    end;

    if p18 == 24 then
        for i = 24, 168, 24 do
            v22 = v22 * 2 % 229;
            local v34 = bit32_bxor(buffer_readu32(p19, i - 24), buffer_readu16(u1, math_floor(v21 / 65536) * 2) * 65536 + buffer_readu16(u1, v21 % 65536 * 2), v22);
            buffer_writeu32(p19, i, v34);
            local v35 = bit32_bxor(buffer_readu32(p19, i - 20), v34);
            buffer_writeu32(p19, i + 4, v35);
            local v36 = bit32_bxor(buffer_readu32(p19, i - 16), v35);
            buffer_writeu32(p19, i + 8, v36);
            local v37 = bit32_bxor(buffer_readu32(p19, i - 12), v36);
            buffer_writeu32(p19, i + 12, v37);
            local v38 = bit32_bxor(buffer_readu32(p19, i - 8), v37);
            buffer_writeu32(p19, i + 16, v38);
            local v39 = bit32_bxor(buffer_readu32(p19, i - 4), v38);
            buffer_writeu32(p19, i + 20, v39);
            v21 = bit32_rrotate(v39, 8);
            local _ = i;
        end;

        local v40 = bit32_bxor(buffer_readu32(p19, 168), buffer_readu16(u1, math_floor(v21 / 65536) * 2) * 65536 + buffer_readu16(u1, v21 % 65536 * 2), 128);
        buffer_writeu32(p19, 192, v40);
        local v41 = bit32_bxor(buffer_readu32(p19, 172), v40);
        buffer_writeu32(p19, 196, v41);
        local v42 = bit32_bxor(buffer_readu32(p19, 176), v41);
        buffer_writeu32(p19, 200, v42);
        buffer_writeu32(p19, 204, (bit32_bxor(buffer_readu32(p19, 180), v42)));

        return p19;
    end;

    for i = 16, 144, 16 do
        v22 = v22 * 2 % 229;
        local v43 = bit32_bxor(buffer_readu32(p19, i - 16), buffer_readu16(u1, math_floor(v21 / 65536) * 2) * 65536 + buffer_readu16(u1, v21 % 65536 * 2), v22);
        buffer_writeu32(p19, i, v43);
        local v44 = bit32_bxor(buffer_readu32(p19, i - 12), v43);
        buffer_writeu32(p19, i + 4, v44);
        local v45 = bit32_bxor(buffer_readu32(p19, i - 8), v44);
        buffer_writeu32(p19, i + 8, v45);
        local v46 = bit32_bxor(buffer_readu32(p19, i - 4), v45);
        buffer_writeu32(p19, i + 12, v46);
        v21 = bit32_rrotate(v46, 8);
        local _ = i;
    end;

    local v47 = bit32_bxor(buffer_readu32(p19, 144), buffer_readu16(u1, math_floor(v21 / 65536) * 2) * 65536 + buffer_readu16(u1, v21 % 65536 * 2), 54);
    buffer_writeu32(p19, 160, v47);
    local v48 = bit32_bxor(buffer_readu32(p19, 148), v47);
    buffer_writeu32(p19, 164, v48);
    local v49 = bit32_bxor(buffer_readu32(p19, 152), v48);
    buffer_writeu32(p19, 168, v49);
    buffer_writeu32(p19, 172, (bit32_bxor(buffer_readu32(p19, 156), v49)));

    return p19;
end;

local function encryptBlock(p50: buffer, p51: number, p52: buffer, p53: number, p54: buffer, p55: number) -- Line: 284
    -- upvalues: buffer_readu8 (copy), bit32_bxor (copy), u2 (copy), u3 (copy), u1 (copy), buffer_readu16 (copy), buffer_readu32 (copy), buffer_writeu32 (copy)
    local v56 = bit32_bxor(buffer_readu8(p52, p53), (buffer_readu8(p50, 0)));
    local v57 = bit32_bxor(buffer_readu8(p52, p53 + 1), (buffer_readu8(p50, 1)));
    local v58 = bit32_bxor(buffer_readu8(p52, p53 + 2), (buffer_readu8(p50, 2)));
    local v59 = bit32_bxor(buffer_readu8(p52, p53 + 3), (buffer_readu8(p50, 3)));
    local v60 = bit32_bxor(buffer_readu8(p52, p53 + 4), (buffer_readu8(p50, 4)));
    local v61 = bit32_bxor(buffer_readu8(p52, p53 + 5), (buffer_readu8(p50, 5)));
    local v62 = bit32_bxor(buffer_readu8(p52, p53 + 6), (buffer_readu8(p50, 6)));
    local v63 = bit32_bxor(buffer_readu8(p52, p53 + 7), (buffer_readu8(p50, 7)));
    local v64 = bit32_bxor(buffer_readu8(p52, p53 + 8), (buffer_readu8(p50, 8)));
    local v65 = bit32_bxor(buffer_readu8(p52, p53 + 9), (buffer_readu8(p50, 9)));
    local v66 = bit32_bxor(buffer_readu8(p52, p53 + 10), (buffer_readu8(p50, 10)));
    local v67 = bit32_bxor(buffer_readu8(p52, p53 + 11), (buffer_readu8(p50, 11)));
    local v68 = bit32_bxor(buffer_readu8(p52, p53 + 12), (buffer_readu8(p50, 12)));
    local v69 = bit32_bxor(buffer_readu8(p52, p53 + 13), (buffer_readu8(p50, 13)));
    local v70 = bit32_bxor(buffer_readu8(p52, p53 + 14), (buffer_readu8(p50, 14)));
    local v71 = bit32_bxor(buffer_readu8(p52, p53 + 15), (buffer_readu8(p50, 15)));
    local v72 = v56 * 256 + v61;
    local v73 = v61 * 256 + v66;
    local v74 = v66 * 256 + v71;
    local v75 = v71 * 256 + v56;
    local v76 = v60 * 256 + v65;
    local v77 = v65 * 256 + v70;
    local v78 = v70 * 256 + v59;
    local v79 = v59 * 256 + v60;
    local v80 = v64 * 256 + v69;
    local v81 = v69 * 256 + v58;
    local v82 = v58 * 256 + v63;
    local v83 = v63 * 256 + v64;
    local v84 = v68 * 256 + v57;
    local v85 = v57 * 256 + v62;
    local v86 = v62 * 256 + v67;
    local v87 = v67 * 256 + v68;

    for i = 16, p51, 16 do
        local v88 = bit32_bxor(buffer_readu8(u2, v72), buffer_readu8(u3, v74), (buffer_readu8(p50, i)));
        local v89 = bit32_bxor(buffer_readu8(u2, v73), buffer_readu8(u3, v75), (buffer_readu8(p50, i + 1)));
        local v90 = bit32_bxor(buffer_readu8(u2, v74), buffer_readu8(u3, v72), (buffer_readu8(p50, i + 2)));
        local v91 = bit32_bxor(buffer_readu8(u2, v75), buffer_readu8(u3, v73), (buffer_readu8(p50, i + 3)));
        local v92 = bit32_bxor(buffer_readu8(u2, v76), buffer_readu8(u3, v78), (buffer_readu8(p50, i + 4)));
        local v93 = bit32_bxor(buffer_readu8(u2, v77), buffer_readu8(u3, v79), (buffer_readu8(p50, i + 5)));
        local v94 = bit32_bxor(buffer_readu8(u2, v78), buffer_readu8(u3, v76), (buffer_readu8(p50, i + 6)));
        local v95 = bit32_bxor(buffer_readu8(u2, v79), buffer_readu8(u3, v77), (buffer_readu8(p50, i + 7)));
        local v96 = bit32_bxor(buffer_readu8(u2, v80), buffer_readu8(u3, v82), (buffer_readu8(p50, i + 8)));
        local v97 = bit32_bxor(buffer_readu8(u2, v81), buffer_readu8(u3, v83), (buffer_readu8(p50, i + 9)));
        local v98 = bit32_bxor(buffer_readu8(u2, v82), buffer_readu8(u3, v80), (buffer_readu8(p50, i + 10)));
        local v99 = bit32_bxor(buffer_readu8(u2, v83), buffer_readu8(u3, v81), (buffer_readu8(p50, i + 11)));
        local v100 = bit32_bxor(buffer_readu8(u2, v84), buffer_readu8(u3, v86), (buffer_readu8(p50, i + 12)));
        local v101 = bit32_bxor(buffer_readu8(u2, v85), buffer_readu8(u3, v87), (buffer_readu8(p50, i + 13)));
        local v102 = bit32_bxor(buffer_readu8(u2, v86), buffer_readu8(u3, v84), (buffer_readu8(p50, i + 14)));
        local v103 = bit32_bxor(buffer_readu8(u2, v87), buffer_readu8(u3, v85), (buffer_readu8(p50, i + 15)));
        v72 = v88 * 256 + v93;
        v73 = v93 * 256 + v98;
        v74 = v98 * 256 + v103;
        v75 = v103 * 256 + v88;
        v76 = v92 * 256 + v97;
        v77 = v97 * 256 + v102;
        v78 = v102 * 256 + v91;
        v79 = v91 * 256 + v92;
        v80 = v96 * 256 + v101;
        v81 = v101 * 256 + v90;
        v82 = v90 * 256 + v95;
        v83 = v95 * 256 + v96;
        v84 = v100 * 256 + v89;
        v85 = v89 * 256 + v94;
        v86 = v94 * 256 + v99;
        v87 = v99 * 256 + v100;
        local _ = i;
    end;

    buffer_writeu32(p54, p55, (bit32_bxor(buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v87), buffer_readu8(u3, v85), (buffer_readu8(p50, p51 + 31))) * 512 + bit32_bxor(buffer_readu8(u2, v82), buffer_readu8(u3, v80), (buffer_readu8(p50, p51 + 26))) * 2) * 65536 + buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v77), buffer_readu8(u3, v79), (buffer_readu8(p50, p51 + 21))) * 512 + bit32_bxor(buffer_readu8(u2, v72), buffer_readu8(u3, v74), (buffer_readu8(p50, p51 + 16))) * 2), (buffer_readu32(p50, p51 + 32)))));
    buffer_writeu32(p54, p55 + 4, (bit32_bxor(buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v75), buffer_readu8(u3, v73), (buffer_readu8(p50, p51 + 19))) * 512 + bit32_bxor(buffer_readu8(u2, v86), buffer_readu8(u3, v84), (buffer_readu8(p50, p51 + 30))) * 2) * 65536 + buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v81), buffer_readu8(u3, v83), (buffer_readu8(p50, p51 + 25))) * 512 + bit32_bxor(buffer_readu8(u2, v76), buffer_readu8(u3, v78), (buffer_readu8(p50, p51 + 20))) * 2), (buffer_readu32(p50, p51 + 36)))));
    buffer_writeu32(p54, p55 + 8, (bit32_bxor(buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v79), buffer_readu8(u3, v77), (buffer_readu8(p50, p51 + 23))) * 512 + bit32_bxor(buffer_readu8(u2, v74), buffer_readu8(u3, v72), (buffer_readu8(p50, p51 + 18))) * 2) * 65536 + buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v85), buffer_readu8(u3, v87), (buffer_readu8(p50, p51 + 29))) * 512 + bit32_bxor(buffer_readu8(u2, v80), buffer_readu8(u3, v82), (buffer_readu8(p50, p51 + 24))) * 2), (buffer_readu32(p50, p51 + 40)))));
    buffer_writeu32(p54, p55 + 12, (bit32_bxor(buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v83), buffer_readu8(u3, v81), (buffer_readu8(p50, p51 + 27))) * 512 + bit32_bxor(buffer_readu8(u2, v78), buffer_readu8(u3, v76), (buffer_readu8(p50, p51 + 22))) * 2) * 65536 + buffer_readu16(u1, bit32_bxor(buffer_readu8(u2, v73), buffer_readu8(u3, v75), (buffer_readu8(p50, p51 + 17))) * 512 + bit32_bxor(buffer_readu8(u2, v84), buffer_readu8(u3, v86), (buffer_readu8(p50, p51 + 28))) * 2), (buffer_readu32(p50, p51 + 44)))));
end;

local function decryptBlock(p104: buffer, p105: number, p106: buffer, p107: number, p108: buffer, p109: number) -- Line: 477
    -- upvalues: u4 (copy), buffer_readu8 (copy), bit32_bxor (copy), u5 (copy), u6 (copy), buffer_writeu32 (copy)
    local v110 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107) * 256 + buffer_readu8(p104, p105 + 32)), (buffer_readu8(p104, p105 + 16)));
    local v111 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 13) * 256 + buffer_readu8(p104, p105 + 45)), (buffer_readu8(p104, p105 + 17)));
    local v112 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 10) * 256 + buffer_readu8(p104, p105 + 42)), (buffer_readu8(p104, p105 + 18)));
    local v113 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 7) * 256 + buffer_readu8(p104, p105 + 39)), (buffer_readu8(p104, p105 + 19)));
    local v114 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 4) * 256 + buffer_readu8(p104, p105 + 36)), (buffer_readu8(p104, p105 + 20)));
    local v115 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 1) * 256 + buffer_readu8(p104, p105 + 33)), (buffer_readu8(p104, p105 + 21)));
    local v116 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 14) * 256 + buffer_readu8(p104, p105 + 46)), (buffer_readu8(p104, p105 + 22)));
    local v117 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 11) * 256 + buffer_readu8(p104, p105 + 43)), (buffer_readu8(p104, p105 + 23)));
    local v118 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 8) * 256 + buffer_readu8(p104, p105 + 40)), (buffer_readu8(p104, p105 + 24)));
    local v119 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 5) * 256 + buffer_readu8(p104, p105 + 37)), (buffer_readu8(p104, p105 + 25)));
    local v120 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 2) * 256 + buffer_readu8(p104, p105 + 34)), (buffer_readu8(p104, p105 + 26)));
    local v121 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 15) * 256 + buffer_readu8(p104, p105 + 47)), (buffer_readu8(p104, p105 + 27)));
    local v122 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 12) * 256 + buffer_readu8(p104, p105 + 44)), (buffer_readu8(p104, p105 + 28)));
    local v123 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 9) * 256 + buffer_readu8(p104, p105 + 41)), (buffer_readu8(p104, p105 + 29)));
    local v124 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 6) * 256 + buffer_readu8(p104, p105 + 38)), (buffer_readu8(p104, p105 + 30)));
    local v125 = bit32_bxor(buffer_readu8(u4, buffer_readu8(p106, p107 + 3) * 256 + buffer_readu8(p104, p105 + 35)), (buffer_readu8(p104, p105 + 31)));
    local v126 = v110 * 256 + v111;
    local v127 = v111 * 256 + v112;
    local v128 = v112 * 256 + v113;
    local v129 = v113 * 256 + v110;
    local v130 = v114 * 256 + v115;
    local v131 = v115 * 256 + v116;
    local v132 = v116 * 256 + v117;
    local v133 = v117 * 256 + v114;
    local v134 = v118 * 256 + v119;
    local v135 = v119 * 256 + v120;
    local v136 = v120 * 256 + v121;
    local v137 = v121 * 256 + v118;
    local v138 = v122 * 256 + v123;
    local v139 = v123 * 256 + v124;
    local v140 = v124 * 256 + v125;
    local v141 = v125 * 256 + v122;

    for i = p105, 16, -16 do
        local v142 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v126) * 256 + buffer_readu8(u6, v128)), (buffer_readu8(p104, i)));
        local v143 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v139) * 256 + buffer_readu8(u6, v141)), (buffer_readu8(p104, i + 1)));
        local v144 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v136) * 256 + buffer_readu8(u6, v134)), (buffer_readu8(p104, i + 2)));
        local v145 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v133) * 256 + buffer_readu8(u6, v131)), (buffer_readu8(p104, i + 3)));
        local v146 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v130) * 256 + buffer_readu8(u6, v132)), (buffer_readu8(p104, i + 4)));
        local v147 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v127) * 256 + buffer_readu8(u6, v129)), (buffer_readu8(p104, i + 5)));
        local v148 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v140) * 256 + buffer_readu8(u6, v138)), (buffer_readu8(p104, i + 6)));
        local v149 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v137) * 256 + buffer_readu8(u6, v135)), (buffer_readu8(p104, i + 7)));
        local v150 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v134) * 256 + buffer_readu8(u6, v136)), (buffer_readu8(p104, i + 8)));
        local v151 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v131) * 256 + buffer_readu8(u6, v133)), (buffer_readu8(p104, i + 9)));
        local v152 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v128) * 256 + buffer_readu8(u6, v126)), (buffer_readu8(p104, i + 10)));
        local v153 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v141) * 256 + buffer_readu8(u6, v139)), (buffer_readu8(p104, i + 11)));
        local v154 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v138) * 256 + buffer_readu8(u6, v140)), (buffer_readu8(p104, i + 12)));
        local v155 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v135) * 256 + buffer_readu8(u6, v137)), (buffer_readu8(p104, i + 13)));
        local v156 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v132) * 256 + buffer_readu8(u6, v130)), (buffer_readu8(p104, i + 14)));
        local v157 = bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v129) * 256 + buffer_readu8(u6, v127)), (buffer_readu8(p104, i + 15)));
        v126 = v142 * 256 + v143;
        v127 = v143 * 256 + v144;
        v128 = v144 * 256 + v145;
        v129 = v145 * 256 + v142;
        v130 = v146 * 256 + v147;
        v131 = v147 * 256 + v148;
        v132 = v148 * 256 + v149;
        v133 = v149 * 256 + v146;
        v134 = v150 * 256 + v151;
        v135 = v151 * 256 + v152;
        v136 = v152 * 256 + v153;
        v137 = v153 * 256 + v150;
        v138 = v154 * 256 + v155;
        v139 = v155 * 256 + v156;
        v140 = v156 * 256 + v157;
        v141 = v157 * 256 + v154;
        local _ = i;
    end;

    buffer_writeu32(p108, p109, bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v133) * 256 + buffer_readu8(u6, v131)), (buffer_readu8(p104, 3))) * 16777216 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v136) * 256 + buffer_readu8(u6, v134)), (buffer_readu8(p104, 2))) * 65536 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v139) * 256 + buffer_readu8(u6, v141)), (buffer_readu8(p104, 1))) * 256 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v126) * 256 + buffer_readu8(u6, v128)), (buffer_readu8(p104, 0))));
    buffer_writeu32(p108, p109 + 4, bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v137) * 256 + buffer_readu8(u6, v135)), (buffer_readu8(p104, 7))) * 16777216 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v140) * 256 + buffer_readu8(u6, v138)), (buffer_readu8(p104, 6))) * 65536 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v127) * 256 + buffer_readu8(u6, v129)), (buffer_readu8(p104, 5))) * 256 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v130) * 256 + buffer_readu8(u6, v132)), (buffer_readu8(p104, 4))));
    buffer_writeu32(p108, p109 + 8, bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v141) * 256 + buffer_readu8(u6, v139)), (buffer_readu8(p104, 11))) * 16777216 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v128) * 256 + buffer_readu8(u6, v126)), (buffer_readu8(p104, 10))) * 65536 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v131) * 256 + buffer_readu8(u6, v133)), (buffer_readu8(p104, 9))) * 256 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v134) * 256 + buffer_readu8(u6, v136)), (buffer_readu8(p104, 8))));
    buffer_writeu32(p108, p109 + 12, bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v129) * 256 + buffer_readu8(u6, v127)), (buffer_readu8(p104, 15))) * 16777216 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v132) * 256 + buffer_readu8(u6, v130)), (buffer_readu8(p104, 14))) * 65536 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v135) * 256 + buffer_readu8(u6, v137)), (buffer_readu8(p104, 13))) * 256 + bit32_bxor(buffer_readu8(u4, buffer_readu8(u5, v138) * 256 + buffer_readu8(u6, v140)), (buffer_readu8(p104, 12))));
end;

for i = 1, 255 do
    v12 = bit32_bxor(v12, v12 * 2, v12 < 128 and 0 or 27) % 256;
    local v158 = bit32_bxor(v13, v13 * 2);
    local v159 = bit32_bxor(v158, v158 * 4);
    v13 = bit32_bxor(v159, v159 * 16) % 256;

    if v13 >= 128 then
        v13 = bit32_bxor(v13, 9);
    end;

    local v160 = bit32_bxor(v13, v13 % 128 * 2 + v13 / 128, v13 % 64 * 4 + v13 / 64, v13 % 32 * 8 + v13 / 32, v13 % 16 * 16 + v13 / 16, 99);
    buffer_writeu8(v7, v12, v160);
    buffer_writeu8(v8, v160, v12);
    buffer_writeu8(v9, v12, (gfmul(3, v12)));
    buffer_writeu8(v10, v12, (gfmul(9, v12)));
    buffer_writeu8(v11, v12, (gfmul(11, v12)));
    local _ = i;
end;

local v161 = 0;

for i = 0, 255 do
    local v162 = buffer_readu8(v7, i);
    local v163 = v162 * 256;
    local v164 = gfmul(2, v162);
    local v165 = gfmul(13, i);
    local v166 = gfmul(14, i);
    local v167 = i;

    for i2 = 0, 255 do
        local v168 = buffer_readu8(v7, i2);
        buffer_writeu16(u1, v161 * 2, v163 + v168);
        buffer_writeu8(u4, v161, (buffer_readu8(v8, (bit32_bxor(v167, i2)))));
        buffer_writeu8(u2, v161, (bit32_bxor(v164, (buffer_readu8(v9, v168)))));
        buffer_writeu8(u3, v161, (bit32_bxor(v162, v168)));
        buffer_writeu8(u5, v161, (bit32_bxor(v166, (buffer_readu8(v11, i2)))));
        buffer_writeu8(u6, v161, (bit32_bxor(v165, (buffer_readu8(v10, i2)))));
        v161 = v161 + 1;
        local _ = i2;
    end;
end;

local function newidx(p169, p170) -- Line: 845
    return error((`{p170} cannot be assigned to`));
end;

local function tostr() -- Line: 848
    return "AesCipher";
end;

local script_Modes = require(script.Modes);
local script_Pads = require(script.Pads);

local function expandKey(p171: any, p172: buffer?) -- Line: 854
    -- upvalues: buffer_len (copy), keySchedule (copy), buffer_create (copy)
    local v173 = typeof(p171) == "buffer";
    local v174;

    if v173 then
        v174 = buffer_len(p171);
    else
        v174 = #p171;
    end;

    return keySchedule(p171, v174, p172 or buffer_create(v174 == 32 and 240 or (v174 == 24 and 208 or (v174 == 16 and 176 or error("Key must be either 16, 24 or 32 bytes long")))), v173);
end;

local function fromKey(p175: buffer, p176: any, p177: any) -- Line: 864
    -- upvalues: buffer_len (copy), buffer_tostring (copy), string_sub (copy), script_Modes (copy), script_Pads (copy), encryptBlock (copy), decryptBlock (copy), buffer_fromstring (copy), buffer_create (copy), newidx (copy), tostr (copy)
    local u178 = buffer_len(p175);
    local u179 = nil;
    local u180 = nil;
    local u181 = buffer_tostring(p175);

    if u178 == 240 then
        u180 = string_sub(u181, 1, 32);
        u179 = 192;
    elseif u178 == 208 then
        u180 = string_sub(u181, 1, 24);
        u179 = 160;
    elseif u178 == 176 then
        u180 = string_sub(u181, 1, 16);
        u179 = 128;
    else
        error("Round keys must be either 240, 208 or 128 bytes long");
    end;

    local u182 = p175;
    local u183 = p176 or script_Modes.ECB;
    local FwdMode = u183.FwdMode;
    local InvMode = u183.InvMode;
    local u184 = u183.SegmentSize or 16;
    local u185 = p177 or script_Pads.Pkcs7;
    local Pad = u185.Pad;
    local Unpad = u185.Unpad;
    local u186 = newproxy(true);
    local v187 = getmetatable(u186);

    local function encp(p188, p189, p190, p191) -- Line: 894
        -- upvalues: encryptBlock (ref), u182 (ref), u179 (ref)
        encryptBlock(u182, u179, p188, p189, p190, p191);
    end;

    local function decp(p192, p193, p194, p195) -- Line: 897
        -- upvalues: decryptBlock (ref), u182 (ref), u179 (ref)
        decryptBlock(u182, u179, p192, p193, p194, p195);
    end;

    local function enc(p196, p197, p198, ...) -- Line: 900
        -- upvalues: buffer_fromstring (ref), u186 (copy), u179 (ref), Pad (copy), u184 (copy), FwdMode (ref), encp (copy), decp (copy), u185 (ref), u183 (ref), buffer_create (ref)
        if typeof(p197) ~= "buffer" then
            if typeof(p197) == "string" then
                p197 = buffer_fromstring(p197);
            else
                p197 = error((`Unable to cast {typeof(p197)} to buffer`));
            end;
        end;

        if typeof(p198) ~= "buffer" then
            p198 = false;
        end;

        if p196 ~= u186 then
            return p196:Encrypt(p197, p198, ...);
        end;

        if not u179 then
            error("AesCipher object\'s already destroyed");

            return buffer_create(0);
        end;

        local v199 = Pad(p197, p198, u184);

        if u185.Overwrite ~= false then
            p197 = v199;
        end;

        FwdMode(encp, decp, p197, v199, u183, ...);

        return v199;
    end;

    local function encb(p200, p201, p202, p203, p204) -- Line: 917
        -- upvalues: u186 (copy), u179 (ref), encryptBlock (ref), u182 (ref)
        if p200 ~= u186 then
            p200:EncryptBlock(p201, p202, p203, p204);

            return;
        end;

        if u179 then
            encryptBlock(u182, u179, p201, p202, p203 or p201, p204 or p202);

            return;
        end;

        error("AesCipher object\'s already destroyed");
    end;

    local function dec(p205, p206, p207, ...) -- Line: 926
        -- upvalues: buffer_fromstring (ref), u186 (copy), u179 (ref), u185 (ref), buffer_create (ref), buffer_len (ref), InvMode (ref), encp (copy), decp (copy), u183 (ref), Unpad (copy), u184 (copy)
        if typeof(p206) ~= "buffer" then
            if typeof(p206) == "string" then
                p206 = buffer_fromstring(p206);
            else
                p206 = error((`Unable to cast {typeof(p206)} to buffer`));
            end;
        end;

        if typeof(p207) ~= "buffer" then
            p207 = false;
        end;

        if p205 ~= u186 then
            return p205:Decrypt(p206, p207, ...);
        end;

        if not u179 then
            error("AesCipher object\'s already destroyed");

            return buffer_create(0);
        end;

        local Overwrite = u185.Overwrite;
        local v208;

        if Overwrite == nil then
            v208 = buffer_create(buffer_len(p206));
        elseif Overwrite then
            v208 = p206;
        else
            v208 = p207 or buffer_create(buffer_len(p206));
        end;

        InvMode(encp, decp, p206, v208, u183, ...);

        return Unpad(v208, p207, u184);
    end;

    local function decb(p209, p210, p211, p212, p213) -- Line: 947
        -- upvalues: u186 (copy), u179 (ref), decryptBlock (ref), u182 (ref)
        if p209 ~= u186 then
            p209:DecryptBlock(p210, p211, p212, p213);

            return;
        end;

        if u179 then
            decryptBlock(u182, u179, p210, p211, p212 or p210, p213 or p211);

            return;
        end;

        error("AesCipher object\'s already destroyed");
    end;

    local function destroy(p214) -- Line: 956
        -- upvalues: u186 (copy), u179 (ref), u181 (ref), u182 (ref), FwdMode (ref), InvMode (ref), u183 (ref), u185 (ref), u180 (ref), u178 (ref)
        if p214 ~= u186 then
            p214:Destroy();

            return;
        end;

        if not u179 then
            error("AesCipher object\'s already destroyed");

            return;
        end;

        u181 = nil;
        u182 = nil;
        u179 = nil;
        FwdMode = nil;
        InvMode = nil;
        u183 = nil;
        u185 = nil;
        u180 = nil;
        u178 = nil;
    end;

    function v187.__index(p215, p216) -- Line: 967
        -- upvalues: enc (copy), dec (copy), encb (copy), decb (copy), destroy (copy), u179 (ref), u180 (ref), u181 (ref), u183 (ref), u185 (ref), u178 (ref)
        if p216 == "Encrypt" then
            return enc;
        end;

        if p216 == "Decrypt" then
            return dec;
        end;

        if p216 == "EncryptBlock" then
            return encb;
        end;

        if p216 == "DecryptBlock" then
            return decb;
        end;

        if p216 == "Destroy" then
            return destroy;
        end;

        if not u179 then
            return error("AesCipher object\'s already destroyed");
        end;

        if p216 == "Key" then
            return u180;
        end;

        if p216 == "RoundKeys" then
            return u181;
        end;

        if p216 == "Mode" then
            return u183;
        end;

        if p216 == "Padding" then
            return u185;
        end;

        if p216 == "Length" then
            return u178;
        end;

        return error((`{p216} is not a valid member of AesCipher`));
    end;

    v187.__newindex = newidx;
    v187.__tostring = tostr;

    function v187.__len() -- Line: 985
        -- upvalues: u178 (ref)
        return u178 or error("AesCipher object\'s destroyed");
    end;

    v187.__metatable = "AesCipher object: Metatable\'s locked";

    return u186;
end;

return table.freeze({
    new = function(p217, p218, p219) -- Line: 993, Name: new
        -- upvalues: fromKey (copy), expandKey (copy)
        return fromKey(expandKey(p217), p218, p219);
    end,

    expandKey = expandKey,
    fromKey = fromKey,
    modes = script_Modes,
    pads = script_Pads
});