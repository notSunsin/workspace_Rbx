-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = {
        Guessed = true,
        Count = p2,
        Slots = table.create(p2, 0)
    };

    return setmetatable(v3, u1);
end;

function u1.Add(p4, p5) -- Line: 10
    if not p4.Guessed then
        return;
    end;

    for i = 1, p4.Count do
        if p4.Slots[i] == 0 then
            p4.Slots[i] = p5;

            return;
        end;

        local _ = i;
    end;
end;

function u1.Remove(p6, p7) -- Line: 17
    for i = 1, p6.Count do
        local v8;

        if p6.Slots[i] == p7 then
            p6.Slots[i] = p6.Guessed and 0 or -1;
            v8 = i;
        else
            v8 = i;
        end;
    end;
end;

function u1.Invalidate(p9) -- Line: 25
    p9.Guessed = false;

    for i = 1, p9.Count do
        p9.Slots[i] = -1;
        local _ = i;
    end;
end;

function u1.Recover(p10, p11, p12) -- Line: 30
    if p11 < 1 or p10.Count < p11 then
        return;
    end;

    if p10.Guessed and p10.Slots[p11] ~= p12 then
        p10:Invalidate();
    end;

    p10:Remove(p12);
    p10.Slots[p11] = p12;
end;

return u1;