-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.InventoryService);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
require(ReplicatedStorage.Modules.UpdateService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Data.DefaultData);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local u1 = Trove.new();
local Config = GameConfigController:GetConfig("PrehistoricEventConfig");
workspace:GetAttributeChangedSignal("PrehistoricEventConfig"):Connect(function() -- Line: 26
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("PrehistoricEventConfig");
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Notification;
local ClaimFromDinoMachine = GameEvents.Events.PrehistoricEvent.ClaimFromDinoMachine;
local LocalPlayer = Players.LocalPlayer;
local script_RewardModel = script.RewardModel;
local script_MachineStartSound = script.MachineStartSound;
local script_MachineLoopSound = script.MachineLoopSound;
local script_MachineDoneSound = script.MachineDoneSound;
local u2 = nil;
local u3 = false;
local u4 = {};

local function GetMachineData() -- Line: 48
    -- upvalues: LocalPlayer (copy), DataService (copy)
    if not LocalPlayer then
        warn("No LocalPlayer!");

        return nil;
    end;

    local Data = DataService:GetData();

    if not Data then
        warn((`No PlayerData for {LocalPlayer}!`));

        return nil;
    end;

    local PrehistoricEventData = Data.PrehistoricEventData;

    if PrehistoricEventData then
        return PrehistoricEventData;
    end;

    warn((`No DinoMachine data for {LocalPlayer.Name}!`));

    return nil;
end;

function u4.Start(p5) -- Line: 60
    -- upvalues: EventRotationUtils (copy), GetMachineData (copy), TimeHelper (copy), script_RewardModel (copy), ItemImageFinder (copy), u2 (ref), script_MachineStartSound (copy), script_MachineLoopSound (copy), CountDictionary (copy), Config (ref), Calculate_Weight (copy), FastTween (copy), u1 (copy), u3 (ref), ClaimFromDinoMachine (copy), DataService (copy), SoundService (copy), script_MachineDoneSound (copy)
    local u6 = EventRotationUtils:GetEventIDModelsWait("PrehistoricEventPart1")[1];
    local FossilClaimProximityPrompt = u6:FindFirstChild("FossilClaimProximityPrompt", true);
    local DnaMachineLabel = u6:FindFirstChild("DnaMachineLabel", true);
    local DinoMachineRewardDisplayPart = u6:FindFirstChild("DinoMachineRewardDisplayPart", true);
    local DnaSwirl = u6:FindFirstChild("DnaSwirl", true);
    local Parent = DnaSwirl.Parent;
    local DnaMachineBase = u6:WaitForChild("DnaMachineBase");

    local function UpdatePrompt() -- Line: 71
        -- upvalues: GetMachineData (ref), FossilClaimProximityPrompt (copy)
        local v7 = GetMachineData();

        if not v7 then
            return;
        end;

        if v7.RewardReady then
            FossilClaimProximityPrompt.Enabled = true;

            return;
        end;

        FossilClaimProximityPrompt.Enabled = false;
    end;

    local function UpdateTimer() -- Line: 83
        -- upvalues: GetMachineData (ref), TimeHelper (ref), DnaMachineLabel (copy), script_RewardModel (ref), DinoMachineRewardDisplayPart (copy), ItemImageFinder (ref)
        local v8 = GetMachineData();

        if not v8 then
            return;
        end;

        local v9 = TimeHelper:GenerateColonFormatFromTime(v8.TimeLeft);

        if v8.TimeLeft > 0 then
            DnaMachineLabel.Text = `{v9}`;

            return;
        end;

        if not (v8.RewardReady and (v8.RewardName and v8.RewardType)) then
            if v8.RewardReady or v8.IsRunning then
                return;
            end;

            DnaMachineLabel.Text = "Trade Pets for Dinos";
            script_RewardModel.Parent = script;

            return;
        end;

        DnaMachineLabel.Text = "READY";
        script_RewardModel.Parent = DinoMachineRewardDisplayPart;
        script_RewardModel:PivotTo(CFrame.new(DinoMachineRewardDisplayPart.Position));
        local ImageLabel = script_RewardModel:FindFirstChild("ImageLabel", true);
        local TextLabel = script_RewardModel:FindFirstChild("TextLabel", true);
        ImageLabel.Image = ItemImageFinder(v8.RewardName, v8.RewardType);

        if TextLabel and (v8.RewardAmount and v8.RewardAmount > 1) then
            TextLabel.Text = "x" .. tostring(v8.RewardAmount);

            return;
        end;

        TextLabel.Text = "";
    end;

    local function UpdateSwirl(p10: boolean) -- Line: 119
        -- upvalues: DnaSwirl (copy), u2 (ref), Parent (copy), script_MachineStartSound (ref), script_MachineLoopSound (ref)
        if not p10 then
            DnaSwirl.Parent = script;

            if u2 then
                task.cancel(u2);
                u2 = nil;
            end;

            return;
        end;

        if u2 then
            return;
        end;

        DnaSwirl.Parent = Parent;
        script_MachineStartSound:Play();
        script_MachineLoopSound:Play();
        u2 = task.spawn(function() -- Line: 135
            -- upvalues: DnaSwirl (ref)
            while true do
                local v11;

                repeat
                    task.wait(0.1);
                    v11 = DnaSwirl.PrimaryPart;
                until v11;

                local CFrame_Angles_ret = CFrame.Angles(0, 0.3490658503988659, 0);
                DnaSwirl:PivotTo(v11.CFrame * CFrame_Angles_ret);
            end;
        end);
    end;

    local function UpdateMachine(p12: number) -- Line: 149
        -- upvalues: DnaMachineBase (ref), u6 (copy)
        if p12 == 0 then
            return;
        end;

        local v13 = `DnaMachineLvl{p12}`;
        local v14 = script:FindFirstChild(v13, true);

        if not v14 then
            return;
        end;

        DnaMachineBase.Parent = script;
        DnaMachineBase = v14;
        DnaMachineBase.Parent = u6;
    end;

    local function UpdateUpgradeUI() -- Line: 161
        -- upvalues: EventRotationUtils (ref), GetMachineData (ref), CountDictionary (ref), Config (ref), Calculate_Weight (ref), FastTween (ref)
        local BillboardGui = EventRotationUtils:GetEventIDModelsWait("PrehistoricEventPart2")[1]:WaitForChild("MainPart"):WaitForChild("BillboardPart"):WaitForChild("BillboardGui");
        local UpgradeBar = BillboardGui:WaitForChild("UpgradeBar");
        local UpgradeLabel = BillboardGui:WaitForChild("UpgradeLabel");
        local ProgressionLabel = UpgradeBar:WaitForChild("ProgressionLabel");
        local v15 = GetMachineData();

        if not v15 then
            return;
        end;

        if v15.CurrentMachineLevel >= CountDictionary(Config.LevelPlantWeightRequirements) then
            UpgradeLabel.Text = "Max Level";
            UpgradeBar.Visible = false;

            return;
        end;

        local v16 = 0;

        for i, v in v15.SubmittedPlants do
            local ItemName = v.ItemName;

            if ItemName then
                local Seed = v.Seed;

                if Seed then
                    local v17 = v.WeightMultiplier or 1;
                    local v18, _ = Calculate_Weight.Calculate_Weight(Seed, ItemName);
                    v16 = v16 + v18 * v17;
                else
                    warn((`No Seed for {i}`));
                end;
            else
                warn((`No ItemName for {i}`));
            end;
        end;

        local v19 = Config.LevelPlantWeightRequirements[v15.CurrentMachineLevel + 1];
        ProgressionLabel.Text = `{math.floor(v16)}/{v19} KG`;
        local v20 = math.floor(v16) / v19;
        local math_clamp_ret = math.clamp(v20, 0, 1);
        FastTween(UpgradeBar:FindFirstChild("Fill"), TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        });
    end;

    u1:Add(FossilClaimProximityPrompt.Triggered:Connect(function() -- Line: 209
        -- upvalues: u3 (ref), ClaimFromDinoMachine (ref)
        if u3 then
            return;
        end;

        u3 = true;
        ClaimFromDinoMachine:FireServer("ClaimReward");
        task.wait(1);
        u3 = false;
    end));
    u1:Add(DataService:GetPathSignal("PrehistoricEventData/CurrentMachineLevel"):Connect(function() -- Line: 217
        -- upvalues: GetMachineData (ref), DnaMachineBase (ref), u6 (copy)
        local v21 = GetMachineData();

        if not v21 then
            return;
        end;

        local CurrentMachineLevel = v21.CurrentMachineLevel;

        if CurrentMachineLevel == 0 then
            return;
        end;

        local v22 = `DnaMachineLvl{CurrentMachineLevel}`;
        local v23 = script:FindFirstChild(v22, true);

        if not v23 then
            return;
        end;

        DnaMachineBase.Parent = script;
        DnaMachineBase = v23;
        DnaMachineBase.Parent = u6;
    end));
    u1:Add(DataService:GetPathSignal("PrehistoricEventData/SubmittedPlants"):Connect(function() -- Line: 224
        -- upvalues: GetMachineData (ref), UpdateUpgradeUI (copy)
        if not GetMachineData() then
            return;
        end;

        UpdateUpgradeUI();
    end));
    u1:Add(DataService:GetPathSignal("PrehistoricEventData/IsRunning"):Connect(function() -- Line: 231
        -- upvalues: GetMachineData (ref), FossilClaimProximityPrompt (copy), UpdateTimer (copy), u2 (ref), DnaSwirl (copy), Parent (copy), script_MachineStartSound (ref), script_MachineLoopSound (ref), SoundService (ref), script_MachineDoneSound (ref)
        local v24 = GetMachineData();

        if not v24 then
            return;
        end;

        local v25 = GetMachineData();

        if v25 then
            if v25.RewardReady then
                FossilClaimProximityPrompt.Enabled = true;
            else
                FossilClaimProximityPrompt.Enabled = false;
            end;
        end;

        UpdateTimer();

        if not v24.IsRunning then
            DnaSwirl.Parent = script;

            if u2 then
                task.cancel(u2);
                u2 = nil;
            end;

            SoundService:PlayLocalSound(script_MachineDoneSound);
            script_MachineLoopSound:Stop();

            return;
        end;

        if u2 then
            return;
        end;

        DnaSwirl.Parent = Parent;
        script_MachineStartSound:Play();
        script_MachineLoopSound:Play();
        u2 = task.spawn(function() -- Line: 135
            -- upvalues: DnaSwirl (ref)
            while true do
                local v26;

                repeat
                    task.wait(0.1);
                    v26 = DnaSwirl.PrimaryPart;
                until v26;

                local CFrame_Angles_ret = CFrame.Angles(0, 0.3490658503988659, 0);
                DnaSwirl:PivotTo(v26.CFrame * CFrame_Angles_ret);
            end;
        end);
    end));
    u1:Add(task.spawn(function() -- Line: 247
        -- upvalues: GetMachineData (ref), FossilClaimProximityPrompt (copy), UpdateTimer (copy)
        while true do
            task.wait(0.5);
            local v27 = GetMachineData();

            if v27 then
                if v27.RewardReady then
                    FossilClaimProximityPrompt.Enabled = true;
                else
                    FossilClaimProximityPrompt.Enabled = false;
                end;
            end;

            UpdateTimer();
        end;
    end));
    local v28 = GetMachineData();

    if not v28 then
        return;
    end;

    local CurrentMachineLevel = v28.CurrentMachineLevel;

    if CurrentMachineLevel ~= 0 then
        local v29 = `DnaMachineLvl{CurrentMachineLevel}`;
        local v30 = script:FindFirstChild(v29, true);

        if v30 then
            DnaMachineBase.Parent = script;
            DnaMachineBase = v30;
            DnaMachineBase.Parent = u6;
        end;
    end;

    UpdateUpgradeUI();

    if v28.IsRunning then
        if not u2 then
            DnaSwirl.Parent = Parent;
            script_MachineStartSound:Play();
            script_MachineLoopSound:Play();
            u2 = task.spawn(function() -- Line: 135
                -- upvalues: DnaSwirl (copy)
                while true do
                    local v31;

                    repeat
                        task.wait(0.1);
                        v31 = DnaSwirl.PrimaryPart;
                    until v31;

                    local CFrame_Angles_ret = CFrame.Angles(0, 0.3490658503988659, 0);
                    DnaSwirl:PivotTo(v31.CFrame * CFrame_Angles_ret);
                end;
            end);
        end;
    else
        DnaSwirl.Parent = script;

        if u2 then
            task.cancel(u2);
            u2 = nil;
        end;
    end;
end;

local u32 = false;
EventRotationController.EventUpdated:Connect(function(p33: string, p34: string) -- Line: 270, Name: OnEventUpdated
    -- upvalues: u1 (copy), u32 (ref), u4 (copy)
    if p34 ~= "PrehistoricEvent" then
        u1:Clean();
        u32 = false;

        return;
    end;

    if u32 then
        return;
    end;

    u32 = true;
    u1:Clean();
    task.spawn(u4.Start, u4);
end);

return u4;