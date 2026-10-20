-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlayHoverSound = require(ReplicatedStorage.Modules.PlayHoverSound);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);

return function(p1: userdata) -- Line: 6, Name: SetupSounds
    -- upvalues: PlayHoverSound (copy), PlayClickSound (copy)
    local SENSOR = p1:WaitForChild("SENSOR");
    SENSOR.MouseEnter:Connect(function() -- Line: 9
        -- upvalues: PlayHoverSound (ref)
        PlayHoverSound();
    end);
    SENSOR.MouseButton1Click:Connect(function() -- Line: 13
        -- upvalues: PlayClickSound (ref)
        PlayClickSound();
    end);

    return SENSOR;
end;