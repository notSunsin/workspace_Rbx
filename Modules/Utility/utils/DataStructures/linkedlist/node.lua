-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 4
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5.value = p2;
    v5.prev = p3;
    v5.next = p4;

    return v5;
end;

return u1;