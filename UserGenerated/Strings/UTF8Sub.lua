-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: number, p3: number?) -- Line: 20, Name: UTF8Sub
    local v4 = p3 or -1;
    local utf8_offset_ret = utf8.offset(p1, p2);

    if not utf8_offset_ret then
        if p2 > 0 then
            return "";
        end;

        utf8_offset_ret = 1;
    end;

    local v5;

    if v4 == -1 then
        v5 = #p1;
    else
        local utf8_offset_ret2 = utf8.offset(p1, v4 + 1);

        if utf8_offset_ret2 then
            v5 = utf8_offset_ret2 - 1;
        else
            v5 = v4 < 0 and 0 or #p1;
        end;
    end;

    return string.sub(p1, utf8_offset_ret, v5);
end;