-- Decompiled with Potassium's decompiler.

local v1 = {};
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.CreateTagHandler);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local LocalPlayer = Players.LocalPlayer;

local function EnableWeatherPerformanceMode() -- Line: 25
    -- upvalues: Lighting (copy)
    for _, descendant in Lighting:GetDescendants() do
        if descendant.Name ~= "Atmosphere" and (descendant.Name ~= "Blur" and (descendant.Name ~= "Cutscene" and (descendant.Name ~= "LoadingBlur" and (descendant.Name ~= "NightColor" and not descendant:IsA("Folder"))))) then
            if not descendant:IsA("Sky") then
                descendant.Enabled = false;
            end;
        end;
    end;
end;

LocalPlayer:GetAttributeChangedSignal("PerformanceMode"):Connect(function() -- Line: 44
    -- upvalues: LocalPlayer (copy), EnableWeatherPerformanceMode (copy)
    if LocalPlayer:GetAttribute("PerformanceMode") then
        EnableWeatherPerformanceMode();
    end;
end);

if SettingsService:GetSetting("PerformanceMode") then
    task.defer(EnableWeatherPerformanceMode);
end;

return v1;