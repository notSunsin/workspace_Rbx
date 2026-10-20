-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);
local u1 = {
    Variant1 = 0,
    Variant2 = 60,
    Variant3 = 120,
    Variant4 = 180,
    Variant5 = 240,
    Variant6 = 300
};

local function setFTUELuckBoost(p2: userdata, p3: any) -- Line: 27
    -- upvalues: u1 (copy)
    p2:SetAttribute("AB_FTUELuckBoost", u1[p3] or 0);
end;

return {
    RemoteConfig = "FTUELuckBoost",
    Disabled = false,
    DefaultState = game:GetService("RunService"):IsStudio() and "Variant5" or "Variant1",
    States = {
        Variant1 = {
            Server = setFTUELuckBoost
        },
        Variant2 = {
            Server = setFTUELuckBoost
        },
        Variant3 = {
            Server = setFTUELuckBoost
        },
        Variant4 = {
            Server = setFTUELuckBoost
        },
        Variant5 = {
            Server = setFTUELuckBoost
        },
        Variant6 = {
            Server = setFTUELuckBoost
        }
    }
};