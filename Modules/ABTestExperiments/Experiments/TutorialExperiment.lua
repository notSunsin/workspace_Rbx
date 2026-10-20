-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);
require(ReplicatedStorage.Modules.IsDev);

local function setTutorial(p1: userdata, p2: any) -- Line: 9
    p1:SetAttribute("AB_TutorialVariant", p2);
end;

return {
    RemoteConfig = "TutorialVariant",
    Disabled = false,
    DefaultState = "Variant4",
    States = {
        Variant1 = {
            Client = setTutorial
        },
        Variant2 = {
            Client = setTutorial
        },
        Variant3 = {
            Client = setTutorial
        },
        Variant4 = {
            Client = setTutorial
        }
    }
};