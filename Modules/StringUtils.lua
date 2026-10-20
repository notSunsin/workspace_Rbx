-- Decompiled with Potassium's decompiler.

local u1 = {
    a = true,
    e = true,
    i = true,
    o = true,
    u = true
};
local u4 = {
    StipFlavourText = function(p2: table, p3: string) -- Line: 13, Name: StipFlavourText
        if p3 and p3 ~= "" then
            return p3:gsub("%b[]", ""):gsub("^%s*(.-)%s*$", "%1");
        end;

        warn("StringUtils:StipFlavourText | No item name passed!");

        return "";
    end
};

function u4.FormatGearName(p5: table, p6: string) -- Line: 25
    -- upvalues: u4 (copy)
    if p6 and p6 ~= "" then
        return u4:StipFlavourText(p6):gsub("(%l)(%u)", "%1 %2"):gsub("(%a)(%d)", "%1 %2"):gsub("(%d)(%a)", "%1 %2"):gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1");
    end;

    warn("StringUtils:FormatGearName | No gear name passed!");

    return "";
end;

function u4.Pluralize(p7: table, p8: string) -- Line: 41
    if string.match(p8, "[^aeiou]y$") then
        return string.sub(p8, 1, -2) .. "ies";
    end;

    if string.match(p8, "(s|x|z)$") or (string.match(p8, "ch$") or string.match(p8, "sh$")) then
        return p8 .. "es";
    end;

    return p8 .. "s";
end;

function u4.TryPluralize(p9: table, p10: string, p11: number) -- Line: 56
    -- upvalues: u4 (copy)
    if p11 == 1 then
        return p10;
    end;

    return u4:Pluralize(p10);
end;

function u4.NormalizeRecipeName(p12: table, p13: string) -- Line: 64
    local string_find_ret = string.find(p13, "@");

    if string_find_ret then
        return string.sub(p13, 1, string_find_ret - 1);
    end;

    return p13;
end;

function u4.SplitWordWithSpace(p14: table, p15: string) -- Line: 72
    if #string.split(p15, " ") > 1 then
        return p15;
    end;

    return p15:gsub("(%u%l*)", function(p16) -- Line: 78
        return p16 .. " ";
    end):match("^%s*(.-)%s*$");
end;

function u4.IsAn(p17: table, p18: string) -- Line: 83
    -- upvalues: u1 (copy)
    return #p18 < 1 and "a" or (u1[p18:lower():sub(1, 1)] and "an" or "a");
end;

return u4;