-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundData = require(ReplicatedStorage.Data.SoundData);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local Assets = ReplicatedStorage.Assets;
local Fireworks = Assets.Fireworks;
local u1 = {
    Bean = {
        SFX = "rbxassetid://134973227001448",
        Image = "rbxassetid://71279244204542"
    },
    Green = {
        SFX = "rbxassetid://138544319214265",
        Image = "rbxassetid://81941215051346"
    }
};
local u2 = {};

local function Create4thOfJulyFirework(p3, p4) -- Line: 13
    -- upvalues: Assets (copy), SoundPlayer (copy), Debris (copy), TweenService (copy)
    local v5 = Assets.JulyAssets.JulyFirework:Clone();
    local math_random_ret = math.random(-10, 10);
    local math_random_ret2 = math.random(40, 80);
    local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
    v5.CFrame = p3;
    v5.Parent = workspace;
    local v6 = p3.Position + Vector3_new_ret;
    local v7 = p3.Position + Vector3.new(0, Vector3_new_ret.Y, 0);
    local v8;

    if workspace:GetAttribute("2026Fireworks") then
        if math.random(3) == 1 then
            local u9 = { "269146157", "84355080907909", "139736861124279" };
            task.delay(2.5, function() -- Line: 35
                -- upvalues: SoundPlayer (ref), u9 (copy)
                SoundPlayer:PlaySound((`rbxassetid://{u9[math.random(#u9)]}`));
            end);
            v8 = 0;
        else
            v8 = 0;
        end;
    else
        SoundPlayer:PlaySound("rbxassetid://132449382613843");
        v8 = 0;
    end;

    while v8 < 1 do
        v8 = v8 + game:GetService("RunService").Heartbeat:Wait();
        local v10 = p3.Position:Lerp(v7, v8):Lerp(p3.Position:Lerp(v6, v8), v8 ^ 1.5);
        v5:PivotTo(CFrame.new(v10));
    end;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    Debris:AddItem(v5, 4);
    local v11 = Assets.JulyAssets.Boom:Clone();
    v11.Parent = workspace.Visuals;
    v11.CFrame = v5.CFrame;

    for _, descendant in v11:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") and not p4 then
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 92
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 98
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 105
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
                TweenService:Create(descendant.ImageLabel.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v11, 10);
end;

local v12 = {};

local function CreatePhysicalFirework(p13, p14) -- Line: 123
    -- upvalues: Assets (copy), Debris (copy), TweenService (copy)
    local v15 = Assets.JulyAssets.FireworkWithVFX:Clone();
    v15:PivotTo(p13);
    v15.Parent = workspace;
    local v16 = 0;

    while v16 < 1 do
        v16 = v16 + game:GetService("RunService").Heartbeat:Wait();
        v15:PivotTo(p13:Lerp(p13 * CFrame.new(0, 120, 0), v16 / 1));
    end;

    for _, descendant in v15:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Transparency = 1;
            descendant.CanQuery = false;
        end;
    end;

    Debris:AddItem(v15, 4);
    local v17 = Assets.JulyAssets.Boom:Clone();
    v17.Parent = workspace.Visuals;
    v17.CFrame = v15:GetPivot();

    for _, descendant in v17:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") and not p14 then
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 189
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 195
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 202
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
                TweenService:Create(descendant.ImageLabel.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v17, 10);
end;

for i, _ in u1 do
    table.insert(u2, i);
end;

local u18 = {
    Boo = {
        SFX = "rbxassetid://12229501",
        Image = "rbxassetid://0"
    }
};
local u19 = {};

