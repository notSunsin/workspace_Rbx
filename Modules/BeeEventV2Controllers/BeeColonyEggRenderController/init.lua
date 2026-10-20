-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
local Entries = BeeEggRegistry.Entries;
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local EggInfoFader = require(ReplicatedStorage.Modules.BeeEventV2Controllers.EggInfoFader);
require(ReplicatedStorage.Data.SoundData);
require(ReplicatedStorage.Modules.SoundPlayer);
local RaycastClickDetectorService = require(ReplicatedStorage.Modules.RaycastClickDetectorService);
local GameEvents = ReplicatedStorage.GameEvents;
local HatchBeeSwarmEgg = GameEvents.BizzyBeeEvent:WaitForChild("HatchBeeSwarmEgg");
local SkipBeeEggHatchTime = GameEvents.BizzyBeeEvent:WaitForChild("SkipBeeEggHatchTime");
local script_Sounds = script.Sounds;
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(140, 140, 140);
local TweenInfo_new_ret = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Highlight = Instance.new("Highlight");
Highlight.FillTransparency = 1;
Highlight.OutlineColor = Color3_fromRGB_ret;
Highlight.OutlineTransparency = 0;
Highlight.Parent = ReplicatedStorage;
local u1 = nil;
local u2 = false;

local function TweenHighlightColor(p3) -- Line: 36
    -- upvalues: u1 (ref), TweenService (copy), Highlight (copy), TweenInfo_new_ret (copy)
    if u1 then
        u1:Cancel();
    end;

    u1 = TweenService:Create(Highlight, TweenInfo_new_ret, {
        OutlineColor = p3
    });
    u1:Play();
end;

UserInputService.InputBegan:Connect(function(p4, p5) -- Line: 42
    -- upvalues: Highlight (copy), u2 (ref), Color3_fromRGB_ret2 (copy), u1 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if p5 then
        return;
    end;

    if p4.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return;
    end;

    if not Highlight.Adornee then
        return;
    end;

    u2 = true;

    if u1 then
        u1:Cancel();
    end;

    u1 = TweenService:Create(Highlight, TweenInfo_new_ret, {
        OutlineColor = Color3_fromRGB_ret2
    });
    u1:Play();
end);
UserInputService.InputEnded:Connect(function(p6) -- Line: 50
    -- upvalues: u2 (ref), Color3_fromRGB_ret (copy), u1 (ref), TweenService (copy), Highlight (copy), TweenInfo_new_ret (copy)
    if p6.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return;
    end;

    if not u2 then
        return;
    end;

    u2 = false;

    if u1 then
        u1:Cancel();
    end;

    u1 = TweenService:Create(Highlight, TweenInfo_new_ret, {
        OutlineColor = Color3_fromRGB_ret
    });
    u1:Play();
end);
local BeeEggs = ReplicatedStorage.Assets.Models.BeeEggs;
local EggInfo = ReplicatedStorage.Modules.BeeEventV2Controllers.BeeColonyEggShopController.EggInfo;
local v7 = {};
local LocalPlayer = Players.LocalPlayer;
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = {};
local u13 = {};
local u14 = nil;
local u15 = false;
local LastInputType = UserInputService:GetLastInputType();

local function TweenPivot(p16: userdata, p17, p18: number, p19: any, p20: any) -- Line: 78
    -- upvalues: TweenService (copy)
    if not (p16 and p16.Parent) then
        return;
    end;

    local Pivot = p16:GetPivot();
    local v21 = 0;
    local v22 = p19 or Enum.EasingStyle.Sine;

    if not p20 then
        p20 = Enum.EasingDirection.Out;
    end;

    while v21 < p18 do
        local v23 = v21 + task.wait();
        v21 = math.min(v23, p18);

        if not p16.Parent then
            return;
        end;

        p16:PivotTo(Pivot:Lerp(p17, (TweenService:GetValue(v21 / p18, v22, p20))));
    end;

    if p16.Parent then
        p16:PivotTo(p17);
    end;
end;

local function CreateSparkleVFX(p24: userdata) -- Line: 96
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "BeeEggSparkleAttachment";
    Attachment.Parent = p24;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 80), Color3.fromRGB(255, 180, 0));
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 1);
    ParticleEmitter.Rate = 6;
    ParticleEmitter.Speed = NumberRange.new(0.5, 1.5);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.Parent = Attachment;

    return ParticleEmitter;
end;

