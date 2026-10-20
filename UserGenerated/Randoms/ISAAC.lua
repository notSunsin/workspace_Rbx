-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.UserGenerated.Randoms.Base);
local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed);
local bit32_bxor = bit32.bxor;
local bit32_bor = bit32.bor;
local bit32_band = bit32.band;
local bit32_lshift = bit32.lshift;
local bit32_rshift = bit32.rshift;
local math_floor = math.floor;
local math_ldexp = math.ldexp;
local math_sqrt = math.sqrt;
local math_log = math.log;
local math_max = math.max;
local math_sin = math.sin;
local math_cos = math.cos;
local math_clamp = math.clamp;
local table_create = table.create;
local table_clone = table.clone;
local string_format = string.format;
local Vector2_new = Vector2.new;
local Vector3_new = Vector3.new;
assert(true);
local Random_new_ret = Random.new();

local function IsInteger(p1: number) -- Line: 43
    -- upvalues: math_floor (copy)
    local v2;

    if type(p1) == "number" and (math_floor(p1) == p1 and p1 ~= (1 / 0)) then
        v2 = p1 ~= (-1 / 0);
    else
        v2 = false;
    end;

    return v2;
end;

local function AssertIntegerNonNegative(p3: number) -- Line: 48
    -- upvalues: math_floor (copy)
    local v4;

    if type(p3) == "number" and (math_floor(p3) == p3 and p3 ~= (1 / 0)) then
        v4 = p3 ~= (-1 / 0);
    else
        v4 = false;
    end;

    if not v4 then
        error("Integer", 2);
    end;

    if p3 < 0 then
        error("NonNegative", 2);
    end;
end;

local function IsaacMix(p5: table) -- Line: 76
    -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_bor (copy), bit32_rshift (copy)
    local v6 = p5[2];
    local v7 = p5[3];
    local v8 = p5[4];
    local v9 = p5[5];
    local v10 = p5[6];
    local v11 = p5[7];
    local v12 = p5[8];
    local v13 = bit32_bxor(p5[1], (bit32_lshift(v6, 11)));
    local v14 = bit32_bor(v8 + v13, 0);
    local v15 = bit32_bxor(bit32_bor(v6 + v7, 0), (bit32_rshift(v7, 2)));
    local v16 = bit32_bor(v9 + v15, 0);
    local v17 = bit32_bxor(bit32_bor(v7 + v14, 0), (bit32_lshift(v14, 8)));
    local v18 = bit32_bor(v10 + v17, 0);
    local v19 = bit32_bxor(bit32_bor(v14 + v16, 0), (bit32_rshift(v16, 16)));
    local v20 = bit32_bor(v11 + v19, 0);
    local v21 = bit32_bxor(bit32_bor(v16 + v18, 0), (bit32_lshift(v18, 10)));
    local v22 = bit32_bor(v12 + v21, 0);
    local v23 = bit32_bxor(bit32_bor(v18 + v20, 0), (bit32_rshift(v20, 4)));
    local v24 = bit32_bor(v13 + v23, 0);
    local v25 = bit32_bxor(bit32_bor(v20 + v22, 0), (bit32_lshift(v22, 8)));
    local v26 = bit32_bor(v15 + v25, 0);
    local v27 = bit32_bxor(bit32_bor(v22 + v24, 0), (bit32_rshift(v24, 9)));
    local v28 = bit32_bor(v17 + v27, 0);
    p5[1] = bit32_bor(v24 + v26, 0);
    p5[2] = v26;
    p5[3] = v28;
    p5[4] = v19;
    p5[5] = v21;
    p5[6] = v23;
    p5[7] = v25;
    p5[8] = v27;
end;

