-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "TestKeyTeleport",
    Disabled = false,
    DefaultState = false,
    States = {
        [true] = {
            Server = function(p1: userdata, p2: any) -- Line: 15, Name: Server
                p1:SetAttribute("TestKeyTeleport", true);
            end,

            Client = function(p3: userdata, p4: any) -- Line: 19, Name: Client
                p3:SetAttribute("TestKeyTeleport", true);
            end
        },
        [false] = {
            Server = function(p5: userdata, p6: any) -- Line: 26, Name: Server
                p5:SetAttribute("TestKeyTeleport", false);
            end,

            Client = function(p7: userdata, p8: any) -- Line: 31, Name: Client
                p7:SetAttribute("TestKeyTeleport", false);
            end
        }
    }
};