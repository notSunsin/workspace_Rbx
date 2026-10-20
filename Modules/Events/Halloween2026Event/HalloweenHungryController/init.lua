-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local GlobalUpdateTime = ReplicatedFirst:WaitForChild("GlobalUpdateTime");
local u2 = {
    EVENT_ID = "HalloweenHungry"
};
local success, result = pcall(function() -- Line: 65
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.IsInTradeWorld);
end);

if success and result then
    return u2;
end;

local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SeedPackRewardTrackUIController = require(ReplicatedStorage.Modules.SeedPackRewardTrackUIController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local Config = GameConfigController:GetConfig("HalloweenHungryConfig");
workspace:GetAttributeChangedSignal("HalloweenHungryConfig"):Connect(function() -- Line: 78
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("HalloweenHungryConfig");
end);
local LocalPlayer = Players.LocalPlayer;
local u3 = false;

local function cfg(p4: string, p5: any) -- Line: 87
    -- upvalues: Config (ref)
    local v6 = Config and Config[p4];

    if v6 == nil then
        return p5;
    end;

    return v6;
end;

local function getStartGate() -- Line: 94
    -- upvalues: Config (ref), GlobalUpdateTime (copy)
    local v7 = Config and Config.START_EPOCH;
    local v8 = tonumber(v7 == nil and 0 or v7) or 0;

    return v8 == -1 and (tonumber(GlobalUpdateTime.Value) or 0) or v8;
end;

local function getEndGate() -- Line: 100
    -- upvalues: Config (ref)
    local v9 = Config and Config.END_EPOCH;

    return tonumber(v9 == nil and 0 or v9) or 0;
end;

local function formatClock(p10: number) -- Line: 105
    local math_floor_ret = math.floor(p10);
    local math_max_ret = math.max(math_floor_ret, 0);
    local v11 = math_max_ret // 86400;
    local v12 = math_max_ret % 86400 // 3600;
    local v13 = math_max_ret % 3600 // 60;
    local v14 = math_max_ret % 60;

    if v11 > 0 then
        return string.format("%dd %02d:%02d:%02d", v11, v12, v13, v14);
    end;

    if v12 > 0 then
        return string.format("%d:%02d:%02d", v12, v13, v14);
    end;

    return string.format("%02d:%02d", v13, v14);
end;

local function toColor3(p15: any, p16) -- Line: 120
    if typeof(p15) == "table" and p15[1] then
        return Color3.fromRGB(p15[1], p15[2], p15[3]);
    end;

    return p16;
end;

function u2.GetConfig(p17) -- Line: 128
    -- upvalues: Config (ref)
    return Config;
end;

function u2.GetState(p18: table, p19: number?) -- Line: 133
    -- upvalues: Config (ref), GlobalUpdateTime (copy)
    local v20 = p19 or workspace:GetServerTimeNow();

    if not Config or Config.ENABLED == false then
        return "Disabled";
    end;

    local v21 = Config and Config.START_EPOCH;
    local v22 = tonumber(v21 == nil and 0 or v21) or 0;
    local v23 = v22 == -1 and (tonumber(GlobalUpdateTime.Value) or 0) or v22;

    if v23 > 0 and v20 < v23 then
        return "Upcoming";
    end;

    local v24 = Config and Config.END_EPOCH;
    local v25 = tonumber(v24 == nil and 0 or v24) or 0;

    return v25 > 0 and v25 <= v20 and "Ended" or "Live";
end;

function u2.GetEndTime(p26) -- Line: 145
    -- upvalues: Config (ref), EventRotationUtils (copy)
    local v27 = Config and Config.END_EPOCH;
    local v28 = tonumber(v27 == nil and 0 or v27) or 0;

    if v28 > 0 then
        return v28;
    end;

    local success2, result2 = pcall(function() -- Line: 149
        -- upvalues: EventRotationUtils (ref)
        local CurrentEvent, _, v29 = EventRotationUtils:GetCurrentEvent();

        if not CurrentEvent or CurrentEvent.EventSet ~= "Halloween2026Event" then
            return nil;
        end;

        local v30 = false;

        for _, v in EventRotationUtils:GetEventSetConfigs("Halloween2026Event") do
            if v30 then
                v29 = v29 + (v.Duration or 604800);
            end;

            if v.EventID == CurrentEvent.EventID then
                v30 = true;
            end;
        end;

        return v29;
    end);

    if success2 then
        return result2;
    end;

    return nil;
end;

function u2.GetProgress(p31) -- Line: 170
    -- upvalues: DataService (copy), Config (ref)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HalloweenHungryData;
    end;

    local v32 = {};
    local v33 = Config and Config.SETS;

    if v33 == nil then
        v33 = v32;
    end;

    local v34 = #v33;
    local v35 = Data and (tonumber(Data.CurrentLevel) or 1) or 1;
    local v36 = (v35 < 1 or math.max(v34, 1) < v35) and 1 or v35;
    local v37 = v33[v36] or {};
    local v38 = Data and typeof(Data.Submitted) == "table" and (Data.Submitted or {}) or {};
    local v39 = 0;
    local v40 = {};
    local v41 = {};

    for i, v in v37 do
        if v38[`Slot{i}`] or (v38[tostring(i)] or v38[i]) then
            v39 = v39 + 1;
        else
            table.insert(v40, v);
            table.insert(v41, {
                Slot = i,
                Req = v
            });
        end;
    end;

    return {
        Level = v36,
        NumSets = v34,
        Set = v37,
        Fed = v39,
        Needed = #v37,
        Remaining = v40,
        RemainingSlots = v41,
        Submitted = v38
    };
end;

local function getRemotes() -- Line: 206
    -- upvalues: ReplicatedStorage (copy)
    local GameEvents = ReplicatedStorage:FindFirstChild("GameEvents");

    if GameEvents then
        GameEvents = GameEvents:WaitForChild("HalloweenHungry", 10);
    end;

    if not GameEvents then
        return nil;
    end;

    local Submit = GameEvents:WaitForChild("Submit", 10);
    local SubmitResult = GameEvents:WaitForChild("SubmitResult", 10);

    return Submit and SubmitResult and {
        Submit = Submit,
        SubmitResult = SubmitResult
    } or nil;
end;

local u42 = 0;

function u2.Submit(p43: table, p44: number?, p45: table?) -- Line: 223
    -- upvalues: getRemotes (copy), u42 (ref)
    local v46 = getRemotes();

    if not v46 then
        return nil;
    end;

    u42 = u42 + 1;
    local u47 = u42;
    local table_clone_ret = table.clone(p45 or {});
    table_clone_ret.Token = u47;
    local u48 = nil;
    local u49 = nil;
    u49 = v46.SubmitResult.OnClientEvent:Connect(function(p50) -- Line: 236
        -- upvalues: u47 (copy), u48 (ref), u49 (ref)
        if typeof(p50) == "table" and p50.Token == u47 then
            u48 = p50;
            u49:Disconnect();
        end;
    end);
    v46.Submit:FireServer(table_clone_ret);
    local v51 = os.clock() + (p44 or 5);

    while u48 == nil and os.clock() < v51 do
        task.wait();
    end;

    u49:Disconnect();

    return u48;
end;

function u2.OpenRewards(p52) -- Line: 253
    -- upvalues: SeedPackRewardTrackUIController (copy)
    SeedPackRewardTrackUIController:OpenBasicPackUI("HalloweenHungry");
end;

local function getEventModel() -- Line: 260
    -- upvalues: CollectionService (copy), Config (ref)
    local v53 = Config and Config.MODEL_TAG;

    for _, v in CollectionService:GetTagged(v53 == nil and "HalloweenHungryModel" or v53) do
        if v:IsDescendantOf(workspace) then
            return v;
        end;
    end;

    return nil;
end;

local function updateTimer(p54: userdata, p55: number) -- Line: 270
end;

local u56 = {};
local u57 = {};

local function getPlantImage(p58: string) -- Line: 314
    -- upvalues: u56 (copy), ItemImageFinder (copy)
    local v59 = u56[p58];

    if v59 then
        return v59;
    end;

    local success2, result2 = pcall(ItemImageFinder, p58, "Fruit");
    local v60 = (not success2 or typeof(result2) ~= "string") and "" or result2;
    u56[p58] = v60;

    return v60;
end;

local function getMutationColor(p61: string) -- Line: 323
    -- upvalues: MutationHandler (copy)
    local success2, success2 = pcall(function() -- Line: 324
        -- upvalues: MutationHandler (ref)
        return MutationHandler:GetMutations();
    end);

    if success2 then
        if success2 then
            success2 = success2[p61];
        end;
    end;

    if success2 then
        success2 = success2.Color;
    end;

    if typeof(success2) == "Color3" then
        return success2;
    end;

    return nil;
end;

local function applyMutationColor(p62: userdata, p63: any) -- Line: 332
    -- upvalues: MutationHandler (copy)
    if not (p63 and p63.MUTATION) then
        return;
    end;

    local Mutation = (p62:FindFirstChild("Inner") or p62):FindFirstChild("Mutation");

    if not (Mutation and Mutation:IsA("TextLabel")) then
        return;
    end;

    local MUTATION = p63.MUTATION;
    local success2, success2 = pcall(function() -- Line: 324
        -- upvalues: MutationHandler (ref)
        return MutationHandler:GetMutations();
    end);

    if success2 then
        if success2 then
            success2 = success2[MUTATION];
        end;
    end;

    if success2 then
        success2 = success2.Color;
    end;

    if typeof(success2) ~= "Color3" then
        success2 = nil;
    end;

    if success2 and Mutation.TextColor3 ~= success2 then
        Mutation.TextColor3 = success2;
    end;
end;

local function setCard(p64: userdata, p65: any) -- Line: 343
    -- upvalues: applyMutationColor (copy), u57 (copy), u56 (copy), ItemImageFinder (copy), MutationHandler (copy)
    if not p64:IsA("GuiObject") then
        return;
    end;

    local v66 = not p65 and "hidden" or `{p65.PLANT_NAME}|{p65.WEIGHT}|{p65.MUTATION or ""}|{p65.VARIANT or ""}`;
    applyMutationColor(p64, p65);

    if u57[p64] == v66 then
        return;
    end;

    u57[p64] = v66;

    if not p65 then
        p64.Visible = false;

        return;
    end;

    local v67 = p64:FindFirstChild("Inner") or p64;
    local Vector = v67:FindFirstChild("Vector");
    local RewardNameText = v67:FindFirstChild("RewardNameText");
    local QuantityText = v67:FindFirstChild("QuantityText");
    local Mutation = v67:FindFirstChild("Mutation");

    if Vector and Vector:IsA("ImageLabel") then
        local PLANT_NAME = p65.PLANT_NAME;
        local v68 = u56[PLANT_NAME];

        if not v68 then
            local success2, result2 = pcall(ItemImageFinder, PLANT_NAME, "Fruit");
            v68 = (not success2 or typeof(result2) ~= "string") and "" or result2;
            u56[PLANT_NAME] = v68;
        end;

        Vector.Image = v68;
    end;

    if RewardNameText and RewardNameText:IsA("TextLabel") then
        local v69;

        if p65.VARIANT then
            v69 = `{p65.VARIANT} {p65.PLANT_NAME}`;
        else
            v69 = p65.PLANT_NAME;
        end;

        RewardNameText.Text = v69;
    end;

    if QuantityText and QuantityText:IsA("TextLabel") then
        QuantityText.Text = `[{p65.WEIGHT}kg+]`;
    end;

    if Mutation and Mutation:IsA("TextLabel") then
        if p65.MUTATION then
            Mutation.Text = p65.MUTATION;
            local MUTATION = p65.MUTATION;
            local success2, success2 = pcall(function() -- Line: 324
                -- upvalues: MutationHandler (ref)
                return MutationHandler:GetMutations();
            end);

            if success2 then
                if success2 then
                    success2 = success2[MUTATION];
                end;
            end;

            if success2 then
                success2 = success2.Color;
            end;

            if typeof(success2) ~= "Color3" then
                success2 = nil;
            end;

            if success2 then
                Mutation.TextColor3 = success2;
            end;

            Mutation.Visible = true;
        else
            Mutation.Visible = false;
        end;
    end;

    p64.Visible = true;
end;

local function updateRequirementCards(p70: userdata, p71: any) -- Line: 385
    -- upvalues: u2 (copy), setCard (copy)
    local Frame = p70:FindFirstChild("Frame");

    if not Frame then
        return;
    end;

    local v72 = u2:GetState() == "Live";
    local v73 = p71.Submitted or {};

    for i = 1, 3 do
        local v74 = Frame:FindFirstChild((tostring(i)));
        local v75;

        if v74 then
            local v76 = p71.Set[i];

            if not (v72 and (v76 and not (v73[`Slot{i}`] or (v73[tostring(i)] or v73[i])))) then
                v76 = nil;
            end;

            setCard(v74, v76);
            v75 = i;
        else
            v75 = i;
        end;
    end;
end;

local function fillProgressTokens(p77: string, p78: any) -- Line: 401
    local string_gsub_ret = string.gsub(p77, "CURRENT", (tostring(p78.Level - 1)));
    local string_gsub_ret2 = string.gsub(string_gsub_ret, "MAX", (tostring(p78.NumSets)));
    local string_gsub_ret3 = string.gsub(string_gsub_ret2, "FED", (tostring(p78.Fed)));

    return string.gsub(string_gsub_ret3, "NEEDED", (tostring(p78.Needed)));
end;

local function updateProgress(p79: userdata) -- Line: 414
    -- upvalues: u2 (copy), TweenService (copy), Config (ref), fillProgressTokens (copy), updateRequirementCards (copy)
    local Progress = p79:FindFirstChild("Progress");
    local v80;

    if Progress then
        v80 = Progress:FindFirstChild("ProgressBilboard");
    else
        v80 = Progress;
    end;

    if not v80 then
        return;
    end;

    local ProgressBilboardTitle = Progress:FindFirstChild("ProgressBilboardTitle", true);

    if ProgressBilboardTitle and (ProgressBilboardTitle:IsA("BillboardGui") and not ProgressBilboardTitle.Enabled) then
        ProgressBilboardTitle.Enabled = true;
    end;

    local Progress2 = u2:GetProgress();
    local v81 = Progress2.NumSets <= 0 and 0 or math.clamp((Progress2.Level - 1) / Progress2.NumSets, 0, 1);
    v80.Enabled = true;
    local UpgradeBar = v80:FindFirstChild("UpgradeBar");
    local v82;

    if UpgradeBar then
        v82 = UpgradeBar:FindFirstChild("Fill");
    else
        v82 = UpgradeBar;
    end;

    if UpgradeBar then
        UpgradeBar = UpgradeBar:FindFirstChild("ProgressionLabel");
    end;

    local v83 = ProgressBilboardTitle and ProgressBilboardTitle:FindFirstChild("Title") or v80:FindFirstChild("Title");

    if v82 then
        local UDim2_fromScale_ret = UDim2.fromScale(v81, 1);

        if v82.Size ~= UDim2_fromScale_ret then
            if v82.Size.X.Scale < v81 then
                TweenService:Create(v82, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2_fromScale_ret
                }):Play();
            else
                v82.Size = UDim2_fromScale_ret;
            end;
        end;

        local v84 = Config and Config.PROGRESS_BAR_COLOR;

        if v84 == nil then
            v84 = nil;
        end;

        local Color3_fromRGB_ret = Color3.fromRGB(255, 140, 0);

        if typeof(v84) == "table" and v84[1] then
            Color3_fromRGB_ret = Color3.fromRGB(v84[1], v84[2], v84[3]);
        end;

        v82.BackgroundColor3 = Color3_fromRGB_ret;
    end;

    if UpgradeBar then
        local v85 = Config and Config.PROGRESS_TEXT;
        UpgradeBar.Text = fillProgressTokens(v85 == nil and "CURRENT/MAX" or v85, Progress2);
    end;

    if v83 then
        local v86 = Config and Config.PROGRESS_TITLE;
        v83.Text = fillProgressTokens(v86 == nil and "FED/NEEDED Plants Fed" or v86, Progress2);
    end;

    updateRequirementCards(v80, Progress2);
