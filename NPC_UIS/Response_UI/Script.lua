-- Decompiled with Potassium's decompiler.

local Top_Text = require(game.ReplicatedStorage.Top_Text);
task.wait(0.5);

if script and (script.Parent and script.Parent ~= nil) then
    Top_Text.TakeAwayResponses(script.Parent.Parent.Parent, game.Players.LocalPlayer);
end;