local function PlayShake(p25: userdata, p26) -- Line: 117
    -- upvalues: TweenPivot (copy)
    TweenPivot(p25, p26 * CFrame.new(0, 0.3, 0) * CFrame.Angles(0, 0, 0.3490658503988659), 0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    TweenPivot(p25, p26 * CFrame.new(0, 0.3, 0) * CFrame.Angles(0, 0, -0.3490658503988659), 0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    TweenPivot(p25, p26, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
end;

local function StartShakeLoop(p27: userdata, u28: userdata) -- Line: 130
    -- upvalues: u12 (copy), CreateSparkleVFX (copy), PlayShake (copy)
    if u12[p27] then
        return;
    end;

    local PrimaryPart = u28.PrimaryPart;

    if not PrimaryPart then
        return;
    end;

    local u29 = {
        Running = true,
        Model = u28,
        BaseCFrame = u28:GetPivot(),
        Sparkle = CreateSparkleVFX(PrimaryPart)
    };
    u12[p27] = u29;
    task.spawn(function() -- Line: 144
        -- upvalues: u29 (copy), u28 (copy), PlayShake (ref)
        while u29.Running do
            task.wait(1 + math.random() * 2);

            if not (u29.Running and u28.Parent) then
                break;
            end;

            pcall(PlayShake, u28, u29.BaseCFrame);
        end;
    end);
end;

local function StopShakeLoop(p30: userdata) -- Line: 153
    -- upvalues: u12 (copy), Debris (copy)
    local v31 = u12[p30];

    if not v31 then
        return;
    end;

    v31.Running = false;

    if v31.Sparkle then
        v31.Sparkle.Enabled = false;
        local Parent = v31.Sparkle.Parent;

        if Parent then
            Debris:AddItem(Parent, 1.5);
        end;
    end;

    u12[p30] = nil;
end;

local function HideDuplicateEggs(p32: userdata, p33: userdata) -- Line: 167
    for _, child in p32:GetChildren() do
        if child ~= p33 and (child:IsA("Model") or child:IsA("BasePart")) then
            local v34 = child;

            for _, descendant in child:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.LocalTransparencyModifier = 1;
                end;
            end;

            if v34:IsA("BasePart") then
                v34.LocalTransparencyModifier = 1;
            end;
        end;
    end;
end;

local function ShakeCamera(u35: number, u36: number) -- Line: 183
    -- upvalues: RunService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local os_clock_ret = os.clock();
    local u37 = nil;
    u37 = RunService.RenderStepped:Connect(function() -- Line: 188
        -- upvalues: os_clock_ret (copy), u36 (copy), u37 (ref), u35 (copy), workspace_CurrentCamera (copy)
        local v38 = os.clock() - os_clock_ret;

        if u36 <= v38 then
            u37:Disconnect();

            return;
        end;

        local v39 = 1 - v38 / u36;
        local v40 = (math.random() - 0.5) * 2 * u35 * v39;
        local v41 = (math.random() - 0.5) * 2 * u35 * v39;
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(v40, v41, 0);
    end);
end;

local function CreateScreenFlash() -- Line: 201
    -- upvalues: Players (copy), TweenService (copy), Debris (copy)
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");

    if not PlayerGui then
        return;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "HatchFlash";
    ScreenGui.DisplayOrder = 999;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame.BackgroundTransparency = 0;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    task.delay(0.05, function() -- Line: 217
        -- upvalues: TweenService (ref), Frame (copy)
        TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end);
    Debris:AddItem(ScreenGui, 0.7);
end;

local u42 = {
    ColorSequence.new(Color3.fromRGB(255, 230, 80), Color3.fromRGB(255, 160, 0)),
    ColorSequence.new(Color3.fromRGB(255, 200, 50), Color3.fromRGB(255, 120, 0)),
    ColorSequence.new(Color3.fromRGB(255, 245, 150), Color3.fromRGB(255, 180, 30)),
    ColorSequence.new(Color3.fromRGB(255, 210, 70), Color3.fromRGB(255, 140, 10))
};

local function CreateEnergyBeams(p43: userdata, p44) -- Line: 233
    -- upvalues: u42 (copy)
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "BeamCenter";
    Attachment.Parent = p43;
    local v45 = {};
    local v46 = {};

    for i = 1, 4 do
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Name = "BeamOrbit_" .. i;
        Attachment2.Parent = p43;
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        Beam.Color = u42[i];
        Beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(0.5, 0.3), NumberSequenceKeypoint.new(1, 0.8) });
        Beam.Width0 = 0.05;
        Beam.Width1 = 0.15;
        Beam.LightEmission = 1;
        Beam.LightInfluence = 0;
        Beam.FaceCamera = true;
        Beam.CurveSize0 = 1.5;
        Beam.CurveSize1 = -1.5;
        Beam.Segments = 12;
        Beam.TextureSpeed = 2;
        Beam.Parent = p43;
        v45[i] = Attachment2;
        v46[i] = Beam;
        local _ = i;
    end;

    return Attachment, v45, v46;
end;

local function PlayHatchAnimation(p47: userdata, u48: userdata) -- Line: 273
    -- upvalues: u12 (copy), Debris (copy), HideDuplicateEggs (copy), script_Sounds (copy), Entries (copy), CreateEnergyBeams (copy), TweenService (copy), TweenPivot (copy), CreateScreenFlash (copy), RunService (copy)
    local v49 = u12[p47];

    if v49 then
        v49.Running = false;

        if v49.Sparkle then
            v49.Sparkle.Enabled = false;
            local Parent = v49.Sparkle.Parent;

            if Parent then
                Debris:AddItem(Parent, 1.5);
            end;
        end;

        u12[p47] = nil;
    end;

    HideDuplicateEggs(p47, u48);
    script_Sounds.Open:Play();
    script_Sounds.Riser:Play();
    local PrimaryPart = u48.PrimaryPart;

    if not PrimaryPart then
        return;
    end;

    local Pivot = u48:GetPivot();
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = PrimaryPart;
    task.delay(6, function() -- Line: 290
        -- upvalues: Attachment (copy)
        if Attachment.Parent then
            Attachment:Destroy();
        end;
    end);
    local v50 = p47:GetAttribute("HatchedFrom") or "Common Bee Egg";
    local v51 = Entries[v50];
    local v52 = v51 and v51.Color or Color3.fromRGB(255, 220, 60);

    if v50 == "Common Bee Egg" then
        v52 = Color3.fromRGB(255, 220, 60);
    end;

    local PointLight = Instance.new("PointLight");
    PointLight.Color = v52;
    PointLight.Brightness = 0;
    PointLight.Range = 0;
    PointLight.Parent = PrimaryPart;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 80), Color3.fromRGB(255, 130, 30));
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.5, 0.3), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 1);
    ParticleEmitter.Speed = NumberRange.new(2, 6);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-200, 200);
    ParticleEmitter.Rate = 10;
    ParticleEmitter.Parent = Attachment;
    local v53, u54, u55 = CreateEnergyBeams(PrimaryPart, Pivot);
    local u56 = {};
    local u57 = {};

    for i = 1, 8 do
        local v58 = (i - 1) * 0.7853981633974483;
        local v59 = math.cos(v58) * 10;
        local v60 = math.sin(v58) * 10;
        local Vector3_new_ret = Vector3.new(v59, (i % 3 - 1) * 2, v60);
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = PrimaryPart;
        Attachment2.Position = Vector3_new_ret;
        Attachment2.CFrame = CFrame.lookAt(Vector3_new_ret, Vector3.new(0, 0, 0));
        local ParticleEmitter2 = Instance.new("ParticleEmitter");
        ParticleEmitter2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 220, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 230, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 220)) });
        ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 0) });
        ParticleEmitter2.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.6),
            NumberSequenceKeypoint.new(0.3, 0.1),
            NumberSequenceKeypoint.new(0.9, 0.3),
            NumberSequenceKeypoint.new(1, 1)
        });
        ParticleEmitter2.Lifetime = NumberRange.new(0.5, 1);
        ParticleEmitter2.Speed = NumberRange.new(8, 14);
        ParticleEmitter2.SpreadAngle = Vector2.new(15, 15);
        ParticleEmitter2.LightEmission = 1;
        ParticleEmitter2.Rotation = NumberRange.new(0, 360);
        ParticleEmitter2.RotSpeed = NumberRange.new(-100, 100);
        ParticleEmitter2.Rate = 0;
        ParticleEmitter2.Parent = Attachment2;
        table.insert(u56, Attachment2);
        table.insert(u57, ParticleEmitter2);
        local _ = i;
    end;

    local u61 = true;
    local u62 = 0;
    task.spawn(function() -- Line: 375
        -- upvalues: u48 (copy), u61 (ref), TweenService (ref), PointLight (copy), ParticleEmitter (copy), u56 (copy), u62 (ref), u57 (copy), u54 (copy), u55 (copy)
        local v63 = 0;

        while v63 < 3.5 and (u48.Parent and u61) do
            local task_wait_ret = task.wait();
            v63 = math.min(v63 + task_wait_ret, 3.5);

            if not u48.Parent then
                return;
            end;

            local Value = TweenService:GetValue(v63 / 3.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
            u48:ScaleTo(1 + 0.8 * Value);
            PointLight.Brightness = Value * 0.4;
            PointLight.Range = Value * 5;
            ParticleEmitter.Rate = 10 + Value * 90;
            local v64 = Value * 35;
            local v65 = 10 * (1 - Value * 0.6);

            for i, v in u56 do
                local v66 = (i - 1) * 0.7853981633974483 + u62 * 0.3;
                local v67 = math.sin(u62 * 1.5 + i) * (1 + Value * 2);
                local v68 = math.cos(v66) * v65;
                local v69 = math.sin(v66) * v65;
                local Vector3_new_ret = Vector3.new(v68, v67, v69);
                v.CFrame = CFrame.lookAt(Vector3_new_ret, Vector3.new(0, 0, 0));
                u57[i].Rate = v64;
                u57[i].Speed = NumberRange.new(8 + Value * 10, 14 + Value * 15);
            end;

            u62 = u62 + (0.3 + Value * 8) * task_wait_ret;
            local v70 = 3.5 * (1 - Value * 0.7);

            for i, v in u54 do
                local v71 = (i - 1) * 1.5707963267948966 + u62;
                local v72 = math.sin(u62 * 2 + i) * (0.5 + Value * 1);
                local v73 = math.cos(v71) * v70;
                local v74 = math.sin(v71) * v70;
                v.Position = Vector3.new(v73, v72, v74);
            end;

            for _, v in u55 do
                v.Width0 = 0.05 + Value * 0.4;
                v.Width1 = 0.15 + Value * 0.6;
                v.CurveSize0 = 1.5 - Value * 1.2;
                v.CurveSize1 = -1.5 + Value * 1.2;
                v.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6 - Value * 0.5), NumberSequenceKeypoint.new(0.5, 0.3 - Value * 0.25), NumberSequenceKeypoint.new(1, 0.8 - Value * 0.5) });
            end;

            if Value > 0.15 then
                local v75 = (Value - 0.15) * 0.15;
                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    local v76 = (math.random() - 0.5) * 2 * v75;
                    local v77 = (math.random() - 0.5) * 2 * v75;
                    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(v76, v77, 0);
                end;
            end;
        end;
    end);
    local v78 = 0;

    while v78 < 3.5 and u48.Parent do
        local v79 = v78 + task.wait();
        v78 = math.min(v79, 3.5);

        if not u48.Parent then
            return;
        end;

        local v80 = v78 / 3.5;
        local Value = TweenService:GetValue(v80, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
        local math_rad_ret = math.rad(3 + Value * 42);
        local v81 = 1.5 + Value * 14;
        local v82 = TweenService:GetValue(v80, Enum.EasingStyle.Cubic, Enum.EasingDirection.In) * 3.141592653589793 * 6;
        local v83 = math.sin(v78 * v81) * math_rad_ret;
        local v84 = math.cos(v78 * v81 * 0.7) * math_rad_ret * 0.4;
        local math_sin_ret = math.sin(v78 * v81 * 0.5);
        local v85 = math.abs(math_sin_ret) * (Value * 1.2);
        u48:PivotTo(Pivot * CFrame.new(0, v85, 0) * CFrame.Angles(v84, v82, v83));
    end;

    u61 = false;
    TweenPivot(u48, Pivot * CFrame.new(0, 1.5, 0), 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    for _, v in u54 do
        v.Position = Vector3.new(0, 0, 0);
    end;

    for _, v in u55 do
        v.Width0 = 0.6;
        v.Width1 = 0.6;
        v.Transparency = NumberSequence.new(0);
    end;

    task.wait(0.15);

    for _, v in u55 do
        v:Destroy();
    end;

    for _, v in u54 do
        v:Destroy();
    end;

    v53:Destroy();
    ParticleEmitter.Enabled = false;

    for _, v in u56 do
        v:Destroy();
    end;

    local Position = PrimaryPart.Position;
    local v86 = {};

    for _, descendant in u48:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            local v87 = descendant.Position - Position;
            local v88;

            if v87.Magnitude > 0.05 then
                v88 = v87.Unit;
            else
                local v89 = math.random() - 0.5;
                local v90 = math.random() * 0.5 + 0.5;
                local v91 = math.random() - 0.5;
                v88 = Vector3.new(v89, v90, v91).Unit;
            end;

            table.insert(v86, {
                Part = descendant,
                OrigCFrame = descendant.CFrame,
                OrigColor = descendant.Color,
                Dir = v88
            });
        end;
    end;

    for _, descendant in u48:GetDescendants() do
        if descendant:IsA("JointInstance") or (descendant:IsA("WeldConstraint") or descendant:IsA("Constraint")) then
            descendant:Destroy();
        end;
    end;

    for _, v in v86 do
        v.Part.Anchored = true;
    end;

    local Highlight2 = Instance.new("Highlight");
    Highlight2.FillColor = Color3.fromRGB(255, 230, 100);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.fromRGB(255, 200, 50);
    Highlight2.OutlineTransparency = 0.5;
    Highlight2.Adornee = u48;
    Highlight2.Parent = u48;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = PrimaryPart;
    local v92 = {};

    for i, v in v86 do
        if i > 6 then
            break;
        end;

        local Attachment3 = Instance.new("Attachment");
        Attachment3.Parent = v.Part;
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment2;
        Beam.Attachment1 = Attachment3;
        Beam.Color = ColorSequence.new(Color3.fromRGB(255, 245, 180), Color3.fromRGB(255, 200, 60));
        Beam.Transparency = NumberSequence.new(0.8);
        Beam.Width0 = 0.02;
        Beam.Width1 = 0.05;
        Beam.LightEmission = 1;
        Beam.LightInfluence = 0;
        Beam.FaceCamera = true;
        Beam.Segments = 1;
        Beam.Parent = PrimaryPart;
        table.insert(v92, {
            Beam = Beam,
            Att = Attachment3
        });
    end;

    script_Sounds.Crack:Play();
    local os_clock_ret = os.clock();

    while os.clock() - os_clock_ret < 0.7 and u48.Parent do
        task.wait();
        local v93 = (os.clock() - os_clock_ret) / 0.7;
        local Value = TweenService:GetValue(math.min(v93, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out);
        local v94 = os.clock() - os_clock_ret;

        for _, v in v86 do
            local v95 = v94 * (3 + v.Dir.X * 4);
            v.Part.CFrame = CFrame.new(v.OrigCFrame.Position + v.Dir * 3.5 * Value) * v.OrigCFrame.Rotation * CFrame.Angles(0, v95, v95 * 0.3);
            v.Part.Color = v.OrigColor:Lerp(Color3.fromRGB(255, 240, 180), Value * 0.7);
        end;

        for _, v in v92 do
            v.Beam.Width0 = 0.02 + Value * 0.3;
            v.Beam.Width1 = 0.05 + Value * 0.4;
            v.Beam.Transparency = NumberSequence.new(0.8 - Value * 0.6);
        end;

        Highlight2.FillTransparency = 1 - Value * 0.7;
        PointLight.Brightness = 0.5 + Value * 1;
        PointLight.Range = 5 + Value * 5;
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            local v96 = Value * 0.08;
            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new((math.random() - 0.5) * 2 * v96, (math.random() - 0.5) * 2 * v96, 0);
        end;
    end;

    script_Sounds.Unlock:Play();
    local os_clock_ret2 = os.clock();

    while os.clock() - os_clock_ret2 < 0.15 and u48.Parent do
        task.wait();
        local v97 = (os.clock() - os_clock_ret2) / 0.15;
        local Value = TweenService:GetValue(math.min(v97, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In);

        for _, v in v86 do
            v.Part.CFrame = CFrame.new(v.OrigCFrame.Position + v.Dir * 3.5 * (1 - Value)) * v.OrigCFrame.Rotation;
            v.Part.Color = Color3.fromRGB(255, 255, 220);
        end;

        Highlight2.FillTransparency = 0.3 - Value * 0.3;
    end;

    local os_clock_ret3 = os.clock();
    CFrame.new(Position);

    while os.clock() - os_clock_ret3 < 0.25 and u48.Parent do
        task.wait();
        local v98 = (os.clock() - os_clock_ret3) / 0.25;
        local Value = TweenService:GetValue(math.min(v98, 1), Enum.EasingStyle.Back, Enum.EasingDirection.In);

        for _, v in v86 do
            v.Part.CFrame = CFrame.new(Position + (v.OrigCFrame.Position - Position) * (1 - Value * 0.4)) * v.OrigCFrame.Rotation;
            v.Part.Color = Color3.fromRGB(255, 255, 255):Lerp(v52, Value);
        end;

        Highlight2.FillTransparency = Value * 0.5;
        PointLight.Brightness = 1 + Value * 1;
        PointLight.Range = 8 + Value * 6;
    end;

    task.wait(0.08);
    Highlight2:Destroy();

    for _, v in v92 do
        v.Beam:Destroy();
        v.Att:Destroy();
    end;

    Attachment2:Destroy();
    local u99 = {};

    for _, v in v86 do
        local u100 = v.Part:Clone();
        local v101 = v;

        for _, descendant in u100:GetDescendants() do
            if descendant:IsA("JointInstance") or (descendant:IsA("WeldConstraint") or descendant:IsA("Constraint")) then
                descendant:Destroy();
            end;
        end;

        local v102 = 0.25 + math.random() * 0.2;
        local v103 = u100.Size * v102;
        local math_max_ret = math.max(v103.X, v103.Y, v103.Z);

        if math_max_ret > 1.2 then
            v103 = v103 * (1.2 / math_max_ret);
        end;

        u100.Size = v103;
        u100.CFrame = v101.Part.CFrame * CFrame.new((math.random() - 0.5) * 0.5, (math.random() - 0.5) * 0.5, (math.random() - 0.5) * 0.5);
        u100.Anchored = false;
        u100.CanCollide = true;
        u100.CanQuery = false;
        u100.Color = Color3.fromRGB(255, 255, 220);
        u100.Material = Enum.Material.Neon;
        u100.Parent = workspace;
        local Dir = v101.Dir;
        local v104 = (math.random() - 0.5) * 0.4;
        local v105 = 0.8 + math.random() * 0.8;
        local v106 = (math.random() - 0.5) * 0.4;
        u100:ApplyImpulse((Dir + Vector3.new(v104, v105, v106)).Unit * ((25 + math.random() * 35) * u100:GetMass()));
        local v107 = (math.random() - 0.5) * 40;
        local v108 = (math.random() - 0.5) * 40;
        local v109 = (math.random() - 0.5) * 40;
        u100:ApplyAngularImpulse(Vector3.new(v107, v108, v109) * u100:GetMass());
        local Attachment3 = Instance.new("Attachment");
        Attachment3.Parent = u100;
        local ParticleEmitter2 = Instance.new("ParticleEmitter");
        ParticleEmitter2.Color = ColorSequence.new(Color3.fromRGB(255, 220, 80), Color3.fromRGB(255, 150, 20));
        ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) });
        ParticleEmitter2.Lifetime = NumberRange.new(0.3, 0.7);
        ParticleEmitter2.Speed = NumberRange.new(0.5, 2);
        ParticleEmitter2.SpreadAngle = Vector2.new(180, 180);
        ParticleEmitter2.LightEmission = 1;
        ParticleEmitter2.Rate = 30;
        ParticleEmitter2.Parent = Attachment3;
        table.insert(u99, {
            Shard = u100,
            Sparkle = ParticleEmitter2
        });
        Debris:AddItem(u100, 15);
        task.spawn(function() -- Line: 703
            -- upvalues: ParticleEmitter2 (copy)
            task.wait(2);

            if ParticleEmitter2 then
                ParticleEmitter2.Enabled = false;
            end;
        end);
        task.spawn(function() -- Line: 707
            -- upvalues: u100 (copy)
            task.wait(1.5);

            if u100.Parent then
                u100.Material = Enum.Material.SmoothPlastic;
            end;
        end);
        v101.Part.LocalTransparencyModifier = 1;

        for i = 1, 2 do
            local Part = Instance.new("Part");
            local v110 = 0.2 + math.random() * 0.4;
            local v111 = 0.2 + math.random() * 0.4;
            local v112 = 0.2 + math.random() * 0.4;
            Part.Size = Vector3.new(v110, v111, v112);
            Part.CFrame = v101.Part.CFrame * CFrame.new((math.random() - 0.5) * 1.5, (math.random() - 0.5) * 1.5, (math.random() - 0.5) * 1.5);
            Part.Anchored = false;
            Part.CanCollide = true;
            Part.CanQuery = false;
            Part.Color = v101.OrigColor:Lerp(Color3.fromRGB(255, 240, 180), 0.5);
            Part.Material = Enum.Material.Neon;
            Part.Parent = workspace;
            local Dir2 = v101.Dir;
            local v113 = math.random() - 0.5;
            local v114 = math.random() * 0.5 + 0.5;
            local v115 = math.random() - 0.5;
            Part:ApplyImpulse((Dir2 + Vector3.new(v113, v114, v115)).Unit * (15 + math.random() * 25) * Part:GetMass());
            local v116 = (math.random() - 0.5) * 10;
            local v117 = (math.random() - 0.5) * 10;
            local v118 = (math.random() - 0.5) * 10;
            Part:ApplyAngularImpulse(Vector3.new(v116, v117, v118) * Part:GetMass());
            table.insert(u99, {
                Sparkle = nil,
                Shard = Part
            });
            task.delay(6, function() -- Line: 731
                -- upvalues: Part (copy)
                if Part.Parent then
                    Part:Destroy();
                end;
            end);
            task.spawn(function() -- Line: 733
                -- upvalues: Part (copy)
                task.wait(1.5);

                if Part.Parent then
                    Part.Material = Enum.Material.SmoothPlastic;
                end;
            end);
            local _ = i;
        end;
    end;

    task.spawn(function() -- Line: 741
        -- upvalues: TweenService (ref), u99 (copy), PointLight (copy)
        task.wait(2);
        local os_clock_ret4 = os.clock();

        while os.clock() - os_clock_ret4 < 2 do
            task.wait();
            local v119 = (os.clock() - os_clock_ret4) / 2;
            local Value = TweenService:GetValue(math.min(v119, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.In);

            for _, v in u99 do
                if v.Shard.Parent then
                    v.Shard.Transparency = Value;
                end;
            end;

            if PointLight.Parent then
                PointLight.Brightness = math.max(0, PointLight.Brightness * (1 - Value));
                PointLight.Range = math.max(0, PointLight.Range * (1 - Value));
            end;
        end;

        for _, v in u99 do
            if v.Shard.Parent then
                v.Shard:Destroy();
            end;
        end;

        if PointLight.Parent then
            PointLight:Destroy();
        end;
    end);
    CreateScreenFlash();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local os_clock_ret4 = os.clock();
        local u120 = nil;
        local u121 = 0.8;
        local u122 = 0.4;
        u120 = RunService.RenderStepped:Connect(function() -- Line: 188
            -- upvalues: os_clock_ret4 (copy), u121 (copy), u120 (ref), u122 (copy), workspace_CurrentCamera (copy)
            local v123 = os.clock() - os_clock_ret4;

            if u121 <= v123 then
                u120:Disconnect();

                return;
            end;

            local v124 = 1 - v123 / u121;
            local v125 = (math.random() - 0.5) * 2 * u122 * v124;
            local v126 = (math.random() - 0.5) * 2 * u122 * v124;
            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(v125, v126, 0);
        end);
    end;

    local Attachment3 = Instance.new("Attachment");
    Attachment3.Parent = PrimaryPart;
    Attachment3.Position = Vector3.new(0, 0, 0);
    local Attachment4 = Instance.new("Attachment");
    Attachment4.Parent = PrimaryPart;
    Attachment4.Position = Vector3.new(0, 60, 0);
    local Beam = Instance.new("Beam");
    Beam.Attachment0 = Attachment3;
    Beam.Attachment1 = Attachment4;
    local v127 = v52:Lerp(Color3.fromRGB(255, 255, 255), 0.5);
    Beam.Color = ColorSequence.new(v52, v127);
    Beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(0.3, 0.4), NumberSequenceKeypoint.new(1, 1) });
    Beam.Width0 = 1.5;
    Beam.Width1 = 0.15;
    Beam.LightEmission = 1;
    Beam.LightInfluence = 0;
    Beam.FaceCamera = true;
    Beam.Segments = 1;
    Beam.Parent = PrimaryPart;
    task.spawn(function() -- Line: 792
        -- upvalues: TweenService (ref), Beam (copy), Attachment3 (copy), Attachment4 (copy)
        local os_clock_ret4 = os.clock();

        while os.clock() - os_clock_ret4 < 0.6 do
            task.wait();
            local Value = TweenService:GetValue((os.clock() - os_clock_ret4) / 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            Beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1 + Value * 0.9), NumberSequenceKeypoint.new(0.3, 0.4 + Value * 0.6), NumberSequenceKeypoint.new(1, 1) });
            Beam.Width0 = 1.5 * (1 - Value * 0.7);
            Beam.Width1 = 0.15 * (1 - Value * 0.7);
        end;

        Beam:Destroy();
        Attachment3:Destroy();
        Attachment4:Destroy();
    end);
    local Attachment5 = Instance.new("Attachment");
    Attachment5.Parent = PrimaryPart;
    Attachment5.Position = Vector3.new(0, -2, 0);
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Color = ColorSequence.new(Color3.fromRGB(220, 200, 150), Color3.fromRGB(180, 160, 120));
    ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.5, 2), NumberSequenceKeypoint.new(1, 3) });
    ParticleEmitter2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(0.5, 0.7), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter2.Lifetime = NumberRange.new(1.5, 3);
    ParticleEmitter2.Speed = NumberRange.new(3, 8);
    ParticleEmitter2.SpreadAngle = Vector2.new(180, 20);
    ParticleEmitter2.LightEmission = 0.2;
    ParticleEmitter2.Rotation = NumberRange.new(0, 360);
    ParticleEmitter2.RotSpeed = NumberRange.new(-30, 30);
    ParticleEmitter2.Drag = 3;
    ParticleEmitter2.Rate = 0;
    ParticleEmitter2.Parent = Attachment5;
    ParticleEmitter2:Emit(40);
    task.delay(4, function() -- Line: 838
        -- upvalues: Attachment5 (copy)
        if Attachment5.Parent then
            Attachment5:Destroy();
        end;
    end);

    if PointLight and PointLight.Parent then
        PointLight:Destroy();
    end;

    if WarmGlow and WarmGlow.Parent then
        WarmGlow:Destroy();
    end;

    local ParticleEmitter3 = Instance.new("ParticleEmitter");
    ParticleEmitter3.Color = ColorSequence.new(Color3.fromRGB(255, 230, 80), Color3.fromRGB(255, 130, 30));
    ParticleEmitter3.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.4), NumberSequenceKeypoint.new(0.3, 0.7), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter3.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.3), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter3.Lifetime = NumberRange.new(0.6, 1.4);
    ParticleEmitter3.Speed = NumberRange.new(20, 45);
    ParticleEmitter3.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter3.LightEmission = 1;
    ParticleEmitter3.Rotation = NumberRange.new(0, 360);
    ParticleEmitter3.RotSpeed = NumberRange.new(-200, 200);
    ParticleEmitter3.Drag = 4;
    ParticleEmitter3.Rate = 0;
    ParticleEmitter3.Parent = Attachment;
    ParticleEmitter3:Emit(180);
    local ParticleEmitter4 = Instance.new("ParticleEmitter");
    ParticleEmitter4.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 250, 200));
    ParticleEmitter4.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5), NumberSequenceKeypoint.new(0.2, 3), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.4), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter4.Lifetime = NumberRange.new(0.2, 0.4);
    ParticleEmitter4.Speed = NumberRange.new(0, 1);
    ParticleEmitter4.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter4.LightEmission = 1;
    ParticleEmitter4.Rate = 0;
    ParticleEmitter4.Parent = Attachment;
    ParticleEmitter4:Emit(30);
    local ParticleEmitter5 = Instance.new("ParticleEmitter");
    ParticleEmitter5.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200));
    ParticleEmitter5.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 6) });
    ParticleEmitter5.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 0.3), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter5.Lifetime = NumberRange.new(0.6, 1);
    ParticleEmitter5.Speed = NumberRange.new(18, 30);
    ParticleEmitter5.SpreadAngle = Vector2.new(180, 15);
    ParticleEmitter5.LightEmission = 1;
    ParticleEmitter5.Rate = 0;
    ParticleEmitter5.Parent = Attachment;
    ParticleEmitter5:Emit(40);
    local ParticleEmitter6 = Instance.new("ParticleEmitter");
    ParticleEmitter6.Color = ColorSequence.new(Color3.fromRGB(255, 180, 0), Color3.fromRGB(180, 100, 0));
    ParticleEmitter6.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.3, 0.35), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter6.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8, 0.2), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter6.Lifetime = NumberRange.new(1, 2.5);
    ParticleEmitter6.Speed = NumberRange.new(12, 30);
    ParticleEmitter6.SpreadAngle = Vector2.new(50, 50);
    ParticleEmitter6.LightEmission = 0.4;
    ParticleEmitter6.Acceleration = Vector3.new(0, -25, 0);
    ParticleEmitter6.Drag = 1.5;
    ParticleEmitter6.Rotation = NumberRange.new(0, 360);
    ParticleEmitter6.Rate = 0;
    ParticleEmitter6.Parent = Attachment;
    ParticleEmitter6:Emit(50);
    local ParticleEmitter7 = Instance.new("ParticleEmitter");
    ParticleEmitter7.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 200)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 220, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 50)) });
    ParticleEmitter7.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.2, 0.25),
        NumberSequenceKeypoint.new(0.8, 0.15),
        NumberSequenceKeypoint.new(1, 0)
    });
    ParticleEmitter7.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter7.Lifetime = NumberRange.new(2, 4);
    ParticleEmitter7.Speed = NumberRange.new(1, 4);
    ParticleEmitter7.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter7.LightEmission = 1;
    ParticleEmitter7.Acceleration = Vector3.new(0, 2, 0);
    ParticleEmitter7.Rotation = NumberRange.new(0, 360);
    ParticleEmitter7.RotSpeed = NumberRange.new(-60, 60);
    ParticleEmitter7.Rate = 0;
    ParticleEmitter7.Parent = Attachment;
    ParticleEmitter7:Emit(80);
    local ParticleEmitter8 = Instance.new("ParticleEmitter");
    ParticleEmitter8.Color = ColorSequence.new(Color3.fromRGB(200, 230, 255), Color3.fromRGB(255, 255, 200));
    ParticleEmitter8.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.08), NumberSequenceKeypoint.new(0.1, 0.15), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter8.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.2), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter8.Lifetime = NumberRange.new(0.1, 0.3);
    ParticleEmitter8.Speed = NumberRange.new(40, 80);
    ParticleEmitter8.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter8.LightEmission = 1;
    ParticleEmitter8.Rotation = NumberRange.new(0, 360);
    ParticleEmitter8.Rate = 0;
    ParticleEmitter8.Parent = Attachment;
    ParticleEmitter8:Emit(50);
    local ParticleEmitter9 = Instance.new("ParticleEmitter");
    ParticleEmitter9.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 50)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 130, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 60, 10)) });
    ParticleEmitter9.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(0.5, 0.15), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter9.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(0.7, 0.4), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter9.Lifetime = NumberRange.new(2, 5);
    ParticleEmitter9.Speed = NumberRange.new(2, 8);
    ParticleEmitter9.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter9.LightEmission = 0.8;
    ParticleEmitter9.Acceleration = Vector3.new(0, 4, 0);
    ParticleEmitter9.Drag = 2;
    ParticleEmitter9.Rotation = NumberRange.new(0, 360);
    ParticleEmitter9.RotSpeed = NumberRange.new(-40, 40);
    ParticleEmitter9.Rate = 0;
    ParticleEmitter9.Parent = Attachment;
    ParticleEmitter9:Emit(60);
    PointLight.Brightness = 1.2;
    PointLight.Range = 10;
    TweenService:Create(PointLight, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Brightness = 0,
        Range = 0
    }):Play();
    local PointLight2 = Instance.new("PointLight");
    PointLight2.Color = v52:Lerp(Color3.fromRGB(255, 200, 100), 0.4);
    PointLight2.Brightness = 0.3;
    PointLight2.Range = 6;
    PointLight2.Parent = PrimaryPart;
    TweenService:Create(PointLight2, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Brightness = 0,
        Range = 0
    }):Play();
    task.delay(0.5, function() -- Line: 1027
        -- upvalues: PointLight2 (copy)
        if PointLight2.Parent then
            PointLight2:Destroy();
        end;
    end);
    task.delay(0.12, function() -- Line: 1030
        -- upvalues: Attachment (copy), ParticleEmitter3 (copy), ParticleEmitter8 (copy)
        if Attachment.Parent then
            ParticleEmitter3:Emit(80);
            ParticleEmitter8:Emit(30);
        end;
    end);
    task.delay(0.3, function() -- Line: 1037
        -- upvalues: Attachment (copy), ParticleEmitter5 (copy), ParticleEmitter7 (copy), ParticleEmitter9 (copy)
        if Attachment.Parent then
            ParticleEmitter5:Emit(20);
            ParticleEmitter7:Emit(40);
            ParticleEmitter9:Emit(30);
        end;
    end);
    task.delay(1, function() -- Line: 1046
        -- upvalues: Attachment (copy), ParticleEmitter9 (copy), ParticleEmitter7 (copy)
        if Attachment.Parent then
            ParticleEmitter9:Emit(30);
            ParticleEmitter7:Emit(25);
        end;
    end);
    task.delay(2.5, function() -- Line: 1053
        -- upvalues: Attachment (copy), ParticleEmitter9 (copy), ParticleEmitter7 (copy)
        if Attachment.Parent then
            ParticleEmitter9:Emit(15);
            ParticleEmitter7:Emit(10);
        end;
    end);
