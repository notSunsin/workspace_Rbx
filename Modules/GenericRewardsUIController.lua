-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.SeedData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
require(ReplicatedStorage.Modules.DataService);
local DeepClone = require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local DisclaimerPresets = require(ReplicatedStorage.Modules.UIComponents.DisclaimerPresets);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
Item_Module.Return_All_Seed_Rarities();
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found");
local GenericRewards_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GenericRewards_UI");
local u1 = Trove.new();
local u6 = {
    DisclaimerPresets = DisclaimerPresets.Presets,

    RoundOddsPercent = function(p2: number) -- Line: 107, Name: RoundOddsPercent
        if p2 ~= p2 or p2 < 0.01 then
            return 0;
        end;

        local string_format = string.format;
        local v3 = `%.{2}f`;

        return tonumber(string_format(v3, p2)) or 0;
    end,

    FormatOddsPercent = function(p4: number, p5: boolean?) -- Line: 122, Name: FormatOddsPercent
        if p4 ~= p4 or p4 <= 0 then
            return "0%";
        end;

        if p4 >= 0.01 then
            return string.format(`%.{2}f%%`, p4);
        end;

        if p5 then
            return `&lt;{0.01}%`;
        end;

        return `<{0.01}%`;
    end
};

function u6.RoundedOddsDisclaimer(p7: table) -- Line: 139
    -- upvalues: u6 (copy)
    local v8 = 0;

    for _, v in p7 do
        v8 = v8 + (v.Weight or 0);
    end;

    if v8 <= 0 then
        return nil;
    end;

    local v9 = 0;

    for _, v in p7 do
        v9 = v9 + u6.RoundOddsPercent((v.Weight or 0) / v8 * 100);
    end;

    return math.abs(v9 - 100) >= 1e-9 and "PRESETS/RoundedOddsCompliance" or nil;
end;

local u10 = {};
local u11 = {};

local function ApplyHeaderColor(p12, p13) -- Line: 167
    -- upvalues: u10 (copy), u11 (copy)
    local v14 = p12:FindFirstChildOfClass("UIGradient");

    if v14 then
        if u10[v14] == nil then
            u10[v14] = v14.Color;
        end;

        local v15;

        if p13 == nil then
            v15 = u10[v14];
        elseif typeof(p13) == "ColorSequence" then
            v15 = p13;
        else
            v15 = ColorSequence.new(p13);
        end;

        v14.Color = v15;
    end;

    local Detail = p12:FindFirstChild("Detail");

    if Detail then
        Detail = Detail:FindFirstChild("InletTexture");
    end;

    if Detail and Detail:IsA("ImageLabel") then
        if u11[Detail] == nil then
            u11[Detail] = Detail.ImageColor3;
        end;

        local v16;

        if p13 then
            v16 = Color3.fromRGB(255, 255, 255);
        else
            v16 = u11[Detail];
        end;

        Detail.ImageColor3 = v16;
    end;
end;

