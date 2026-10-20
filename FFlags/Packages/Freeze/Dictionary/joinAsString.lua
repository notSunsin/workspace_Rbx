-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: string?) -- Line: 15, Name: joinAsString
    local v3 = {};

    for i, v in p1 do
        local string_format = string.format;
        local v4 = tostring(i);
        local v5 = tostring(v);
        table.insert(v3, string_format("%s=%s", v4, v5));
    end;

    return table.concat(v3, p2 or ",");
end;