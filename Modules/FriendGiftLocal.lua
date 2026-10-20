-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GameEvents = ReplicatedStorage.GameEvents;
local StarterGui = game:GetService("StarterGui");
local FriendGiftEvent = GameEvents.FriendGiftEvent;
local LocalPlayer = Players.LocalPlayer;
local Friend_Notification = LocalPlayer.PlayerGui:WaitForChild("Friend_Notification", 10);

local function WaitForChildChain(p1: userdata, p2: string) -- Line: 19
    for _, v in p2:split(".") do
        p1 = p1:WaitForChild(v);
    end;

    return p1;
end;

local v3 = Friend_Notification;
local u4 = {};

for _, v in ("Frame.Frame.Background.Holder.BodyLabel"):split(".") do
    Friend_Notification = Friend_Notification:WaitForChild(v);
end;

local v5 = v3;

for _, v in ("Frame.Frame.Background.Holder.Frame.Accept"):split(".") do
    v3 = v3:WaitForChild(v);
end;

local u6 = v5;

for _, v in ("Frame.Frame.Background.Holder.Frame.Decline"):split(".") do
    v5 = v5:WaitForChild(v);
end;

local u7 = {};
local u8 = nil;

local function UpdateFromQueue() -- Line: 38
    -- upvalues: u8 (ref), u7 (copy), Friend_Notification (copy), u6 (copy)
    print("EVENT FIRED 5");

    if u8 then
        return;
    end;

    local v9 = u7[1];
    u8 = v9;
    print("EVENT FIRED 6");
    Friend_Notification.Text = `Friend request from\n{v9.Name}`;
    print("EVENT FIRED 7");
    u6.Show_VAL.Value = true;
end;

function u4.DismissCurrent(p10) -- Line: 51
    -- upvalues: u7 (copy), u8 (ref), Friend_Notification (copy), u6 (copy)
    print("EVENT FIRED 1");
    local table_find_ret = table.find(u7, u8);

    if table_find_ret then
        table.remove(u7, table_find_ret);
    end;

    u8 = nil;

    if #u7 <= 0 then
        print("Hiding");
        u6.Show_VAL.Value = false;

        return;
    end;

    print("Trying to show next");
    print("EVENT FIRED 5");

    if u8 then
        return;
    end;

    local v11 = u7[1];
    u8 = v11;
    print("EVENT FIRED 6");
    Friend_Notification.Text = `Friend request from\n{v11.Name}`;
    print("EVENT FIRED 7");
    u6.Show_VAL.Value = true;
end;

function u4.AcceptCurrent(p12) -- Line: 70
    -- upvalues: u8 (ref), u4 (copy), StarterGui (copy)
    print("EVENT FIRED 2");
    local v13 = u8;
    u4:DismissCurrent();

    if not v13 then
        return;
    end;

    StarterGui:SetCore("PromptSendFriendRequest", v13);
end;

FriendGiftEvent.OnClientEvent:Connect(function(p14: userdata) -- Line: 81
    -- upvalues: LocalPlayer (copy), u7 (copy), u8 (ref), Friend_Notification (copy), u6 (copy)
    print("EVENT FIRED 3");

    if p14:IsFriendsWith(LocalPlayer.UserId) then
        return;
    end;

    if not table.find(u7, p14) then
        table.insert(u7, p14);
    end;

    print("EVENT FIRED 5");

    if u8 then
        return;
    end;

    local v15 = u7[1];
    u8 = v15;
    print("EVENT FIRED 6");
    Friend_Notification.Text = `Friend request from\n{v15.Name}`;
    print("EVENT FIRED 7");
    u6.Show_VAL.Value = true;
end);
v3.MouseButton1Click:Connect(function() -- Line: 94
    -- upvalues: u4 (copy)
    u4:AcceptCurrent();
end);
v5.MouseButton1Click:Connect(function() -- Line: 98
    -- upvalues: u4 (copy)
    u4:DismissCurrent();
end);

return u4;