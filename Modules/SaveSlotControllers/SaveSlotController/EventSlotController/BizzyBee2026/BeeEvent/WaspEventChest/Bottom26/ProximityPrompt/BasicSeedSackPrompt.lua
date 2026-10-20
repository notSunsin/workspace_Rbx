-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local WaspEventOddsController = require(ReplicatedStorage.Modules.BeeEventV2Controllers.WaspEventOddsController);
script.Parent.Triggered:Connect(function() -- Line: 6
    -- upvalues: WaspEventOddsController (copy)
    WaspEventOddsController:Open();
end);