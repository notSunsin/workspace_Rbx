-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local TradeEvents = ReplicatedStorage.GameEvents.TradeEvents;
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local Spring = require(ReplicatedStorage.Modules.Spring);
local FriendsAPI = require(ReplicatedStorage.Modules.FriendsAPI);
local LocalPlayer = Players.LocalPlayer;
local Gift_Notification = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Gift_Notification");
u1.PERMISSION_ATTRIBUTE = "TradeRequestPermission";

function u1.CanSendRequest(p2: table, p3: userdata) -- Line: 22
    -- upvalues: u1 (copy), FriendsAPI (copy), LocalPlayer (copy)
    local Attribute = p3:GetAttribute(u1.PERMISSION_ATTRIBUTE);

    if Attribute == "No one" then
        return false;
    end;

    return Attribute ~= "Friends" and true or FriendsAPI:IsFriendsWithImmediate(LocalPlayer, p3);
end;

function u1.SendRequest(p4: table, p5: userdata) -- Line: 35
    -- upvalues: TradeEvents (copy)
    TradeEvents.SendRequest:FireServer(p5);
end;

local function AnimateOut(p6) -- Line: 41
    -- upvalues: Spring (copy), Debris (copy)
    if not p6 or p6:HasTag("_fadingOut") then
        return;
    end;

    p6:AddTag("_fadingOut");
    local Canvas = p6.Wrapper.Canvas;
    Spring.target(p6.Wrapper.DropShadow, 1, 3, {
        ImageTransparency = 1
    });
    Spring.target(Canvas.UIStroke, 1, 3, {
        Transparency = 1
    });
    Spring.target(Canvas, 1, 3, {
        GroupTransparency = 1,
        Position = UDim2.fromScale(0.65, 0.5)
    });
    Debris:AddItem(p6, 1);
end;

TradeEvents.SendRequest.OnClientEvent:Connect(function(u7: any, p8: userdata, p9: number) -- Line: 57
    -- upvalues: TweenService (copy), Spring (copy), AnimateOut (copy), SetupButton (copy), TradeEvents (copy), Gift_Notification (copy)
    local v10 = p9 - workspace:GetServerTimeNow();
    local u11 = script.TradeRequest:Clone();
    local Canvas = u11.Wrapper.Canvas;
    local Main = Canvas.Segment.Main;
    local DropShadow = u11.Wrapper.DropShadow;
    local PLAYER_IMAGE = u11.Wrapper.Canvas.Segment.Main.Profile.Holder.PLAYER_IMAGE;
    u11.Wrapper.Canvas.Segment.Main.Timeout.Size = UDim2.fromScale(0, 1);
    PLAYER_IMAGE.Image = `rbxthumb://type=AvatarHeadShot&id={p8.UserId}&w=180&h=180`;
    Main.SENDER_NAME.Text = p8.Name;
    Main.SENDER_NAME_SHADOW.Text = p8.Name;
    Canvas.GroupTransparency = 1;
    u11.Wrapper.Position = UDim2.fromScale(0.65, 0.5);
    Canvas.UIStroke.Transparency = 1;
    Main.Timeout.Size = UDim2.fromScale(1, 0.05);
    DropShadow.ImageTransparency = 1;
    local BackgroundColor3 = Main.Timeout.BackgroundColor3;
    TweenService:Create(Main.Timeout, TweenInfo.new(v10, Enum.EasingStyle.Exponential), {
        BackgroundColor3 = BackgroundColor3:Lerp(Color3.new(1, 0, 0), 0.75),
        Size = UDim2.fromScale(0, 0.05)
    }):Play();
    Spring.target(DropShadow, 1, 3, {
        ImageTransparency = 0.6
    });
    Spring.target(Canvas.UIStroke, 1, 3, {
        Transparency = 0
    });
    Spring.target(Canvas, 1, 3, {
        GroupTransparency = 0
    });
    Spring.target(u11.Wrapper, 1, 3, {
        Position = UDim2.fromScale(0.5, 0.5)
    });
    task.delay(v10, function() -- Line: 92
        -- upvalues: AnimateOut (ref), u11 (copy)
        AnimateOut(u11);
    end);
    SetupButton({
        instance = u11.Wrapper.Canvas.Segment.Buttons.ACCEPT_BUTTON.Main.SENSOR,

        onclick = function() -- Line: 98, Name: onclick
            -- upvalues: AnimateOut (ref), u11 (copy), TradeEvents (ref), u7 (copy)
            AnimateOut(u11);
            TradeEvents.RespondRequest:FireServer(u7, true);
        end
    });
    SetupButton({
        instance = u11.Wrapper.Canvas.Segment.Buttons.DECLINE_BUTTON.Main.SENSOR,

        onclick = function() -- Line: 106, Name: onclick
            -- upvalues: AnimateOut (ref), u11 (copy), TradeEvents (ref), u7 (copy)
            AnimateOut(u11);
            TradeEvents.RespondRequest:FireServer(u7, false);
        end
    });
    u11.Parent = Gift_Notification.Frame;
end);

return u1;