-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "ShowPickupTally",
    Disabled = false,
    DefaultState = RunService:IsStudio(),
    States = {
        [true] = {
            Client = function(p1: userdata, p2: any) -- Line: 16, Name: Client
                p1:SetAttribute("AB_ShowPickupTally", true);
            end
        }
    }
};