end;

local function GetInputVerb() -- Line: 1061
    -- upvalues: LastInputType (ref)
    return LastInputType.Name:find("Gamepad") and "L2" or (LastInputType == Enum.UserInputType.Touch and "Tap" or "Click");
end;

local function UseEgg(p128: userdata?, p129: userdata?) -- Line: 1073
    -- upvalues: u13 (copy), LocalPlayer (copy), RaycastClickDetectorService (copy), u8 (copy), EggInfoFader (copy), u9 (ref), u10 (ref), u11 (ref), Highlight (copy), HatchBeeSwarmEgg (copy), PlayHatchAnimation (copy), SkipBeeEggHatchTime (copy)
    if not (p128 and p129) then
        return;
    end;

    if u13[p128] then
        return;
    end;

    if p128:GetAttribute("OwnerUserId") ~= LocalPlayer.UserId then
        return;
    end;

    local Attribute = p128:GetAttribute("UUID");

    if typeof(Attribute) ~= "string" then
        warn("BeeColonyEggRenderController | No UUID on bee egg");

        return;
    end;

    if not p128:GetAttribute("ReadyToHatch") then
        SkipBeeEggHatchTime:FireServer(Attribute);

        return;
    end;

    u13[p128] = true;
    local v130 = RaycastClickDetectorService.get(p128);

    if v130 then
        v130.MaxActivationDistance = 0;
    end;

    local v131 = u8[p128];

    if v131 then
        EggInfoFader.Hide(v131);
    end;

    if u9 == p128 then
        u9 = nil;
    end;

    if u10 == p128 then
        u10 = nil;
    end;

    if u11 == p128 then
        u11 = nil;
        Highlight.Adornee = nil;
    end;

    HatchBeeSwarmEgg:FireServer(Attribute);
    PlayHatchAnimation(p128, p129);
