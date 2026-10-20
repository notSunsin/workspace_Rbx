-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "Test",
    Disabled = false,
    DefaultState = true,
    States = {
        [true] = {
            Server = function(p1: userdata, p2: any) -- Line: 15, Name: Server
            end,

            Client = function(p3: userdata, p4: any) -- Line: 19, Name: Client
            end
        },
        [false] = {
            Server = function(p5: userdata, p6: any) -- Line: 25, Name: Server
            end,

            Client = function(p7: userdata, p8: any) -- Line: 29, Name: Client
            end
        }
    }
};