function u6.Open(p17: table, p18: table) -- Line: 191
    -- upvalues: GenericRewards_UI (copy), DisclaimerPresets (copy), GuiController (copy), u1 (copy), ApplyHeaderColor (copy), ItemInfoHover (copy), DeepClone (copy), ItemOddsController (copy), GiveServiceCommon (copy), u6 (copy), ColorHelper (copy)
    local DisplayOdds = p18.DisplayOdds;
    local v19 = DisplayOdds == nil and true or DisplayOdds;
    local v20 = p18.RewardTemplate or nil;
    local v21 = p18.Title or "Rewards";
    local RewardData = p18.RewardData;
    local RewardFrameCreatedCallback = p18.RewardFrameCreatedCallback;
    local Breadcrumb = p18.Breadcrumb;
    local v22 = p18.ChanceDisplayMode or "Percentage";
    local u23 = p18.RewardsUIOverride or GenericRewards_UI;
    local Holder = u23.Frame.Main.Holder;
    local RewardsUIBuiltCallback = p18.RewardsUIBuiltCallback;
    local RewardsUIPreBuildCallback = p18.RewardsUIPreBuildCallback;
    local Information = p18.Information;
    local v24 = DisclaimerPresets.Resolve(p18.Disclaimer);
    GuiController:GetStateForGui(u23);
    u1:Destroy();
    local v25 = v20 or Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE;
    Holder.Header.Title.Text = v21;
    ApplyHeaderColor(Holder.Header, p18.HeaderColor);
    local Information2 = u23.Frame.Main:FindFirstChild("Information");

    if Information2 and Information2:IsA("Frame") then
        local v26;

        if Information == nil then
            v26 = false;
        else
            v26 = Information ~= "";
        end;

        Information2.Visible = v26;
        local Text = Information2:FindFirstChild("Text");

        if Text and Text:IsA("TextLabel") then
            Text.Text = Information or "";
        end;
    end;

    local Disclaimer = u23.Frame.Main:FindFirstChild("Disclaimer");

    if Disclaimer and Disclaimer:IsA("TextLabel") then
        Disclaimer.Text = v24;
    end;

    for _, child in Holder.RewardScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    ItemInfoHover:RemoveRewardTable("GenericRewardsUI");
    local _ = #RewardData;
    local v27 = DeepClone(RewardData);
    table.sort(v27, function(p28, p29) -- Line: 242
        return (p28.Weight or 1) > (p29.Weight or 1);
    end);
    local v30 = 0;
    local v31 = 0;

    for _, v in v27 do
        v30 = v30 + (v.Weight or 0);
    end;

    if RewardsUIPreBuildCallback then
        RewardsUIPreBuildCallback(u23, Holder.RewardScrollingFrame);
    end;

    local v32 = {};

    for i, v in v27 do
        v31 = v31 + 1;
        local v33 = u1:Clone(v25);
        local RewardName = v33.Frame.RewardName;
        local Odds = v33.Frame.Odds;
        local ITEM_IMAGE = v33.Frame.ITEM_IMAGE;
        ItemOddsController:ConnectOddsButton(v.Reward, v33.Frame.OddsButton, u23);
        RewardName.Text = GiveServiceCommon:Format(v.Reward);

        if v19 then
            local v34 = v.Weight / v30;

            if v22 == "Percentage" then
                Odds.Text = u6.FormatOddsPercent(v34 * 100, Odds.RichText);
            else
                Odds.Text = `1 in {string.format("%.2f", 1 / v34)}`;
            end;

            Odds.Visible = true;
        else
            Odds.Visible = false;
        end;

        ITEM_IMAGE.Image = GiveServiceCommon:GetImage(v.Reward);
        RewardName.TextColor3 = Color3.new(1, 1, 1);
        local UIStroke = v33.Frame.RewardName.UIStroke;

        if UIStroke then
            UIStroke.Color = ColorHelper:Darken(GiveServiceCommon:GetRarityColor(v.Reward));
        end;

        if RewardFrameCreatedCallback then
            RewardFrameCreatedCallback(v33, v, i);
        end;

        v33.LayoutOrder = v31 + 1000 + 1;
        v33.Parent = Holder.RewardScrollingFrame;
        table.insert(v32, {
            Type = v.Reward.Type,
            Value = v.Reward.Value
        });
        v33:SetAttribute("UUID", (`GenericRewardsUI_{v.Reward.Type}_{v.Reward.Value}`));
        v33:AddTag("ItemInfoHoverTag");
    end;

    ItemInfoHover:AddRewardTable("GenericRewardsUI", v32);

    if RewardsUIBuiltCallback then
        RewardsUIBuiltCallback(u23, Holder.RewardScrollingFrame);
    end;

    GuiController:Open(u23);

    if Breadcrumb then
        u1:Add(u23.Frame.ExitButton.Activated:Once(function() -- Line: 323
            -- upvalues: GuiController (ref), u23 (copy), Breadcrumb (copy), u1 (ref)
            GuiController:Close(u23);
            GuiController:Open(Breadcrumb);
            u1:Clean();
        end));

        return;
    end;

    u1:Add(u23.Frame.ExitButton.Activated:Once(function() -- Line: 329
        -- upvalues: GuiController (ref), u23 (copy), u1 (ref)
        GuiController:Close(u23);
        u1:Clean();
    end));
end;

function u6.Start(p35) -- Line: 336
    -- upvalues: GenericRewards_UI (copy), GuiController (copy)
    if GenericRewards_UI:FindFirstChild("Frame") then
        GenericRewards_UI.Frame.Active = true;
    end;

    GuiController:UsePopupAnims(GenericRewards_UI);
end;

task.spawn(u6.Start, u6);

return u6;