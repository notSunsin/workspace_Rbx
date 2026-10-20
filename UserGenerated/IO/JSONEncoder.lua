-- Decompiled with Potassium's decompiler.

local u1 = {
    [36] = true,
    [95] = true
};
local u2 = {
    [36] = true,
    [95] = true
};
local u3 = {
    [0] = -12336,
    [1] = -12592,
    [2] = -12848,
    [3] = -13104,
    [4] = -13360,
    [5] = -13616,
    [6] = -13872,
    [7] = -14128,
    [8] = 25180,
    [9] = 29788,
    [10] = 28252,
    [11] = -25136,
    [12] = 26204,
    [13] = 29276,
    [14] = -25904,
    [15] = -26160,
    [16] = -12337,
    [17] = -12593,
    [18] = -12849,
    [19] = -13105,
    [20] = -13361,
    [21] = -13617,
    [22] = -13873,
    [23] = -14129,
    [24] = -14385,
    [25] = -14641,
    [26] = -24881,
    [27] = -25137,
    [28] = -25393,
    [29] = -25649,
    [30] = -25905,
    [31] = -26161
};

for i = 65, 90 do
    u1[i] = true;
    u2[i] = true;
    local _ = i;
end;

for i = 97, 122 do
    u1[i] = true;
    u2[i] = true;
    local _ = i;
end;

u2[48] = true;
u2[49] = true;
u2[50] = true;
u2[51] = true;
u2[52] = true;
u2[53] = true;
u2[54] = true;
u2[55] = true;
u2[56] = true;
u2[57] = true;

local function Stream(p4: buffer) -- Line: 91
    return {
        Pos = 0,
        Indent = 0,
        Pretty = false,
        Null = nil,
        QuoteChar = 34,
        UnquoteIdent = false,
        Buf = p4,
        Cap = buffer.len(p4),
        Encoders = {}
    };
end;

local function ToString(p5: table) -- Line: 105
    return buffer.readstring(p5.Buf, 0, p5.Pos);
end;

local function AllocSize(p6: number) -- Line: 109
    local math_log_ret = math.log(p6, 2);
    local v7 = 2 ^ math.ceil(math_log_ret);

    return math.max(p6, v7);
end;

local function Reserve(p8: table, p9: number) -- Line: 113
    local Pos = p8.Pos;
    local v10 = Pos + p9;

    if p8.Cap < v10 then
        local math_log_ret = math.log(v10, 2);
        local v11 = 2 ^ math.ceil(math_log_ret);
        local math_max_ret = math.max(v10, v11);
        local buffer_create_ret = buffer.create(math_max_ret);
        buffer.copy(buffer_create_ret, 0, p8.Buf, 0, Pos);
        p8.Buf = buffer_create_ret;
        p8.Cap = math_max_ret;
    end;

    p8.Pos = v10;

    return Pos;
end;

local function WriteString(p12: table, p13: string) -- Line: 126
    -- upvalues: Reserve (copy)
    local string_len_ret = string.len(p13);
    local v14 = Reserve(p12, string_len_ret);
    buffer.writestring(p12.Buf, v14, p13, string_len_ret);
end;

local function WriteIndent(p15: table) -- Line: 132
    -- upvalues: Reserve (copy)
    local v16 = p15.Indent * 2;
    local v17 = Reserve(p15, v16);
    local Buf = p15.Buf;

    for i = 0, v16 - 1 do
        buffer.writeu16(Buf, v17 + i * 2, 8224);
        local _ = i;
    end;
end;

local function IncrementIndent(p18: table, p19: number) -- Line: 141
    p18.Indent = p18.Indent + p19;
end;

local function WriteU8(p20: table, p21: number) -- Line: 145
    -- upvalues: Reserve (copy)
    local v22 = Reserve(p20, 1);
    buffer.writeu8(p20.Buf, v22, p21);
end;

local function WriteU16(p23: table, p24: number) -- Line: 150
    -- upvalues: Reserve (copy)
    local v25 = Reserve(p23, 2);
    buffer.writeu16(p23.Buf, v25, p24);
end;

local function WriteU32(p26: table, p27: number) -- Line: 155
    -- upvalues: Reserve (copy)
    local v28 = Reserve(p26, 4);
    buffer.writeu32(p26.Buf, v28, p27);
end;

