-- Decompiled with Potassium's decompiler.

local function u3(p1, p2) -- Line: 2
    return p2 < p1;
end;

return function(p4: table, p5: function?) -- Line: 6
    -- upvalues: u3 (copy)
    if p5 == nil then
        p5 = u3;
    end;

    local v6 = nil;
    local v7 = nil;

    for i, v in p4 do
        if v6 == nil or p5(v6, v) == false then
            v7 = i;
            v6 = v;
        end;
    end;

    return v6, v7;
end;