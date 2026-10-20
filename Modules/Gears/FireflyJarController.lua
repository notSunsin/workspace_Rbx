-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage.Assets;
local RunService = game:GetService("RunService");
local Firefly = ReplicatedStorage.Assets.VFX.Firefly;
local VFX = Firefly.VFX;
local JarBreakParts = Firefly.JarBreakParts;
local Firefly2 = Firefly.Firefly;

local function EndParticles(p1: userdata) -- Line: 16
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;
end;

local function GiveRandomVelcoityAndTorqueToModel(p2: userdata) -- Line: 24
    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
            local math_random_ret = math.random(-10, 10);
            local math_random_ret2 = math.random(15, 20);
            descendant.AssemblyLinearVelocity = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
            local math_random_ret3 = math.random(-10, 10);
            local math_random_ret4 = math.random(-10, 10);
            descendant.AssemblyAngularVelocity = Vector3.new(math_random_ret3, math_random_ret4, math.random(-10, 10));
        end;
    end;
end;

local function FadeOutDescendants(p3: userdata, p4: number) -- Line: 33
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);

    for _, descendant in ipairs(p3:GetDescendants()) do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo_new_ret, {
                Transparency = 1
            }):Play();
        end;
    end;
end;

local function FadeOutEmitterRate(p5: userdata, p6: number) -- Line: 45
    -- upvalues: TweenService (copy)
    if not p5 then
        return;
    end;

    TweenService:Create(p5, TweenInfo.new(p6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Rate = 0
    }):Play();
end;

local function RotateModelAroundPosition(u7: userdata, u8: vector, u9: number, u10: number, p11: number) -- Line: 55
    -- upvalues: RunService (copy)
    if not u7.PrimaryPart then
        warn("Model needs a PrimaryPart set!");

        return;
    end;

    local u12 = p11 or 5;
    local u13 = 0;
    local u14 = 0;
    local u20 = RunService.Heartbeat:Connect(function(p15) -- Line: 68
        -- upvalues: u14 (ref), u13 (ref), u10 (copy), u9 (copy), u12 (ref), u8 (copy), u7 (copy)
        u14 = u14 + p15;
        u13 = u13 + u10 * p15;
        local math_clamp_ret = math.clamp(u14 / u12, 0, 1);
        local math_lerp_ret = math.lerp(0, u9, math_clamp_ret);
        local math_clamp_ret2 = math.clamp(u14 / u12, 0, 1);
        local math_lerp_ret2 = math.lerp(0, 10, math_clamp_ret2);
        local v16 = math.cos(u13) * math_lerp_ret;
        local v17 = math.sin(u13) * math_lerp_ret;
        local v18 = u8 + Vector3.new(v16, math_lerp_ret2, v17);
        local v19 = -math.sin(u13);
        local math_cos_ret = math.cos(u13);
        local Unit = Vector3.new(v19, 0, math_cos_ret).Unit;
        local CFrame_new_ret = CFrame.new(v18, v18 + Unit);

        if u7 then
            u7:PivotTo(CFrame_new_ret);
        end;
    end);
    task.delay(u12, function() -- Line: 88
        -- upvalues: u20 (ref)
        u20:Disconnect();
    end);
end;

ReplicatedStorage.GameEvents.FireflyJarVisual.OnClientEvent:Connect(function(p21: userdata) -- Line: 94, Name: CreateFairyVFX
    -- upvalues: VFX (copy), Debris (copy), JarBreakParts (copy), GiveRandomVelcoityAndTorqueToModel (copy), Firefly2 (copy), RotateModelAroundPosition (copy), FadeOutDescendants (copy), EndParticles (copy)
    if p21 == nil or #p21:GetChildren() == 0 then
        print("No part");

        return;
    end;

    local v22 = p21["Firefly Jar"];
    local v23 = VFX:Clone();
    v23.Parent = v22;
    v23.Position = Vector3.new(0, -1, 0);
    local Break = v23:FindFirstChild("Break");

    if Break then
        Break:Emit(3);
    end;

    Debris:AddItem(v23, 3);
    local v24 = JarBreakParts:Clone();
    v24.Parent = workspace.Visuals;
    v24:PivotTo(v22:GetPivot());
    GiveRandomVelcoityAndTorqueToModel(v24);
    Debris:AddItem(v24, 3);
    local v25 = Firefly2:Clone();
    v25.Parent = workspace.Visuals;
    v25.AnimationController.Animator:LoadAnimation(v25.Walk):Play();
    v25:PivotTo(v22.Firefly:GetPivot());
    RotateModelAroundPosition(v25, v22.Firefly:GetPivot().Position, 5, 4, 10);
    task.delay(5, function() -- Line: 137
    end);
    FadeOutDescendants(v25, 8);
    Debris:AddItem(v25, 10);
    task.wait(3);

    if not v23 then
        return;
    end;

    EndParticles(v23);
end);

return {};