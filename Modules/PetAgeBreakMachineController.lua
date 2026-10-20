-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("SoundService");
require(ReplicatedStorage.Modules.Chalk);
require(ReplicatedStorage.Modules.PolicyService);
require(ReplicatedStorage.Modules.PetTraitsData);
require(ReplicatedStorage.Calculate_Weight);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.CountDictionary);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
require(ReplicatedStorage.Modules.NumberUtil);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local PetAgeBreakUIController = require(ReplicatedStorage.Modules.PetAgeBreakUIController);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local PetList = require(ReplicatedStorage.Data.PetRegistry).PetList;
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
require(ReplicatedStorage.Data.DefaultData);
require(ReplicatedStorage.Data.PetAgeBreakMachineData);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.PetAgeLimitBreak_Submit;
local PetAgeLimitBreak_SubmitHeld = GameEvents.PetAgeLimitBreak_SubmitHeld;
local _ = GameEvents.PetAgeLimitBreak_Cancel;
local PetAgeLimitBreak_Skip = GameEvents.PetAgeLimitBreak_Skip;
local PetAgeLimitBreak_Claim = GameEvents.PetAgeLimitBreak_Claim;
local PetAgeLimitBreak_PlayEffects = GameEvents.PetAgeLimitBreak_PlayEffects;
local LocalPlayer = Players.LocalPlayer;
local PetAgeBreak_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetAgeBreak_UI");
local u1 = false;
local u2 = nil;
local u3 = CollectionService:GetTagged("PetAgeMachine")[1];
local TimerTextLabel = u3:FindFirstChild("TimerTextLabel", true);
local PetModelLocation = u3:FindFirstChild("PetModelLocation", true);
local u4 = nil;
local PetAgeMachineProximityPrompt = u3:FindFirstChild("PetAgeMachineProximityPrompt", true);

local function GetMachineData() -- Line: 65
    -- upvalues: LocalPlayer (copy), DataService (copy)
    if not LocalPlayer then
        return warn("No LocalPlayer!");
    end;

    local Data = DataService:GetData();

    if Data then
        return Data.PetAgeBreakMachine or warn((`No PetAgeBreakMachine data for {LocalPlayer.Name}!`));
    end;

    return warn((`No PlayerData for {LocalPlayer}!`));
end;

local function ToggleMachineVisiblity(p5: boolean) -- Line: 78
    -- upvalues: u3 (copy)
    if p5 then
        u3.Parent = workspace;

        return;
    end;

    u3.Parent = script;
end;

local function UpdateModel() -- Line: 87
    -- upvalues: GetMachineData (copy), u2 (ref), SelectiveAssetReplication (copy), PetList (copy), PetModelLocation (copy)
    local v6 = GetMachineData();

    if not v6 then
        return;
    end;

    if not v6.SubmittedPet then
        if u2 then
            u2:Destroy();
            u2 = nil;
        end;

        return;
    end;

    local v7 = SelectiveAssetReplication:GetAssetAsync("PetAssets", v6.SubmittedPet.PetType):Clone();
    local v8 = PetList[v6.SubmittedPet.PetType];
    v7:SetPrimaryPartCFrame(CFrame.new(v7:GetPrimaryPartCFrame().Position) * v8.WeldOffset);
    u2 = v7;

    if not u2 then
        return;
    end;

    if not (u2.PrimaryPart and PetModelLocation.PrimaryPart) then
        warn("Both models need a PrimaryPart set.");

        return;
    end;

    local ExtentsSize = u2:GetExtentsSize();
    local ExtentsSize2 = PetModelLocation:GetExtentsSize();
    local math_min_ret = math.min(ExtentsSize2.X / ExtentsSize.X, ExtentsSize2.Y / ExtentsSize.Y, ExtentsSize2.Z / ExtentsSize.Z);

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    u2:ScaleTo(math_min_ret);
    local Rotation = u2:GetPivot().Rotation;
    local Position = PetModelLocation:GetPivot().Position;
    u2:PivotTo(CFrame.new(Position) * Rotation);
    u2.Parent = PetModelLocation;
