-- Decompiled with Potassium's decompiler.

local string_byte = string.byte;
local string_char = string.char;
local string_find = string.find;
local string_gsub = string.gsub;
local string_sub = string.sub;
local table_concat = table.concat;
local table_sort = table.sort;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = { 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258 };
local u11 = { 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13 };
local u12 = {};
local u13 = {};
local u14 = { 16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15 };
local u15 = {};
local u16 = { 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577 };
local u17 = {};
local u18 = {};
local u19 = {};
local u20 = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0 };
local u21 = {};
local u22 = {};

for i = 0, 255 do
    u1[i] = string_char(i);
    local _ = i;
end;

local v23 = 1;

for i = 0, 32 do
    u2[i] = v23;
    v23 = v23 * 2;
    local _ = i;
end;

for i = 1, 9 do
    u3[i] = {};
    local v24 = i;

    for i2 = 0, u2[i + 1] - 1 do
        local v25 = i2;
        local v26 = v25;
        local v27 = v25;
        v25 = v26;
        v27 = v26;
        local v28 = 0;

        for i3 = 1, v24 do
            local v29 = v28 - v28 % 2 + ((v28 % 2 == 1 or v26 % 2 == 1) and 1 or 0);
            v26 = (v26 - v26 % 2) / 2;
            v28 = v29 * 2;
            local _ = i3;
        end;

        u3[v24][v25] = (v28 - v28 % 2) / 2;
    end;
end;

local v30 = 1;
local v31 = 18;
local v32 = 16;
local v33 = 265;

for i = 3, 258 do
    local v34;

    if i <= 10 then
        u5[i] = i + 254;
        u6[i] = 0;
        v34 = i;
    elseif i == 258 then
        u5[i] = 285;
        u6[i] = 0;
        v34 = i;
    else
        if v31 < i then
            v31 = v31 + v32;
            v32 = v32 * 2;
            v33 = v33 + 4;
            v30 = v30 + 1;
        end;

        local v35 = i - v31 - 1 + v32 / 2;
        u5[i] = (v35 - v35 % (v32 / 8)) / (v32 / 8) + v33;
        u6[i] = v30;
        u4[i] = v35 % (v32 / 8);
        v34 = i;
    end;
end;

u7[1] = 0;
u7[2] = 1;
u8[1] = 0;
u8[2] = 0;
local v36 = 4;
local v37 = 3;
local v38 = 2;
local v39 = 0;

for i = 3, 256 do
    if v36 < i then
        v37 = v37 * 2;
        v36 = v36 * 2;
        v38 = v38 + 2;
        v39 = v39 + 1;
    end;

    u7[i] = i <= v37 and v38 and v38 or v38 + 1;
    u8[i] = v39 < 0 and 0 or v39;
    local v40;

    if v36 >= 8 then
        u9[i] = (i - v36 / 2 - 1) % (v36 / 4);
        v40 = i;
    else
        v40 = i;
    end;
end;

function u19.Adler32(p41: table, p42: string) -- Line: 444
    -- upvalues: string_byte (copy)
    if type(p42) ~= "string" then
        error(("Usage: LibDeflate:Adler32(str): \'str\' - string expected got \'%s\'."):format((type(p42))), 2);
    end;

    local v43 = #p42;
    local v44 = 1;
    local v45 = 1;
    local v46 = 0;

    while v44 <= v43 - 15 do
        local v47, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62 = string_byte(p42, v44, v44 + 15);
        v46 = (v46 + v45 * 16 + v47 * 16 + 15 * v48 + 14 * v49 + 13 * v50 + 12 * v51 + 11 * v52 + 10 * v53 + 9 * v54 + 8 * v55 + 7 * v56 + 6 * v57 + 5 * v58 + 4 * v59 + 3 * v60 + 2 * v61 + v62) % 65521;
        v45 = (v45 + v47 + v48 + v49 + v50 + v51 + v52 + v53 + v54 + v55 + v56 + v57 + v58 + v59 + v60 + v61 + v62) % 65521;
        v44 = v44 + 16;
    end;

    while v44 <= v43 do
        v45 = (v45 + string_byte(p42, v44, v44)) % 65521;
        v46 = (v46 + v45) % 65521;
        v44 = v44 + 1;
    end;

    return (v46 * 65536 + v45) % 4294967296;
end;

local function IsEqualAdler32(p63: number, p64: number) -- Line: 502
    return p63 % 4294967296 == p64 % 4294967296;
end;

