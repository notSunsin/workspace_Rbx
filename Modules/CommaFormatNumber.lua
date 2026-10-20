-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1, Name: CommaFormatNumber
    return tostring(p1):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
end;