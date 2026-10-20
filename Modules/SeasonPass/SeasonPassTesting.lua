-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);

local function DataChecker(p1: string) -- Line: 12
    -- upvalues: ReplicatedStorage (copy)
    local v2 = ReplicatedStorage.Data.SeasonPass.SeasonPassData[p1];

    if not v2 then
        return;
    end;

    local v3 = require(v2);
    local v4 = 0;

    for i, _ in v3.FreeRewards do
        local v5 = v3.PremiumRewards[i];

        if #v3.FreeRewards[i] == 0 then
            warn((`Missing free rewards at level {i}`));
        end;

        if #v5 == 0 then
            warn((`Missing premium rewards at level {i}`));
        end;

        v4 = v4 + 1;
    end;

    if v4 ~= 50 then
        warn("There aren\'t 50 levels");
    end;
end;

local function PassPointCounter(p6: string) -- Line: 37
    -- upvalues: ReplicatedStorage (copy), SeasonPassStaticData (copy)
    local v7 = ReplicatedStorage.Data.SeasonPass.SeasonPassData[p6];

    if not v7 then
        return;
    end;

    local v8 = require(v7);
    local v9 = 0;
    local v10 = 0;

    for i = 1, SeasonPassStaticData.MAX_LEVEL do
        for _, v in v8.FreeRewards[i] do
            if v.Type == "Currency" then
                v9 = v9 + v.Quantity;
            end;
        end;

        for _, v in v8.PremiumRewards[i] do
            if v.Type == "Currency" then
                v10 = v10 + v.Quantity;
            end;
        end;
    end;

    warn((`{p6} | Free Points: {v9}, Premium Points: {v10}, Total: {v9 + v10}`));
end;

return {};