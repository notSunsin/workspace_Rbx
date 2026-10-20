-- Decompiled with Potassium's decompiler.

local Random_new_ret = Random.new();
local u1 = {};

return function(p2: table, p3: boolean?, p4: string?) -- Line: 4, Name: chooseWeighted
    -- upvalues: u1 (copy), Random_new_ret (copy)
    local v5;

    if p3 then
        v5 = u1[p2];
    else
        v5 = p3;
    end;

    if not v5 then
        v5 = 0;

        for _, v in pairs(p2) do
            local v6;

            if p4 == nil then
                v6 = v;
            else
                v6 = v[p4];
            end;

            v5 = v5 + v6;
        end;

        if p3 then
            u1[p2] = v5;
        end;
    end;

    local v7 = Random_new_ret:NextNumber(0, v5);
    local v8 = 0;

    for i, v in pairs(p2) do
        local v9;

        if p4 == nil then
            v9 = v;
        else
            v9 = v[p4];
        end;

        v8 = v8 + v9;

        if v7 <= v8 then
            return i;
        end;
    end;

    return nil;
end;