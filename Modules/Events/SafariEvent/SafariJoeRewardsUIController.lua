-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.SeedData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local SafariEventRewardData = require(ReplicatedStorage.Data.Events.SafariEvent.SafariEventRewardData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local u1 = Trove.new();
Item_Module.Return_All_Seed_Rarities();
local SafariJoeRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("SafariEvent"):WaitForChild("SafariJoeRewards_UI");
local Holder = SafariJoeRewards_UI.Frame.Main.Holder;
local u2 = Trove.new();
local u20 = {
    Open = function(p3: table, p4: userdata?, p5: boolean?) -- Line: 34, Name: Open
        -- upvalues: GuiController (copy), SafariJoeRewards_UI (copy), u2 (copy), Holder (copy), SafariEventRewardData (copy), ItemOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(SafariJoeRewards_UI);
        u2:Destroy();
        Holder.Header.Title.Text = "Safari Joe Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        for i, v in SafariEventRewardData.SafariJoeRewards.Rewards do
            local _ = #v;
            local table_clone_ret = table.clone(v);
            table.sort(table_clone_ret, function(p6, p7) -- Line: 57
                return p6.Chance > p7.Chance;
            end);
            local v8 = i;
            local v9 = 0;
            local v10 = 0;

            for _, v2 in table_clone_ret do
                v9 = v9 + (v2.Chance or 0);
            end;

            local v11 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.TIER_TEMPLATE);
            v11.Title.Text = `Required Pet Value: {v8}`;
            v11.LayoutOrder = v8 * 1000;
            v11.Parent = Holder.RewardScrollingFrame;

            for _, v2 in table_clone_ret do
                v10 = v10 + 1;
                local v12 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
                local RewardName = v12.Frame.RewardName;
                local Odds = v12.Frame.Odds;
                local ITEM_IMAGE = v12.Frame.ITEM_IMAGE;
                ItemOddsController:ConnectOddsButton(v2, v12.Frame.OddsButton, SafariJoeRewards_UI);
                local v13 = tostring(v2.Value);
                local v14 = v2.Quantity or 1;

                if v14 > 1 then
                    v13 = "x" .. v14 .. " " .. v2.Value;
                end;

                RewardName.Text = v13;
                Odds.Text = string.format("%.2f", v2.Chance / v9 * 100) .. "%";
                Odds.Visible = true;
                ITEM_IMAGE.Image = ItemImageFinder(tostring(v2.Value), v2.Type);
                RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
                local UIStroke = v12.Frame.RewardName.UIStroke;

                if UIStroke then
                    UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
                end;

                v12:AddTag("ItemInfoHoverTag");
                v12:SetAttribute("UUID", (`SafariJoeRewards_{v2.Type}_{v2.Value}`));
                v12.LayoutOrder = v8 * 1000 + v10 + 1;
                v12.Parent = Holder.RewardScrollingFrame;
            end;
        end;

        GuiController:Open(SafariJoeRewards_UI);
    end,

    OverwriteTitle = function(p15: table, p16: string) -- Line: 131, Name: OverwriteTitle
        -- upvalues: Holder (copy)
        Holder.Header.Title.Text = p16;
    end,

    Start = function(p17) -- Line: 135, Name: Start
        -- upvalues: SafariEventRewardData (copy), ItemInfoHover (copy), u1 (copy), SafariJoeRewards_UI (copy), GuiController (copy), u2 (copy)
        local v18 = {};
        local v19 = {};

        for _, v in SafariEventRewardData.SafariJoeRewards.Rewards do
            for _, v2 in v do
                if not v18[`{v2.Value}`] then
                    table.insert(v19, v2);
                end;
            end;
        end;

        ItemInfoHover:AddRewardTable("SafariJoeRewards", v19);
        u1:Add(SafariJoeRewards_UI.Frame.ExitButton.Activated:Connect(function() -- Line: 149
            -- upvalues: GuiController (ref), SafariJoeRewards_UI (ref), u2 (ref)
            GuiController:Close(SafariJoeRewards_UI);
            u2:Clean();
        end));
        GuiController:UsePopupAnims(SafariJoeRewards_UI);
    end
};
EventRotationClientBinder:Bind({
    EventSet = "SafariEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 161, Name: OnStart
        -- upvalues: u20 (copy)
        task.spawn(u20.Start, u20);
    end,

    OnStop = function() -- Line: 162, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u20;