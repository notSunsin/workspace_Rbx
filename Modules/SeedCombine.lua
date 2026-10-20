-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HashLib = require(ReplicatedStorage.GameAnalytics.GameAnalytics.HttpApi.HashLib);
local v1 = {};

local function u32LE(p2: number) -- Line: 10
    local bit32_band_ret = bit32.band(p2, 255);
    local bit32_rshift_ret = bit32.rshift(p2, 8);
    local bit32_band_ret2 = bit32.band(bit32_rshift_ret, 255);
    local bit32_rshift_ret2 = bit32.rshift(p2, 16);
    local bit32_band_ret3 = bit32.band(bit32_rshift_ret2, 255);
    local bit32_rshift_ret3 = bit32.rshift(p2, 24);
    local bit32_band_ret4 = bit32.band(bit32_rshift_ret3, 255);

    return string.char(bit32_band_ret, bit32_band_ret2, bit32_band_ret3, bit32_band_ret4);
end;

function v1.SeedCombine32(p3: table, p4: table) -- Line: 22
    -- upvalues: HashLib (copy)
    local table_create_ret = table.create(#p4);

    for i, v in p4 do
        local bit32_band_ret = bit32.band(v, 255);
        local bit32_rshift_ret = bit32.rshift(v, 8);
        local bit32_band_ret2 = bit32.band(bit32_rshift_ret, 255);
        local bit32_rshift_ret2 = bit32.rshift(v, 16);
        local bit32_band_ret3 = bit32.band(bit32_rshift_ret2, 255);
        local bit32_rshift_ret3 = bit32.rshift(v, 24);
        local bit32_band_ret4 = bit32.band(bit32_rshift_ret3, 255);
        table_create_ret[i] = string.char(bit32_band_ret, bit32_band_ret2, bit32_band_ret3, bit32_band_ret4);
    end;

    local v5 = HashLib.sha256(table.concat(table_create_ret)):sub(1, 8);

    return tonumber(v5, 16);
end;

return v1;