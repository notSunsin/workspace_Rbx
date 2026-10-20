-- Decompiled with Potassium's decompiler.

local function IsEqual(p1, p2) -- Line: 23
    return rawequal(p1, p2) and true or type(p1) == "number" and (type(p2) == "number" and (p1 ~= p1 and p2 ~= p2));
end;

local function IsASCII(p3: string) -- Line: 37
    for i = 1, string.len(p3) do
        local string_byte_ret = string.byte(p3, i);

        if string_byte_ret < 32 or string_byte_ret > 126 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local function IsFinite(p4: number) -- Line: 49
    local v5;

    if p4 == p4 and p4 ~= (1 / 0) then
        v5 = p4 ~= (-1 / 0);
    else
        v5 = false;
    end;

    return v5;
end;

local function IsInteger(p6: number) -- Line: 55
    local v7;

    if math.floor(p6) == p6 and p6 ~= (1 / 0) then
        v7 = p6 ~= (-1 / 0);
    else
        v7 = false;
    end;

    return v7;
end;

local function LuaString(p8: string) -- Line: 72
    local v9, _ = string.format("%q", p8):gsub("\n", "n");

    return v9;
end;

local function StringRep(p10) -- Line: 77
    if type(p10) == "string" then
        local v11, _ = string.format("%q", p10):gsub("\n", "n");

        return v11;
    end;

    if typeof(p10) == "Instance" then
        return p10:GetFullName();
    end;

    return tostring(p10);
end;

local function SafeKeyStringRep(p12) -- Line: 86
    if type(p12) == "number" or type(p12) == "boolean" then
        return `{p12}`;
    end;

    if type(p12) ~= "string" then
        if typeof(p12) == "Instance" then
            return p12:GetFullName();
        end;

        return `UnknownType({typeof(p12)})`;
    end;

    local utf8_len_ret = utf8.len(p12);

    if not utf8_len_ret then
        return "InvalidUTF8";
    end;

    local v13 = true;

    for i = 1, string.len(p12) do
        local string_byte_ret = string.byte(p12, i);

        if string_byte_ret < 32 or string_byte_ret > 126 then
            v13 = false;
            break;
        end;

        local _ = i;
    end;

    if not v13 then
        return "NonASCII";
    end;

    if utf8_len_ret <= 30 then
        local v14, _ = string.format("%q", p12):gsub("\n", "n");

        return v14;
    end;

    local string_sub_ret = string.sub(p12, 1, 30);
    local v15, _ = string.format("%q", string_sub_ret):gsub("\n", "n");

    return `{v15}...{utf8_len_ret - 30}`;
end;

local function StripErrorSource(p16) -- Line: 107
    local v17 = tostring(p16);
    local string_match_ret, v18 = string.match(v17, "^(.*:%d+): (.+)$");

    if string_match_ret then
        v17 = v18 or v17;
    end;

    return v17;
end;

local function ParseError(p19) -- Line: 118
    local v20 = tostring(p19);
    local string_match_ret, v21 = string.match(v20, "^(.*:%d+): (.+)$");

    if string_match_ret then
        v20 = v21 or v20;
    end;

    local string_match_ret2, v22 = string.match(v20, "^(.+) $(%[.+)$");

    if string_match_ret2 then
        if not v22 then
            string_match_ret2 = v20;
        end;
    else
        string_match_ret2 = v20;
    end;

    return string_match_ret2, v22;
end;

local function MakeError(p23: string, p24: string) -- Line: 130
    return `{p23} ${p24}`;
end;

local u45 = {
    IsCFrameFinite = function(p25) -- Line: 59, Name: IsCFrameFinite
        local Components, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36 = p25:GetComponents();
        local v37 = Components + v26 + v27 + v28 + v29 + v30 + v31 + v32 + v33 + v34 + v35 + v36;
        local v38;

        if v37 == v37 and v37 ~= (1 / 0) then
            v38 = v37 ~= (-1 / 0);
        else
            v38 = false;
        end;

        return v38;
    end,

    IsVector2Finite = function(p39) -- Line: 64, Name: IsVector2Finite
        local v40 = p39.X + p39.Y;
        local v41;

        if v40 == v40 and v40 ~= (1 / 0) then
            v41 = v40 ~= (-1 / 0);
        else
            v41 = false;
        end;

        return v41;
    end,

    IsVector3Finite = function(p42: vector) -- Line: 68, Name: IsVector3Finite
        local v43 = p42.X + p42.Y + p42.Z;
        local v44;

        if v43 == v43 and v43 ~= (1 / 0) then
            v44 = v43 ~= (-1 / 0);
        else
            v44 = false;
        end;

        return v44;
    end
};

