-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "SessionTimeLuck",
    Disabled = false,
    DefaultState = false,
    States = {
        [false] = {
            Server = function(p1: userdata, p2: any) -- Line: 16, Name: Server
                p1:SetAttribute("SessionTimeLuckEnabled", false);
            end
        },
        [true] = {
            Server = function(p3: userdata, p4: any) -- Line: 21, Name: Server
                p3:SetAttribute("SessionTimeLuckEnabled", true);
            end
        }
    }
};