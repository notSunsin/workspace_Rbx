-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.AchievementsData.Types);
local SeasonPassUtils = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassUtils);
workspace:GetServerTimeNow();
local CurrentSeason = SeasonPassUtils.GetCurrentSeason();
local u1 = nil;
local u2 = {};

local function LoadSeasonPassData() -- Line: 65
    -- upvalues: CurrentSeason (ref), SeasonPassUtils (copy), u2 (copy), u1 (ref)
    CurrentSeason = SeasonPassUtils.GetCurrentSeason();
    u2.CurrentSeason = CurrentSeason;

    if not CurrentSeason then
        u2.InfRewards = nil;
        u2.FreeRewards = nil;
        u2.PremiumRewards = nil;
        u2.IncludesItems = nil;
        u2.ShopItems = nil;

        return;
    end;

    local v3 = script:WaitForChild(`{CurrentSeason:gsub(" ", "")}Data`, 5);

    if not v3 then
        return;
    end;

    u1 = require(v3);
    u2.InfRewards = u1.InfRewards;
    u2.FreeRewards = u1.FreeRewards;
    u2.PremiumRewards = u1.PremiumRewards;
    u2.IncludesItems = u1.IncludesItems;
    u2.ShopItems = u1.ShopItems;
end;

function u2.SwitchToNewSeason() -- Line: 88
    -- upvalues: CurrentSeason (ref), SeasonPassUtils (copy), LoadSeasonPassData (copy)
    CurrentSeason = SeasonPassUtils.GetCurrentSeason();
    LoadSeasonPassData();
end;

function u2.GetSeasonPassData(p4: string) -- Line: 93
    if typeof(p4) ~= "string" then
        return {};
    end;

    local v5 = script:FindFirstChild((`{p4:gsub(" ", "")}Data`));

    if v5 then
        return require(v5);
    end;

    warn((`No season pass data found: {p4:gsub(" ", "")}Data`));

    return {};
end;

LoadSeasonPassData();

return u2;