local function Isaac(p29) -- Line: 105
    -- upvalues: bit32_bor (copy), bit32_band (copy), bit32_rshift (copy), bit32_bxor (copy), bit32_lshift (copy)
    local AA = p29.AA;
    local BB = p29.BB;
    local MM = p29.MM;
    local RSL = p29.RSL;
    local v30 = bit32_bor(p29.CC + 1, 0);
    local v31 = bit32_bor(BB + v30, 0);

    for i = 1, 256 do
        local v32 = MM[i];
        local v33 = bit32_band(i, 3);

        if v33 == 0 then
            AA = bit32_bxor(AA, (bit32_rshift(AA, 16)));
        elseif v33 == 1 then
            AA = bit32_bxor(AA, (bit32_lshift(AA, 13)));
        elseif v33 == 2 then
            AA = bit32_bxor(AA, (bit32_rshift(AA, 6)));
        elseif v33 == 3 then
            AA = bit32_bxor(AA, (bit32_lshift(AA, 2)));
        end;

        AA = bit32_bor(MM[bit32_band(i + 127, 255) + 1] + AA, 0);
        local v34 = bit32_bor(MM[bit32_band(bit32_rshift(v32, 2), 255) + 1] + AA + v31, 0);
        MM[i] = v34;
        v31 = bit32_bor(MM[bit32_band(bit32_rshift(v34, 10), 255) + 1] + v32, 0);
        RSL[i] = v31;
        local _ = i;
    end;

    p29.AA = AA;
    p29.BB = v31;
    p29.CC = v30;
end;

local function IsaacInit(p35: any, p36: boolean) -- Line: 132
    -- upvalues: table_create (copy), IsaacMix (copy), bit32_bor (copy)
    p35.AA = 0;
    p35.BB = 0;
    p35.CC = 0;
    p35.Count = 256;
    local MM = p35.MM;
    local RSL = p35.RSL;
    local v37 = table_create(8, 2654435769);
    IsaacMix(v37);
    IsaacMix(v37);
    IsaacMix(v37);
    IsaacMix(v37);

    for i = 0, 255, 8 do
        local v38;

        if p36 then
            v38 = i;

            for i2 = 1, 8 do
                v37[i2] = bit32_bor(v37[i2] + RSL[v38 + i2], 0);
                local _ = i2;
            end;
        else
            v38 = i;
        end;

        IsaacMix(v37);
        MM[v38 + 1] = v37[1];
        MM[v38 + 2] = v37[2];
        MM[v38 + 3] = v37[3];
        MM[v38 + 4] = v37[4];
        MM[v38 + 5] = v37[5];
        MM[v38 + 6] = v37[6];
        MM[v38 + 7] = v37[7];
        MM[v38 + 8] = v37[8];
    end;

    if p36 then
        for i = 0, 255, 8 do
            local v39 = i;

            for i2 = 1, 8 do
                v37[i2] = bit32_bor(v37[i2] + MM[v39 + i2], 0);
                local _ = i2;
            end;

            IsaacMix(v37);
            MM[v39 + 1] = v37[1];
            MM[v39 + 2] = v37[2];
            MM[v39 + 3] = v37[3];
            MM[v39 + 4] = v37[4];
            MM[v39 + 5] = v37[5];
            MM[v39 + 6] = v37[6];
            MM[v39 + 7] = v37[7];
            MM[v39 + 8] = v37[8];
        end;
    end;
end;

