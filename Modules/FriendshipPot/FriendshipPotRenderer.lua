-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local StarterGui = game:GetService("StarterGui");
local SocialService = game:GetService("SocialService");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local FriendshipPots = Assets:WaitForChild("Models"):WaitForChild("FriendshipPots");
local _ = Assets.SFX;
local _ = Assets.VFX;
require(ReplicatedStorage.Modules.TweenModel);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.FriendshipPots);
local FriendInvitePrompterService = require(ReplicatedStorage.Modules.FriendInvitePrompterService);
local FriendsAPI = require(ReplicatedStorage.Modules.FriendsAPI);
local FriendshipPotService_RE = ReplicatedStorage.GameEvents.FriendshipPotService_RE;
local u1 = {};
local LocalPlayer = game.Players.LocalPlayer;
local u2 = {};
local Value = ReplicatedFirst.DayInSeconds.Value;

function u1.UpdatePot(p3: table, p4: userdata) -- Line: 40
    -- upvalues: u2 (copy), Value (copy), Players (copy), FriendsAPI (copy), LocalPlayer (copy), FriendInvitePrompterService (copy)
    debug.traceback("Trace");

    if not p4 then
        return;
    end;

    local v5 = u2[p4];

    if not v5 then
        return;
    end;

    local Asset = v5.Asset;

    if not Asset then
        return;
    end;

    local Grow = Asset:FindFirstChild("Grow");

    if not Grow then
        return;
    end;

    local Age = Grow:FindFirstChild("Age");

    if not Age then
        return;
    end;

    local Attribute = p4:GetAttribute("CurrentStreak");

    if not Attribute then
        return;
    end;

    local Attribute2 = p4:GetAttribute("LastTendTime");

    if not Attribute2 then
        return;
    end;

    local Attribute3 = p4:GetAttribute("LastStreakTime");

    if not Attribute3 then
        return;
    end;

    local Attribute4 = p4:GetAttribute("LinkedPlayerID");

    if not Attribute4 then
        return;
    end;

    local Attribute5 = p4:GetAttribute("OWNER");

    if not Attribute5 then
        return;
    end;

    local v6 = p4:GetAttribute("StreakFailTime") or 0;
    local v7 = workspace:GetServerTimeNow() / Value;
    local math_floor_ret = math.floor(v7);
    local math_floor_ret2 = math.floor(Attribute2 / Value);
    local math_floor_ret3 = math.floor(Attribute3 / Value);
    local RestorePrompt = u2[p4].RestorePrompt;
    local math_floor_ret4 = math.floor(v6 / Value);
    local v8;

    if math_floor_ret3 > 0 then
        v8 = math_floor_ret3 + 1 < math_floor_ret;
    else
        v8 = false;
    end;

    local v9;

    if math_floor_ret4 > 0 then
        v9 = math_floor_ret <= math_floor_ret4 + 1;
    else
        v9 = false;
    end;

    if RestorePrompt then
        RestorePrompt.Enabled = v8 and v9;
    end;

    local TendPrompt = u2[p4].TendPrompt;

    if TendPrompt then
        local v10 = Players:FindFirstChild(Attribute5);

        if math_floor_ret2 == math_floor_ret then
            v10 = false;
        elseif v10 then
            v10 = FriendsAPI:IsFriendsWithImmediate(LocalPlayer, v10);
        end;

        TendPrompt.Enabled = v10;
    end;

    local InteractionPrompt = u2[p4].InteractionPrompt;

    if InteractionPrompt then
        local v11 = nil;
        local PlayerByUserId = Players:GetPlayerByUserId(Attribute4);
        local v12;

        if PlayerByUserId or not (FriendsAPI:IsFriendsWithImmediate(LocalPlayer, Attribute4) and (FriendInvitePrompterService.CanSendGameInvite and math_floor_ret ~= math_floor_ret2)) then
            v12 = PlayerByUserId and not FriendsAPI:IsFriendsWithImmediate(LocalPlayer, Attribute4) and "Friend" or v11;
        else
            local Attribute6 = p4:GetAttribute("LinkedPlayerID_NAME");
            v12 = (not Attribute6 or Attribute6 == "UNKNOWN") and "Invite" or "Invite " .. Attribute6;
        end;

        if v12 then
            InteractionPrompt.ActionText = v12;
            InteractionPrompt.Enabled = true;
        else
            InteractionPrompt.Enabled = false;
        end;
    end;

    Age.Value = Attribute;
end;

function u1.UpdateAllPots(p13) -- Line: 122
    -- upvalues: u2 (copy), u1 (copy)
    for i, _ in u2 do
        u1:UpdatePot(i);
    end;
end;

