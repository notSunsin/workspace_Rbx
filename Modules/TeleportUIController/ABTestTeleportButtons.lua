-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    return {};
end;

local _ = LocalPlayer.PlayerGui.Teleport_UI;
ReplicatedStorage.GameEvents.ABTestingEvents:WaitForChild("HideInventoryItem");
local v1 = {};
local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);

if ClientABTests.GetAssignmentsAsync(LocalPlayer, true) then
    ClientABTests.GetAttributes(LocalPlayer);
end;

return v1;