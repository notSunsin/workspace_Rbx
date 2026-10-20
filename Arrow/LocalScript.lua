-- Decompiled with Potassium's decompiler.

local Arrow_Module = require(game.ReplicatedStorage.Arrow_Module);
local u1 = true;
script.Parent.Touched:Connect(function(p2) -- Line: 3
    -- upvalues: u1 (ref), Arrow_Module (copy)
    if p2.Parent.Name == script.Parent.Target_Player.Value and u1 == true then
        u1 = false;
        Arrow_Module.Remove_Arrow(script.Parent);
    end;
end);