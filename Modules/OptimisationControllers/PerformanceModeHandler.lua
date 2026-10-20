-- Decompiled with Potassium's decompiler.

local Stats = game:GetService("Stats");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.PlatformProvider);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local IsMobile = require(ReplicatedStorage.Modules.OptimisationControllers.IsMobile);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
require(ReplicatedStorage.Modules.OptimisationControllers.IsBadDeviceHeuristic);
local FPSHandler = require(ReplicatedStorage.Modules.OptimisationControllers.FPSHandler);
local LocalPlayer = Players.LocalPlayer;
local u1 = { 224410 };
local u2 = {};

local function IsAndroid() -- Line: 27
    -- upvalues: UserInputService (copy)
    local X = UserInputService:GetDeviceAcceleration().Position.X;
    local v3 = tostring(X);
    local string_split_ret = string.split(v3, ".");
    local v4 = string_split_ret[2];
    local v5 = v4 and #string_split_ret[2] or v4;

    if v5 and UserInputService.AccelerometerEnabled then
        return v5 <= 2;
    end;

    return false;
end;

function u2.IsLowEndDevice(p6) -- Line: 47
    -- upvalues: IsMobile (copy), Stats (copy), u1 (copy), LocalPlayer (copy)
    if UserSettings().GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
        return false;
    end;

    local v7 = IsMobile();

    if v7 then
        if Stats:GetTotalMemoryUsageMb() <= 1500 then
            v7 = UserSettings().GameSettings.SavedQualityLevel.Value <= Enum.SavedQualitySetting.QualityLevel3.Value;
        else
            v7 = false;
        end;
    end;

    return table.find(u1, LocalPlayer.UserId) and true or v7;
end;

function u2.OpenPrompt(p8) -- Line: 69
    -- upvalues: ConfirmationPromptController (copy), SettingsService (copy)
    ConfirmationPromptController:Open({
        Title = "Performance Mode",
        Header = "We\'ve detected your device to be running on low FPS, would you like to enable Performance Mode?",
        Middle = "This should increase FPS but will disable most Mutation, Plant, and Weather VFX.",
        Footer = "(This can be turned off in the Settings menu, but you will need to rejoin to fully disable Performance Mode)"
    }, {
        ConfirmCallback = function() -- Line: 80, Name: ConfirmCallback
            -- upvalues: SettingsService (ref)
            SettingsService:SetSetting("PerformanceMode", true);
        end
    });
end;

task.defer(function() -- Line: 90
    -- upvalues: SettingsService (copy), LocalPlayer (copy), FPSHandler (copy), IsMobile (copy), u2 (copy)
    if SettingsService:GetSetting("PerformanceMode") then
        return;
    end;

    task.wait(10);
    local v9 = 0;

    while not LocalPlayer:GetAttribute("FarmFullyLoaded") and v9 < 300 do
        task.wait(1);
        v9 = v9 + 1;
    end;

    FPSHandler:EnableFPSTracker();
    local v10 = IsMobile() and 15 or 10;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v11 = 0;
    local v12 = 0;
    local v13 = 0;
    local v14 = 0;
    local v15 = 0;

    while workspace:GetServerTimeNow() <= ServerTimeNow + 90 do
        local CurrentFPS = FPSHandler:GetCurrentFPS();
        workspace:GetServerTimeNow();
        v11 = v11 + 0.5;

        if CurrentFPS <= v10 then
            v12 = v12 + 1;

            if workspace:GetServerTimeNow() <= ServerTimeNow + 30 then
                v13 = v13 + 1;
            end;
        end;

        v14 = v14 + 1;
        v15 = v15 + CurrentFPS;
        task.wait(0.5);
    end;

    local math_floor_ret = math.floor(v15 / v14);

    if v12 >= 135 then
        LocalPlayer:SetAttribute("PerformanceMode", true);
        SettingsService:SetSetting("CropMutationVFX", false);
        SettingsService:SetSetting("PetMutationVFX", false);
        SettingsService:SetSetting("PetScaling", false);
        SettingsService:SetSetting("HeldPetScaling", false);
        SettingsService:SetSetting("KeepPetOnGround", true);
        SettingsService:SetSetting("LowerPlantFXQuality", true);
        SettingsService:SetSetting("PerformanceMode", true);
    elseif v13 >= 45 then
        u2:OpenPrompt();
    end;

    LocalPlayer:SetAttribute("AverageFPSAfterLoad", math_floor_ret);
    FPSHandler:DisableFPSTracker();
end);

return u2;