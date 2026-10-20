-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.TeamEventHelper);
local Signal = require(ReplicatedStorage.Modules.Signal);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local UpdateTeamDataRE = GameEvents.TeamEvents.UpdateTeamDataRE;
GameEvents:WaitForChild("TeamEvents");
local IsInTradeWorld = require(ReplicatedStorage.Modules.IsInTradeWorld);
assert(game.Players.LocalPlayer, "LocalPlayer not found");
local u1 = {
    DataUpdated = Signal.new()
};
local u2 = nil;

local function NormalizeTeam(p3) -- Line: 40
    if p3.members then
        local v4 = {};

        for i, v in p3.members do
            local v5 = tonumber(i);

            if v5 then
                v4[v5] = v;
            end;
        end;

        p3.members = v4;
    end;

    if p3.metadata and p3.metadata.captain ~= nil then
        p3.metadata.captain = tonumber(p3.metadata.captain) or p3.metadata.captain;
    end;
end;

local function UpdateCachedData(p6) -- Line: 55
    -- upvalues: u2 (ref), NormalizeTeam (copy), u1 (copy)
    if type(p6) == "table" then
        if not u2 then
            u2 = {};
        end;

        for i, v in p6 do
            for _, v2 in v do
                NormalizeTeam(v2);
            end;

            u2[i] = v;
        end;
    end;

    u1.DataUpdated:Fire();
end;

function u1.GetCachedData(p7) -- Line: 71
    -- upvalues: u2 (ref)
    return u2;
end;

function u1.GetTeamId(p8: table, p9: any, p10: userdata) -- Line: 75
    -- upvalues: u2 (ref)
    local v11 = u2 and u2[p9];

    if not v11 then
        return nil;
    end;

    for i, v in v11 do
        if v.members[p10.UserId] ~= nil then
            return i;
        end;
    end;

    return nil;
end;

function u1.GetTeamData(p12: table, p13: any, p14: string) -- Line: 89
    -- upvalues: u2 (ref)
    local v15 = u2 and u2[p13];

    if v15 then
        return v15[p14];
    end;

    return nil;
end;

function Init()
    -- upvalues: IsInTradeWorld (copy), UpdateTeamDataRE (copy), UpdateCachedData (copy)
    if IsInTradeWorld then
        return;
    end;

    UpdateTeamDataRE.OnClientEvent:Connect(UpdateCachedData);
end;

task.spawn(Init);

return u1;