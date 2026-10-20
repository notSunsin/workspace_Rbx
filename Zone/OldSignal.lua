-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local Heartbeat = game:GetService("RunService").Heartbeat;
local u1 = {};
u1.__index = u1;
u1.ClassName = "Signal";
u1.totalConnections = 0;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);

    if p2 then
        v3.connectionsChanged = u1.new();
    end;

    v3.connections = {};
    v3.totalConnections = 0;
    v3.waiting = {};
    v3.totalWaiting = 0;

    return v3;
end;

function u1.Fire(p4, ...) -- Line: 30
    for _, v in pairs(p4.connections) do
        task.spawn(v.Handler, ...);
    end;

    if p4.totalWaiting > 0 then
        local table_pack_ret = table.pack(...);

        for i, _ in pairs(p4.waiting) do
            p4.waiting[i] = table_pack_ret;
        end;
    end;
end;

u1.fire = u1.Fire;

function u1.Connect(u5, p6) -- Line: 44
    -- upvalues: HttpService (copy)
    if type(p6) ~= "function" then
        error(("connect(%s)"):format((typeof(p6))), 2);
    end;

    local u7 = HttpService:GenerateGUID(false);
    local u8 = {
        Connected = true,
        ConnectionId = u7,
        Handler = p6
    };
    u5.connections[u7] = u8;

    function u8.Disconnect(p9) -- Line: 57
        -- upvalues: u5 (copy), u7 (copy), u8 (copy)
        u5.connections[u7] = nil;
        u8.Connected = false;
        local v10 = u5;
        v10.totalConnections = v10.totalConnections - 1;

        if u5.connectionsChanged then
            u5.connectionsChanged:Fire(-1);
        end;
    end;

    u8.Destroy = u8.Disconnect;
    u8.destroy = u8.Disconnect;
    u8.disconnect = u8.Disconnect;
    u5.totalConnections = u5.totalConnections + 1;

    if u5.connectionsChanged then
        u5.connectionsChanged:Fire(1);
    end;

    return u8;
end;

u1.connect = u1.Connect;

function u1.Wait(p11) -- Line: 77
    -- upvalues: HttpService (copy), Heartbeat (copy)
    local v12 = HttpService:GenerateGUID(false);
    p11.waiting[v12] = true;
    p11.totalWaiting = p11.totalWaiting + 1;

    repeat
        Heartbeat:Wait();
    until p11.waiting[v12] ~= true;

    p11.totalWaiting = p11.totalWaiting - 1;
    local v13 = p11.waiting[v12];
    p11.waiting[v12] = nil;

    return unpack(v13);
end;

u1.wait = u1.Wait;

function u1.Destroy(p14) -- Line: 89
    if p14.bindableEvent then
        p14.bindableEvent:Destroy();
        p14.bindableEvent = nil;
    end;

    if p14.connectionsChanged then
        p14.connectionsChanged:Fire(-p14.totalConnections);
        p14.connectionsChanged:Destroy();
        p14.connectionsChanged = nil;
    end;

    p14.totalConnections = 0;

    for i, _ in pairs(p14.connections) do
        p14.connections[i] = nil;
    end;
end;

u1.destroy = u1.Destroy;
u1.Disconnect = u1.Destroy;
u1.disconnect = u1.Destroy;

return u1;