local function EncodeNumber(p29: table, p30: number) -- Line: 175
    -- upvalues: Reserve (copy)
    if p30 ~= p30 then
        local v31 = Reserve(p29, 3);
        local Buf = p29.Buf;
        buffer.writeu16(Buf, v31, 24910);
        buffer.writeu8(Buf, v31 + 2, 78);

        return;
    end;

    if p30 == (1 / 0) then
        local v32 = Reserve(p29, 8);
        local Buf = p29.Buf;
        buffer.writeu32(Buf, v32, 1768320585);
        buffer.writeu32(Buf, v32 + 4, 2037672302);

        return;
    end;

    if p30 == (-1 / 0) then
        local v33 = Reserve(p29, 9);
        local Buf = p29.Buf;
        buffer.writeu8(Buf, v33, 45);
        buffer.writeu32(Buf, v33 + 1, 1768320585);
        buffer.writeu32(Buf, v33 + 5, 2037672302);

        return;
    end;

    local v34 = tostring(p30);
    local string_find_ret = string.find(v34, "e%+");

    if string_find_ret then
        v34 = string.sub(v34, 1, string_find_ret) .. string.sub(v34, string_find_ret + 2);
    end;

    local string_len_ret = string.len(v34);
    local v35 = Reserve(p29, string_len_ret);
    buffer.writestring(p29.Buf, v35, v34, string_len_ret);
end;

local function IsIdentifierName(p36: table, p37: string) -- Line: 202
    -- upvalues: u1 (copy), u2 (copy)
    local string_len_ret = string.len(p37);

    if string_len_ret == 0 then
        return false;
    end;

    if not u1[string.byte(p37, 1)] then
        return false;
    end;

    local v38 = u2;

    for i = 2, string_len_ret do
        if not v38[string.byte(p37, i)] then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local function EncodeString(p39: table, p40: string, p41: boolean?) -- Line: 220
    -- upvalues: u1 (copy), u2 (copy), Reserve (copy), u3 (copy)
    if p41 then
        local string_len_ret = string.len(p40);
        local v42;

        if string_len_ret == 0 or not u1[string.byte(p40, 1)] then
            v42 = false;
        else
            local v43 = u2;
            v42 = true;

            for i = 2, string_len_ret do
                if not v43[string.byte(p40, i)] then
                    v42 = false;
                    break;
                end;

                local _ = i;
            end;
        end;

        if not v42 then
            p41 = false;
        end;
    end;

    local string_len_ret = string.len(p40);
    local v44 = Reserve(p39, string_len_ret * 6 + 2);
    local Buf = p39.Buf;
    local QuoteChar = p39.QuoteChar;

    if not p41 then
        buffer.writeu8(Buf, v44, QuoteChar);
        v44 = v44 + 1;
    end;

    for i = 1, string_len_ret do
        local string_byte_ret = string.byte(p40, i);
        local v45;

        if string_byte_ret > 31 then
            if string_byte_ret == QuoteChar or string_byte_ret == 92 then
                local v46 = bit32.lshift(string_byte_ret, 8) + 92;
                buffer.writeu16(Buf, v44, v46);
                v44 = v44 + 2;
                v45 = i;
            else
                buffer.writeu8(Buf, v44, string_byte_ret);
                v44 = v44 + 1;
                v45 = i;
            end;
        else
            local v47 = u3[string_byte_ret];

            if v47 < 0 then
                v47 = -v47;
                buffer.writeu32(Buf, v44, 808482140);
                v44 = v44 + 4;
            end;

            buffer.writeu16(Buf, v44, v47);
            v44 = v44 + 2;
            v45 = i;
        end;
    end;

    if not p41 then
        buffer.writeu8(Buf, v44, QuoteChar);
        v44 = v44 + 1;
    end;

    p39.Pos = v44;
end;

local function EncodeAny(p48: table, p49: any) -- Line: 304
    if p49 == p48.Null then
        p49 = nil;
    end;

    p48.Encoders[typeof(p49)](p48, p49);
end;

