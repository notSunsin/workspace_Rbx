-- Decompiled with Potassium's decompiler.

return function(p1: buffer, p2: buffer) -- Line: 20, Name: CompareBuffer
    local buffer_len_ret = buffer.len(p1);
    local buffer_len_ret2 = buffer.len(p2);

    for i = 0, math.min(buffer_len_ret, buffer_len_ret2) - 1 do
        local buffer_readu8_ret = buffer.readu8(p1, i);
        local buffer_readu8_ret2 = buffer.readu8(p2, i);

        if buffer_readu8_ret ~= buffer_readu8_ret2 then
            return buffer_readu8_ret - buffer_readu8_ret2;
        end;

        local _ = i;
    end;

    return buffer_len_ret - buffer_len_ret2;
end;