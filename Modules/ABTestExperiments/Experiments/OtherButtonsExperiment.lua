-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("GuiService");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "OtherButtons",
    Disabled = false,
    DefaultState = false,
    States = {
        Variant = {
            Server = function(p1: userdata, p2: any) -- Line: 17, Name: Server
                print(p1, p2);
                p1:SetAttribute("OtherButtons", true);
            end
        }
    }
};