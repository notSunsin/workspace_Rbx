-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);

local function newQueue() -- Line: 29
    return {
        Head = 1,
        Tail = 0,
        Bytes = 0,
        Items = {},
        Times = {}
    };
end;

local function push(p1: table, p2: buffer, p3: number) -- Line: 33
    p1.Tail = p1.Tail + 1;
    p1.Items[p1.Tail] = p2;
    p1.Times[p1.Tail] = p3;
    p1.Bytes = p1.Bytes + buffer.len(p2);
end;

local function peek(p4: table) -- Line: 40
    return p4.Items[p4.Head];
end;

local function pop(p5: table) -- Line: 44
    local v6 = p5.Items[p5.Head];
    p5.Items[p5.Head] = nil;
    p5.Times[p5.Head] = nil;
    p5.Head = p5.Head + 1;
    p5.Bytes = p5.Bytes - buffer.len(v6);

    if p5.Head > p5.Tail then
        p5.Head = 1;
        p5.Tail = 0;
    end;
end;

local u7 = {};
u7.__index = u7;

function u7.new(p8: any, p9: function, p10: function) -- Line: 59
    -- upvalues: newQueue (copy), u7 (copy)
    local v11 = {
        SentBytes = 0,
        Elapsed = 0,
        BurstLeft = 0,
        Stopped = false,
        Config = p8,
        Send = p9,
        OnStop = p10,
        Stream = newQueue(),
        Init = newQueue(),
        StreamTokens = p8.StreamBytesPerSecond,
        InitTokens = p8.InitBytesPerSecond
    };

    return setmetatable(v11, u7);
end;

function u7.Push(p12: table, p13: buffer, p14: boolean) -- Line: 80
    -- upvalues: Observability (copy)
    if p12.Stopped then
        return;
    end;

    if p14 then
        local Init = p12.Init;
        local Elapsed = p12.Elapsed;
        Init.Tail = Init.Tail + 1;
        Init.Items[Init.Tail] = p13;
        Init.Times[Init.Tail] = Elapsed;
        Init.Bytes = Init.Bytes + buffer.len(p13);

        return;
    end;

    local Stream = p12.Stream;
    local Elapsed = p12.Elapsed;
    Stream.Tail = Stream.Tail + 1;
    Stream.Items[Stream.Tail] = p13;
    Stream.Times[Stream.Tail] = Elapsed;
    Stream.Bytes = Stream.Bytes + buffer.len(p13);

    if p12.Stream.Bytes > p12.Config.QueueDropBytes then
        p12:Stop(Observability.StopReason.Dropped);
    end;
end;

function u7.Burst(p15: table, p16: number) -- Line: 96
    p15.BurstLeft = p16;
end;

function u7._drain(p17: table, p18: table, p19: number, p20: number, p21: number) -- Line: 101
    -- upvalues: Observability (copy)
    local math_min_ret = math.min(p19 + p20 * p21, p20);

    while true do
        local v22 = p18.Items[p18.Head];

        if not v22 then
            break;
        end;

        local buffer_len_ret = buffer.len(v22);

        if math_min_ret < math.min(buffer_len_ret, p20) then
            break;
        end;

        if p17.SentBytes + buffer_len_ret > p17.Config.SessionCapBytes then
            p17:Stop(Observability.StopReason.Capped);

            return math_min_ret;
        end;

        local v23 = p18.Items[p18.Head];
        p18.Items[p18.Head] = nil;
        p18.Times[p18.Head] = nil;
        p18.Head = p18.Head + 1;
        p18.Bytes = p18.Bytes - buffer.len(v23);

        if p18.Head > p18.Tail then
            p18.Head = 1;
            p18.Tail = 0;
        end;

        math_min_ret = math_min_ret - buffer_len_ret;
        p17.SentBytes = p17.SentBytes + buffer_len_ret;
        p17.Send(v22);
    end;

    return math_min_ret;
end;

function u7.Step(p24: table, p25: number) -- Line: 125
    -- upvalues: Observability (copy)
    if p24.Stopped then
        return;
    end;

    p24.Elapsed = p24.Elapsed + p25;
    p24.InitTokens = p24:_drain(p24.Init, p24.InitTokens, p24.Config.InitBytesPerSecond, p25);

    if p24.Stopped then
        return;
    end;

    local Stream = p24.Stream;
    local Init = p24.Init;

    if Init.Items[Init.Head] then
        for i = Stream.Head, Stream.Tail do
            Stream.Times[i] = p24.Elapsed;
            local _ = i;
        end;

        return;
    end;

    local StreamBytesPerSecond = p24.Config.StreamBytesPerSecond;

    if p24.BurstLeft > 0 then
        p24.BurstLeft = p24.BurstLeft - p25;
        StreamBytesPerSecond = p24.Config.BurstBytesPerSecond;
    end;

    p24.StreamTokens = p24:_drain(Stream, p24.StreamTokens, StreamBytesPerSecond, p25);

    if p24.Stopped then
        return;
    end;

    local v26 = Stream.Times[Stream.Head];

    if v26 and p24.Elapsed - v26 > p24.Config.QueueMaxLagSeconds then
        p24:Stop(Observability.StopReason.Dropped);
    end;
end;

function u7.Stop(p27: table, p28: string) -- Line: 158
    -- upvalues: newQueue (copy)
    if p27.Stopped then
        return;
    end;

    p27.Stopped = true;
    p27.Stream = newQueue();
    p27.Init = newQueue();
    p27.OnStop(p28);
end;

return u7;