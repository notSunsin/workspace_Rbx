-- Decompiled with Potassium's decompiler.

local game_ReplicatedStorage = game.ReplicatedStorage;
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local _ = game.Players.LocalPlayer;
local LoadingScreen = require(script.Parent.Parent.LoadingScreen);
require(game_ReplicatedStorage.Field_Of_View_Module);
local u1 = setmetatable({}, LoadingScreen);
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: LoadingScreen (copy), u1 (copy)
    local v3 = LoadingScreen.new(p2);
    local v4 = setmetatable(v3, u1);
    v4.bgFrame = v4.gui.Variant4Frame;
    v4.mainFrame = v4.bgFrame.InnerFrame;

    return v4;
end;

function u1.fillLogo(p5, p6) -- Line: 27
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    TweenService:Create(p5.mainFrame.LogoCG.UIGradient, TweenInfo_new_ret, {
        Offset = Vector2.new(0, 0)
    }):Play();
end;

function u1.hideFrame(p7) -- Line: 32
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In);
    local v8 = TweenService:Create(p7.mainFrame, TweenInfo_new_ret, {
        Position = UDim2.new(0, 0, 1, 0)
    });
    v8:Play();
    p7:changeAllTransparency(1, 1);
    v8.Completed:Wait();
end;

function u1.startLoading(p9) -- Line: 43
    -- upvalues: UserInputService (copy)
    p9:startTransparentBGfx();
    p9:hideGuis();
    p9.gui.Enabled = true;
    p9.bgFrame.Visible = true;
    task.wait(1);
    p9:fillLogo(5);
    p9:startTipCycle(7);
    p9:startCounter(5);
    p9.counterFinishedEvent.Event:Wait();
    p9:fadeUpdateText(p9.mainFrame.CounterTxt, "<font color=\'#FFFF00\'>[Click Anywhere to Play]</font>", 0.6);
    UserInputService.InputBegan:Wait();
    p9:endTipCycle();
    p9:hideFrame();
    p9:endTransparentBGfx();
    p9:showGuis();
    p9:finishedLoading();
end;

return u1;