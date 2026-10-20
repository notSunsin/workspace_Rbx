-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_Trove = require(script.Trove);
local script_Util = require(script.Util);
local workspace_Terrain = workspace.Terrain;
local u1 = {};
u1.__index = u1;
local Random_new_ret = Random.new();
local math_sin = math.sin;
local math_cos = math.cos;
local math_noise = math.noise;
local math_sqrt = math.sqrt;

local function setAttachmentWorldCFrame(p2: userdata, p3) -- Line: 50
    p2.WorldCFrame = p3;
end;

local function setBasePartCFrame(p4: userdata, p5) -- Line: 54
    p4.CFrame = p5;
end;

local function defaultShapeFunction(p6: table) -- Line: 58
    -- upvalues: math_sin (copy), math_cos (copy)
    return p6.CFrame * CFrame.new(math_sin(p6.Time) * p6.Radius, 0, math_cos(p6.Time) * p6.Radius);
end;

function u1.new(p7, p8: number, p9: number, p10: userdata, p11: table?) -- Line: 84
    -- upvalues: u1 (copy), script_Trove (copy)
    local v12 = setmetatable({}, u1);
    local v13 = p11 or {};
    v12.cframe = p7;
    v12.radius = p8;
    v12.radiusVariation = v13.radiusVariation;
    v12.segments = p9;
    v12.trailPart = p10;
    v12.rotationSpeed = v13.rotationSpeed or 1;
    v12.rotationSpeedVariation = v13.rotationSpeedVariation;
    v12.shapePartial = v13.shapePartial or 1;
    v12.shrink = v13.shrink or 1;
    v12.noise = v13.noise;
    v12.noiseFrequency = v13.noiseFrequency;
    v12.noiseAmplitude = v13.noiseAmplitude;
    v12.trove = script_Trove.new();
    v12._segments = {};
    v12._trailsCreated = false;

    return v12;
end;

function u1.SetShapeFunction(p14: table, p15: function) -- Line: 117
    p14.shapeFunction = p15;
end;

function u1.GetShapeFunction(p16: table, p17: table) -- Line: 122
    -- upvalues: math_sin (copy), math_cos (copy)
    if p16.shapeFunction then
        return p16.shapeFunction(p17);
    end;

    return p17.CFrame * CFrame.new(math_sin(p17.Time) * p17.Radius, 0, math_cos(p17.Time) * p17.Radius);
end;

function u1.CreateTrails(p18) -- Line: 131
    -- upvalues: script_Util (copy), workspace_Terrain (copy), math_sqrt (copy), Random_new_ret (copy), setAttachmentWorldCFrame (copy), setBasePartCFrame (copy)
    if p18._trailsCreated then
        return;
    end;

    p18._trailsCreated = true;
    local v19 = p18.cframe * CFrame.new(0, p18.radius, 0);

    for i = 1, p18.segments do
        local v20 = p18.trailPart:Clone();
        p18.trove:Add(v20);
        script_Util.ToggleAllTrails(v20, true);
        v20.Parent = workspace_Terrain;
        local v21 = v19 * CFrame.new(0, -(2 * p18.radius * p18.shapePartial / p18.segments) * (i - 0.5), 0);
        local v22 = math_sqrt(1 - (2 * ((v21.Position - v19.Position).Magnitude / (p18.radius * 2)) - 1) ^ 2) * p18.radius * p18.shrink;
        local Position = v21.Position;
        local v23 = not p18.radiusVariation and 1 or Random_new_ret:NextNumber(p18.radiusVariation.Min, p18.radiusVariation.Max);
        local v24 = not p18.rotationSpeedVariation and 1 or Random_new_ret:NextNumber(p18.rotationSpeedVariation.Min, p18.rotationSpeedVariation.Max);
        local v25 = {
            CFrame = v21,
            Index = i,
            Instance = v20
        };
        local v26;

        if v20:IsA("Attachment") then
            v26 = setAttachmentWorldCFrame;
        else
            v26 = setBasePartCFrame;
        end;

        v25.SetCFrame = v26;
        v25.Radius = v22 * v23;
        v25.BaseRadius = v22 * v23;
        v25.NoiseX = Position.X;
        v25.NoiseY = Position.Y;
        v25.NoiseZ = i * 5;
        v25.Time = Random_new_ret:NextNumber(0, 1000000);
        v25.RotationSpeed = p18.rotationSpeed * v24;
        table.insert(p18._segments, v25);
        local _ = i;
    end;
end;

function u1.Start(p27) -- Line: 184
    -- upvalues: defaultShapeFunction (copy), RunService (copy), math_noise (copy)
    p27:CreateTrails();
    local _segments = p27._segments;
    local u28 = 0;
    local noise = p27.noise;
    local u29 = p27.noiseAmplitude or 0;
    local u30 = p27.noiseFrequency or 0;
    local u31 = p27.shapeFunction or defaultShapeFunction;
    p27._renderConnection = RunService.RenderStepped:Connect(function(p32) -- Line: 193
        -- upvalues: _segments (copy), u31 (copy), noise (copy), u29 (copy), math_noise (ref), u28 (ref), u30 (copy)
        for i = 1, #_segments do
            local v33 = _segments[i];
            v33.Time = v33.Time + v33.RotationSpeed * p32;
            v33.SetCFrame(v33.Instance, u31(v33));
            local v34;

            if noise then
                v33.Radius = v33.BaseRadius + u29 * math_noise(v33.NoiseX + u28 * u30, v33.NoiseY + u28 * u30, v33.NoiseZ);
                v34 = i;
            else
                v34 = i;
            end;
        end;

        u28 = u28 + p32;
    end);
    p27.trove:Add(p27._renderConnection);
end;

function u1.End(p35: table, p36: boolean?) -- Line: 212
    -- upvalues: script_Util (copy)
    p35._renderConnection:Disconnect();
    task.wait(script_Util.GetMaxLifetime(p35.trailPart));

    if p36 then
        p35:Destroy();
    end;
end;

function u1.Destroy(p37) -- Line: 223
    p37.trove:Clean();
    p37.trove:Destroy();
    table.clear(p37._segments);
    setmetatable(p37, nil);
end;

return u1;