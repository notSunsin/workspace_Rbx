-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Op = Observability.Op;
local u1 = {};
u1.__index = u1;

function u1.new(p2: number, p3: function) -- Line: 28
    -- upvalues: Codec (copy), u1 (copy)
    local v4 = {
        Init = false,
        LastTime = 0,
        Records = 0,
        Main = nil,
        StageTime = 0,
        StageStart = 0,
        BatchBytes = p2,
        OnBatch = p3,
        W = Codec.newWriter(p2 + 1024),
        Scratch = Codec.newWriter(16384),
        Staged = {}
    };
    local v5 = setmetatable(v4, u1);
    v5:_writeTime();

    return v5;
end;

function u1._writeTime(p6) -- Line: 46
    -- upvalues: Op (copy)
    local W = p6.W;
    W:u8(Op.Time);
    W:u32(p6.LastTime);
end;

function u1.Time(p7: table, p8: number) -- Line: 52
    -- upvalues: Op (copy), Codec (copy)
    local math_floor_ret = math.floor(p8);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, 4294967295);

    if p7.Main then
        p7.StageTime = math_clamp_ret;

        return;
    end;

    if p7.LastTime < math_clamp_ret then
        local W = p7.W;
        W:u8(Op.TimeDelta);
        Codec.varuint(W, math_clamp_ret - p7.LastTime);
        p7.LastTime = math_clamp_ret;
    end;
end;

function u1.BeginStage(p9) -- Line: 65
    assert(not p9.Main, "stage already open");
    p9.Main = p9.W;
    p9.W = p9.Scratch;
    p9.W.len = 0;
    p9.StageStart = 0;
    p9.StageTime = p9.LastTime;
    table.clear(p9.Staged);
end;

function u1.CommitStage(p10) -- Line: 75
    local W = p10.W;
    p10.W = p10.Main;
    p10.Main = nil;
    local Staged = p10.Staged;
    table.sort(Staged, function(p11, p12) -- Line: 80
        if p11.T == p12.T then
            return p11.Index < p12.Index;
        end;

        return p11.T < p12.T;
    end);

    for _, v in Staged do
        p10:Time(v.T);
        local W2 = p10.W;
        local v13 = v.Finish - v.Start;
        W2:_ensure(v13);
        buffer.copy(W2.buf, W2.len, W.buf, v.Start, v13);
        W2.len = W2.len + v13;
        p10:EndRecord();
    end;

    table.clear(Staged);
end;

function u1.EndRecord(p14) -- Line: 99
    if not p14.Main then
        p14.Records = p14.Records + 1;

        if p14.W.len >= p14.BatchBytes then
            p14:Cut();
        end;

        return;
    end;

    local Staged = p14.Staged;
    local len = p14.W.len;
    table.insert(Staged, {
        T = p14.StageTime,
        Start = p14.StageStart,
        Finish = len,
        Index = #Staged + 1
    });
    p14.StageStart = len;
end;

function u1.Cut(p15) -- Line: 114
    -- upvalues: Codec (copy)
    if p15.Records == 0 then
        return;
    end;

    local v16 = p15.W:finish();
    p15.W = Codec.newWriter(p15.BatchBytes + 1024);
    p15.Records = 0;
    p15:_writeTime();
    p15.OnBatch(v16, p15.Init);
end;

function u1.ClockSync(p17: table, p18: number) -- Line: 126
    -- upvalues: Op (copy)
    local W = p17.W;
    W:u8(Op.ClockSync);
    W:f64(p18);
    p17:EndRecord();
end;

return u1;