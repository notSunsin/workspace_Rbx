-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Trove = require(ReplicatedStorage.Modules.Trove);
local Random_new_ret = Random.new();
local u1 = 0;
local u2 = {};

function u2.new() -- Line: 179
    -- upvalues: u2 (copy), RunService (copy), Random_new_ret (copy), Trove (copy)
    local u3 = setmetatable({}, {
        __index = u2
    });
    u3.Amplitude = 1;
    u3.Frequency = 1;
    u3.FadeInTime = 1;
    u3.FadeOutTime = 1;
    u3.SustainTime = 0;
    u3.Sustain = false;
    u3.PositionInfluence = Vector3.new(1, 1, 1);
    u3.RotationInfluence = Vector3.new(1, 1, 1);
    local v4;

    if RunService:IsRunning() then
        v4 = time;
    else
        v4 = os.clock;
    end;

    u3.TimeFunction = v4;
    u3._timeOffset = Random_new_ret:NextNumber(-1000000000, 1000000000);
    u3._startTime = 0;
    u3._trove = Trove.new();
    u3._trove:Add(function() -- Line: 198
        -- upvalues: u3 (copy)
        if u3 and getmetatable(u3) ~= nil then
            getmetatable(u3).__mode = "kv";
        end;
    end);
    u3._running = false;

    return u3;
end;

function u2.InverseSquare(p5: vector, p6: number) -- Line: 240
    local v7 = p6 < 1 and 1 or p6;

    return p5 * (1 / (v7 * v7));
end;

function u2.NextRenderName() -- Line: 256
    -- upvalues: u1 (ref)
    u1 = u1 + 1;

    return ("__shake_%.4i__"):format(u1);
end;

function u2.Start(u8) -- Line: 269
    u8._startTime = u8.TimeFunction();
    u8._running = true;
    u8._trove:Add(function() -- Line: 272
        -- upvalues: u8 (copy)
        u8._running = false;
    end);
end;

function u2.Stop(p9) -- Line: 284
    if p9._trove then
        p9._trove:Clean();
    end;
end;

function u2.IsShaking(p10) -- Line: 294
    return p10._running;
end;

function u2.StopSustain(p11) -- Line: 303
    local v12 = p11.TimeFunction();
    p11.Sustain = false;
    p11.SustainTime = v12 - p11._startTime - p11.FadeInTime;
end;

function u2.Update(p13, p14) -- Line: 331
    local v15 = false;
    local v16 = p13.TimeFunction();
    local v17 = v16 - p13._startTime;
    local v18 = (v16 + p13._timeOffset) / p13.Frequency % 1000000;
    local v19 = 1;
    local v20 = v17 >= p13.FadeInTime and 1 or v17 / p13.FadeInTime;

    if not p13.Sustain and p13.FadeInTime + p13.SustainTime < v17 then
        if p13.FadeOutTime == 0 then
            v15 = true;
        else
            v19 = 1 - (v17 - p13.FadeInTime - p13.SustainTime) / p13.FadeOutTime;

            if not p13.Sustain and p13.FadeInTime + p13.SustainTime + p13.FadeOutTime <= v17 then
                v15 = true;
            end;
        end;
    end;

    local v21 = math.noise(v18, 0) / 2;
    local v22 = math.noise(0, v18) / 2;
    local v23 = math.noise(v18, v18) / 2;
    local v24 = Vector3.new(v21, v22, v23) * (p13.Amplitude * (p14 * 80 * 1.25)) * math.min(v20, v19);

    if v15 then
        p13:Stop();
    end;

    return p13.PositionInfluence * v24, p13.RotationInfluence * v24, v15;
end;

function u2.OnSignal(u25: table, p26: any, u27: function) -- Line: 389
    return u25._trove:Connect(p26, function() -- Line: 390
        -- upvalues: u27 (copy), u25 (copy)
        u27(u25:Update());
    end);
end;

function u2.BindToRenderStep(u28: table, p29: string, p30: number, u31: function) -- Line: 415
    u28._trove:BindToRenderStep(p29, p30, function(p32) -- Line: 416
        -- upvalues: u31 (copy), u28 (copy)
        u31(u28:Update(p32));
    end);
end;

function u2.Clone(p33) -- Line: 450
    -- upvalues: u2 (copy)
    local v34 = u2.new();

    for _, v in { "Amplitude", "Frequency", "FadeInTime", "FadeOutTime", "SustainTime", "Sustain", "PositionInfluence", "RotationInfluence", "TimeFunction" } do
        v34[v] = p33[v];
    end;

    return v34;
end;

function u2.Destroy(p35) -- Line: 472
    p35:Stop();
end;

return u2;