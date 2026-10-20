-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local u1 = RunService:IsServer();
local u2;

if u1 then
    local ServerScriptService = game:GetService("ServerScriptService");
    u2 = require(ServerScriptService.Modules.DataService);
else
    u2 = require(ReplicatedStorage.Modules.DataService);
end;

local u3 = {
    REQUIRED_CONTRIBUTIONS = 7,
    REQUIRED_FENCE_CONTRIBUTIONS = 12
};

local function GetPlayerData(p4: userdata) -- Line: 24
    -- upvalues: u1 (copy), u2 (ref), Players (copy)
    if u1 then
        return u2:GetPlayerDataAsync(p4);
    end;

    if p4 == Players.LocalPlayer then
        return u2:GetData();
    end;

    error("BeanstalkPermissionModule | GetPlayerData | Tried to access non-local playerdata from client");

    return nil;
end;

function u3.GetPlayerContributions(p5: table, p6: userdata) -- Line: 39
    -- upvalues: u1 (copy), u2 (ref), Players (copy)
    local v7;

    if u1 then
        v7 = u2:GetPlayerDataAsync(p6);
    elseif p6 == Players.LocalPlayer then
        v7 = u2:GetData();
    else
        error("BeanstalkPermissionModule | GetPlayerData | Tried to access non-local playerdata from client");
        v7 = nil;
    end;

    return v7 and (v7.BeanstalkEvent.EventsContributed or 0) or 0;
end;

function u3.CanSeeBeanstalkPortal(p8: table, p9: userdata) -- Line: 47
    return workspace:GetAttribute("ActivateBeanstalk") and true or false;
end;

function u3.CanUseBeanstalkPortal(p10: table, p11: userdata) -- Line: 56
    -- upvalues: u3 (copy)
    if u3:CanSeeBeanstalkPortal(p11) then
        return u3:GetPlayerContributions(p11) >= u3.REQUIRED_CONTRIBUTIONS;
    end;

    return false;
end;

function u3.CanClaimFence(p12: table, p13: userdata) -- Line: 66
    -- upvalues: u3 (copy)
    if u3:CanSeeBeanstalkPortal(p13) then
        return u3:GetPlayerContributions(p13) >= u3.REQUIRED_FENCE_CONTRIBUTIONS;
    end;

    return false;
end;

return u3;