-- Decompiled with Potassium's decompiler.

local ServerScriptService = game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local DiggingEventConfigData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingEventConfigData);

return {
    GetTheme = function(p1) -- Line: 11, Name: GetTheme
        -- upvalues: DiggingEventConfigData (copy), RunService (copy), ServerScriptService (copy), ReplicatedStorage (copy)
        local CurrentTheme = DiggingEventConfigData.GetCurrentTheme();
        local v2;

        if RunService:IsServer() then
            v2 = require(ServerScriptService.Modules.EventRotation.EventRotationService):GetLoadedEvent();
        else
            v2 = require(ReplicatedStorage.Modules.EventRotation.EventRotationController):GetLoadedEvent();
        end;

        if v2 then
            return v2.EventSet;
        end;

        return CurrentTheme;
    end
};