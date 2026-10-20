-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1: any, p2: number?) -- Line: 3, Name: PlaySound
    -- upvalues: ReplicatedStorage (copy)
    local Sound = Instance.new("Sound");
    Sound.PlaybackSpeed = p2 or Random.new():NextNumber(0.95, 1.05);
    Sound.SoundId = p1;
    Sound.Parent = ReplicatedStorage;
    Sound.Ended:Once(function() -- Line: 9
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    Sound:Play();

    return Sound;
end;