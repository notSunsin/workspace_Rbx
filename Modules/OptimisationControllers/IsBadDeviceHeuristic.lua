-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = { 813163219, 327423121 };
local IsMobile = require(ReplicatedStorage.Modules.OptimisationControllers.IsMobile);
local IsDev = require(ReplicatedStorage.Modules.IsDev);

return function() -- Line: 11, Name: IsBadDeviceHeuristic
    -- upvalues: IsDev (copy), u1 (copy), LocalPlayer (copy), IsMobile (copy)
    if IsDev() and table.find(u1, LocalPlayer.UserId) then
        return true;
    end;

    if not IsMobile() then
        return false;
    end;

    if UserSettings().GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
        return false;
    end;

    return UserSettings().GameSettings.SavedQualityLevel.Value <= Enum.SavedQualitySetting.QualityLevel4.Value;
end;