local function EncodeArray(p50: table, p51: table) -- Line: 311
    -- upvalues: Reserve (copy)
    local Pretty = p50.Pretty;
    local v52 = Reserve(p50, 1);
    buffer.writeu8(p50.Buf, v52, 91);

    if Pretty then
        p50.Indent = p50.Indent + 1;
    end;

    for i, v in ipairs(p51) do
        if i > 1 then
            local v53 = Reserve(p50, 1);
            buffer.writeu8(p50.Buf, v53, 44);
        end;

        local v54;

        if Pretty then
            local v55 = Reserve(p50, 1);
            buffer.writeu8(p50.Buf, v55, 10);
            local v56 = p50.Indent * 2;
            local v57 = Reserve(p50, v56);
            local Buf = p50.Buf;
            v54 = v;

            for i2 = 0, v56 - 1 do
                buffer.writeu16(Buf, v57 + i2 * 2, 8224);
                local _ = i2;
            end;
        else
            v54 = v;
        end;

        if v54 == p50.Null then
            v54 = nil;
        end;

        p50.Encoders[typeof(v54)](p50, v54);
    end;

    if Pretty then
        p50.Indent = p50.Indent + -1;

        if #p51 > 0 then
            local v58 = Reserve(p50, 1);
            buffer.writeu8(p50.Buf, v58, 10);
            local v59 = p50.Indent * 2;
            local v60 = Reserve(p50, v59);
            local Buf = p50.Buf;

            for i = 0, v59 - 1 do
                buffer.writeu16(Buf, v60 + i * 2, 8224);
                local _ = i;
            end;
        end;
    end;

    local v61 = Reserve(p50, 1);
    buffer.writeu8(p50.Buf, v61, 93);
end;

local function EncodeMap(p62: table, p63: table) -- Line: 338
    -- upvalues: Reserve (copy), EncodeString (copy)
    local v64 = {};

    for i, _ in pairs(p63) do
        local v65 = type(i) == "string";
        assert(v65);
        table.insert(v64, i);
    end;

    table.sort(v64);
    local Pretty = p62.Pretty;
    local UnquoteIdent = p62.UnquoteIdent;
    local v66 = Reserve(p62, 1);
    buffer.writeu8(p62.Buf, v66, 123);

    if Pretty then
        p62.Indent = p62.Indent + 1;
    end;

    for i, v in ipairs(v64) do
        if i > 1 then
            local v67 = Reserve(p62, 1);
            buffer.writeu8(p62.Buf, v67, 44);
        end;

        local v68;

        if Pretty then
            local v69 = Reserve(p62, 1);
            buffer.writeu8(p62.Buf, v69, 10);
            local v70 = p62.Indent * 2;
            local v71 = Reserve(p62, v70);
            local Buf = p62.Buf;
            v68 = v;

            for i2 = 0, v70 - 1 do
                buffer.writeu16(Buf, v71 + i2 * 2, 8224);
                local _ = i2;
            end;
        else
            v68 = v;
        end;

        EncodeString(p62, v68, UnquoteIdent);

        if Pretty then
            local v72 = Reserve(p62, 2);
            buffer.writeu16(p62.Buf, v72, 8250);
        else
            local v73 = Reserve(p62, 1);
            buffer.writeu8(p62.Buf, v73, 58);
        end;

        local v74 = p63[v68];

        if v74 == p62.Null then
            v74 = nil;
        end;

        p62.Encoders[typeof(v74)](p62, v74);
    end;

    if Pretty then
        p62.Indent = p62.Indent + -1;

        if #v64 > 0 then
            local v75 = Reserve(p62, 1);
            buffer.writeu8(p62.Buf, v75, 10);
            local v76 = p62.Indent * 2;
            local v77 = Reserve(p62, v76);
            local Buf = p62.Buf;

            for i = 0, v76 - 1 do
                buffer.writeu16(Buf, v77 + i * 2, 8224);
                local _ = i;
            end;
        end;
    end;

    local v78 = Reserve(p62, 1);
    buffer.writeu8(p62.Buf, v78, 125);
end;

