-- Decompiled with Potassium's decompiler.

local u34 = {
    ConvertSecondsToTime = function(p1, p2) -- Line: 3, Name: ConvertSecondsToTime
        local math_floor_ret = math.floor(p2 / 60);
        local v3 = p2 % 60;
        local math_floor_ret2 = math.floor(math_floor_ret / 60);
        local v4 = math_floor_ret % 60;
        local math_floor_ret3 = math.floor(math_floor_ret2 / 24);
        local v5 = math_floor_ret2 % 24;
        local math_floor_ret4 = math.floor(math_floor_ret3 / 365);
        local v6 = math_floor_ret3 % 365;
        local math_floor_ret5 = math.floor(v6 / 30);
        local v7 = v6 % 30;
        local math_floor_ret6 = math.floor(math_floor_ret4 / 10);
        local v8 = math_floor_ret4 % 10;
        local math_floor_ret7 = math.floor(math_floor_ret6 / 10);
        local v9 = math_floor_ret6 % 10;
        local math_floor_ret8 = math.floor(math_floor_ret7 / 10);
        local v10 = math_floor_ret7 % 10;
        local math_floor_ret9 = math.floor(math_floor_ret8 / 10);
        local v11 = math_floor_ret8 % 10;
        local v12 = {};
        local v13 = {
            Occupies = 1,
            Type = math_floor_ret9 == 1 and "Eon" or "Eons"
        };

        if math_floor_ret9 == 0 then
            math_floor_ret9 = nil;
        end;

        v13.Value = math_floor_ret9;
        local v14 = {
            Occupies = 1,
            Type = v11 == 1 and "Millenium" or "Millenia"
        };

        if v11 == 0 then
            v11 = nil;
        end;

        v14.Value = v11;
        local v15 = {
            Occupies = 1,
            Type = v10 == 1 and "Century" or "Centuries"
        };

        if v10 == 0 then
            v10 = nil;
        end;

        v15.Value = v10;
        local v16 = {
            Occupies = 1,
            Type = v9 == 1 and "Decade" or "Decades"
        };

        if v9 == 0 then
            v9 = nil;
        end;

        v16.Value = v9;
        local v17 = {
            Occupies = 1,
            Type = v8 == 1 and "Year" or "Years"
        };

        if v8 == 0 then
            v8 = nil;
        end;

        v17.Value = v8;
        local v18 = {
            Occupies = 2,
            Type = math_floor_ret5 == 1 and "Month" or "Months"
        };

        if math_floor_ret5 == 0 then
            math_floor_ret5 = nil;
        end;

        v18.Value = math_floor_ret5;
        local v19 = {
            Occupies = 2,
            Type = v7 == 1 and "Day" or "Days"
        };

        if v7 == 0 then
            v7 = nil;
        end;

        v19.Value = v7;
        local v20 = {
            Occupies = 1,
            Type = v5 == 1 and "Hour" or "Hours"
        };

        if v5 == 0 then
            v5 = nil;
        end;

        v20.Value = v5;
        local v21 = {
            Occupies = 2,
            Type = v4 == 1 and "Minute" or "Minutes"
        };

        if v4 == 0 then
            v4 = nil;
        end;

        v21.Value = v4;
        local v22 = {
            Occupies = 2,
            OverwriteOccupy = true,
            Type = v3 == 1 and "Second" or "Seconds"
        };

        if v3 == 0 then
            v3 = nil;
        end;

        v22.Value = v3;
        v12[1], v12[2], v12[3], v12[4], v12[5], v12[6], v12[7], v12[8], v12[9], v12[10] = v13, v14, v15, v16, v17, v18, v19, v20, v21, v22;

        return v12;
    end,

    GenerateTextFromTime = function(p23, p24, p25) -- Line: 78, Name: GenerateTextFromTime
        local v26 = p25 ~= false;
        local v27 = p24 // 86400;
        local v28 = p24 % 86400;
        local v29 = v28 // 3600;
        local v30 = v28 % 3600;
        local v31 = v30 // 60;
        local v32 = v30 % 60 // 1;
        local v33 = "";

        if v27 > 0 then
            v33 = v33 .. v27 .. (v27 == 1 and " Day" or " Days");
        end;

        if v29 > 0 then
            if #v33 > 0 then
                v33 = v33 .. (v26 and ", " or " ");
            end;

            v33 = v33 .. v29 .. (v29 == 1 and " Hour" or " Hours");
        end;

        if v31 > 0 then
            if #v33 > 0 then
                v33 = v33 .. (v26 and ", " or " ");
            end;

            v33 = v33 .. v31 .. (v31 == 1 and " Minute" or " Minutes");
        end;

        if v32 > 0 then
            if #v33 > 0 then
                v33 = v33 .. (v26 and ", " or " ");
            end;

            v33 = v33 .. v32 .. (v32 == 1 and " Second" or " Seconds");
        end;

        if v26 then
            local string_match_ret = string.match(v33, "^(.*), ");

            if string_match_ret then
                v33 = string_match_ret .. " and " .. string.sub(v33, #string_match_ret + 3);
            end;
        end;

        return v33;
    end
};

function u34.GenerateColonFormatFromTime(p35, p36) -- Line: 131
    -- upvalues: u34 (copy)
    local v37 = u34:ConvertSecondsToTime(p36);
    local v38 = "";
    local v39 = { "Second", "Seconds", "Minute", "Minutes" };

    for i, v in v37 do
        local Value = v.Value;
        local Occupies = v.Occupies;
        local v40 = v37[i - 1];
        local OverwriteOccupy = v.OverwriteOccupy;

        if OverwriteOccupy then
            v40 = OverwriteOccupy;
        elseif v40 then
            v40 = v40.Value;
        end;

        local v41 = table.find(v39, v.Type) and (Value or 0) or Value;

        if v41 then
            local v42 = v40 and `%0{Occupies}d` or "%d";
            local string_format_ret = string.format(v42, v41);
            v38 = #v37 == i and `{v38}{string_format_ret}` or `{v38}{string_format_ret}:`;
        end;
    end;

    return v38;
end;

local u43 = { {
        Name = "Year",
        Singular = "Year",
        Plural = "Years",
        Value = 31536000
    }, {
        Name = "Month",
        Singular = "Month",
        Plural = "Months",
        Value = 2592000
    }, {
        Name = "Day",
        Singular = "Day",
        Plural = "Days",
        Value = 86400
    }, {
        Name = "Hour",
        Singular = "Hour",
        Plural = "Hours",
        Value = 3600
    }, {
        Name = "Minute",
        Singular = "Minute",
        Plural = "Minutes",
        Value = 60
    }, {
        Name = "Second",
        Singular = "Second",
        Plural = "Seconds",
        Value = 1
    } };

function u34.GetLargestTime(p44: table, p45: number, p46: string, p47: number?) -- Line: 179
    -- upvalues: u43 (copy)
    local v48 = p47 or 1;
    local v49 = 0;
    local v50 = {};
    local v51 = p46 or "floor";

    for _, v in ipairs(u43) do
        if v48 <= v49 then
            break;
        end;

        local math_floor_ret = math.floor(p45 / v.Value);

        if math_floor_ret > 0 or #v50 == 0 and v.Name == "Second" then
            if v49 == v48 - 1 and p45 % v.Value > 0 then
                if v51 == "ceil" then
                    math_floor_ret = math_floor_ret + 1;
                elseif v51 == "round" and p45 % v.Value >= v.Value / 2 then
                    math_floor_ret = math_floor_ret + 1;
                end;
            end;

            table.insert(v50, math_floor_ret .. " " .. (math_floor_ret == 1 and v.Singular or v.Plural));
            p45 = p45 - math_floor_ret * v.Value;
            v49 = v49 + 1;
        end;
    end;

    if #v50 == 0 then
        return "0 Seconds";
    end;

    if #v50 == 1 then
        return v50[1];
    end;

    if #v50 == 2 then
        return v50[1] .. " and " .. v50[2];
    end;

    local table_remove_ret = table.remove(v50);

    return table.concat(v50, ", ") .. " and " .. table_remove_ret;
end;

function u34.HasPassedTime(p52: table, p53: number, p54: number) -- Line: 237
    local ServerTimeNow = workspace:GetServerTimeNow();
    local math_floor_ret = math.floor(ServerTimeNow);
    local math_round_ret = math.round(math_floor_ret - p54);

    if math.floor(math_floor_ret / p53) == math.floor(p54 / p53) then
        return false, math_round_ret;
    end;

    return true, math_round_ret;
end;

return u34;