end;

local function StartRightTriggerListener() -- Line: 1113
    -- upvalues: u14 (ref), UserInputService (copy), u11 (ref), Highlight (copy), u15 (ref), UseEgg (copy)
    if u14 then
        return;
    end;

    u14 = UserInputService.InputChanged:Connect(function(p132, p133) -- Line: 1116
        -- upvalues: u11 (ref), Highlight (ref), u15 (ref), UseEgg (ref)
        if p133 then
            return;
        end;

        if p132.KeyCode ~= Enum.KeyCode.ButtonL2 then
            return;
        end;

        if not (u11 and Highlight.Adornee) then
            return;
        end;

        local v134 = p132.Position.Z > 0.75;

        if not v134 or u15 then
            if not v134 and u15 then
                u15 = false;
            end;

            return;
        end;

        u15 = true;
        UseEgg(u11, u11:FindFirstChildOfClass("Model"));
    end);
end;

local function StopRightTriggerListener() -- Line: 1132
    -- upvalues: u14 (ref), u15 (ref)
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    u15 = false;
end;

local function GetClickDetector(p135: userdata) -- Line: 1141
    -- upvalues: RaycastClickDetectorService (copy)
    local v136 = RaycastClickDetectorService.get(p135);

    if not v136 then
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.FilterDescendantsInstances = { p135 };
        v136 = RaycastClickDetectorService.bind(p135, {
            MaxDistance = 32,
            RaycastParams = RaycastParams_new_ret
        });
    end;

    return v136;
