-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.TeamEventHelper);
local Signal = require(ReplicatedStorage.Modules.Signal);
local TeamEventController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventController);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found");
local TeamEventParty = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("TeamEvents"):WaitForChild("TeamEventParty");
local InvitePlayer = TeamEventParty:WaitForChild("InvitePlayer");
local AcceptInvite = TeamEventParty:WaitForChild("AcceptInvite");
local OnInviteReceived = TeamEventParty:WaitForChild("OnInviteReceived");
local OnInviteResult = TeamEventParty:WaitForChild("OnInviteResult");
local RequestLeaveParty = TeamEventParty:WaitForChild("RequestLeaveParty");
local u1 = {
    InboundReceived = Signal.new(),
    InboundResolved = Signal.new(),
    OutboundChanged = Signal.new()
};
local u2 = {};

local function getOutbound(p3: string) -- Line: 40
    -- upvalues: u2 (copy)
    local v4 = u2[p3];

    if not v4 then
        v4 = {};
        u2[p3] = v4;
    end;

    return v4;
end;

function u1.HasOutboundInvite(p5: table, p6: any, p7: number) -- Line: 49
    -- upvalues: u2 (copy)
    local v8 = u2[p6];

    if not v8 then
        return false, nil;
    end;

    local v9 = v8[p7];

    if not v9 then
        return false, nil;
    end;

    if v9 > workspace:GetServerTimeNow() then
        return true, v9;
    end;

    v8[p7] = nil;

    return false, nil;
end;

function u1.GetOutbound(p10, p11) -- Line: 62
    -- upvalues: u2 (copy)
    return u2[p11] or {};
end;

function u1.GetTeamId(p12, p13) -- Line: 66
    -- upvalues: TeamEventController (copy), LocalPlayer (copy)
    return TeamEventController:GetTeamId(p13, LocalPlayer);
end;

function u1.GetTeamData(p14, p15) -- Line: 70
    -- upvalues: TeamEventController (copy)
    local TeamId = p14:GetTeamId(p15);

    if TeamId then
        return TeamEventController:GetTeamData(p15, TeamId);
    end;

    return nil;
end;

function u1.IsLocalCaptain(p16, p17) -- Line: 81
    -- upvalues: LocalPlayer (copy), Players (copy)
    local TeamData = p16:GetTeamData(p17);

    if not TeamData then
        return false;
    end;

    local v18 = 0;

    for _ in TeamData.members do
        v18 = v18 + 1;
    end;

    if v18 == 1 and TeamData.members[LocalPlayer.UserId] ~= nil then
        return true;
    end;

    if TeamData.metadata ~= nil and TeamData.metadata.captain == LocalPlayer.UserId then
        return true;
    end;

    if TeamData.members[LocalPlayer.UserId] ~= nil then
        local v19 = TeamData.metadata and TeamData.metadata.captain;

        if not v19 or Players:GetPlayerByUserId(v19) == nil then
            return true;
        end;
    end;

    return false;
end;

function u1.CanInvite(p20, p21) -- Line: 99
    return not p20:GetTeamId(p21) and true or p20:IsLocalCaptain(p21);
end;

function u1.Invite(p22: table, p23: any, p24: number) -- Line: 105
    -- upvalues: InvitePlayer (copy)
    InvitePlayer:FireServer(p23, p24);
end;

function u1.Accept(p25: table, p26: any, p27: number) -- Line: 112
    -- upvalues: AcceptInvite (copy)
    AcceptInvite:FireServer(p26, p27, false);
end;

function u1.Decline(p28: table, p29: any, p30: number) -- Line: 116
    -- upvalues: AcceptInvite (copy)
    AcceptInvite:FireServer(p29, p30, true);
end;

function u1.LeaveParty(p31, u32) -- Line: 120
    -- upvalues: ConfirmationPromptController (copy), RequestLeaveParty (copy)
    local v33 = "Your points toward today\'s goal will reset. Rewards you\'ve already earned are kept.";
    local TeamData = p31:GetTeamData(u32);
    local v34 = 0;

    if TeamData and type(TeamData.members) == "table" then
        for _ in TeamData.members do
            v34 = v34 + 1;
        end;
    end;

    if v34 > 1 and p31:IsLocalCaptain(u32) then
        v33 = v33 .. " Party leadership will pass to one of your teammates.";
    end;

    ConfirmationPromptController:Open({
        Title = "Leave Event Party",
        Header = "Leaving your event party",
        Footer = "Are you sure?",
        ConfirmText = "Leave",
        RejectText = "Cancel",
        Middle = v33
    }, {
        ConfirmCallback = function() -- Line: 140, Name: ConfirmCallback
            -- upvalues: RequestLeaveParty (ref), u32 (copy)
            RequestLeaveParty:FireServer(u32);
        end
    });
end;

OnInviteReceived.OnClientEvent:Connect(function(p35: string, p36: number, p37: string, p38: number) -- Line: 148
    -- upvalues: u1 (copy)
    u1.InboundReceived:Fire(p35, p36, p37, p38);
end);
OnInviteResult.OnClientEvent:Connect(function(p39: string, u40: number, p41: string, u42: number?) -- Line: 152
    -- upvalues: u2 (copy), u1 (copy)
    local u43 = u2[p39];

    if not u43 then
        u43 = {};
        u2[p39] = u43;
    end;

    if p41 ~= "sent" or not u42 then
        u43[u40] = nil;
        u1.OutboundChanged:Fire();

        return;
    end;

    u43[u40] = u42;
    u1.OutboundChanged:Fire();
    local task_delay = task.delay;
    local v44 = u42 - workspace:GetServerTimeNow();
    task_delay(math.max(0, v44), function() -- Line: 158
        -- upvalues: u43 (copy), u40 (copy), u42 (copy), u1 (ref)
        if u43[u40] == u42 then
            u43[u40] = nil;
            u1.OutboundChanged:Fire();
        end;
    end);
end);

return u1;