function u19.CreateDictionary(p65: table, p66: string, p67: number, p68: number) -- Line: 548
    -- upvalues: string_byte (copy)
    if type(p66) ~= "string" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string expected got \'%s\'."):format((type(p66))), 2);
    end;

    if type(p67) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' - number expected got \'%s\'."):format((type(p67))), 2);
    end;

    if type(p68) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' - number expected got \'%s\'."):format((type(p68))), 2);
    end;

    if p67 ~= #p66 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' does not match the actual length of \'str\'. \'strlen\': %u, \'#str\': %u . Please check if \'str\' is modified unintentionally."):format(p67, #p66));
    end;

    if p67 == 0 then
        error(
            "Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - Empty string is not allowed.",
            2
        );
    end;

    if p67 > 32768 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string longer than 32768 bytes is not allowed. Got %d bytes."):format(p67), 2);
    end;

    local v69 = p65:Adler32(p66);

    if p68 % 4294967296 ~= v69 % 4294967296 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' does not match the actual adler32 of \'str\'. \'adler32\': %u, \'Adler32(str)\': %u . Please check if \'str\' is modified unintentionally."):format(p68, v69));
    end;

    local v70 = {
        adler32 = p68,
        hash_tables = {},
        string_table = {},
        strlen = p67
    };
    local string_table = v70.string_table;
    local hash_tables = v70.hash_tables;
    string_table[1] = string_byte(p66, 1, 1);
    string_table[2] = string_byte(p66, 2, 2);

    if p67 >= 3 then
        local v71 = string_table[1] * 256 + string_table[2];
        local v72 = 1;

        while v72 <= p67 - 2 - 3 do
            local v73, v74, v75, v76 = string_byte(p66, v72 + 2, v72 + 5);
            string_table[v72 + 2] = v73;
            string_table[v72 + 3] = v74;
            string_table[v72 + 4] = v75;
            string_table[v72 + 5] = v76;
            local v77 = (v71 * 256 + v73) % 16777216;
            local v78 = hash_tables[v77];

            if not v78 then
                v78 = {};
                hash_tables[v77] = v78;
            end;

            v78[#v78 + 1] = v72 - p67;
            local v79 = v72 + 1;
            local v80 = (v77 * 256 + v74) % 16777216;
            local v81 = hash_tables[v80];

            if not v81 then
                v81 = {};
                hash_tables[v80] = v81;
            end;

            v81[#v81 + 1] = v79 - p67;
            local v82 = v79 + 1;
            local v83 = (v80 * 256 + v75) % 16777216;
            local v84 = hash_tables[v83];

            if not v84 then
                v84 = {};
                hash_tables[v83] = v84;
            end;

            v84[#v84 + 1] = v82 - p67;
            local v85 = v82 + 1;
            v71 = (v83 * 256 + v76) % 16777216;
            local v86 = hash_tables[v71];

            if not v86 then
                v86 = {};
                hash_tables[v71] = v86;
            end;

            v86[#v86 + 1] = v85 - p67;
            v72 = v85 + 1;
        end;

        while v72 <= p67 - 2 do
            local v87 = string_byte(p66, v72 + 2);
            string_table[v72 + 2] = v87;
            v71 = (v71 * 256 + v87) % 16777216;
            local v88 = hash_tables[v71];

            if not v88 then
                v88 = {};
                hash_tables[v71] = v88;
            end;

            v88[#v88 + 1] = v72 - p67;
            v72 = v72 + 1;
        end;
    end;

    return v70;
end;

local function IsValidDictionary(p89: table?) -- Line: 674
    if p89 == nil or type(p89) ~= "table" then
        return false, ("\'dictionary\' - table expected got \'%s\'."):format((type(p89)));
    end;

    if type(p89.adler32) == "number" and (type(p89.string_table) == "table" and (type(p89.strlen) == "number" and (p89.strlen > 0 and (p89.strlen <= 32768 and (p89.strlen == #p89.string_table and type(p89.hash_tables) == "table"))))) then
        return true, "";
    end;

    return false, ("\'%s\' - corrupted dictionary."):format((type(p89)));
end;

local u90 = {
    [0] = { false, nil, 0, 0, 0 },
    [1] = { false, nil, 4, 8, 4 },
    [2] = { false, nil, 5, 18, 8 },
    [3] = { false, nil, 6, 32, 32 },
    [4] = { true, 4, 4, 16, 16 },
    [5] = { true, 8, 16, 32, 32 },
    [6] = { true, 8, 16, 128, 128 },
    [7] = { true, 8, 32, 128, 256 },
    [8] = { true, 32, 128, 258, 1024 },
    [9] = { true, 32, 258, 258, 4096 }
};

local function IsValidArguments(p91: string, p92: boolean?, p93: table?, p94: boolean?, p95: table?) -- Line: 754
    -- upvalues: IsValidDictionary (copy), u90 (copy)
    if type(p91) ~= "string" then
        return false, ("\'str\' - string expected got \'%s\'."):format((type(p91)));
    end;

    if p92 then
        local v96, v97 = IsValidDictionary(p93);

        if not v96 then
            return false, v97;
        end;
    end;

    if p94 then
        local v98 = type(p95);

        if v98 ~= "nil" and v98 ~= "table" then
            return false, ("\'configs\' - nil or table expected got \'%s\'."):format((type(p95)));
        end;

        if v98 == "table" then
            assert(p95);

            for i, v in pairs(p95) do
                if i ~= "level" and i ~= "strategy" then
                    return false, ("\'configs\' - unsupported table key in the configs: \'%s\'."):format(i);
                end;

                if i == "level" and not u90[v] then
                    return false, ("\'configs\' - unsupported \'level\': %s."):format((tostring(v)));
                end;

                if i == "strategy" and (v ~= "fixed" and (v ~= "huffman_only" and v ~= "dynamic")) then
                    return false, ("\'configs\' - unsupported \'strategy\': \'%s\'."):format((tostring(v)));
                end;
            end;
        end;
    end;

    return true, "";
end;

local function CreateWriter() -- Line: 817
    -- upvalues: u2 (copy), u1 (copy), string_char (copy), table_concat (copy)
    local u99 = 0;
    local u100 = 0;
    local u101 = 0;
    local u102 = 0;
    local u103 = {};
    local u104 = {};

    return function(p105: number, p106: number) -- Line: 830, Name: WriteBits
        -- upvalues: u100 (ref), u2 (ref), u101 (ref), u102 (ref), u99 (ref), u103 (ref), u1 (ref)
        u100 = u100 + p105 * u2[u101];
        u101 = u101 + p106;
        u102 = u102 + p106;

        if u101 >= 32 then
            u99 = u99 + 1;
            u103[u99] = u1[u100 % 256] .. u1[(u100 - u100 % 256) / 256 % 256] .. u1[(u100 - u100 % 65536) / 65536 % 256] .. u1[(u100 - u100 % 16777216) / 16777216 % 256];
            local v107 = u2[32 - u101 + p106];
            u100 = (p105 - p105 % v107) / v107;
            u101 = u101 - 32;
        end;
    end, function(p108: string) -- Line: 850, Name: WriteString
        -- upvalues: u101 (ref), u99 (ref), u103 (ref), u100 (ref), string_char (ref), u102 (ref)
        for i = 1, u101, 8 do
            u99 = u99 + 1;
            u103[u99] = string_char(u100 % 256);
            u100 = (u100 - u100 % 256) / 256;
            local _ = i;
        end;

        u101 = 0;
        u99 = u99 + 1;
        u103[u99] = p108;
        u102 = u102 + #p108 * 8;
    end, function(p109: number) -- Line: 869, Name: FlushWriter
        -- upvalues: u102 (ref), u101 (ref), u100 (ref), u2 (ref), u99 (ref), u103 (ref), u1 (ref), table_concat (ref), u104 (copy)
        if p109 == 3 then
            return u102, nil;
        end;

        if p109 == 1 or p109 == 2 then
            local v110 = (8 - u101 % 8) % 8;

            if u101 > 0 then
                u100 = u100 - u2[u101] + u2[u101 + v110];

                for i = 1, u101, 8 do
                    u99 = u99 + 1;
                    u103[u99] = u1[u100 % 256];
                    u100 = (u100 - u100 % 256) / 256;
                    local _ = i;
                end;

                u100 = 0;
                u101 = 0;
            end;

            if p109 == 2 then
                u102 = u102 + v110;

                return u102, nil;
            end;
        end;

        local v111 = table_concat(u103);
        u103 = {};
        u99 = 0;
        u104[#u104 + 1] = v111;

        if p109 == 0 then
            return u102, nil;
        end;

        return u102, table_concat(u104);
    end;
end;

local function MinHeapPush(p112: table, p113: table, p114: number) -- Line: 922
    local v115 = p114 + 1;
    p112[v115] = p113;
    local v116 = (v115 - v115 % 2) / 2;

    while v116 >= 1 and p113[1] < p112[v116][1] do
        local v117 = p112[v116];
        p112[v116] = p113;
        p112[v115] = v117;
        v115 = v116;
        v116 = (v116 - v116 % 2) / 2;
    end;
end;

local function MinHeapPop(p118: table, p119: number) -- Line: 943
    local v120 = p118[1];
    local v121 = p118[p119];
    local v122 = v121[1];
    p118[1] = v121;
    p118[p119] = v120;
    local v123 = p119 - 1;
    local v124 = 1;
    local v125 = v124 * 2;
    local v126 = v125 + 1;

    while v125 <= v123 do
        local v127 = p118[v125];
        local v128;

        if v126 <= v123 and p118[v126][1] < v127[1] then
            local v129 = p118[v126];

            if v129[1] >= v122 then
                break;
            end;

            p118[v126] = v121;
            p118[v124] = v129;
            v128 = v126 * 2;
            v125 = v126;
            v126 = v128 + 1;
        else
            if v127[1] >= v122 then
                break;
            end;

            p118[v125] = v121;
            p118[v124] = v127;
            v128 = v125 * 2;
            v126 = v128 + 1;
        end;

        v124 = v125;
        v125 = v128;
    end;

    return v120;
end;

local function GetHuffmanCodeFromBitlen(p130: table, p131: table, p132: number, p133: number) -- Line: 992
    -- upvalues: u3 (copy)
    local v134 = 0;
    local v135 = {};
    local v136 = {};

    for i = 1, p133 do
        v134 = (v134 + (p130[i - 1] or 0)) * 2;
        v135[i] = v134;
        local _ = i;
    end;

    for i = 0, p132 do
        local v137 = p131[i];
        local v138;

        if v137 then
            local v139 = v135[v137];
            v135[v137] = v139 + 1;

            if v137 <= 9 then
                v136[i] = u3[v137][v139];
                v138 = i;
            else
                v138 = i;
                local v140 = 0;

                for i2 = 1, v137 do
                    local v141 = v140 - v140 % 2 + ((v140 % 2 == 1 or v139 % 2 == 1) and 1 or 0);
                    v139 = (v139 - v139 % 2) / 2;
                    v140 = v141 * 2;
                    local _ = i2;
                end;

                v136[v138] = (v140 - v140 % 2) / 2;
            end;
        else
            v138 = i;
        end;
    end;

    return v136;
end;

local function SortByFirstThenSecond(p142: table, p143: table) -- Line: 1034
    local v144;

    if p142[1] < p143[1] then
        v144 = true;
    elseif p142[1] == p143[1] then
        v144 = p142[2] < p143[2];
    else
        v144 = false;
    end;

    return v144;
end;

local function GetHuffmanBitlenAndCode(p145: table, p146: number, p147: number) -- Line: 1049
    -- upvalues: table_sort (copy), SortByFirstThenSecond (copy), MinHeapPop (copy), MinHeapPush (copy), GetHuffmanCodeFromBitlen (copy)
    local v148 = 0;
    local v149 = {};
    local v150 = {};
    local v151 = {};
    local v152 = -1;
    local v153 = {};
    local v154 = {};

    for i, v in pairs(p145) do
        v148 = v148 + 1;
        v149[v148] = { v, i };
    end;

    if v148 == 0 then
        return {}, {}, -1;
    end;

    if v148 == 1 then
        local v155 = v149[1][2];
        v151[v155] = 1;
        v154[v155] = 0;

        return v151, v154, v155;
    end;

    table_sort(v149, SortByFirstThenSecond);

    for i = 1, v148 do
        v150[i] = v149[i];
        local _ = i;
    end;

    while v148 > 1 do
        local v156 = MinHeapPop(v150, v148);
        local v157 = v148 - 1;
        local v158 = MinHeapPop(v150, v157);
        local v159 = v157 - 1;
        MinHeapPush(v150, {
            v156[1] + v158[1],
            -1,
            v156,
            v158
        }, v159);
        v148 = v159 + 1;
    end;

    local v160 = {
        v150[1],
        {},
        {},
        {}
    };
    v150[1][1] = 0;
    local v161 = 1;
    local v162 = 1;
    local v163 = 0;

    while v161 <= v162 do
        local v164 = v160[v161];
        local v165 = v164[1];
        local v166 = v164[2];
        local v167 = v164[3];
        local v168 = v164[4];

        if v167 then
            v162 = v162 + 1;
            v160[v162] = v167;
            v167[1] = v165 + 1;
        end;

        if v168 then
            v162 = v162 + 1;
            v160[v162] = v168;
            v168[1] = v165 + 1;
        end;

        v161 = v161 + 1;

        if p146 < v165 then
            v163 = v163 + 1;
            v165 = p146;
        end;

        if v166 >= 0 then
            v151[v166] = v165;

            if v152 < v166 then
                v152 = v166 or v152;
            end;

            v153[v165] = (v153[v165] or 0) + 1;
        end;
    end;

    if v163 > 0 then
        repeat
            local v169 = p146 - 1;

            while (v153[v169] or 0) == 0 do
                v169 = v169 - 1;
            end;

            v153[v169] = v153[v169] - 1;
            v153[v169 + 1] = (v153[v169 + 1] or 0) + 2;
            v153[p146] = v153[p146] - 1;
            v163 = v163 - 2;
        until v163 <= 0;

        local v170 = 1;

        for i = p146, 1, -1 do
            local v171 = v153[i] or 0;
            local v172 = i;

            while v171 > 0 do
                v151[v149[v170][2]] = v172;
                v171 = v171 - 1;
                v170 = v170 + 1;
            end;
        end;
    end;

    return v151, GetHuffmanCodeFromBitlen(v153, v151, p147, p146), v152;
end;

local function RunLengthEncodeHuffmanBitlen(p173: table, p174: number, p175: table, p176: number) -- Line: 1187
    local v177 = p174 + (p176 < 0 and 0 or p176) + 1;
    local v178 = 0;
    local v179 = {};
    local v180 = 0;
    local v181 = {};
    local v182 = nil;
    local v183 = 0;
    local v184 = {};

    for i = 0, v177 + 1 do
        local v185;

        if i <= p174 then
            v185 = p173[i] or 0;
        else
            v185 = i <= v177 and (p175[i - p174 - 1] or 0) or nil;
        end;

        local v186;

        if v185 == v182 then
            v178 = v178 + 1;

            if v185 == 0 or v178 ~= 6 then
                if v185 == 0 and v178 == 138 then
                    v183 = v183 + 1;
                    v179[v183] = 18;
                    v180 = v180 + 1;
                    v184[v180] = 127;
                    v181[18] = (v181[18] or 0) + 1;
                    v186 = i;
                    v178 = 0;
                else
                    v186 = i;
                end;
            else
                v183 = v183 + 1;
                v179[v183] = 16;
                v180 = v180 + 1;
                v184[v180] = 3;
                v181[16] = (v181[16] or 0) + 1;
                v186 = i;
                v178 = 0;
            end;
        else
            if v178 == 1 then
                assert(v182);
                v183 = v183 + 1;
                v179[v183] = v182;
                v181[v182] = (v181[v182] or 0) + 1;
            elseif v178 == 2 then
                assert(v182);
                local v187 = v183 + 1;
                v179[v187] = v182;
                v183 = v187 + 1;
                v179[v183] = v182;
                v181[v182] = (v181[v182] or 0) + 2;
            elseif v178 >= 3 then
                v183 = v183 + 1;
                local v188 = v182 == 0 and (v178 <= 10 and 17 or 18) or 16;
                v179[v183] = v188;
                v181[v188] = (v181[v188] or 0) + 1;
                v180 = v180 + 1;
                v184[v180] = v178 <= 10 and v178 - 3 or v178 - 11;
            end;

            if v185 and v185 ~= 0 then
                v183 = v183 + 1;
                v179[v183] = v185;
                v181[v185] = (v181[v185] or 0) + 1;
                v182 = v185;
                v186 = i;
                v178 = 0;
            else
                v182 = v185;
                v186 = i;
                v178 = 1;
            end;
        end;
    end;

    return v179, v184, v181;
end;

local function LoadStringToTable(p189: string, p190: any, p191: number, p192: number, p193: number) -- Line: 1272
    -- upvalues: string_byte (copy)
    local v194 = p191 - p193;

    while v194 <= p192 - 15 - p193 do
        local v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209, v210 = string_byte(p189, v194 + p193, v194 + 15 + p193);
        p190[v194] = v195;
        p190[v194 + 1] = v196;
        p190[v194 + 2] = v197;
        p190[v194 + 3] = v198;
        p190[v194 + 4] = v199;
        p190[v194 + 5] = v200;
        p190[v194 + 6] = v201;
        p190[v194 + 7] = v202;
        p190[v194 + 8] = v203;
        p190[v194 + 9] = v204;
        p190[v194 + 10] = v205;
        p190[v194 + 11] = v206;
        p190[v194 + 12] = v207;
        p190[v194 + 13] = v208;
        p190[v194 + 14] = v209;
        p190[v194 + 15] = v210;
        v194 = v194 + 16;
    end;

    while v194 <= p192 - p193 do
        p190[v194] = string_byte(p189, v194 + p193, v194 + p193);
        v194 = v194 + 1;
    end;

    return p190;
end;

local function GetBlockLZ77Result(p211: number, p212: table, p213: table, p214: number, p215: number, p216: number, p217: table?) -- Line: 1328
    -- upvalues: u90 (copy), u5 (copy), u6 (copy), u7 (copy), u9 (copy), u8 (copy), u4 (copy)
    local v218 = u90[p211];
    local v219 = v218[1];
    local v220 = v218[2];
    local v221 = v218[3];
    local v222 = v218[4];
    local v223 = v218[5];
    local v224 = (v219 or not v221) and 2147483646 or v221;
    local v225 = v223 - v223 % 4 / 4;
    local v226, v227, v228;

    if p217 then
        v226 = p217.hash_tables;
        v227 = p217.string_table;
        v228 = p217.strlen;
        assert(p214 == 1);

        if p214 <= p215 and v228 >= 2 then
            local v229 = v227[v228 - 1] * 65536 + v227[v228] * 256 + p212[1];
            local v230 = p213[v229];

            if not v230 then
                v230 = {};
                p213[v229] = v230;
            end;

            v230[#v230 + 1] = -1;
        end;

        if p214 + 1 <= p215 and v228 >= 1 then
            local v231 = v227[v228] * 65536 + p212[1] * 256 + p212[2];
            local v232 = p213[v231];

            if not v232 then
                v232 = {};
                p213[v231] = v232;
            end;

            v232[#v232 + 1] = 0;
        end;
    else
        v228 = 0;
        v226 = {};
        v227 = {};
    end;

    local v233 = v228 + 3;
    local v234 = (p212[p214 - p216] or 0) * 256 + (p212[p214 + 1 - p216] or 0);
    local v235 = p215 + (v219 and 1 or 0);
    local v236 = 0;
    local v237 = 0;
    local v238 = {};
    local v239 = false;
    local v240 = {};
    local v241 = 0;
    local v242 = 0;
    local v243 = {};
    local v244 = {};
    local v245 = 0;
    local v246 = {};
    local v247 = 0;
    local v248 = {};

    while true do
        if p214 > v235 then
            v246[v241 + 1] = 256;
            v238[256] = (v238[256] or 0) + 1;

            return v246, v244, v238, v240, v248, v243;
        end;

        local v249 = p214 - p216;
        local v250 = p216 - 3;
        local v251 = 0;
        v234 = (v234 * 256 + (p212[v249 + 2] or 0)) % 16777216;
        local v252 = nil;
        local v253 = p213[v234];
        local v254, v255;

        if v253 then
            v254 = #v253;
            v255 = v254;
            v252 = v253;
        else
            v255 = 0;
            v253 = {};
            p213[v234] = v253;

            if v226 then
                v252 = v226[v234];
                v254 = v252 and (#v252 or 0) or 0;
            else
                v254 = 0;
            end;
        end;

        if p214 <= p215 then
            v253[v255 + 1] = p214;
        end;

        local v256, v257;

        if v254 > 0 and (p214 + 2 <= p215 and (not v219 or v236 < v221)) then
            local v258;

            if v219 and (v220 <= v236 and v225) then
                v258 = v225;
            else
                v258 = v223;
            end;

            local v259 = p215 - p214;
            local v260 = (v259 >= 257 and 257 or v259) + v249;
            local v261 = v249 + 3;
            v256 = v237;

            while true do
                if v254 < 1 or v258 <= 0 then
                    v257 = v251;
                    break;
                end;

                local v262 = v252[v254];

                if p214 - v262 > 32768 then
                    v257 = v251;
                    break;
                end;

                local v263;

                if v262 < p214 then
                    if v262 >= -257 then
                        local v264 = v262 - v250;
                        v263 = v261;

                        while v261 <= v260 and p212[v264] == p212[v261] do
                            v261 = v261 + 1;
                            v264 = v264 + 1;
                        end;
                    else
                        local v265 = v233 + v262;
                        local v266 = v261;

                        while v266 <= v260 and v227[v265] == p212[v266] do
                            v266 = v266 + 1;
                            v265 = v265 + 1;
                        end;

                        v263 = v261;
                        v261 = v266;
                    end;

                    v257 = v261 - v249;

                    if v251 < v257 then
                        v237 = p214 - v262;
                    else
                        v257 = v251;
                    end;

                    if v222 <= v257 then
                        break;
                    end;
                else
                    v257 = v251;
                    v263 = v261;
                end;

                v254 = v254 - 1;
                v258 = v258 - 1;

                if v254 == 0 and (v262 > 0 and v226) then
                    v252 = v226[v234];
                    v254 = v252 and (#v252 or 0) or 0;
                end;

                v251 = v257;
                v261 = v263;
            end;
        else
            v256 = v237;
            v257 = v251;
        end;

        if not v219 then
            v236 = v257;
            v256 = v237;
        end;

        if (not v219 or v239) and ((v236 > 3 or v236 == 3 and v256 < 4096) and v257 <= v236) then
            local v267 = u5[v236];
            local v268 = u6[v236];
            local v269, v270, v271;

            if v256 <= 256 then
                v269 = u7[v256];
                v270 = u9[v256];
                v271 = u8[v256];
            else
                v271 = 7;
                v269 = 16;
                local v272 = 512;
                local v273 = 384;

                while true do
                    if v256 <= v273 then
                        v270 = (v256 - v272 / 2 - 1) % (v272 / 4);
                    end;

                    if v256 <= v272 then
                        v270 = (v256 - v272 / 2 - 1) % (v272 / 4);
                        v269 = v269 + 1;
                    end;

                    v269 = v269 + 2;
                    v271 = v271 + 1;
                    v273 = v273 * 2;
                    v272 = v272 * 2;
                end;
            end;

            v241 = v241 + 1;
            v246[v241] = v267;
            v238[v267] = (v238[v267] or 0) + 1;
            v242 = v242 + 1;
            v240[v242] = v269;
            v243[v269] = (v243[v269] or 0) + 1;

            if v268 > 0 then
                v245 = v245 + 1;
                v244[v245] = u4[v236];
            end;

            if v271 > 0 then
                v247 = v247 + 1;
                v248[v247] = v270;
            end;

            for i = p214 + 1, p214 + v236 - (v219 and 2 or 1) do
                v234 = (v234 * 256 + (p212[i - p216 + 2] or 0)) % 16777216;
                local v274;

                if v236 <= v224 then
                    local v275 = p213[v234];

                    if not v275 then
                        v275 = {};
                        p213[v234] = v275;
                    end;

                    v275[#v275 + 1] = i;
                    v274 = i;
                else
                    v274 = i;
                end;
            end;

            p214 = p214 + v236 - (v219 and 1 or 0);
            v239 = false;
        elseif v219 and not v239 then
            p214 = p214 + 1;
            v239 = true;
        else
            if v219 then
                v249 = v249 - 1 or v249;
            end;

            local v276 = p212[v249];
            v241 = v241 + 1;
            v246[v241] = v276;
            v238[v276] = (v238[v276] or 0) + 1;
            p214 = p214 + 1;
        end;

        v236 = v257;
    end;
end;

local function GetBlockDynamicHuffmanHeader(p277: table, p278: table) -- Line: 1582
    -- upvalues: GetHuffmanBitlenAndCode (copy), RunLengthEncodeHuffmanBitlen (copy), u14 (copy)
    local v279, v280, v281 = GetHuffmanBitlenAndCode(p277, 15, 285);
    local v282, v283, v284 = GetHuffmanBitlenAndCode(p278, 15, 29);
    local v285, v286, v287 = RunLengthEncodeHuffmanBitlen(v279, v281, v282, v284);
    local v288, v289 = GetHuffmanBitlenAndCode(v287, 7, 18);
    local v290 = 0;

    for i = 1, 19 do
        local v291;

        if (v288[u14[i]] or 0) == 0 then
            v291 = i;
        else
            v290 = i;
            v291 = v290;
            local v292 = v290;
            v290 = v291;
            v292 = v291;
        end;
    end;

    local v293 = v284 + 1 - 1;

    return v281 + 1 - 257, v293 < 0 and 0 or v293, v290 - 4, v288, v289, v285, v286, v279, v280, v282, v283;
end;

local function GetDynamicHuffmanBlockSize(p294: table, p295: table, p296: number, p297: table, p298: table, p299: table, p300: table) -- Line: 1644
    -- upvalues: u20 (copy)
    local v301 = 17 + (p296 + 4) * 3;

    for i = 1, #p298 do
        local v302 = p298[i];
        v301 = v301 + p297[v302];
        local v303;

        if v302 >= 16 then
            v301 = v301 + (v302 == 16 and 2 or (v302 == 17 and 3 or 7));
            v303 = i;
        else
            v303 = i;
        end;
    end;

    local v304 = 0;

    for i = 1, #p294 do
        local v305 = p294[i];
        v301 = v301 + p299[v305];
        local v306;

        if v305 > 256 then
            v304 = v304 + 1;

            if v305 > 264 and v305 < 285 then
                v301 = v301 + u20[v305 - 256];
            end;

            local v307 = p295[v304];
            v301 = v301 + p300[v307];

            if v307 > 3 then
                v301 = v301 + ((v307 - v307 % 2) / 2 - 1);
                v306 = i;
            else
                v306 = i;
            end;
        else
            v306 = i;
        end;
    end;

    return v301;
end;

local function CompressDynamicHuffmanBlock(p308, p309, p310, p311, p312, p313, p314, p315, p316, p317, p318, p319, p320, p321, p322, p323, p324) -- Line: 1690
    -- upvalues: u14 (copy), u20 (copy)
    p308(p309 and 1 or 0, 1);
    p308(2, 2);
    p308(p314, 5);
    p308(p315, 5);
    p308(p316, 4);

    for i = 1, p316 + 4 do
        p308(p317[u14[i]] or 0, 3);
        local _ = i;
    end;

    local v325 = 1;

    for i = 1, #p319 do
        local v326 = p319[i];
        p308(p318[v326], p317[v326]);
        local v327;

        if v326 >= 16 then
            p308(p320[v325], v326 == 16 and 2 or (v326 == 17 and 3 or 7));
            v325 = v325 + 1;
            v327 = i;
        else
            v327 = i;
        end;
    end;

    local v328 = 0;
    local v329 = 0;
    local v330 = 0;

    for i = 1, #p310 do
        local v331 = p310[i];
        p308(p322[v331], p321[v331]);
        local v332;

        if v331 > 256 then
            v329 = v329 + 1;

            if v331 > 264 and v331 < 285 then
                v328 = v328 + 1;
                p308(p311[v328], u20[v331 - 256]);
            end;

            local v333 = p312[v329];
            p308(p324[v333], p323[v333]);

            if v333 > 3 then
                v330 = v330 + 1;
                p308(p313[v330], (v333 - v333 % 2) / 2 - 1);
                v332 = i;
            else
                v332 = i;
            end;
        else
            v332 = i;
        end;
    end;
end;

local function GetFixedHuffmanBlockSize(p334: table, p335: table) -- Line: 1771
    -- upvalues: u21 (ref), u20 (copy)
    local v336 = 3;
    local v337 = 0;

    for i = 1, #p334 do
        local v338 = p334[i];
        v336 = v336 + u21[v338];
        local v339;

        if v338 > 256 then
            v337 = v337 + 1;

            if v338 > 264 and v338 < 285 then
                v336 = v336 + u20[v338 - 256];
            end;

            local v340 = p335[v337];
            v336 = v336 + 5;

            if v340 > 3 then
                v336 = v336 + ((v340 - v340 % 2) / 2 - 1);
                v339 = i;
            else
                v339 = i;
            end;
        else
            v339 = i;
        end;
    end;

    return v336;
end;

local function CompressFixedHuffmanBlock(p341: function, p342: boolean, p343: table, p344: table, p345: table, p346: table) -- Line: 1799
    -- upvalues: u22 (ref), u21 (ref), u20 (copy), u15 (ref)
    p341(p342 and 1 or 0, 1);
    p341(1, 2);
    local v347 = 0;
    local v348 = 0;
    local v349 = 0;

    for i = 1, #p343 do
        local v350 = p343[i];
        p341(u22[v350], u21[v350]);
        local v351;

        if v350 > 256 then
            v347 = v347 + 1;

            if v350 > 264 and v350 < 285 then
                v348 = v348 + 1;
                p341(p344[v348], u20[v350 - 256]);
            end;

            local v352 = p345[v347];
            p341(u15[v352], 5);

            if v352 > 3 then
                v349 = v349 + 1;
                p341(p346[v349], (v352 - v352 % 2) / 2 - 1);
                v351 = i;
            else
                v351 = i;
            end;
        else
            v351 = i;
        end;
    end;
end;

local function GetStoreBlockSize(p353: number, p354: number, p355: number) -- Line: 1847
    assert(p354 - p353 + 1 <= 65535);

    return 3 + (8 - (p355 + 3) % 8) % 8 + 32 + (p354 - p353 + 1) * 8;
end;

local function CompressStoreBlock(p356: function, p357: function, p358: boolean, p359: string, p360: number, p361: number, p362: number) -- Line: 1861
    -- upvalues: u2 (copy)
    assert(p361 - p360 + 1 <= 65535);
    p356(p358 and 1 or 0, 1);
    p356(0, 2);
    local v363 = (8 - (p362 + 3) % 8) % 8;

    if v363 > 0 then
        p356(u2[v363] - 1, v363);
    end;

    local v364 = p361 - p360 + 1;
    p356(v364, 16);
    p356(255 - v364 % 256 + (255 - (v364 - v364 % 256) / 256) * 256, 16);
    p357(p359:sub(p360, p361));
end;

local function Deflate(p365: table?, p366: function, p367: function, p368: function, p369: string, p370: table?) -- Line: 1899
    -- upvalues: LoadStringToTable (copy), GetBlockLZ77Result (copy), GetBlockDynamicHuffmanHeader (copy), GetDynamicHuffmanBlockSize (copy), GetFixedHuffmanBlockSize (copy), CompressStoreBlock (copy), CompressFixedHuffmanBlock (copy), CompressDynamicHuffmanBlock (copy)
    local v371 = {};
    local v372 = {};
    local v373 = nil;
    local v374 = 0;
    local v375 = 0;
    local v376, _ = p368(3);
    local v377 = #p369;
    local v378 = nil;
    local v379 = nil;

    if p365 then
        if p365.level then
            v378 = p365.level;
        end;

        if p365.strategy then
            v379 = p365.strategy;
        end;
    end;

    if not v378 then
        if v377 < 2048 then
            v378 = 7;
        elseif v377 > 65536 then
            v378 = 3;
        else
            v378 = 5;
        end;
    end;

    while not v373 do
        local v380;

        if v374 == 0 then
            v374 = 1;
            v380 = 0;
            v375 = 65535;
        else
            v374 = v375 + 1;
            v375 = v375 + 32768;
            v380 = v374 - 32768 - 1;
        end;

        if v377 <= v375 then
            v375 = v377;
            v373 = true;
        else
            v373 = false;
        end;

        local v381, v382, v383, v384, v385, v386, v387, v388, v389, v390, v391, v392, v393, v394, v395, v396, v397;

        if v378 == 0 then
            v381 = nil;
            v382 = {};
            v383 = nil;
            v384 = {};
            v385 = nil;
            v386 = {};
            v387 = {};
            v388 = {};
            v389 = {};
            v390 = {};
            v391 = nil;
            v392 = {};
            v393 = {};
            v394 = nil;
            v395 = {};
            v396 = {};
            v397 = {};
        else
            LoadStringToTable(p369, v371, v374, v375 + 3, v380);

            if v374 == 1 and p370 then
                local string_table = p370.string_table;
                local strlen = p370.strlen;

                for i = 0, -strlen + 1 < -257 and -257 or -strlen + 1, -1 do
                    v371[i] = string_table[strlen + i];
                    local _ = i;
                end;
            end;

            local v398, v399;

            if v379 == "huffman_only" then
                v384 = {};
                LoadStringToTable(p369, v384, v374, v375, v374 - 1);
                v384[v375 - v374 + 2] = 256;
                v398 = {};
                v395 = {};

                for i = 1, v375 - v374 + 2 do
                    local v400 = v384[i];
                    v398[v400] = (v398[v400] or 0) + 1;
                    local _ = i;
                end;

                v392 = {};
                v399 = {};
                v387 = {};
            else
                v384, v395, v398, v392, v387, v399 = GetBlockLZ77Result(v378, v371, v372, v374, v375, v380, p370);
            end;

            v385, v394, v391, v390, v397, v386, v393, v388, v396, v389, v382 = GetBlockDynamicHuffmanHeader(v398, v399);
            v381 = GetDynamicHuffmanBlockSize(v384, v392, v391, v390, v386, v388, v389);
            v383 = GetFixedHuffmanBlockSize(v384, v392);
        end;

        assert(v375 - v374 + 1 <= 65535);
        local v401 = 3 + (8 - (v376 + 3) % 8) % 8 + 32 + (v375 - v374 + 1) * 8;
        local v402;

        if v383 and (v383 < v401 and v383) then
            v402 = v383;
        else
            v402 = v401;
        end;

        if v381 and (v381 < v402 and v381) then
            v402 = v381;
        end;

        if v378 == 0 or v379 ~= "fixed" and (v379 ~= "dynamic" and v401 == v402) then
            CompressStoreBlock(p366, p367, v373, p369, v374, v375, v376);
            v376 = v376 + v401;
        elseif v379 == "dynamic" or v379 ~= "fixed" and v383 ~= v402 then
            if v379 == "dynamic" or v381 == v402 then
                CompressDynamicHuffmanBlock(p366, v373, v384, v395, v392, v387, v385, v394, v391, v390, v397, v386, v393, v388, v396, v389, v382);
                v376 = v376 + assert(v381);
            end;
        else
            CompressFixedHuffmanBlock(p366, v373, v384, v395, v392, v387);
            v376 = v376 + assert(v383);
        end;

        local v403;

        if v373 then
            v403 = p368(3);
        else
            v403 = p368(0);
        end;

        assert(v403 == v376);

        if not v373 then
            if p370 and v374 == 1 then
                local v404 = 0;

                while v371[v404] do
                    v371[v404] = nil;
                    v404 = v404 - 1;
                end;
            end;

            local v405 = 1;
            p370 = nil;

            for i = v375 - 32767, v375 do
                v371[v405] = v371[i - v380];
                v405 = v405 + 1;
                local _ = i;
            end;

            for i, v in pairs(v372) do
                local v406 = #v;

                if v406 > 0 and v375 + 1 - v[1] > 32768 then
                    if v406 == 1 then
                        v372[i] = nil;
                    else
                        local v407 = v;
                        local v408 = 0;
                        local v409 = {};

                        for i2 = 2, v406 do
                            local v410 = v407[i2];
                            local v411;

                            if v375 + 1 - v410 <= 32768 then
                                v408 = v408 + 1;
                                v409[v408] = v410;
                                v411 = i2;
                            else
                                v411 = i2;
                            end;
                        end;

                        v372[i] = v409;
                    end;
                end;
            end;
        end;
    end;
end;

local function CompressDeflateInternal(p412: string, p413: table?, p414: table?) -- Line: 2123
    -- upvalues: CreateWriter (copy), Deflate (copy)
    local v415, v416, v417 = CreateWriter();
    Deflate(p414, v415, v416, v417, p412, p413);
    local v418, v419 = v417(1);
    assert(v419);

    return v419, (8 - v418 % 8) % 8;
end;

local function CompressZlibInternal(p420: string, p421: table?, p422: table?) -- Line: 2134
    -- upvalues: CreateWriter (copy), Deflate (copy), u19 (copy)
    local v423, v424, v425 = CreateWriter();
    v423(120, 8);
    local v426 = p421 and 1 or 0;
    local v427 = 128 + v426 * 32;
    v423(v427 + (31 - (30720 + v427) % 31), 8);

    if v426 == 1 then
        assert(p421);
        local adler32 = p421.adler32;
        local v428 = adler32 % 256;
        local v429 = (adler32 - v428) / 256;
        local v430 = v429 % 256;
        local v431 = (v429 - v430) / 256;
        local v432 = v431 % 256;
        v423((v431 - v432) / 256 % 256, 8);
        v423(v432, 8);
        v423(v430, 8);
        v423(v428, 8);
    end;

    Deflate(p422, v423, v424, v425, p420, p421);
    v425(2);
    local v433 = u19:Adler32(p420);
    local v434 = v433 % 256;
    local v435 = (v433 - v434) / 256;
    local v436 = v435 % 256;
    local v437 = (v435 - v436) / 256;
    local v438 = v437 % 256;
    v423((v437 - v438) / 256 % 256, 8);
    v423(v438, 8);
    v423(v436, 8);
    v423(v434, 8);
    local v439, v440 = v425(1);
    assert(v440);

    return v440, (8 - v439 % 8) % 8;
end;

function u19.CompressDeflate(p441, p442, p443) -- Line: 2205
    -- upvalues: IsValidArguments (copy), CompressDeflateInternal (copy)
    local v444, v445 = IsValidArguments(p442, false, nil, true, p443);

    if not v444 then
        error("Usage: LibDeflate:CompressDeflate(str, configs): " .. v445, 2);
    end;

    return CompressDeflateInternal(p442, nil, p443);
end;

function u19.CompressDeflateWithDict(p446, p447, p448, p449) -- Line: 2229
    -- upvalues: IsValidArguments (copy), CompressDeflateInternal (copy)
    local v450, v451 = IsValidArguments(p447, true, p448, true, p449);

    if not v450 then
        error("Usage: LibDeflate:CompressDeflateWithDict" .. "(str, dictionary, configs): " .. v451, 2);
    end;

    return CompressDeflateInternal(p447, p448, p449);
end;

function u19.CompressZlib(p452, p453, p454) -- Line: 2247
    -- upvalues: IsValidArguments (copy), CompressZlibInternal (copy)
    local v455, v456 = IsValidArguments(p453, false, nil, true, p454);

    if not v455 then
        error("Usage: LibDeflate:CompressZlib(str, configs): " .. v456, 2);
    end;

    return CompressZlibInternal(p453, nil, p454);
end;

function u19.CompressZlibWithDict(p457, p458, p459, p460) -- Line: 2268
    -- upvalues: IsValidArguments (copy), CompressZlibInternal (copy)
    local v461, v462 = IsValidArguments(p458, true, p459, true, p460);

    if not v461 then
        error("Usage: LibDeflate:CompressZlibWithDict" .. "(str, dictionary, configs): " .. v462, 2);
    end;

    return CompressZlibInternal(p458, p459, p460);
end;

local function CreateReader(u463: string) -- Line: 2296
    -- upvalues: u2 (copy), string_byte (copy), string_char (copy), string_sub (copy), u3 (copy)
    local u464 = #u463;
    local u465 = 1;
    local u466 = 0;
    local u467 = 0;

    return function(p468: number) -- Line: 2309, Name: ReadBits
        -- upvalues: u2 (ref), u466 (ref), u467 (ref), u463 (copy), u465 (ref), string_byte (ref)
        local v469 = u2[p468];

        if p468 <= u466 then
            local v470 = u467 % v469;
            u467 = (u467 - v470) / v469;
            u466 = u466 - p468;

            return v470;
        end;

        local v471 = u2[u466];
        local v472, v473, v474, v475 = string_byte(u463, u465, u465 + 3);
        u467 = u467 + ((v472 or 0) + (v473 or 0) * 256 + (v474 or 0) * 65536 + (v475 or 0) * 16777216) * v471;
        u465 = u465 + 4;
        u466 = u466 + 32 - p468;
        local v476 = u467 % v469;
        u467 = (u467 - v476) / v469;

        return v476;
    end, function(p477: number, p478: table, p479: number) -- Line: 2337, Name: ReadBytes
        -- upvalues: u466 (ref), u467 (ref), string_char (ref), u464 (copy), u465 (ref), u463 (copy), string_sub (ref)
        assert(u466 % 8 == 0);
        local v480;

        if u466 / 8 < p477 then
            v480 = u466 / 8 or p477;
        else
            v480 = p477;
        end;

        for i = 1, v480 do
            local v481 = u467 % 256;
            p479 = p479 + 1;
            p478[p479] = string_char(v481);
            u467 = (u467 - v481) / 256;
            local _ = i;
        end;

        u466 = u466 - v480 * 8;
        local v482 = p477 - v480;

        if (u464 - u465 - v482 + 1) * 8 + u466 < 0 then
            return -1;
        end;

        for i = u465, u465 + v482 - 1 do
            p479 = p479 + 1;
            p478[p479] = string_sub(u463, i, i);
            local _ = i;
        end;

        u465 = u465 + v482;

        return p479;
    end, function(p483: table, p484: table, p485: number) -- Line: 2372, Name: Decode
        -- upvalues: u466 (ref), u463 (copy), u2 (ref), u465 (ref), string_byte (ref), u467 (ref), u3 (ref)
        local v486, v487, v488;

        if p485 > 0 then
            if u466 < 15 and u463 then
                local v489 = u2[u466];
                local v490, v491, v492, v493 = string_byte(u463, u465, u465 + 3);
                u467 = u467 + ((v490 or 0) + (v491 or 0) * 256 + (v492 or 0) * 65536 + (v493 or 0) * 16777216) * v489;
                u465 = u465 + 4;
                u466 = u466 + 32;
            end;

            local v494 = u2[p485];
            u466 = u466 - p485;
            local v495 = u467 % v494;
            u467 = (u467 - v495) / v494;
            local v496 = u3[p485][v495];
            v486 = p483[p485];

            if v496 < v486 then
                return p484[v496];
            end;

            v487 = v486 * 2;
            v488 = v496 * 2;
        else
            v488 = 0;
            v487 = 0;
            v486 = 0;
        end;

        for i = p485 + 1, 15 do
            local v497 = u467 % 2;
            u467 = (u467 - v497) / 2;
            u466 = u466 - 1;

            if v497 == 1 then
                v488 = v488 + 1 - v488 % 2 or v488;
            end;

            local v498 = p483[i] or 0;
            local v499 = v488 - v487;

            if v499 < v498 then
                return p484[v486 + v499];
            end;

            v486 = v486 + v498;
            v487 = (v487 + v498) * 2;
            v488 = v488 * 2;
            local _ = i;
        end;

        return -10;
    end, function() -- Line: 2431, Name: ReaderBitlenLeft
        -- upvalues: u464 (copy), u465 (ref), u466 (ref)
        return (u464 - u465 + 1) * 8 + u466;
    end, function() -- Line: 2435, Name: SkipToByteBoundary
        -- upvalues: u466 (ref), u2 (ref), u467 (ref)
        local v500 = u466 % 8;
        local v501 = u2[v500];
        u466 = u466 - v500;
        u467 = (u467 - u467 % v501) / v501;
    end;
end;

local function CreateDecompressState(p502: string, p503: table?) -- Line: 2450
    -- upvalues: CreateReader (copy)
    local v504, v505, v506, v507, v508 = CreateReader(p502);

    return {
        buffer_size = 0,
        ReadBits = v504,
        ReadBytes = v505,
        Decode = v506,
        ReaderBitlenLeft = v507,
        SkipToByteBoundary = v508,
        buffer = {},
        result_buffer = {},
        dictionary = p503
    };
end;

local function GetHuffmanForDecode(p509: table, p510: number, p511: number) -- Line: 2475
    local v512 = p511;
    local v513 = {};

    for i = 0, p510 do
        local v514 = p509[i] or 0;

        if v514 > 0 and (v514 < p511 and v514) then
            p511 = v514;
        end;

        v513[v514] = (v513[v514] or 0) + 1;
        local _ = i;
    end;

    if v513[0] == p510 + 1 then
        return 0, v513, {}, 0;
    end;

    local v515 = 1;

    for i = 1, v512 do
        v515 = v515 * 2 - (v513[i] or 0);

        if v515 < 0 then
            return v515, {}, {}, 0;
        end;

        local _ = i;
    end;

    local v516 = { 0 };

    for i = 1, v512 - 1 do
        v516[i + 1] = v516[i] + (v513[i] or 0);
        local _ = i;
    end;

    local v517 = {};

    for i = 0, p510 do
        local v518 = p509[i] or 0;
        local v519;

        if v518 == 0 then
            v519 = i;
        else
            v517[v516[v518]] = i;
            v516[v518] = v516[v518] + 1;
            v519 = i;
        end;
    end;

    return v515, v513, v517, p511;
end;

local function DecodeUntilEndOfBlock(p520: table, p521: table, p522: table, p523: number, p524: table, p525: table, p526: number) -- Line: 2541
    -- upvalues: u1 (copy), u10 (copy), u20 (copy), u16 (copy), u11 (copy), table_concat (copy)
    local buffer = p520.buffer;
    local buffer_size = p520.buffer_size;
    local ReadBits = p520.ReadBits;
    local Decode = p520.Decode;
    local ReaderBitlenLeft = p520.ReaderBitlenLeft;
    local result_buffer = p520.result_buffer;
    local dictionary = p520.dictionary;
    local v527, v528, v529;

    if dictionary and not buffer[0] then
        v527 = dictionary.string_table;
        v528 = dictionary.strlen;
        v529 = -v528 + 1;

        for i = 0, -v528 + 1 < -257 and -257 or -v528 + 1, -1 do
            buffer[i] = u1[v527[v528 + i]];
            local _ = i;
        end;
    else
        v528 = nil;
        v527 = {};
        v529 = 1;
    end;

    while true do
        local v530 = Decode(p521, p522, p523);

        if v530 < 0 or v530 > 285 then
            break;
        end;

        if v530 < 256 then
            buffer_size = buffer_size + 1;
            buffer[buffer_size] = u1[v530];
        elseif v530 > 256 then
            local v531 = v530 - 256;
            local v532 = u10[v531];

            if v531 >= 8 then
                v532 = v532 + ReadBits(u20[v531]) or v532;
            end;

            v530 = Decode(p524, p525, p526);

            if v530 < 0 or v530 > 29 then
                return -10;
            end;

            local v533 = u16[v530];

            if v533 > 4 then
                v533 = v533 + ReadBits(u11[v530]) or v533;
            end;

            local v534 = buffer_size - v533 + 1;

            if v534 < v529 then
                return -11;
            end;

            if v534 >= -257 then
                for i = 1, v532 do
                    buffer_size = buffer_size + 1;
                    buffer[buffer_size] = buffer[v534];
                    v534 = v534 + 1;
                    local _ = i;
                end;
            else
                local v535 = v528 + v534;

                for i = 1, v532 do
                    buffer_size = buffer_size + 1;
                    buffer[buffer_size] = u1[v527[v535]];
                    v535 = v535 + 1;
                    local _ = i;
                end;
            end;
        end;

        if ReaderBitlenLeft() < 0 then
            return 2;
        end;

        if buffer_size >= 65536 then
            result_buffer[#result_buffer + 1] = table_concat(buffer, "", 1, 32768);

            for i = 32769, buffer_size do
                buffer[i - 32768] = buffer[i];
                local _ = i;
            end;

            buffer_size = buffer_size - 32768;
            buffer[buffer_size + 1] = nil;
        end;

        if v530 == 256 then
            p520.buffer_size = buffer_size;

            return 0;
        end;
    end;

    return -10;
end;

local function DecompressStoreBlock(p536: table) -- Line: 2634
    -- upvalues: table_concat (copy)
    local buffer = p536.buffer;
    local buffer_size = p536.buffer_size;
    local ReadBits = p536.ReadBits;
    local ReadBytes = p536.ReadBytes;
    local ReaderBitlenLeft = p536.ReaderBitlenLeft;
    local result_buffer = p536.result_buffer;
    p536.SkipToByteBoundary();
    local v537 = ReadBits(16);

    if ReaderBitlenLeft() < 0 then
        return 2;
    end;

    local v538 = ReadBits(16);

    if ReaderBitlenLeft() < 0 then
        return 2;
    end;

    if v537 % 256 + v538 % 256 ~= 255 then
        return -2;
    end;

    if (v537 - v537 % 256) / 256 + (v538 - v538 % 256) / 256 ~= 255 then
        return -2;
    end;

    local v539 = ReadBytes(v537, buffer, buffer_size);

    if v539 < 0 then
        return 2;
    end;

    if v539 >= 65536 then
        result_buffer[#result_buffer + 1] = table_concat(buffer, "", 1, 32768);

        for i = 32769, v539 do
            buffer[i - 32768] = buffer[i];
            local _ = i;
        end;

        v539 = v539 - 32768;
        buffer[v539 + 1] = nil;
    end;

    p536.buffer_size = v539;

    return 0;
end;

local function DecompressFixBlock(p540: table) -- Line: 2683
    -- upvalues: DecodeUntilEndOfBlock (copy), u12 (ref), u17 (ref), u13 (ref), u18 (ref)
    return DecodeUntilEndOfBlock(p540, u12, u17, 7, u13, u18, 5);
end;

local function DecompressDynamicBlock(p541: table) -- Line: 2698
    -- upvalues: u14 (copy), GetHuffmanForDecode (copy), DecodeUntilEndOfBlock (copy)
    local ReadBits = p541.ReadBits;
    local Decode = p541.Decode;
    local v542 = ReadBits(5) + 257;
    local v543 = ReadBits(5) + 1;
    local v544 = ReadBits(4) + 4;

    if v542 > 286 or v543 > 30 then
        return -3;
    end;

    local v545 = {};

    for i = 1, v544 do
        v545[u14[i]] = ReadBits(3);
        local _ = i;
    end;

    local v546, v547, v548, v549 = GetHuffmanForDecode(v545, 18, 7);

    if v546 ~= 0 then
        return -4;
    end;

    local v550 = 0;
    local v551 = {};
    local v552 = {};

    while v550 < v542 + v543 do
        local v553 = Decode(v547, v548, v549);

        if v553 < 0 then
            return v553;
        end;

        if v553 < 16 then
            if v550 < v542 then
                v551[v550] = v553;
            else
                v552[v550 - v542] = v553;
            end;

            v550 = v550 + 1;
        else
            local v554 = 0;
            local v555;

            if v553 == 16 then
                if v550 == 0 then
                    return -5;
                end;

                if v550 - 1 < v542 then
                    v554 = v551[v550 - 1];
                else
                    v554 = v552[v550 - v542 - 1];
                end;

                v555 = 3 + ReadBits(2);
            elseif v553 == 17 then
                v555 = 3 + ReadBits(3);
            else
                v555 = 11 + ReadBits(7);
            end;

            if v550 + v555 > v542 + v543 then
                return -6;
            end;

            while v555 > 0 do
                v555 = v555 - 1;

                if v550 < v542 then
                    v551[v550] = v554;
                else
                    v552[v550 - v542] = v554;
                end;

                v550 = v550 + 1;
            end;
        end;
    end;

    if (v551[256] or 0) == 0 then
        return -9;
    end;

    local v556, v557, v558, v559 = GetHuffmanForDecode(v551, v542 - 1, 15);

    if v556 ~= 0 and (v556 < 0 or v542 ~= (v557[0] or 0) + (v557[1] or 0)) then
        return -7;
    end;

    local v560, v561, v562, v563 = GetHuffmanForDecode(v552, v543 - 1, 15);

    return v560 ~= 0 and (v560 < 0 or v543 ~= (v561[0] or 0) + (v561[1] or 0)) and -8 or DecodeUntilEndOfBlock(p541, v557, v558, v559, v561, v562, v563);
end;

local function Inflate(p564: table) -- Line: 2818
    -- upvalues: DecompressStoreBlock (copy), DecodeUntilEndOfBlock (copy), u12 (ref), u17 (ref), u13 (ref), u18 (ref), DecompressDynamicBlock (copy), table_concat (copy)
    local ReadBits = p564.ReadBits;
    local v565 = nil;

    while not v565 do
        v565 = ReadBits(1) == 1;
        local v566 = ReadBits(2);
        local v567;

        if v566 == 0 then
            v567 = DecompressStoreBlock(p564);
        elseif v566 == 1 then
            v567 = DecodeUntilEndOfBlock(p564, u12, u17, 7, u13, u18, 5);
        else
            if v566 ~= 2 then
                return nil, -1;
            end;

            v567 = DecompressDynamicBlock(p564);
        end;

        if v567 ~= 0 then
            return nil, v567;
        end;
    end;

    p564.result_buffer[#p564.result_buffer + 1] = table_concat(p564.buffer, "", 1, p564.buffer_size);

    return table_concat(p564.result_buffer), 0;
end;

local function DecompressDeflateInternal(p568: string, p569: table?) -- Line: 2847
    -- upvalues: CreateDecompressState (copy), Inflate (copy)
    local v570 = CreateDecompressState(p568, p569);
    local v571, v572 = Inflate(v570);

    if not v571 then
        return nil, v572;
    end;

    local v573 = v570.ReaderBitlenLeft();

    return v571, (v573 - v573 % 8) / 8;
end;

local function DecompressZlibInternal(p574: string, p575: table?) -- Line: 2861
    -- upvalues: CreateDecompressState (copy), Inflate (copy), u19 (copy)
    local v576 = CreateDecompressState(p574, p575);
    local ReadBits = v576.ReadBits;
    local v577 = ReadBits(8);

    if v576.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;

    local v578 = v577 % 16;

    if v578 ~= 8 then
        return nil, -12;
    end;

    if (v577 - v578) / 16 > 7 then
        return nil, -13;
    end;

    local v579 = ReadBits(8);

    if v576.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;

    if (v577 * 256 + v579) % 31 ~= 0 then
        return nil, -14;
    end;

    local _ = (v579 - v579 % 64) / 64 % 4;

    if (v579 - v579 % 32) / 32 % 2 == 1 then
        if not p575 then
            return nil, -16;
        end;

        local v580 = ReadBits(8);
        local v581 = ReadBits(8);
        local v582 = ReadBits(8);
        local v583 = ReadBits(8);

        if v576.ReaderBitlenLeft() < 0 then
            return nil, 2;
        end;

        if (v580 * 16777216 + v581 * 65536 + v582 * 256 + v583) % 4294967296 ~= p575.adler32 % 4294967296 then
            return nil, -17;
        end;
    end;

    local v584, v585 = Inflate(v576);

    if not v584 then
        return nil, v585;
    end;

    v576.SkipToByteBoundary();
    local v586 = ReadBits(8);
    local v587 = ReadBits(8);
    local v588 = ReadBits(8);
    local v589 = ReadBits(8);

    if v576.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;

    local v590 = u19:Adler32(v584);

    if (v586 * 16777216 + v587 * 65536 + v588 * 256 + v589) % 4294967296 ~= v590 % 4294967296 then
        return nil, -15;
    end;

    local v591 = v576.ReaderBitlenLeft();

    return v584, (v591 - v591 % 8) / 8;
end;

function u19.DecompressDeflate(p592: table, p593: string) -- Line: 2943
    -- upvalues: DecompressDeflateInternal (copy)
    local v594, v595;

    if type(p593) == "string" then
        v594 = true;
        v595 = "";
    else
        v595 = ("\'str\' - string expected got \'%s\'."):format((type(p593)));
        v594 = false;
    end;

    if not v594 then
        error("Usage: LibDeflate:DecompressDeflate(str): " .. v595, 2);
    end;

    return DecompressDeflateInternal(p593);
end;

function u19.DecompressDeflateWithDict(p596: table, p597: string, p598: table) -- Line: 2969
    -- upvalues: IsValidDictionary (copy), DecompressDeflateInternal (copy)
    local v599, v600;

    if type(p597) == "string" then
        local v601;
        v601, v599 = IsValidDictionary(p598);

        if v601 then
            v600 = true;
            v599 = "";
        else
            v600 = false;
        end;
    else
        v599 = ("\'str\' - string expected got \'%s\'."):format((type(p597)));
        v600 = false;
    end;

    if not v600 then
        error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): " .. v599, 2);
    end;

    return DecompressDeflateInternal(p597, p598);
end;

function u19.DecompressZlib(p602: table, p603: string) -- Line: 2990
    -- upvalues: DecompressZlibInternal (copy)
    local v604, v605;

    if type(p603) == "string" then
        v604 = true;
        v605 = "";
    else
        v605 = ("\'str\' - string expected got \'%s\'."):format((type(p603)));
        v604 = false;
    end;

    if not v604 then
        error("Usage: LibDeflate:DecompressZlib(str): " .. v605, 2);
    end;

    return DecompressZlibInternal(p603);
end;

function u19.DecompressZlibWithDict(p606: table, p607: string, p608: table) -- Line: 3016
    -- upvalues: IsValidDictionary (copy), DecompressZlibInternal (copy)
    local v609, v610;

    if type(p607) == "string" then
        local v611;
        v611, v609 = IsValidDictionary(p608);

        if v611 then
            v610 = true;
            v609 = "";
        else
            v610 = false;
        end;
    else
        v609 = ("\'str\' - string expected got \'%s\'."):format((type(p607)));
        v610 = false;
    end;

    if not v610 then
        error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): " .. v609, 2);
    end;

    return DecompressZlibInternal(p607, p608);
end;

u21 = {};

for i = 0, 143 do
    u21[i] = 8;
    local _ = i;
end;

for i = 144, 255 do
    u21[i] = 9;
    local _ = i;
end;

u21[256] = 7;
u21[257] = 7;
u21[258] = 7;
u21[259] = 7;
u21[260] = 7;
u21[261] = 7;
u21[262] = 7;
u21[263] = 7;
u21[264] = 7;
u21[265] = 7;
u21[266] = 7;
u21[267] = 7;
u21[268] = 7;
u21[269] = 7;
u21[270] = 7;
u21[271] = 7;
u21[272] = 7;
u21[273] = 7;
u21[274] = 7;
u21[275] = 7;
u21[276] = 7;
u21[277] = 7;
u21[278] = 7;
u21[279] = 7;
u21[280] = 8;
u21[281] = 8;
u21[282] = 8;
u21[283] = 8;
u21[284] = 8;
u21[285] = 8;
u21[286] = 8;
u21[287] = 8;
local v612 = {};

for i = 0, 31 do
    v612[i] = 5;
    local _ = i;
end;

local v613, v614, v615 = GetHuffmanForDecode(u21, 287, 9);
u12 = v614;
u17 = v615;
assert(v613 == 0);
local v616, v617, v618 = GetHuffmanForDecode(v612, 31, 5);
u13 = v617;
u18 = v618;
assert(v616 == 0);
u22 = GetHuffmanCodeFromBitlen(u12, u21, 287, 9);
u15 = GetHuffmanCodeFromBitlen(u13, v612, 31, 5);
local u619 = {
    ["\0"] = "%z",
    ["("] = "%(",
    [")"] = "%)",
    ["."] = "%.",
    ["%"] = "%%",
    ["+"] = "%+",
    ["-"] = "%-",
    ["*"] = "%*",
    ["?"] = "%?",
    ["["] = "%[",
    ["]"] = "%]",
    ["^"] = "%^",
    ["$"] = "%$"
};

local function escape_for_gsub(p620: string) -- Line: 3084
    -- upvalues: u619 (copy)
    local v621, _ = p620:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);

    return v621;
end;

function u19.CreateCodec(p622: table, p623: string, p624: string, p625: string) -- Line: 3129
    -- upvalues: string_byte (copy), string_sub (copy), table_concat (copy), u619 (copy), u1 (copy), string_gsub (copy), string_find (copy)
    if type(p623) ~= "string" or (type(p624) ~= "string" or type(p625) ~= "string") then
        error(
            "Usage: LibDeflate:CreateCodec(reserved_chars, escape_chars, map_chars): All arguments must be string.",
            2
        );
    end;

    if p624 == "" then
        return nil, "No escape characters supplied.";
    end;

    if #p623 < #p625 then
        return nil, "The number of reserved characters must be at least as many as the number of mapped chars.";
    end;

    if p623 == "" then
        return nil, "No characters to encode.";
    end;

    local v626 = p623 .. p624 .. p625;
    local v627 = {};

    for i = 1, #v626 do
        local v628 = string_byte(v626, i, i);

        if v627[v628] then
            return nil, "There must be no duplicate characters in the concatenation of reserved_chars, escape_chars and map_chars.";
        end;

        v627[v628] = true;
        local _ = i;
    end;

    local u629 = {};
    local u630 = {};
    local v631 = {};
    local u632 = {};

    if #p625 > 0 then
        local v633 = {};
        local v634 = {};

        for i = 1, #p625 do
            local v635 = string_sub(p623, i, i);
            local v636 = string_sub(p625, i, i);
            u632[v635] = v636;
            v631[#v631 + 1] = v635;
            v633[v636] = v635;
            v634[#v634 + 1] = v636;
            local _ = i;
        end;

        local v637, _ = table_concat(v634):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
        u629[#u629 + 1] = "([" .. v637 .. "])";
        u630[#u630 + 1] = v633;
    end;

    local v638 = 1;
    local v639 = string_sub(p624, v638, v638);
    local v640 = 0;
    local v641 = {};
    local v642 = {};

    for i = 1, #v626 do
        local v643 = string_sub(v626, i, i);
        local v644;

        if u632[v643] then
            v644 = i;
        else
            v644 = i;

            while v640 >= 256 or v627[v640] do
                v640 = v640 + 1;

                if v640 > 255 then
                    local v645, _ = v639:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
                    local v646, _ = table_concat(v641):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
                    u629[#u629 + 1] = v645 .. "([" .. v646 .. "])";
                    u630[#u630 + 1] = v642;
                    v638 = v638 + 1;
                    v639 = string_sub(p624, v638, v638);

                    if not v639 or v639 == "" then
                        return nil, "Out of escape characters.";
                    end;

                    v640 = 0;
                    v641 = {};
                    v642 = {};
                end;
            end;

            local v647 = u1[v640];
            u632[v643] = v639 .. v647;
            v631[#v631 + 1] = v643;
            v642[v647] = v643;
            v641[#v641 + 1] = v647;
            v640 = v640 + 1;
        end;

        if v644 == #v626 then
            local v648, _ = v639:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
            local v649, _ = table_concat(v641):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
            u629[#u629 + 1] = v648 .. "([" .. v649 .. "])";
            u630[#u630 + 1] = v642;
        end;
    end;

    local v650 = {};
    local v651, _ = table_concat(v631):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
    local u652 = "([" .. v651 .. "])";

    function v650.Encode(p653: table, p654: string) -- Line: 3243
        -- upvalues: string_gsub (ref), u652 (copy), u632 (copy)
        if type(p654) ~= "string" then
            error(("Usage: codec:Encode(str): \'str\' - string expected got \'%s\'."):format((type(p654))), 2);
        end;

        local v655, _ = string_gsub(p654, u652, u632);

        return v655;
    end;

    local u656 = #u629;
    local v657, _ = p623:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u619);
    local u658 = "([" .. v657 .. "])";

    function v650.Decode(p659: table, p660: string) -- Line: 3254
        -- upvalues: string_find (ref), u658 (copy), u656 (copy), string_gsub (ref), u629 (copy), u630 (copy)
        if type(p660) ~= "string" then
            error(("Usage: codec:Decode(str): \'str\' - string expected got \'%s\'."):format((type(p660))), 2);
        end;

        if string_find(p660, u658) then
            return nil;
        end;

        for i = 1, u656 do
            p660 = string_gsub(p660, u629[i], u630[i]);
            local _ = i;
        end;

        return p660;
    end;

    return v650, "";
end;

u19.internals = {
    LoadStringToTable = LoadStringToTable,
    IsValidDictionary = IsValidDictionary,
    IsEqualAdler32 = IsEqualAdler32
};

return table.freeze(u19);