-- Decompiled with Potassium's decompiler.

return {
    Comma = function(p1) -- Line: 2, Name: Comma
        local v2;

        repeat
            p1, v2 = string.gsub(p1, "^(-?%d+)(%d%d%d)", "%1,%2");
        until v2 == 0;

        return p1;
    end
};