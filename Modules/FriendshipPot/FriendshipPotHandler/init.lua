-- Decompiled with Potassium's decompiler.

local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");
local Players = game:GetService("Players");
local FriendshipPotToolService_RE = GameEvents:WaitForChild("FriendshipPotToolService_RE");
local FriendPotLink_RE = GameEvents:WaitForChild("FriendPotLink_RE");
local FriendPotLinkEnded_RE = GameEvents:WaitForChild("FriendPotLinkEnded_RE");
local script_Gift_Notification = script.Gift_Notification;
local Gift_Notification = Players.LocalPlayer.PlayerGui:WaitForChild("Gift_Notification");
local u1 = {};
FriendPotLink_RE.OnClientEvent:Connect(function(p2: string, p3: string, u4: string, p5: string) -- Line: 22
    -- upvalues: Players (copy), script_Gift_Notification (copy), u1 (copy), Gift_Notification (copy), FriendshipPotToolService_RE (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p2);
    Players:GetPlayerByUserId(p3);
    local u6 = script_Gift_Notification:Clone();
    u1[u4] = u6;
    u6.Parent = Gift_Notification.Frame;
    u6.Holder.Notification_UI.TextLabel.Text = "Friend Pot from @" .. PlayerByUserId.Name;
    u6.Holder.TextLabel.Text = p5;
    u6.Holder.Frame.Accept.MouseButton1Click:Connect(function() -- Line: 34
        -- upvalues: u6 (copy), FriendshipPotToolService_RE (ref), u4 (copy)
        u6:Destroy();
        FriendshipPotToolService_RE:FireServer("AcceptTrade", u4);
    end);
    u6.Holder.Frame.Decline.MouseButton1Click:Connect(function() -- Line: 39
        -- upvalues: u6 (copy), FriendshipPotToolService_RE (ref), u4 (copy)
        u6:Destroy();
        FriendshipPotToolService_RE:FireServer("CancelTrade", u4);
    end);
end);
FriendPotLinkEnded_RE.OnClientEvent:Connect(function(p7: string, p8: string, p9: string) -- Line: 46
    -- upvalues: u1 (copy)
    local v10 = u1[p9];

    if not v10 then
        return;
    end;

    v10:Destroy();
end);

return {};