function u1.PotMoved(p14: table, p15: userdata) -- Line: 129
    -- upvalues: u2 (copy)
    if not p15 then
        return;
    end;

    local v16 = u2[p15];

    if not v16 then
        return;
    end;

    local Asset = v16.Asset;

    if not Asset then
        return;
    end;

    local Pivot = p15:GetPivot();
    local Pivot2 = Asset:GetPivot();
    Asset:PivotTo(CFrame.new(Pivot.X, Pivot2.Y, Pivot.Z) * Pivot.Rotation);
end;

function u1.RenderPot(p17: table, u18: userdata) -- Line: 144
    -- upvalues: FriendshipPots (copy), RunService (copy), TweenService (copy), u2 (copy), LocalPlayer (copy), FriendshipPotService_RE (copy), Value (copy), Players (copy), FriendsAPI (copy), FriendInvitePrompterService (copy), SocialService (copy), StarterGui (copy), u1 (copy)
    if not u18:GetAttribute("READY") then
        u18:GetAttributeChangedSignal("READY"):Wait();
    end;

    local Attribute = u18:GetAttribute("PotType");

    if not Attribute then
        local v19 = 0;

        repeat
            task.wait(0.5);
            Attribute = u18:GetAttribute("PotType");
            v19 = v19 + 1;
        until v19 >= 5 or Attribute;
    end;

    if not Attribute then
        return;
    end;

    local v20 = FriendshipPots:FindFirstChild(Attribute);

    if not v20 then
        return warn((`Could not find Pot model associated with {Attribute}`));
    end;

    local u21 = v20:Clone();
    u21.PrimaryPart.Anchored = true;
    local u22 = Vector3.new(0, 0, 0);
    task.spawn(function() -- Line: 173
        -- upvalues: RunService (ref), TweenService (ref), u22 (ref), u21 (copy), u18 (copy)
        local v23 = 0;

        while v23 < 0.25 do
            v23 = v23 + RunService.RenderStepped:Wait();
            u22 = (Vector3.new(0, 3, 0)):Lerp(Vector3.new(0, 0, 0), (TweenService:GetValue(v23 / 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)));
            local Y = u21:GetExtentsSize().Y;
            u21:PivotTo(u18:GetPivot() * CFrame.new(0, u22.Y + Y * 0.5, 0));
        end;

        local Generate = u21:FindFirstChild("Generate");

        if Generate then
            Generate.Enabled = true;
        end;
    end);
    u2[u18] = {
        Asset = u21
    };
    local Y = u21:GetExtentsSize().Y;
    u21:PivotTo(u18:GetPivot() * CFrame.new(0, u22.Y + Y * 0.4, 0));
    u21.Parent = u18;

    if u18:GetAttribute("LinkedPlayerID") == LocalPlayer.UserId then
        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.Name = "TendPrompt";
        ProximityPrompt.Parent = u21.PrimaryPart;
        ProximityPrompt.ActionText = "Tend!";
        ProximityPrompt.HoldDuration = 1;
        ProximityPrompt.Enabled = true;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
        ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
        ProximityPrompt.Triggered:Connect(function() -- Line: 217
            -- upvalues: FriendshipPotService_RE (ref), u18 (copy)
            FriendshipPotService_RE:FireServer("TendPot", u18);
        end);
        u2[u18].TendPrompt = ProximityPrompt;
    end;

    if u18:GetAttribute("OWNER") == LocalPlayer.Name then
        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.Name = "InteractionPrompt";
        ProximityPrompt.ActionText = "???";
        ProximityPrompt.HoldDuration = 1;
        ProximityPrompt.Enabled = false;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
        ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(0, 2.6, 0);
        Attachment.Parent = u21.PrimaryPart;
        ProximityPrompt.Parent = Attachment;
        ProximityPrompt.Triggered:Connect(function() -- Line: 239
            -- upvalues: u18 (copy), Value (ref), Players (ref), FriendsAPI (ref), LocalPlayer (ref), FriendInvitePrompterService (ref), SocialService (ref), StarterGui (ref)
            local Attribute2 = u18:GetAttribute("LinkedPlayerID");

            if not Attribute2 then
                return;
            end;

            local Attribute3 = u18:GetAttribute("LastTendTime");

            if not Attribute3 then
                return;
            end;

            local v24 = workspace:GetServerTimeNow() / Value;
            local math_floor_ret = math.floor(v24);
            local math_floor_ret2 = math.floor(Attribute3 / Value);
            local PlayerByUserId = Players:GetPlayerByUserId(Attribute2);

            if PlayerByUserId or not (FriendsAPI:IsFriendsWithImmediate(LocalPlayer, Attribute2) and (FriendInvitePrompterService.CanSendGameInvite and math_floor_ret ~= math_floor_ret2)) then
                if PlayerByUserId and not FriendsAPI:IsFriendsWithImmediate(LocalPlayer, Attribute2) then
                    pcall(function() -- Line: 269
                        -- upvalues: StarterGui (ref), PlayerByUserId (copy)
                        StarterGui:SetCore("PromptSendFriendRequest", PlayerByUserId);
                    end);
                end;

                return;
            end;

            local Attribute4 = u18:GetAttribute("LinkedPlayerID_NAME");
            local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
            ExperienceInviteOptions.InviteUser = Attribute2;
            ExperienceInviteOptions.PromptMessage = (not Attribute4 or Attribute4 == "UNKNOWN") and "Invite your friend to Tend your pot" or `Invite {Attribute4} to Tend your pot`;
            pcall(function() -- Line: 266
                -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
                SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
            end);
        end);
        u2[u18].InteractionPrompt = ProximityPrompt;
    end;

    if u18:GetAttribute("OWNER") == LocalPlayer.Name then
        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.Name = "RestorePrompt";
        ProximityPrompt.ActionText = "Restore Streak!";
        ProximityPrompt.HoldDuration = 1;
        ProximityPrompt.Enabled = false;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
        ProximityPrompt.Parent = u21.PrimaryPart;
        ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
        ProximityPrompt.Triggered:Connect(function() -- Line: 288
            -- upvalues: FriendshipPotService_RE (ref), u18 (copy)
            FriendshipPotService_RE:FireServer("TryRestoreStreak", u18);
        end);
        u2[u18].RestorePrompt = ProximityPrompt;
    end;

    u2[u18].AttribConnection = u18.AttributeChanged:Connect(function(p25) -- Line: 294
        -- upvalues: u1 (ref), u18 (copy)
        if p25 ~= "CurrentStreak" and (p25 ~= "LastTendTime" and (p25 ~= "LastStreakTime" and (p25 ~= "StreakFailTime" and (p25 ~= "LinkedPlayerID" and p25 ~= "LinkedPlayerID_NAME")))) then
            return;
        end;

        u1:UpdatePot(u18);
    end);
    u2[u18].PlayerAddedConnection = Players.PlayerAdded:Connect(function() -- Line: 311
        -- upvalues: u1 (ref), u18 (copy)
        u1:UpdatePot(u18);
    end);
    u2[u18].PlayerRemovingConnection = Players.PlayerRemoving:Connect(function(p26: userdata) -- Line: 314
        -- upvalues: Players (ref), u1 (ref), u18 (copy)
        while p26:IsDescendantOf(Players) do
            task.wait();
        end;

        u1:UpdatePot(u18);
    end);
    u2[u18].FriendUpdatedConnection = FriendsAPI:OnFriendshipUpdate(LocalPlayer, function() -- Line: 323
        -- upvalues: u1 (ref), u18 (copy)
        u1:UpdatePot(u18);
    end);
    u1:UpdatePot(u18);