end;

local function UpdateEggInfo(p137: userdata) -- Line: 1159
    -- upvalues: u8 (copy), LastInputType (ref), BeeEggRegistry (copy), Chalk (copy), TimeHelper (copy)
    local v138 = u8[p137];

    if not v138 then
        return;
    end;

    local v139 = p137:GetAttribute("HatchedFrom") or "Egg";
    local v140 = p137:GetAttribute("TimeUntilHatch") or 0;
    local Attribute = p137:GetAttribute("ReadyToHatch");

    if not LastInputType.Name:find("Gamepad") then
        local _ = LastInputType == Enum.UserInputType.Touch;
    end;

    local _ = Attribute or v140 <= 0;
    local Price = v138:FindFirstChild("Price", true);
    local Item = v138:FindFirstChild("Item", true);

    if Item and Item:IsA("TextLabel") then
        Item.RichText = true;
        local v141 = BeeEggRegistry.Entries[v139];

        if v141 then
            Item.Text = Chalk.color(v141.Color)(v139);
        else
            Item.Text = v139;
        end;

        local Detail = Price:FindFirstChild("Detail");

        if Detail and Detail:IsA("TextLabel") then
            Price.Label.Visible = false;
            Detail.Visible = true;

            if Attribute or v140 <= 0 then
                Detail.Text = "Ready to Hatch!";
            else
                Detail.Text = `Hatching in {TimeHelper:GenerateColonFormatFromTime(v140)}`;
            end;
        end;
    end;

    local Action = v138:FindFirstChild("Action", true);

    if Action and Action:IsA("TextLabel") then
        Action.Text = `[{LastInputType.Name:find("Gamepad") and "L2" or (LastInputType == Enum.UserInputType.Touch and "Tap" or "Click")} To {(Attribute or v140 <= 0) and "Hatch" or "Skip"}]`;
    end;
