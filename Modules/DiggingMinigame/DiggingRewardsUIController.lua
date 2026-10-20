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
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local DiggingRewardData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingRewardData);
require(ReplicatedStorage.Data.DiggingMinigame.DiggingEventConfigData);
local DiggingMinigameUtils = require(ReplicatedStorage.Modules.DiggingMinigame.DiggingMinigameUtils);
require(ReplicatedStorage.Modules.GiveServiceCommon);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
Item_Module.Return_All_Seed_Rarities();
local DiggingRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("DiggingRewards_UI");
local Holder = DiggingRewards_UI.Frame.Main.Holder;
local u1 = Trove.new();
local v16 = {
    Open = function(p2: table, u3: userdata?, p4: boolean?) -- Line: 32, Name: Open
        -- upvalues: GuiController (copy), DiggingRewards_UI (copy), u1 (copy), Holder (copy), DiggingMinigameUtils (copy), DiggingRewardData (copy), ItemOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(DiggingRewards_UI);
        u1:Destroy();
        Holder.Header.UIGradient.Color = ColorSequence.new(Color3.fromRGB(244, 197, 8), Color3.fromRGB(202, 158, 46));
        Holder.Header.Title.Text = "Potential Digging Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local Theme = DiggingMinigameUtils:GetTheme();

        if not Theme then
            warn("No Theme found");

            return;
        end;

        if Theme == "DISABLED" then
            return;
        end;

        local v5 = DiggingRewardData.RewardSets[Theme] or {};
        table.sort(v5, function(p6, p7) -- Line: 56
            return p6.Chance > p7.Chance;
        end);
        local v8 = 0;

        for _, v in v5 do
            v8 = v8 + (v.Chance or 0);
        end;

        local v9 = 0;

        for _, v in v5 do
            v9 = v9 + 1;
            local v10 = u1:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
            local RewardName = v10.Frame.RewardName;
            local Odds = v10.Frame.Odds;
            local ITEM_IMAGE = v10.Frame.ITEM_IMAGE;
            ItemOddsController:ConnectOddsButton(v, v10.Frame.OddsButton, DiggingRewards_UI);
            local v11 = tostring(v.Value);
            local v12 = v.Quantity or 1;

            if v12 > 1 then
                v11 = "x" .. v12 .. " " .. v.Value;
            end;

            RewardName.Text = v11;
            Odds.Text = string.format("%.2f", v.Chance / v8 * 100) .. "%";
            Odds.Visible = true;
            ITEM_IMAGE.Image = ItemImageFinder(tostring(v.Value), v.Type);
            RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
            local UIStroke = v10.Frame.RewardName.UIStroke;

            if UIStroke then
                UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
            end;

            v10.LayoutOrder = v9 + 1000 + 1;
            v10.Parent = Holder.RewardScrollingFrame;
        end;

        GuiController:Open(DiggingRewards_UI);

        if u3 then
            u1:Add(DiggingRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 113
                -- upvalues: GuiController (ref), DiggingRewards_UI (ref), u3 (copy), u1 (ref)
                GuiController:Close(DiggingRewards_UI);
                GuiController:Open(u3);
                u1:Clean();
            end));

            return;
        end;

        u1:Add(DiggingRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 119
            -- upvalues: GuiController (ref), DiggingRewards_UI (ref), u1 (ref)
            GuiController:Close(DiggingRewards_UI);
            u1:Clean();
        end));
    end,

    Start = function(p13) -- Line: 126, Name: Start
        -- upvalues: GuiController (copy), DiggingRewards_UI (copy)
        GuiController:UsePopupAnims(DiggingRewards_UI);
    end,

    OverwriteTitle = function(p14: table, p15: string) -- Line: 130, Name: OverwriteTitle
        -- upvalues: Holder (copy)
        Holder.Header.Title.Text = p15;
    end
};
task.spawn(v16.Start, v16);

return v16;