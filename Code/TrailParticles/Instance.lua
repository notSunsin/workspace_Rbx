-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local math_noise = math.noise;
local Random_new_ret = Random.new(os.time());

function u1.new(p2: vector) -- Line: 12
    -- upvalues: Random_new_ret (copy), u1 (copy)
    local v5 = {
        Element = nil,
        MinSpeedMult = 1,
        MaxSpeedMult = 1,
        FadeIn = 1,
        FadeOut = 1,
        Active = true,
        Resolution = 2,
        Contrast = 1.1,
        TrailLife = 0.5,
        _t = 0,
        Velocity = p2,

        NoiseStrength = function(p3) -- Line: 20, Name: NoiseStrength
        end,

        VelocityDrag = function(p4) -- Line: 21, Name: VelocityDrag
        end,

        Seed = os.time()
    };
    local v6 = Random_new_ret:NextInteger(-1, 1) + 0.01;
    local v7 = Random_new_ret:NextInteger(-1, 1) + 0.01;
    local v8 = Random_new_ret:NextInteger(-1, 1) + 0.01;
    v5._rotationDirection = Vector3.new(v6, v7, v8);
    v5._start = os.clock();

    return setmetatable(v5, u1);
end;

function u1.Update(p9: table, p10: number) -- Line: 40
    -- upvalues: math_noise (copy)
    if not p9.Element then
        error("Particle element missing or nil");

        return;
    end;

    if os.clock() - p9._start >= p9.Lifetime then
        p9:Destroy();
    end;

    local Element = p9.Element;
    local v11 = math_noise(Element.CFrame.Rotation.X / p9.Resolution + 0.1, p9.Seed + p9._t);
    local v12 = math.clamp(v11, -1, 1) * p9.NoiseStrength(p9.Contrast + p9._t / 10);
    local v13 = math.rad(v12) * p9._rotationDirection.X;
    local v14 = math_noise(Element.CFrame.Rotation.Y / p9.Resolution + 0.1, p9.Seed + p9._t);
    local v15 = math.clamp(v14, -1, 1) * p9.NoiseStrength(p9.Contrast + p9._t / 10);
    local v16 = math.rad(v15) * p9._rotationDirection.Y;
    local v17 = math_noise(Element.CFrame.Rotation.Z / p9.Resolution + 0.1, p9.Seed + p9._t);
    local v18 = math.clamp(v17, -1, 1) * p9.NoiseStrength(p9.Contrast + p9._t / 10);
    local v19 = math.rad(v18) * p9._rotationDirection.Z;
    Element:UpdateCFrame(Element.CFrame * CFrame.new(-p9.Velocity * p10) * CFrame.Angles(v13, v16, v19));
    p9.Velocity = p9.VelocityDrag(p9.Velocity);

    if p9.Velocity.X < 0 or (p9.Velocity.Y < 0 or p9.Velocity.Z < 0) then
        p9:Destroy();
    end;

    p9._t = p9._t + p10 * 60;
end;

function u1.Destroy(u20) -- Line: 79
    u20.Active = false;
    u20.Velocity = Vector3.new(0, 0, 0);
    u20._rotationDirection = Vector3.new(0, 0, 0);
    task.delay(u20.TrailLife, function() -- Line: 83
        -- upvalues: u20 (copy)
        u20.Element:Destroy();
        u20.Active = false;
    end);
end;

setmetatable(u1, {
    __index = function(p21, p22) -- Line: 90, Name: __index
        error(string.format("%q is not a valid member of %q", tostring(p22), script.Name), 2);
    end
});

return u1;