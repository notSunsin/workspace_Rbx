-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SettingsUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SettingsUI");
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local SetupSounds = require(ReplicatedStorage.Modules.SetupSounds);
require(ReplicatedStorage.Modules.SetupHoverAnimations);
local FindDescendantsWithTag = require(ReplicatedStorage.Modules.FindDescendantsWithTag);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local u1 = WaitForDescendant(SettingsUI, "SETTING_INSERTION_POINT");
local u2 = WaitForDescendant(SettingsUI, "MULTIPLE_SETTING_TEMPLATE");
local u3 = {};
u3.__index = u3;

function u3.new(u4: table) -- Line: 19
    -- upvalues: u3 (copy), u2 (copy), WaitForDescendant (copy), SetupSounds (copy), FindDescendantsWithTag (copy)
    local u5 = setmetatable({}, u3);
    local v6 = u2:Clone();
    u5.Asset = v6;
    u5.CurrentValue = nil;
    local v7 = {};
    u5.UIData = v7;
    v7.SETTING_TITLE = WaitForDescendant(v6, "SETTING_TITLE");
    v7.SETTING_DESCRIPTION = WaitForDescendant(v6, "SETTING_DESCRIPTION");
    v7.BACKGROUND_TEXTURE = WaitForDescendant(v6, "BACKGROUND_TEXTURE");
    local v8 = { WaitForDescendant(v6, "NONE_BUTTON"), WaitForDescendant(v6, "LESS_BUTTON"), WaitForDescendant(v6, "ALL_BUTTON") };
    u5.Buttons = {};
    local v9 = v8[#v8];
    local v10 = #u4;
    local math_max_ret = math.max((1 - (v10 - 1) * 0.1) / v10, 0.1);

    for i, v in u4 do
        local v11 = v8[i];

        if not v11 then
            v11 = v9:Clone();
            v11.Name = `OPTION_{i}_BUTTON`;
            v11.Parent = v9.Parent;
        end;

        v11.LayoutOrder = i;
        v11.Size = UDim2.fromScale(math_max_ret, v11.Size.Y.Scale);
        v11.TOGGLE.Text = v;
        u5.Buttons[v] = v11;
        SetupSounds(v11);
        v11.SENSOR.MouseButton1Click:Connect(function() -- Line: 60
            -- upvalues: u5 (copy), v (copy), u4 (copy)
            u5:Set(v, u4);
        end);
    end;

    for i = v10 + 1, #v8 do
        v8[i].Visible = false;
        local _ = i;
    end;

    v7.AllStrokes = FindDescendantsWithTag(v6, "ColorStroke");

    return u5;
end;

function u3.Set(p12: table, p13: string, p14: table) -- Line: 74
    -- upvalues: SettingsService (copy)
    if p12.CurrentValue == p13 then
        return;
    end;

    p12.CurrentValue = p13;
    local _ = p12.UIData;

    for i, v in p12.Buttons do
        v.BackgroundTransparency = i == p13 and 0 or 0.8;
    end;

    if p12.Id then
        SettingsService:SetSetting(p12.Id, p13);
    end;
end;

function u3.SetId(p15: table, p16: string) -- Line: 90
    p15.Id = p16;

    return p15;
end;

function u3.Update(p17: table, p18: string) -- Line: 95
    p17:Set(p18);

    return p17;
end;

function u3.SetDescription(p19: table, p20: string) -- Line: 100
    p19.UIData.SETTING_DESCRIPTION.Text = p20;

    return p19;
end;

function u3.SetTitle(p21: table, p22: string) -- Line: 105
    p21.UIData.SETTING_TITLE.Text = p22;

    return p21;
end;

function u3.SetBackgroundImage(p23: table, p24: string) -- Line: 110
    p23.UIData.BACKGROUND_TEXTURE.Image = p24;

    return p23;
end;

function u3.SetLayoutOrder(p25: table, p26: number) -- Line: 115
    p25.Asset.LayoutOrder = p26;

    return p25;
end;

function u3.Complete(p27) -- Line: 120
    -- upvalues: u1 (copy)
    local Asset = p27.Asset;
    Asset.Visible = true;
    Asset.Parent = u1;

    return p27;
end;

return u3;