local function Seed(p40: any, p41: any, p42: boolean?) -- Line: 234
    -- upvalues: Random_new_ret (copy), bit32_bor (copy), IsaacInit (copy)
    if p41 == nil then
        p41 = { Random_new_ret:NextInteger(0, 4294967295) };
    elseif type(p41) == "number" then
        p41 = { p41 };
    else
        local v43 = type(p41) == "table";
        assert(v43);
    end;

    if p42 == nil then
        p42 = true;
    else
        local v44 = type(p42) == "boolean";
        assert(v44);
    end;

    local math_min_ret = math.min(256, #p41);
    local MM = p40.MM;
    local RSL = p40.RSL;

    for i = 1, 256 do
        MM[i] = 0;
        RSL[i] = 0;
        local _ = i;
    end;

    for i = 1, math_min_ret do
        RSL[i] = bit32_bor(p41[i], 0);
        local _ = i;
    end;

    IsaacInit(p40, p42);
end;

local table_freeze_ret = table.freeze({
    NextU32 = function(p45) -- Line: 169, Name: NextU32
        -- upvalues: Isaac (copy)
        local v46 = p45.Count + 1;

        if v46 > 256 then
            Isaac(p45);
            v46 = 1;
        end;

        p45.Count = v46;

        return p45.RSL[v46];
    end,

    NextU64 = function(p47) -- Line: 179, Name: NextU64
        -- upvalues: Isaac (copy), math_ldexp (copy)
        local v48 = p47.Count + 1;

        if v48 > 256 then
            Isaac(p47);
            v48 = 1;
        end;

        p47.Count = v48;
        local v49 = math_ldexp(p47.RSL[v48], 32);
        local v50 = p47.Count + 1;

        if v50 > 256 then
            Isaac(p47);
            v50 = 1;
        end;

        p47.Count = v50;

        return v49 + p47.RSL[v50];
    end,

    NextFloat = function(p51) -- Line: 183, Name: NextFloat
        -- upvalues: Isaac (copy), math_ldexp (copy)
        local v52 = p51.Count + 1;

        if v52 > 256 then
            Isaac(p51);
            v52 = 1;
        end;

        p51.Count = v52;

        return math_ldexp(p51.RSL[v52], -32);
    end,

    NextDouble = function(p53) -- Line: 187, Name: NextDouble
        -- upvalues: Isaac (copy), math_ldexp (copy)
        local v54 = p53.Count + 1;

        if v54 > 256 then
            Isaac(p53);
            v54 = 1;
        end;

        p53.Count = v54;
        local v55 = math_ldexp(p53.RSL[v54], 32);
        local v56 = p53.Count + 1;

        if v56 > 256 then
            Isaac(p53);
            v56 = 1;
        end;

        p53.Count = v56;

        return math_ldexp(v55 + p53.RSL[v56], -64);
    end,

    NextNumber = function(p57: any, p58: number, p59: number) -- Line: 191, Name: NextNumber
        -- upvalues: Isaac (copy), math_ldexp (copy)
        local v60 = p57.Count + 1;

        if v60 > 256 then
            Isaac(p57);
            v60 = 1;
        end;

        p57.Count = v60;
        local v61 = math_ldexp(p57.RSL[v60], 32);
        local v62 = p57.Count + 1;

        if v62 > 256 then
            Isaac(p57);
            v62 = 1;
        end;

        p57.Count = v62;

        return p58 + (p59 - p58) * math_ldexp(v61 + p57.RSL[v62], -64);
    end,

    NextInteger = function(p63: any, p64: number, p65: number) -- Line: 195, Name: NextInteger
        -- upvalues: Isaac (copy), math_ldexp (copy), math_floor (copy)
        local v66 = p63.Count + 1;

        if v66 > 256 then
            Isaac(p63);
            v66 = 1;
        end;

        p63.Count = v66;
        local v67 = math_ldexp(p63.RSL[v66], 32);
        local v68 = p63.Count + 1;

        if v68 > 256 then
            Isaac(p63);
            v68 = 1;
        end;

        p63.Count = v68;

        return math_floor(p64 + (p65 - p64 + 1) * math_ldexp(v67 + p63.RSL[v68], -64));
    end,

    NextNormal = function(p69: any, p70: number?, p71: number?) -- Line: 199, Name: NextNormal
        -- upvalues: Isaac (copy), math_ldexp (copy), math_max (copy), math_log (copy), math_sqrt (copy), math_cos (copy), math_sin (copy)
        local v72 = p69.Count + 1;

        if v72 > 256 then
            Isaac(p69);
            v72 = 1;
        end;

        p69.Count = v72;
        local v73 = math_ldexp(p69.RSL[v72], 32);
        local v74 = p69.Count + 1;

        if v74 > 256 then
            Isaac(p69);
            v74 = 1;
        end;

        p69.Count = v74;
        local v75 = math_sqrt(math_log((math_max(2.2250738585072014e-308, (math_ldexp(v73 + p69.RSL[v74], -64))))) * -2) * (p71 or 0);
        local v76 = p69.Count + 1;

        if v76 > 256 then
            Isaac(p69);
            v76 = 1;
        end;

        p69.Count = v76;
        local v77 = math_ldexp(p69.RSL[v76], 32);
        local v78 = p69.Count + 1;

        if v78 > 256 then
            Isaac(p69);
            v78 = 1;
        end;

        p69.Count = v78;
        local v79 = 6.283185307179586 * math_ldexp(v77 + p69.RSL[v78], -64);
        local v80 = p70 or 0;

        return math_cos(v79) * v75 + v80, math_sin(v79) * v75 + v80;
    end,

    NextBoolean = function(p81: any, p82: number?) -- Line: 206, Name: NextBoolean
        -- upvalues: Isaac (copy), math_ldexp (copy)
        local v83 = p81.Count + 1;

        if v83 > 256 then
            Isaac(p81);
            v83 = 1;
        end;

        p81.Count = v83;
        local v84 = math_ldexp(p81.RSL[v83], 32);
        local v85 = p81.Count + 1;

        if v85 > 256 then
            Isaac(p81);
            v85 = 1;
        end;

        p81.Count = v85;

        return math_ldexp(v84 + p81.RSL[v85], -64) < (p82 or 0.5);
    end,

    NextVector2 = function(p86: any, p87: number?) -- Line: 210, Name: NextVector2
        -- upvalues: Isaac (copy), math_ldexp (copy), Vector2_new (copy), math_cos (copy), math_sin (copy)
        local v88 = p87 or 1;
        local v89 = p86.Count + 1;

        if v89 > 256 then
            Isaac(p86);
            v89 = 1;
        end;

        p86.Count = v89;
        local v90 = math_ldexp(p86.RSL[v89], 32);
        local v91 = p86.Count + 1;

        if v91 > 256 then
            Isaac(p86);
            v91 = 1;
        end;

        p86.Count = v91;
        local v92 = 6.283185307179586 * math_ldexp(v90 + p86.RSL[v91], -64);

        return Vector2_new(math_cos(v92) * v88, math_sin(v92) * v88);
    end,

    NextVector3 = function(p93: any, p94: number?) -- Line: 216, Name: NextVector3
        -- upvalues: Isaac (copy), math_ldexp (copy), math_sqrt (copy), math_cos (copy), math_sin (copy), Vector3_new (copy)
        local v95 = p94 or 1;
        local v96 = p93.Count + 1;

        if v96 > 256 then
            Isaac(p93);
            v96 = 1;
        end;

        p93.Count = v96;
        local v97 = math_ldexp(p93.RSL[v96], 32);
        local v98 = p93.Count + 1;

        if v98 > 256 then
            Isaac(p93);
            v98 = 1;
        end;

        p93.Count = v98;
        local v99 = 6.283185307179586 * math_ldexp(v97 + p93.RSL[v98], -64);
        local v100 = p93.Count + 1;

        if v100 > 256 then
            Isaac(p93);
            v100 = 1;
        end;

        p93.Count = v100;
        local v101 = math_ldexp(p93.RSL[v100], 32);
        local v102 = p93.Count + 1;

        if v102 > 256 then
            Isaac(p93);
            v102 = 1;
        end;

        p93.Count = v102;
        local v103 = math_ldexp(v101 + p93.RSL[v102], -64) * 2 - 1;
        local v104 = math_sqrt(1 - v103 * v103);

        return Vector3_new(math_cos(v99) * v104 * v95, math_sin(v99) * v104 * v95, v103 * v95);
    end,

    NextUUIDv4 = function(p105) -- Line: 224, Name: NextUUIDv4
        -- upvalues: string_format (copy), Isaac (copy), bit32_band (copy), bit32_bor (copy)
        local v106 = p105.Count + 1;

        if v106 > 256 then
            Isaac(p105);
            v106 = 1;
        end;

        p105.Count = v106;
        local v107 = p105.RSL[v106];
        local v108 = p105.Count + 1;

        if v108 > 256 then
            Isaac(p105);
            v108 = 1;
        end;

        p105.Count = v108;
        local v109 = bit32_bor(bit32_band(p105.RSL[v108], 4294905855), 16384);
        local v110 = p105.Count + 1;

        if v110 > 256 then
            Isaac(p105);
            v110 = 1;
        end;

        p105.Count = v110;
        local v111 = bit32_bor(bit32_band(p105.RSL[v110], 1073741823), 2147483648);
        local v112 = p105.Count + 1;

        if v112 > 256 then
            Isaac(p105);
            v112 = 1;
        end;

        p105.Count = v112;

        return string_format("%08x%08x%08x%08x", v107, v109, v111, p105.RSL[v112]);
    end,

    Seed = Seed,

    Shuffle = function(p113: any, p114: table) -- Line: 261, Name: Shuffle
        -- upvalues: Isaac (copy), math_ldexp (copy), math_floor (copy)
        local v115 = type(p114) == "table";
        assert(v115);

        for i = #p114, 2, -1 do
            local v116 = p113.Count + 1;

            if v116 > 256 then
                Isaac(p113);
                v116 = 1;
            end;

            p113.Count = v116;
            local v117 = math_ldexp(p113.RSL[v116], 32);
            local v118 = p113.Count + 1;

            if v118 > 256 then
                Isaac(p113);
                v118 = 1;
            end;

            p113.Count = v118;
            local v119 = math_floor((i - 1 + 1) * math_ldexp(v117 + p113.RSL[v118], -64) + 1);
            local v120 = p114[i];
            p114[i] = p114[v119];
            p114[v119] = v120;
            local _ = i;
        end;
    end,

    Clone = function(p121) -- Line: 269, Name: Clone
        -- upvalues: table_clone (copy)
        local v122 = {
            RSL = table_clone(p121.RSL),
            Count = p121.Count,
            MM = table_clone(p121.MM),
            AA = p121.AA,
            BB = p121.BB,
            CC = p121.CC
        };
        local v123 = getmetatable(p121);

        return setmetatable(v122, v123);
    end
});
local table_freeze_ret2 = table.freeze({
    __index = table_freeze_ret
});
local u127 = {
    new = function(p124: any, p125: boolean?) -- Line: 301, Name: new
        -- upvalues: table_create (copy), Seed (copy), table_freeze_ret2 (copy)
        local v126 = {
            Count = 0,
            AA = 0,
            BB = 0,
            CC = 0,
            RSL = table_create(256, 0),
            MM = table_create(256, 0)
        };
        Seed(v126, p124, p125);

        return setmetatable(v126, table_freeze_ret2);
    end
};

function u127.Unique(p128: number?) -- Line: 314
    -- upvalues: math_floor (copy), math_clamp (copy), u127 (copy), GenerateSeed (copy)
    if p128 ~= nil then
        local v129;

        if type(p128) == "number" and (math_floor(p128) == p128 and p128 ~= (1 / 0)) then
            v129 = p128 ~= (-1 / 0);
        else
            v129 = false;
        end;

        if not v129 then
            error("Integer", 2);
        end;

        if p128 < 0 then
            error("NonNegative", 2);
        end;
    end;

    local v130 = math_clamp(p128 or 32, 0, 256);

    return u127.new(GenerateSeed(v130), true);
end;

u127.R = u127.Unique();

return table.freeze(u127);