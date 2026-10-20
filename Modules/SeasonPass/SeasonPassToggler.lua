-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.SetupButton);
local SeasonPassUI = Players.LocalPlayer.PlayerGui:WaitForChild("SeasonPassUI");
GuiController:GetStateForGui(SeasonPassUI);
local v5 = {
    Open = function(p1) -- Line: 16, Name: Open
        -- upvalues: GuiController (copy), SeasonPassUI (copy)
        GuiController:Open(SeasonPassUI);
    end,

    Close = function(p2) -- Line: 20, Name: Close
        -- upvalues: GuiController (copy), SeasonPassUI (copy)
        GuiController:Close(SeasonPassUI);
    end,

    Toggle = function(p3) -- Line: 24, Name: Toggle
        -- upvalues: GuiController (copy), SeasonPassUI (copy)
        GuiController:Toggle(SeasonPassUI);
    end,

    Start = function(p4) -- Line: 28, Name: Start
        -- upvalues: GuiController (copy), SeasonPassUI (copy)
        GuiController:UsePopupAnims(SeasonPassUI);
    end
};
task.spawn(v5.Start, v5);

return v5;