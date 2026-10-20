-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
local SoundService = game:GetService("SoundService");
game:GetService("TweenService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local HoneyMachine2026Data = require(ReplicatedStorage.Data.HoneyMachine2026Data);
local NPCDialogueController = require(ReplicatedStorage.Modules.NPCDialogueController);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
require(ReplicatedStorage.Data.DefaultData);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local u1 = {
    MutationHandler:GetMutations().Pollinated_Poor,
    MutationHandler:GetMutations().Pollinated_Fair,
    MutationHandler:GetMutations().Pollinated_Good,
    MutationHandler:GetMutations().Pollinated_Godly
};
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local PollenValueMulipliers = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig).Pollination.PollenValueMulipliers;
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local Top_Text = require(game.ReplicatedStorage.Top_Text);
ReplicatedStorage.GameEvents:WaitForChild("Notification");
require(ReplicatedStorage.Modules.UpdateService);
local HoneyMachine2026Service_RE = ReplicatedStorage.GameEvents.HoneyMachine2026Service_RE;
local v2 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 48
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local LocalPlayer = Players.LocalPlayer;
local HoneyMachine2026 = CollectionService:GetTagged("BizzyBee2026")[1]:FindFirstChild("HoneyMachine2026", true);
local Benjamin = HoneyMachine2026.Benjamin;
local HoneyMachine2026Prompt = Benjamin.HumanoidRootPart.HoneyMachine2026Prompt;
local ProximityPrompt = HoneyMachine2026.HoneyCompressor.Output.Jar.ProximityPrompt;
local CollectPrompt = HoneyMachine2026.HoneyCompressor.Output.Jar.CollectPrompt;
local TextLabel = HoneyMachine2026.HoneyCompressor.Sign.SurfaceGui.TextLabel;
local u3 = {};
local u4 = {};
local u5 = {};
local v6 = {};
local u7 = {};
local u8 = {};

for i = 1, 3 do
    local v9 = HoneyMachine2026:FindFirstChild(`HoneyFill{i}`, true);
    local v10;

    if v9 then
        v6[i] = v9.Outer;
        u7[i] = v9.Honey;
        u8[i] = u7[i]:GetPivot().Y - HoneyMachine2026:GetPivot().Y;
        u3[i] = u7[i].Size;
        u4[i] = nil;
        u5[i] = {};
        local Bubbles = v9:FindFirstChild("Bubbles");

        if Bubbles then
            v10 = i;

            for _, descendant in Bubbles:GetDescendants() do
                if descendant:IsA("BasePart") then
                    table.insert(u5[v10], {
                        Part = descendant,
                        OriginalTransparency = descendant.Transparency
                    });
                end;
            end;
        else
            v10 = i;
        end;
    else
        warn((`Missing HoneyFill{i} in HoneyMachine`));
        v10 = i;
    end;
end;

local v11 = v6[1];
local u12 = 0;
local Output = HoneyMachine2026.HoneyCompressor.Output;
local _ = Output.Spout;
local Jar = Output.Jar;
local Lid = Output.Lid;
local Flow = Output.Flow;
local JarHoney = Output.JarHoney;
local _ = JarHoney.Position.Y;
local u13 = JarHoney:GetPivot().Y - HoneyMachine2026:GetPivot().Y;
local Size = JarHoney.Size;
local u14 = nil;
local u15 = 0;
local u16 = false;
local _ = v11.FruitAddedSound;
local _ = v11.FillSound;
local FullSound = v11.FullSound;
FullSound.Parent = SoundService;
local StartSound = v11.StartSound;
local MachineLoopSound = v11.MachineLoopSound;
local MachineDoneSound = v11.MachineDoneSound;
MachineDoneSound.Parent = SoundService;
local PourStartSound = Jar.PourStartSound;
local PourLoopSound = Jar.PourLoopSound;
local TapDoneSound = Jar.TapDoneSound;
local HoneyCollect = Jar.HoneyCollect;
local HoneySell = Jar.HoneySell;
local u17 = Vector3.new(0, 0, 0);
local Pivot = HoneyMachine2026:GetPivot();
local u18 = {};

if u7[1] then
    u18[1] = u7[1]:GetPivot();
end;