end;

UserInputService.LastInputTypeChanged:Connect(function(p142) -- Line: 1205
    -- upvalues: LastInputType (ref), u8 (copy), UpdateEggInfo (copy)
    LastInputType = p142;

    for i in u8 do
        UpdateEggInfo(i);
    end;
end);

local function SetActiveEgg(p143: userdata?) -- Line: 1213
    -- upvalues: u13 (copy), u11 (ref), UpdateEggInfo (copy), u8 (copy), EggInfoFader (copy), Highlight (copy), u2 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u14 (ref), UserInputService (copy), u15 (ref), UseEgg (copy)
    if p143 and u13[p143] then
        p143 = nil;
    end;

    if u11 == p143 then
        if p143 then
            UpdateEggInfo(p143);
        end;

        return;
    end;

    if u11 and u8[u11] then
        EggInfoFader.Hide(u8[u11]);
    end;

    u11 = p143;

    if not (u11 and u8[u11]) then
        Highlight.Adornee = nil;

        if u14 then
            u14:Disconnect();
            u14 = nil;
        end;

        u15 = false;

        return;
    end;

    UpdateEggInfo(u11);
    EggInfoFader.Show(u8[u11]);
    local v144;

    if u2 then
        v144 = Color3_fromRGB_ret2;
    else
        v144 = Color3_fromRGB_ret;
    end;

    Highlight.OutlineColor = v144;
    Highlight.Adornee = u11:FindFirstChildOfClass("Model");

    if u14 then
        return;
    end;

    u14 = UserInputService.InputChanged:Connect(function(p145, p146) -- Line: 1116
        -- upvalues: u11 (ref), Highlight (ref), u15 (ref), UseEgg (ref)
        if p146 then
            return;
        end;

        if p145.KeyCode ~= Enum.KeyCode.ButtonL2 then
            return;
        end;

        if not (u11 and Highlight.Adornee) then
            return;
        end;

        local v147 = p145.Position.Z > 0.75;

        if not v147 or u15 then
            if not v147 and u15 then
                u15 = false;
            end;

            return;
        end;

        u15 = true;
        UseEgg(u11, u11:FindFirstChildOfClass("Model"));
    end);
