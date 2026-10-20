-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
require(ReplicatedStorage.Modules.UpdateService);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.CountDictionary);
require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Comma_Module);
local Spr = require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Code.Bezier_2);
require(ReplicatedStorage.Data.DefaultData);
require(ReplicatedStorage.Modules.Trove).new();
local Config = GameConfigController:GetConfig("ZenEventConfig");
local ZenProgressData = Config.ZenProgressData;
local CorruptZenQuestData = Config.CorruptZenQuestData;
local ZenTreeData = Config.ZenTreeData;
workspace:GetAttributeChangedSignal("ZenEventConfig"):Connect(function() -- Line: 28
    -- upvalues: Config (ref), GameConfigController (copy), ZenProgressData (ref), CorruptZenQuestData (ref), ZenTreeData (ref)
    Config = GameConfigController:GetConfig("ZenEventConfig");
    ZenProgressData = Config.ZenProgressData;
    CorruptZenQuestData = Config.CorruptZenQuestData;
    ZenTreeData = Config.ZenTreeData;
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Events.ZenEvent.ClaimZenReward;
local _ = GameEvents.Events.ZenEvent.FoxRewardEffect;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};
local u3 = nil;
local u4 = nil;
local u9 = {
    SetupZenTree = function(p5) -- Line: 55, Name: SetupZenTree
        -- upvalues: CollectionService (copy), u1 (copy)
        for _, descendant in CollectionService:GetTagged("ZenEventModel")[1]:FindFirstChild("ZenTree"):GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "Tree";
                local v6 = tonumber(descendant.Name);

                if v6 then
                    if not u1[v6] then
                        u1[v6] = {};
                    end;

                    table.insert(u1[v6], descendant);
                    descendant:SetAttribute("OriginalCF", descendant:GetPivot());
                    descendant:SetAttribute("OriginalSize", descendant.Size);
                    descendant:SetAttribute("PivotOffset", descendant.PivotOffset);
                end;
            end;
        end;
    end,

    SetupCorruptTree = function(p7) -- Line: 78, Name: SetupCorruptTree
        -- upvalues: EventRotationUtils (copy), u2 (copy)
        for _, descendant in EventRotationUtils:GetEventIDModels("ZenEventPart2")[1]:FindFirstChild("CorruptZenTree"):GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "Tree";
                local v8 = tonumber(descendant.Name);

                if v8 then
                    if not u2[v8] then
                        u2[v8] = {};
                    end;

                    table.insert(u2[v8], descendant);
                    descendant:SetAttribute("OriginalCF", descendant:GetPivot());
                    descendant:SetAttribute("OriginalSize", descendant.Size);
                    descendant:SetAttribute("PivotOffset", descendant.PivotOffset);
                end;
            end;
        end;
    end
};

local function StartMonkPray(p10: boolean) -- Line: 101
    -- upvalues: CollectionService (copy), u4 (ref), Spr (copy), u3 (ref)
    local v11 = CollectionService:GetTagged("ZenChanneller")[1];
    local ZenQuestProximityPrompt = v11:FindFirstChild("ZenQuestProximityPrompt", true);
    local v12 = CollectionService:GetTagged("ZenTree")[1];

    if p10 then
        v11 = CollectionService:GetTagged("CorruptChanneller")[1];
        ZenQuestProximityPrompt = v11:FindFirstChild("CorruptZenQuestProximityPrompt", true);
        v12 = CollectionService:GetTagged("CorruptZenTree")[1];
    end;

    local GrowEffects = v12:FindFirstChild("GrowEffects");
    u4 = v11:GetPivot();
    ZenQuestProximityPrompt.Enabled = false;
    Spr.target(v11, 0.7, 0.5, {
        Pivot = u4 * CFrame.new(0, 2, 0) * CFrame.Angles(0, 3.141592653589793, 0)
    });

    if not u3 then
        u3 = v11:FindFirstChild("Humanoid"):FindFirstChild("Animator"):LoadAnimation((v11:FindFirstChild("PrayAnimation")));
    end;

    for _, child in GrowEffects:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child.Enabled = true;
        end;

        if child:IsA("Sound") then
            child:Play();
        end;
    end;

    task.delay(0.2, function() -- Line: 139
        -- upvalues: u3 (ref)
        u3:Play();
    end);
end;

local function StopMonkPray(p13: boolean) -- Line: 144
    -- upvalues: CollectionService (copy), Spr (copy), u4 (ref), u3 (ref)
    local v14 = CollectionService:GetTagged("ZenChanneller")[1];
    local ZenQuestProximityPrompt = v14:FindFirstChild("ZenQuestProximityPrompt", true);
    local v15 = CollectionService:GetTagged("ZenTree")[1];

    if p13 then
        v14 = CollectionService:GetTagged("CorruptChanneller")[1];
        ZenQuestProximityPrompt = v14:FindFirstChild("CorruptZenQuestProximityPrompt", true);
        v15 = CollectionService:GetTagged("CorruptZenTree")[1];
    end;

    local GrowEffects = v15:FindFirstChild("GrowEffects");
    ZenQuestProximityPrompt.Enabled = true;
    Spr.target(v14, 0.7, 0.5, {
        Pivot = u4
    });

    for _, child in GrowEffects:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child.Enabled = false;
        end;
    end;

    task.delay(0.5, function() -- Line: 167
        -- upvalues: u3 (ref)
        u3:Stop();
    end);
