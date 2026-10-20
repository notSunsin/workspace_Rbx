-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

local function GenerateEntropy() -- Line: 22
    -- upvalues: HttpService (copy)
    local v1 = HttpService:GenerateGUID(false);
    local string_sub_ret = string.sub(v1, 1, 8);
    local v2 = tonumber(string_sub_ret, 16);
    local v3 = string.sub(v1, 10, 13) .. string.sub(v1, 25, 28);
    local v4 = tonumber(v3, 16);
    local string_sub_ret2 = string.sub(v1, 29, 36);

    return v2, v4, tonumber(string_sub_ret2, 16);
end;

return function(p5: number) -- Line: 29, Name: GenerateSeed
    -- upvalues: HttpService (copy)
    local table_create_ret = table.create(p5, 0);
    local v6 = p5 // 3;

    for i = 0, v6 - 1 do
        local v7 = HttpService:GenerateGUID(false);
        local string_sub_ret = string.sub(v7, 1, 8);
        local v8 = tonumber(string_sub_ret, 16);
        local v9 = string.sub(v7, 10, 13) .. string.sub(v7, 25, 28);
        local v10 = tonumber(v9, 16);
        local string_sub_ret2 = string.sub(v7, 29, 36);
        local v11 = tonumber(string_sub_ret2, 16);
        table_create_ret[i * 3 + 1] = v8;
        table_create_ret[i * 3 + 2] = v10;
        table_create_ret[i * 3 + 3] = v11;
        local _ = i;
    end;

    local v12 = p5 - v6 * 3;

    if v12 ~= 1 then
        if v12 == 2 then
            local v13 = HttpService:GenerateGUID(false);
            local string_sub_ret = string.sub(v13, 1, 8);
            local v14 = tonumber(string_sub_ret, 16);
            local v15 = string.sub(v13, 10, 13) .. string.sub(v13, 25, 28);
            local v16 = tonumber(v15, 16);
            local string_sub_ret2 = string.sub(v13, 29, 36);
            tonumber(string_sub_ret2, 16);
            table_create_ret[p5 - 1] = v14;
            table_create_ret[p5] = v16;
        end;

        return table_create_ret;
    end;

    local v17 = HttpService:GenerateGUID(false);
    local string_sub_ret = string.sub(v17, 1, 8);
    local v18 = tonumber(string_sub_ret, 16);
    local v19 = string.sub(v17, 10, 13) .. string.sub(v17, 25, 28);
    tonumber(v19, 16);
    local string_sub_ret2 = string.sub(v17, 29, 36);
    tonumber(string_sub_ret2, 16);
    table_create_ret[p5] = v18;

    return table_create_ret;
end;