-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2: table?) -- Line: 31
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.values = {};
    v3.list = {};
    v3.indexMapping = {};
    v3.length = 0;
    v3.Changed = Instance.new("BindableEvent");

    if p2 then
        for _, v in ipairs(p2) do
            v3:add(v);
        end;
    end;

    return v3;
end;

function u1.add(p4, p5) -- Line: 50
    if p5 == nil or p4.values[p5] then
        return;
    end;

    p4.values[p5] = true;
    p4.length = p4.length + 1;
    table.insert(p4.list, p5);
    p4.indexMapping[p5] = #p4.list;
    p4.Changed:Fire();
end;

function u1.remove(p6, p7) -- Line: 62
    if not p6.values[p7] then
        return;
    end;

    p6.values[p7] = nil;
    p6.length = p6.length - 1;
    local v8 = p6.indexMapping[p7];
    p6.list[v8] = p6.list[#p6.list];
    p6.indexMapping[p7] = nil;
    p6.indexMapping[p6.list[v8]] = v8;
    table.remove(p6.list, #p6.list);

    if p6.length == 0 then
        p6.indexMapping = {};
    end;

    p6.Changed:Fire();
end;

function u1.contains(p9, p10) -- Line: 80
    return p9.values[p10] ~= nil;
end;

function u1.__eq(p11: table, p12: table) -- Line: 85
    for i, _ in pairs(p11.values) do
        if not p12:contains(i) then
            return false;
        end;
    end;

    for i, _ in pairs(p12.values) do
        if not p11:contains(i) then
            return false;
        end;
    end;

    return true;
end;

function u1.tolist(p13) -- Line: 100
    local v14 = {};

    for i, _ in pairs(p13.values) do
        table.insert(v14, i);
    end;

    return v14;
end;

function u1.toList(p15) -- Line: 109
    return p15:tolist();
end;

function u1.getRandom(p16) -- Line: 114
    if #p16.list < 1 then
        return nil;
    end;

    return p16.list[math.random(1, #p16.list)];
end;

function u1.getRandomSubset(p17: table, p18: number) -- Line: 122
    -- upvalues: u1 (copy)
    if p17.length < p18 then
        error("Requested subset size is greater than the size of the set");
    end;

    local v19 = {};

    for i = 1, #p17.list do
        table.insert(v19, i);
        local _ = i;
    end;

    for i = #v19, 2, -1 do
        local math_random_ret = math.random(1, i);
        local v20 = v19[i];
        v19[i] = v19[math_random_ret];
        v19[math_random_ret] = v20;
        local _ = i;
    end;

    local v21 = u1.new();

    for i = 1, p18 do
        v21:add(p17.list[v19[i]]);
        local _ = i;
    end;

    return v21;
end;

function u1.popRandom(p22: table, p23: userdata?) -- Line: 146
    local v24;

    if p23 then
        v24 = p23:NextInteger(1, #p22.list);
    else
        v24 = math.random(1, #p22.list);
    end;

    local v25 = p22.list[v24];
    p22:remove(v25);

    return v25;
end;

function u1.__add(p26: table, p27: table) -- Line: 159
    local v28 = p26:clone();

    for i, _ in pairs(p27.values) do
        v28:add(i);
    end;

    return v28;
end;

function u1.__sub(p29: table, p30: table) -- Line: 167
    -- upvalues: u1 (copy)
    local v31 = u1.new();

    for i, _ in pairs(p29.values) do
        if not p30:contains(i) then
            v31:add(i);
        end;
    end;

    return v31;
end;

function u1.clone(p32) -- Line: 178
    -- upvalues: u1 (copy)
    local v33 = u1.new();

    for i, _ in pairs(p32.values) do
        v33:add(i);
    end;

    return v33;
end;

function u1.__len(p34) -- Line: 186
    return p34.length;
end;

function u1.intersection(p35: table, p36: table) -- Line: 191
    -- upvalues: u1 (copy)
    local v37 = u1.new();

    for i, _ in pairs(p36.values) do
        if p35:contains(i) then
            v37:add(i);
        end;
    end;

    return v37;
end;

function u1.xor(p38: table, p39: table) -- Line: 202
    -- upvalues: u1 (copy)
    local v40 = u1.new();

    for i, _ in pairs(p38.values) do
        if not p39:contains(i) then
            v40:add(i);
        end;
    end;

    for i, _ in pairs(p39.values) do
        if not p38:contains(i) then
            v40:add(i);
        end;
    end;

    return v40;
end;

function u1.clear(p41) -- Line: 219
    p41.values = {};
    p41.length = 0;
    p41.list = {};
    p41.indexMapping = {};
    p41.Changed:Fire();
end;

return u1;