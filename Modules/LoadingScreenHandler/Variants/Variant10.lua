-- Decompiled with Potassium's decompiler.

local game_ReplicatedStorage = game.ReplicatedStorage;
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local _ = game.Players.LocalPlayer;
local LoadingScreen = require(script.Parent.Parent.LoadingScreen);
require(game_ReplicatedStorage.Field_Of_View_Module);
local u1 = setmetatable({}, LoadingScreen);
u1.__index = u1;

function u1.new(p2) -- Line: 24
    -- upvalues: LoadingScreen (copy), u1 (copy)
    local v3 = LoadingScreen.new(p2);
    local v4 = setmetatable(v3, u1);
    v4.bgFrame = v4.gui.Variant5Frame;
    v4.mainFrame = v4.bgFrame.InnerFrame;

    return v4;
end;

function u1.startBarFill(u5, u6) -- Line: 33
    -- upvalues: TweenService (copy)
    task.spawn(function() -- Line: 34
        -- upvalues: TweenService (ref), u5 (copy), u6 (copy)
        local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Linear);
        TweenService:Create(u5.mainFrame.LoadingBar, TweenInfo_new_ret, {
            GroupTransparency = 0
        }):Play();
        TweenService:Create(u5.mainFrame.LoadingBar.UIStroke, TweenInfo_new_ret, {
            Transparency = 0
        }):Play();
        local TweenInfo_new_ret2 = TweenInfo.new(u5.mainFrame.LoadingBar.UIStroke.Thickness / (u5.mainFrame.LoadingBar.BackFill.AbsoluteSize.X / u6), Enum.EasingStyle.Linear);
        local v7 = TweenService:Create(u5.mainFrame.LoadingBar.UIStroke.UIGradient, TweenInfo_new_ret2, {
            Offset = Vector2.new(-0.495, 0)
        });
        v7:Play();
        v7.Completed:Wait();
        local TweenInfo_new_ret3 = TweenInfo.new(u6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        TweenService:Create(u5.mainFrame.LoadingBar.FrontFill, TweenInfo_new_ret3, {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play();
        local v8 = TweenService:Create(u5.mainFrame.LoadingBar.UIStroke.UIGradient, TweenInfo_new_ret3, {
            Offset = Vector2.new(0.495, 0)
        });
        v8:Play();
        v8.Completed:Wait();
        TweenService:Create(u5.mainFrame.LoadingBar.UIStroke.UIGradient, TweenInfo_new_ret2, {
            Offset = Vector2.new(0.5, 0)
        }):Play();
    end);
end;

function u1.revealLogo(p9) -- Line: 60
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Linear);
    TweenService:Create(p9.mainFrame.LogoImg, TweenInfo_new_ret, {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(p9.mainFrame.LogoImg.FruitImg, TweenInfo_new_ret, {
        ImageTransparency = 0
    }):Play();
    task.wait(1);
end;

function u1.hideFrame(p10) -- Line: 70
    p10:changeAllTransparency(1, 1, true);
end;

function u1.startLoading(p11) -- Line: 75
    -- upvalues: UserInputService (copy)
    local v12 = script.dbdbdb:Clone();
    v12.Parent = workspace;
    v12.CFrame = workspace.CurrentCamera.CFrame;
    print(v12.CFrame);
    p11:startTransparentBGfx();
    p11:hideGuis();
    p11.gui.Enabled = true;
    p11.bgFrame.Visible = true;
    p11:startRotateTween();
    task.wait(1);
    p11:revealLogo();
    p11:startBarFill(5);
    p11:startTipCycle(7);
    task.wait(0.6);
    p11:startCounter(5);
    p11.counterFinishedEvent.Event:Wait();
    p11:fadeUpdateText(p11.mainFrame.CounterTxt, "<font color=\'#FFFF00\'>[Click Anywhere to Play]</font>", 0.6);
    UserInputService.InputBegan:Wait();
    p11:endTipCycle();
    p11:hideFrame();
    p11:endTransparentBGfx();
    p11:stopRotateTween();
    p11:showGuis();
    p11:finishedLoading();
end;

return u1;