local function CreateBeanstalkFirework(p20) -- Line: 236
    -- upvalues: Fireworks (copy), u2 (copy), SoundPlayer (copy), u1 (copy), Debris (copy), TweenService (copy)
    local BeanstalkAssets = Fireworks.BeanstalkAssets;
    local v21 = BeanstalkAssets.BeanstalkFirework:Clone();
    local math_random_ret = math.random(-10, 10);
    local math_random_ret2 = math.random(40, 80);
    local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
    v21.CFrame = p20;
    v21.Parent = workspace;
    local v22 = p20.Position + Vector3_new_ret;
    local v23 = p20.Position + Vector3.new(0, Vector3_new_ret.Y, 0);
    local u24 = u2[math.random(1, #u2)];
    SoundPlayer:PlaySound("rbxassetid://132449382613843");
    task.delay(1.4, function() -- Line: 268
        -- upvalues: SoundPlayer (ref), u1 (ref), u24 (copy)
        SoundPlayer:PlaySound(u1[u24].SFX, {
            PlaybackSpeed = math.random(90, 110) / 100
        });
    end);
    local v25 = 0;

    while v25 < 1 do
        v25 = v25 + game:GetService("RunService").Heartbeat:Wait();
        local v26 = p20.Position:Lerp(v23, v25):Lerp(p20.Position:Lerp(v22, v25), v25 ^ 1.5);
        v21:PivotTo(CFrame.new(v26));
    end;

    for _, descendant in v21:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    Debris:AddItem(v21, 4);
    local v27 = BeanstalkAssets.Boom:Clone();
    v27.Parent = workspace.Visuals;
    v27.CFrame = v21.CFrame;

    for _, descendant in v27:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = true;
            descendant.ImageLabel.Image = u1[u24].Image;
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 329
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 335
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 342
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v27, 10);
end;

for i, _ in u18 do
    table.insert(u19, i);
end;

local function CreateHalloweenFirework(p28) -- Line: 372
    -- upvalues: Fireworks (copy), u19 (copy), SoundPlayer (copy), u18 (copy), Debris (copy), TweenService (copy)
    local HalloweenAssets = Fireworks.HalloweenAssets;
    local u29 = HalloweenAssets.HalloweenFirework:Clone();
    local math_random_ret = math.random(-10, 10);
    local math_random_ret2 = math.random(40, 80);
    local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
    u29.CFrame = p28;
    u29.Parent = workspace;
    local v30 = p28.Position + Vector3_new_ret;
    local v31 = p28.Position + Vector3.new(0, Vector3_new_ret.Y, 0);
    local u32 = u19[math.random(1, #u19)];
    SoundPlayer:PlaySound("rbxassetid://132449382613843");
    task.delay(1.4, function() -- Line: 403
        -- upvalues: SoundPlayer (ref), u18 (ref), u32 (copy), u29 (copy)
        SoundPlayer:PlaySound(u18[u32].SFX, {
            PlaybackSpeed = math.random(90, 110) / 100
        }, u29.CFrame.Position);
    end);
    local v33 = 0;

    while v33 < 1 do
        v33 = v33 + game:GetService("RunService").Heartbeat:Wait();
        local v34 = p28.Position:Lerp(v31, v33):Lerp(p28.Position:Lerp(v30, v33), v33 ^ 1.5);
        u29:PivotTo(CFrame.new(v34));
    end;

    for _, descendant in u29:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    Debris:AddItem(u29, 4);
    local v35 = HalloweenAssets.Boom:Clone();
    v35.Parent = workspace.Visuals;
    v35.CFrame = u29.CFrame;

    for _, descendant in v35:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = true;
            descendant.ImageLabel.Image = u18[u32].Image;
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 466
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 472
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 479
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v35, 10);
end;

local function CreateSkyLantern(p36) -- Line: 497
    -- upvalues: Fireworks (copy), Debris (copy), RunService (copy), TweenService (copy)
    local Position = p36.Position;
    local LookVector = p36.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local CFrame_new_ret = CFrame.new(Position, Position + Unit);
    local u37 = Fireworks.SkyLantern.SkyLantern:Clone();
    u37.Parent = workspace.Visuals;
    u37:PivotTo(CFrame_new_ret);
    local math_random_ret = math.random(40, 80);
    local math_random_ret2 = math.random(8, 15);
    local math_random_ret3 = math.random(1, 3);
    local math_random_ret4 = math.random(1, 3);
    local u38 = math.random(60, 100) / 100;
    local u39 = math.random(40, 80) / 100;
    local u40 = math.random(8, 20) / 100;

    if math.random(0, 1) == 0 then
        u40 = -u40;
    end;

    local u41 = CFrame_new_ret * CFrame.new(0, math_random_ret, 0);
    Debris:AddItem(u37, math_random_ret2);
    local u42 = {};

    for _, descendant in u37:GetDescendants() do
        if descendant:IsA("Light") then
            table.insert(u42, descendant);
            descendant:SetAttribute("BaseBrightness", descendant.Brightness);
        end;
    end;

    task.spawn(function() -- Line: 542
        -- upvalues: math_random_ret2 (copy), RunService (ref), CFrame_new_ret (copy), u41 (copy), u38 (copy), math_random_ret3 (copy), u39 (copy), math_random_ret4 (copy), u40 (ref), u37 (copy), u42 (copy)
        local v43 = 0;

        while v43 < math_random_ret2 do
            v43 = v43 + RunService.Heartbeat:Wait();
            local v44 = CFrame_new_ret:Lerp(u41, (math.clamp(v43 / math_random_ret2, 0, 1)));
            local v45 = math.sin(v43 * u38) * math_random_ret3;
            local v46 = math.cos(v43 * u39) * math_random_ret4;
            local CFrame_new_ret2 = CFrame.new(v45, 0, v46);
            local CFrame_Angles_ret = CFrame.Angles(0, v43 * u40, 0);
            u37:PivotTo(v44 * CFrame_new_ret2 * CFrame_Angles_ret);

            for _, v in u42 do
                v.Brightness = (v:GetAttribute("BaseBrightness") or v.Brightness) * (1 + math.random(-10, 10) / 100);
            end;
        end;
    end);
    task.wait(math_random_ret2 - 3);

    for _, descendant in u37:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(3), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("Light") then
            TweenService:Create(descendant, TweenInfo.new(3), {
                Brightness = 0
            }):Play();
        end;
    end;
end;

local function CreateChristmasFirework(p47) -- Line: 587
    -- upvalues: Fireworks (copy), SoundPlayer (copy), SoundData (copy), Debris (copy), TweenService (copy)
    local ChristmasAssets = Fireworks.ChristmasAssets;
    local u48 = ChristmasAssets.ChristmasFirework:Clone();
    local math_random_ret = math.random(-10, 10);
    local math_random_ret2 = math.random(40, 80);
    local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
    u48.CFrame = p47;
    u48.Parent = workspace;
    local v49 = p47.Position + Vector3_new_ret;
    local v50 = p47.Position + Vector3.new(0, Vector3_new_ret.Y, 0);
    SoundPlayer:PlaySound("rbxassetid://132449382613843");
    task.delay(1.1, function() -- Line: 606
        -- upvalues: SoundPlayer (ref), SoundData (ref), u48 (copy)
        SoundPlayer:PlaySound(SoundData.Weather.FestiveNight.FestiveBells, {
            FadeOutDuration = 3
        }, u48.CFrame.Position);
    end);
    local v51 = 0;

    while v51 < 1 do
        v51 = v51 + game:GetService("RunService").Heartbeat:Wait();
        local v52 = p47.Position:Lerp(v50, v51):Lerp(p47.Position:Lerp(v49, v51), v51 ^ 1.5);
        u48:PivotTo(CFrame.new(v52));
    end;

    for _, descendant in u48:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    Debris:AddItem(u48, 4);
    local v53 = ChristmasAssets.Boom:Clone();
    v53.Parent = workspace.Visuals;
    v53.CFrame = u48.CFrame;

    for _, descendant in v53:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = true;
            descendant.ImageLabel.Image = "rbxassetid://0";
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 667
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 673
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 680
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v53, 10);
end;

local function CreateDragonsFirework(p54: any, p55: any, p56) -- Line: 694
    -- upvalues: ReplicatedStorage (copy), Fireworks (copy), SoundPlayer (copy), SoundData (copy), Debris (copy), TweenService (copy)
    local Bezier = require(ReplicatedStorage.Code.Bezier);
    local DragonsFireworkAssets = Fireworks.DragonsFireworkAssets;
    local u57 = DragonsFireworkAssets.DragonsFirework:Clone();
    local math_random_ret = math.random(-10, 10);
    local math_random_ret2 = math.random(40, 80);
    local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
    u57.CFrame = p54;
    u57.Parent = workspace;
    local v58 = p54.Position + Vector3_new_ret;
    local v59 = p54.Position + Vector3.new(0, Vector3_new_ret.Y, 0);
    SoundPlayer:PlaySound("rbxassetid://132449382613843", {
        Volume = 1.3,
        RollOffMinDistance = 25,
        RollOffMaxDistance = 250
    }, nil, u57);
    task.delay(1.1, function() -- Line: 723
        -- upvalues: SoundPlayer (ref), SoundData (ref), u57 (copy)
        SoundPlayer:PlaySound(SoundData.Weather.Volcano.FireBallVolcano_GrowAGarden, {
            Volume = 1.3,
            RollOffMinDistance = 25,
            RollOffMaxDistance = 250,
            FadeOutDuration = 1
        }, u57.CFrame.Position);
    end);
    local v60 = 0;

    if p56 then
        while v60 < 1 do
            v60 = v60 + game:GetService("RunService").Heartbeat:Wait();
            local Position = p54.Position;
            local Position2 = p56.Position;
            local v61 = (Position + Position2) / 4 + Vector3.new(0, Position.Y + 60, 0);
            local v62 = Bezier.new(Position, v61, Position2):Get(game.TweenService:GetValue(v60 / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) ^ 1.5);
            u57:PivotTo(CFrame.new(v62));
        end;
    else
        while v60 < 1 do
            v60 = v60 + game:GetService("RunService").Heartbeat:Wait();
            local v63 = p54.Position:Lerp(v59, v60):Lerp(p54.Position:Lerp(v58, v60), v60 ^ 1.5);
            u57:PivotTo(CFrame.new(v63));
        end;
    end;

    for _, descendant in u57:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    Debris:AddItem(u57, 4);
    local v64 = DragonsFireworkAssets.Boom:Clone();
    v64.Parent = workspace.Visuals;
    v64.CFrame = u57.CFrame;

    for _, descendant in v64:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = true;
            descendant.ImageLabel.Image = "rbxassetid://0";
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 803
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 809
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 816
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v64, 10);
end;

