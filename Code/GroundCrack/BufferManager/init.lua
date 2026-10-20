-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    return setmetatable({
        pool = {},
        createFunc = p2
    }, u1);
end;

function u1.get(p3) -- Line: 13
    if #p3.pool > 0 then
        return table.remove(p3.pool);
    end;

    return p3.createFunc();
end;

function u1.release(p4, p5) -- Line: 21
    table.insert(p4.pool, p5);
    p5.Parent = script.Cache;
end;

return u1;