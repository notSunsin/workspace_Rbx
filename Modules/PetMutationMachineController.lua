-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("SoundService");
require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.Chalk);
local PolicyService = require(ReplicatedStorage.Modules.PolicyService);
require(ReplicatedStorage.Modules.PetTraitsData);
require(ReplicatedStorage.Calculate_Weight);
require(ReplicatedStorage.Modules.UpdateService);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local PetList = require(ReplicatedStorage.Data.PetRegistry).PetList;
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
require(ReplicatedStorage.Data.DefaultData);
local PetMutationMachineData = require(ReplicatedStorage.Data.PetMutationMachineData);
local PetMutationMachineService_RE = ReplicatedStorage:WaitForChild("GameEvents").PetMutationMachineService_RE;
local LocalPlayer = Players.LocalPlayer;
local u2 = false;
local u3 = nil;
local v4 = workspace:FindFirstChild("NPCS") and workspace.NPCS:QueryDescendants(".PetMutationMachine") or {};

if not next(v4) then
    v4 = workspace:QueryDescendants(".PetMutationMachine");
end;

if #v4 <= 0 then
    warn("Cannot find Pet Mutation machine");

    return {};
end;

local u5 = v4[1];
local TimerTextLabel = u5:FindFirstChild("TimerTextLabel", true);
local PetModelLocation = u5:FindFirstChild("PetModelLocation", true);
local u6 = {};
local u7 = nil;
local PetMutationMachineProximityPrompt = u5:FindFirstChild("PetMutationMachineProximityPrompt", true);

local function GetMachineData() -- Line: 81
    -- upvalues: LocalPlayer (copy), DataService (copy)
    if not LocalPlayer then
        return warn("No LocalPlayer!");
    end;

    local Data = DataService:GetData();

    if Data then
        return Data.PetMutationMachine or warn((`No PetMuationMachine data for {LocalPlayer.Name}!`));
    end;

    return warn((`No PlayerData for {LocalPlayer}!`));
end;

local function UpdateModel() -- Line: 94
    -- upvalues: GetMachineData (copy), u3 (ref), SelectiveAssetReplication (copy), PetList (copy), PetModelLocation (copy)
    local v8 = GetMachineData();

    if not v8 then
        return;
    end;

    if not v8.SubmittedPet then
        if u3 then
            u3:Destroy();
            u3 = nil;
        end;

        return;
    end;

    local v9 = SelectiveAssetReplication:GetAssetAsync("PetAssets", v8.SubmittedPet.PetType):Clone();
    local v10 = PetList[v8.SubmittedPet.PetType];
    v9:SetPrimaryPartCFrame(CFrame.new(v9:GetPrimaryPartCFrame().Position) * v10.WeldOffset);
    u3 = v9;

    if not u3 then
        return;
    end;

    if not (u3.PrimaryPart and PetModelLocation.PrimaryPart) then
        warn("Both models need a PrimaryPart set.");

        return;
    end;

    local ExtentsSize = u3:GetExtentsSize();
    local ExtentsSize2 = PetModelLocation:GetExtentsSize();
    local math_min_ret = math.min(ExtentsSize2.X / ExtentsSize.X, ExtentsSize2.Y / ExtentsSize.Y, ExtentsSize2.Z / ExtentsSize.Z);

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    u3:ScaleTo(math_min_ret);
    local Rotation = u3:GetPivot().Rotation;
    local Position = PetModelLocation:GetPivot().Position;
    u3:PivotTo(CFrame.new(Position) * Rotation);
    u3.Parent = PetModelLocation;
end;

local function UpdateTimer() -- Line: 152
    -- upvalues: GetMachineData (copy), TimeHelper (copy), TimerTextLabel (copy)
    local v11 = GetMachineData();

    if not v11 then
        return;
    end;

    local v12 = TimeHelper:GenerateColonFormatFromTime(v11.TimeLeft);

    if v11.TimeLeft > 0 then
        TimerTextLabel.Text = `{v12}`;

        return;
    end;

    if v11.PetReady then
        TimerTextLabel.Text = "READY";

        return;
    end;

    TimerTextLabel.Text = "";
end;

local u13 = 0;

local function AnimatePet(p14: userdata) -- Line: 174
    -- upvalues: u13 (ref)
    local v15 = math.sin(u13) * 0.01;
    local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
    p14:PivotTo((p14:GetPivot() + Vector3.new(0, v15, 0)) * CFrame_Angles_ret);
end;

local u16 = nil;

