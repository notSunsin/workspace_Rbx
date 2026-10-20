-- Decompiled with Potassium's decompiler.

local u1 = {
    RESET_TIME = 14400,
    STARTING_COST = 1000000,
    MAX_COST = 1e21,
    COST_RATE_OF_INCREASE = 3,
    BREAK_CHANCE_MULTIPLIER = 2,
    BASE_BREAK_CHANCE = 2.5
};

function u1.GetCost(p2: table, p3: number) -- Line: 13
    -- upvalues: u1 (copy)
    if p3 == 1 then
        return u1.STARTING_COST;
    end;

    local v4 = u1.STARTING_COST * math.pow(10, u1.COST_RATE_OF_INCREASE * p3 - 3);

    return math.clamp(v4, 0, u1.MAX_COST);
end;

function u1.GetBreakChance(p5: table, p6: number, p7: number) -- Line: 24
    -- upvalues: u1 (copy)
    if p6 == 0 then
        return 0;
    end;

    if p7 == 0 then
        return u1.BASE_BREAK_CHANCE;
    end;

    return p7 * u1.BREAK_CHANCE_MULTIPLIER;
end;

return u1;