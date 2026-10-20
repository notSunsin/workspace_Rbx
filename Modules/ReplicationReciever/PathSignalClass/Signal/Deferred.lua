-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;

function u1.new() -- Line: 50
    -- upvalues: u1 (copy)
    return setmetatable({
        _active = true,
        _head = nil
    }, u1);
end;

function u1.Is(p3) -- Line: 71
    -- upvalues: u1 (copy)
    local v4;

    if typeof(p3) == "table" then
        v4 = getmetatable(p3) == u1;
    else
        v4 = false;
    end;

    return v4;
end;

function u1.IsActive(p5) -- Line: 87
    return p5._active == true;
end;

function u1.Connect(p6: table, p7: function) -- Line: 108
    -- upvalues: u2 (copy)
    local v8 = typeof(p7) == "function";
    assert(v8, "Must be function");

    if p6._active ~= true then
        return setmetatable({
            Connected = false,
            _node = nil
        }, u2);
    end;

    local _head = p6._head;
    local v9 = {
        _connection = nil,
        _prev = nil,
        _signal = p6,
        _handler = p7,
        _next = _head
    };

    if _head ~= nil then
        _head._prev = v9;
    end;

    p6._head = v9;
    local v10 = setmetatable({
        Connected = true,
        _node = v9
    }, u2);
    v9._connection = v10;

    return v10;
end;

function u1.Once(p11: table, u12: function) -- Line: 169
    local v13 = typeof(u12) == "function";
    assert(v13, "Must be function");
    local u14 = nil;
    u14 = p11:Connect(function(...) -- Line: 179
        -- upvalues: u14 (ref), u12 (copy)
        if u14 == nil then
            return;
        end;

        u14:Disconnect();
        u14 = nil;
        u12(...);
    end);

    return u14;
end;

u1.ConnectOnce = u1.Once;

function u1.Wait(p15) -- Line: 211
    local coroutine_running_ret = coroutine.running();
    local u16 = nil;
    u16 = p15:Connect(function(...) -- Line: 216
        -- upvalues: u16 (ref), coroutine_running_ret (ref)
        if u16 == nil then
            return;
        end;

        u16:Disconnect();
        u16 = nil;
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u1.Fire(p17, ...) -- Line: 246
    local _head = p17._head;

    while _head ~= nil do
        task.defer(_head._handler, ...);
        _head = _head._next;
    end;
end;

function u1.DisconnectAll(p18) -- Line: 266
    local _head = p18._head;

    while _head ~= nil do
        local _connection = _head._connection;

        if _connection ~= nil then
            _connection.Connected = false;
            _connection._node = nil;
            _head._connection = nil;
        end;

        _head = _head._next;
    end;

    p18._head = nil;
end;

function u1.Destroy(p19) -- Line: 293
    if p19._active ~= true then
        return;
    end;

    p19:DisconnectAll();
    p19._active = false;
end;

function u2.Disconnect(p20) -- Line: 314
    if p20.Connected ~= true then
        return;
    end;

    p20.Connected = false;
    local _node = p20._node;
    local _prev = _node._prev;
    local _next = _node._next;

    if _next ~= nil then
        _next._prev = _prev;
    end;

    if _prev == nil then
        _node._signal._head = _next;
    else
        _prev._next = _next;
    end;

    _node._connection = nil;
    p20._node = nil;
end;

u2.Destroy = u2.Disconnect;

return u1;