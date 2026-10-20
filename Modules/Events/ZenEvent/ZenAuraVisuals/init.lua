-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local SkyboxManager = require(ReplicatedStorage.Modules.SkyboxManager);
local Bezier_2 = require(ReplicatedStorage.Code.Bezier_2);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local _ = workspace.CurrentCamera;
local ChannelChi = ReplicatedStorage.GameEvents.Events.ZenEvent.ChannelChi;
local _ = (UserInputService.TouchEnabled and "Mobile" or "PC") == "Mobile";
local u2 = Lighting.ColorCorrection:Clone();
u2.Name = script.Name;
u2.Parent = Lighting;
local u3 = false;
local u4 = {};
local u5 = {
    Tranquil = {
        Brightness = 0.7,
        ColorCorrectionBrightness = 0.1,
        Sky = script.Sky,
        AmbientColor = Color3.fromRGB(154, 186, 235),
        TintColor = Color3.fromRGB(215, 236, 255),
        BeamSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
    },
    Corrupt = {
        Brightness = 0,
        ColorCorrectionBrightness = 0,
        Sky = script.Sky2,
        AmbientColor = Color3.fromRGB(255, 0, 0),
        TintColor = Color3.fromRGB(255, 255, 255),
        BeamSequence = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 100)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
    }
};

local function CreateEvent(p6) -- Line: 68
    -- upvalues: u3 (ref), u5 (copy), SkyboxManager (copy), TweenService (copy), Lighting (copy), u2 (copy), ReplicatedStorage (copy)
    if u3 == true then
        return;
    end;

    u3 = true;
    local u7 = u5[workspace:GetAttribute("CorruptZenAura") and "Corrupt" or "Tranquil"];
    SkyboxManager.UpdateSkybox(u7.Sky, 2);
    TweenService:Create(Lighting, TweenInfo.new(3), {
        ExposureCompensation = 0.425,
        Ambient = u7.AmbientColor,
        Brightness = u7.Brightness
    }):Play();
    TweenService:Create(u2, TweenInfo.new(3), {
        Contrast = u7.Contrast,
        Brightness = u7.ColorCorrectionBrightness,
        TintColor = u7.TintColor
    }):Play();
    game.Workspace.Terrain.Clouds.Enabled = true;
    game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(172, 205, 255);
    TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0.905,
        Density = 0.083
    }):Play();
    local v8 = script.ZenRings:Clone();
    v8.Parent = workspace.WeatherVisuals;

    for i, child in v8:GetChildren() do
        task.spawn(function() -- Line: 100
            -- upvalues: child (copy), i (copy), TweenService (ref), u7 (copy)
            local Position = child.Position;
            local v9 = child;
            v9.Position = v9.Position + Vector3.new(0, 1000, 0);
            task.wait(0.5 * i);
            TweenService:Create(child, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = Position
            }):Play();

            for _, child2 in child:GetChildren() do
                if child2:IsA("Beam") then
                    child2.Color = u7.BeamSequence;
                end;
            end;
        end);
    end;

    task.spawn(function() -- Line: 113
        -- upvalues: ReplicatedStorage (ref)
        task.wait(5);
        ReplicatedStorage.ZenAura.Value = true;
    end);

    if p6 then
    end;
end;

local function ResetEvent(p10) -- Line: 121
    -- upvalues: u3 (ref), SkyboxManager (copy), u5 (copy), ReplicatedStorage (copy), TweenService (copy), u2 (copy), Lighting (copy)
    if u3 == false then
        return;
    end;

    SkyboxManager.UpdateSkybox(u5.Tranquil.Sky, 0);
    SkyboxManager.UpdateSkybox(u5.Corrupt.Sky, 0);
    u3 = false;
    ReplicatedStorage.ZenAura.Value = false;
    TweenService:Create(u2, TweenInfo.new(3), {
        Brightness = 0,
        Contrast = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    TweenService:Create(Lighting, TweenInfo.new(3), {
        Ambient = Lighting:GetAttribute("DefaultAmbient"),
        ExposureCompensation = Lighting:GetAttribute("DefaultExposure"),
        Brightness = Lighting:GetAttribute("DefaultBrightness")
    }):Play();
    TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0,
        Density = 0
    }):Play();
    task.delay(3, function() -- Line: 146
        game.Workspace.Terrain.Clouds.Enabled = false;
        game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(22, 40, 70);
    end);
    local ZenRings = workspace.WeatherVisuals:FindFirstChild("ZenRings");

    if ZenRings then
        ZenRings.Name = "OLDzenrings";

        for i, child in ZenRings:GetChildren() do
            task.spawn(function() -- Line: 155
                -- upvalues: i (copy), TweenService (ref), child (copy)
                task.wait(0.25 * i);
                local v11 = TweenService:Create(child, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Position = child.Position + Vector3.new(0, 3000, 0)
                });
                v11:Play();
                v11.Completed:Wait();
                child:Destroy();
            end);
        end;

        task.wait(5);
        ZenRings:Destroy();
    end;

    if p10 then
    end;
