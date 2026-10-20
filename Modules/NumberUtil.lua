-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function GenerateIncrement(p1) -- Line: 76
    return math.pow(1000, p1) * 1000;
end;

local v2 = { "CENT", "VIG", "NOV", "OCT", "SEP", "SXD", "QUI", "QUA", "TR", "DU", "UN", "DE", "NO", "OC", "SP", "SX", "QI", "QA", "T", "B", "M", "K" };
local v3 = #v2 - 1;
local u4 = {};
local u18 = {
    autoColon = function(p5: number) -- Line: 5, Name: autoColon
        if p5 >= 86400 then
            return string.format("%02i:%02i:%02i:%02i", p5 / 86400, p5 / 3600 % 24, p5 / 60 % 60, p5 % 60);
        end;

        if p5 >= 3600 then
            return string.format("%02i:%02i:%02i", p5 / 3600, p5 / 60 % 60, p5 % 60);
        end;

        return string.format("%02i:%02i", p5 / 60, p5 % 60);
    end,

    toMS = function(p6: number) -- Line: 15, Name: toMS
        return string.format("%01i:%02i", p6 / 60, p6 % 60);
    end,

    toHMS = function(p7: number) -- Line: 19, Name: toHMS
        return string.format("%02i:%02i:%02i", p7 / 3600, p7 / 60 % 60, p7 % 60);
    end,

    toDHMS = function(p8: number) -- Line: 23, Name: toDHMS
        if p8 >= 86400 then
            return `{p8 // 86400}d {p8 % 86400 // 3600}h`;
        end;

        if p8 >= 3600 then
            return `{p8 // 3600}h {p8 % 3600 // 60}m`;
        end;

        return `{p8 // 60}m {p8 // 1 % 60}s`;
    end,

    toHMSExtended = function(p9: number) -- Line: 33, Name: toHMSExtended
        local v10 = p9 / 3600;

        if v10 < 24 then
            return string.format("%02i:%02i:%02i", v10, p9 / 60 % 60, p9 % 60);
        end;

        if v10 < 48 then
            return string.format("1 day, %02i hours", v10 - 24);
        end;

        return string.format("%02i days", v10 / 24);
    end,

    compactFormat = function(p11: number, p12: boolean?) -- Line: 45, Name: compactFormat
        if p11 >= 86400 then
            local v13 = p11 % 86400 // 3600;

            return `{p11 // 86400}d{(v13 <= 0 or p12) and "" or ` {v13}h`}`;
        end;

        if p11 >= 3600 then
            local v14 = p11 % 3600 // 60;

            return `{p11 // 3600}h{(v14 <= 0 or p12) and "" or ` {v14}m`}`;
        end;

        if p11 < 60 then
            return `{p11 // 1}s`;
        end;

        local v15 = p11 // 1 % 60;

        return `{p11 // 60}m{(v15 <= 0 or p12) and "" or ` {v15}s`}`;
    end,

    formatShopTime = function(p16: number) -- Line: 60, Name: formatShopTime
        if p16 >= 86400 then
            local math_ceil_ret = math.ceil(p16 / 86400);

            return `{math_ceil_ret} Day{math_ceil_ret == 1 and "" or "s"}`;
        end;

        if p16 >= 3600 then
            return "Today";
        end;

        if p16 < 60 then
            return `{p16 // 1} Seconds`;
        end;

        local v17 = p16 // 60;

        return `{v17} Minute{v17 == 1 and "" or "s"}`;
    end
};

for _, v in v2 do
    local v19 = {
        Number = math.pow(1000, v3) * 1000,
        Symbol = v
    };
    table.insert(u4, v19);
    v3 = v3 - 1;
end;

function u18.FormatCompactPrice(p20: number, p21: string?) -- Line: 127
    -- upvalues: u4 (copy)
    for _, v in u4 do
        local Number = v.Number;
        local Symbol = v.Symbol;

        if Number <= p20 then
            return `{(`%.{p21 or "1"}f`):format(p20 / Number):gsub("0+$", ""):gsub("%.$", "")}{Symbol}`;
        end;
    end;

    return ("%.0f"):format(p20);
end;

function u18.ReverseLerp(p22: number, p23: number, p24: number) -- Line: 150
    return (p24 - p22) / (p23 - p22);
end;

function u18.RoundToDP(p25: number, p26: number) -- Line: 154
    return math.round(p25 * 10 ^ p26) / 10 ^ p26;
end;

local Comma_Module = require(ReplicatedStorage.Comma_Module);

function u18.Comma(p27) -- Line: 159
    -- upvalues: Comma_Module (copy)
    return Comma_Module.Comma(p27);
end;

local u28 = { {
        Name = "Flower",
        Icon = "🌸",
        Value = 1000000000000000
    } };
table.sort(u28, function(p29, p30) -- Line: 169
    return p29.Value > p30.Value;
end);

function u18.FormatSheckles(p31: number) -- Line: 201
    -- upvalues: u28 (copy), u18 (copy)
    local v32 = {};

    for _, v in u28 do
        if v.Value <= p31 then
            local math_floor_ret = math.floor(p31 / v.Value);
            p31 = math.floor(p31 % v.Value);
            local v33;

            if math_floor_ret >= 1000 then
                v33 = u18.FormatCompactPrice(math_floor_ret);
            else
                v33 = tostring(math_floor_ret);
            end;

            local v34 = `{v33}{v.Icon}`;
            table.insert(v32, v34);
        end;
    end;

    if p31 > 0 then
        local v35 = u18.FormatCompactPrice(p31) .. "¢";
        table.insert(v32, v35);
    end;

    if #v32 == 0 then
        return "0¢";
    end;

    if #v32 == 1 then
        return v32[1];
    end;

    local table_remove_ret = table.remove(v32);

    return table.concat(v32, ", ") .. " " .. table_remove_ret;
end;

function u18.BreakdownSheckles(p36: number) -- Line: 231
    -- upvalues: u28 (copy)
    local v37 = {};

    for _, v in u28 do
        if v.Value <= p36 then
            local math_floor_ret = math.floor(p36 / v.Value);
            p36 = p36 % v.Value;
            table.insert(v37, {
                Name = v.Name,
                Icon = v.Icon,
                Count = math_floor_ret
            });
        end;
    end;

    return {
        Tiers = v37,
        Remainder = p36
    };
end;

function u18.DisplaySheckles(p38: number) -- Line: 253
    -- upvalues: u18 (copy)
    if type(p38) == "string" then
        p38 = tonumber(p38);
    end;

    if p38 then
        local math_abs_ret = math.abs(p38);
        local math_floor_ret = math.floor(math_abs_ret);

        if math_floor_ret >= 1000000000000000 then
            return u18.FormatSheckles(math_floor_ret);
        end;

        if math_floor_ret >= 1000 then
            return u18.FormatCompactPrice(math_floor_ret, "3") .. "¢";
        end;

        return u18.Comma(math_floor_ret) .. "¢";
    end;

    warn("Incorrect type for amount");
end;

return u18;