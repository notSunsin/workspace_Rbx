-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.UserGenerated.Randoms.Base);
local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed);
local script_Theory = require(script.Theory);
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
local string_format = string.format;
local Vector2_new = Vector2.new;
local Vector3_new = Vector3.new;
assert(true);
local Random_new_ret = Random.new();

local function Mul32(p1: number, p2: number) -- Line: 42
    -- upvalues: bit32_rshift (copy), bit32_band (copy), bit32_lshift (copy)
    local v3 = bit32_rshift(p1, 16);
    local v4 = bit32_band(p1, 65535);
    local v5 = bit32_rshift(p2, 16);
    local v6 = bit32_band(p2, 65535);

    return bit32_lshift(bit32_band(v3 * v6 + v4 * v5, 65535), 16) + v4 * v6;
end;

local function IsInteger(p7: number) -- Line: 53
    -- upvalues: math_floor (copy)
    local v8;

    if type(p7) == "number" and (math_floor(p7) == p7 and p7 ~= (1 / 0)) then
        v8 = p7 ~= (-1 / 0);
    else
        v8 = false;
    end;

    return v8;
end;

local function AssertInteger(p9: number) -- Line: 57
    -- upvalues: math_floor (copy)
    local v10;

    if type(p9) == "number" and (math_floor(p9) == p9 and p9 ~= (1 / 0)) then
        v10 = p9 ~= (-1 / 0);
    else
        v10 = false;
    end;

    if not v10 then
        error("Integer", 2);
    end;
end;

local function AssertIntegerNonNegative(p11: number) -- Line: 64
    -- upvalues: math_floor (copy)
    local v12;

    if type(p11) == "number" and (math_floor(p11) == p11 and p11 ~= (1 / 0)) then
        v12 = p11 ~= (-1 / 0);
    else
        v12 = false;
    end;

    if not v12 then
        error("Integer", 2);
    end;

    if p11 < 0 then
        error("NonNegative", 2);
    end;
end;

local function Seed(p13, p14) -- Line: 154
    -- upvalues: Random_new_ret (copy), bit32_bor (copy), bit32_rshift (copy), bit32_band (copy), bit32_lshift (copy)
    local v15 = p14 == nil and {} or (type(p14) == "number" and { p14 } or p14);
    local v16 = v15[2];
    local v17 = v15[3];
    local v18 = v15[4];
    local v19 = bit32_bor(v15[1] or Random_new_ret:NextInteger(0, 4294967295), 0);

    if not v16 then
        local v20 = bit32_rshift(v19, 16);
        local v21 = bit32_band(v19, 65535);
        v16 = bit32_lshift(bit32_band(v21 * 27655 + v20 * 35173, 65535), 16) + v21 * 35173 + 1;
    end;

    local v22 = bit32_bor(v16, 0);

    if not v17 then
        local v23 = bit32_rshift(v22, 16);
        local v24 = bit32_band(v22, 65535);
        v17 = bit32_lshift(bit32_band(v24 * 27655 + v23 * 35173, 65535), 16) + v24 * 35173 + 1;
    end;

    local v25 = bit32_bor(v17, 0);

    if not v18 then
        local v26 = bit32_rshift(v25, 16);
        local v27 = bit32_band(v25, 65535);
        v18 = bit32_lshift(bit32_band(v27 * 27655 + v26 * 35173, 65535), 16) + v27 * 35173 + 1;
    end;

    local v28 = bit32_bor(v18, 0);
    p13.x = v19;
    p13.y = v22;
    p13.z = v25;
    p13.w = v28;
end;

