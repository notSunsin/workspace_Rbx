-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local SettingsUI = Players.LocalPlayer.PlayerGui:WaitForChild("SettingsUI");
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local SetupSounds = require(ReplicatedStorage.Modules.SetupSounds);
require(ReplicatedStorage.Modules.SetupBrightnessAnimationFrame);
require(ReplicatedStorage.Modules.SetupHoverAnimations);
local FindDescendantsWithTag = require(ReplicatedStorage.Modules.FindDescendantsWithTag);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local u1 = WaitForDescendant(SettingsUI, "SETTING_INSERTION_POINT");
local u2 = WaitForDescendant(SettingsUI, "TOGGLE_SETTING_TEMPLATE");
local u3 = {};
u3.__index = u3;

function u3.new() -- Line: 25
    -- upvalues: u3 (copy), u2 (copy), FindDescendantsWithTag (copy), WaitForDescendant (copy), SetupSounds (copy)
    local u4 = setmetatable({}, u3);
    u4.CurrentValue = true;
    local v5 = u2:Clone();
    u4.Asset = v5;
    local v6 = {};
    u4.UIData = v6;
    v6.AllStrokes = FindDescendantsWithTag(v5, "ColorStroke");
    local v7 = WaitForDescendant(v5, "TOGGLE_BUTTON");
    v6.TOGGLE_BUTTON = v7;
    v6.TOGGLE_STATE_TEXT = WaitForDescendant(v5, "TOGGLE_STATE_TEXT");
    v6.SETTING_TITLE = WaitForDescendant(v5, "SETTING_TITLE");
    v6.SETTING_DESCRIPTION = WaitForDescendant(v5, "SETTING_DESCRIPTION");
    v6.BACKGROUND_TEXTURE = WaitForDescendant(v5, "BACKGROUND_TEXTURE");
    SetupSounds(v7);
    v7:WaitForChild("SENSOR").MouseButton1Click:Connect(function() -- Line: 44
        -- upvalues: u4 (copy)
        u4:Toggle();
    end);

    return u4;
end;

function u3.Toggle(p8) -- Line: 51
    -- upvalues: SettingsService (copy)
    local v9 = not p8.CurrentValue;
    p8:Update(v9);
    local Id = p8.Id;

    if Id then
        SettingsService:SetSetting(Id, v9);
    end;
end;

function u3.SetLayoutOrder(p10: table, p11: number) -- Line: 61
    p10.Asset.LayoutOrder = p11;

    return p10;
end;

function u3.SetId(p12, p13) -- Line: 66
    p12.Id = p13;

    return p12;
end;

function u3.Update(p14: table, p15: boolean) -- Line: 72
    -- upvalues: TweenService (copy)
    p14.CurrentValue = p15;
    local CurrentValue = p14.CurrentValue;
    local UIData = p14.UIData;
    local AllStrokes = UIData.AllStrokes;
    UIData.TOGGLE_STATE_TEXT.Text = CurrentValue and "On" or "Off";
    local v16;

    if CurrentValue then
        v16 = Color3.fromRGB(30, 100, 14);
    else
        v16 = Color3.fromRGB(118, 4, 7);
    end;

    local v17;

    if CurrentValue then
        v17 = Color3.fromRGB(37, 238, 38);
    else
        v17 = Color3.fromRGB(206, 27, 24);
    end;

    for _, v in AllStrokes do
        TweenService:Create(v, TweenInfo.new(0.15), {
            Color = v16
        }):Play();
    end;

    TweenService:Create(UIData.TOGGLE_BUTTON, TweenInfo.new(0.15), {
        BackgroundColor3 = v17
    }):Play();

    return p14;
end;

function u3.SetDescription(p18: table, p19: string) -- Line: 101
    p18.UIData.SETTING_DESCRIPTION.Text = p19;

    return p18;
end;

function u3.SetTitle(p20: table, p21: string) -- Line: 109
    p20.UIData.SETTING_TITLE.Text = p21;

    return p20;
end;

function u3.SetBackgroundImage(p22: table, p23: string) -- Line: 117
    p22.UIData.BACKGROUND_TEXTURE.Image = p23;

    return p22;
end;

function u3.Complete(p24) -- Line: 125
    -- upvalues: u1 (copy)
    local Asset = p24.Asset;
    Asset.Visible = true;
    Asset.Parent = u1;

    return p24;
end;

return u3;