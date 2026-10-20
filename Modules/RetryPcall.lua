-- Decompiled with Potassium's decompiler.

return function(p1: number, p2: number?, p3: any, ...) -- Line: 7
    local v4 = { false };
    local v5 = p2 or 1;

    for i = 1, p1 do
        v4 = { pcall(p3, ...) };

        if v4[1] then
            break;
        end;

        local v6 = v5 * 0.1 * math.random();
        task.wait(v5 + v6);
        v5 = math.min(v5 * 1.5, 120);
        local _ = i;
    end;

    return table.unpack(v4);
end;