end;

local function UpdateTimer() -- Line: 144
    -- upvalues: GetMachineData (copy), TimeHelper (copy), TimerTextLabel (copy)
    local v9 = GetMachineData();

    if not v9 then
        return;
    end;

    local v10 = TimeHelper:GenerateColonFormatFromTime(v9.TimeLeft);

    if v9.TimeLeft > 0 then
        TimerTextLabel.Text = `{v10}`;

        return;
    end;

    if v9.PetReady then
        TimerTextLabel.Text = "READY";

        return;
    end;

    TimerTextLabel.Text = "";
end;

local u11 = 0;

local function AnimatePet(p12: userdata) -- Line: 166
    -- upvalues: u11 (ref)
    local v13 = math.sin(u11) * 0.01;
    local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
    p12:PivotTo((p12:GetPivot() + Vector3.new(0, v13, 0)) * CFrame_Angles_ret);
end;

local function UpdatePrompt() -- Line: 177
    -- upvalues: GetMachineData (copy), PetAgeMachineProximityPrompt (copy)
    local v14 = GetMachineData();

    if not v14 then
        return;
    end;

    PetAgeMachineProximityPrompt.Enabled = true;

    if v14.IsRunning or v14.TimeLeft > 0 then
        PetAgeMachineProximityPrompt.ActionText = "Skip";

        return;
    end;

    if v14.PetReady then
        PetAgeMachineProximityPrompt.ActionText = "Claim Pet";

        return;
    end;

    if v14.SubmittedPet and not v14.IsRunning then
        PetAgeMachineProximityPrompt.ActionText = "Select Dupes";

        return;
    end;

    if not v14.SubmittedPet then
        PetAgeMachineProximityPrompt.ActionText = "Submit Pet";
    end;
end;

task.spawn(function() -- Line: 200
    -- upvalues: GetMachineData (copy), PetAgeMachineProximityPrompt (copy)
    local v15 = GetMachineData();

    if not v15 then
        return;
    end;

    PetAgeMachineProximityPrompt.Enabled = true;

    if v15.IsRunning or v15.TimeLeft > 0 then
        PetAgeMachineProximityPrompt.ActionText = "Skip";

        return;
    end;

    if v15.PetReady then
        PetAgeMachineProximityPrompt.ActionText = "Claim Pet";

        return;
    end;

    if v15.SubmittedPet and not v15.IsRunning then
        PetAgeMachineProximityPrompt.ActionText = "Select Dupes";

        return;
    end;

    if not v15.SubmittedPet then
        PetAgeMachineProximityPrompt.ActionText = "Submit Pet";
    end;
end);

local function quadraticBezier(p16: number, p17: any, p18: any, p19: any) -- Line: 205
    return (1 - p16) ^ 2 * p17 + (1 - p16) * 2 * p16 * p18 + p16 ^ 2 * p19;
end;

