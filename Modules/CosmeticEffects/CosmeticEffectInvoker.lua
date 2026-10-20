-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local PlayCosmeticFX = ReplicatedStorage.GameEvents.CosmeticEffectEvents.PlayCosmeticFX;

return {
    PlayEffect = function(p1: table, p2: userdata, p3: string) -- Line: 52, Name: PlayEffect
        -- upvalues: PlayCosmeticFX (copy), SoundService (copy)
        if not PlayCosmeticFX:InvokeServer(p2, p3) then
            return;
        end;

        if p3 == "LightSwitch" then
            local Click = SoundService.Click;
            Click.Volume = 0.1;
            Click.Playing = true;
            Click.TimePosition = 0;
        end;
    end
};