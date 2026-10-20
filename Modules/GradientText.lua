-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: string, p3: string) -- Line: 1, Name: GradientText
    local string_split_ret = string.split(p1, " ");
    local v4 = #string_split_ret;

    if v4 == 0 then
        return "";
    end;

    if v4 == 1 then
        return `<b><font color="{p2}">{string_split_ret[1]}</font></b>`;
    end;

    local string_sub_ret = string.sub(p2, 2, 3);
    local v5 = tonumber(string_sub_ret, 16) / 255;
    local string_sub_ret2 = string.sub(p2, 4, 5);
    local v6 = tonumber(string_sub_ret2, 16) / 255;
    local string_sub_ret3 = string.sub(p2, 6, 7);
    local v7 = tonumber(string_sub_ret3, 16) / 255;
    local string_sub_ret4 = string.sub(p3, 2, 3);
    local v8 = tonumber(string_sub_ret4, 16) / 255;
    local string_sub_ret5 = string.sub(p3, 4, 5);
    local v9 = tonumber(string_sub_ret5, 16) / 255;
    local string_sub_ret6 = string.sub(p3, 6, 7);
    local v10 = tonumber(string_sub_ret6, 16) / 255;
    local v11 = {};

    for i, v in string_split_ret do
        local v12 = (i - 1) / (v4 - 1);
        local math_floor_ret = math.floor((v5 + (v8 - v5) * v12) * 255);
        local math_floor_ret2 = math.floor((v6 + (v9 - v6) * v12) * 255);
        local math_floor_ret3 = math.floor((v7 + (v10 - v7) * v12) * 255);
        local v13 = `<b><font color="{string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3)}">{v}</font></b>`;
        table.insert(v11, v13);
    end;

    return table.concat(v11, " ");
end;