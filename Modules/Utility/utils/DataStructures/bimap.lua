-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.map1 = {};
    v3.map2 = {};

    if p2 then
        for i, v in pairs(p2) do
            v3:registerPair(i, v);
        end;
    end;

    return v3;
end;

function u1.registerPair(p4, p5, p6) -- Line: 19
    p4:remove(p5);
    p4:remove(p6);
    p4.map1[p5] = p6;
    p4.map2[p6] = p5;
end;

function u1.clear(p7) -- Line: 26
    table.clear(p7.map1);
    table.clear(p7.map2);
end;

function u1.remove(p8, p9) -- Line: 31
    if not p8.map1[p9] then
        if p8.map2[p9] then
            local v10 = p8.map2[p9];
            p8.map2[p9] = nil;
            p8.map1[v10] = nil;
        end;

        return;
    end;

    local v11 = p8.map1[p9];
    p8.map1[p9] = nil;
    p8.map2[v11] = nil;
end;

function u1.getValue(p12, p13) -- Line: 43
    return p12.map1[p13] or p12.map2[p13];
end;

return u1;