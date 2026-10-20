-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("HttpService");
local Players = game:GetService("Players");
local TypedSignal = require(script:WaitForChild("TypedSignal"));
local ABTestExperiments = require(ReplicatedStorage.Modules.ABTestExperiments);
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);
local LocalPlayer = Players.LocalPlayer;
local v10 = {
    _loaded = false,
    _loadedSignal = TypedSignal.new(),
    _remoteConfigs = {},

    _runExperiments = function(p1) -- Line: 37, Name: _runExperiments
        -- upvalues: ABTestExperiments (copy), LocalPlayer (copy)
        if not p1._remoteConfigs then
            return;
        end;

        for _, v in ABTestExperiments do
            if not v.Disabled then
                local v2 = p1._remoteConfigs[v.RemoteConfig] or v.DefaultState;
                local v3 = v.States[v2];

                if v3 and v3.Client then
                    task.defer(v3.Client, LocalPlayer, v2);
                end;
            end;
        end;
    end,

    IsLoaded = function(p4) -- Line: 58, Name: IsLoaded
        return p4._loaded;
    end,

    OnLoad = function(p5, p6) -- Line: 63, Name: OnLoad
        return p5._loadedSignal:Connect(p6);
    end,

    GetRemoteConfig = function(p7, p8) -- Line: 68, Name: GetRemoteConfig
        return p7._remoteConfigs[p8], p7:IsLoaded();
    end,

    Start = function(p9) -- Line: 72, Name: Start
    end
};
task.spawn(v10.Start, v10);

return v10;