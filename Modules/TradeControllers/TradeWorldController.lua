-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local TradeWorldData = require(ReplicatedStorage.Data.TradeWorldData);
local TravelToTradeWorld = ReplicatedStorage.GameEvents.TradeWorld.TravelToTradeWorld;
local TravelToMainWorld = ReplicatedStorage.GameEvents.TradeWorld.TravelToMainWorld;
local Tagged = CollectionService:GetTagged("TradeWorldPrompt");
local u1 = CollectionService:GetTagged("MainWorldPrompt")[1];
local LocalPlayer = Players.LocalPlayer;
local u5 = {
    IsInWorld = function(p2) -- Line: 20, Name: IsInWorld
        -- upvalues: TradeWorldData (copy)
        return game.PlaceId == TradeWorldData.PlaceId and true or TradeWorldData.ForceInWorld;
    end,

    IsPlayerANoob = function(p3) -- Line: 30, Name: IsPlayerANoob
        -- upvalues: RunService (copy), ReplicatedStorage (copy)
        local v4 = nil;

        if RunService:IsServer() then
            return false;
        end;

        if RunService:IsClient() then
            v4 = require(ReplicatedStorage.Modules.DataService):GetData();
        end;

        if not v4 then
            warn("TradeWorldController | No player data found.");

            return true;
        end;

        local TotalCropsValueSold = v4.TotalCropsValueSold;
        local Sheckles = v4.Sheckles;

        if TotalCropsValueSold >= 100000 or Sheckles >= 100000 then
            return false;
        end;

        return TotalCropsValueSold + Sheckles < 100000;
    end
};

function u5.TeleportToTradeWorld(p6) -- Line: 57
    -- upvalues: u5 (copy), ReplicatedStorage (copy), TravelToTradeWorld (copy)
    if u5:IsPlayerANoob() then
        require(ReplicatedStorage.Modules.Notification):CreateNotification("You\'re not ready yet. You need to have earned at least 100,000¢!");

        return;
    end;

    TravelToTradeWorld:FireServer();
end;

function u5.TeleportToMainWorld(p7) -- Line: 68
    -- upvalues: TravelToMainWorld (copy)
    TravelToMainWorld:FireServer();
end;

function u5.TradeWorldInitializer(p8) -- Line: 72
    -- upvalues: LocalPlayer (copy), u5 (copy), Tagged (copy)
    task.spawn(function() -- Line: 74
        -- upvalues: LocalPlayer (ref), u5 (ref), Tagged (ref)
        if not LocalPlayer then
            return;
        end;

        local PlayerGui = LocalPlayer.PlayerGui;
        task.wait(3);
        local v9 = u5:IsInWorld();

        if v9 then
            for _, v in Tagged do
                v.Enabled = false;
            end;

            local Hud_UI = PlayerGui.Hud_UI;
            Hud_UI.SideBtns.GardenGuide.Visible = false;
            Hud_UI.SideBtns.Pass.Visible = false;
        end;

        PlayerGui.ActivePetUI.Frame.Opener.Visible = not v9;
    end);
end;

u5:TradeWorldInitializer();

for _, v in Tagged do
    if v:IsA("ProximityPrompt") then
        v.Triggered:Connect(function() -- Line: 115
            -- upvalues: RunService (copy), u5 (copy)
            if RunService:IsServer() then
                return;
            end;

            u5:TeleportToTradeWorld();
        end);
    end;
end;

local u10;

if u1 then
    u10 = u1.Triggered:Connect(function() -- Line: 126
        -- upvalues: RunService (copy), u5 (copy)
        if RunService:IsServer() then
            return;
        end;

        u5:TeleportToMainWorld();
    end);
else
    u10 = nil;
end;

CollectionService:GetInstanceAddedSignal("MainWorldPrompt"):Connect(function(p11: userdata) -- Line: 134
    -- upvalues: u10 (ref), u1 (copy), RunService (copy), TravelToMainWorld (copy)
    if p11:IsA("ProximityPrompt") then
        if u10 then
            u10:Disconnect();
            u10 = nil;
        end;

        u10 = u1.Triggered:Connect(function() -- Line: 140
            -- upvalues: RunService (ref), TravelToMainWorld (ref)
            if RunService:IsServer() then
                return;
            end;

            TravelToMainWorld:FireServer();
        end);
    end;
end);
CollectionService:GetInstanceRemovedSignal("MainWorldPrompt"):Connect(function(p12: userdata) -- Line: 149
    -- upvalues: u10 (ref)
    if p12:IsA("ProximityPrompt") and u10 then
        u10:Disconnect();
        u10 = nil;
    end;
end);

return u5;