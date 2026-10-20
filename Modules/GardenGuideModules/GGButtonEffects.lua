-- Decompiled with Potassium's decompiler.

local SoundService = game:GetService("SoundService");
local Click = SoundService.Click;
local Hover = SoundService.Hover;
local v1 = {
    Click = function() -- Line: 8, Name: Click
        -- upvalues: Click (copy)
        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Click:Play();
    end
};

local function _() -- Line: 13
    -- upvalues: Hover (copy)
    Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Hover:Play();
end;

function v1.AddHoverEffect(u2: userdata) -- Line: 18
    -- upvalues: Hover (copy)
    u2.MouseEnter:Connect(function() -- Line: 19
        -- upvalues: Hover (ref), u2 (copy)
        Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Hover:Play();
        u2.BackgroundTransparency = 0.8;
    end);
    u2.MouseLeave:Connect(function() -- Line: 23
        -- upvalues: u2 (copy)
        u2.BackgroundTransparency = 1;
    end);
end;

return v1;