-- Decompiled with Potassium's decompiler.

local SoundService = game:GetService("SoundService");
local Click = SoundService.Click;
local Hover = SoundService.Hover;

return {
    Click = function() -- Line: 6, Name: Click
        -- upvalues: Click (copy)
        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Click:Play();
    end,

    Hover = function() -- Line: 11, Name: Hover
        -- upvalues: Hover (copy)
        Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Hover:Play();
    end
};