local u65 = { Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 85, 0), Color3.fromRGB(255, 0, 0) };

local function CreateNewYearsFirework(p66, p67) -- Line: 836
    -- upvalues: ReplicatedStorage (copy), Fireworks (copy), SoundPlayer (copy), SoundData (copy), Debris (copy), u65 (copy), TweenService (copy)
    require(ReplicatedStorage.Code.Bezier);
    local NewYearsFireworkAssets = Fireworks.NewYearsFireworkAssets;
    local u68 = NewYearsFireworkAssets.NewYearsFirework:Clone();
    local math_random_ret = math.random(-10, 10);
    local math_random_ret2 = math.random(40, 80);
    local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
    u68.CFrame = p66;
    u68.Parent = workspace;
    local v69 = p66.Position + Vector3_new_ret;
    local v70 = p66.Position + Vector3.new(0, Vector3_new_ret.Y, 0);
    SoundPlayer:PlaySound("rbxassetid://132449382613843", {
        Volume = 1.3,
        RollOffMinDistance = 25,
        RollOffMaxDistance = 250
    }, nil, u68);
    task.delay(1.1, function() -- Line: 865
        -- upvalues: SoundPlayer (ref), SoundData (ref), u68 (copy)
        SoundPlayer:PlaySound(SoundData.Weather.Stoplight.WinSound, {
            Volume = 0.3,
            RollOffMinDistance = 25,
            RollOffMaxDistance = 250,
            FadeOutDuration = 1,
            PlaybackSpeed = math.random(95, 105) / 100
        }, u68.CFrame.Position);
    end);
    local v71 = 0;

    while v71 < 1 do
        v71 = v71 + game:GetService("RunService").Heartbeat:Wait();
        local v72 = p66.Position:Lerp(v70, v71):Lerp(p66.Position:Lerp(v69, v71), v71 ^ 1.5);
        u68:PivotTo(CFrame.new(v72));
    end;

    for _, descendant in u68:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    Debris:AddItem(u68, 4);
    local v73 = NewYearsFireworkAssets.Boom:Clone();
    v73.Parent = workspace.Visuals;
    v73.CFrame = u68.CFrame;

    for _, descendant in v73:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = true;
            descendant.ImageLabel.Image = "rbxassetid://103894346519582";
            descendant.ImageLabel.ImageColor3 = u65[math.random(1, #u65)];
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Brightness = 25
            }):Play();
            TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 3
            }):Play();
            TweenService:Create(descendant.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.435, 0)
            }):Play();
            task.delay(0.3, function() -- Line: 928
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 2
                }):Play();
            end);
            task.delay(0.5, function() -- Line: 934
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel.UIScale, TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 4
                }):Play();
            end);
            task.delay(5, function() -- Line: 941
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v73, 10);
end;

