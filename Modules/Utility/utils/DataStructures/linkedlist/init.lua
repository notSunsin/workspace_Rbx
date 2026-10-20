-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local script_node = require(script.node);

function u1.new(p2: table) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.first = nil;
    v3.last = nil;
    v3.length = 0;
    v3.Changed = Instance.new("BindableEvent");

    if p2 then
        for _, v in pairs(p2) do
            v3:appendEnd(v);
        end;
    end;

    return v3;
end;

function u1.toList(p4, p5) -- Line: 22
    local v6 = p4[p5 and "last" or "first"];
    local v7 = {};
    local v8 = p5 and "prev" or "next";

    while v6 do
        table.insert(v7, v6.value);
        v6 = v6[v8];
    end;

    return v7;
end;

function u1.appendEnd(p9, p10) -- Line: 36
    -- upvalues: script_node (copy)
    if p9.first then
        local v11 = script_node.new(p10, p9.last, nil);
        p9.last.next = v11;
        p9.last = v11;
    else
        local v12 = script_node.new(p10, nil, nil);
        p9.first = v12;
        p9.last = v12;
    end;

    p9.length = p9.length + 1;
    p9.Changed:Fire();

    return p9.last;
end;

function u1.peekStart(p13) -- Line: 51
    if p13.first then
        return p13.first.value;
    end;

    return nil;
end;

function u1.peekEnd(p14) -- Line: 58
    if p14.last then
        return p14.last.value;
    end;

    return nil;
end;

function u1.appendStart(p15, p16) -- Line: 65
    -- upvalues: script_node (copy)
    if p15.first then
        local v17 = script_node.new(p16, nil, p15.first);
        p15.first.prev = v17;
        p15.first = v17;
    else
        local v18 = script_node.new(p16, nil, nil);
        p15.first = v18;
        p15.last = v18;
    end;

    p15.length = p15.length + 1;
    p15.Changed:Fire();

    return p15.first;
end;

function u1.popStart(p19) -- Line: 80
    if not p19.first then
        return nil;
    end;

    local value = p19.first.value;

    if p19.first == p19.last then
        p19.first = nil;
        p19.last = nil;
    else
        p19.first = p19.first.next;
        p19.first.prev = nil;
    end;

    p19.length = p19.length - 1;
    p19.Changed:Fire();

    return value;
end;

function u1.popEnd(p20) -- Line: 97
    if not p20.last then
        return nil;
    end;

    local value = p20.last.value;

    if p20.last == p20.first then
        p20.first = nil;
        p20.last = nil;
    else
        p20.last = p20.last.prev;
        p20.last.next = nil;
    end;

    p20.length = p20.length - 1;
    p20.Changed:Fire();

    return value;
end;

function u1.removeNode(p21, p22) -- Line: 114
    if not p22 then
        return;
    end;

    if p22 == p21.first and p22 == p21.last then
        p21.first = nil;
        p21.last = nil;
    elseif p22 == p21.first then
        p21.first = p21.first.next;

        if p21.first then
            p21.first.prev = nil;
        end;
    elseif p22 == p21.last then
        p21.last = p21.last.prev;

        if p21.last then
            p21.last.next = nil;
        end;
    else
        p22.prev.next = p22.next;
        p22.next.prev = p22.prev;
    end;

    p21.length = p21.length - 1;
    p21.Changed:Fire();
end;

function u1.removeByValue(p23, p24) -- Line: 139
    local first = p23.first;

    while first do
        if first.value == p24 then
            p23:removeNode(first);

            return;
        end;

        first = first.next;
    end;
end;

function u1.findPosition(p25, p26) -- Line: 151
    local first = p25.first;
    local v27 = 1;

    while first do
        if first.value == p26 then
            return v27;
        end;

        first = first.next;
        v27 = v27 + 1;
    end;

    return nil;
end;

function u1.filter(p28: table, p29: function, p30: boolean) -- Line: 164
    local first = p28.first;
    local v31 = {};

    while first do
        local next = first.next;

        if p29(first.value) then
            table.insert(v31, first.value);

            if p30 then
                p28:removeNode(first);
                first = next;
            else
                first = next;
            end;
        else
            first = next;
        end;
    end;

    return v31;
end;

function u1.__len(p32) -- Line: 182
    return p32.length;
end;

function u1.clear(p33) -- Line: 186
    p33.first = nil;
    p33.last = nil;
    p33.length = 0;
    p33.Changed:Fire();
end;

return u1;