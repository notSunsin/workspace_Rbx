-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

local function setStarterPackVariant(p1: userdata, p2: any) -- Line: 14
    p1:SetAttribute("AB_StarterPack", p2);
end;

return {
    RemoteConfig = "StarterPack",
    Disabled = false,
    DefaultState = game:GetService("RunService"):IsStudio() and "Variant2" or "Variant1",
    States = {
        Variant1 = {
            Server = setStarterPackVariant
        },
        Variant2 = {
            Server = setStarterPackVariant
        }
    }
};