local v95 = {
    ["nil"] = function(p79: table, p80: nil) -- Line: 160, Name: EncodeNull
        -- upvalues: Reserve (copy)
        local v81 = Reserve(p79, 4);
        buffer.writeu32(p79.Buf, v81, 1819047278);
    end,

    boolean = function(p82: table, p83: boolean) -- Line: 164, Name: EncodeBoolean
        -- upvalues: Reserve (copy)
        if p83 then
            local v84 = Reserve(p82, 4);
            buffer.writeu32(p82.Buf, v84, 1702195828);

            return;
        end;

        local v85 = Reserve(p82, 5);
        local Buf = p82.Buf;
        buffer.writeu32(Buf, v85, 1936482662);
        buffer.writeu8(Buf, v85 + 4, 101);
    end,

    number = EncodeNumber,
    string = EncodeString,

    buffer = function(p86: table, p87: buffer) -- Line: 266, Name: EncodeBuffer
        -- upvalues: Reserve (copy), u3 (copy)
        local buffer_len_ret = buffer.len(p87);
        local v88 = Reserve(p86, 2 + buffer_len_ret * 6);
        local Buf = p86.Buf;
        local QuoteChar = p86.QuoteChar;
        buffer.writeu8(Buf, v88, QuoteChar);
        local v89 = v88 + 1;

        for i = 0, buffer_len_ret - 1 do
            local buffer_readu8_ret = buffer.readu8(p87, i);
            local v90;

            if buffer_readu8_ret > 31 then
                if buffer_readu8_ret == QuoteChar or buffer_readu8_ret == 92 then
                    local v91 = bit32.lshift(buffer_readu8_ret, 8) + 92;
                    buffer.writeu16(Buf, v89, v91);
                    v89 = v89 + 2;
                    v90 = i;
                else
                    buffer.writeu8(Buf, v89, buffer_readu8_ret);
                    v89 = v89 + 1;
                    v90 = i;
                end;
            else
                local v92 = u3[buffer_readu8_ret];

                if v92 < 0 then
                    v92 = -v92;
                    buffer.writeu32(Buf, v89, 808482140);
                    v89 = v89 + 4;
                end;

                buffer.writeu16(Buf, v89, v92);
                v89 = v89 + 2;
                v90 = i;
            end;
        end;

        buffer.writeu8(Buf, v89, QuoteChar);
        p86.Pos = v89 + 1;
    end,

    table = function(p93: table, p94: any) -- Line: 377, Name: EncodeTable
        -- upvalues: EncodeArray (copy), EncodeMap (copy)
        if #p94 > 0 or next(p94) == nil then
            EncodeArray(p93, p94);

            return;
        end;

        EncodeMap(p93, p94);
    end
};
local table_clone_ret = table.clone(v95);

function table_clone_ret.Vector2(p96: table, p97) -- Line: 386
    -- upvalues: EncodeArray (copy)
    EncodeArray(p96, { p97.X, p97.Y });
end;

function table_clone_ret.Vector3(p98: table, p99: vector) -- Line: 390
    -- upvalues: EncodeArray (copy)
    EncodeArray(p98, { p99.X, p99.Y, p99.Z });
end;

function table_clone_ret.Vector2int16(p100: table, p101: userdata) -- Line: 394
    -- upvalues: EncodeArray (copy)
    EncodeArray(p100, { p101.X, p101.Y });
end;

function table_clone_ret.Vector3int16(p102: table, p103: userdata) -- Line: 398
    -- upvalues: EncodeArray (copy)
    EncodeArray(p102, { p103.X, p103.Y, p103.Z });
end;

function table_clone_ret.Region3(p104: table, p105: userdata) -- Line: 402
    -- upvalues: EncodeArray (copy)
    local v106 = p105.CFrame * (p105.Size * -0.5);
    local v107 = p105.CFrame * (p105.Size * 0.5);
    EncodeArray(p104, {
        v106.X,
        v106.Y,
        v106.Z,
        v107.X,
        v107.Y,
        v107.Z
    });
end;

function table_clone_ret.Region3int16(p108: table, p109: userdata) -- Line: 408
    -- upvalues: EncodeArray (copy)
    EncodeArray(p108, {
        p109.Min.X,
        p109.Min.Y,
        p109.Min.Z,
        p109.Max.X,
        p109.Max.Y,
        p109.Max.Z
    });
end;

function table_clone_ret.UDim(p110: table, p111) -- Line: 412
    -- upvalues: EncodeArray (copy)
    EncodeArray(p110, { p111.Scale, p111.Offset });
end;

function table_clone_ret.UDim2(p112: table, p113) -- Line: 416
    -- upvalues: EncodeArray (copy)
    EncodeArray(p112, {
        p113.X.Scale,
        p113.X.Offset,
        p113.Y.Scale,
        p113.Y.Offset
    });
end;

