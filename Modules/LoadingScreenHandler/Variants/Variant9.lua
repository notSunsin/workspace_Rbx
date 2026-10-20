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
    p7:changeAllTransparency(1, 1, true);
end;

function u1.startLoading(p8) -- Line: 37
    -- upvalues: UserInputService (copy)
    p8:startTransparentBGfx();
    p8:hideGuis();
    p8.gui.Enabled = true;
    p8.bgFrame.Visible = true;
    task.wait(1);
    p8:fillLogo(5);
    p8:startTipCycle(7);
    p8:startCounter(5);
    p8.counterFinishedEvent.Event:Wait();
    p8:fadeUpdateText(p8.mainFrame.CounterTxt, "<font color=\'#FFFF00\'>[Click Anywhere to Play]</font>", 0.6);
    UserInputService.InputBegan:Wait();
    p8:endTipCycle();
    p8:hideFrame();
    p8:endTransparentBGfx();
    p8:showGuis();
    p8:finishedLoading();
end;

return u1;