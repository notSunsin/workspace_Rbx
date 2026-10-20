-- Decompiled with Potassium's decompiler.

return {
    dict = function(p1: any, p2: userdata?) -- Line: 3, Name: dict
        local v3 = 0;

        for _, v in p1 do
            v3 = v3 + v;
        end;

        local v4 = (p2 or Random.new()):NextNumber(0, v3);
        local v5 = 0;

        for i, v in p1 do
            v5 = v5 + v;

            if v4 <= v5 then
                return i;
            end;
        end;

        return nil;
    end,

    array = function(p6: table, p7: userdata?) -- Line: 22, Name: array
        local v8 = 0;

        for _, v in p6 do
            v8 = v8 + v.Chance;
        end;

        local v9 = (p7 or Random.new()):NextNumber(0, v8);
        local v10 = 0;

        for i, v in p6 do
            v10 = v10 + v.Chance;

            if v9 <= v10 then
                return v, i;
            end;
        end;

        return nil, nil;
    end
};