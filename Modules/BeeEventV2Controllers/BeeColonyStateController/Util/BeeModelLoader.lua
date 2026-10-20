-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PetAnimations = ReplicatedStorage.Assets.Animations.PetAnimations;
local BeeModels = ReplicatedStorage.Assets.Models.BeeModels;
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local BeeItemLoader = require(script.Parent.BeeItemLoader);

return function(u1: any, p2: string) -- Line: 10, Name: LoadBeeModel
    -- upvalues: BeeModels (copy), BeeItemLoader (copy), BeeRegistry (copy), PetAnimations (copy), ReplicatedStorage (copy), Players (copy)
    if u1.Client.Model then
        return;
    end;

    local v3 = u1.Server.BeeName or "Bee";
    local v4 = BeeModels:FindFirstChild(v3) or BeeModels:FindFirstChild("Bee");

    if not v4 then
        return;
    end;

    local v5 = v4:Clone();
    local Hitbox = u1.Client.Hitbox;

    if not Hitbox then
        v5:Destroy();

        return;
    end;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = true;
            descendant.Anchored = false;

            if u1.Server.IsIllusion then
                descendant.Color = descendant.Color:Lerp(Color3.fromRGB(212, 212, 212), 0.6);
                descendant.Transparency = 0.25;
                descendant.Material = Enum.Material.SmoothPlastic;
            end;
        end;
    end;

    local PrimaryPart = v5.PrimaryPart;

    if not PrimaryPart then
        v5:Destroy();

        return;
    end;

    local Weld = Instance.new("Weld");
    Weld.Part0 = Hitbox;
    Weld.Part1 = PrimaryPart;
    Weld.C0 = CFrame.Angles(0, 1.5707963267948966, -3.141592653589793);
    Weld.C1 = CFrame.identity;
    Weld.Parent = PrimaryPart;
    v5.Parent = Hitbox;
    Hitbox.Transparency = 1;
    u1.Client.IsSpawning = true;
    u1.Client.SpawnElapsed = nil;
    u1.Client.Model = v5;
    BeeItemLoader(u1);
    local v6 = v5:FindFirstChildOfClass("AnimationController");

    if not v6 then
        return;
    end;

    local v7 = v6:FindFirstChildOfClass("Animator");

    if not v7 then
        return;
    end;

    local v8;

    if BeeRegistry[v3].IdleAnimation then
        v8 = Instance.new("Animation");
        v8.AnimationId = BeeRegistry[v3].IdleAnimation;
    else
        local Bee = PetAnimations:FindFirstChild("Bee");

        if not Bee then
            return;
        end;

        v8 = Bee:FindFirstChild("Idle");
    end;

    local v9 = v7:LoadAnimation(v8);
    v9.Looped = true;
    v9:Play();
    u1.Client.IdleAnimation = v9;

    if BeeRegistry[v3].AttackAnimation then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = BeeRegistry[v3].AttackAnimation;
        local v10 = v7:LoadAnimation(Animation);
        u1.Client.AttackAnimation = v10;
    end;

    if BeeRegistry[v3].DamagedAnimation then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = BeeRegistry[v3].DamagedAnimation;
        local v11 = v7:LoadAnimation(Animation);
        v11.Looped = false;
        u1.Client.DamagedAnimation = v11;
    end;

    if v3 ~= "Wasp King" and v3 ~= "Skeleton Bee" then
        if u1.Client.HealthBar then
            u1.Client.HealthBar:Destroy();
            u1.Client.HealthBar = nil;
        end;

        local u12 = ReplicatedStorage.BeeHealthbar:Clone();
        u12.Adornee = PrimaryPart;
        u12.Enabled = false;
        u12.Parent = Players.LocalPlayer.PlayerGui;
        u1.Client.HealthBar = u12;
        PrimaryPart.Destroying:Once(function() -- Line: 127
            -- upvalues: u12 (copy), u1 (copy)
            u12:Destroy();

            if u1.Client.HealthBar == u12 then
                u1.Client.HealthBar = nil;
            end;
        end);
        local v13 = {};

        for i = 1, 4 do
            local v14 = u12:FindFirstChild((tostring(i)));

            if v14 then
                v14 = v14:FindFirstChild("Heart");
            end;

            if v14 then
                v14 = v14:FindFirstChildOfClass("UIGradient");
            end;

            v13[i] = v14 and v14.Rotation or 0;
            local _ = i;
        end;

        u1.Client.HeartBaseRotations = v13;
    end;
end;