-- Decompiled with Potassium's decompiler.

return function(p1: number) -- Line: 20, Name: TrimmedNumberString
    local v2 = type(p1) == "number";
    assert(v2);

    if p1 ~= p1 then
        return "NaN";
    end;

    if p1 == (1 / 0) then
        return "Infinity";
    end;

    if p1 == (-1 / 0) then
        return "-Infinity";
    end;

    local string_format_ret = string.format("%f", p1);
    local string_match_ret, v3 = string.match(string_format_ret, "^([^%.]*)%.?(.*)$");
    assert(string_match_ret);

    if not v3 then
        return string_match_ret;
    end;

    local string_gsub_ret = string.gsub(v3, "0+$", "");

    if #string_gsub_ret == 0 then
        return string_match_ret;
    end;

    return `{string_match_ret}.{string_gsub_ret}`;
end;