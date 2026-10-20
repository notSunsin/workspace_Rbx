-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 2
    return p1 and (typeof(p1) == "table" and typeof(p1.equals) == "function") and true or false;
end;