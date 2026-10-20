-- Decompiled with Potassium's decompiler.

local u1 = {
    Corn = "Corn",
    Cacao = "Cacao",
    Cactus = "Cacti",
    Bamboo = "Bamboo",
    Tomato = "Tomatoes"
};

return function(p2: string) -- Line: 10, Name: pluralize
    -- upvalues: u1 (copy)
    if not p2 then
        return "";
    end;

    local string_lower_ret = string.lower(p2);

    for i, v in pairs(u1) do
        if string.lower(i) == string_lower_ret then
            if string.sub(p2, 1, 1):match("%u") then
                return v:gsub("^%l", string.upper);
            end;

            return v:lower();
        end;
    end;

    if string.match(p2, "[^aeiou]y$") then
        return string.sub(p2, 1, -2) .. "ies";
    end;

    if string.match(p2, "[sxz]$") or (string.match(p2, "ch$") or string.match(p2, "sh$")) then
        return p2 .. "es";
    end;

    return p2 .. "s";
end;