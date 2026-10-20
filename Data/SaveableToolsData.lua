-- Decompiled with Potassium's decompiler.

local u1 = {
    DefaultData = {
        Trowel = {
            Uses = 5
        },
        ["Watering Can"] = {
            Uses = 10
        },
        ["Lightning Rod"] = {},
        Sprinkler = {}
    }
};

function u1.GetDefaultData(p2: table, p3: string) -- Line: 36
    -- upvalues: u1 (copy)
    return u1.DefaultData[p3] or nil;
end;

return u1;