function table_clone_ret.CFrame(p114: table, p115) -- Line: 420
    -- upvalues: EncodeArray (copy)
    EncodeArray(p114, { p115:GetComponents() });
end;

function table_clone_ret.Color3(p116: table, p117) -- Line: 424
    -- upvalues: EncodeArray (copy)
    EncodeArray(p116, { math.round(p117.R * 255), math.round(p117.G * 255), (math.round(p117.B * 255)) });
end;

function table_clone_ret.NumberRange(p118: table, p119) -- Line: 432
    -- upvalues: EncodeArray (copy)
    EncodeArray(p118, { p119.Min, p119.Max });
end;

function table_clone_ret.Rect(p120: table, p121) -- Line: 436
    -- upvalues: EncodeArray (copy)
    EncodeArray(p120, {
        p121.Min.X,
        p121.Min.Y,
        p121.Max.X,
        p121.Max.Y
    });
end;

function table_clone_ret.EnumItem(p122: table, p123: userdata) -- Line: 440
    -- upvalues: EncodeNumber (copy)
    EncodeNumber(p122, p123.Value);
end;

local buffer_create_ret = buffer.create(4096);
local u124 = Stream(buffer_create_ret);
u124.Encoders = v95;

local function Compact(p125, p126) -- Line: 473
    -- upvalues: u124 (copy), ToString (copy)
    local v127 = u124;
    v127.Pos = 0;
    v127.Null = p126;

    if p125 == v127.Null then
        p125 = nil;
    end;

    v127.Encoders[typeof(p125)](v127, p125);

    return ToString(v127);
end;

local u128 = Stream(buffer_create_ret);
u128.Encoders = v95;
u128.Pretty = true;

local function Pretty(p129, p130) -- Line: 484
    -- upvalues: u128 (copy), ToString (copy)
    local v131 = u128;
    v131.Pos = 0;
    v131.Indent = 0;
    v131.Null = p130;

    if p129 == v131.Null then
        p129 = nil;
    end;

    v131.Encoders[typeof(p129)](v131, p129);

    return ToString(v131);
end;

local u132 = Stream(buffer_create_ret);
u132.Encoders = table_clone_ret;

local function CompactExt(p133, p134) -- Line: 495
    -- upvalues: u132 (copy), ToString (copy)
    local v135 = u132;
    v135.Pos = 0;
    v135.Null = p134;

    if p133 == v135.Null then
        p133 = nil;
    end;

    v135.Encoders[typeof(p133)](v135, p133);

    return ToString(v135);
end;

local u136 = Stream(buffer_create_ret);
u136.Encoders = table_clone_ret;
u136.Pretty = true;

local function PrettyExt(p137, p138) -- Line: 506
    -- upvalues: u136 (copy), ToString (copy)
    local v139 = u136;
    v139.Pos = 0;
    v139.Indent = 0;
    v139.Null = p138;

    if p137 == v139.Null then
        p137 = nil;
    end;

    v139.Encoders[typeof(p137)](v139, p137);

    return ToString(v139);
end;

local u140 = Stream(buffer_create_ret);
u140.Encoders = v95;
u140.UnquoteIdent = true;
u140.QuoteChar = 39;

local function Compact5(p141, p142) -- Line: 520
    -- upvalues: u140 (copy), ToString (copy)
    local v143 = u140;
    v143.Pos = 0;
    v143.Null = p142;

    if p141 == v143.Null then
        p141 = nil;
    end;

    v143.Encoders[typeof(p141)](v143, p141);

    return ToString(v143);
end;

local u144 = Stream(buffer_create_ret);
u144.Encoders = v95;
u144.Pretty = true;
u144.UnquoteIdent = true;
u144.QuoteChar = 39;

return table.freeze({
    Compact = Compact,
    Pretty = Pretty,
    CompactExt = CompactExt,
    PrettyExt = PrettyExt,
    Compact5 = Compact5,

    Pretty5 = function(p145, p146) -- Line: 533, Name: Pretty5
        -- upvalues: u144 (copy), ToString (copy)
        local v147 = u144;
        v147.Pos = 0;
        v147.Indent = 0;
        v147.Null = p146;

        if p145 == v147.Null then
            p145 = nil;
        end;

        v147.Encoders[typeof(p145)](v147, p145);

        return ToString(v147);
    end
});