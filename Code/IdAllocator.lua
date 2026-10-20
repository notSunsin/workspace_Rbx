-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 4
    -- upvalues: u1 (copy)
    return setmetatable({
        MaxID = 65535,
        InUse = {}
    }, u1);
end;

function u1.Allocate(p2) -- Line: 11
    for i = 0, p2.MaxID do
        if not p2.InUse[i] then
            p2.InUse[i] = true;

            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.Release(p3, p4) -- Line: 21
    if p3.InUse[p4] then
        p3.InUse[p4] = nil;
    end;
end;

return u1;