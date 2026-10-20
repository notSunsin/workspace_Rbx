-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "FruitVFX",
    Disabled = false,
    DefaultState = RunService:IsStudio() and true or false,
    States = {
        [true] = {
            Server = function(p1: userdata, p2: any) -- Line: 16, Name: Server
                p1:SetAttribute("AB_FruitCollection", true);
            end
        },
        [false] = {
            Server = function(p3: userdata, p4: any) -- Line: 21, Name: Server
                p3:SetAttribute("AB_FruitCollection", false);
            end
        }
    }
};