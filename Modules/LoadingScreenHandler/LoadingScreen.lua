-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Debris = game:GetService("Debris");
local game_ReplicatedStorage = game.ReplicatedStorage;
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;
require(game_ReplicatedStorage.Modules.GuiController);
local utils = require(game_ReplicatedStorage.Modules.Utility.utils);
local Field_Of_View_Module = require(game_ReplicatedStorage.Field_Of_View_Module);
local TradeWorldController = require(game_ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local u2 = {
    TextLabel = "TextTransparency",
    ImageLabel = "ImageTransparency",
    UIStroke = "Transparency"
};

function u1.new(p3: userdata) -- Line: 29
    -- upvalues: u1 (copy), utils (copy)
    local v4 = setmetatable({}, u1);
    v4.COUNTER_MAX = 2000;
    v4.gui = p3;
    v4.counterFinishedEvent = Instance.new("BindableEvent");
    v4.canSkipEvent = Instance.new("BindableEvent");
    v4.hasFiredCanSkip = false;
    v4.cCounter = 0;
    v4.blockTextTweens = false;
    v4.guiCons = {};
    v4.tips = utils.set.new({ "<font color=\"#FFFF00\">Gold</font> plants are rare, but valuable!", "Your garden literally grows while you are <b>offline</b>", "The <i>best</i> seeds have a <i>small</i> chance of restocking!", "The seed store restocks every 5 minutes!", "You can flex your fruits and finds to other people!", "<font color=\"#FFFF00\">Private Servers</font> are free for everyone!", "Playing with friends makes the game even more fun!", "There is a small chance for <font color=\"#FF0000\">r</font><font color=\"#FF7F00\">a</font><font color=\"#FFFF00\">i</font><font color=\"#00FF00\">n</font><font color=\"#0000FF\">b</font><font color=\"#4B0082\">o</font><font color=\"#8B00FF\">w</font> crops!" });
    v4.remainingTips = v4.tips:clone();

    return v4;
end;

function u1.setCam(p5) -- Line: 60
    -- upvalues: TradeWorldController (copy)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    if TradeWorldController:IsInWorld() then
        workspace.CurrentCamera.CFrame = workspace.TradeworldCamPart.CFrame;

        return;
    end;

    workspace.CurrentCamera.CFrame = workspace.LoadingCamPart.CFrame;
end;

function u1.startTransparentBGfx(u6) -- Line: 71
    u6.blur = Instance.new("BlurEffect");
    u6.blur.Name = "LoadingBlur";
    u6.blur.Size = 15;
    u6.blur.Parent = game:GetService("Lighting");
    u6:setCam();
    u6.camLockCon = workspace.CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 79
        -- upvalues: u6 (copy)
        u6:setCam();
    end);
end;

function u1.endTransparentBGfx(p7) -- Line: 84
    -- upvalues: Field_Of_View_Module (copy), TweenService (copy), Debris (copy)
    workspace.CurrentCamera.FieldOfView = 100;
    Field_Of_View_Module.Change_FOV(70, 3);
    TweenService:Create(p7.blur, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    Debris:AddItem(p7.blur, 1);
    p7.camLockCon:Disconnect();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
end;

function u1.hideOtherGui(u8, u9) -- Line: 94
    if u9.Enabled then
        u8.originalEnabledStates[u9] = u9.Enabled;
        u9.Enabled = false;
    end;

    u8.guiCons[u9] = u9:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 99
        -- upvalues: u9 (copy), u8 (copy)
        if u9.Enabled then
            u8.originalEnabledStates[u9] = u9.Enabled;
            u9.Enabled = false;
        end;
    end);
end;

function u1.hideGuis(u10) -- Line: 107
    -- upvalues: LocalPlayer (copy)
    u10.originalEnabledStates = {};
    u10.guiAddedCon = LocalPlayer.PlayerGui.ChildAdded:Connect(function(p11) -- Line: 110
        -- upvalues: u10 (copy)
        if p11:IsA("ScreenGui") then
            u10:hideOtherGui(p11);
        end;
    end);

    for _, child in pairs(LocalPlayer.PlayerGui:GetChildren()) do
        if child:IsA("ScreenGui") and child ~= u10.gui then
            u10:hideOtherGui(child);
        end;
    end;
end;