local u82 = {
    Firework = function(p74, ...) -- Line: 956
        -- upvalues: Create4thOfJulyFirework (copy)
        Create4thOfJulyFirework(p74, ...);
    end,

    ["4thOfJuly"] = function(p75, ...) -- Line: 961
        -- upvalues: Create4thOfJulyFirework (copy)
        Create4thOfJulyFirework(p75, ...);
    end,

    Beanworks = function(p76, ...) -- Line: 964
        -- upvalues: CreateBeanstalkFirework (copy)
        CreateBeanstalkFirework(p76, ...);
    end,

    ["Sky Lantern"] = function(p77, ...) -- Line: 967
        -- upvalues: CreateSkyLantern (copy)
        CreateSkyLantern(p77, ...);
    end,

    Frightwork = function(p78, ...) -- Line: 970
        -- upvalues: CreateHalloweenFirework (copy)
        CreateHalloweenFirework(p78, ...);
    end,

    ["Christmas Firework"] = function(p79, ...) -- Line: 973
        -- upvalues: CreateChristmasFirework (copy)
        CreateChristmasFirework(p79, ...);
    end,

    ["Dragon\'s Firework"] = function(p80, ...) -- Line: 976
        -- upvalues: CreateDragonsFirework (copy)
        CreateDragonsFirework(p80, ...);
    end,

    ["New Year\'s Firework"] = function(p81, ...) -- Line: 979
        -- upvalues: CreateNewYearsFirework (copy)
        CreateNewYearsFirework(p81, ...);
    end
};

function v12.Force_Create_Firework(p83: any, p84: any, p85: string?, ...) -- Line: 995
    -- upvalues: u82 (copy)
    local v86 = u82[p85 or "Firework"];

    if v86 then
        task.spawn(v86, p83, p84, ...);

        return;
    end;

    warn("Firework Type does not exist!");
end;

ReplicatedStorage.GameEvents.FireworkVisual.OnClientEvent:Connect(function(p87: any, p88: any, p89: string?, ...) -- Line: 984, Name: CreateFirework
    -- upvalues: u82 (copy)
    local v90 = u82[p89 or "Firework"];

    if v90 then
        task.spawn(v90, p87, p88, ...);

        return;
    end;

    warn("Firework Type does not exist!");
end);
ReplicatedStorage.GameEvents.PhysicalFirework.OnClientEvent:Connect(CreatePhysicalFirework);

return v12;