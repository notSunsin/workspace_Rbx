-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };

function v1.TimeFromGameDate(p3: table, p4: number?, p5: number) -- Line: 37
    return (p5 - 1) * 432000 + ((p4 or 1) - 1) * 14400;
end;

function v1.GameDateFromTime(p6: table, p7: number) -- Line: 46
    local v8 = math.floor(p7 % 5184000 / 432000) + 1;

    return math.floor(p7 % 432000 / 14400) + 1, v8;
end;

function v1.GameDayFromTime(p9: table, p10: number) -- Line: 54
    return math.floor(p10 / 14400);
end;

function v1.GameMonthFromTime(p11: table, p12: number) -- Line: 61
    return math.floor(p12 / 432000);
end;

function v1.GetMonthName(p13: table, p14: number) -- Line: 68
    -- upvalues: u2 (copy)
    local v15 = p14 % 12;

    return u2[v15 == 0 and 12 or v15] or "Invalid";
end;

return v1;