end;

local function RefreshActiveEgg() -- Line: 1244
    -- upvalues: SetActiveEgg (copy), u9 (ref), u10 (ref)
    SetActiveEgg(u9 or u10);
end;

local function CreateEggInfo(p148: userdata) -- Line: 1280
    -- upvalues: EggInfo (copy)
    local EggInfo2 = p148:FindFirstChild("EggInfo");

    if EggInfo2 and EggInfo2:IsA("BillboardGui") then
        EggInfo2.Enabled = false;

        return EggInfo2;
    end;

    local v149 = EggInfo:Clone();
    v149.Name = "EggInfo";
    v149.Enabled = false;
    v149.Parent = p148;

    return v149;
end;

local function CreateEggModel(u150: userdata) -- Line: 1295
    -- upvalues: BeeEggs (copy), EggInfo (copy), u8 (copy), UpdateEggInfo (copy), StartShakeLoop (copy), GetClickDetector (copy), u9 (ref), SetActiveEgg (copy), u10 (ref), u12 (copy), Debris (copy), LocalPlayer (copy), u13 (copy), EggInfoFader (copy), u11 (ref), Highlight (copy), HatchBeeSwarmEgg (copy), PlayHatchAnimation (copy), SkipBeeEggHatchTime (copy)
    local Attribute = u150:GetAttribute("HatchedFrom");
    local Attribute2 = u150:GetAttribute("OwnerUserId");

    if not Attribute then
        warn("BeeColonyEggRenderController:CreateEggModel | BeeData has no HatchedFrom");

        return nil;
    end;

    local v151 = BeeEggs:FindFirstChild(Attribute);

    if not v151 then
        warn((`BeeColonyEggRenderController:CreateEggModel | no model found for egg type "{Attribute}"`));

        return nil;
    end;

    if not v151.PrimaryPart then
        warn((`BeeColonyEggRenderController:CreateEggModel | model has no primary part set "{Attribute}"`));

        return nil;
    end;

    local v152 = u150:FindFirstChildOfClass("Model");

    if v152 then
        for _, child in u150:GetChildren() do
            if child:IsA("Model") and child ~= v152 then
                child:Destroy();
            end;
        end;

        local EggInfo2 = u150:FindFirstChild("EggInfo");

        if EggInfo2 and EggInfo2:IsA("BillboardGui") then
            EggInfo2.Enabled = false;
        else
            EggInfo2 = EggInfo:Clone();
            EggInfo2.Name = "EggInfo";
            EggInfo2.Enabled = false;
            EggInfo2.Parent = u150;
        end;

        u8[u150] = EggInfo2;
        UpdateEggInfo(u150);

        return v152;
    end;

    local u153 = v151:Clone();

    for _, descendant in u153:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Anchored = true;
        end;
    end;

    u153.PrimaryPart.Anchored = true;
    u153:PivotTo(u150.CFrame);
    u153.Parent = u150;
    u150.ChildAdded:Connect(function(p154) -- Line: 1344
        -- upvalues: u153 (copy)
        if p154:IsA("Model") and p154 ~= u153 then
            p154:Destroy();
        end;
    end);

    if u150:GetAttribute("ReadyToHatch") then
        StartShakeLoop(u150, u153);
    end;

    local EggInfo2 = u150:FindFirstChild("EggInfo");

    if EggInfo2 and EggInfo2:IsA("BillboardGui") then
        EggInfo2.Enabled = false;
    else
        EggInfo2 = EggInfo:Clone();
        EggInfo2.Name = "EggInfo";
        EggInfo2.Enabled = false;
        EggInfo2.Parent = u150;
    end;

    u8[u150] = EggInfo2;
    UpdateEggInfo(u150);
    local u155 = GetClickDetector(u150);
    u155.MouseHoverEnter:Connect(function() -- Line: 1360
        -- upvalues: u9 (ref), u150 (copy), SetActiveEgg (ref)
        u9 = u150;
        SetActiveEgg(u150);
    end);
    u155.MouseHoverLeave:Connect(function() -- Line: 1365
        -- upvalues: u9 (ref), u150 (copy), SetActiveEgg (ref), u10 (ref)
        if u9 ~= u150 then
            return;
        end;

        u9 = nil;
        SetActiveEgg(u9 or u10);
    end);
    u150:GetAttributeChangedSignal("TimeUntilHatch"):Connect(function() -- Line: 1371
        -- upvalues: UpdateEggInfo (ref), u150 (copy)
        UpdateEggInfo(u150);
    end);
    u150:GetAttributeChangedSignal("ReadyToHatch"):Connect(function() -- Line: 1375
        -- upvalues: UpdateEggInfo (ref), u150 (copy), StartShakeLoop (ref), u153 (copy), u12 (ref), Debris (ref)
        UpdateEggInfo(u150);

        if u150:GetAttribute("ReadyToHatch") then
            StartShakeLoop(u150, u153);

            return;
        end;

        local v156 = u150;
        local v157 = u12[v156];

        if not v157 then
            return;
        end;

        v157.Running = false;

        if v157.Sparkle then
            v157.Sparkle.Enabled = false;
            local Parent = v157.Sparkle.Parent;

            if Parent then
                Debris:AddItem(Parent, 1.5);
            end;
        end;

        u12[v156] = nil;
    end);
    u150:GetAttributeChangedSignal("HatchedFrom"):Connect(function() -- Line: 1384
        -- upvalues: UpdateEggInfo (ref), u150 (copy)
        UpdateEggInfo(u150);
    end);

    if Attribute2 == LocalPlayer.UserId then
        u155.MouseClick:Connect(function() -- Line: 1389
            -- upvalues: u13 (ref), u150 (copy), u155 (copy), u8 (ref), EggInfoFader (ref), u9 (ref), u10 (ref), u11 (ref), Highlight (ref), HatchBeeSwarmEgg (ref), PlayHatchAnimation (ref), u153 (copy), SkipBeeEggHatchTime (ref)
            if u13[u150] then
                return;
            end;

            local Attribute3 = u150:GetAttribute("UUID");

            if not Attribute3 then
                warn("BeeColonyEggRenderController | No UUID on bee egg");

                return;
            end;

            if not u150:GetAttribute("ReadyToHatch") then
                SkipBeeEggHatchTime:FireServer(Attribute3);

                return;
            end;

            u13[u150] = true;
            u155.MaxActivationDistance = 0;
            local v158 = u8[u150];

            if v158 then
                EggInfoFader.Hide(v158);
            end;

            if u9 == u150 then
                u9 = nil;
            end;

            if u10 == u150 then
                u10 = nil;
            end;

            if u11 == u150 then
                u11 = nil;
                Highlight.Adornee = nil;
            end;

            HatchBeeSwarmEgg:FireServer(Attribute3);
            PlayHatchAnimation(u150, u153);
        end);
    end;

    return u153;
