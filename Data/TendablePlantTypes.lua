-- Decompiled with Potassium's decompiler.

return {
    DefaultTendablePlant = function(p1: table?) -- Line: 7, Name: DefaultTendablePlant
        local v2 = 0;
        local v3 = 0;

        if p1 then
            v2 = p1.CurrentPlantHealth or v2;
            v3 = p1.CurrentSizeBoostChance or v3;
        end;

        return {
            CurrentPlantHealth = v2,
            CurrentSizeBoostChance = v3
        };
    end
};