local table_freeze_ret = table.freeze({
    NextU32 = function(p29) -- Line: 89, Name: NextU32
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy)
        local x = p29.x;
        local w = p29.w;
        local v30 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v31 = bit32_bxor(bit32_bxor(bit32_bxor(v30, (bit32_rshift(v30, 8))), w), (bit32_rshift(w, 19)));
        local z = p29.z;
        p29.x = p29.y;
        p29.y = z;
        p29.z = w;
        p29.w = v31;

        return v31;
    end,

    NextU64 = function(p32) -- Line: 99, Name: NextU64
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy)
        local x = p32.x;
        local w = p32.w;
        local v33 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v34 = bit32_bxor(bit32_bxor(bit32_bxor(v33, (bit32_rshift(v33, 8))), w), (bit32_rshift(w, 19)));
        local z = p32.z;
        p32.x = p32.y;
        p32.y = z;
        p32.z = w;
        p32.w = v34;
        local v35 = math_ldexp(v34, 32);
        local x2 = p32.x;
        local w2 = p32.w;
        local v36 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v37 = bit32_bxor(bit32_bxor(bit32_bxor(v36, (bit32_rshift(v36, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p32.z;
        p32.x = p32.y;
        p32.y = z2;
        p32.z = w2;
        p32.w = v37;

        return v35 + v37;
    end,

    NextFloat = function(p38) -- Line: 103, Name: NextFloat
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy)
        local x = p38.x;
        local w = p38.w;
        local v39 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v40 = bit32_bxor(bit32_bxor(bit32_bxor(v39, (bit32_rshift(v39, 8))), w), (bit32_rshift(w, 19)));
        local z = p38.z;
        p38.x = p38.y;
        p38.y = z;
        p38.z = w;
        p38.w = v40;

        return math_ldexp(v40, -32);
    end,

    NextDouble = function(p41) -- Line: 107, Name: NextDouble
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy)
        local x = p41.x;
        local w = p41.w;
        local v42 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v43 = bit32_bxor(bit32_bxor(bit32_bxor(v42, (bit32_rshift(v42, 8))), w), (bit32_rshift(w, 19)));
        local z = p41.z;
        p41.x = p41.y;
        p41.y = z;
        p41.z = w;
        p41.w = v43;
        local v44 = math_ldexp(v43, 32);
        local x2 = p41.x;
        local w2 = p41.w;
        local v45 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v46 = bit32_bxor(bit32_bxor(bit32_bxor(v45, (bit32_rshift(v45, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p41.z;
        p41.x = p41.y;
        p41.y = z2;
        p41.z = w2;
        p41.w = v46;

        return math_ldexp(v44 + v46, -64);
    end,

    NextNumber = function(p47: any, p48: number, p49: number) -- Line: 111, Name: NextNumber
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy)
        local x = p47.x;
        local w = p47.w;
        local v50 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v51 = bit32_bxor(bit32_bxor(bit32_bxor(v50, (bit32_rshift(v50, 8))), w), (bit32_rshift(w, 19)));
        local z = p47.z;
        p47.x = p47.y;
        p47.y = z;
        p47.z = w;
        p47.w = v51;
        local v52 = math_ldexp(v51, 32);
        local x2 = p47.x;
        local w2 = p47.w;
        local v53 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v54 = bit32_bxor(bit32_bxor(bit32_bxor(v53, (bit32_rshift(v53, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p47.z;
        p47.x = p47.y;
        p47.y = z2;
        p47.z = w2;
        p47.w = v54;

        return p48 + (p49 - p48) * math_ldexp(v52 + v54, -64);
    end,

    NextInteger = function(p55: any, p56: number, p57: number) -- Line: 115, Name: NextInteger
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy), math_floor (copy)
        local x = p55.x;
        local w = p55.w;
        local v58 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v59 = bit32_bxor(bit32_bxor(bit32_bxor(v58, (bit32_rshift(v58, 8))), w), (bit32_rshift(w, 19)));
        local z = p55.z;
        p55.x = p55.y;
        p55.y = z;
        p55.z = w;
        p55.w = v59;
        local v60 = math_ldexp(v59, 32);
        local x2 = p55.x;
        local w2 = p55.w;
        local v61 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v62 = bit32_bxor(bit32_bxor(bit32_bxor(v61, (bit32_rshift(v61, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p55.z;
        p55.x = p55.y;
        p55.y = z2;
        p55.z = w2;
        p55.w = v62;

        return math_floor(p56 + (p57 - p56 + 1) * math_ldexp(v60 + v62, -64));
    end,

    NextNormal = function(p63: any, p64: number?, p65: number?) -- Line: 119, Name: NextNormal
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy), math_max (copy), math_log (copy), math_sqrt (copy), math_cos (copy), math_sin (copy)
        local x = p63.x;
        local w = p63.w;
        local v66 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v67 = bit32_bxor(bit32_bxor(bit32_bxor(v66, (bit32_rshift(v66, 8))), w), (bit32_rshift(w, 19)));
        local z = p63.z;
        p63.x = p63.y;
        p63.y = z;
        p63.z = w;
        p63.w = v67;
        local v68 = math_ldexp(v67, 32);
        local x2 = p63.x;
        local w2 = p63.w;
        local v69 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v70 = bit32_bxor(bit32_bxor(bit32_bxor(v69, (bit32_rshift(v69, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p63.z;
        p63.x = p63.y;
        p63.y = z2;
        p63.z = w2;
        p63.w = v70;
        local v71 = math_sqrt(math_log((math_max(2.2250738585072014e-308, (math_ldexp(v68 + v70, -64))))) * -2) * (p65 or 0);
        local x3 = p63.x;
        local w3 = p63.w;
        local v72 = bit32_bxor(x3, (bit32_lshift(x3, 11)));
        local v73 = bit32_bxor(bit32_bxor(bit32_bxor(v72, (bit32_rshift(v72, 8))), w3), (bit32_rshift(w3, 19)));
        local z3 = p63.z;
        p63.x = p63.y;
        p63.y = z3;
        p63.z = w3;
        p63.w = v73;
        local v74 = math_ldexp(v73, 32);
        local x4 = p63.x;
        local w4 = p63.w;
        local v75 = bit32_bxor(x4, (bit32_lshift(x4, 11)));
        local v76 = bit32_bxor(bit32_bxor(bit32_bxor(v75, (bit32_rshift(v75, 8))), w4), (bit32_rshift(w4, 19)));
        local z4 = p63.z;
        p63.x = p63.y;
        p63.y = z4;
        p63.z = w4;
        p63.w = v76;
        local v77 = 6.283185307179586 * math_ldexp(v74 + v76, -64);
        local v78 = p64 or 0;

        return math_cos(v77) * v71 + v78, math_sin(v77) * v71 + v78;
    end,

    NextBoolean = function(p79: any, p80: number?) -- Line: 126, Name: NextBoolean
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy)
        local x = p79.x;
        local w = p79.w;
        local v81 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v82 = bit32_bxor(bit32_bxor(bit32_bxor(v81, (bit32_rshift(v81, 8))), w), (bit32_rshift(w, 19)));
        local z = p79.z;
        p79.x = p79.y;
        p79.y = z;
        p79.z = w;
        p79.w = v82;
        local v83 = math_ldexp(v82, 32);
        local x2 = p79.x;
        local w2 = p79.w;
        local v84 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v85 = bit32_bxor(bit32_bxor(bit32_bxor(v84, (bit32_rshift(v84, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p79.z;
        p79.x = p79.y;
        p79.y = z2;
        p79.z = w2;
        p79.w = v85;

        return math_ldexp(v83 + v85, -64) < (p80 or 0.5);
    end,

    NextVector2 = function(p86: any, p87: number?) -- Line: 130, Name: NextVector2
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy), Vector2_new (copy), math_cos (copy), math_sin (copy)
        local v88 = p87 or 1;
        local x = p86.x;
        local w = p86.w;
        local v89 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v90 = bit32_bxor(bit32_bxor(bit32_bxor(v89, (bit32_rshift(v89, 8))), w), (bit32_rshift(w, 19)));
        local z = p86.z;
        p86.x = p86.y;
        p86.y = z;
        p86.z = w;
        p86.w = v90;
        local v91 = math_ldexp(v90, 32);
        local x2 = p86.x;
        local w2 = p86.w;
        local v92 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v93 = bit32_bxor(bit32_bxor(bit32_bxor(v92, (bit32_rshift(v92, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p86.z;
        p86.x = p86.y;
        p86.y = z2;
        p86.z = w2;
        p86.w = v93;
        local v94 = 6.283185307179586 * math_ldexp(v91 + v93, -64);

        return Vector2_new(math_cos(v94) * v88, math_sin(v94) * v88);
    end,

    NextVector3 = function(p95: any, p96: number?) -- Line: 136, Name: NextVector3
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy), math_sqrt (copy), math_cos (copy), math_sin (copy), Vector3_new (copy)
        local v97 = p96 or 1;
        local x = p95.x;
        local w = p95.w;
        local v98 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v99 = bit32_bxor(bit32_bxor(bit32_bxor(v98, (bit32_rshift(v98, 8))), w), (bit32_rshift(w, 19)));
        local z = p95.z;
        p95.x = p95.y;
        p95.y = z;
        p95.z = w;
        p95.w = v99;
        local v100 = math_ldexp(v99, 32);
        local x2 = p95.x;
        local w2 = p95.w;
        local v101 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v102 = bit32_bxor(bit32_bxor(bit32_bxor(v101, (bit32_rshift(v101, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p95.z;
        p95.x = p95.y;
        p95.y = z2;
        p95.z = w2;
        p95.w = v102;
        local v103 = 6.283185307179586 * math_ldexp(v100 + v102, -64);
        local x3 = p95.x;
        local w3 = p95.w;
        local v104 = bit32_bxor(x3, (bit32_lshift(x3, 11)));
        local v105 = bit32_bxor(bit32_bxor(bit32_bxor(v104, (bit32_rshift(v104, 8))), w3), (bit32_rshift(w3, 19)));
        local z3 = p95.z;
        p95.x = p95.y;
        p95.y = z3;
        p95.z = w3;
        p95.w = v105;
        local v106 = math_ldexp(v105, 32);
        local x4 = p95.x;
        local w4 = p95.w;
        local v107 = bit32_bxor(x4, (bit32_lshift(x4, 11)));
        local v108 = bit32_bxor(bit32_bxor(bit32_bxor(v107, (bit32_rshift(v107, 8))), w4), (bit32_rshift(w4, 19)));
        local z4 = p95.z;
        p95.x = p95.y;
        p95.y = z4;
        p95.z = w4;
        p95.w = v108;
        local v109 = math_ldexp(v106 + v108, -64) * 2 - 1;
        local v110 = math_sqrt(1 - v109 * v109);

        return Vector3_new(math_cos(v103) * v110 * v97, math_sin(v103) * v110 * v97, v109 * v97);
    end,

    NextUUIDv4 = function(p111) -- Line: 144, Name: NextUUIDv4
        -- upvalues: string_format (copy), bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), bit32_band (copy), bit32_bor (copy)
        local x = p111.x;
        local w = p111.w;
        local v112 = bit32_bxor(x, (bit32_lshift(x, 11)));
        local v113 = bit32_bxor(bit32_bxor(bit32_bxor(v112, (bit32_rshift(v112, 8))), w), (bit32_rshift(w, 19)));
        local z = p111.z;
        p111.x = p111.y;
        p111.y = z;
        p111.z = w;
        p111.w = v113;
        local x2 = p111.x;
        local w2 = p111.w;
        local v114 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
        local v115 = bit32_bxor(bit32_bxor(bit32_bxor(v114, (bit32_rshift(v114, 8))), w2), (bit32_rshift(w2, 19)));
        local z2 = p111.z;
        p111.x = p111.y;
        p111.y = z2;
        p111.z = w2;
        p111.w = v115;
        local v116 = bit32_bor(bit32_band(v115, 4294905855), 16384);
        local x3 = p111.x;
        local w3 = p111.w;
        local v117 = bit32_bxor(x3, (bit32_lshift(x3, 11)));
        local v118 = bit32_bxor(bit32_bxor(bit32_bxor(v117, (bit32_rshift(v117, 8))), w3), (bit32_rshift(w3, 19)));
        local z3 = p111.z;
        p111.x = p111.y;
        p111.y = z3;
        p111.z = w3;
        p111.w = v118;
        local v119 = bit32_bor(bit32_band(v118, 1073741823), 2147483648);
        local x4 = p111.x;
        local w4 = p111.w;
        local v120 = bit32_bxor(x4, (bit32_lshift(x4, 11)));
        local v121 = bit32_bxor(bit32_bxor(bit32_bxor(v120, (bit32_rshift(v120, 8))), w4), (bit32_rshift(w4, 19)));
        local z4 = p111.z;
        p111.x = p111.y;
        p111.y = z4;
        p111.z = w4;
        p111.w = v121;

        return string_format("%08x%08x%08x%08x", v113, v116, v119, v121);
    end,

    Seed = Seed,

    Shuffle = function(p122: any, p123: table) -- Line: 185, Name: Shuffle
        -- upvalues: bit32_lshift (copy), bit32_bxor (copy), bit32_rshift (copy), math_ldexp (copy), math_floor (copy)
        local v124 = type(p123) == "table";
        assert(v124);

        for i = #p123, 2, -1 do
            local x = p122.x;
            local w = p122.w;
            local v125 = bit32_bxor(x, (bit32_lshift(x, 11)));
            local v126 = bit32_bxor(bit32_bxor(bit32_bxor(v125, (bit32_rshift(v125, 8))), w), (bit32_rshift(w, 19)));
            local z = p122.z;
            p122.x = p122.y;
            p122.y = z;
            p122.z = w;
            p122.w = v126;
            local v127 = math_ldexp(v126, 32);
            local x2 = p122.x;
            local w2 = p122.w;
            local v128 = bit32_bxor(x2, (bit32_lshift(x2, 11)));
            local v129 = bit32_bxor(bit32_bxor(bit32_bxor(v128, (bit32_rshift(v128, 8))), w2), (bit32_rshift(w2, 19)));
            local z2 = p122.z;
            p122.x = p122.y;
            p122.y = z2;
            p122.z = w2;
            p122.w = v129;
            local v130 = math_floor((i - 1 + 1) * math_ldexp(v127 + v129, -64) + 1);
            local v131 = p123[i];
            p123[i] = p123[v130];
            p123[v130] = v131;
            local _ = i;
        end;
    end,

    Clone = function(p132) -- Line: 193, Name: Clone
        local v133 = {
            x = p132.x,
            y = p132.y,
            z = p132.z,
            w = p132.w
        };
        local v134 = getmetatable(p132);

        return setmetatable(v133, v134);
    end,

    GetState = function(p135) -- Line: 203, Name: GetState
        return {
            p135.x,
            p135.y,
            p135.z,
            p135.w
        };
    end,

    Skip = function(p136: any, p137: number) -- Line: 207, Name: Skip
        -- upvalues: math_floor (copy), script_Theory (copy)
        local v138;

        if type(p137) == "number" and (math_floor(p137) == p137 and p137 ~= (1 / 0)) then
            v138 = p137 ~= (-1 / 0);
        else
            v138 = false;
        end;

        if not v138 then
            error("Integer", 2);
        end;

        local v139, v140, v141, v142 = script_Theory.Transform(p136.x, p136.y, p136.z, p136.w, p137);
        p136.x = v139;
        p136.y = v140;
        p136.z = v141;
        p136.w = v142;
    end
});
local table_freeze_ret2 = table.freeze({
    __index = table_freeze_ret
});
local u145 = {
    new = function(p143) -- Line: 234, Name: new
        -- upvalues: Seed (copy), table_freeze_ret2 (copy)
        local v144 = {
            x = 0,
            y = 0,
            z = 0,
            w = 0
        };
        Seed(v144, p143);

        return setmetatable(v144, table_freeze_ret2);
    end
};

function u145.Unique(p146: number?) -- Line: 245
    -- upvalues: math_floor (copy), math_clamp (copy), u145 (copy), GenerateSeed (copy)
    if p146 ~= nil then
        local v147;

        if type(p146) == "number" and (math_floor(p146) == p146 and p146 ~= (1 / 0)) then
            v147 = p146 ~= (-1 / 0);
        else
            v147 = false;
        end;

        if not v147 then
            error("Integer", 2);
        end;

        if p146 < 0 then
            error("NonNegative", 2);
        end;
    end;

    local v148 = math_clamp(p146 or 4, 0, 4);

    return u145.new(GenerateSeed(v148));
end;

u145.R = u145.Unique();

return table.freeze(u145);