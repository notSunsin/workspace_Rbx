-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Data.Events.PrehistoricEvent.PrehistoricEventConfig);
local u1 = nil;

if RunService:IsServer() then
    u1 = require(ServerScriptService.Modules.GameConfigService);
elseif RunService:IsClient() then
    u1 = require(ReplicatedStorage.Modules.GameConfigController);
end;

local u2 = u1 and u1:GetConfig("PrehistoricEventConfig");
workspace:GetAttributeChangedSignal("PrehistoricEventConfig"):Connect(function() -- Line: 17
    -- upvalues: u2 (ref), u1 (ref)
    local v3 = u1 and u1:GetConfig("PrehistoricEventConfig");
    u2 = v3;
end);
local u7 = {
    NormalizeOdds = function(p4, p5) -- Line: 23, Name: NormalizeOdds
        local PossibleRewards = p5.PossibleRewards;
        local v6 = 0;

        for _, v in PossibleRewards do
            v6 = v6 + v.RewardOdd;
        end;

        for _, v in PossibleRewards do
            v.NormalizedOdd = v.RewardOdd / v6 * 100;
        end;

        p5.TotalOdds = v6;
    end
};

function u7.GenerateReward(p8: table, p9: number, p10: number?) -- Line: 38
    -- upvalues: u2 (ref), u7 (copy)
    local v11 = 0;
    local v12 = nil;

    for _, v in u2.RewardTable do
        if v.RequiredPoints <= p9 and v11 < v.RequiredPoints then
            v11 = v.RequiredPoints;
            v12 = v;
        end;
    end;

    if not v12 then
        warn("PrehistoricEventUtils:GenerateReward | Could not find valid reward data ");

        return nil;
    end;

    if not v12.TotalOdds then
        u7:NormalizeOdds(v12);
    end;

    local v13 = not v12.TotalOdds and 1 or v12.TotalOdds;
    local v14 = math.random() * v13;
    local v15 = 0;

    for _, v in v12.PossibleRewards do
        v15 = v15 + v.RewardOdd;

        if v15 >= v14 then
            local v16 = v.RewardAmount or 1;
            local _ = p10 and (p10 >= 1 and (v.RewardName == "Dinosaur Egg" and math.random() < 0.5));

            if p10 and (p10 >= 3 and v.RewardType == "Egg") then
                local _ = v16 + 1;
            end;

            return {
                RewardName = v.RewardName,
                RewardType = v.RewardType,
                RewardAmount = v.RewardAmount or 1,
                RewardOdd = v.RewardOdd,
                NormalizedOdd = v.NormalizedOdd
            };
        end;
    end;

    return nil;
end;

return u7;