-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Data.DefaultData);
local RebirthConfigData = require(ReplicatedStorage.Data.RebirthConfigData);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local u1;

if RunService:IsServer() then
    u1 = require(game:GetService("ServerScriptService").Modules.DataService);
else
    u1 = require(ReplicatedStorage.Modules.DataService);
end;

local LocalPlayer = Players.LocalPlayer;
local u2 = RunService:IsServer();
RunService:IsStudio();
local v3 = {};

local function GetPlayerData(p4: userdata) -- Line: 19
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy)
    if u2 then
        return u1:GetPlayerData(p4);
    end;

    if p4 == LocalPlayer then
        return u1:GetData();
    end;

    return nil;
end;

function v3.IsRebirthAvailable(p5: table, p6: userdata) -- Line: 31
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), RebirthConfigData (copy)
    local v7;

    if u2 then
        v7 = u1:GetPlayerData(p6);
    elseif p6 == LocalPlayer then
        v7 = u1:GetData();
    else
        v7 = nil;
    end;

    if v7 then
        return v7.RebirthData.LastRebirthTime + RebirthConfigData.RESET_TIME <= workspace:GetServerTimeNow();
    end;

    warn((`RebirthShared:IsRebirthAvailable | Cannot find Player Data for {p6}`));

    return false;
end;

function v3.CalculatePrice(p8: table, p9: number, p10: userdata?) -- Line: 49
    -- upvalues: RebirthUnlocksSharedService (copy), RebirthConfigData (copy)
    if p10 and (RebirthUnlocksSharedService:HasBeenAssignedABTest(p10) and p9 <= 6) then
        return RebirthConfigData.REBIRTH_AB_TEST_PRICES[p9];
    end;

    return RebirthConfigData.REBIRTH_PRICE + RebirthConfigData.REBIRTH_PRICE_INCREASE * p9;
end;

return v3;