end;

function u4.Start(p12) -- Line: 172
    -- upvalues: SkyboxManager (copy), u5 (copy), u1 (copy), ChannelChi (copy), Bezier_2 (copy), TweenService (copy), CreateEvent (copy), ResetEvent (copy)
    SkyboxManager.AddSkybox(u5.Tranquil.Sky, 0);
    SkyboxManager.AddSkybox(u5.Corrupt.Sky, 0);
    u1:Add(ChannelChi.OnClientEvent:Connect(function(p13: any, p14: any, p15: any, p16: boolean?) -- Line: 176
        -- upvalues: Bezier_2 (ref), TweenService (ref)
        local Position = (p13:GetPivot() * CFrame.new(0, 0, -5)).Position;
        local Position2 = p14.PrimaryPart.Position;
        local u17 = script.Wisp:Clone();
        u17.Position = Position;
        u17.Parent = workspace;

        if p16 then
            u17.Color = Color3.fromRGB(255, 75, 75);
            u17.Attachment.Chakra.Color = ColorSequence.new(Color3.fromRGB(60, 15, 15));
            u17.Attachment.Glow.Color = ColorSequence.new(Color3.fromRGB(135, 40, 40));
            u17.Trail.Color = ColorSequence.new(Color3.fromRGB(150, 0, 0));
            u17.Trail2.Color = ColorSequence.new(Color3.fromRGB(150, 0, 0));
            u17.Emit.Cubes.Color = ColorSequence.new(Color3.fromRGB(255, 25, 25));
            u17.Emit["Little Stars"].Color = ColorSequence.new(Color3.fromRGB(255, 25, 25));
        end;

        local function getRandomXZOffset() -- Line: 198
            local math_random_ret = math.random(-45, 45);

            return Vector3.new(math_random_ret, 0, math.random(-45, 45));
        end;

        local v18 = Position:Lerp(Position2, 0.33) + Vector3.new(0, 1, 0) * math.random(15, 20);
        local math_random_ret = math.random(-45, 45);
        local v19 = v18 + Vector3.new(math_random_ret, 0, math.random(-45, 45));
        local v20 = Position:Lerp(Position2, 0.66) + Vector3.new(0, 1, 0) * math.random(5, 10);
        local math_random_ret2 = math.random(-45, 45);
        local v21 = v20 + Vector3.new(math_random_ret2, 0, math.random(-45, 45));
        local v22 = Bezier_2.new(Position, v19, v21, Position2):CreateCFrameTween(u17, { "CFrame" }, (TweenInfo.new(p15, Enum.EasingStyle.Sine, Enum.EasingDirection.In)));
        game:GetService("Debris"):AddItem(u17, p15 + 3);
        v22:Play();
        v22.Completed:Once(function() -- Line: 213
            -- upvalues: TweenService (ref), u17 (copy)
            TweenService:Create(u17, TweenInfo.new(0.5), {
                Transparency = 1,
                Size = u17.Size * 1.5
            }):Play();

            for _, descendant in u17:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    if descendant.Enabled then
                        descendant.Enabled = false;
                    else
                        descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                    end;
                end;
            end;
        end);
    end));
    u1:Add(workspace:GetAttributeChangedSignal("CorruptZenAura"):Connect(function() -- Line: 226
        -- upvalues: CreateEvent (ref), ResetEvent (ref)
        if workspace:GetAttribute("CorruptZenAura") then
            CreateEvent();

            return;
        end;

        ResetEvent();
    end));

    if workspace:GetAttribute("CorruptZenAura") then
        task.defer(function() -- Line: 235
            -- upvalues: CreateEvent (ref)
            CreateEvent(true);
        end);
    else
        ResetEvent(true);
    end;

    u1:Add(workspace:GetAttributeChangedSignal("ZenAura"):Connect(function() -- Line: 242
        -- upvalues: CreateEvent (ref), ResetEvent (ref)
        if workspace:GetAttribute("ZenAura") then
            CreateEvent();

            return;
        end;

        ResetEvent();
    end));

    if workspace:GetAttribute("ZenAura") then
        task.defer(function() -- Line: 251
            -- upvalues: CreateEvent (ref)
            CreateEvent(true);
        end);

        return;
    end;

    ResetEvent(true);
end;

local u23 = false;
EventRotationController.EventUpdated:Connect(function(p24: string, p25: string) -- Line: 260, Name: OnEventUpdated
    -- upvalues: u1 (copy), u23 (ref), u4 (copy)
    if p25 ~= "ZenEvent" then
        u1:Clean();
        u23 = false;

        return;
    end;

    if u23 then
        return;
    end;

    u23 = true;
    u1:Clean();
    task.spawn(u4.Start, u4);
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "ZenEvent" then
    local _ = LoadedEvent.EventID;

    if LoadedEvent.EventSet == "ZenEvent" then
        if not u23 then
            u23 = true;
            u1:Clean();
            task.spawn(u4.Start, u4);
        end;
    else
        u1:Clean();
        u23 = false;
    end;
end;

return u4;