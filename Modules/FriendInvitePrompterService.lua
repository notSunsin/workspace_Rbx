-- Decompiled with Potassium's decompiler.

local SocialService = game:GetService("SocialService");
local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FriendInvitePrompterService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("FriendInvitePrompterService");
local LocalPlayer = Players.LocalPlayer;
local FriendInvites = LocalPlayer.PlayerGui:WaitForChild("FriendInvites");
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local SetupHoverAnimations = require(ReplicatedStorage.Modules.SetupHoverAnimations);
local SetupSounds = require(ReplicatedStorage.Modules.SetupSounds);
local u1 = {
    CanSendGameInvite = false
};

local function CanSendGameInvite(u2: userdata) -- Line: 23
    -- upvalues: SocialService (copy)
    local success, result = pcall(function() -- Line: 24
        -- upvalues: SocialService (ref), u2 (copy)
        return SocialService:CanSendGameInviteAsync(u2);
    end);

    return success and result;
end;

task.spawn(function() -- Line: 30
    -- upvalues: u1 (copy), LocalPlayer (copy), SocialService (copy)
    local u3 = LocalPlayer;
    local success, result = pcall(function() -- Line: 24
        -- upvalues: SocialService (ref), u3 (copy)
        return SocialService:CanSendGameInviteAsync(u3);
    end);
    u1.CanSendGameInvite = success and result;
end);

function u1.CreatePrompt(p4) -- Line: 34
    -- upvalues: u1 (copy), FriendInvites (copy), WaitForDescendant (copy), SetupHoverAnimations (copy), SetupSounds (copy), TweenService (copy), SocialService (copy), LocalPlayer (copy)
    if not u1.CanSendGameInvite then
        return warn("Cannot send game invite!");
    end;

    local InsertionPoint = FriendInvites:FindFirstChild("InsertionPoint");

    if not InsertionPoint then
        return;
    end;

    local u5 = InsertionPoint.FriendInviteTemplate:Clone();
    local UIScale = u5.UIScale;
    UIScale.Scale = 0;
    local v6 = WaitForDescendant(u5, "ACCEPT_BUTTON");
    local v7 = WaitForDescendant(u5, "DECLINE_BUTTON");
    SetupHoverAnimations(v6);
    SetupHoverAnimations(v7);
    local v8 = SetupSounds(v7);

    local function Remove() -- Line: 54
        -- upvalues: TweenService (ref), UIScale (copy), u5 (copy)
        local v9 = TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 0
        });
        v9:Play();
        v9.Completed:Once(function() -- Line: 60
            -- upvalues: u5 (ref)
            u5:Destroy();
        end);
    end;

    SetupSounds(v6).MouseButton1Click:Connect(function() -- Line: 65
        -- upvalues: Remove (copy), SocialService (ref), LocalPlayer (ref)
        Remove();
        SocialService:PromptGameInvite(LocalPlayer);
    end);
    v8.MouseButton1Click:Connect(function() -- Line: 70
        -- upvalues: Remove (copy)
        Remove();
    end);
    u5.Visible = true;
    u5.Parent = InsertionPoint;
    TweenService:Create(UIScale, TweenInfo.new(0.5), {
        Scale = 1
    }):Play();
end;

local u10 = { "CreatePrompt" };
FriendInvitePrompterService.OnClientEvent:Connect(function(p11, ...) -- Line: 86
    -- upvalues: u10 (copy), u1 (copy)
    if not table.find(u10, p11) then
        return;
    end;

    local v12 = u1[p11];

    if not v12 then
        return;
    end;

    v12(u1, ...);
end);

return u1;