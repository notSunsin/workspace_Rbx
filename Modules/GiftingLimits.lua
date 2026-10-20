-- Decompiled with Potassium's decompiler.

local u1 = { {
        ReceiverSheckles = 10000,
        GiftMaximumValue = 100000
    }, {
        ReceiverSheckles = 100000,
        GiftMaximumValue = 2000000
    }, {
        ReceiverSheckles = 10000000,
        GiftMaximumValue = 1000000000
    }, {
        ReceiverSheckles = 1000000000,
        GiftMaximumValue = 1000000000000
    } };

return {
    GiftingLimits = u1,

    VerifyGift = function(p2: number, p3: number) -- Line: 28, Name: VerifyGift
        -- upvalues: u1 (copy)
        if type(p2) ~= "number" then
            warn((`Invalid receiver sheckles: {p2}`));

            return false;
        end;

        if type(p3) == "number" then
            for _, v in u1 do
                if v.ReceiverSheckles > p2 and p3 > v.GiftMaximumValue then
                    return false;
                end;
            end;

            return true;
        end;

        warn((`Invalid gift value: {p3}`));

        return false;
    end
};