function u45.Array(u46: function) -- Line: 140
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u46);

    return function(p47: table) -- Line: 142
        -- upvalues: SafeKeyStringRep (ref), u46 (copy)
        if type(p47) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p47) ~= nil then
            error("metatable", 2);
        end;

        local v48 = rawlen(p47);
        local v49 = 0;

        for i, v in pairs(p47) do
            v49 = v49 + 1;

            if i ~= v49 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v48 < v49 then
                error(`IndexOverflow ${`[{v49}]`}`, 2);
            end;

            local success, result = pcall(u46, v);

            if not success then
                local v50 = tostring(result);
                local string_match_ret, v51 = string.match(v50, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v50 = v51 or v50;
                end;

                local string_match_ret2, v52 = string.match(v50, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v52 then
                        string_match_ret2 = v50;
                    end;
                else
                    string_match_ret2 = v50;
                end;

                error(`{string_match_ret2} ${`[{v49}]{v52 or ""}`}`, 2);
            end;
        end;

        if v48 ~= v49 then
            error("LengthMismatch", 2);
        end;

        return p47;
    end;
end;

function u45.ArrayCoerce(u53: function) -- Line: 172
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u53);

    return function(p54: table) -- Line: 174
        -- upvalues: SafeKeyStringRep (ref), u53 (copy)
        if type(p54) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p54) ~= nil then
            error("metatable", 2);
        end;

        local v55 = rawlen(p54);
        local v56 = 0;
        local v57 = {};

        for i, v in pairs(p54) do
            v56 = v56 + 1;

            if i ~= v56 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v55 < v56 then
                error(`IndexOverflow ${`[{v56}]`}`, 2);
            end;

            local success, result = pcall(u53, v);

            if not success then
                local v58 = tostring(result);
                local string_match_ret, v59 = string.match(v58, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v58 = v59 or v58;
                end;

                local string_match_ret2, v60 = string.match(v58, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v60 then
                        string_match_ret2 = v58;
                    end;
                else
                    string_match_ret2 = v58;
                end;

                error(`{string_match_ret2} ${`[{v56}]{v60 or ""}`}`, 2);
            end;

            v57[i] = result;
        end;

        if v55 ~= v56 then
            error("LengthMismatch", 2);
        end;

        return v57;
    end;
end;

function u45.UniqueArray(u61: function) -- Line: 206
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u61);

    return function(p62: table) -- Line: 208
        -- upvalues: SafeKeyStringRep (ref), u61 (copy)
        if type(p62) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p62) ~= nil then
            error("metatable", 2);
        end;

        local v63 = rawlen(p62);
        local v64 = 0;
        local v65 = {};

        for i, v in pairs(p62) do
            v64 = v64 + 1;

            if i ~= v64 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v63 < v64 then
                error(`IndexOverflow ${`[{v64}]`}`, 2);
            end;

            if v65[v] then
                error(`UniqueArray ${`[{v64}]`}`, 2);
            end;

            v65[v] = true;

            if not v65[v] then
                error(`InvalidKey ${`[{v64}]`}`, 2);
            end;

            local success, result = pcall(u61, v);

            if not success then
                local v66 = tostring(result);
                local string_match_ret, v67 = string.match(v66, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v66 = v67 or v66;
                end;

                local string_match_ret2, v68 = string.match(v66, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v68 then
                        string_match_ret2 = v66;
                    end;
                else
                    string_match_ret2 = v66;
                end;

                error(`{string_match_ret2} ${`[{v64}]{v68 or ""}`}`, 2);
            end;
        end;

        if v63 ~= v64 then
            error("LengthMismatch", 2);
        end;

        return p62;
    end;
end;

function u45.UniqueArrayCoerce(u69: function) -- Line: 246
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u69);

    return function(p70: table) -- Line: 248
        -- upvalues: SafeKeyStringRep (ref), u69 (copy)
        if type(p70) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p70) ~= nil then
            error("metatable", 2);
        end;

        local v71 = rawlen(p70);
        local v72 = 0;
        local v73 = {};
        local v74 = {};

        for i, v in pairs(p70) do
            v72 = v72 + 1;

            if i ~= v72 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v71 < v72 then
                error(`IndexOverflow ${`[{v72}]`}`, 2);
            end;

            if v73[v] then
                error(`UniqueArray ${`[{v72}]`}`, 2);
            end;

            v73[v] = true;

            if not v73[v] then
                error(`InvalidKey ${`[{v72}]`}`, 2);
            end;

            local success, result = pcall(u69, v);

            if not success then
                local v75 = tostring(result);
                local string_match_ret, v76 = string.match(v75, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v75 = v76 or v75;
                end;

                local string_match_ret2, v77 = string.match(v75, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v77 then
                        string_match_ret2 = v75;
                    end;
                else
                    string_match_ret2 = v75;
                end;

                error(`{string_match_ret2} ${`[{v72}]{v77 or ""}`}`, 2);
            end;

            v74[i] = result;
        end;

        if v71 ~= v72 then
            error("LengthMismatch", 2);
        end;

        return v74;
    end;
end;

function u45.Map(u78: function, u79: function, p80: number?) -- Line: 289
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u78);
    u45.Function(u79);
    u45.Optional(u45.IntegerPositive)(p80);
    local u81 = p80 or (1 / 0);

    return function(p82) -- Line: 295
        -- upvalues: u81 (copy), u78 (copy), SafeKeyStringRep (ref), u79 (copy)
        if type(p82) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p82) ~= nil then
            error("metatable", 2);
        end;

        local v83 = 0;

        for i, v in pairs(p82) do
            v83 = v83 + 1;

            if u81 < v83 then
                error(`LengthLimit({u81})`, 2);
            end;

            local success, result = pcall(u78, i);

            if not success then
                local v84 = tostring(result);
                local string_match_ret, v85 = string.match(v84, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v84 = v85 or v84;
                end;

                local string_match_ret2, v86 = string.match(v84, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v86 then
                        string_match_ret2 = v84;
                    end;
                else
                    string_match_ret2 = v84;
                end;

                error(`{string_match_ret2} ${`<{SafeKeyStringRep(i)}>{v86 or ""}`}`, 2);
            end;

            local success2, result2 = pcall(u79, v);

            if not success2 then
                local v87 = tostring(result2);
                local string_match_ret, v88 = string.match(v87, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v87 = v88 or v87;
                end;

                local string_match_ret2, v89 = string.match(v87, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v89 then
                        string_match_ret2 = v87;
                    end;
                else
                    string_match_ret2 = v87;
                end;

                error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v89 or ""}`}`, 2);
            end;
        end;

        return p82;
    end;
end;

function u45.MapCoerce(u90: function, u91: function, p92: number?) -- Line: 324
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u90);
    u45.Function(u91);
    u45.Optional(u45.IntegerPositive)(p92);
    local u93 = p92 or (1 / 0);

    return function(p94) -- Line: 334
        -- upvalues: u93 (copy), u90 (copy), SafeKeyStringRep (ref), u91 (copy)
        if type(p94) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p94) ~= nil then
            error("metatable", 2);
        end;

        local v95 = 0;
        local v96 = {};

        for i, v in pairs(p94) do
            v95 = v95 + 1;

            if u93 < v95 then
                error(`LengthLimit({u93})`, 2);
            end;

            local success, result = pcall(u90, i);

            if not success then
                local v97 = tostring(result);
                local string_match_ret, v98 = string.match(v97, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v97 = v98 or v97;
                end;

                local string_match_ret2, v99 = string.match(v97, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v99 then
                        string_match_ret2 = v97;
                    end;
                else
                    string_match_ret2 = v97;
                end;

                error(`{string_match_ret2} ${`<{SafeKeyStringRep(i)}>{v99 or ""}`}`, 2);
            end;

            local success2, result2 = pcall(u91, v);

            if not success2 then
                local v100 = tostring(result2);
                local string_match_ret, v101 = string.match(v100, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v100 = v101 or v100;
                end;

                local string_match_ret2, v102 = string.match(v100, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v102 then
                        string_match_ret2 = v100;
                    end;
                else
                    string_match_ret2 = v100;
                end;

                error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v102 or ""}`}`, 2);
            end;

            v96[result] = result2;
        end;

        return v96;
    end;
end;

function u45.Table(p103: table) -- Line: 365
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.NoMetatable(p103);

    for _, v in pairs(p103) do
        u45.Function(v);
    end;

    local table_clone_ret = table.clone(p103);

    return function(p104) -- Line: 372
        -- upvalues: table_clone_ret (ref), SafeKeyStringRep (ref)
        if type(p104) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p104) ~= nil then
            error("metatable", 2);
        end;

        if rawlen(table_clone_ret) ~= rawlen(p104) then
            error("LengthMismatch", 2);
        end;

        for i, _ in pairs(p104) do
            if not table_clone_ret[i] then
                error(`UnknownKey ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;
        end;

        for i, v in pairs(table_clone_ret) do
            local success, result = pcall(v, p104[i]);

            if not success then
                local v105 = tostring(result);
                local string_match_ret, v106 = string.match(v105, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v105 = v106 or v105;
                end;

                local string_match_ret2, v107 = string.match(v105, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v107 then
                        string_match_ret2 = v105;
                    end;
                else
                    string_match_ret2 = v105;
                end;

                local v108 = error;
                local v109;

                if type(i) == "string" then
                    local v110;
                    v109, v110 = string.format("%q", i):gsub("\n", "n");
                elseif typeof(i) == "Instance" then
                    v109 = i:GetFullName();
                else
                    v109 = tostring(i);
                end;

                v108(`{string_match_ret2} ${`[{v109}]{v107 or ""}`}`, 2);
            end;
        end;

        return p104;
    end;
end;

function u45.TablePermissive(p111: table) -- Line: 399
    -- upvalues: u45 (copy)
    u45.NoMetatable(p111);

    for _, v in pairs(p111) do
        u45.Function(v);
    end;

    local table_clone_ret = table.clone(p111);

    return function(p112) -- Line: 406
        -- upvalues: table_clone_ret (ref)
        if type(p112) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p112) ~= nil then
            error("metatable", 2);
        end;

        if rawlen(table_clone_ret) ~= rawlen(p112) then
            error("LengthMismatch", 2);
        end;

        for i, v in pairs(table_clone_ret) do
            local success, result = pcall(v, p112[i]);

            if not success then
                local v113 = tostring(result);
                local string_match_ret, v114 = string.match(v113, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v113 = v114 or v113;
                end;

                local string_match_ret2, v115 = string.match(v113, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v115 then
                        string_match_ret2 = v113;
                    end;
                else
                    string_match_ret2 = v113;
                end;

                local v116 = error;
                local v117;

                if type(i) == "string" then
                    local v118;
                    v117, v118 = string.format("%q", i):gsub("\n", "n");
                elseif typeof(i) == "Instance" then
                    v117 = i:GetFullName();
                else
                    v117 = tostring(i);
                end;

                v116(`{string_match_ret2} ${`[{v117}]{v115 or ""}`}`, 2);
            end;
        end;

        return p112;
    end;
end;

function u45.TableCoerce(p119: table) -- Line: 434
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.NoMetatable(p119);

    for _, v in pairs(p119) do
        u45.Function(v);
    end;

    local table_clone_ret = table.clone(p119);

    return function(p120) -- Line: 441
        -- upvalues: table_clone_ret (ref), SafeKeyStringRep (ref)
        if type(p120) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p120) ~= nil then
            error("metatable", 2);
        end;

        if rawlen(table_clone_ret) ~= rawlen(p120) then
            error("LengthMismatch", 2);
        end;

        local v121 = {};

        for i, _ in pairs(p120) do
            if not table_clone_ret[i] then
                error(`UnknownKey ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;
        end;

        for i, v in pairs(table_clone_ret) do
            local success, result = pcall(v, p120[i]);

            if not success then
                local v122 = tostring(result);
                local string_match_ret, v123 = string.match(v122, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v122 = v123 or v122;
                end;

                local string_match_ret2, v124 = string.match(v122, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v124 then
                        string_match_ret2 = v122;
                    end;
                else
                    string_match_ret2 = v122;
                end;

                local v125 = error;
                local v126;

                if type(i) == "string" then
                    local v127;
                    v126, v127 = string.format("%q", i):gsub("\n", "n");
                elseif typeof(i) == "Instance" then
                    v126 = i:GetFullName();
                else
                    v126 = tostring(i);
                end;

                v125(`{string_match_ret2} ${`[{v126}]{v124 or ""}`}`, 2);
            end;

            v121[i] = result;
        end;

        return v121;
    end;
end;

function u45.IsASCII(p128: string) -- Line: 470
    local v129;

    if type(p128) == "string" then
        for i = 1, string.len(p128) do
            local string_byte_ret = string.byte(p128, i);

            if string_byte_ret < 32 or string_byte_ret > 126 then
                return false;
            end;

            local _ = i;
        end;

        v129 = true;
    else
        v129 = false;
    end;

    return v129;
end;

function u45.IsFinite(p130: number) -- Line: 473
    local v131;

    if type(p130) == "number" and (p130 == p130 and p130 ~= (1 / 0)) then
        v131 = p130 ~= (-1 / 0);
    else
        v131 = false;
    end;

    return v131;
end;

function u45.IsInteger(p132: number) -- Line: 476
    local v133;

    if type(p132) == "number" and (math.floor(p132) == p132 and p132 ~= (1 / 0)) then
        v133 = p132 ~= (-1 / 0);
    else
        v133 = false;
    end;

    return v133;
end;

function u45.IsCFrameFinite(p134) -- Line: 479
    local v135;

    if typeof(p134) == "CFrame" then
        local Components, v136, v137, v138, v139, v140, v141, v142, v143, v144, v145, v146 = p134:GetComponents();
        local v147 = Components + v136 + v137 + v138 + v139 + v140 + v141 + v142 + v143 + v144 + v145 + v146;

        if v147 == v147 and v147 ~= (1 / 0) then
            v135 = v147 ~= (-1 / 0);
        else
            v135 = false;
        end;
    else
        v135 = false;
    end;

    return v135;
end;

function u45.IsVector2Finite(p148) -- Line: 482
    local v149;

    if typeof(p148) == "Vector2" then
        local v150 = p148.X + p148.Y;

        if v150 == v150 and v150 ~= (1 / 0) then
            v149 = v150 ~= (-1 / 0);
        else
            v149 = false;
        end;
    else
        v149 = false;
    end;

    return v149;
end;

function u45.Optional(u151: function) -- Line: 486
    if type(u151) ~= "function" then
        error("function", 2);
    end;

    return function(p152) -- Line: 490
        -- upvalues: u151 (copy)
        if p152 == nil then
            return nil;
        end;

        local success, result = pcall(u151, p152);

        if not success then
            local v153 = error;
            local v154 = tostring(result);
            local string_match_ret, v155 = string.match(v154, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v154 = v155 or v154;
            end;

            v153(v154, 2);
        end;

        return result;
    end;
end;

function u45.Default(u156: function, p157: any) -- Line: 502
    if type(u156) ~= "function" then
        error("function", 2);
    end;

    local u158 = u156(p157);

    return function(p159) -- Line: 507
        -- upvalues: u158 (copy), u156 (copy)
        if p159 == nil then
            return u158;
        end;

        local success, result = pcall(u156, p159);

        if not success then
            local v160 = error;
            local v161 = tostring(result);
            local string_match_ret, v162 = string.match(v161, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v161 = v162 or v161;
            end;

            v160(v161, 2);
        end;

        return result;
    end;
end;

function u45.AnyOf(...) -- Line: 519
    local table_pack_ret = table.pack(...);

    for i = 1, table_pack_ret.n do
        local v163 = type(table_pack_ret[i]) == "function";
        assert(v163, "function");
        local _ = i;
    end;

    assert(table_pack_ret.n > 0);

    return function(p164) -- Line: 525
        -- upvalues: table_pack_ret (copy)
        for i = 1, table_pack_ret.n do
            local success, result = pcall(table_pack_ret[i], p164);

            if success then
                return result;
            end;

            local _ = i;
        end;

        error("AnyOf", 2);
    end;
end;

function u45.AllOf(...) -- Line: 536
    local table_pack_ret = table.pack(...);

    for i = 1, table_pack_ret.n do
        local v165 = type(table_pack_ret[i]) == "function";
        assert(v165, "function");
        local _ = i;
    end;

    assert(table_pack_ret.n > 0);

    return function(p166) -- Line: 542
        -- upvalues: table_pack_ret (copy)
        for i = 1, table_pack_ret.n do
            local success, result = pcall(table_pack_ret[i], p166);
            local v167;

            if success then
                v167 = i;
            else
                local v168 = error;
                local v169 = tostring(result);
                local string_match_ret, v170 = string.match(v169, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v169 = v170 or v169;
                end;

                v168(v169, 2);
                v167 = i;
            end;
        end;

        return p166;
    end;
end;

function u45.AnyTable(p171) -- Line: 554
    if type(p171) ~= "table" then
        error("table", 2);
    end;

    return p171;
end;

function u45.Number(p172: number) -- Line: 560
    if type(p172) ~= "number" then
        error("number", 2);
    end;

    return p172;
end;

function u45.Boolean(p173: boolean) -- Line: 566
    if type(p173) ~= "boolean" then
        error("boolean", 2);
    end;

    return p173;
end;

function u45.Buffer(p174: buffer) -- Line: 572
    if type(p174) ~= "buffer" then
        error("buffer", 2);
    end;

    return p174;
end;

function u45.Function(p175: function) -- Line: 578
    if type(p175) ~= "function" then
        error("function", 2);
    end;

    return p175;
end;

function u45.Thread(p176: thread) -- Line: 584
    if type(p176) ~= "thread" then
        error("thread", 2);
    end;

    return p176;
end;

function u45.String(p177: string) -- Line: 591
    if type(p177) ~= "string" then
        error("string", 2);
    end;

    if not utf8.len(p177) then
        error("UTF8", 2);
    end;

    return p177;
end;

function u45.RawString(p178: string) -- Line: 601
    if type(p178) ~= "string" then
        error("string", 2);
    end;

    return p178;
end;

function u45.Any(p179) -- Line: 608
    return p179;
end;

function u45.Equals(u180) -- Line: 612
    return function(p181) -- Line: 613
        -- upvalues: u180 (copy)
        local v182 = u180;

        if not (rawequal(p181, v182) or type(p181) == "number" and (type(v182) == "number" and (p181 ~= p181 and v182 ~= v182))) then
            error("Equals", 2);
        end;

        return p181;
    end;
end;

function u45.Set(p183: table) -- Line: 621
    -- upvalues: u45 (copy)
    u45.Array(u45.Any);
    local u184 = {};

    for _, v in ipairs(p183) do
        if v ~= v then
            error("InvalidKeyNaN", 2);
        end;

        u184[v] = true;

        if not u184[v] then
            error("InvalidKey", 2);
        end;
    end;

    return function(p185) -- Line: 633
        -- upvalues: u184 (copy)
        if not u184[p185] then
            error("Set", 2);
        end;

        return p185;
    end;
end;

function u45.Pattern(u186: string) -- Line: 641
    -- upvalues: u45 (copy)
    u45.String(u186);

    return function(p187) -- Line: 643
        -- upvalues: u186 (copy)
        if type(p187) ~= "string" then
            error("string", 2);
        end;

        if not utf8.len(p187) then
            error("UTF8", 2);
        end;

        if not string.find(p187, u186) then
            error("Pattern", 2);
        end;

        return p187;
    end;
end;

function u45.NoMetatable(p188) -- Line: 657
    if type(p188) ~= "table" then
        error("table", 2);
    end;

    if getmetatable(p188) ~= nil then
        error("metatable", 2);
    end;

    return p188;
end;

function u45.Finite(p189: number) -- Line: 668
    if type(p189) ~= "number" then
        error("number", 2);
    end;

    local v190;

    if p189 == p189 and p189 ~= (1 / 0) then
        v190 = p189 ~= (-1 / 0);
    else
        v190 = false;
    end;

    if not v190 then
        error("Finite", 2);
    end;

    return p189;
end;

function u45.FinitePositive(p191: number) -- Line: 679
    if type(p191) ~= "number" then
        error("number", 2);
    end;

    local v192;

    if p191 == p191 and p191 ~= (1 / 0) then
        v192 = p191 ~= (-1 / 0);
    else
        v192 = false;
    end;

    if not v192 then
        error("Finite", 2);
    end;

    if p191 <= 0 then
        error("Positive", 2);
    end;

    return p191;
end;

function u45.FiniteNonNegative(p193: number) -- Line: 693
    if type(p193) ~= "number" then
        error("number", 2);
    end;

    local v194;

    if p193 == p193 and p193 ~= (1 / 0) then
        v194 = p193 ~= (-1 / 0);
    else
        v194 = false;
    end;

    if not v194 then
        error("Finite", 2);
    end;

    if p193 < 0 then
        error("NonNegative", 2);
    end;

    return p193;
end;

function u45.Positive(p195: number) -- Line: 707
    if type(p195) ~= "number" then
        error("number", 2);
    end;

    if p195 <= 0 then
        error("Positive", 2);
    end;

    return p195;
end;

function u45.NonNegative(p196: number) -- Line: 718
    if type(p196) ~= "number" then
        error("number", 2);
    end;

    if p196 < 0 then
        error("NonNegative", 2);
    end;

    return p196;
end;

function u45.Real(p197: number) -- Line: 729
    if type(p197) ~= "number" then
        error("number", 2);
    end;

    if p197 ~= p197 then
        error("Real", 2);
    end;

    return p197;
end;

function u45.Range(u198: number, u199: number) -- Line: 740
    -- upvalues: u45 (copy)
    u45.Real(u198);
    u45.Real(u199);

    if u198 > u199 then
        error("a<=b", 2);
    end;

    return function(p200) -- Line: 746
        -- upvalues: u198 (copy), u199 (copy)
        if type(p200) ~= "number" then
            error("number", 2);
        end;

        if u198 > p200 or p200 > u199 then
            error(`Range({u198},{u199})`, 2);
        end;

        return p200;
    end;
end;

function u45.Integer(p201: number) -- Line: 758
    if type(p201) ~= "number" then
        error("number", 2);
    end;

    local v202;

    if math.floor(p201) == p201 and p201 ~= (1 / 0) then
        v202 = p201 ~= (-1 / 0);
    else
        v202 = false;
    end;

    if not v202 then
        error("Integer", 2);
    end;

    return p201;
end;

function u45.Unsigned32(p203: number) -- Line: 769
    if bit32.bor(p203, 0) ~= p203 then
        error("Unsigned32", 2);
    end;

    return p203;
end;

function u45.IntegerPositive(p204: number) -- Line: 778
    if type(p204) ~= "number" then
        error("number", 2);
    end;

    local v205;

    if math.floor(p204) == p204 and p204 ~= (1 / 0) then
        v205 = p204 ~= (-1 / 0);
    else
        v205 = false;
    end;

    if not v205 then
        error("Integer", 2);
    end;

    if p204 < 1 then
        error("Positive", 2);
    end;

    return p204;
end;

function u45.Index(p206: number) -- Line: 792
    if type(p206) ~= "number" then
        error("number", 2);
    end;

    local v207;

    if math.floor(p206) == p206 and p206 ~= (1 / 0) then
        v207 = p206 ~= (-1 / 0);
    else
        v207 = false;
    end;

    if not v207 then
        error("Integer", 2);
    end;

    if p206 < 1 then
        error("Positive", 2);
    end;

    return p206;
end;

function u45.IntegerNonNegative(p208: number) -- Line: 806
    if type(p208) ~= "number" then
        error("number", 2);
    end;

    local v209;

    if math.floor(p208) == p208 and p208 ~= (1 / 0) then
        v209 = p208 ~= (-1 / 0);
    else
        v209 = false;
    end;

    if not v209 then
        error("Integer", 2);
    end;

    if p208 < 0 then
        error("NonNegative", 2);
    end;

    return p208;
end;

function u45.IntegerRange(u210: number, u211: number) -- Line: 820
    -- upvalues: u45 (copy)
    u45.Integer(u210);
    u45.Integer(u211);

    if u210 > u211 then
        error("a<=b", 2);
    end;

    return function(p212) -- Line: 826
        -- upvalues: u210 (copy), u211 (copy)
        if type(p212) ~= "number" then
            error("number", 2);
        end;

        local v213;

        if math.floor(p212) == p212 and p212 ~= (1 / 0) then
            v213 = p212 ~= (-1 / 0);
        else
            v213 = false;
        end;

        if not v213 then
            error("Integer", 2);
        end;

        if u210 > p212 or p212 > u211 then
            error(`Range({u210},{u211})`, 2);
        end;

        return p212;
    end;
end;

function u45.UInt32() -- Line: 840
    return function(p214) -- Line: 841
        if type(p214) ~= "number" then
            error("number", 2);
        end;

        if bit32.bor(p214, 0) ~= p214 then
            error("UInt32", 2);
        end;

        return p214;
    end;
end;

function u45.StringRange(u215: number, u216: number) -- Line: 853
    -- upvalues: u45 (copy)
    u45.Integer(u215);
    u45.Integer(u216);

    if u215 > u216 then
        error("a<=b", 2);
    end;

    return function(p217) -- Line: 859
        -- upvalues: u215 (copy), u216 (copy)
        if type(p217) ~= "string" then
            error("string", 2);
        end;

        local utf8_len_ret = utf8.len(p217);

        if not utf8_len_ret then
            error("UTF8", 2);
        end;

        if u215 > utf8_len_ret or utf8_len_ret > u216 then
            error(`StringRange({u215},{u216})`, 2);
        end;

        return p217;
    end;
end;

function u45.ASCII(p218: string) -- Line: 874
    if type(p218) ~= "string" then
        error("string", 2);
    end;

    for i = 1, string.len(p218) do
        local string_byte_ret = string.byte(p218, i);
        local v219;

        if string_byte_ret < 32 or string_byte_ret > 126 then
            error("ASCII", 2);
            v219 = i;
        else
            v219 = i;
        end;
    end;

    return p218;
end;

function u45.ASCIIRange(u220: number, u221: number) -- Line: 888
    -- upvalues: u45 (copy)
    u45.Integer(u220);
    u45.Integer(u221);

    if u220 > u221 then
        error("a<=b", 2);
    end;

    return function(p222) -- Line: 894
        -- upvalues: u220 (copy), u221 (copy)
        if type(p222) ~= "string" then
            error("string", 2);
        end;

        local string_len_ret = string.len(p222);

        if u220 > string_len_ret or string_len_ret > u221 then
            error(`ASCIIRange({u220},{u221})`, 2);
        end;

        for i = 1, string_len_ret do
            local string_byte_ret = string.byte(p222, i);
            local v223;

            if string_byte_ret < 32 or string_byte_ret > 126 then
                error("ASCII", 2);
                v223 = i;
            else
                v223 = i;
            end;
        end;

        return p222;
    end;
end;

function u45.CFrame(p224) -- Line: 912
    if typeof(p224) ~= "CFrame" then
        error("CFrame", 2);
    end;

    return p224;
end;

function u45.CFrameFinite(p225) -- Line: 918
    if typeof(p225) ~= "CFrame" then
        error("CFrame", 2);
    end;

    local Components, v226, v227, v228, v229, v230, v231, v232, v233, v234, v235, v236 = p225:GetComponents();
    local v237 = Components + v226 + v227 + v228 + v229 + v230 + v231 + v232 + v233 + v234 + v235 + v236;
    local v238;

    if v237 == v237 and v237 ~= (1 / 0) then
        v238 = v237 ~= (-1 / 0);
    else
        v238 = false;
    end;

    if not v238 then
        error("CFrameFinite", 2);
    end;

    return p225;
end;

function u45.Vector2(p239) -- Line: 927
    if typeof(p239) ~= "Vector2" then
        error("Vector2", 2);
    end;

    return p239;
end;

function u45.Vector2Finite(p240) -- Line: 933
    if typeof(p240) ~= "Vector2" then
        error("Vector2", 2);
    end;

    local v241 = p240.X + p240.Y;
    local v242;

    if v241 == v241 and v241 ~= (1 / 0) then
        v242 = v241 ~= (-1 / 0);
    else
        v242 = false;
    end;

    if not v242 then
        error("Vector2Finite", 2);
    end;

    return p240;
end;

function u45.Vector2Unit(p243) -- Line: 942
    if typeof(p243) ~= "Vector2" then
        error("Vector2", 2);
    end;

    local v244 = p243.X + p243.Y;
    local v245;

    if v244 == v244 and v244 ~= (1 / 0) then
        v245 = v244 ~= (-1 / 0);
    else
        v245 = false;
    end;

    if not v245 then
        error("Vector2Finite", 2);
    end;

    if math.abs(p243.Magnitude - 1) > 1e-6 then
        error("Vector2Unit", 2);
    end;

    return p243;
end;

function u45.Vector3(p246: vector) -- Line: 954
    if typeof(p246) ~= "Vector3" then
        error("Vector3", 2);
    end;

    return p246;
end;

function u45.Vector3Finite(p247: vector) -- Line: 960
    if typeof(p247) ~= "Vector3" then
        error("Vector3", 2);
    end;

    local v248 = p247.X + p247.Y + p247.Z;
    local v249;

    if v248 == v248 and v248 ~= (1 / 0) then
        v249 = v248 ~= (-1 / 0);
    else
        v249 = false;
    end;

    if not v249 then
        error("Vector3Finite", 2);
    end;

    return p247;
end;

function u45.Vector3Unit(p250: vector) -- Line: 969
    if typeof(p250) ~= "Vector3" then
        error("Vector3", 2);
    end;

    local v251 = p250.X + p250.Y + p250.Z;
    local v252;

    if v251 == v251 and v251 ~= (1 / 0) then
        v252 = v251 ~= (-1 / 0);
    else
        v252 = false;
    end;

    if not v252 then
        error("Vector3Finite", 2);
    end;

    if math.abs(p250.Magnitude - 1) > 1e-6 then
        error("Vector3Unit", 2);
    end;

    return p250;
end;

function u45.Vector3Positive(p253: vector) -- Line: 981
    if typeof(p253) ~= "Vector3" then
        error("Vector3", 2);
    end;

    local v254 = p253.X + p253.Y + p253.Z;
    local v255;

    if v254 == v254 and v254 ~= (1 / 0) then
        v255 = v254 ~= (-1 / 0);
    else
        v255 = false;
    end;

    if not v255 then
        error("Vector3Finite", 2);
    end;

    if p253.X <= 0 or (p253.Y <= 0 or p253.Z <= 0) then
        error("Vector3Positive");
    end;

    return p253;
end;

function u45.Vector3int16(p256: userdata) -- Line: 993
    if typeof(p256) ~= "Vector3int16" then
        error("Vector3int16", 2);
    end;

    return p256;
end;

function u45.Vector2int16(p257: userdata) -- Line: 999
    if typeof(p257) ~= "Vector2int16" then
        error("Vector2int16", 2);
    end;

    return p257;
end;

function u45.Region3(p258: userdata) -- Line: 1005
    if typeof(p258) ~= "Region3" then
        error("Region3", 2);
    end;

    return p258;
end;

function u45.Region3int16(p259: userdata) -- Line: 1011
    if typeof(p259) ~= "Region3int16" then
        error("Region3int16", 2);
    end;

    return p259;
end;

function u45.UDim(p260) -- Line: 1017
    if typeof(p260) ~= "UDim" then
        error("UDim", 2);
    end;

    return p260;
end;

function u45.UDim2(p261) -- Line: 1023
    if typeof(p261) ~= "UDim2" then
        error("UDim2", 2);
    end;

    return p261;
end;

function u45.Rect(p262) -- Line: 1029
    if typeof(p262) ~= "Rect" then
        error("Rect", 2);
    end;

    return p262;
end;

function u45.PhysicalProperties(p263: userdata) -- Line: 1035
    if typeof(p263) ~= "PhysicalProperties" then
        error("PhysicalProperties", 2);
    end;

    return p263;
end;

function u45.Storable(p264: any, p265: table?) -- Line: 1044
    -- upvalues: SafeKeyStringRep (copy), u45 (copy)
    if type(p264) == "boolean" then
        return p264;
    end;

    if type(p264) == "number" then
        return p264;
    end;

    if type(p264) == "string" then
        if not utf8.len(p264) then
            error("UTF8", 2);

            return p264;
        end;
    else
        if type(p264) == "buffer" then
            return p264;
        end;

        if type(p264) == "table" then
            if type(p264) ~= "table" then
                error("table", 2);
            end;

            if getmetatable(p264) ~= nil then
                error("metatable", 2);
            end;

            local v266 = p265 or {};

            if v266[p264] then
                error("Loop", 2);
            end;

            v266[p264] = true;
            local v267 = rawlen(p264);

            if v267 <= 0 then
                for i, v in pairs(p264) do
                    if type(i) ~= "string" then
                        error(`KeyString ${`[{SafeKeyStringRep(i)}]`}`, 2);
                    end;

                    if not utf8.len(i) then
                        error(`KeyUTF8 ${`[{SafeKeyStringRep(i)}]`}`, 2);
                    end;

                    local success, result = pcall(u45.Storable, v, v266);

                    if not success then
                        local v268 = tostring(result);
                        local string_match_ret, v269 = string.match(v268, "^(.*:%d+): (.+)$");

                        if string_match_ret then
                            v268 = v269 or v268;
                        end;

                        local string_match_ret2, v270 = string.match(v268, "^(.+) $(%[.+)$");

                        if string_match_ret2 then
                            if not v270 then
                                string_match_ret2 = v268;
                            end;
                        else
                            string_match_ret2 = v268;
                        end;

                        error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v270 or ""}`}`, 2);
                    end;
                end;

                return p264;
            end;

            local v271 = 0;

            for i, v in pairs(p264) do
                v271 = v271 + 1;

                if i ~= v271 then
                    error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
                end;

                if v267 < v271 then
                    error(`IndexOverflow ${`[{v271}]`}`, 2);
                end;

                local success, result = pcall(u45.Storable, v, v266);

                if not success then
                    local v272 = tostring(result);
                    local string_match_ret, v273 = string.match(v272, "^(.*:%d+): (.+)$");

                    if string_match_ret then
                        v272 = v273 or v272;
                    end;

                    local string_match_ret2, v274 = string.match(v272, "^(.+) $(%[.+)$");

                    if string_match_ret2 then
                        if not v274 then
                            string_match_ret2 = v272;
                        end;
                    else
                        string_match_ret2 = v272;
                    end;

                    error(`{string_match_ret2} ${`[{v271}]{v274 or ""}`}`, 2);
                end;
            end;

            if v267 ~= v271 then
                error("LengthMismatch", 2);

                return p264;
            end;
        else
            error("Storable", 2);
        end;
    end;

    return p264;
end;

local u275 = {
    boolean = true,
    number = true,
    string = true,
    buffer = true,
    Color3 = true,
    Instance = true,
    NumberRange = true,
    Rect = true,
    Region3 = true,
    Region3int16 = true,
    UDim = true,
    UDim2 = true,
    CFrame = true,
    Vector2 = true,
    Vector2int16 = true,
    Vector3 = true,
    Vector3int16 = true,
    EnumItem = true
};
table.freeze(u275);

function u45.Networkable(p276: any, p277: table?) -- Line: 1150
    -- upvalues: SafeKeyStringRep (copy), u45 (copy), u275 (copy)
    if type(p276) == "string" then
        if not utf8.len(p276) then
            error("UTF8", 2);

            return p276;
        end;
    elseif type(p276) == "table" then
        if type(p276) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p276) ~= nil then
            error("metatable", 2);
        end;

        local v278 = p277 or {};

        if v278[p276] then
            error("Loop", 2);
        end;

        v278[p276] = true;
        local v279 = rawlen(p276);

        if v279 <= 0 then
            for i, v in pairs(p276) do
                if type(i) ~= "string" then
                    error(`KeyString ${`[{SafeKeyStringRep(i)}]`}`, 2);
                end;

                if not utf8.len(i) then
                    error(`KeyUTF8 ${`[{SafeKeyStringRep(i)}]`}`, 2);
                end;

                local success, result = pcall(u45.Networkable, v, v278);

                if not success then
                    local v280 = tostring(result);
                    local string_match_ret, v281 = string.match(v280, "^(.*:%d+): (.+)$");

                    if string_match_ret then
                        v280 = v281 or v280;
                    end;

                    local string_match_ret2, v282 = string.match(v280, "^(.+) $(%[.+)$");

                    if string_match_ret2 then
                        if not v282 then
                            string_match_ret2 = v280;
                        end;
                    else
                        string_match_ret2 = v280;
                    end;

                    error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v282 or ""}`}`, 2);
                end;
            end;

            return p276;
        end;

        local v283 = 0;

        for i, v in pairs(p276) do
            v283 = v283 + 1;

            if i ~= v283 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v279 < v283 then
                error(`IndexOverflow ${`[{v283}]`}`, 2);
            end;

            local success, result = pcall(u45.Networkable, v, v278);

            if not success then
                local v284 = tostring(result);
                local string_match_ret, v285 = string.match(v284, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v284 = v285 or v284;
                end;

                local string_match_ret2, v286 = string.match(v284, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v286 then
                        string_match_ret2 = v284;
                    end;
                else
                    string_match_ret2 = v284;
                end;

                error(`{string_match_ret2} ${`[{v283}]{v286 or ""}`}`, 2);
            end;
        end;

        if v279 ~= v283 then
            error("LengthMismatch", 2);

            return p276;
        end;
    elseif not u275[typeof(p276)] then
        error("Networkable", 2);
    end;

    return p276;
end;

function u45.Enum(u287: userdata) -- Line: 1210
    if typeof(u287) ~= "Enum" then
        error("Enum", 2);
    end;

    return function(p288) -- Line: 1214
        -- upvalues: u287 (copy)
        if typeof(p288) ~= "EnumItem" then
            error("EnumItem", 2);
        end;

        if p288.EnumType ~= u287 then
            error(tostring(u287), 2);
        end;

        return p288;
    end;
end;

function u45.EnumValue(p289: userdata) -- Line: 1225
    if typeof(p289) ~= "Enum" then
        error("Enum", 2);
    end;

    local u290 = {};

    for _, v in ipairs(p289:GetEnumItems()) do
        u290[v.Value] = v;
    end;

    return function(p291) -- Line: 1233
        -- upvalues: u290 (copy)
        if typeof(p291) ~= "number" then
            error("number", 2);
        end;

        if not u290[p291] then
            error("EnumValue", 2);
        end;

        return p291;
    end;
end;

function u45.Player(p292: userdata) -- Line: 1244
    if typeof(p292) ~= "Instance" or not p292:IsA("Player") then
        error("Player", 2);
    end;

    return p292;
end;

function u45.BasePart(p293: userdata) -- Line: 1250
    if typeof(p293) ~= "Instance" or not p293:IsA("BasePart") then
        error("BasePart", 2);
    end;

    return p293;
end;

function u45.Part(p294: userdata) -- Line: 1256
    if typeof(p294) ~= "Instance" or not p294:IsA("Part") then
        error("Part", 2);
    end;

    return p294;
end;

function u45.MeshPart(p295: userdata) -- Line: 1262
    if typeof(p295) ~= "Instance" or not p295:IsA("MeshPart") then
        error("MeshPart", 2);
    end;

    return p295;
end;

function u45.Model(p296: userdata) -- Line: 1268
    if typeof(p296) ~= "Instance" or not p296:IsA("Model") then
        error("Model", 2);
    end;

    return p296;
end;

function u45.Animation(p297: userdata) -- Line: 1274
    if typeof(p297) ~= "Instance" or not p297:IsA("Animation") then
        error("Animation", 2);
    end;

    return p297;
end;

function u45.Humanoid(p298: userdata) -- Line: 1280
    if typeof(p298) ~= "Instance" or not p298:IsA("Humanoid") then
        error("Humanoid", 2);
    end;

    return p298;
end;

function u45.ParticleEmitter(p299: userdata) -- Line: 1286
    if typeof(p299) ~= "Instance" or not p299:IsA("ParticleEmitter") then
        error("ParticleEmitter", 2);
    end;

    return p299;
end;

function u45.Sound(p300: userdata) -- Line: 1292
    if typeof(p300) ~= "Instance" or not p300:IsA("Sound") then
        error("Sound", 2);
    end;

    return p300;
end;

function u45.Instance(p301: userdata) -- Line: 1298
    if typeof(p301) ~= "Instance" then
        error("Instance", 2);
    end;

    return p301;
end;

function u45.InstanceOf(u302: string) -- Line: 1306
    -- upvalues: u45 (copy)
    u45.String(u302);

    return function(p303) -- Line: 1308
        -- upvalues: u302 (copy)
        if typeof(p303) ~= "Instance" then
            error("Instance", 2);
        end;

        if not p303:IsA(u302) then
            error(u302, 2);
        end;

        return p303;
    end;
end;

function u45.InstanceClass(u304: string) -- Line: 1319
    -- upvalues: u45 (copy)
    u45.String(u304);

    return function(p305) -- Line: 1321
        -- upvalues: u304 (copy)
        if typeof(p305) ~= "Instance" then
            error("Instance", 2);
        end;

        if p305.ClassName ~= u304 then
            error(u304, 2);
        end;

        return p305;
    end;
end;

function u45.HexLower(p306: string) -- Line: 1332
    if type(p306) ~= "string" then
        error("string", 2);
    end;

    for i = 1, string.len(p306) do
        local string_byte_ret = string.byte(p306, i);
        local v307;

        if string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 97 and string_byte_ret <= 102 then
            v307 = i;
        else
            error("HexLower", 2);
            v307 = i;
        end;
    end;

    return p306;
end;

function u45.HexUpper(p308: string) -- Line: 1346
    if type(p308) ~= "string" then
        error("string", 2);
    end;

    for i = 1, string.len(p308) do
        local string_byte_ret = string.byte(p308, i);
        local v309;

        if string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 65 and string_byte_ret <= 70 then
            v309 = i;
        else
            error("HexUpper", 2);
            v309 = i;
        end;
    end;

    return p308;
end;

function u45.UUIDStripped(p310: string) -- Line: 1360
    if type(p310) ~= "string" then
        error("string", 2);
    end;

    local string_len_ret = string.len(p310);

    if string_len_ret ~= 32 then
        error("Length32", 2);
    end;

    for i = 1, string_len_ret do
        local string_byte_ret = string.byte(p310, i);
        local v311;

        if string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 97 and string_byte_ret <= 102 then
            v311 = i;
        else
            error("HexLower", 2);
            v311 = i;
        end;
    end;

    return p310;
end;

function u45.UUID(p312: string) -- Line: 1378
    if type(p312) ~= "string" then
        error("string", 2);
    end;

    if string.len(p312) ~= 36 then
        error("Length36", 2);
    end;

    if not p312:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        error("UUID", 2);
    end;

    return p312;
end;

function u45.Base64(p313: string) -- Line: 1391
    if type(p313) ~= "string" then
        error("string", 2);
    end;

    if string.len(p313) % 4 ~= 0 then
        error("Base64Length", 2);
    end;

    if not string.match(p313, "^[A-Za-z0-9+/]*=?=?$") or string.match(p313, "[^=]=+[^=]") then
        error("Base64", 2);
    end;

    return p313;
end;

function u45.ToNumber(u314: function) -- Line: 1404
    return function(p315) -- Line: 1405
        -- upvalues: u314 (copy)
        local v316 = tonumber(p315);

        if not v316 then
            error("tonumber", 2);
        end;

        local success, result = pcall(u314, v316);

        if not success then
            local v317 = error;
            local v318 = tostring(result);
            local string_match_ret, v319 = string.match(v318, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v318 = v319 or v318;
            end;

            v317(v318, 2);
        end;

        return result;
    end;
end;

function u45.IsoDate(p320: string) -- Line: 1418
    if not DateTime.fromIsoDate(p320) then
        error("IsoDate", 2);
    end;

    return p320;
end;

return table.freeze(u45);