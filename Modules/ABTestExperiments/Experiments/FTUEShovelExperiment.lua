-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

local function setShovel(p1: userdata, p2: any) -- Line: 10
    p1:SetAttribute("AB_FTUEShovel", p2);
end;

return {
    RemoteConfig = "FTUEShovel",
    Disabled = false,
    DefaultState = game:GetService("RunService"):IsStudio() and "Variant2" or "Variant3",
    States = {
        Variant1 = {
            Server = setShovel
        },
        Variant2 = {
            Server = setShovel
        },
        Variant3 = {
            Server = setShovel
        }
    }
};