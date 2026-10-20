-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local TraderRewardData = require(ReplicatedStorage.Data.Events.TraderEvent.TraderRewardData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u1 = Trove.new();
local u2 = Trove.new();
local TraderRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("TraderEvent"):WaitForChild("TraderRewards_UI");
local Holder = TraderRewards_UI.Frame.Main.Holder;
local u18 = {
    Open = function(p3: table, u4: userdata?) -- Line: 25, Name: Open
        -- upvalues: u2 (copy), Holder (copy), DataService (copy), TraderRewardData (copy), ItemOddsController (copy), TraderRewards_UI (copy), ItemImageFinder (copy), ColorHelper (copy), GuiController (copy)
        u2:Destroy();
        Holder.Header.UIGradient.Color = ColorSequence.new(Color3.fromRGB(244, 197, 8), Color3.fromRGB(202, 158, 46));
        Holder.Header.Title.Text = "Potential Trader Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local Data = DataService:GetData();
        local v5 = {};
        local v6 = 0;

        for i = 1, 11 do
            local v7 = {
                Label = `{i}`,
                Key = i
            };
            table.insert(v5, v7);
            local _ = i;
        end;

        table.insert(v5, {
            Label = "12+",
            Key = 12
        });
        local v8 = {};

        for i in TraderRewardData.PartTwoRewardsData do
            table.insert(v8, i);
        end;

        table.sort(v8);

        for _, v in v8 do
            local v9 = {
                Label = `{v}+`,
                Key = v
            };
            table.insert(v5, v9);
        end;

        for _, v in v5 do
            local Label = v.Label;
            local Key = v.Key;
            v6 = v6 + 1000;
            local v10 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.TIER_TEMPLATE);
            v10.Title.Text = `STREAK: {Label}`;
            v10.LayoutOrder = v6;
            v10.Parent = Holder.RewardScrollingFrame;
            local v11;

            if Key <= 12 then
                v11 = TraderRewardData.RewardsData[Key];
            elseif Label == "12+" then
                v11 = TraderRewardData.RewardsData[12];
            else
                v11 = TraderRewardData.PartTwoRewardsData[Key];
            end;

            if v11 then
                if Data.PermanentGears["Booth Sign"] == true then
                    for i, v2 in v11 do
                        if v2.Name == "Booth Sign" then
                            table.remove(v11, i);
                        end;
                    end;
                end;

                table.sort(v11, function(p12, p13) -- Line: 114
                    return (p12.Chance or 0) > (p13.Chance or 0);
                end);
                local v14 = 0;

                for _, v2 in v11 do
                    v14 = v14 + (v2.Chance or 0);
                end;

                for _, v2 in v11 do
                    v6 = v6 + 1;
                    local v15 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
                    local Frame = v15.Frame;
                    local RewardName = Frame.RewardName;
                    local Odds = Frame.Odds;
                    local ITEM_IMAGE = Frame.ITEM_IMAGE;
                    local OddsButton = Frame.OddsButton;
                    local Name = v2.Name;
                    local v16 = v2.Quantity or 1;
                    local RewardType = v2.RewardType;

                    if v16 > 1 then
                        RewardName.Text = `x{v16} {Name}`;
                    else
                        RewardName.Text = Name;
                    end;

                    Odds.Text = `{string.format("%.2f", v2.Chance / v14 * 100)}%`;
                    Odds.Visible = true;
                    ItemOddsController:ConnectOddsButton({
                        Type = RewardType,
                        Value = Name
                    }, OddsButton, TraderRewards_UI);
                    ITEM_IMAGE.Image = ItemImageFinder(Name, RewardType);
                    RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
                    local UIStroke = RewardName:FindFirstChild("UIStroke");

                    if UIStroke and UIStroke:IsA("UIStroke") then
                        UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
                    end;

                    v15.LayoutOrder = v6 + 1000;
                    v15.Parent = Holder.RewardScrollingFrame;
                end;
            end;
        end;

        GuiController:Open(TraderRewards_UI);

        if u4 then
            u2:Add(TraderRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 172
                -- upvalues: GuiController (ref), TraderRewards_UI (ref), u4 (copy), u2 (ref)
                GuiController:Close(TraderRewards_UI);
                GuiController:Open(u4);
                u2:Clean();
            end));

            return;
        end;

        u2:Add(TraderRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 178
            -- upvalues: GuiController (ref), TraderRewards_UI (ref), u2 (ref)
            GuiController:Close(TraderRewards_UI);
            u2:Clean();
        end));
    end,

    Start = function(p17) -- Line: 185, Name: Start
        -- upvalues: GuiController (copy), TraderRewards_UI (copy)
        GuiController:UsePopupAnims(TraderRewards_UI);
    end
};
EventRotationClientBinder:Bind({
    EventSet = "TraderEvent",
    Script = script,

    OnStart = function() -- Line: 192, Name: OnStart
        -- upvalues: u18 (copy)
        task.spawn(u18.Start, u18);
    end,

    OnStop = function() -- Line: 193, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u18;