local function UpdatePrompt() -- Line: 188
    -- upvalues: u6 (copy), LocalPlayer (copy), PetMutationMachineProximityPrompt (copy), GetMachineData (copy), u16 (ref), DataService (copy), CountDictionary (copy), NumberUtil (copy), PetMutationMachineData (copy)
    if u6[LocalPlayer] then
        PetMutationMachineProximityPrompt.Enabled = false;

        return;
    end;

    local v17 = GetMachineData();

    if not v17 then
        return;
    end;

    PetMutationMachineProximityPrompt.Enabled = true;

    if v17.IsRunning or v17.TimeLeft > 0 then
        if u16 and u16.ArePaidRandomItemsRestricted then
            PetMutationMachineProximityPrompt.Enabled = false;

            return;
        end;

        PetMutationMachineProximityPrompt.ActionText = "Skip";

        return;
    end;

    if not v17.PetReady then
        if v17.SubmittedPet and not v17.IsRunning then
            PetMutationMachineProximityPrompt.ActionText = `Start Mutation: {NumberUtil.DisplaySheckles(PetMutationMachineData.MUTATE_PRICE)}`;

            return;
        end;

        if not v17.SubmittedPet then
            PetMutationMachineProximityPrompt.ActionText = "Submit Pet";
        end;

        return;
    end;

    local Data = DataService:GetData();

    if Data then
        Data = Data.PetsData;
    end;

    local v18;

    if Data then
        v18 = Data.MutableStats;
    else
        v18 = Data;
    end;

    if Data then
        Data = Data.PetInventory;
    end;

    if Data then
        Data = Data.Data;
    end;

    if v18 and Data then
        local v19 = CountDictionary(Data);
        local MaxPetsInInventory = v18.MaxPetsInInventory;

        if MaxPetsInInventory <= v19 then
            PetMutationMachineProximityPrompt.ActionText = `Inventory Full ({v19}/{MaxPetsInInventory})`;

            return;
        end;
    end;

    PetMutationMachineProximityPrompt.ActionText = "Claim Pet";
end;

task.spawn(function() -- Line: 238
    -- upvalues: u16 (ref), PolicyService (copy), LocalPlayer (copy), UpdatePrompt (copy)
    u16 = PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
    UpdatePrompt();
end);

local function quadraticBezier(p20: number, p21: any, p22: any, p23: any) -- Line: 244
    return (1 - p20) ^ 2 * p21 + (1 - p20) * 2 * p20 * p22 + p20 ^ 2 * p23;
end;

