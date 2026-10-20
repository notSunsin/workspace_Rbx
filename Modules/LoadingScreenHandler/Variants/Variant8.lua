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
    v4.bgFrame = v4.gui.Variant3Frame;
    v4.mainFrame = v4.bgFrame.InnerFrame;

    return v4;
end;

function u1.revealLogo(p5) -- Line: 27
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Linear);
    TweenService:Create(p5.mainFrame.LogoImg, TweenInfo_new_ret, {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(p5.mainFrame.LogoImg.FruitImg, TweenInfo_new_ret, {
        ImageTransparency = 0
    }):Play();
    task.wait(1);
end;

function u1.hideFrame(p6) -- Line: 37
    p6:changeAllTransparency(1, 1, true);
end;

function u1.startLoading(p7) -- Line: 42
    -- upvalues: UserInputService (copy)
    p7:startTransparentBGfx();
    p7:hideGuis();
    p7.gui.Enabled = true;
    p7.bgFrame.Visible = true;
    p7:startRotateTween();
    task.wait(1);
    p7:revealLogo();
    p7:startTipCycle(7);
    task.wait(0.6);
    p7:startCounter(5);
    p7.counterFinishedEvent.Event:Wait();
    p7:fadeUpdateText(p7.mainFrame.CounterTxt, "<font color=\'#FFFF00\'>[Click Anywhere to Play]</font>", 0.6);
    UserInputService.InputBegan:Wait();
    p7:endTipCycle();
    p7:hideFrame();
    p7:endTransparentBGfx();
    p7:showGuis();
    p7:stopRotateTween();
    p7:finishedLoading();
end;

return u1;