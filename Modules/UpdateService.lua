-- Decompiled with Potassium's decompiler.

local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CentralTimeController);
local Signal = require(ReplicatedStorage.Modules.Signal);
local IsDev = require(ReplicatedStorage.Modules.IsDev);
local LocalPlayer = Players.LocalPlayer;
require(ReplicatedStorage.Data.TradeWorldData);
local u1 = {};

if IsDev() and RunService:IsServer() then
    if RunService:IsStudio() or game.PlaceId == 108890465381067 then
        ReplicatedFirst.GlobalUpdateTime.Value = workspace:GetServerTimeNow() + 60;
    else
        ReplicatedFirst.GlobalUpdateTime.Value = workspace:GetServerTimeNow() + 180;
    end;
end;

local u2 = Signal.new();
u1.OnUpdated = u2;
local u3 = { "Candy Corn Carrot", "Spider Shrub", "Pumpkin Lantern", "Candy Cluster", "Witch\'s Broom", "Webberry", "Blood Kiwi", "Fang Root", "Haunted Hallow", "Dracuvine", "Dracuvine Seed", "Haunted Egg", "Skull Snail", "Lantern Wisp", "Gargoyle", "Haunted Knight", "Ghostly Skull Snail", "Ghostly Lantern Wisp", "Ghostly Gargoyle", "Ghostly Haunted Knight", "Grave Crab", "Frankenstein\'s Bear", "Eyeball Monster", "HALLOWEEN_2026", "Haunted", "Premium Haunted Egg" };
local u4 = { "Scarlet Aspen Seed" };
local u5 = {};
local Children = workspace.Interaction.UpdateItems:GetChildren();
local u6 = false;

function u1.IsActive(p7: table, p8: string) -- Line: 112
    -- upvalues: u1 (copy)
    local v9 = not u1:IsHiddenFromUpdate(p8) and not u1:IsHiddenAfterUpdate(p8);

    return v9;
end;

function u1.IsHiddenAfterUpdate(p10: table, p11: string) -- Line: 116
    -- upvalues: u4 (copy), ReplicatedFirst (copy)
    for _, v in u4 do
        if v == p11 and workspace:GetServerTimeNow() > ReplicatedFirst.GlobalUpdateTime.Value then
            return true;
        end;
    end;

    return false;
end;

function u1.IsHiddenFromUpdate(p12: table, p13: string) -- Line: 126
    -- upvalues: u3 (copy), ReplicatedFirst (copy)
    for _, v in u3 do
        if v == p13 and workspace:GetServerTimeNow() <= ReplicatedFirst.GlobalUpdateTime.Value then
            return true;
        end;
    end;

    return false;
end;

function u1.GetUpdateTime(p14) -- Line: 136
    -- upvalues: ReplicatedFirst (copy)
    return ReplicatedFirst.GlobalUpdateTime.Value;
end;

function u1.GetRemainingTimeUntilUpdate(p15) -- Line: 140
    -- upvalues: ReplicatedFirst (copy)
    return ReplicatedFirst.GlobalUpdateTime.Value - workspace:GetServerTimeNow();
end;

function u1.IsUpdateDone(p16) -- Line: 144
    -- upvalues: u6 (ref)
    return u6;
end;

local function CompleteUpdate() -- Line: 148
    -- upvalues: u5 (copy), u6 (ref), u2 (copy)
    for _, v in u5 do
        v.Parent = script;
        v:AddTag("DestroyAfterUpdate");
    end;

    u6 = true;
    u2:Fire();
end;

task.spawn(function() -- Line: 159
    -- upvalues: ReplicatedFirst (copy), CompleteUpdate (copy), Children (copy), LocalPlayer (copy)
    if workspace:GetServerTimeNow() >= ReplicatedFirst.GlobalUpdateTime.Value then
        CompleteUpdate();

        return;
    end;

    for _, v in Children do
        v:AddTag("UpdateItem");
        v.Parent = script;
    end;

    while task.wait(1) and workspace:GetServerTimeNow() < ReplicatedFirst.GlobalUpdateTime.Value do

    end;

    local v17;

    if LocalPlayer then
        v17 = LocalPlayer:GetAttribute("FirstTimePlayer");
    else
        v17 = nil;
    end;

    for _, v in Children do
        if not v17 then
            v.Parent = workspace.Interaction.UpdateItems;
            v:RemoveTag("UpdateItem");
        end;
    end;

    CompleteUpdate();
end);

function u1.ForceCompleteUpdate(p18) -- Line: 200
    -- upvalues: ReplicatedFirst (copy), RunService (copy), ReplicatedStorage (copy)
    ReplicatedFirst.GlobalUpdateTime.Value = workspace:GetServerTimeNow();

    if RunService:IsServer() then
        ReplicatedStorage.GameEvents.UpdateServiceForceUpdated:FireAllClients();
    end;
end;

if RunService:IsClient() then
    ReplicatedStorage.GameEvents.UpdateServiceForceUpdated.OnClientEvent:Connect(u1.ForceCompleteUpdate, u1);
end;

return u1;