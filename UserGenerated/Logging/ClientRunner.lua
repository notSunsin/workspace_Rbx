-- Decompiled with Potassium's decompiler.

local FastFlags = require(game.ReplicatedStorage.UserGenerated.FastFlags);
local script_Parent = require(script.Parent);
local v1 = FastFlags.Replicated("UserGenerated.Logging.ClientLevel", script_Parent.AssertLevel, "Warn");
script_Parent.SetLevel(v1:Get());
v1.Changed:Connect(function(p2) -- Line: 24
    -- upvalues: script_Parent (copy)
    script_Parent.SetLevel(p2);
end);