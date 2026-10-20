-- Decompiled with Potassium's decompiler.

local game_ReplicatedStorage = game.ReplicatedStorage;
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local _ = game.Players.LocalPlayer;
local LoadingScreen = require(script.Parent.Parent.LoadingScreen);
local utils = require(game_ReplicatedStorage.Modules.Utility.utils);
local u1 = setmetatable({}, LoadingScreen);
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: LoadingScreen (copy), u1 (copy)
    local v3 = LoadingScreen.new(p2);
    local v4 = setmetatable(v3, u1);
    v4.bgFrame = v4.gui.Variant1Frame;
    v4.mainFrame = v4.bgFrame.InnerFrame;
    v4.canSkipAfter = 3;
    v4.skipped = false;
    v4.finished = false;

    return v4;
end;

function u1.revealLogo(p5) -- Line: 30
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

function u1.hideFrame(p6) -- Line: 40
    -- upvalues: TweenService (copy)
    p6:changeAllTransparency(1, 1);
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Linear);
    local v7 = TweenService:Create(p6.bgFrame, TweenInfo_new_ret, {
        BackgroundTransparency = 1
    });
    v7:Play();
    v7.Completed:Wait();
end;

function u1.startLoading(u8) -- Line: 51
    -- upvalues: UserInputService (copy), utils (copy)
    u8:startTransparentBGfx();
    u8:hideGuis();
    u8.gui.Enabled = true;
    u8.bgFrame.Visible = true;
    u8:startRotateTween();
    u8:startTipCycle(7);
    u8:startCounter(15);
    u8.canSkipEvent.Event:Wait();
    u8:fadeUpdateText(u8.mainFrame.SkipTxt, "Click to skip!", 0.6);
    u8.inputCon = UserInputService.InputBegan:Connect(function() -- Line: 64
        -- upvalues: u8 (copy)
        u8.skipped = true;
    end);
    u8.counterFinishedEvent.Event:Connect(function() -- Line: 67
        -- upvalues: u8 (copy)
        u8.finished = true;
        u8:fadeUpdateText(u8.mainFrame.CounterTxt, "Fully Loaded!", 0.6);
    end);

    while not (u8.skipped or u8.finished) do
        task.wait();
    end;

    if u8.finished then
        local v9 = utils.isMobile() and "Tap anywhere to play!" or "Press any key to play!";
        u8:fadeUpdateText(u8.mainFrame.PressAnyTxt, "<font color=\'#FFFF00\'>[" .. v9 .. "]</font>", 0.6);
    end;

    while not u8.skipped do
        task.wait();
    end;

    u8:endCounter();
    u8:endTipCycle();
    u8.inputCon:Disconnect();
    u8:hideFrame();
    u8:endTransparentBGfx();
    u8:stopRotateTween();
    u8:showGuis();
    u8:finishedLoading();
end;

return u1;