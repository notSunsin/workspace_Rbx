-- Decompiled with Potassium's decompiler.

local TextService = game:GetService("TextService");
local u5 = {
    MakeDictionary = function(p1) -- Line: 6, Name: MakeDictionary
        local v2 = {};

        for i = 1, #p1 do
            v2[p1[i]] = true;
            local _ = i;
        end;

        return v2;
    end,

    DictionaryKeys = function(p3) -- Line: 17, Name: DictionaryKeys
        local v4 = {};

        for i in pairs(p3) do
            table.insert(v4, i);
        end;

        return v4;
    end
};

local function transformInstanceSet(p6) -- Line: 28
    local v7 = {};

    for i = 1, #p6 do
        v7[i] = p6[i].Name;
        local _ = i;
    end;

    return v7, p6;
end;

function u5.MakeFuzzyFinder(p8) -- Line: 42
    local u9 = nil;
    local u10 = {};

    if typeof(p8) == "Enum" then
        p8 = p8:GetEnumItems();
    end;

    if typeof(p8) == "Instance" then
        u10 = p8:GetChildren();
        u9 = {};

        for i = 1, #u10 do
            u9[i] = u10[i].Name;
            local _ = i;
        end;
    elseif typeof(p8) == "table" then
        if typeof(p8[1]) == "Instance" or (typeof(p8[1]) == "EnumItem" or typeof(p8[1]) == "table" and typeof(p8[1].Name) == "string") then
            u9 = {};
            u10 = p8;

            for i = 1, #p8 do
                u9[i] = u10[i].Name;
                p8 = u10;
                local _ = i;
                u10 = p8;
            end;
        elseif type(p8[1]) == "string" then
            u9 = p8;
        elseif p8[1] == nil then
            u9 = {};
        else
            error("MakeFuzzyFinder only accepts tables of instances or strings.");
        end;
    else
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.");
    end;

    return function(p11, p12) -- Line: 70
        -- upvalues: u9 (ref), u10 (ref)
        local v13 = {};

        for i, v in pairs(u9) do
            local v14;

            if u10 then
                v14 = u10[i] or v;
            else
                v14 = v;
            end;

            if v:lower() == p11:lower() then
                if p12 then
                    return v14;
                end;

                table.insert(v13, 1, v14);
            elseif v:lower():find(p11:lower(), 1, true) then
                v13[#v13 + 1] = v14;
            end;
        end;

        if p12 then
            return v13[1];
        end;

        return v13;
    end;
end;

function u5.GetNames(p15) -- Line: 98
    local v16 = {};

    for i = 1, #p15 do
        v16[i] = p15[i].Name or tostring(p15[i]);
        local _ = i;
    end;

    return v16;
end;

function u5.SplitStringSimple(p17, p18) -- Line: 109
    local v19 = {};
    local v20 = 1;

    for i in string.gmatch(p17, "([^" .. (p18 == nil and "%s" or p18) .. "]+)") do
        v19[v20] = i;
        v20 = v20 + 1;
    end;

    return v19;
end;

local function charCode(p21) -- Line: 122
    return utf8.char((tonumber(p21, 16)));
end;

function u5.ParseEscapeSequences(p22) -- Line: 127
    -- upvalues: charCode (copy)
    return p22:gsub("\\(.)", {
        t = "\t",
        n = "\n"
    }):gsub("\\u(%x%x%x%x)", charCode):gsub("\\x(%x%x)", charCode);
end;

function u5.EncodeEscapedOperator(p23, p24) -- Line: 136
    local v25 = p24:sub(1, 1);
    local v26 = p24:gsub(".", "%%%1");

    return p23:gsub("(" .. ("%" .. v25) .. "+)(" .. v26 .. ")", function(p27, p28) -- Line: 141
        return (p27:sub(1, #p27 - 1) .. p28):gsub(".", function(p29) -- Line: 142
            return "\\u" .. string.format("%04x", string.byte(p29), 16);
        end);
    end);
end;

local u30 = { "&&", "||", ";" };

function u5.EncodeEscapedOperators(p31) -- Line: 149
    -- upvalues: u30 (copy), u5 (copy)
    for _, v in ipairs(u30) do
        p31 = u5.EncodeEscapedOperator(p31, v);
    end;

    return p31;
end;

local function encodeControlChars(p32) -- Line: 157
    return p32:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___");
end;

local function decodeControlChars(p33) -- Line: 167
    return p33:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
end;

function u5.SplitString(p34, p35) -- Line: 177
    -- upvalues: u5 (copy)
    local v36 = nil;
    local v37 = nil;
    local v38 = {};
    local v39 = p35 or (1 / 0);

    for i in p34:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
        local v40 = u5.ParseEscapeSequences(i);
        local v41 = v40:match("^([\'\"])");
        local v42 = v40:match("([\'\"])$");
        local v43 = v40:match("(\\*)[\'\"]$");

        if v41 and not (v36 or v42) then
            v36 = v41;
            v37 = v40;
        elseif v37 and (v42 == v36 and #v43 % 2 == 0) then
            v40 = v37 .. " " .. v40;
            v37 = nil;
            v36 = nil;
        elseif v37 then
            v37 = v37 .. " " .. v40;
        end;

        if not v37 then
            v38[#v38 + (v39 < #v38 and 0 or 1)] = v40:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
        end;
    end;

    if v37 then
        v38[#v38 + (v39 < #v38 and 0 or 1)] = v37:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
    end;

    return v38;
end;

function u5.MashExcessArguments(p44, p45) -- Line: 209
    local v46 = {};

    for i = 1, #p44 do
        local v47;

        if p45 < i then
            v46[p45] = ("%s %s"):format(v46[p45] or "", p44[i]);
            v47 = i;
        else
            v46[i] = p44[i];
            v47 = i;
        end;
    end;

    return v46;
end;

function u5.TrimString(p48) -- Line: 222
    local _, v49 = string.find(p48, "^%s*");

    return v49 == #p48 and "" or string.match(p48, ".*%S", v49 + 1);
end;

function u5.GetTextSize(p50, p51, p52) -- Line: 229
    -- upvalues: TextService (copy)
    return TextService:GetTextSize(p50, p51.TextSize, p51.Font, p52 or Vector2.new(p51.AbsoluteSize.X, 0));
end;

function u5.MakeEnumType(u53, p54) -- Line: 234
    -- upvalues: u5 (copy)
    local u55 = u5.MakeFuzzyFinder(p54);

    return {
        Validate = function(p56) -- Line: 237, Name: Validate
            -- upvalues: u55 (copy), u53 (copy)
            return u55(p56, true) ~= nil, ("Value %q is not a valid %s."):format(p56, u53);
        end,

        Autocomplete = function(p57) -- Line: 240, Name: Autocomplete
            -- upvalues: u55 (copy), u5 (ref)
            local v58 = u55(p57);

            if type(v58[1]) ~= "string" then
                v58 = u5.GetNames(v58) or v58;
            end;

            return v58;
        end,

        Parse = function(p59) -- Line: 244, Name: Parse
            -- upvalues: u55 (copy)
            return u55(p59, true);
        end
    };
end;

function u5.ParsePrefixedUnionType(p60, p61) -- Line: 251
    -- upvalues: u5 (copy)
    local v62 = u5.SplitStringSimple(p60);
    local v63 = {};

    for i = 1, #v62, 2 do
        v63[#v63 + 1] = {
            prefix = v62[i - 1] or "",
            type = v62[i]
        };
        local _ = i;
    end;

    table.sort(v63, function(p64, p65) -- Line: 265
        return #p64.prefix > #p65.prefix;
    end);

    for i = 1, #v63 do
        local v66 = v63[i];

        if p61:sub(1, #v66.prefix) == v66.prefix then
            return v66.type, p61:sub(#v66.prefix + 1), v66.prefix;
        end;

        local _ = i;
    end;
end;

function u5.MakeListableType(u67, p68) -- Line: 280
    local v69 = {
        Listable = true,
        Transform = u67.Transform,
        Validate = u67.Validate,
        ValidateOnce = u67.ValidateOnce,
        Autocomplete = u67.Autocomplete,
        Default = u67.Default,
        ArgumentOperatorAliases = u67.ArgumentOperatorAliases,

        Parse = function(...) -- Line: 289, Name: Parse
            -- upvalues: u67 (copy)
            return { u67.Parse(...) };
        end
    };

    if p68 then
        for i, v in pairs(p68) do
            v69[i] = v;
        end;
    end;

    return v69;
end;

local function encodeCommandEscape(p70) -- Line: 303
    return p70:gsub("\\%$", "___!CMDR_DOLLAR!___");
end;

local function decodeCommandEscape(p71) -- Line: 307
    return p71:gsub("___!CMDR_DOLLAR!___", "$");
end;

function u5.RunCommandString(p72, p73) -- Line: 311
    -- upvalues: u5 (copy)
    local v74 = u5.ParseEscapeSequences(p73);
    local v75 = u5.EncodeEscapedOperators(v74):split("&&");
    local v76 = "";

    for i, v in ipairs(v75) do
        local v77 = v76:gsub("%$", "\\x24"):gsub("%%", "%%%%");

        if v76:find("%s") then
            v77 = ("%q"):format(v77) or v77;
        end;

        local v78 = v:gsub("||", v77);
        local v79 = u5.RunEmbeddedCommands(p72, v78);
        v76 = tostring(p72:EvaluateAndRun(v79));

        if i == #v75 then
            return v76;
        end;
    end;
end;

function u5.RunEmbeddedCommands(p80, p81) -- Line: 338
    -- upvalues: u5 (copy)
    local v82 = p81:gsub("\\%$", "___!CMDR_DOLLAR!___");
    local v83 = {};

    for i in v82:gmatch("$(%b{})") do
        local v84 = i:sub(2, #i - 1);
        local v85;

        if v84:match("^{.+}$") then
            v84 = v84:sub(2, #v84 - 1);
            v85 = false;
        else
            v85 = true;
        end;

        v83[i] = u5.RunCommandString(p80, v84);

        if v85 and (v83[i]:find("%s") or v83[i] == "") then
            v83[i] = string.format("%q", v83[i]);
        end;
    end;

    return v82:gsub("$(%b{})", v83):gsub("___!CMDR_DOLLAR!___", "$");
end;

function u5.SubstituteArgs(p86, p87) -- Line: 366
    local v88 = p86:gsub("\\%$", "___!CMDR_DOLLAR!___");

    if type(p87) == "table" then
        for i = 1, #p87 do
            local v89 = tostring(i);
            p87[v89] = p87[i];
            local v90;

            if p87[v89]:find("%s") then
                p87[v89] = string.format("%q", p87[v89]);
                v90 = i;
            else
                v90 = i;
            end;
        end;
    end;

    return v88:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p87):gsub("___!CMDR_DOLLAR!___", "$");
end;

function u5.MakeAliasCommand(p91, p92) -- Line: 383
    -- upvalues: u5 (copy)
    local v93, v94 = unpack(p91:split("|"));
    local u95 = u5.EncodeEscapedOperators(p92);
    local v96 = {};
    local v97 = {};

    for i in u95:gmatch("$(%d+)") do
        if v96[i] == nil then
            v96[i] = true;
            local v98 = u95:match((`${i}(%b\{})`));
            local v99, v100, v101;

            if v98 then
                local v102 = v98:sub(2, #v98 - 1);
                v99, v100, v101 = unpack(v102:split("|"));
            else
                v99 = nil;
                v100 = nil;
                v101 = nil;
            end;

            local v103;

            if v99 then
                v103 = v99:match("%?$") and true or false;
            else
                v103 = v99;
            end;

            local v104 = not v99 and "string" or v99:match("^%w+");
            local v105 = v100 or `Argument {i}`;
            table.insert(v97, {
                Type = v104,
                Name = v105,
                Description = v101 or "",
                Optional = v103
            });
        end;
    end;

    return {
        Group = "UserAlias",
        Name = v93,
        Aliases = {},
        Description = `<Alias> {v94 or u95}`,
        Args = v97,

        Run = function(p106) -- Line: 422, Name: Run
            -- upvalues: u5 (ref), u95 (ref)
            return u5.RunCommandString(p106.Dispatcher, u5.SubstituteArgs(u95, p106.RawArguments));
        end
    };
end;

function u5.MakeSequenceType(p107) -- Line: 429
    -- upvalues: u5 (copy)
    local u108 = p107 or {};
    assert(u108.Parse ~= nil and true or u108.Constructor ~= nil, "MakeSequenceType: Must provide one of: Constructor, Parse");
    u108.TransformEach = u108.TransformEach or function(...) -- Line: 434
        return ...;
    end;
    u108.ValidateEach = u108.ValidateEach or function() -- Line: 438
        return true;
    end;

    return {
        Prefixes = u108.Prefixes,

        Transform = function(p109) -- Line: 445, Name: Transform
            -- upvalues: u5 (ref), u108 (ref)
            return u5.Map(u5.SplitPrioritizedDelimeter(p109, { ",", "%s" }), function(p110) -- Line: 446
                -- upvalues: u108 (ref)
                return u108.TransformEach(p110);
            end);
        end,

        Validate = function(p111) -- Line: 451, Name: Validate
            -- upvalues: u108 (ref)
            if u108.Length and #p111 > u108.Length then
                return false, ("Maximum of %d values allowed in sequence"):format(u108.Length);
            end;

            for i = 1, u108.Length or #p111 do
                local v112, v113 = u108.ValidateEach(p111[i], i);

                if not v112 then
                    return false, v113;
                end;

                local _ = i;
            end;

            return true;
        end,

        Parse = u108.Parse or function(p114) -- Line: 467
            -- upvalues: u108 (ref)
            return u108.Constructor(unpack(p114));
        end
    };
end;

function u5.SplitPrioritizedDelimeter(p115, p116) -- Line: 475
    -- upvalues: u5 (copy)
    for i, v in ipairs(p116) do
        if p115:find(v) or i == #p116 then
            return u5.SplitStringSimple(p115, v);
        end;
    end;
end;

function u5.Map(p117, p118) -- Line: 484
    local v119 = {};

    for i, v in ipairs(p117) do
        v119[i] = p118(v, i);
    end;

    return v119;
end;

function u5.Each(p120, ...) -- Line: 495
    local v121 = {};

    for i, v in ipairs({ ... }) do
        v121[i] = p120(v);
    end;

    return unpack(v121);
end;

function u5.EmulateTabstops(p122, p123) -- Line: 504
    local v124 = #p122;
    local table_create_ret = table.create(v124);
    local v125 = 0;

    for i = 1, v124 do
        local string_sub_ret = string.sub(p122, i, i);
        local v126;

        if string_sub_ret == "\t" then
            local v127 = p123 - v125 % p123;
            table.insert(table_create_ret, string.rep(" ", v127));
            v125 = v125 + v127;
            v126 = i;
        else
            table.insert(table_create_ret, string_sub_ret);

            if string_sub_ret == "\n" then
                v126 = i;
                v125 = 0;
            elseif string_sub_ret == "\r" then
                v126 = i;
            else
                v125 = v125 + 1;
                v126 = i;
            end;
        end;
    end;

    return table.concat(table_create_ret);
end;

function u5.Mutex() -- Line: 526
    local u128 = {};
    local u129 = false;

    return function() -- Line: 530
        -- upvalues: u129 (ref), u128 (copy)
        if u129 then
            table.insert(u128, coroutine.running());
            coroutine.yield();
        else
            u129 = true;
        end;

        return function() -- Line: 538
            -- upvalues: u128 (ref), u129 (ref)
            if #u128 > 0 then
                coroutine.resume(table.remove(u128, 1));

                return;
            end;

            u129 = false;
        end;
    end;
end;

return u5;