if u7[2] then
    u18[2] = u7[2]:GetPivot();
end;

if u7[3] then
    u18[3] = u7[3]:GetPivot();
end;

local Pivot2 = JarHoney:GetPivot();
TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
Chalk.color(Color3.fromRGB(255, 149, 0))("POLLEN");

local function getSkillLevel(p19) -- Line: 179
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();
    local v20 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;

    return v20 and v20[p19] or 0;
end;

local function getMaxPlantWeight() -- Line: 185
    -- upvalues: HoneyMachine2026Data (copy), DataService (copy)
    local MAX_PLANT_WEIGHT = HoneyMachine2026Data.MAX_PLANT_WEIGHT;
    local Data = DataService:GetData();
    local v21 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;

    return MAX_PLANT_WEIGHT * (1 + (v21 and v21.CompressorCapacity or 0));
end;

local function getPollenMultiplier() -- Line: 189
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();
    local v22 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;

    return 1 + (v22 and v22.PollinationAmount or 0) * 0.25;
end;

local function getProcessTime() -- Line: 193
    -- upvalues: DataService (copy), HoneyMachine2026Data (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.BeeEventData;
    end;

    if Data and not Data.HasFirstCompressed then
        return HoneyMachine2026Data.FTUE_TIME_TO_PROCESS;
    end;

    local TIME_TO_PROCESS = HoneyMachine2026Data.TIME_TO_PROCESS;
    local Data2 = DataService:GetData();
    local v23 = Data2 and Data2.BeeEventData and Data2.BeeEventData.BeeSkillTree;

    return TIME_TO_PROCESS * (1 - (v23 and v23.CompressorSpeed or 0) * 0.075);
end;

local function GetMachineData() -- Line: 205
    -- upvalues: LocalPlayer (copy), DataService (copy)
    if not LocalPlayer then
        return warn("No LocalPlayer!");
    end;

    local Data = DataService:GetData();

    if Data then
        return Data.HoneyMachine2026 or warn((`No HoneyMachine2026 data for {LocalPlayer.Name}!`));
    end;

    return warn((`No PlayerData for {LocalPlayer}!`));
end;

local function FetchValidHeldPlant() -- Line: 218
    -- upvalues: LocalPlayer (copy), InventoryServiceEnums (copy), u1 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local v24 = nil;

    for _, child in Character:GetChildren() do
        if child:IsA("Tool") and (child:HasTag("FruitTool") and child:GetAttribute(InventoryServiceEnums.ITEM_UUID)) then
            v24 = child;
            break;
        end;
    end;

    if not v24 then
        return nil;
    end;

    local v25 = false;

    for _, v in u1 do
        if v24:GetAttribute(v.Name) then
            v25 = true;
            break;
        end;
    end;

    if not v25 then
        return nil;
    end;

    if v24:GetAttribute(InventoryServiceEnums.Favorite) then
        return nil;
    end;

    return v24;
end;

local function FetchAllValidPlants() -- Line: 249
    -- upvalues: InventoryServiceEnums (copy), u1 (copy)
    local v26 = {};

    for _, child in char:GetChildren() do
        if child:IsA("Tool") and (child:HasTag("FruitTool") and child:GetAttribute(InventoryServiceEnums.ITEM_UUID)) then
            local v27 = child;
            local v28 = false;

            for _, v in u1 do
                if v27:GetAttribute(v.Name) then
                    v28 = true;
                    break;
                end;
            end;

            if v28 and not v27:GetAttribute(InventoryServiceEnums.Favorite) then
                table.insert(v26, v27);
            end;
        end;
    end;

    return v26;
end;

local function CalculatePlantPollenScore(p29: userdata) -- Line: 277
    -- upvalues: InventoryService (copy), InventoryServiceEnums (copy), PollenValueMulipliers (copy), MutationHandler (copy), Calculate_Weight (copy), CalculatePlantValue (copy), GameConfigController (copy), DataService (copy)
    local ItemData = InventoryService:GetToolData(p29).ItemData;

    if not ItemData then
        return warn("NO ITEM DATA");
    end;

    local Attribute = p29:GetAttribute(InventoryServiceEnums.ITEM_UUID);

    if not Attribute then
        warn((`No GUID for {p29}`));

        return;
    end;

    local ItemName = ItemData.ItemName;

    if not ItemName then
        warn((`No ItemName for {Attribute}`));

        return;
    end;

    local Seed = ItemData.Seed;

    if Seed then
        local v30 = ItemData.WeightMultiplier or 1;
        local v31 = ItemData.PollinationTier and (PollenValueMulipliers[ItemData.PollinationTier] or 1) or 1;
        local v32 = MutationHandler:CalcValueMultiFromMuts(MutationHandler:ExtractMutationsFromString(ItemData.MutationString));
        local v33, _ = Calculate_Weight.Calculate_Weight(Seed, ItemName);
        local v34 = CalculatePlantValue({
            name = ItemData.ItemName,
            variant = ItemData.Variant,
            weight = v33 * v30,
            mutationMultiplier = math.log10(10 + v32),
            fruitVersion = ItemData.FruitVersion
        });
        local Config = GameConfigController:GetConfig("HoneyMachineSettings");
        local v35 = v31 * math.abs(Config.VALUE_COEFFICIENT * (v34 - Config.VALUE_OFFSET_BEFORE) ^ Config.VALUE_POWER + Config.VALUE_OFFSET_AFTER);
        local Data = DataService:GetData();
        local v36 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;

        return math.ceil(v35 * (1 + (v36 and v36.PollinationAmount or 0) * 0.25));
    end;

    warn((`No Seed for {Attribute}`));
end;

local function calculateHoneyReward() -- Line: 307
    -- upvalues: DataService (copy), PollenValueMulipliers (copy), MutationHandler (copy), Calculate_Weight (copy), CalculatePlantValue (copy), GameConfigController (copy)
    local Data = DataService:GetData();

    if not Data then
        return warn("HoneyMachineHandler:MachineInteract | No Data!");
    end;

    local HoneyMachine20262 = Data.HoneyMachine2026;

    if not HoneyMachine20262 then
        return warn("HoneyMachineHandler:MachineInteract | No HoneyMachine data!");
    end;

    local v37 = 0;

    for i, v in HoneyMachine20262.SubmittedPlants do
        local ItemName = v.ItemName;

        if ItemName then
            local Seed = v.Seed;

            if Seed then
                local v38 = v.WeightMultiplier or 1;
                local v39 = v.PollinationTier and (PollenValueMulipliers[v.PollinationTier] or 1) or 1;
                local v40 = MutationHandler:CalcValueMultiFromMuts(MutationHandler:ExtractMutationsFromString(v.MutationString));
                local v41, _ = Calculate_Weight.Calculate_Weight(Seed, ItemName);
                local v42 = CalculatePlantValue({
                    name = v.ItemName,
                    variant = v.Variant,
                    weight = v41 * v38,
                    mutationMultiplier = math.log10(10 + v40),
                    fruitVersion = v.FruitVersion
                });
                local Config = GameConfigController:GetConfig("HoneyMachineSettings");
                v37 = v37 + v39 * math.abs(Config.VALUE_COEFFICIENT * (v42 - Config.VALUE_OFFSET_BEFORE) ^ Config.VALUE_POWER + Config.VALUE_OFFSET_AFTER);
            else
                warn((`No Seed for {i}`));
            end;
        else
            warn((`No ItemName for {i}`));
        end;
    end;

    local Data2 = DataService:GetData();
    local v43 = Data2 and Data2.BeeEventData and Data2.BeeEventData.BeeSkillTree;

    return math.ceil(v37 * (1 + (v43 and v43.PollinationAmount or 0) * 0.25));
end;

local function WillHeldPlantFill() -- Line: 345
    -- upvalues: GetMachineData (copy), FetchValidHeldPlant (copy), InventoryService (copy), InventoryServiceEnums (copy), Calculate_Weight (copy), HoneyMachine2026Data (copy), DataService (copy)
    local v44 = GetMachineData();

    if not v44 then
        return;
    end;

    local v45 = FetchValidHeldPlant();

    if not v45 then
        return false;
    end;

    local ToolData = InventoryService:GetToolData(v45);
    local Attribute = v45:GetAttribute(InventoryServiceEnums.ITEM_UUID);
    local ItemName = ToolData.ItemName;

    if not ItemName then
        warn((`No ItemName for {Attribute}`));

        return;
    end;

    local Seed = ToolData.Seed;

    if Seed then
        local _ = ToolData.WeightMultiplier or 1;
        local v46, _ = Calculate_Weight.Calculate_Weight(Seed, ItemName);
        local v47 = v44.PlantWeight + v46;
        local MAX_PLANT_WEIGHT = HoneyMachine2026Data.MAX_PLANT_WEIGHT;
        local Data = DataService:GetData();
        local v48 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;

        return MAX_PLANT_WEIGHT * (1 + (v48 and v48.CompressorCapacity or 0)) <= v47;
    end;

    warn((`No Seed for {Attribute}`));
end;

local function UpdateTimer() -- Line: 368
    -- upvalues: GetMachineData (copy), TextLabel (copy), TimeHelper (copy), HoneyMachine2026Data (copy), DataService (copy)
    local v49 = GetMachineData();

    if not v49 then
        return;
    end;

    local v50 = tonumber(v49.TimeLeft) or 0;
    local math_max_ret = math.max(0, v50);

    if v49.IsRunning then
        TextLabel.Text = TimeHelper:GenerateColonFormatFromTime(math_max_ret);

        return;
    end;

    if v49.HoneyStored > 0 then
        TextLabel.Text = "READY";

        return;
    end;

    local MAX_PLANT_WEIGHT = HoneyMachine2026Data.MAX_PLANT_WEIGHT;
    local Data = DataService:GetData();
    local v51 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;
    local v52 = MAX_PLANT_WEIGHT * (1 + (v51 and v51.CompressorCapacity or 0));
    TextLabel.Text = `[{math.round(v49.PlantWeight * 100) / 100}/{v52} KG]<br/><font color="rgb(255, 180, 60)">{math.floor(v49.PlantWeight / v52 * 1000) / 10}% Full</font>`;
end;

local function ShakeMachine(p53: number) -- Line: 393
    -- upvalues: u17 (ref), HoneyMachine2026 (copy), Pivot (ref)
    local v54 = p53 or 0.2;
    local v55 = math.random(-100, 100) / 100 * v54;
    local v56 = math.random(-100, 100) / 100 * v54;
    u17 = Vector3.new(v55, v56);
    HoneyMachine2026:PivotTo(Pivot + u17);
end;

local function UpdateBubbles(p57: number) -- Line: 410
    -- upvalues: u7 (copy), u3 (copy), u5 (copy)
    local v58 = u7[p57];
    local v59 = u3[p57];
    local v60 = u5[p57];

    if not (v58 and (v59 and v60)) then
        return;
    end;

    local v61 = v58:GetPivot().Y + v59.Y / 2;

    for _, v in v60 do
        if v61 < v.Part.Position.Y then
            v.Part.Transparency = 1;
        else
            v.Part.Transparency = v.OriginalTransparency;
        end;
    end;
end;

local function UpdateTank(p62: number) -- Line: 428
    -- upvalues: u7 (copy), u3 (copy), u8 (copy), u4 (copy), u12 (ref), HoneyMachine2026 (copy), UpdateBubbles (copy)
    local u63 = p62 or 0.5;

    for i = 1, 3 do
        local u64 = u7[i];
        local v65 = u3[i];
        local v66 = u8[i];
        local v67;

        if u64 and (v65 and v66) then
            if u4[i] then
                task.cancel(u4[i]);
                u4[i] = nil;
            end;

            local v68 = (i - 1) / 3;
            local math_clamp_ret = math.clamp((u12 - v68) / (i / 3 - v68), 0, 1);
            local v69 = v66 - v65.Y;
            local v70 = u64:GetPivot().Y - HoneyMachine2026:GetPivot().Y;
            local v71 = v69 + v65.Y * math_clamp_ret;
            local Position = u64:GetPivot().Position;
            local _, v72, _ = u64:GetPivot():ToEulerAnglesXYZ();
            u64:PivotTo(CFrame.new(Position) * CFrame.Angles(0, v72, 0));
            local u73 = v71 - v70;
            u4[i] = task.spawn(function() -- Line: 457
                -- upvalues: u64 (copy), u73 (copy), UpdateBubbles (ref), i (copy), u63 (ref)
                for i2 = 1, 60 do
                    u64:PivotTo(u64:GetPivot() * CFrame.new(0, u73 / 60, 0));
                    UpdateBubbles(i);
                    task.wait(u63 / 60);
                    local _ = i2;
                end;

                UpdateBubbles(i);
            end);
            v67 = i;
        else
            v67 = i;
        end;
    end;
end;

local function UpdateJar(p74: number) -- Line: 470
    -- upvalues: u14 (ref), u13 (copy), Size (copy), JarHoney (copy), HoneyMachine2026 (copy), u15 (ref)
    if u14 then
        task.cancel(u14);
        u14 = nil;
    end;

    local u75 = p74 or 0.5;
    local v76 = u13 - Size.Y;
    local v77 = JarHoney:GetPivot().Y - HoneyMachine2026:GetPivot().Y;
    local u78 = v76 + Size.Y * u15 - v77;

    if u15 > 0 then
        JarHoney.Transparency = 0;
    elseif v77 <= v76 + 0.1 then
        JarHoney.Transparency = 1;
    end;

    u14 = task.spawn(function() -- Line: 490
        -- upvalues: JarHoney (ref), u78 (copy), u75 (ref)
        for i = 1, 60 do
            JarHoney:PivotTo(JarHoney:GetPivot() + Vector3.new(0, u78 / 60, 0));
            task.wait(u75 / 60);
            local _ = i;
        end;
    end);
end;

local function UpdateTarget() -- Line: 500
    -- upvalues: GetMachineData (copy), u15 (ref), u12 (ref), DataService (copy), HoneyMachine2026Data (copy), Lid (copy), Flow (copy), calculateHoneyReward (copy)
    local v79 = GetMachineData();

    if not v79 then
        return;
    end;

    u15 = 0;
    u12 = nil;

    if v79.IsRunning then
        local v80 = tonumber(v79.TimeLeft) or 0;
        local math_max_ret = math.max(0, v80);
        local Data = DataService:GetData();

        if Data then
            Data = Data.BeeEventData;
        end;

        local v81;

        if Data and not Data.HasFirstCompressed then
            v81 = HoneyMachine2026Data.FTUE_TIME_TO_PROCESS;
        else
            local TIME_TO_PROCESS = HoneyMachine2026Data.TIME_TO_PROCESS;
            local Data2 = DataService:GetData();
            local v82 = Data2 and Data2.BeeEventData and Data2.BeeEventData.BeeSkillTree;
            v81 = TIME_TO_PROCESS * (1 - (v82 and v82.CompressorSpeed or 0) * 0.075);
        end;

        local Data2 = DataService:GetData();

        if Data2 then
            Data2 = Data2.BeeEventData;
        end;

        local v83;

        if Data2 and not Data2.HasFirstCompressed then
            v83 = HoneyMachine2026Data.FTUE_TIME_TO_PROCESS;
        else
            local TIME_TO_PROCESS = HoneyMachine2026Data.TIME_TO_PROCESS;
            local Data3 = DataService:GetData();
            local v84 = Data3 and Data3.BeeEventData and Data3.BeeEventData.BeeSkillTree;
            v83 = TIME_TO_PROCESS * (1 - (v84 and v84.CompressorSpeed or 0) * 0.075);
        end;

        u15 = (v81 - math_max_ret) / v83;
        u12 = 1 - u15;
        Lid.Transparency = 1;
        Flow.Transparency = 0;
    elseif v79.HoneyStored > 0 then
        if DataService:GetData().BeeEventData.HasCollectedHoney then
            u15 = v79.HoneyStored / calculateHoneyReward();
        else
            u15 = 1;
        end;

        Lid.Transparency = 0;
        Flow.Transparency = 1;
    else
        Lid.Transparency = 1;
        Flow.Transparency = 1;
    end;

    if u12 == nil then
        local PlantWeight = v79.PlantWeight;
        local MAX_PLANT_WEIGHT = HoneyMachine2026Data.MAX_PLANT_WEIGHT;
        local Data = DataService:GetData();
        local v85 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;
        u12 = PlantWeight / (MAX_PLANT_WEIGHT * (1 + (v85 and v85.CompressorCapacity or 0)));
    end;

    math.clamp(u15, 0, 1);
    math.clamp(u12, 0, 1);
end;

function v2.MoveTo(p86: table, p87) -- Line: 538
    -- upvalues: Pivot (ref), u18 (copy), Pivot2 (ref), HoneyMachine2026 (copy), u7 (copy), JarHoney (copy), UpdateTank (copy), UpdateJar (copy)
    if not p87 then
        warn("No NewCF!");

        return;
    end;

    local v88 = p87 * Pivot:Inverse();
    Pivot = p87;
    u18[1] = v88 * u18[1];
    u18[2] = v88 * u18[2];
    u18[3] = v88 * u18[3];
    Pivot2 = v88 * Pivot2;
    HoneyMachine2026:PivotTo(p87);
    u7[1]:PivotTo(u18[1]);
    u7[2]:PivotTo(u18[2]);
    u7[3]:PivotTo(u18[3]);
    JarHoney:PivotTo(Pivot2);
    UpdateTank(0.1);
    UpdateJar(0.1);
end;

local function UpdatePrompt() -- Line: 567
    -- upvalues: GetMachineData (copy), HoneyMachine2026Prompt (copy), ProximityPrompt (copy), CollectPrompt (copy), HoneyMachine2026Data (copy), DataService (copy), Benjamin (copy)
    local v89 = GetMachineData();

    if not v89 then
        return;
    end;

    if v89.IsRunning then
        HoneyMachine2026Prompt.Enabled = false;
        ProximityPrompt.Enabled = true;
        CollectPrompt.Enabled = false;

        return;
    end;

    if v89.HoneyStored > 0 then
        HoneyMachine2026Prompt.Enabled = false;
        ProximityPrompt.Enabled = false;
        CollectPrompt.Enabled = true;

        return;
    end;

    local PlantWeight = v89.PlantWeight;
    local MAX_PLANT_WEIGHT = HoneyMachine2026Data.MAX_PLANT_WEIGHT;
    local Data = DataService:GetData();
    local v90 = Data and Data.BeeEventData and Data.BeeEventData.BeeSkillTree;

    if PlantWeight < MAX_PLANT_WEIGHT * (1 + (v90 and v90.CompressorCapacity or 0)) then
        HoneyMachine2026Prompt.Enabled = not Benjamin:GetAttribute("ConversationStarted");
        ProximityPrompt.Enabled = false;
        CollectPrompt.Enabled = false;
    end;
end;

task.spawn(function() -- Line: 589
    -- upvalues: UpdateTarget (copy), UpdatePrompt (copy), UpdateTimer (copy), UpdateJar (copy)
    while true do
        task.wait(0.5);
        UpdateTarget();
        UpdatePrompt();
        UpdateTimer();
        UpdateJar(0.5);
    end;
end);
task.spawn(function() -- Line: 600
    -- upvalues: UpdateTank (copy)
    while true do
        task.wait(5);
        UpdateTank(5);
    end;
end);
CollectPrompt.Triggered:Connect(function() -- Line: 607
    -- upvalues: u16 (ref), HoneyCollect (copy), HoneySell (copy), HoneyMachine2026Service_RE (copy)
    if u16 then
        return;
    end;

    u16 = true;
    HoneyCollect:Play();
    HoneySell:Play();
    HoneyMachine2026Service_RE:FireServer("CollectHoney");
    task.delay(1, function() -- Line: 615
        -- upvalues: u16 (ref)
        u16 = false;
    end);
end);
local u91 = false;
local NumberRange_new_ret = NumberRange.new(0.025, 0.2);
local u92 = 0.01;
task.spawn(function() -- Line: 628
    -- upvalues: HoneyMachine2026 (copy), u91 (ref), workspace_CurrentCamera (ref), Pivot (ref), u92 (ref), NumberRange_new_ret (copy)
    while true do
        while true do
            task.wait(0.5);

            if not HoneyMachine2026:IsDescendantOf(workspace) then
                break;
            end;

            if select(2, workspace_CurrentCamera:WorldToViewportPoint(Pivot.Position)) then
                u92 = math.clamp(0.001 * (workspace_CurrentCamera.CFrame.Position - Pivot.Position).Magnitude, NumberRange_new_ret.Min, NumberRange_new_ret.Max);
                u91 = true;
            else
                u91 = false;
            end;
        end;

        u91 = false;
    end;
end);
task.spawn(function() -- Line: 643
    -- upvalues: u92 (ref), u91 (ref), GetMachineData (copy), u17 (ref), HoneyMachine2026 (copy), Pivot (ref)
    while true do
        repeat
            task.wait(u92);
        until u91;

        local v93 = GetMachineData();

        if v93 and v93.IsRunning then
            local v94 = 0.05 or 0.2;
            local v95 = math.random(-100, 100) / 100 * v94;
            local v96 = math.random(-100, 100) / 100 * v94;
            u17 = Vector3.new(v95, v96);
            HoneyMachine2026:PivotTo(Pivot + u17);
        end;
    end;
end);
DataService:GetPathSignal("HoneyMachine2026/@"):Connect(function() -- Line: 654
    -- upvalues: GetMachineData (copy), UpdateTarget (copy), UpdateTimer (copy), UpdatePrompt (copy), UpdateJar (copy), UpdateTank (copy), MachineLoopSound (copy), SoundService (copy), FullSound (copy), StartSound (copy), PourStartSound (copy), PourLoopSound (copy)
    local v97 = GetMachineData();

    if not v97 then
        return;
    end;

    local v98 = v97.IsRunning and 0.5 or 5;
    UpdateTarget();
    UpdateTimer();
    UpdatePrompt();
    UpdateJar();
    UpdateTank(v98);

    if v97.IsRunning and (v97.TimeLeft >= 5 and not MachineLoopSound.IsPlaying) then
        SoundService:PlayLocalSound(FullSound);
        StartSound:Play();
        PourStartSound:Play();
        MachineLoopSound:Play();
        PourLoopSound:Play();
    end;
end);
DataService:GetPathSignal("BeeEventData/BeeSkillTree/@"):Connect(function() -- Line: 675
    -- upvalues: UpdateTarget (copy), UpdatePrompt (copy), UpdateJar (copy), UpdateTank (copy)
    UpdateTarget();
    UpdatePrompt();
    UpdateJar();
    UpdateTank(5);
end);
DataService:GetPathSignal("HoneyMachine2026/IsRunning"):Connect(function() -- Line: 683
    -- upvalues: GetMachineData (copy), MachineLoopSound (copy), PourLoopSound (copy), SoundService (copy), MachineDoneSound (copy), TapDoneSound (copy)
    local v99 = GetMachineData();

    if not v99 then
        return;
    end;

    if not v99.IsRunning then
        MachineLoopSound:Stop();
        PourLoopSound:Stop();
        SoundService:PlayLocalSound(MachineDoneSound);
        TapDoneSound:Play();
    end;
end);
UpdateJar(0.1);
UpdateTank(0.1);
local v100 = { "Compress this pollinated plant", "Compress all my pollinated plants", "Goodbye" };
NPCDialogueController:Start({
    ExitLine = "Fly back soon.",
    DeactivationDistance = 20,
    ProximityPrompt = HoneyMachine2026Prompt,
    SpeakingNPC = Benjamin,
    PromptList = v100,
    OperationMap = {
        [v100[1]] = function() -- Line: 705
            -- upvalues: Top_Text (copy), Benjamin (copy), HoneyMachine2026Service_RE (copy)
            Top_Text.NpcText(Benjamin, "Let me see...", true);
            task.wait(1.6);
            HoneyMachine2026Service_RE:FireServer("SubmitHeld");
        end,

        [v100[2]] = function() -- Line: 712
            -- upvalues: Top_Text (copy), Benjamin (copy), HoneyMachine2026Service_RE (copy)
            Top_Text.NpcText(Benjamin, "Let me see...", true);
            task.wait(1.5);
            HoneyMachine2026Service_RE:FireServer("SubmitAll");
        end,

        [v100[3]] = function() -- Line: 719
            task.wait(0.3);
        end
    },
    IntroLines = { "This machine is the honey compressor!" },
    RootPart = Benjamin.HumanoidRootPart,

    OnDialogueStarted = function() -- Line: 735, Name: OnDialogueStarted
    end,

    OnDialogueEnded = function() -- Line: 737, Name: OnDialogueEnded
    end
});

return v2;