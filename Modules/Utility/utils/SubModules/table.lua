-- Decompiled with Potassium's decompiler.

return {
    merge = function(p1, p2) -- Line: 3, Name: merge
        local v3 = {};

        for _, v in ipairs(p1) do
            table.insert(v3, v);
        end;

        for _, v in ipairs(p2) do
            table.insert(v3, v);
        end;

        return v3;
    end,

    shuffle = function(p4) -- Line: 14, Name: shuffle
        for i = #p4, 2, -1 do
            local math_random_ret = math.random(i);
            local v5 = p4[i];
            p4[i] = p4[math_random_ret];
            p4[math_random_ret] = v5;
            local _ = i;
        end;

        return p4;
    end
};