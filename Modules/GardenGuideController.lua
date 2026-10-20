-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GardenGuideData = require(ReplicatedStorage.Data.GardenGuideData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.SetupButton);
local u1 = not GardenGuideData.UseTool;
local GardenGuide = Players.LocalPlayer.PlayerGui:WaitForChild("GardenGuide");
GuiController:GetStateForGui(GardenGuide);
local ToggleBook = ReplicatedStorage.GameEvents.GardenGuide.ToggleBook;
local u4 = {
    Open = function(p2) -- Line: 22, Name: Open
        -- upvalues: u1 (copy), GuiController (copy), GardenGuide (copy)
        if u1 then
            GuiController:Open(GardenGuide);

            return;
        end;

        GardenGuide.Enabled = true;
    end,

    Close = function(p3) -- Line: 30, Name: Close
        -- upvalues: u1 (copy), GuiController (copy), GardenGuide (copy)
        if u1 then
            GuiController:Close(GardenGuide);

            return;
        end;

        GardenGuide.Enabled = false;
    end
};

function u4.Toggle(p5) -- Line: 38
    -- upvalues: u1 (copy), GuiController (copy), GardenGuide (copy), u4 (copy)
    if u1 then
        GuiController:Toggle(GardenGuide);

        return;
    end;

    if GardenGuide.Enabled then
        u4:Close();

        return;
    end;

    u4:Open();
end;

function u4.Start(p6) -- Line: 50
    -- upvalues: u1 (copy), GuiController (copy), GardenGuide (copy), ToggleBook (copy)
    if u1 then
        GuiController:UsePopupAnims(GardenGuide);
    end;

    GardenGuide:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 56
        -- upvalues: ToggleBook (ref), GardenGuide (ref)
        ToggleBook:FireServer(GardenGuide.Enabled);
    end);
end;

task.spawn(u4.Start, u4);

return u4;