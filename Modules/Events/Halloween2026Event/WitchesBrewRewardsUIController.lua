-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local WitchesBrew2026RewardData = require(ReplicatedStorage.Data.Events.Halloween2026Event.WitchesBrew2026RewardData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local u1 = Trove.new();
local u2 = Trove.new();
local WitchesBrewRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("Halloween2026Event"):WaitForChild("WitchesBrewRewards_UI");
local Holder = WitchesBrewRewards_UI.Frame.Main.Holder;
local u3 = {};

local function GetTotalChance(p4) -- Line: 31
    local v5 = 0;

    for _, v in p4 do
        v5 = v5 + (v.Chance or 1);
    end;

    return v5;
end;

local function AddCurrencyReward(p6: number, p7: table) -- Line: 48
    -- upvalues: Holder (copy), u2 (copy), ItemOddsController (copy), WitchesBrewRewards_UI (copy), ItemNameFinder (copy), ColorHelper (copy), ItemImageFinder (copy)
    local v8 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
    ItemOddsController:ConnectOddsButton(p7, v8.Frame.OddsButton, WitchesBrewRewards_UI);
    local Odds = v8.Frame.Odds;
    Odds.Text = `{string.format("%.2f", 100)}%`;
    Odds.Visible = true;
    local RewardName = v8.Frame.RewardName;
    local Min = p7.QuantityRange.Min;
    local Max = p7.QuantityRange.Max;
    RewardName.Text = `{ItemNameFinder(tostring(p7.Value), p7.Type)} x{Min}-{Max}`;
    RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
    local UIStroke = v8.Frame.RewardName.UIStroke;

    if UIStroke then
        UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
    end;

    v8.Frame.ITEM_IMAGE.Image = ItemImageFinder(tostring(p7.Value), p7.Type);
    v8.LayoutOrder = p6 + 1 + 1;
    v8.Parent = Holder.RewardScrollingFrame;
    v8:SetAttribute("UUID", (`WitchesBrew2026_{p7.Type}_{p7.Value}`));
    v8:AddTag("ItemInfoHoverTag");
end;

local function PopulateRewards(p9: any, p10: number, p11: number) -- Line: 84
    -- upvalues: Holder (copy), u2 (copy), ItemOddsController (copy), WitchesBrewRewards_UI (copy), ColorHelper (copy), ItemImageFinder (copy)
    local REWARDTRACK_TEMPLATE = Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE;
    local v12 = 0;

    for _, v in p9 do
        v12 = v12 + (v.Chance or 1);
    end;

    for _, v in p9 do
        p10 = p10 + 1;
        local v13 = u2:Clone(REWARDTRACK_TEMPLATE);
        ItemOddsController:ConnectOddsButton(v, v13.Frame.OddsButton, WitchesBrewRewards_UI);
        local Odds = v13.Frame.Odds;
        Odds.Text = `{string.format("%.2f", (v.Chance or 1) / v12 * p11 * 100)}%`;
        Odds.Visible = true;
        local RewardName = v13.Frame.RewardName;
        local v14 = `{v.Value}`;
        local v15 = v.Quantity or 1;

        if v15 > 1 then
            v14 = `{v.Value} x{v15}`;
        end;

        RewardName.Text = v14;
        RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
        local UIStroke = v13.Frame.RewardName.UIStroke;

        if UIStroke then
            UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
        end;

        v13.Frame.ITEM_IMAGE.Image = ItemImageFinder(tostring(v.Value), v.Type);
        v13.LayoutOrder = p10 + 1;
        v13.Parent = Holder.RewardScrollingFrame;
        v13:SetAttribute("UUID", (`WitchesBrew2026_{v.Type}_{v.Value}`));
        v13:AddTag("ItemInfoHoverTag");
    end;
end;

function u3.Open(p16) -- Line: 127
    -- upvalues: GuiController (copy), WitchesBrewRewards_UI (copy), u2 (copy), Holder (copy), AddCurrencyReward (copy), PopulateRewards (copy), WitchesBrew2026RewardData (copy)
    GuiController:GetStateForGui(WitchesBrewRewards_UI);
    u2:Destroy();

    for _, child in Holder.RewardScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    local TIER_TEMPLATE = Holder.RewardScrollingFrame.UIListLayout.TIER_TEMPLATE;
    local v17 = u2:Clone(TIER_TEMPLATE);
    v17.Title.Text = "Normal Contributor Rewards (50% chance of one reward)";
    v17.LayoutOrder = 100;
    v17.Parent = Holder.RewardScrollingFrame;
    AddCurrencyReward(101, {
        Type = "Currency",
        Value = "CandyCorn",
        QuantityRange = {
            Min = 5,
            Max = 10
        }
    });
    PopulateRewards(WitchesBrew2026RewardData.Rewards, 102, 0.5);
    local v18 = u2:Clone(TIER_TEMPLATE);
    v18.Title.Text = "Top Contributor Rewards (one guaranteed, 3+ players, plus the normal 50% roll)";
    v18.LayoutOrder = 200;
    v18.Parent = Holder.RewardScrollingFrame;
    AddCurrencyReward(201, {
        Type = "Currency",
        Value = "CandyCorn",
        QuantityRange = {
            Min = 5,
            Max = 20
        }
    });
    PopulateRewards(WitchesBrew2026RewardData.TopContributorRewards, 202, 1);
end;

function u3.Start(p19) -- Line: 171
    -- upvalues: GuiController (copy), WitchesBrewRewards_UI (copy), u3 (copy), u1 (copy), ItemInfoHover (copy), WitchesBrew2026RewardData (copy)
    GuiController:UsePopupAnims(WitchesBrewRewards_UI);
    u3:Open();
    u1:Add(WitchesBrewRewards_UI.Frame.ExitButton.Activated:Connect(function() -- Line: 175
        -- upvalues: GuiController (ref), WitchesBrewRewards_UI (ref)
        GuiController:Close(WitchesBrewRewards_UI);
    end));
    ItemInfoHover:AddRewardTable("WitchesBrew2026", WitchesBrew2026RewardData.Rewards);
    ItemInfoHover:AddRewardTable("WitchesBrew2026", { {
            Type = "Currency",
            Value = "CandyCorn"
        } });
end;

EventRotationClientBinder:Bind({
    EventSet = "Halloween2026Event",
    Script = script,

    OnStart = function() -- Line: 189, Name: OnStart
        -- upvalues: u3 (copy)
        task.spawn(u3.Start, u3);
    end,

    OnStop = function() -- Line: 190, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u3;