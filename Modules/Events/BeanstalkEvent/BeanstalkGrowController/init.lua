-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
require(ReplicatedStorage.Modules.UpdateService);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local BeanstalkEvent = ReplicatedStorage:WaitForChild("GameEvents").Events.BeanstalkEvent;
local BeanstalkREPopulate = BeanstalkEvent.BeanstalkREPopulate;
local BeanstalkREClaimReward = BeanstalkEvent.BeanstalkREClaimReward;
local BeanStalkRESelect = BeanstalkEvent.BeanStalkRESelect;
local u2 = {};
local u3 = {};
local Children = script:GetChildren();

if #Children > 0 then
    local u4 = nil;
    local u5 = nil;
    local u6 = nil;
    local u7 = nil;
    local u8 = nil;
    local u9 = nil;
    local u10 = false;
    local u11 = false;
    local CameraShaker = require(game.ReplicatedStorage.Code.CameraShaker);
    local u13 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p12) -- Line: 48
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * p12;
    end);
    local u14 = nil;
    local u15 = nil;
    local u16 = false;
    local u17 = {};

    local function EnableRewardPoint(p18: userdata) -- Line: 58
        for _, descendant in p18:GetDescendants() do
            if descendant:IsA("ProximityPrompt") then
                descendant.Enabled = true;
            elseif descendant:IsA("Part") then
                descendant.Transparency = 0;
                descendant.CanCollide = true;
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end;

    local function DisableRewardPoint(p19: userdata) -- Line: 71
        for _, descendant in p19:GetDescendants() do
            if descendant:IsA("ProximityPrompt") then
                descendant.Enabled = false;
            elseif descendant:IsA("Part") then
                descendant.Transparency = 1;
                descendant.CanCollide = false;
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end;

    local function DisableBeanstalk() -- Line: 85
        -- upvalues: u5 (ref), CollectionService (copy)
        for _, descendant in u5:GetDescendants() do
            if not (descendant:HasTag("CosmeticHitBox") or (not descendant:IsA("BasePart") or CollectionService:HasTag(descendant, "KeepTransparency"))) then
                descendant.Transparency = 1;
                descendant.CanCollide = false;
            end;
        end;
    end;

    local function EnableBeanstalk() -- Line: 97
        -- upvalues: u5 (ref), CollectionService (copy)
        for _, descendant in u5:GetDescendants() do
            if not (descendant:HasTag("CosmeticHitBox") or (not descendant:IsA("BasePart") or CollectionService:HasTag(descendant, "KeepTransparency"))) then
                descendant.Transparency = 0;
                descendant.CanCollide = true;
            end;
        end;
    end;

    local function EnableFX() -- Line: 108
        -- upvalues: u6 (ref), u7 (ref), u13 (copy), u14 (ref), CameraShaker (copy)
        if u6 then
            for _, child in u6:GetChildren() do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = true;
                end;
            end;
        end;

        if u7 then
            u7:Play();
        end;

        if u13 then
            u14 = u13:ShakeSustain(CameraShaker.Presets.Vibration);
        end;
    end;

    local function DisableFX() -- Line: 127
        -- upvalues: u6 (ref), u7 (ref), u13 (copy), u14 (ref)
        if u6 then
            for _, child in u6:GetChildren() do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = false;
                end;
            end;
        end;

        if u7 then
            u7:Stop();
        end;

        if u13 then
            u13:StopSustained(1);
        end;

        u14 = nil;
    end;

    local function ScaleModel(p20, p21) -- Line: 148
        local Pivot = p20:GetPivot();

        for _, descendant in ipairs(p20:GetDescendants()) do
            if descendant:IsA("BasePart") then
                local v22 = Pivot:PointToObjectSpace(descendant.Position);
                descendant.Size = descendant.Size * p21;
                descendant.Position = Pivot:PointToWorldSpace(v22 * p21);
            end;
        end;
    end;

    local function TweenScaleModel(p23, p24, p25) -- Line: 161
        -- upvalues: u1 (copy), TweenService (copy)
        local Pivot = p23:GetPivot();
        local u26 = {};
        local u27 = {};

        for _, descendant in ipairs(p23:GetDescendants()) do
            if descendant:IsA("BasePart") then
                u26[descendant] = descendant.Size;
                u27[descendant] = Pivot:PointToObjectSpace(descendant.Position);
            end;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 1;
        u1:Add(NumberValue.Changed:Connect(function(p28) -- Line: 176
            -- upvalues: u26 (copy), Pivot (copy), u27 (copy)
            for i, v in pairs(u26) do
                i.Size = v * p28;
                i.Position = Pivot:PointToWorldSpace(u27[i] * p28);
            end;
        end));
        TweenService:Create(NumberValue, p25, {
            Value = p24
        }):Play();
    end;

    local function MoveUp() -- Line: 188
        -- upvalues: u10 (ref), EnableBeanstalk (copy), EnableFX (copy), u6 (ref), u14 (ref), TweenService (copy), u9 (ref), u8 (ref), u5 (ref), DisableFX (copy)
        if u10 then
            return {};
        end;

        u10 = true;
        EnableBeanstalk();
        EnableFX();
        local v29 = 0;

        while v29 < 4 and u10 do
            u14:SetScaleMagnitude(1 - math.clamp((workspace.CurrentCamera.CFrame.Position - u6.Position).Magnitude, 0, 150) / 150);
            v29 = v29 + game:GetService("RunService").Heartbeat:Wait();
            local Value = TweenService:GetValue(v29 / 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            local v30 = u9:Lerp(u8, Value);
            local math_lerp_ret = math.lerp(-360, 0, Value);
            u5:PivotTo(v30 * CFrame.Angles(0, math.rad(math_lerp_ret), 0) * CFrame.new(Random.new():NextUnitVector() * 0.1));
        end;

        if u10 then
            u5:PivotTo(u8);
            DisableFX();
        end;
    end;

    local function MoveDown() -- Line: 222
        -- upvalues: u5 (ref), u2 (copy), u3 (ref), DisableRewardPoint (copy), u10 (ref), EnableFX (copy), u6 (ref), u14 (ref), TweenService (copy), u8 (ref), u9 (ref), DisableFX (copy), DisableBeanstalk (copy)
        local v31 = u5;

        for _, v in u2 do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u2);

        for _, v in u3 do
            DisableRewardPoint(v);
        end;

        task.wait(0.5);

        if u10 == false then
            return {};
        end;

        EnableFX();
        local v32 = 0;
        u10 = false;

        while v32 < 4 and not u10 do
            u14:SetScaleMagnitude(1 - math.clamp((workspace.CurrentCamera.CFrame.Position - u6.Position).Magnitude, 0, 150) / 150);
            v32 = v32 + game:GetService("RunService").Heartbeat:Wait();
            local Value = TweenService:GetValue(v32 / 4, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            local v33 = u8:Lerp(u9, Value);
            local math_lerp_ret = math.lerp(0, -360, Value);
            v31:PivotTo(v33 * CFrame.Angles(0, math.rad(math_lerp_ret), 0) * CFrame.new(Random.new():NextUnitVector() * 0.1));
        end;

        if not u10 then
            v31:PivotTo(u9);
            DisableFX();
            DisableBeanstalk();
            v31.Parent.Parent = script;
        end;
    end;

    local function SetupBeanStalkVariation() -- Line: 272
        -- upvalues: u15 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref)
        if not u15 then
            return;
        end;

        local v34 = workspace.Interaction:QueryDescendants(".BeanstalkEventModel")[1];

        if not v34 then
            local v35 = 0;

            while v35 < 5 do
                v34 = workspace.Interaction:QueryDescendants(".BeanstalkEventModel")[1];

                if v34 then
                    break;
                end;

                v35 = v35 + task.wait();
            end;

            if not v34 then
                warn("Missing BeanstalkEventModel!");

                return;
            end;
        end;

        u15.Parent = v34;
        u4 = u15;
        u5 = u4.Root;
        u6 = u4.GroundBreak;
        u7 = u6.Rumble;
        u8 = u5:GetPivot() * CFrame.new(0, 180, 0);
        u9 = u5:GetPivot();
    end;

    local function UpdateActiveBeanstalk() -- Line: 301
        -- upvalues: SaveSlotController (copy), u16 (ref), u11 (ref), SetupBeanStalkVariation (copy), MoveUp (copy), MoveDown (copy)
        if SaveSlotController:IsCurrentSlotSpecial() then
            return;
        end;

        if workspace:GetAttribute("ActivateBeanstalk") then
            if not u16 then
                while u11 do
                    task.wait(0.1);
                end;

                SetupBeanStalkVariation();
                MoveUp();
                u16 = true;
            end;
        else
            u16 = false;
            u11 = true;
            MoveDown();
            u11 = false;
        end;
    end;

    function u17.Start(p36) -- Line: 322
        -- upvalues: Children (copy), u5 (ref), u8 (ref), u9 (ref), DisableBeanstalk (copy), u13 (copy), DisableRewardPoint (copy), u15 (ref), UpdateActiveBeanstalk (copy), u1 (copy), BeanStalkRESelect (copy), u16 (ref), u3 (ref), BeanstalkREPopulate (copy), EnableRewardPoint (copy), SoundService (copy), BeanstalkREClaimReward (copy), u2 (copy), SaveSlotController (copy)
        for _, v in Children do
            u5 = v:FindFirstChild("Root");

            if u5 then
                u8 = u5:GetPivot();
                u9 = u5:GetPivot() * CFrame.new(0, -180, 0);
                DisableBeanstalk();
                u5:PivotTo(u9);
                u13:Start();

                for _, child in v.Root.RewardPoints:GetChildren() do
                    DisableRewardPoint(child);
                end;
            end;
        end;

        if u15 then
            task.spawn(UpdateActiveBeanstalk);
        end;

        u1:Add(workspace:GetAttributeChangedSignal("ActivateBeanstalk"):Connect(UpdateActiveBeanstalk));
        u1:Add(BeanStalkRESelect.OnClientEvent:Connect(function(p37, p38) -- Line: 347
            -- upvalues: u16 (ref), u15 (ref), u3 (ref), UpdateActiveBeanstalk (ref)
            if not u16 then
                u15 = p37;
                u3 = p38;

                if workspace:GetAttribute("ActivateBeanstalk") then
                    UpdateActiveBeanstalk();
                end;
            end;
        end));
        u1:Add(BeanstalkREPopulate.OnClientEvent:Connect(function(p39) -- Line: 359
            -- upvalues: u3 (ref), DisableRewardPoint (ref), EnableRewardPoint (ref), SoundService (ref), BeanstalkREClaimReward (ref), u2 (ref)
            for _, v in u3 do
                DisableRewardPoint(v);
            end;

            if p39 == nil then
                return;
            end;

            for i, v in p39 do
                local RewardPartInstance = v.RewardPartInstance;
                local ProximityPrompt = RewardPartInstance:WaitForChild("ProximityPrompt");
                EnableRewardPoint(RewardPartInstance);
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In);

                if ProximityPrompt:IsA("ProximityPrompt") then
                    local v40 = ProximityPrompt.Triggered:Connect(function() -- Line: 374
                        -- upvalues: SoundService (ref), BeanstalkREClaimReward (ref), i (copy), DisableRewardPoint (ref), RewardPartInstance (copy)
                        task.wait(0.1);
                        SoundService.PopSoundHigher:Play();
                        task.wait(0.1);
                        BeanstalkREClaimReward:FireServer(i);
                        task.wait(0.1);
                        DisableRewardPoint(RewardPartInstance);
                    end);
                    table.insert(u2, v40);
                end;
            end;
        end));
        u1:Add(SaveSlotController:GetSaveSlotChangeSignal():Connect(function() -- Line: 388
            -- upvalues: SaveSlotController (ref), UpdateActiveBeanstalk (ref)
            if SaveSlotController:IsCurrentSlotSpecial() then
                return;
            end;

            UpdateActiveBeanstalk();
        end));
    end;

    local u41 = false;
    EventRotationController.EventUpdated:Connect(function(p42: string, p43: string) -- Line: 397, Name: OnEventUpdated
        -- upvalues: u1 (copy), u41 (ref), u17 (copy)
        if p43 ~= "BeanstalkEvent" then
            u1:Clean();
            u41 = false;

            return;
        end;

        if u41 then
            return;
        end;

        u41 = true;
        u1:Clean();
        task.spawn(u17.Start, u17);
    end);
    local LoadedEvent = EventRotationController:GetLoadedEvent();

    if LoadedEvent and LoadedEvent.EventSet == "BeanstalkEvent" then
        local _ = LoadedEvent.EventID;

        if LoadedEvent.EventSet == "BeanstalkEvent" then
            if not u41 then
                u41 = true;
                u1:Clean();
                task.spawn(u17.Start, u17);
            end;
        else
            u1:Clean();
            u41 = false;
        end;
    end;

    return u17;
end;

error("Cannot find EventBeanstalk");