end;

local function RemoveEggModel(p159: userdata) -- Line: 1431
    -- upvalues: u12 (copy), Debris (copy), u8 (copy), u13 (copy), u9 (ref), u10 (ref), u11 (ref), SetActiveEgg (copy)
    if p159:IsA("BasePart") then
        local v160 = u12[p159];

        if v160 then
            v160.Running = false;

            if v160.Sparkle then
                v160.Sparkle.Enabled = false;
                local Parent = v160.Sparkle.Parent;

                if Parent then
                    Debris:AddItem(Parent, 1.5);
                end;
            end;

            u12[p159] = nil;
        end;

        u8[p159] = nil;
        u13[p159] = nil;

        if u9 == p159 then
            u9 = nil;
        end;

        if u10 == p159 then
            u10 = nil;
        end;

        if u11 == p159 then
            u11 = nil;
        end;
    end;

    p159:Destroy();
    SetActiveEgg(u9 or u10);
end;

local function GetClosestEgg() -- Line: 1248
    -- upvalues: LocalPlayer (copy), u8 (copy), u13 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
        return nil;
    end;

    local v161 = 32;
    local v162 = nil;

    for i in u8 do
        if not u13[i] and i:IsDescendantOf(workspace) then
            local Magnitude = (HumanoidRootPart.Position - i.Position).Magnitude;

            if Magnitude <= v161 then
                v162 = i;
                v161 = Magnitude;
            end;
        end;
    end;

    return v162;
end;

for _, v in CollectionService:GetTagged("BeeSwarmEgg") do
    CreateEggModel(v);
end;

CollectionService:GetInstanceAddedSignal("BeeSwarmEgg"):Connect(function(p163) -- Line: 1458
    -- upvalues: CreateEggModel (copy), script_Sounds (copy)
    CreateEggModel(p163);
    script_Sounds.PlaceEgg:Play();
end);
CollectionService:GetInstanceRemovedSignal("BeeSwarmEgg"):Connect(RemoveEggModel);
RunService.Heartbeat:Connect(function() -- Line: 1465
    -- upvalues: GetClosestEgg (copy), u10 (ref), SetActiveEgg (copy), u9 (ref), u11 (ref), UpdateEggInfo (copy)
    local v164 = GetClosestEgg();

    if u10 == v164 then
        if u11 then
            UpdateEggInfo(u11);
        end;

        return;
    end;

    u10 = v164;
    SetActiveEgg(u9 or u10);
end);

return v7;