end;

local u87 = {};

local function pickSoundVariant(p88: string) -- Line: 461
    -- upvalues: u87 (copy)
    local v89 = {};
    local v90 = script:FindFirstChild(p88);
    local v91;

    if v90 and v90:IsA("Sound") then
        table.insert(v89, v90);
        v91 = 2;
    else
        v91 = 2;
    end;

    while true do
        local v92 = script:FindFirstChild((`{p88}{v91}`));

        if not (v92 and v92:IsA("Sound")) then
            break;
        end;

        table.insert(v89, v92);
        v91 = v91 + 1;
    end;

    if #v89 == 0 then
        return nil;
    end;

    if #v89 == 1 then
        return v89[1];
    end;

    local v93 = u87[p88];
    local v94 = v89[math.random(#v89)];

    if v94 == v93 then
        v94 = v89[table.find(v89, v94) % #v89 + 1];
    end;

    u87[p88] = v94;

    return v94;
end;

local function isMuted(p95: string) -- Line: 492
    -- upvalues: Config (ref)
    local v96 = Config and Config.MUTED_SFX;

    if v96 == nil then
        v96 = nil;
    end;

    local v97;

    if typeof(v96) == "table" then
        v97 = table.find(v96, p95) ~= nil;
    else
        v97 = false;
    end;

    return v97;
end;

local function playSound(p98: string, p99: userdata?, p100: number?) -- Line: 497
    -- upvalues: Config (ref), pickSoundVariant (copy), SoundService (copy), Debris (copy)
    local v101 = Config and Config.MUTED_SFX;

    if v101 == nil then
        v101 = nil;
    end;

    local v102;

    if typeof(v101) == "table" then
        v102 = table.find(v101, p98) ~= nil;
    else
        v102 = false;
    end;

    if v102 then
        return;
    end;

    local v103 = pickSoundVariant(p98);

    if not v103 then
        return;
    end;

    local u104 = v103:Clone();

    if p100 and p100 > 0 then
        u104.PlaybackSpeed = u104.PlaybackSpeed * (1 + (math.random() * 2 - 1) * p100);
    end;

    u104.Parent = p99 or SoundService;
    u104:Play();
    u104.Ended:Once(function() -- Line: 507
        -- upvalues: u104 (copy)
        u104:Destroy();
    end);
    Debris:AddItem(u104, 15);
end;

local function findNpc(p105: userdata?) -- Line: 512
    if p105 then
        return p105:FindFirstChild("NPC") or p105:FindFirstChild("NPC", true);
    end;

    return nil;
end;

local function getNpcHead() -- Line: 517
    -- upvalues: getEventModel (copy)
    local v106 = getEventModel();
    local v107;

    if v106 then
        v107 = v106:FindFirstChild("NPC") or v106:FindFirstChild("NPC", true);
    else
        v107 = nil;
    end;

    local v108;

    if v107 then
        v108 = v107:FindFirstChild("Head") or v107:IsA("Model") and v107.PrimaryPart;
    else
        v108 = v107;
    end;

    if v108 and v108:IsA("BasePart") then
        return v108;
    end;

    return nil;
end;

function u2.PlaySound(p109: table, p110: string, p111: boolean?) -- Line: 525
    -- upvalues: playSound (copy), getNpcHead (copy)
    local v112;

    if p111 then
        v112 = getNpcHead();
    else
        v112 = nil;
    end;

    playSound(p110, v112, 0.05);
end;

local function refreshProgress() -- Line: 529
    -- upvalues: getEventModel (copy), updateProgress (copy)
    local v113 = getEventModel();

    if v113 then
        pcall(updateProgress, v113);
    end;
end;

local u114 = {
    Idle = {
        Looped = true,
        Priority = Enum.AnimationPriority.Idle
    },
    Eating = {
        Looped = false,
        Priority = Enum.AnimationPriority.Action
    },
    Success = {
        Looped = false,
        Priority = Enum.AnimationPriority.Action2
    }
};
local u115 = nil;
local u116 = {};

local function stopAllTracks(u117: number?) -- Line: 548
    -- upvalues: u116 (copy)
    for _, v in u116 do
        pcall(function() -- Line: 550
            -- upvalues: v (copy), u117 (copy)
            v:Stop(u117 or 0);
        end);
    end;
end;

local function getNpc() -- Line: 554
    -- upvalues: getEventModel (copy)
    local v118 = getEventModel();
    local v119;

    if v118 then
        v119 = v118:FindFirstChild("NPC") or v118:FindFirstChild("NPC", true);
    else
        v119 = nil;
    end;

    if v119 and v119:IsA("Model") then
        return v119;
    end;

    return nil;
end;

local function getTracks() -- Line: 560
    -- upvalues: getEventModel (copy), u115 (ref), stopAllTracks (copy), u116 (copy), u114 (copy), playSound (copy), getNpcHead (copy)
    local v120 = getEventModel();
    local u121;

    if v120 then
        u121 = v120:FindFirstChild("NPC") or v120:FindFirstChild("NPC", true);
    else
        u121 = nil;
    end;

    if not (u121 and u121:IsA("Model")) then
        u121 = nil;
    end;

    if u121 then
        u121 = u121:FindFirstChildWhichIsA("AnimationController");
    end;

    if u121 then
        u121 = u121:FindFirstChildWhichIsA("Animator");
    end;

    if not u121 then
        return nil;
    end;

    if u121 ~= u115 then
        stopAllTracks();
        table.clear(u116);
        u115 = u121;

        for i, v in u114 do
            local u122 = script:FindFirstChild(i);

            if u122 and u122:IsA("Animation") then
                local success2, result2 = pcall(function() -- Line: 576
                    -- upvalues: u121 (copy), u122 (copy)
                    return u121:LoadAnimation(u122);
                end);

                if success2 and result2 then
                    result2.Priority = v.Priority;
                    result2.Looped = v.Looped;
                    u116[i] = result2;

                    if i == "Eating" then
                        result2:GetMarkerReachedSignal("Chomp"):Connect(function() -- Line: 585
                            -- upvalues: playSound (ref), getNpcHead (ref)
                            playSound("Chomp", getNpcHead(), 0.1);
                        end);
                    end;
                end;
            else
                warn((`HalloweenHungryController | Missing '{i}' Animation under the controller`));
            end;
        end;
    end;

    return u116;
end;

local function ensureIdle() -- Line: 596
    -- upvalues: getTracks (copy)
    local v123 = getTracks();

    if v123 then
        v123 = v123.Idle;
    end;

    if v123 and not v123.IsPlaying then
        v123:Play(0.3);
    end;
end;

function u2.PlayAnimation(p124: table, p125: string, p126: boolean?) -- Line: 606
    -- upvalues: getTracks (copy)
    local v127 = getTracks();
    local v128;

    if v127 then
        v128 = v127[p125];
    else
        v128 = v127;
    end;

    if not v128 then
        return 0;
    end;

    for i, v in v127 do
        if i ~= "Idle" and (v ~= v128 and v.IsPlaying) then
            v:Stop(0.15);
        end;
    end;

    local v129 = getTracks();

    if v129 then
        v129 = v129.Idle;
    end;

    if v129 and not v129.IsPlaying then
        v129:Play(0.3);
    end;

    v128:Play(0.15);
    local v130 = os.clock() + 1;

    while v128.Length <= 0 and os.clock() < v130 do
        task.wait();
    end;

    local Length = v128.Length;

    if p126 then
        local u131 = false;
        local v132 = v128.Stopped:Once(function() -- Line: 628
            -- upvalues: u131 (ref)
            u131 = true;
        end);
        local v133 = os.clock() + math.max(Length, 0.1) + 0.5;

        while not u131 and os.clock() < v133 do
            task.wait();
        end;

        v132:Disconnect();
    end;

    return Length;
end;

local function fireDropCategory(p134: string?) -- Line: 639
    return p134 == "Currency" and "Coins" or (p134 == "Seed" and "Seeds" or (p134 == "Seed Pack" and "SeedPack" or "Items"));
end;

local function fireRewardDrop(u135) -- Line: 647
    -- upvalues: ReplicatedStorage (copy), getEventModel (copy), LocalPlayer (copy), playSound (copy)
    local u136 = ReplicatedStorage:FindFirstChild("GameEvents") and ReplicatedStorage.GameEvents:FindFirstChild("FireDropBindable");

    if not (u136 and u135) then
        return;
    end;

    local v137 = getEventModel();
    local v138;

    if v137 then
        v138 = v137:FindFirstChild("NPC") or v137:FindFirstChild("NPC", true);
    else
        v138 = nil;
    end;

    if not (v138 and v138:IsA("Model")) then
        v138 = nil;
    end;

    if v138 then
        v138 = v138:FindFirstChild("Head") or v138.PrimaryPart;
    end;

    local u139;

    if v138 and v138:IsA("BasePart") then
        u139 = v138.CFrame;
    elseif LocalPlayer.Character then
        u139 = LocalPlayer.Character:GetPivot();
    else
        u139 = nil;
    end;

    if not u139 then
        return;
    end;

    playSound("RewardWhoosh", nil, 0.05);
    pcall(function() -- Line: 660
        -- upvalues: u136 (copy), LocalPlayer (ref), u135 (copy), u139 (copy)
        local v140 = {
            Owner = LocalPlayer.Name
        };
        local Type = u135.Type;
        v140.RewardType = Type == "Currency" and "Coins" or (Type == "Seed" and "Seeds" or (Type == "Seed Pack" and "SeedPack" or "Items"));
        v140.GearName = u135.Value;
        v140.KeySeed = u135.Value;
        u136:Fire(v140, u139);
    end);
end;

local u141 = 0;
local u142 = 0;

local function playReaction(p143) -- Line: 674
    -- upvalues: u141 (ref), playSound (copy), getNpcHead (copy), u2 (copy), u142 (ref), u3 (ref), Config (ref), fireRewardDrop (copy)
    u141 = u141 + 1;
    local v144 = u141;

    if not p143.Skipped and (tonumber(p143.Count) or 1) > 0 then
        playSound("Chomp", getNpcHead(), 0.1);
        u2:PlayAnimation("Eating", true);
        playSound("Gulp", getNpcHead(), 0.05);
    end;

    u142 = v144;

    if v144 ~= u141 or not u3 then
        return;
    end;

    if p143.Reason == "Fed" then
        playSound("PlantAccepted", nil, 0);

        return;
    end;

    if p143.Reason == "SetComplete" or p143.Reason == "CycleComplete" then
        playSound(p143.Reason == "CycleComplete" and "CycleComplete" or "SetComplete", nil, 0);
        u2:PlayAnimation("Success", false);
        local v145 = Config and Config.SUCCESS_DROP_DELAY;
        task.wait(tonumber(v145 == nil and 0.4 or v145) or 0.4);

        if v144 ~= u141 or not u3 then
            return;
        end;

        fireRewardDrop(p143.Reward);
    end;
end;

function u2.GetReactionId(p146) -- Line: 699
    -- upvalues: u141 (ref)
    return u141;
end;

function u2.WaitForEating(p147: table, p148: number, p149: number?) -- Line: 705
    -- upvalues: u141 (ref), u142 (ref)
    local v150 = os.clock() + (p149 or 6);

    while os.clock() < v150 do
        if p148 < u141 and u142 == u141 then
            return;
        end;

        task.wait();
    end;
end;

local u151 = { "ViewOddsBasic", "ViewOddsPremium" };
local u152 = {};

local function cancelBob(p153: table) -- Line: 734
    for _, v in p153 do
        v.Tween:Cancel();

        if v.Part.Parent then
            v.Part.CFrame = v.Base;
            v.Part.Anchored = v.WasAnchored;
        end;
    end;
end;

local function stopBobs() -- Line: 744
    -- upvalues: u152 (copy), cancelBob (copy)
    for _, v in u152 do
        cancelBob(v);
    end;

    table.clear(u152);
end;

local function updateBobs(p154: userdata) -- Line: 751
    -- upvalues: Config (ref), u152 (copy), cancelBob (copy), u151 (copy), TweenService (copy)
    local v155 = Config and Config.BOB_HEIGHT;
    local v156 = tonumber(v155 == nil and 0.5 or v155) or 0.5;
    local v157 = Config and Config.BOB_TIME;
    local v158 = tonumber(v157 == nil and 2 or v157) or 2;
    local math_max_ret = math.max(v158, 0.1);

    for i, v in u152 do
        if not i:IsDescendantOf(p154) then
            cancelBob(v);
            u152[i] = nil;
        end;
    end;

    local TweenInfo_new_ret = TweenInfo.new(math_max_ret, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    local Vector3_new_ret = Vector3.new(0, v156, 0);

    for i, v in u151 do
        local v159 = p154:FindFirstChild(v, true);

        if v159 and (v159:IsA("BasePart") and not u152[v159]) then
            local Parent = v159.Parent;
            local v160 = {};
            local v161;

            if Parent and Parent:IsA("Model") then
                v161 = i;

                for _, descendant in Parent:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        table.insert(v160, descendant);
                    end;
                end;
            else
                v161 = i;
                v160 = { v159 };
            end;

            local v162 = v161 % 2 == 0;
            local v163 = {};

            for _, v2 in v160 do
                local CFrame = v2.CFrame;
                local Anchored = v2.Anchored;
                v2.Anchored = true;
                local v164;

                if v162 then
                    v164 = CFrame + Vector3_new_ret;
                else
                    v164 = CFrame - Vector3_new_ret;
                end;

                v2.CFrame = v164;
                local v165 = {};
                local v166;

                if v162 then
                    v166 = CFrame - Vector3_new_ret;
                else
                    v166 = CFrame + Vector3_new_ret;
                end;

                v165.CFrame = v166;
                local v167 = {
                    Part = v2,
                    Base = CFrame,
                    WasAnchored = Anchored,
                    Tween = TweenService:Create(v2, TweenInfo_new_ret, v165)
                };
                table.insert(v163, v167);
            end;

            for _, v2 in v163 do
                v2.Tween:Play();
            end;

            u152[v159] = v163;
        end;
    end;
end;

local u168 = {};

local function skipProductId() -- Line: 807
    -- upvalues: ReplicatedStorage (copy)
    local success2, success2 = pcall(require, ReplicatedStorage.Data.DevProductIds);

    if success2 then
        if success2 then
            success2 = success2.SkipHalloweenHungry;
        end;
    end;

    return success2 and tonumber(success2.PurchaseID) or 0;
end;

local function notifyLocal(u169: string) -- Line: 813
    -- upvalues: ReplicatedStorage (copy)
    pcall(function() -- Line: 814
        -- upvalues: ReplicatedStorage (ref), u169 (copy)
        require(ReplicatedStorage.Modules.Notification):CreateNotification(u169);
    end);
end;

local function hookSkipSign(p170: userdata) -- Line: 817
    -- upvalues: u168 (copy), ReplicatedStorage (copy), u1 (copy), u2 (copy), LocalPlayer (copy)
    local SkipSign = p170:FindFirstChild("SkipSign", true);
    local v171;

    if SkipSign then
        v171 = SkipSign:FindFirstChildWhichIsA("ProximityPrompt", true);
    else
        v171 = SkipSign;
    end;

    if not (v171 and (v171:IsA("ProximityPrompt") and not u168[v171])) then
        return;
    end;

    u168[v171] = true;
    local success2, success2 = pcall(require, ReplicatedStorage.Data.DevProductIds);

    if success2 then
        if success2 then
            success2 = success2.SkipHalloweenHungry;
        end;
    end;

    local u172 = success2 and tonumber(success2.PurchaseID) or 0;
    local MarketController = require(ReplicatedStorage.Modules.MarketController);
    local u173 = SkipSign:FindFirstChildWhichIsA("TextLabel", true);

    if u173 and (u172 ~= 0 and u173:GetAttribute("ProductId") == nil) then
        local Text = u173.Text;
        local u174;

        if string.find(Text, "???", 1, true) then
            u174 = string.gsub(Text, "%?%?%?", ":robux::value:");
        else
            u174 = Text .. " :robux::value:";
        end;

        pcall(function() -- Line: 836
            -- upvalues: MarketController (copy), u173 (copy), u172 (copy), u174 (copy)
            MarketController:SetPriceLabel(u173, u172, u174);
        end);
    end;

    u1:Add(v171.Triggered:Connect(function() -- Line: 839
        -- upvalues: u2 (ref), ReplicatedStorage (ref), MarketController (copy), LocalPlayer (ref)
        local State = u2:GetState();

        if State ~= "Live" then
            local u175 = State == "Ended" and "The event is over!" or "The event hasn\'t started yet!";
            pcall(function() -- Line: 814
                -- upvalues: ReplicatedStorage (ref), u175 (copy)
                require(ReplicatedStorage.Modules.Notification):CreateNotification(u175);
            end);

            return;
        end;

        local success3, success3 = pcall(require, ReplicatedStorage.Data.DevProductIds);

        if success3 then
            if success3 then
                success3 = success3.SkipHalloweenHungry;
            end;
        end;

        local u176 = success3 and tonumber(success3.PurchaseID) or 0;

        if u176 ~= 0 then
            local success4, result2 = pcall(function() -- Line: 851
                -- upvalues: MarketController (ref), u176 (copy)
                MarketController:PromptPurchase(u176, Enum.InfoType.Product);
            end);

            if not success4 then
                warn("HalloweenHungryController | MarketController prompt failed, using MarketplaceService:", result2);
                game:GetService("MarketplaceService"):PromptProductPurchase(LocalPlayer, u176);
            end;

            return;
        end;

        warn("HalloweenHungryController | DevProductIds.SkipHalloweenHungry.PurchaseID is not set");
        local u177 = "Skipping isn\'t available yet.";
        pcall(function() -- Line: 814
            -- upvalues: ReplicatedStorage (ref), u177 (copy)
            require(ReplicatedStorage.Modules.Notification):CreateNotification(u177);
        end);
    end));
end;

function u2.Start(p178) -- Line: 862
    -- upvalues: u3 (ref), u1 (copy), SeedPackRewardTrackUIController (copy), getRemotes (copy), playSound (copy), getNpcHead (copy), playReaction (copy), DataService (copy), refreshProgress (copy), getEventModel (copy), updateTimer (copy), updateProgress (copy), ensureIdle (copy), updateBobs (copy), hookSkipSign (copy), LocalPlayer (copy)
    u3 = true;
    u1:Add(task.spawn(function() -- Line: 866
        -- upvalues: SeedPackRewardTrackUIController (ref)
        local success2, result2 = pcall(function() -- Line: 867
            -- upvalues: SeedPackRewardTrackUIController (ref)
            SeedPackRewardTrackUIController:SetUpSeedPackRewardTrack("HalloweenHungry", "HalloweenHungryConfig");
        end);

        if not success2 then
            warn("HalloweenHungryController | Reward track setup failed (check REWARDS packs exist in SeedPackData):", result2);
        end;
    end));
    u1:Add(task.spawn(function() -- Line: 876
        -- upvalues: getRemotes (ref), u3 (ref), u1 (ref), playSound (ref), getNpcHead (ref), playReaction (ref)
        local v179 = getRemotes();

        if not (v179 and u3) then
            return;
        end;

        u1:Add(v179.SubmitResult.OnClientEvent:Connect(function(p180) -- Line: 879
            -- upvalues: playSound (ref), getNpcHead (ref), playReaction (ref)
            if typeof(p180) ~= "table" then
                return;
            end;

            if p180.Success then
                task.spawn(playReaction, p180);

                return;
            end;

            if p180.Reason == "Rejected" or p180.Reason == "Missing" then
                playSound("Reject", getNpcHead(), 0.05);
            end;
        end));
    end));
    u1:Add(DataService:GetPathSignal("HalloweenHungryData/CurrentLevel"):Connect(refreshProgress));
    u1:Add(DataService:GetPathSignal("HalloweenHungryData/Submitted/@"):Connect(refreshProgress));
    u1:Add(task.spawn(function() -- Line: 897
        -- upvalues: u3 (ref), getEventModel (ref), updateTimer (ref), updateProgress (ref), ensureIdle (ref), updateBobs (ref), hookSkipSign (ref), getNpcHead (ref), LocalPlayer (ref), playSound (ref)
        local v181 = os.clock() + math.random(10, 25);

        while u3 do
            local v182 = getEventModel();

            if v182 then
                pcall(updateTimer, v182, workspace:GetServerTimeNow());
                pcall(updateProgress, v182);
                pcall(ensureIdle);
                pcall(updateBobs, v182);
                pcall(hookSkipSign, v182);

                if v181 <= os.clock() then
                    v181 = os.clock() + math.random(15, 30);
                    local v183 = getNpcHead();
                    local Character = LocalPlayer.Character;

                    if v183 and (Character and (Character:GetPivot().Position - v183.Position).Magnitude <= 45) then
                        playSound("IdleRumble", v183, 0.1);
                    end;
                end;
            end;

            task.wait(1);
        end;
    end));
end;

EventRotationClientBinder:Bind({
    EventSet = "Halloween2026Event",
    Script = script,

    OnStart = function() -- Line: 925, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start, u2);
    end,

    OnStop = function() -- Line: 926, Name: OnStop
        -- upvalues: u3 (ref), u1 (copy), u141 (ref), u142 (ref), stopAllTracks (copy), u116 (copy), u115 (ref), u152 (copy), cancelBob (copy), u168 (copy), SeedPackRewardTrackUIController (copy), LocalPlayer (copy), GuiController (copy)
        u3 = false;
        u1:Clean();
        u141 = u141 + 1;
        u142 = u141;
        stopAllTracks();
        table.clear(u116);
        u115 = nil;

        for _, v in u152 do
            cancelBob(v);
        end;

        table.clear(u152);
        table.clear(u168);

        if SeedPackRewardTrackUIController:CleanUp("HalloweenHungry") then
            pcall(function() -- Line: 941
                -- upvalues: LocalPlayer (ref), GuiController (ref)
                local SeedPackRewardTrack_UI = LocalPlayer.PlayerGui:FindFirstChild("SeedPackRewardTrack_UI");

                if SeedPackRewardTrack_UI then
                    GuiController:Close(SeedPackRewardTrack_UI);
                end;
            end);
        end;
    end
});

return u2;