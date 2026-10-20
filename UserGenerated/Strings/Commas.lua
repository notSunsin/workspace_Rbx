-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString);

return function(p1) -- Line: 35, Name: Commas
    -- upvalues: TrimmedNumberString (copy)
    if type(p1) ~= "string" then
        p1 = TrimmedNumberString(p1);
    end;

    local string_match_ret, v2, v3 = string.match(p1, "^(.-)([0-9,]+)(.*)$");

    if not v2 then
        return p1;
    end;

    local v4 = {};

    if string_match_ret then
        table.insert(v4, string_match_ret);
    end;

    local string_gsub_ret = string.gsub(v2, ",", "");
    local v5 = 1;
    local v6 = #string_gsub_ret % 3;

    if v6 > 0 then
        local string_sub_ret = string.sub(string_gsub_ret, v5, v5 + v6 - 1);
        table.insert(v4, string_sub_ret);
        v5 = v5 + v6;
    end;

    while v5 <= #string_gsub_ret do
        if v5 > 1 then
            table.insert(v4, ",");
        end;

        local string_sub_ret = string.sub(string_gsub_ret, v5, v5 + 2);
        table.insert(v4, string_sub_ret);
        v5 = v5 + 3;
    end;

    if v3 then
        table.insert(v4, v3);
    end;

    return table.concat(v4);
end;