local function ClaimAnimation(p24: userdata, p25: number) -- Line: 248
    -- upvalues: u5 (copy), u3 (ref), ReplicatedStorage (copy), RunService (copy), u13 (ref), LocalPlayer (copy), SoundPlayer (copy), SoundData (copy), TweenService (copy), PetList (copy)
    local PetMutationMachinePoof = u5:FindFirstChild("PetMutationMachinePoof");
    local PixelSmoke = PetMutationMachinePoof.PixelSmoke;

    if not u3 then
        return;
    end;

    local u26 = u3:Clone();
    u26.Parent = u3.Parent;
    u3.Parent = ReplicatedStorage;
    local v30 = RunService.RenderStepped:Connect(function(p27) -- Line: 260
        -- upvalues: u26 (copy), u13 (ref)
        local v28 = u26;
        local v29 = math.sin(u13) * 0.01;
        local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
        v28:PivotTo((v28:GetPivot() + Vector3.new(0, v29, 0)) * CFrame_Angles_ret);
    end);
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    SoundPlayer:PlaySound(SoundData.MachineSounds.SFX, {}, nil, PetMutationMachinePoof);
    local Pivot = u5:GetPivot();
    local v31 = 0;

    while v31 < 1.5 do
        v31 = v31 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v31 / 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local math_lerp_ret = math.lerp(0.01, 0.1, Value);
        local v32 = math.random(-100, 100) / 100 * math_lerp_ret;
        local v33 = math.random(-100, 100) / 100 * math_lerp_ret;
        local v34 = math.random(-100, 100) / 100 * math_lerp_ret;
        u5:PivotTo(Pivot + Vector3.new(v32, v33, v34));
    end;

    PixelSmoke:Emit(26);
    u26:Destroy();
    v30:Disconnect();
    local v35 = PetList[p24.Name];
    local v36;

    if v35 and v35.WeldOffset then
        v36 = v35.WeldOffset;
    else
        v36 = nil;
    end;

    local v37 = CFrame.lookAt(u26:GetPivot().Position, Character:GetPivot().Position) * v36;
    local v38 = p24:Clone();
    v38:ScaleTo(u26:GetScale() * p25);
    v38:PivotTo(v37);

    for _, descendant in v38:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    local BoundingBox, v39 = v38:GetBoundingBox();
    local Part = Instance.new("Part");
    Part.CFrame = BoundingBox;
    Part.Name = "TrailPart";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Size = v39;
    Part.Transparency = 1;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "Attachment";
    Attachment.CFrame = CFrame.new(0, v39.Y * 0.5, 0);
    Attachment.Parent = Part;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Name = "Attachment";
    Attachment2.CFrame = CFrame.new(0, -v39.Y * 0.5, 0);
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
    Part.Parent = v38;
    v38.Parent = workspace.CurrentCamera;
    task.wait(0.8);
    local Scale = v38:GetScale();
    local v40 = 0;

    while v40 < 0.8 do
        v40 = v40 + RunService.Heartbeat:Wait();
        local Position = v37.Position;
        local Position2 = Character:GetPivot().Position;
        local Value = TweenService:GetValue(v40 / 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local math_clamp_ret = math.clamp((v40 - 0.4) / 0.4, 0, 1);
        v38:ScaleTo((math.lerp(Scale, 0.05, math_clamp_ret)));
        v38:PivotTo(CFrame.new((1 - Value) ^ 2 * Position + (1 - Value) * 2 * Value * (Position + (Position2 - Position) * 0.5 + Vector3.new(0, 14, 0)) + Value ^ 2 * Position2) * v37.Rotation);
    end;

    v38:Destroy();
    local u41 = workspace.Terrain.PopEffect:Clone();
    u41.CFrame = Character:GetPivot();
    SoundPlayer:PlaySound(SoundData.MachineSounds.Retrieve, {}, nil, u41);
    u41.Parent = workspace.Terrain;

    for _, child in u41:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child:Emit(1);
        end;
    end;

    task.delay(1.5, function() -- Line: 395
        -- upvalues: u41 (copy)
        u41:Destroy();
    end);
end;

PetMutationMachineProximityPrompt.Triggered:Connect(function() -- Line: 402
    -- upvalues: u2 (ref), GetMachineData (copy), PetMutationMachineService_RE (copy), LocalPlayer (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), PetsService (copy), ReplicatedStorage (copy), ConfirmationPromptController (copy)
    if u2 then
        return;
    end;

    u2 = true;
    task.delay(0.5, function() -- Line: 408
        -- upvalues: u2 (ref)
        u2 = false;
    end);
    local v42 = GetMachineData();

    if not v42 then
        return;
    end;

    if v42.IsRunning or v42.TimeLeft > 0 then
        PetMutationMachineService_RE:FireServer("AuthoriseSkip");
    end;

    if v42.PetReady then
        PetMutationMachineService_RE:FireServer("ClaimMutatedPet");

        return;
    end;

    if v42.SubmittedPet and not v42.IsRunning then
        PetMutationMachineService_RE:FireServer("StartMachine");

        return;
    end;

    if not v42.SubmittedPet then
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local v43 = Character:FindFirstChildWhichIsA("Tool");

        if not v43 then
            return;
        end;

        if v43:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums.Pet then
            return;
        end;

        local PlayerPetData = PetsService:GetPlayerPetData(v43:GetAttribute("PET_UUID"));
        local v44 = require(ReplicatedStorage.Data.PetRegistry.PetList)[PlayerPetData.PetType];
        local v45 = not v44 and "Common" or v44.Rarity;
        local v46 = {
            Title = "Submit Pet To Mutation Machine",
            Header = "Are you sure you want to submit that pet?",
            Footer = "Your pet will reset back to age 1."
        };
        local v47 = v43:GetAttribute(InventoryServiceEnums.ItemName) or v43.Name;
        v46.Middle = `{tostring(v47)}`;
        local v48 = {};
        local v49 = v43:GetAttribute(InventoryServiceEnums.ItemName) or v43.Name;
        v48[`{tostring(v49)}`] = v45;
        v46.AnimatedWords = v48;
        ConfirmationPromptController:Open(v46, {
            ConfirmEvent = PetMutationMachineService_RE,
            ConfirmEventData = { "SubmitHeldPet" }
        });
    end;
end);
DataService:GetPathSignal("PetMutationMachine/IsRunning"):Connect(function() -- Line: 461
    -- upvalues: GetMachineData (copy), UpdatePrompt (copy), TimeHelper (copy), TimerTextLabel (copy), SoundPlayer (copy), SoundData (copy), u5 (copy), u7 (ref)
    local v50 = GetMachineData();

    if not v50 then
        return;
    end;

    UpdatePrompt();
    local v51 = GetMachineData();

    if v51 then
        local v52 = TimeHelper:GenerateColonFormatFromTime(v51.TimeLeft);

        if v51.TimeLeft > 0 then
            TimerTextLabel.Text = `{v52}`;
        elseif v51.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;

    if v50.IsRunning then
        SoundPlayer:PlaySound(SoundData.MachineSounds.Start, {}, nil, u5);

        if u7 then
            u7:Play();

            return;
        end;

        u7 = SoundPlayer:PlaySound(SoundData.MachineSounds.Loop, {
            Looped = true
        }, nil, u5);

        return;
    end;

    SoundPlayer:PlaySound(SoundData.MachineSounds.LoopDone);

    if u7 then
        u7:Stop();
    end;

    task.spawn(function() -- Line: 479
        -- upvalues: SoundPlayer (ref), SoundData (ref)
        task.wait(1);
        SoundPlayer:PlaySound(SoundData.MachineSounds.Finished);
    end);
end);
DataService:GetPathSignal("PetMutationMachine/SubmittedPet"):Connect(function() -- Line: 487
    -- upvalues: GetMachineData (copy), UpdatePrompt (copy), TimeHelper (copy), TimerTextLabel (copy), UpdateModel (copy), SoundPlayer (copy), SoundData (copy)
    local v53 = GetMachineData();

    if not v53 then
        return;
    end;

    UpdatePrompt();
    local v54 = GetMachineData();

    if v54 then
        local v55 = TimeHelper:GenerateColonFormatFromTime(v54.TimeLeft);

        if v54.TimeLeft > 0 then
            TimerTextLabel.Text = `{v55}`;
        elseif v54.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;

    UpdateModel();

    if v53.SubmittedPet then
        SoundPlayer:PlaySound(SoundData.MachineSounds.Insert);
    end;
end);
RunService.RenderStepped:Connect(function(p56: number) -- Line: 500
    -- upvalues: u3 (ref), u13 (ref)
    if not u3 then
        return;
    end;

    if u3.PrimaryPart then
        u13 = u13 + p56;
        local v57 = u3;
        local v58 = math.sin(u13) * 0.01;
        local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
        v57:PivotTo((v57:GetPivot() + Vector3.new(0, v58, 0)) * CFrame_Angles_ret);
    end;
end);
task.spawn(function() -- Line: 511
    -- upvalues: UpdatePrompt (copy), GetMachineData (copy), TimeHelper (copy), TimerTextLabel (copy)
    while true do
        local v59;

        repeat
            task.wait(0.25);
            UpdatePrompt();
            v59 = GetMachineData();
        until v59;

        local v60 = TimeHelper:GenerateColonFormatFromTime(v59.TimeLeft);

        if v59.TimeLeft > 0 then
            TimerTextLabel.Text = `{v60}`;
        elseif v59.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;
end);
task.spawn(function() -- Line: 534
    -- upvalues: GetMachineData (copy), UpdatePrompt (copy), TimeHelper (copy), TimerTextLabel (copy), UpdateModel (copy), RebirthUnlocksSharedService (copy), LocalPlayer (copy), u6 (copy)
    if not GetMachineData() then
        return;
    end;

    UpdatePrompt();
    local v61 = GetMachineData();

    if v61 then
        local v62 = TimeHelper:GenerateColonFormatFromTime(v61.TimeLeft);

        if v61.TimeLeft > 0 then
            TimerTextLabel.Text = `{v62}`;
        elseif v61.PetReady then
            TimerTextLabel.Text = "READY";
        else
            TimerTextLabel.Text = "";
        end;
    end;

    UpdateModel();

    if RebirthUnlocksSharedService:HasUnlockedFeature(LocalPlayer, "PET_MUTATION_MACHINE") then
        return;
    end;

    u6[LocalPlayer] = true;
    UpdatePrompt();
    local u63 = nil;
    u63 = RebirthUnlocksSharedService.OnRebirthUnlock:Connect(function(p64: userdata, p65: string) -- Line: 547
        -- upvalues: LocalPlayer (ref), u63 (ref), u6 (ref)
        if p64 ~= LocalPlayer then
            return;
        end;

        if p65 ~= "PET_MUTATION_MACHINE" then
            return;
        end;

        if u63 then
            u63:Disconnect();
            u63 = nil;
        end;

        u6[p64] = nil;
    end);
end);
ReplicatedStorage.GameEvents.PetMutationClaimAnimation.OnClientEvent:Connect(ClaimAnimation);

return v1;