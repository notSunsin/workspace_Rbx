-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PityHoverController = require(ReplicatedStorage.Modules.PityHoverController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.SeedData);
local PityData = require(ReplicatedStorage.Data.PityData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local DisclaimerPresets = require(ReplicatedStorage.Modules.UIComponents.DisclaimerPresets);
local Odds_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Odds_UI");
local Items = Odds_UI.Frame.Main.Items;
local u1 = Trove.new();
local v2 = {};

local function FormatPercent(p3: number) -- Line: 43
    if p3 ~= p3 or p3 <= 0 then
        return "0%", false;
    end;

    for i = 2, 4 do
        local string_format = string.format;
        local v4 = `%.{i}f`;
        local v5 = tonumber(string_format(v4, p3));

        if v5 and math.abs(v5 - p3) <= 1e-9 then
            return `{v5}%`, false;
        end;

        local _ = i;
    end;

    local string_format = string.format;
    local v6 = `%.{4}f`;
    local v7 = tonumber(string_format(v6, p3));

    if v7 and v7 ~= 0 then
        return `{v7}%`, true;
    end;

    return `<{0.0001}%`, true;
end;

function v2.Open(p8: table, p9: string, u10: userdata?, p11: string?, p12: number?) -- Line: 64
    -- upvalues: SeedPackData (copy), ItemInfoHover (copy), PityData (copy), GuiController (copy), Odds_UI (copy), u1 (copy), Items (copy), PityHoverController (copy), FormatPercent (copy), ItemImageFinder (copy), RunService (copy), DisclaimerPresets (copy)
    local v13 = SeedPackData.Packs[p9];

    if not v13 then
        return;
    end;

    local u14 = {};

    for _, v in v13.Items do
        table.insert(u14, {
            Type = v.Type == "RainbowSeed" and "Seed" or v.Type,
            Value = v.RewardId
        });
    end;

    ItemInfoHover:AddRewardTable("SeedPackOdds", u14, {});
    local v15;

    if p11 then
        v15 = PityData[p11];
    else
        v15 = nil;
    end;

    local StateForGui = GuiController:GetStateForGui(Odds_UI);
    u1:Destroy();

    for _, child in Items.ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    local v16 = 0;
    local v17 = {};

    for _, v in v13.Items do
        if not (v.RemoveChance or v.HideChance) then
            v16 = v16 + (v.Chance or 0);
        end;
    end;

    for i, v in v13.Items do
        table.insert(v17, {
            Reward = v,
            Index = i,
            Normalized = (v.RemoveChance or v.HideChance) and 0 or (v.Chance or 0) / v16 * 100
        });
    end;

    table.sort(v17, function(p18, p19) -- Line: 112
        return p18.Normalized < p19.Normalized;
    end);
    local v20 = true;

    for i = 2, #v17 do
        if math.abs(v17[i].Normalized - v17[1].Normalized) > 1e-6 then
            v20 = false;
            break;
        end;

        local _ = i;
    end;

    local Normalized = v17[1].Normalized;
    local v21 = nil;

    for i = 2, #v17 do
        if math.abs(v17[i].Normalized - Normalized) > 1e-6 then
            v21 = v17[i].Normalized;
            break;
        end;

        local _ = i;
    end;

    local v22 = false;
    local v23 = 0;

    for _, v in v17 do
        local Reward = v.Reward;
        local v24;

        if Reward.Type == "RainbowSeed" then
            v24 = true;
        else
            v24 = string.find(Reward.RewardId, "Rainbow ") or string.find(p9, "Special ") or not v20 and math.abs(v.Normalized - Normalized) < 1e-6;
        end;

        local v25;

        if v21 then
            v25 = math.abs(v.Normalized - v21) < 1e-6;
        else
            v25 = v21;
        end;

        local v26;

        if v24 then
            v26 = Items.ScrollingFrame.UIListLayout.TemplateRainbow;
        elseif v25 then
            v26 = Items.ScrollingFrame.UIListLayout.TemplateBigger;
        else
            v26 = Items.ScrollingFrame.UIListLayout.TemplateSmaller;
        end;

        v23 = v23 + 1;
        local u27 = u1:Clone(v26);
        u27:SetAttribute("UUID", (`SeedPackOdds_{Reward.Type == "RainbowSeed" and "Seed" or Reward.Type}_{Reward.RewardId}`));
        u27:AddTag("ItemInfoHoverTag");
        u27.LayoutOrder = v.Index;
        u27.Title.Text = SeedPackData:GetTextDisplayForItem(Reward);
        local v28;

        if v15 then
            v28 = v;
            local v29 = 0;

            for _, v3 in v15.Items do
                if v3.RewardId == v28.Reward.RewardId and v3.Type == v28.Reward.Type then
                    v29 = v3.Pity;
                    break;
                end;
            end;

            if v29 > 0 then
                local Pity = u27.Pity;
                Pity.Text = `{v29}*`;
                Pity.Visible = true;
                PityHoverController:AddGuiObject(u27, v29, v15.DisplayPlural);
                u1:Add(function() -- Line: 175
                    -- upvalues: PityHoverController (ref), u27 (copy)
                    PityHoverController:RemoveGuiObject(u27);
                end);
            end;
        else
            v28 = v;
        end;

        if Reward.RemoveChance then
            u27.Odds.Text = "";
        elseif Reward.HideChance then
            u27.Odds.Text = "???";
        else
            local Normalized2 = v28.Normalized;

            if p12 then
                Normalized2 = Normalized2 * (p12 / 100);
            end;

            local v30, v31 = FormatPercent(Normalized2);
            u27.Odds.Text = v30;
            v22 = v22 or v31;
        end;

        if Reward.Icon then
            u27.Vector.Image = Reward.Icon;
            u27.Vector.Visible = true;
        else
            local v32 = ItemImageFinder(Reward.RewardId, Reward.Type);

            if v32 then
                u27.Vector.Image = v32;
                u27.Vector.Visible = true;
            else
                u27.Vector.Visible = false;
            end;
        end;

        if v24 then
            local u33 = nil;
            u1:Add(StateForGui.Visible:Observe(function(p34: boolean) -- Line: 214
                -- upvalues: u33 (ref), u1 (ref), RunService (ref), u27 (copy)
                if p34 and not u33 then
                    u33 = u1:Add(RunService.PostSimulation:Connect(function() -- Line: 216
                        -- upvalues: u27 (ref)
                        local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                        u27.Odds.TextColor3 = Color3_fromHSV_ret;
                        u27.Title.TextColor3 = Color3_fromHSV_ret;
                    end));

                    return;
                end;

                if not p34 and u33 then
                    u1:Remove(u33);
                    u33 = nil;
                end;
            end));
        elseif v25 then
            local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 1);
            u27.Odds.TextColor3 = Color3_fromRGB_ret;
            u27.Title.TextColor3 = Color3_fromRGB_ret;
        end;

        u27.Title.TextScaled = true;
        u27.Odds.TextScaled = true;
        u27.Parent = Items.ScrollingFrame;
    end;

    local Disclaimer = Odds_UI.Frame:FindFirstChild("Disclaimer");

    if Disclaimer and Disclaimer:IsA("TextLabel") then
        local v35;

        if v22 then
            if p12 then
                v35 = DisclaimerPresets.Resolve("PRESETS/RoundedOdds");
            else
                v35 = DisclaimerPresets.Resolve("PRESETS/RoundedOddsCompliance");
            end;
        else
            v35 = "";
        end;

        Disclaimer.Text = v35;
    end;

    for _, v in v17 do
        if v.Reward.Type ~= "RainbowSeed" and not (string.find(v.Reward.RewardId, "Rainbow ") or string.find(p9, "Special ")) then
            break;
        end;
    end;

    if Items.ScrollingFrame.AbsoluteCanvasSize.X > Items.ScrollingFrame.AbsoluteWindowSize.X then
        Items.ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    else
        Items.ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    end;

    GuiController:Open(Odds_UI);

    if u10 then
        u1:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 279
            -- upvalues: ItemInfoHover (ref), u14 (copy), GuiController (ref), Odds_UI (ref), u10 (copy), u1 (ref)
            ItemInfoHover:RemoveRewardTable("SeedPackOdds", u14);
            GuiController:Close(Odds_UI);
            GuiController:Open(u10);
            u1:Clean();
        end));

        return;
    end;

    u1:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 287
        -- upvalues: ItemInfoHover (ref), u14 (copy), GuiController (ref), Odds_UI (ref), u1 (ref)
        ItemInfoHover:RemoveRewardTable("SeedPackOdds", u14);
        GuiController:Close(Odds_UI);
        u1:Clean();
    end));
end;

function v2.Start(p36) -- Line: 296
    -- upvalues: GuiController (copy), Odds_UI (copy)
    GuiController:UsePopupAnims(Odds_UI);
end;

task.spawn(v2.Start, v2);

return v2;