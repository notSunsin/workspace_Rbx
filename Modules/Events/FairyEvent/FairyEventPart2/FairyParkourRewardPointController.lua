-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.Observers);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local LocalPlayer = Players.LocalPlayer;

local function EnableRewardPoint(p2: userdata) -- Line: 23
    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("ProximityPrompt") then
            descendant.Enabled = true;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;
end;

local function DisableRewardPoint(p3: userdata) -- Line: 33
    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("ProximityPrompt") then
            descendant.Enabled = false;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;
end;

ReplicatedStorage.GameEvents.Events.FairyEvent.ClaimParkourReward.OnClientEvent:Connect(function() -- Line: 43
    -- upvalues: SoundService (copy)
    SoundService.PopSoundHigher:Play();
end);

local function ReconcileVisiblePoints() -- Line: 47
    -- upvalues: DataService (copy), CollectionService (copy), LocalPlayer (copy), EnableRewardPoint (copy), DisableRewardPoint (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local FairyWorldParkour = Data.FairyEvent.FairyWorldParkour;

    for _, v in CollectionService:GetTagged("RewardPoint") do
        local Attribute = v:GetAttribute((`Collected_{LocalPlayer.UserId}`));

        if not Attribute then
            if FairyWorldParkour then
                Attribute = FairyWorldParkour.CollectedOrbs[v.Name];
            else
                Attribute = FairyWorldParkour;
            end;
        end;

        if Attribute or v:GetAttribute("Enabled") == true then
            if Attribute and v:GetAttribute("Enabled") ~= false then
                v:SetAttribute("Enabled", false);
                DisableRewardPoint(v);
            end;
        else
            v:SetAttribute("Enabled", true);
            EnableRewardPoint(v);
        end;
    end;
end;

local function Start() -- Line: 64
    -- upvalues: DataService (copy), ReconcileVisiblePoints (copy), CollectionService (copy)
    DataService:GetPathSignal("FairyEvent/@"):Connect(ReconcileVisiblePoints);
    DataService:GetPathSignal("FairyEvent/FairyWorldParkour/@"):Connect(ReconcileVisiblePoints);
    CollectionService:GetInstanceAddedSignal("RewardPoint"):Connect(ReconcileVisiblePoints);
    CollectionService:GetInstanceRemovedSignal("RewardPoint"):Connect(ReconcileVisiblePoints);
    task.spawn(ReconcileVisiblePoints);
end;

EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 76, Name: OnStart
        -- upvalues: Start (copy)
        task.spawn(Start);
    end,

    OnStop = function() -- Line: 77, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return {};