local function ClaimAnimation(p20: userdata) -- Line: 209
    -- upvalues: u3 (copy), u2 (ref), ReplicatedStorage (copy), RunService (copy), u11 (ref), LocalPlayer (copy), SoundPlayer (copy), SoundData (copy), TweenService (copy), PetList (copy)
    local PetAgeMachinePoof = u3:FindFirstChild("PetAgeMachinePoof");
    local PixelSmoke = PetAgeMachinePoof.PixelSmoke;

    if not u2 then
        return;
    end;

    local u21 = u2:Clone();
    u21.Parent = u2.Parent;
    u2.Parent = ReplicatedStorage;
    local v25 = RunService.RenderStepped:Connect(function(p22) -- Line: 221
        -- upvalues: u21 (copy), u11 (ref)
        local v23 = u21;
        local v24 = math.sin(u11) * 0.01;
        local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
        v23:PivotTo((v23:GetPivot() + Vector3.new(0, v24, 0)) * CFrame_Angles_ret);
    end);
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    SoundPlayer:PlaySound(SoundData.MachineSounds.SFX, {}, nil, PetAgeMachinePoof);
    local Pivot = u3:GetPivot();
    local v26 = 0;

    while v26 < 1.5 do
        v26 = v26 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v26 / 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local math_lerp_ret = math.lerp(0.01, 0.1, Value);
        local v27 = math.random(-100, 100) / 100 * math_lerp_ret;
        local v28 = math.random(-100, 100) / 100 * math_lerp_ret;
        local v29 = math.random(-100, 100) / 100 * math_lerp_ret;
        u3:PivotTo(Pivot + Vector3.new(v27, v28, v29));
    end;

    PixelSmoke:Emit(26);
    u21:Destroy();
    v25:Disconnect();
    local v30 = PetList[p20.Name];
    local v31;

    if v30 and v30.WeldOffset then
        v31 = v30.WeldOffset;
    else
        v31 = nil;
    end;

    local v32 = CFrame.lookAt(u21:GetPivot().Position, Character:GetPivot().Position) * v31;
    local v33 = p20:Clone();
    v33:ScaleTo(u21:GetScale());
    v33:PivotTo(v32);

    for _, descendant in v33:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    local BoundingBox, v34 = v33:GetBoundingBox();
    local Part = Instance.new("Part");
    Part.CFrame = BoundingBox;
    Part.Name = "TrailPart";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Size = v34;
    Part.Transparency = 1;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "Attachment";
    Attachment.CFrame = CFrame.new(0, v34.Y * 0.5, 0);
    Attachment.Parent = Part;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Name = "Attachment";
    Attachment2.CFrame = CFrame.new(0, -v34.Y * 0.5, 0);
    Attachment2.Parent = Part;
    local Trail = Instance.new("Trail");
    Trail.Name = "Trail";
    Trail.FaceCamera = true;
    Trail.Lifetime = 0.5;
    Trail.Attachment0 = Attachment;
    Trail.Attachment0 = Attachment2;
    Trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.05, 1),
        NumberSequenceKeypoint.new(0.055, 0.4875),
        NumberSequenceKeypoint.new(1, 1)
    });
    Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) });
    Trail.Parent = Part;
    Part.Parent = v33;
    v33.Parent = workspace.CurrentCamera;
    task.wait(0.8);
    local Scale = v33:GetScale();
    local v35 = 0;

    while v35 < 0.8 do
        v35 = v35 + RunService.Heartbeat:Wait();
        local Position = v32.Position;
        local Position2 = Character:GetPivot().Position;
        local Value = TweenService:GetValue(v35 / 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local math_clamp_ret = math.clamp((v35 - 0.4) / 0.4, 0, 1);
        v33:ScaleTo((math.lerp(Scale, 0.05, math_clamp_ret)));
        v33:PivotTo(CFrame.new((1 - Value) ^ 2 * Position + (1 - Value) * 2 * Value * (Position + (Position2 - Position) * 0.5 + Vector3.new(0, 14, 0)) + Value ^ 2 * Position2) * v32.Rotation);
    end;

    v33:Destroy();
    local u36 = workspace.Terrain.PopEffect:Clone();
    u36.CFrame = Character:GetPivot();
    SoundPlayer:PlaySound(SoundData.MachineSounds.Retrieve, {}, nil, u36);
    u36.Parent = workspace.Terrain;

    for _, child in u36:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child:Emit(1);
        end;
    end;

    task.delay(1.5, function() -- Line: 356
        -- upvalues: u36 (copy)
        u36:Destroy();
    end);
end;

PetAgeMachineProximityPrompt.Triggered:Connect(function() -- Line: 361
    -- upvalues: u1 (ref), GetMachineData (copy), PetAgeLimitBreak_Skip (copy), PetAgeLimitBreak_Claim (copy), PetAgeBreakUIController (copy), LocalPlayer (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), PetAgeLimitBreak_SubmitHeld (copy)
    if u1 then
        return;
    end;

    u1 = true;
    task.delay(0.5, function() -- Line: 367
        -- upvalues: u1 (ref)
        u1 = false;
    end);
    local v37 = GetMachineData();

    if not v37 then
        return;
    end;

    if v37.IsRunning or v37.TimeLeft > 0 then
        PetAgeLimitBreak_Skip:FireServer();
    end;

    if v37.PetReady then
        PetAgeLimitBreak_Claim:FireServer();

        return;
    end;

    if v37.SubmittedPet and not v37.IsRunning then
        PetAgeBreakUIController:Open();

        return;
    end;

    if not v37.SubmittedPet then
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local v38 = Character:FindFirstChildWhichIsA("Tool");

        if not v38 then
            return;
        end;

        if v38:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums.Pet then
            return;
        end;

        PetAgeLimitBreak_SubmitHeld:FireServer();
    end;
end);

local function CheckMachineVisibility() -- Line: 401
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();
    local v39 = false;

    for _, v in Data.PetsData.PetInventory.Data do
        if v and (v.PetData and v.PetData.Level >= 70) then
            v39 = true;
            break;
        end;
    end;

    return (Data.PetAgeBreakMachine.IsRunning or (Data.PetAgeBreakMachine.PetReady or Data.PetAgeBreakMachine.SubmittedPet)) and true or v39;
end;

PetAgeMachineProximityPrompt.PromptHidden:Connect(function() -- Line: 428
    -- upvalues: GuiController (copy), PetAgeBreak_UI (copy)
    GuiController:Close(PetAgeBreak_UI);
end);
DataService:GetPathSignal("PetAgeBreakMachine/IsRunning"):Connect(function() -- Line: 432
    -- upvalues: GetMachineData (copy), PetAgeMachineProximityPrompt (copy), TimeHelper (copy), TimerTextLabel (copy), SoundPlayer (copy), SoundData (copy), u3 (copy), u4 (ref)
    local v40 = GetMachineData();

    if not v40 then
        return;
    end;

    local v41 = GetMachineData();

    if v41 then
        PetAgeMachineProximityPrompt.Enabled = true;

        if v41.IsRunning or v41.TimeLeft > 0 then
            PetAgeMachineProximityPrompt.ActionText = "Skip";
        elseif v41.PetReady then
            PetAgeMachineProximityPrompt.ActionText = "Claim Pet";
        elseif v41.SubmittedPet and not v41.IsRunning then
            PetAgeMachineProximityPrompt.ActionText = "Select Dupes";
        elseif not v41.SubmittedPet then
            PetAgeMachineProximityPrompt.ActionText = "Submit Pet";
        end;
    end;

    local v42 = GetMachineData();

    if v42 then
        local v43 = TimeHelper:GenerateColonFormatFromTime(v42.TimeLeft);

        if v42.TimeLeft > 0 then
            TimerTextLabel.Text = `{v43}`;
        elseif v42.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;

    if v40.IsRunning then
        SoundPlayer:PlaySound(SoundData.MachineSounds.Start, {}, nil, u3);

        if u4 then
            u4:Play();

            return;
        end;

        u4 = SoundPlayer:PlaySound(SoundData.MachineSounds.Loop, {
            Looped = true
        }, nil, u3);

        return;
    end;

    SoundPlayer:PlaySound(SoundData.MachineSounds.LoopDone);

    if u4 then
        u4:Stop();
    end;

    task.spawn(function() -- Line: 450
        -- upvalues: SoundPlayer (ref), SoundData (ref)
        task.wait(1);
        SoundPlayer:PlaySound(SoundData.MachineSounds.Finished);
    end);
end);
DataService:GetPathSignal("PetAgeBreakMachine/SubmittedPet"):Connect(function() -- Line: 458
    -- upvalues: GetMachineData (copy), PetAgeMachineProximityPrompt (copy), TimeHelper (copy), TimerTextLabel (copy), UpdateModel (copy), SoundPlayer (copy), SoundData (copy)
    local v44 = GetMachineData();

    if not v44 then
        return;
    end;

    local v45 = GetMachineData();

    if v45 then
        PetAgeMachineProximityPrompt.Enabled = true;

        if v45.IsRunning or v45.TimeLeft > 0 then
            PetAgeMachineProximityPrompt.ActionText = "Skip";
        elseif v45.PetReady then
            PetAgeMachineProximityPrompt.ActionText = "Claim Pet";
        elseif v45.SubmittedPet and not v45.IsRunning then
            PetAgeMachineProximityPrompt.ActionText = "Select Dupes";
        elseif not v45.SubmittedPet then
            PetAgeMachineProximityPrompt.ActionText = "Submit Pet";
        end;
    end;

    local v46 = GetMachineData();

    if v46 then
        local v47 = TimeHelper:GenerateColonFormatFromTime(v46.TimeLeft);

        if v46.TimeLeft > 0 then
            TimerTextLabel.Text = `{v47}`;
        elseif v46.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;

    UpdateModel();

    if v44.SubmittedPet then
        SoundPlayer:PlaySound(SoundData.MachineSounds.Insert);
    end;
end);
RunService.RenderStepped:Connect(function(p48: number) -- Line: 471
    -- upvalues: u2 (ref), u11 (ref)
    if not u2 then
        return;
    end;

    if u2.PrimaryPart then
        u11 = u11 + p48;
        local v49 = u2;
        local v50 = math.sin(u11) * 0.01;
        local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
        v49:PivotTo((v49:GetPivot() + Vector3.new(0, v50, 0)) * CFrame_Angles_ret);
    end;
end);
task.spawn(function() -- Line: 482
    -- upvalues: GetMachineData (copy), PetAgeMachineProximityPrompt (copy), TimeHelper (copy), TimerTextLabel (copy)
    while true do
        task.wait(0.25);
        local v51 = GetMachineData();

        if v51 then
            PetAgeMachineProximityPrompt.Enabled = true;

            if v51.IsRunning or v51.TimeLeft > 0 then
                PetAgeMachineProximityPrompt.ActionText = "Skip";
            elseif v51.PetReady then
                PetAgeMachineProximityPrompt.ActionText = "Claim Pet";
            elseif v51.SubmittedPet and not v51.IsRunning then
                PetAgeMachineProximityPrompt.ActionText = "Select Dupes";
            elseif not v51.SubmittedPet then
                PetAgeMachineProximityPrompt.ActionText = "Submit Pet";
            end;
        end;

        local v52 = GetMachineData();

        if v52 then
            local v53 = TimeHelper:GenerateColonFormatFromTime(v52.TimeLeft);

            if v52.TimeLeft > 0 then
                TimerTextLabel.Text = `{v53}`;
            elseif v52.PetReady then
                TimerTextLabel.Text = "READY";
            else
                TimerTextLabel.Text = "";
            end;
        end;
    end;
end);
task.spawn(function() -- Line: 491
    -- upvalues: GetMachineData (copy), PetAgeMachineProximityPrompt (copy), TimeHelper (copy), TimerTextLabel (copy), UpdateModel (copy)
    if not GetMachineData() then
        return;
    end;

    local v54 = GetMachineData();

    if v54 then
        PetAgeMachineProximityPrompt.Enabled = true;

        if v54.IsRunning or v54.TimeLeft > 0 then
            PetAgeMachineProximityPrompt.ActionText = "Skip";
        elseif v54.PetReady then
            PetAgeMachineProximityPrompt.ActionText = "Claim Pet";
        elseif v54.SubmittedPet and not v54.IsRunning then
            PetAgeMachineProximityPrompt.ActionText = "Select Dupes";
        elseif not v54.SubmittedPet then
            PetAgeMachineProximityPrompt.ActionText = "Submit Pet";
        end;
    end;

    local v55 = GetMachineData();

    if v55 then
        local v56 = TimeHelper:GenerateColonFormatFromTime(v55.TimeLeft);

        if v55.TimeLeft > 0 then
            TimerTextLabel.Text = `{v56}`;
        elseif v55.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;

    UpdateModel();
end);
task.spawn(function() -- Line: 501
    -- upvalues: u3 (copy), CheckMachineVisibility (copy)
    u3.Parent = script;

    while not CheckMachineVisibility() do
        u3.Parent = script;
        task.wait(5);
    end;

    u3.Parent = workspace;
end);
PetAgeLimitBreak_PlayEffects.OnClientEvent:Connect(ClaimAnimation);

return {};