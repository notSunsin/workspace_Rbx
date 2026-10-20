-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: string?) -- Line: 15, Name: joinAsString
    return table.concat(p1, p2 or ",");
end;