-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "GrowTimer",
    Disabled = true,
    DefaultState = RunService:IsStudio(),
    States = {
        [true] = {
            Server = function(p1: userdata, p2: any) -- Line: 16, Name: Server
                p1:SetAttribute("AB_GrowTimer", true);
            end
        },
        [false] = {
            Server = function(p3: userdata, p4: any) -- Line: 22, Name: Server
                p3:SetAttribute("AB_GrowTimer", nil);
            end
        }
    }
};