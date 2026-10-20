-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Random_new_ret = Random.new();
local u1 = 0;
local u2 = {};
u2.__index = u2;

function u2.new() -- Line: 231
    -- upvalues: u2 (copy), RunService (copy), Random_new_ret (copy)
    local v3 = setmetatable({}, u2);
    v3.Amplitude = 1;
    v3.Frequency = 1;
    v3.FadeInTime = 1;
    v3.FadeOutTime = 1;
    v3.SustainTime = 0;
    v3.Sustain = false;
    v3.PositionInfluence = Vector3.new(1, 1, 1);
    v3.RotationInfluence = Vector3.new(1, 1, 1);
    local v4;

    if RunService:IsRunning() then
        v4 = time;
    else
        v4 = os.clock;
    end;

    v3.TimeFunction = v4;
    v3._timeOffset = Random_new_ret:NextNumber(-1000000, 1000000);
    v3._startTime = 0;
    v3._running = false;
    v3._signalConnections = {};
    v3._renderBindings = {};

    return v3;
end;

function u2.InverseSquare(p5: vector, p6: number) -- Line: 282
    local v7 = p6 < 1 and 1 or p6;

    return p5 * (1 / (v7 * v7));
end;

function u2.NextRenderName() -- Line: 298
    -- upvalues: u1 (ref)
    u1 = u1 + 1;

    return ("__shake_%.4i__"):format(u1);
end;

function u2.Start(p8) -- Line: 311
    p8._startTime = p8.TimeFunction();
    p8._running = true;
end;

function u2.Stop(p9) -- Line: 323
    -- upvalues: RunService (copy)
    p9._running = false;

    for _, v in p9._renderBindings do
        RunService:UnbindFromRenderStep(v);
    end;

    table.clear(p9._renderBindings);

    for _, v in p9._signalConnections do
        v:Disconnect();
    end;

    table.clear(p9._signalConnections);
end;

function u2.IsShaking(p10) -- Line: 341
    return p10._running;
end;

function u2.StopSustain(p11) -- Line: 350
    local v12 = p11.TimeFunction();
    p11.Sustain = false;
    p11.SustainTime = v12 - p11._startTime - p11.FadeInTime;
end;

function u2.Update(p13) -- Line: 378
    local v14 = false;
    local v15 = p13.TimeFunction();
    local v16 = v15 - p13._startTime;
    local v17 = (v15 + p13._timeOffset) / p13.Frequency % 10000;
    local v18 = 1;
    local v19 = v16 >= p13.FadeInTime and 1 or v16 / p13.FadeInTime;

    if not p13.Sustain and p13.FadeInTime + p13.SustainTime < v16 then
        if p13.FadeOutTime == 0 then
            v14 = true;
        else
            v18 = 1 - (v16 - p13.FadeInTime - p13.SustainTime) / p13.FadeOutTime;

            if not p13.Sustain and p13.FadeInTime + p13.SustainTime + p13.FadeOutTime <= v16 then
                v14 = true;
            end;
        end;
    end;

    local v20 = math.noise(v17, 0) / 2;
    local v21 = math.noise(0, v17) / 2;
    local v22 = math.noise(v17, v17) / 2;
    local v23 = Vector3.new(v20, v21, v22) * p13.Amplitude * math.min(v19, v18);

    if v14 then
        p13:Stop();
    end;

    return p13.PositionInfluence * v23, p13.RotationInfluence * v23, v14;
end;

function u2.OnSignal(u24: table, p25: any, u26: function) -- Line: 436
    local v27 = p25:Connect(function() -- Line: 437
        -- upvalues: u26 (copy), u24 (copy)
        u26(u24:Update());
    end);
    table.insert(u24._signalConnections, v27);

    return v27;
end;

function u2.BindToRenderStep(u28: table, p29: string, p30: number, u31: function) -- Line: 466
    -- upvalues: RunService (copy)
    RunService:BindToRenderStep(p29, p30, function() -- Line: 467
        -- upvalues: u31 (copy), u28 (copy)
        u31(u28:Update());
    end);
    table.insert(u28._renderBindings, p29);
end;

function u2.Clone(p32) -- Line: 503
    -- upvalues: u2 (copy)
    local v33 = u2.new();

    for _, v in { "Amplitude", "Frequency", "FadeInTime", "FadeOutTime", "SustainTime", "Sustain", "PositionInfluence", "RotationInfluence", "TimeFunction" } do
        v33[v] = p32[v];
    end;

    return v33;
end;

function u2.Destroy(p34) -- Line: 525
    p34:Stop();
end;

return {
    new = u2.new,
    InverseSquare = u2.InverseSquare,
    NextRenderName = u2.NextRenderName
};