end;

function u9.GrowTree(p16: table, p17: table, p18: number, p19: number, p20: number, p21: boolean) -- Line: 172
    -- upvalues: CollectionService (copy), LocalPlayer (copy), DataService (copy), u1 (copy), u2 (copy), StartMonkPray (copy), StopMonkPray (copy)
    local ZenTree = CollectionService:GetTagged("ZenEventModel")[1]:FindFirstChild("ZenTree");
    local v22 = p18 / (p20 - p19);
    local v23 = p19 == 0 and 0 or p19;
    local v24 = p19;

    for i, v in p17 do
        if v23 < i then
            for _, v2 in v do
                v2.Transparency = 1;
                v2.CanCollide = false;
                v2.CanQuery = false;
                v2.CanTouch = false;
            end;
        end;
    end;

    if not LocalPlayer then
        return warn("No LocalPlayer!");
    end;

    local Data = DataService:GetData();

    if not Data then
        return warn((`No PlayerData for {LocalPlayer}!`));
    end;

    local ZenEventData = Data.ZenEventData;
    local ZenTree2 = Data.ZenEventData.ZenTree;

    if ZenTree2 and (ZenTree2.CurrentTreeLevel == 0 and p17 == u1) then
        return;
    end;

    if ZenEventData and (ZenEventData.CorruptionZenSpawn == 0 and p17 == u2) then
        return;
    end;

    task.wait(2);
    StartMonkPray(not p21);
    local v25 = workspace:GetServerTimeNow() + p18;
    local v26 = nil;

    while workspace:GetServerTimeNow() < v25 do
        local v27 = p19 - v24;
        local v28 = v24 + math.floor(v27 / v22) + 1;
        p19 = p19 + game:GetService("RunService").Heartbeat:Wait();
        local v29;

        if v26 == nil or v26 ~= v28 then
            if #p17 < v28 then
                break;
            end;

            v29 = v28;

            for _, v in p17[v28] do
                v.Transparency = 0;
                v.CanCollide = true;
                v.CanQuery = true;
                v.CanTouch = true;
            end;
        else
            v29 = v28;
            v28 = v26;
        end;

        if p20 < v29 then
            break;
        end;

        local v30 = v27 % v22 / v22;
        v26 = v28;

        for _, v in p17[v29] do
            local _ = v.CFrame.UpVector;
            v.PivotOffset = CFrame.new(v:GetAttribute("PivotOffset").Position * Vector3.new(1, v30, 1)) * v:GetAttribute("PivotOffset").Rotation;
            v.Size = Vector3.new(v.Size.X, 0, v.Size.Z):Lerp(v:GetAttribute("OriginalSize"), v30);
            local _ = CFrame.new(0, -(v:GetAttribute("OriginalSize").Y / 2), 0) * v:GetAttribute("OriginalCF");
            v:PivotTo((v:GetAttribute("OriginalCF")));
            v28 = v26;
            v26 = v28;
        end;
    end;

    if not p21 then
        StopMonkPray(true);

        return;
    end;

    script.Shimmer:Play();
    local v31 = script["Pop Sound!"]:Clone();
    v31.Parent = workspace;
    game.Debris:AddItem(v31, 5);
    v31.PitchShiftSoundEffect.Octave = 1.7;
    v31:Play();
    local BigPopEffect = workspace.Terrain:FindFirstChild("BigPopEffect");
    local Gradient = BigPopEffect:FindFirstChild("Gradient");
    local ParticleEmitter = BigPopEffect:FindFirstChild("ParticleEmitter");
    BigPopEffect.CFrame = ZenTree:GetPivot();
    Gradient:Emit(1);
    ParticleEmitter:Emit(Random.new():NextInteger(1, 3));
    StopMonkPray(false);
end;

function u9.Run(p32: table, p33: boolean) -- Line: 283
    -- upvalues: DataService (copy), LocalPlayer (copy), CollectionService (copy), u1 (copy), u2 (copy), u9 (copy)
    local Data = DataService:GetData();

    if not Data then
        return warn((`No PlayerData for {LocalPlayer}!`));
    end;

    local v34 = CollectionService:GetTagged("ZenEventModel")[1];
    local ZenTree = v34:FindFirstChild("ZenTree");
    local CurrentTreeLevel = Data.ZenEventData.ZenTree.CurrentTreeLevel;
    local v35 = u1;

    if p33 then
        v34 = CollectionService:GetTagged("CorruptZenModel")[1];
        ZenTree = CollectionService:GetTagged("CorruptZenTree")[1];
        CurrentTreeLevel = Data.ZenEventData.CorruptionZenSpawn;
        v35 = u2;
    end;

    ZenTree.Parent = v34;

    if CurrentTreeLevel <= 0 then
        u9:GrowTree(v35, 0.1, 0, 0, not p33);

        return;
    end;

    u9:GrowTree(v35, 8, math.max(CurrentTreeLevel - 1, 0) * 3, CurrentTreeLevel * 3, not p33);
end;

return u9;