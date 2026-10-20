-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local WeightRandom = require(ReplicatedStorage.Modules.WeightRandom);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.InfinitePackData.InfinitePackTypes);
local _ = script.EventPacks;

local function ReturnNil() -- Line: 16
    return nil;
end;

local script_EventInfinitePackProductIds = require(script.EventInfinitePackProductIds);

local function GetCurrentPackRewardData() -- Line: 23
    return nil;
end;

local function GetProductFor(p1: number) -- Line: 36
    -- upvalues: script_EventInfinitePackProductIds (copy)
    if p1 == 1 then
        return nil;
    end;

    if p1 ~= 2 and math.max(p1 - 2, 0) % 5 ~= 0 then
        return nil;
    end;

    for _, v in script_EventInfinitePackProductIds do
        if p1 < v[2] then
            return v[1];
        end;
    end;

    return nil;
end;

return {
    ReplaceNormalPack = false,
    CurrentPack = nil,
    Rewards = nil,

    GetRewards = function(p2: userdata, p3: number, p4: number) -- Line: 58, Name: GetRewards
        -- upvalues: script_EventInfinitePackProductIds (copy), WeightRandom (copy)
        local Random_new_ret = Random.new((bit32.bxor(p3, p2.UserId)));
        local v5 = nil;

        if not v5 then
            error((`EventInfinitePackData:GetCurrentPackRewardData() | Event Infinite Pack "{nil}" not found`));

            return {};
        end;

        local v6 = {};

        for i = 1, p4 do
            local v7 = {};
            local v8, v9;

            if i == 1 or i ~= 2 and math.max(i - 2, 0) % 5 ~= 0 then
                v8 = i;
                v9 = nil;
            else
                v8 = i;
                v9 = nil;

                for _, v in script_EventInfinitePackProductIds do
                    if v8 < v[2] then
                        v9 = v[1];
                        break;
                    end;
                end;
            end;

            local v10;

            if v9 then
                v10 = v5.Paid;
            else
                v10 = v5.Free;
            end;

            local v11 = WeightRandom.array(v10, Random_new_ret);
            table.insert(v7, v11);
            v6[v8] = {
                Rewards = v7,
                ProductId = v9
            };
        end;

        return v6;
    end,

    FallbackPrices = {
        [3425555547] = 37,
        [3425556327] = 99,
        [3425557211] = 175,
        [3425557487] = 375,
        [3425557881] = 495
    }
};