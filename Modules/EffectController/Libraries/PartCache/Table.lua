-- Decompiled with Potassium's decompiler.

local Random_new_ret = Random.new();
local table_clone_ret = table.clone(table);

for i, v in table do
    table_clone_ret[i] = v;
end;

function table_clone_ret.contains(p1, p2) -- Line: 30
    -- upvalues: table_clone_ret (copy)
    return table_clone_ret.indexOf(p1, p2) ~= nil;
end;

function table_clone_ret.indexOf(p3, p4) -- Line: 35
    -- upvalues: table_clone_ret (copy)
    return table.find(p3, p4) or table_clone_ret.keyOf(p3, p4);
end;

function table_clone_ret.keyOf(p5, p6) -- Line: 44
    for i, v in pairs(p5) do
        if v == p6 then
            return i;
        end;
    end;

    return nil;
end;

function table_clone_ret.skip(p7, p8) -- Line: 54
    return table.move(p7, p8 + 1, #p7, 1, table.create(#p7 - p8));
end;

function table_clone_ret.take(p9, p10) -- Line: 59
    return table.move(p9, 1, p10, 1, table.create(p10));
end;

function table_clone_ret.range(p11, p12, p13) -- Line: 64
    return table.move(p11, p12, p13, 1, table.create(p13 - p12 + 1));
end;

function table_clone_ret.skipAndTake(p14, p15, p16) -- Line: 69
    return table.move(p14, p15 + 1, p15 + p16, 1, table.create(p16));
end;

function table_clone_ret.random(p17) -- Line: 74
    -- upvalues: Random_new_ret (copy)
    return p17[Random_new_ret:NextInteger(1, #p17)];
end;

function table_clone_ret.join(p18, p19) -- Line: 79
    local table_create_ret = table.create(#p18 + #p19);

    return table.move(p19, 1, #p19, #p18 + 1, table_create_ret);
end;

function table_clone_ret.removeObject(p20, p21) -- Line: 85
    -- upvalues: table_clone_ret (copy)
    local v22 = table_clone_ret.indexOf(p20, p21);

    if v22 then
        table.remove(p20, v22);
    end;
end;

function table_clone_ret.expand(p23, p24) -- Line: 94
    if p24 < 0 then
        error("Cannot expand a table by a negative amount of objects.");
    end;

    local table_create_ret = table.create(#p23 + p24);

    for i = 1, #p23 do
        table_create_ret[i] = p23[i];
        local _ = i;
    end;

    return table_create_ret;
end;

return table_clone_ret;