end;

function u1.DerenderPot(p27: table, p28: userdata) -- Line: 330
    -- upvalues: u2 (copy)
    if not p28 then
        warn("FriendshipPotRenderer:DerenderPot | No server Pot to derender");

        return;
    end;

    local v29 = u2[p28];

    if not v29 then
        warn("FriendshipPotRenderer:DerenderPot | No state data for server Pot");

        return;
    end;

    if v29.Asset then
        v29.Asset:Destroy();
    end;

    if v29.AttribConnection then
        v29.AttribConnection:Disconnect();
    end;

    if v29.PlayerAddedConnection then
        v29.PlayerAddedConnection:Disconnect();
    end;

    if v29.PlayerRemovingConnection then
        v29.PlayerRemovingConnection:Disconnect();
    end;

    if v29.FriendUpdatedConnection then
        v29.FriendUpdatedConnection:Disconnect();
    end;

    u2[p28] = nil;
end;

CreateTagHandler({
    Tag = "FriendshipPotServer",

    OnInstanceAdded = function(p30: userdata) -- Line: 361, Name: OnInstanceAdded
        -- upvalues: u1 (copy)
        if not p30:IsDescendantOf(workspace) then
            return;
        end;

        u1:RenderPot(p30);
    end,

    OnInstanceRemoved = function(p31) -- Line: 365, Name: OnInstanceRemoved
        -- upvalues: u1 (copy)
        u1:DerenderPot(p31);
    end
});
local u32 = { "UpdateAllPots", "PotMoved" };
FriendshipPotService_RE.OnClientEvent:Connect(function(p33, ...) -- Line: 373
    -- upvalues: u32 (copy), u1 (copy)
    if not table.find(u32, p33) then
        return;
    end;

    local v34 = u1[p33];

    if not v34 then
        return;
    end;

    v34(u1, ...);
end);

return u1;