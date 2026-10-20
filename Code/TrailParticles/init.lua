-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
game:GetService("Debris");
local script_Instance = require(script.Instance);
local script_Part = require(script.Part);
local u1 = {};
u1.__index = u1;
math.randomseed(os.time());

local function ReconcileInv(p2, p3) -- Line: 14
    for i, v in pairs(p3) do
        if p2[i] then
            p2[i] = v;
        end;
    end;

    return p2;
end;

local function gaussianRandom(p4, p5) -- Line: 23
    local v6, v7;

    repeat
        v7 = 2 * math.random() - 1;
        local v8 = 2 * math.random() - 1;
        v6 = math.pow(v7, 2) + math.pow(v8, 2);
    until v6 ~= 0 and v6 < 1;

    local v9 = math.log(v6) * -2 / v6;
    local math_sqrt_ret = math.sqrt(v9);

    return p4 + p5 * v7 * math_sqrt_ret;
end;

function randomPointInSphere(p10)
    -- upvalues: gaussianRandom (copy)
    local v11 = 6.283185307179586 * math.random();
    local v12 = 2 * math.random() - 1;
    local math_acos_ret = math.acos(v12);
    local v13 = gaussianRandom(0, p10 / 3);
    local math_min_ret = math.min(v13, p10);

    return math_min_ret * math.sin(math_acos_ret) * math.cos(v11), math_min_ret * math.sin(math_acos_ret) * math.sin(v11), math_min_ret * math.cos(math_acos_ret);
end;

function u1.new(p14: number, p15: userdata, p16: vector, p17: vector) -- Line: 49
    -- upvalues: u1 (copy)
    local v18 = type(p14) == "number";
    assert(v18, "amount must be a number");
    local v19 = typeof(p15) == "Instance";
    assert(v19, "part must be an instance");
    local v20 = typeof(p16) == "Vector3";
    assert(v20, "origin must be a Vector3");
    local v21 = typeof(p17) == "Vector3";
    assert(v21, "direction must be a Vector3");
    local v22 = {
        XAngle = 30,
        YAngle = 30,
        ZAngle = 0,
        Radius = 10,
        DirectionRelativeToOrigin = false,
        _running = false,
        RenderPriority = Enum.RenderPriority.Last.Value,
        Origin = p16,
        Direction = p17,
        Amount = p14,
        Part = p15,
        _renderName = ("WindParticles_%s"):format((tostring(os.clock()))),
        _instances = {},
        _removeInstances = {},
        _rng = Random.new(os.clock())
    };

    return setmetatable(v22, u1);
end;

function u1.Start(u23) -- Line: 79
    -- upvalues: RunService (copy)
    if u23._running then
        return;
    end;

    u23._running = true;
    RunService:BindToRenderStep(u23._renderName, u23.RenderPriority, function(p24) -- Line: 84
        -- upvalues: u23 (copy)
        debug.profilebegin("particle simulation");
        u23:Update(p24);
        debug.profileend();
    end);
end;

function u1.Simulate(p25: table, p26: table) -- Line: 91
    -- upvalues: script_Part (copy), script_Instance (copy)
    local v27 = type(p26) == "table";
    assert(v27, "properties must be of type WindInstance");

    for i = 1, p25.Amount do
        local v28 = script_Part.new(p25.Part);
        v28:UpdateCFrame(CFrame.new(p25.Origin, p25.Direction));

        if p25.DirectionRelativeToOrigin then
            v28:UpdateCFrame(v28.CFrame * CFrame.new(randomPointInSphere(p25.Radius)));
            v28:UpdateCFrame(CFrame.lookAt(v28.CFrame.Position, p25.Origin) * CFrame.Angles(3.141592653589793, 0, 0));
        else
            local v29 = v28.CFrame * CFrame.new(randomPointInSphere(p25.Radius));
            local CFrame_Angles = CFrame.Angles;
            local v30 = p25._rng:NextNumber(-p25.XAngle, p25.XAngle);
            local math_rad_ret = math.rad(v30);
            local v31 = p25._rng:NextNumber(-p25.YAngle, p25.YAngle);
            v28:UpdateCFrame(v29 * CFrame_Angles(math_rad_ret, math.rad(v31), (math.rad(p25.ZAngle))));
        end;

        local v32 = script_Instance.new(p26.Velocity);
        local _ = i;

        for i2, v in pairs(p26) do
            if v32[i2] then
                v32[i2] = v;
            end;
        end;

        v32.Velocity = v32.Velocity * p25._rng:NextNumber(v32.MinSpeedMult, v32.MaxSpeedMult);
        v32.Lifetime = p25._rng:NextNumber(v32.FadeIn, v32.FadeOut);
        v32.Element = v28;
        p25._instances[#p25._instances + 1] = v32;
    end;
end;

function u1.Update(p33, p34) -- Line: 132
    local _instances = p33._instances;

    for i = 1, #_instances do
        local v35 = _instances[i];
        local v36;

        if v35.Active == false then
            p33._removeInstances[#p33._removeInstances + 1] = i;
            v36 = i;
        else
            v35:Update(p34);
            v36 = i;
        end;
    end;

    for i = #p33._removeInstances, 1, -1 do
        table.remove(_instances, p33._removeInstances[i]);
        p33._removeInstances[i] = nil;
        local _ = i;
    end;
end;

function u1.Stop(p37) -- Line: 152
    -- upvalues: RunService (copy)
    if not p37._running then
        return;
    end;

    RunService:UnbindFromRenderStep(p37._renderName);
    p37._running = false;
end;

function u1.Destroy(p38) -- Line: 160
    p38:Stop();

    for _, v in p38._instances do
        v:Destroy();
    end;

    p38._instances = nil;
end;

setmetatable(u1, {
    __index = function(p39, p40) -- Line: 169, Name: __index
        error(string.format("%q is not a valid member of %q", tostring(p40), script.Name), 2);
    end
});

return u1;