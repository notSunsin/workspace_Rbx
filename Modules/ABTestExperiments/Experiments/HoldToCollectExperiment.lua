-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "HoldToCollect",
    Disabled = false,
    DefaultState = false,
    States = {
        [true] = {
            Client = function(p1: userdata, p2: any) -- Line: 17, Name: Client
                -- upvalues: UserInputService (copy), GuiService (copy)
                local v3 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not GuiService:IsTenFootInterface();

                if v3 then
                    p1:SetAttribute("AB_HoldToCollect", true);
                end;
            end
        }
    }
};