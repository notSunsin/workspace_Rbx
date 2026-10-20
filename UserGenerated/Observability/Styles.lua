-- Decompiled with Potassium's decompiler.

local _, v1 = xpcall(function() -- Line: 42
    return workspace[nil];
end, function() -- Line: 44
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 48
    return p2[p3];
end or v1;
local v5 = {};
local u6 = setmetatable({}, {
    __mode = "k"
});
v5.Affected = u6;
local u7 = {
    BackgroundColor = "BackgroundColor3",
    BorderColor = "BorderColor3",
    TextColor = "TextColor3",
    Font = "FontFace"
};

function v5.Read(p8: userdata, p9: string) -- Line: 70
    -- upvalues: u6 (copy), u4 (ref)
    local v10 = u6[p8];

    if v10 and v10[p9] then
        return pcall(p8.GetStyled, p8, p9);
    end;

    return pcall(u4, p8, p9);
end;

function v5.Get(p11: userdata, p12: string) -- Line: 79
    -- upvalues: u6 (copy), u4 (ref)
    local v13 = u6[p11];

    if v13 and v13[p12] then
        local success, result = pcall(p11.GetStyled, p11, p12);

        if success then
            return result;
        end;
    end;

    return u4(p11, p12);
end;

local function recordedName(p14: userdata, p15: string, p16: table?) -- Line: 92
    -- upvalues: u7 (copy)
    if not p16 then
        return nil;
    end;

    local v17 = u7[p15];

    if v17 then
        p15 = v17;
    elseif p15 == "Transparency" and p14:IsA("GuiObject") then
        p15 = "BackgroundTransparency";
    elseif #p15 > 7 and string.sub(p15, -7) == "Content" then
        p15 = string.sub(p15, 1, -8);
    end;

    if p16[p15] then
        return p15;
    end;

    return nil;
end;

local function runnable(p18: string) -- Line: 111
    if string.find(p18, "::", 1, true) then
        return nil;
    end;

    local u19 = {};
    local u20 = {};
    local u21 = false;

    local function endCompound() -- Line: 118
        -- upvalues: u20 (copy), u19 (copy), u21 (ref)
        if #u20 > 0 then
            table.insert(u19, table.concat(u20, " "));
        elseif u21 then
            table.insert(u19, "GuiObject");
        end;

        table.clear(u20);
        u21 = false;
    end;

    local v22 = 1;

    while v22 <= #p18 do
        local string_sub_ret = string.sub(p18, v22, v22);

        if string.match(string_sub_ret, "%s") then
            v22 = v22 + 1;
        elseif string_sub_ret == ">" then
            if #u20 > 0 then
                table.insert(u19, table.concat(u20, " "));
            elseif u21 then
                table.insert(u19, "GuiObject");
            end;

            table.clear(u20);
            u21 = false;

            if string.sub(p18, v22 + 1, v22 + 1) == ">" then
                table.insert(u19, ">>");
                v22 = v22 + 2;
            else
                table.insert(u19, ">");
                v22 = v22 + 1;
            end;
        elseif string_sub_ret == ":" or string_sub_ret == "@" then
            v22 = v22 + (#string.match(p18, "^[%w_%-]*", v22 + 1) + 1);
            u21 = true;
        elseif string_sub_ret == "." or string_sub_ret == "#" then
            local string_match_ret = string.match(p18, "^[%w_%-]*", v22 + 1);
            table.insert(u20, string_sub_ret .. string_match_ret);
            v22 = v22 + (#string_match_ret + 1);
        else
            local string_match_ret = string.match(p18, "^[%w_%-]+", v22);

            if not string_match_ret then
                return p18;
            end;

            table.insert(u20, string_match_ret);
            v22 = v22 + #string_match_ret;
        end;
    end;

    if #u20 > 0 then
        table.insert(u19, table.concat(u20, " "));
    elseif u21 then
        table.insert(u19, "GuiObject");
    end;

    table.clear(u20);
    u21 = false;

    return table.concat(u19, " ");
end;

local function list(p23: string) -- Line: 165
    local v24 = {};

    for i in string.gmatch(p23, "[^,]+") do
        local string_match_ret = string.match(i, "^%s*(.-)%s*$");

        if string_match_ret ~= "" then
            table.insert(v24, string_match_ret);
        end;
    end;

    return v24;
end;

local function collect(p25: userdata, p26: table?, p27: table) -- Line: 180
    -- upvalues: list (copy), collect (copy)
    for _, child in p25:GetChildren() do
        if child:IsA("StyleRule") then
            local v28 = list(child.Selector);
            local v29 = {};
            local v30;

            if p26 then
                v30 = child;

                for _, v in p26 do
                    local v31 = v;

                    for _, v2 in v28 do
                        table.insert(v29, v31 .. " " .. v2);
                    end;
                end;
            else
                v29 = v28;
                v30 = child;
            end;

            table.insert(p27, {
                Rule = v30,
                Selectors = v29
            });
            collect(v30, v29, p27);
        elseif child:IsA("Folder") then
            collect(child, p26, p27);
        end;
    end;
end;

local function sheetRules(p32: userdata, p33: table, p34: table) -- Line: 203
    -- upvalues: sheetRules (copy), collect (copy)
    if p33[p32] then
        return;
    end;

    p33[p32] = true;

    for _, child in p32:GetChildren() do
        if child:IsA("StyleDerive") then
            local StyleSheet = child.StyleSheet;

            if StyleSheet then
                sheetRules(StyleSheet, p33, p34);
            end;
        end;
    end;

    collect(p32, nil, p34);
end;

local function linksIn(p35: userdata) -- Line: 219
    local success, result = pcall(p35.QueryDescendants, p35, "StyleLink");

    if success then
        return result;
    end;

    local v36 = {};

    for _, descendant in p35:GetDescendants() do
        if descendant:IsA("StyleLink") then
            table.insert(v36, descendant);
        end;
    end;

    return v36;
end;

local function markNames(p37: userdata, p38: table, p39: table) -- Line: 235
    -- upvalues: u4 (ref), u6 (copy), recordedName (copy)
    local v40 = p39[u4(p37, "ClassName")];
    local v41 = u6[p37];
    local v42 = false;

    for _, v in p38 do
        local v43 = recordedName(p37, v, v40);

        if v43 and not (v41 and v41[v43]) then
            if not v41 then
                v41 = {};
                u6[p37] = v41;
            end;

            v41[v43] = true;
            v42 = true;
        end;
    end;

    return v42;
end;

function v5.Build(p44: table, u45: table) -- Line: 260
    -- upvalues: u6 (copy), markNames (copy), linksIn (copy), sheetRules (copy), runnable (copy)
    table.clear(u6);

    local function mark(p46: userdata, p47: table) -- Line: 262
        -- upvalues: markNames (ref), u45 (copy)
        markNames(p46, p47, u45);
    end;

    for _, v in p44 do
        for _, v2 in linksIn(v) do
            local StyleSheet = v2.StyleSheet;
            local Parent = v2.Parent;

            if StyleSheet and Parent then
                local v48 = {};
                sheetRules(StyleSheet, {}, v48);
                local v49 = Parent:IsA("GuiObject");

                for _, v3 in v48 do
                    local success, result = pcall(v3.Rule.GetProperties, v3.Rule);

                    if success and (type(result) == "table" and next(result) ~= nil) then
                        local v50 = v3;
                        local v51 = {};

                        for i in result do
                            table.insert(v51, i);
                        end;

                        if v49 then
                            markNames(Parent, v51, u45);
                        end;

                        for _, v4 in v50.Selectors do
                            local v52 = runnable(v4);

                            if v52 and v52 ~= "" then
                                local success2, result2 = pcall(Parent.QueryDescendants, Parent, v52);

                                if success2 then
                                    for _, v6 in result2 do
                                        markNames(v6, v51, u45);
                                    end;
                                else
                                    warn((`[UGUIReplay] style rule {v50.Rule:GetFullName()} not recorded: {result2}`));
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function chain(p53: string) -- Line: 317
    local v54 = {};

    for i in string.gmatch(p53 .. ">", "([^>]*)>") do
        local string_match_ret = string.match(i, "^%s*(.-)%s*$");

        if string_match_ret == "" or not string.match(string_match_ret, "^[%w_%-#%.]+$") then
            return nil;
        end;

        local v55 = {};

        for i2 in string.gmatch(string_match_ret, "[#%.]?[%w_%-]+") do
            table.insert(v55, i2);
        end;

        table.insert(v54, v55);
    end;

    if #v54 > 0 then
        return v54;
    end;

    return nil;
end;

local function ruleNames(p56: userdata) -- Line: 333
    local v57 = {};
    local success, result = pcall(p56.GetProperties, p56);

    if success and type(result) == "table" then
        for i in result do
            table.insert(v57, i);
        end;
    end;

    return v57;
end;

function v5.Richer(p58: userdata) -- Line: 347
    -- upvalues: sheetRules (copy), chain (copy)
    local StyleSheet = p58.StyleSheet;

    if not StyleSheet then
        return nil, {};
    end;

    local v59 = {};
    sheetRules(StyleSheet, {}, v59);
    local v60 = {};
    local v61 = 0;
    local v62 = {};
    local v63 = false;

    for _, v in v59 do
        table.insert(v60, v.Rule);
        v63 = string.gsub(v.Rule.Selector, "%s", "") == "TextLabel>TextLabel" and true or v63;
        local v64 = v;
        local v65 = {};

        for _, v2 in v.Selectors do
            local v66 = chain(v2);

            if v66 then
                table.insert(v65, v66);
                v61 = math.max(v61, #v66 - 1);
            end;
        end;

        if #v65 > 0 then
            table.insert(v62, {
                Rule = v64.Rule,
                Paths = v65
            });
        end;
    end;

    if v63 then
        return {
            Rules = v62,
            Depth = v61
        }, v60;
    end;

    return nil, v60;
end;

local function compoundMatches(p67: userdata, p68: table) -- Line: 381
    -- upvalues: u4 (ref)
    for _, v in p68 do
        local string_sub_ret = string.sub(v, 1, 1);

        if string_sub_ret == "#" then
            if u4(p67, "Name") ~= string.sub(v, 2) then
                return false;
            end;
        elseif string_sub_ret == "." then
            if not p67:HasTag((string.sub(v, 2))) then
                return false;
            end;
        elseif not p67:IsA(v) then
            return false;
        end;
    end;

    return true;
end;

local function pathMatches(p69: userdata, p70: userdata, p71: table) -- Line: 400
    -- upvalues: compoundMatches (copy), u4 (ref)
    for i = #p71, 2, -1 do
        if not (p69 and compoundMatches(p69, p71[i])) then
            return false;
        end;

        p69 = u4(p69, "Parent");
        local _ = i;
    end;

    local v72;

    if p69 == p70 then
        v72 = compoundMatches(p70, p71[1]);
    else
        v72 = false;
    end;

    return v72;
end;

function v5.MarkRicher(p73: userdata, p74: userdata, p75: table, p76: table) -- Line: 417
    -- upvalues: pathMatches (copy), u6 (copy), markNames (copy), ruleNames (copy)
    local v77 = false;

    for _, v in p75.Rules do
        local v78 = v;

        for _, v2 in v.Paths do
            if pathMatches(p73, p74, v2) then
                if not u6[p73] then
                    u6[p73] = {};
                    v77 = true;
                end;

                if markNames(p73, ruleNames(v78.Rule), p76) then
                    v77 = true;
                end;

                break;
            end;
        end;
    end;

    return v77;
end;

function v5.Clear() -- Line: 441
    -- upvalues: u6 (copy)
    table.clear(u6);
end;

return table.freeze(v5);