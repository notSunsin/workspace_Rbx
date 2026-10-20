-- Decompiled with Potassium's decompiler.

local u1 = {
    Presets = {
        RoundedOddsCompliance = "Percentages are rounded for display and may not total exactly 100%.",
        RoundedOdds = "Percentages are rounded for display and may not add up exactly."
    }
};

function u1.Resolve(p2: string?) -- Line: 34
    -- upvalues: u1 (copy)
    if p2 == nil or p2 == "" then
        return "";
    end;

    if string.sub(p2, 1, 8) ~= "PRESETS/" then
        return p2;
    end;

    local string_sub_ret = string.sub(p2, 9);
    local v3 = u1.Presets[string_sub_ret];

    if v3 then
        return v3;
    end;

    warn((`[DisclaimerPresets] unknown preset "{string_sub_ret}"; showing no disclaimer.`));

    return "";
end;

return u1;