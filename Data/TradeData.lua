-- Decompiled with Potassium's decompiler.

return {
    SheckleTradingEnabled = true,
    Fee = 0,
    ItemLimit = 12,
    ButtonCooldown = 5,
    ItemTypes = { "Pet", "Holdable", "Packaged Seed", "TradeBoothSkin" },

    ApplyFee = function(p1: number) -- Line: 103, Name: ApplyFee
        if p1 > 10 then
            return math.max(p1 * 1, 0);
        end;

        return p1;
    end
};