function u1.showGuis(p12) -- Line: 122
    for _, v in pairs(p12.guiCons) do
        v:Disconnect();
    end;

    p12.guiAddedCon:Disconnect();

    for i, v in pairs(p12.originalEnabledStates) do
        i.Enabled = v;
    end;
end;

function u1.startCounter(u13, u14) -- Line: 132
    -- upvalues: TweenService (copy)
    u13.counterIntVal = Instance.new("IntValue");
    local TweenInfo_new_ret = TweenInfo.new(u14, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    u13.valTween = TweenService:Create(u13.counterIntVal, TweenInfo_new_ret, {
        Value = u13.COUNTER_MAX
    });
    u13.valTween:Play();
    TweenService:Create(u13.mainFrame.CounterTxt, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
        TextTransparency = 0
    }):Play();
    u13.counterListener = u13.counterIntVal.Changed:Connect(function(p15) -- Line: 141
        -- upvalues: u13 (copy), u14 (copy)
        u13.mainFrame.CounterTxt.Text = "Loading " .. p15 .. "/" .. u13.COUNTER_MAX;

        if u13.COUNTER_MAX <= p15 then
            u13.counterFinishedEvent:Fire();
        end;

        if u13.canSkipAfter and (p15 / u13.COUNTER_MAX * u14 >= u13.canSkipAfter and not u13.hasFiredCanSkip) then
            u13.hasFiredCanSkip = true;
            u13.canSkipEvent:Fire();
        end;
    end);
end;

function u1.fadeUpdateText(u16: table, u17: userdata, u18: string, u19: number) -- Line: 154
    -- upvalues: TweenService (copy)
    task.spawn(function() -- Line: 155
        -- upvalues: u19 (copy), TweenService (ref), u17 (copy), u16 (copy), u18 (copy)
        local TweenInfo_new_ret = TweenInfo.new(u19 / 2, Enum.EasingStyle.Linear);
        local v20 = TweenService:Create(u17, TweenInfo_new_ret, {
            TextTransparency = 1
        });
        v20:Play();
        v20.Completed:Wait();

        if not u16.blockTextTweens then
            u17.Text = u18;
            TweenService:Create(u17, TweenInfo_new_ret, {
                TextTransparency = 0
            }):Play();
        end;
    end);
end;

function u1.endCounter(p21) -- Line: 170
    p21.counterListener:Disconnect();
end;

function u1.startTipCycle(u22: table, u23: number) -- Line: 174
    u22.tipTask = task.spawn(function() -- Line: 176
        -- upvalues: u22 (copy), u23 (copy)
        while true do
            u22:updateTip(true);
            task.wait(u23);
        end;
    end);
end;

function u1.endTipCycle(p24) -- Line: 184
    p24.blockTextTweens = true;
    task.cancel(p24.tipTask);
end;

function u1.changeAllTransparency(p25: table, p26: number, p27: number, p28: boolean) -- Line: 189
    -- upvalues: u2 (copy), TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p27, Enum.EasingStyle.Linear);

    for _, descendant in pairs(p25.mainFrame:GetDescendants()) do
        local v29 = u2[descendant.ClassName];

        if v29 then
            TweenService:Create(descendant, TweenInfo_new_ret, {
                [v29] = p26
            }):Play();
        end;
    end;

    if p28 then
        task.wait(p27);
    end;
end;

function u1.updateTip(p30: table, p31: boolean) -- Line: 203
    if #p30.remainingTips < 1 then
        p30.remainingTips = p30.tips:clone();
    end;

    local v32 = "[" .. p30.remainingTips:popRandom() .. "]";

    if p31 then
        p30:fadeUpdateText(p30.mainFrame.TipLabel, v32, 0.6);

        return;
    end;

    p30.mainFrame.TipLabel.Text = v32;
end;

function u1.startRotateTween(p33) -- Line: 216
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true);
    p33.rotateTween = TweenService:Create(p33.mainFrame.LogoImg.FruitImg, TweenInfo_new_ret, {
        Rotation = 5
    });
    p33.rotateTween:Play();
end;

function u1.stopRotateTween(p34) -- Line: 222
    p34.rotateTween:Pause();
end;

LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Seed_Shop");

function u1.finishedLoading(p35) -- Line: 228
    -- upvalues: game_ReplicatedStorage (copy)
    p35.gui.Enabled = false;
    game_ReplicatedStorage.GameEvents.Finish_Loading:FireServer();
    table.clear(p35);
    table.freeze(p35);
end;

return u1;