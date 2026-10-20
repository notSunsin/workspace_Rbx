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
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
require(ReplicatedStorage.Modules.DataService);
local DeepClone = require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
Item_Module.Return_All_Seed_Rarities();
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found");
local ClaimableRewards_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ClaimableRewards_UI");
local u1 = Trove.new();
local v19 = {
    Open = function(p2: table, u3: table) -- Line: 79, Name: Open
        -- upvalues: ClaimableRewards_UI (copy), GuiController (copy), u1 (copy), DeepClone (copy), SeedPackOddsController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), GiveServiceCommon (copy), ColorHelper (copy)
        local DisplayOdds = u3.DisplayOdds;
        local v4 = DisplayOdds == nil and true or DisplayOdds;
        local v5 = u3.RewardTemplate or nil;
        local v6 = u3.Title or "Rewards";
        local RewardData = u3.RewardData;
        local RewardFrameCreatedCallback = u3.RewardFrameCreatedCallback;
        local Breadcrumb = u3.Breadcrumb;
        local v7 = u3.ChanceDisplayMode or "Percentage";
        local u8 = u3.RewardsUIOverride or ClaimableRewards_UI;
        local Holder = u8.Frame.Main.Holder;
        local RewardsUIBuiltCallback = u3.RewardsUIBuiltCallback;
        local RewardsUIPreBuildCallback = u3.RewardsUIPreBuildCallback;
        local Information = u3.Information;
        GuiController:GetStateForGui(u8);
        u1:Destroy();
        local v9 = v5 or Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE;
        Holder.Header.Title.Text = v6;
        local Information2 = u8.Frame.Main:FindFirstChild("Information");

        if Information2 and Information2:IsA("Frame") then
            local v10;

            if Information == nil then
                v10 = false;
            else
                v10 = Information ~= "";
            end;

            Information2.Visible = v10;
            local Text = Information2:FindFirstChild("Text");

            if Text and Text:IsA("TextLabel") then
                Text.Text = Information or "";
            end;
        end;

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local _ = #RewardData;
        local v11 = DeepClone(RewardData);
        table.sort(v11, function(p12, p13) -- Line: 123
            return (p12.Weight or 1) > (p13.Weight or 1);
        end);
        local v14 = 0;
        local v15 = 0;

        for _, v in v11 do
            v14 = v14 + (v.Weight or 0);
        end;

        if RewardsUIPreBuildCallback then
            RewardsUIPreBuildCallback(u8, Holder.ScrollingFrame);
        end;

        for i, v in v11 do
            v15 = v15 + 1;
            local v16 = u1:Clone(v9);
            local RewardName = v16.Frame.RewardName;
            local Odds = v16.Frame.Odds;
            local ITEM_IMAGE = v16.Frame.ITEM_IMAGE;

            if v.Reward.Type == "Seed Pack" then
                v16.Frame.OddsButton.Visible = true;
                v16.Frame.OddsButton.Activated:Connect(function() -- Line: 148
                    -- upvalues: SeedPackOddsController (ref), v (copy), u8 (copy)
                    SeedPackOddsController:Open(v.Reward.Value, u8);
                end);
            elseif v.Reward.Type == "Egg" then
                v16.Frame.OddsButton.Visible = true;
                v16.Frame.OddsButton.Activated:Connect(function() -- Line: 153
                    -- upvalues: PetEggOddsController (ref), v (copy), u8 (copy)
                    PetEggOddsController:Open(v.Reward.Value, u8);
                end);
            elseif v.Reward.Type == "Crate" then
                v16.Frame.OddsButton.Visible = true;
                v16.Frame.OddsButton.Activated:Connect(function() -- Line: 158
                    -- upvalues: CosmeticCrateOddsController (ref), v (copy), u8 (copy)
                    CosmeticCrateOddsController:Open(v.Reward.Value, u8);
                end);
            else
                v16.Frame.OddsButton.Visible = false;
            end;

            RewardName.Text = GiveServiceCommon:Format(v.Reward);

            if v4 then
                local v17 = v.Weight / v14;

                if v7 == "Percentage" then
                    Odds.Text = string.format("%.2f", v17 * 100) .. "%";
                else
                    Odds.Text = `1 in {string.format("%.2f", 1 / v17)}`;
                end;

                Odds.Visible = true;
            else
                Odds.Visible = false;
            end;

            ITEM_IMAGE.Image = GiveServiceCommon:GetImage(v.Reward);
            RewardName.TextColor3 = Color3.new(1, 1, 1);
            local UIStroke = v16.Frame.RewardName.UIStroke;

            if UIStroke then
                UIStroke.Color = ColorHelper:Darken(GiveServiceCommon:GetRarityColor(v.Reward));
            end;

            if RewardFrameCreatedCallback then
                RewardFrameCreatedCallback(v16, v, i);
            end;

            v16.LayoutOrder = v15 + 1000 + 1;
            v16.Parent = Holder.RewardScrollingFrame;
        end;

        if RewardsUIBuiltCallback then
            RewardsUIBuiltCallback(u8, Holder.ScrollingFrame);
        end;

        GuiController:Open(u8);

        if Breadcrumb then
            u1:Add(u8.Frame.ExitButton.Activated:Once(function() -- Line: 211
                -- upvalues: GuiController (ref), u8 (copy), Breadcrumb (copy), u1 (ref)
                GuiController:Close(u8);
                GuiController:Open(Breadcrumb);
                u1:Clean();
            end));
        else
            u1:Add(u8.Frame.ExitButton.Activated:Once(function() -- Line: 217
                -- upvalues: GuiController (ref), u8 (copy), u1 (ref)
                GuiController:Close(u8);
                u1:Clean();
            end));
        end;

        if u3.ClaimCallback then
            u1:Add(u8.Frame.PurchaseButton.Main.SENSOR.Activated:Connect(function() -- Line: 224
                -- upvalues: GuiController (ref), u8 (copy), u1 (ref), u3 (copy)
                GuiController:Close(u8);
                u1:Clean();
                u3.ClaimCallback();
            end));
        end;

        if u3.CloseCallback then
            u1:Add(u8.Frame.ExitButton.Activated:Connect(function() -- Line: 232
                -- upvalues: GuiController (ref), u8 (copy), u1 (ref), u3 (copy)
                GuiController:Close(u8);
                u1:Clean();
                u3.CloseCallback();
            end));
        end;

        if u3.MarkAsClaimed then
            u8.Frame.PurchaseButton.Main.Price.Text = "CLAIMED";
            u8.Frame.PurchaseButton.Main.UIGradient.Color = ColorSequence.new(Color3.new(0.75, 0.2, 0.2));
            u8.Frame.PurchaseButton.Main.UIStroke.Color = Color3.new(0.75, 0.2, 0.2);
            u8.Frame.PurchaseButton.Main.Price.UIStroke.Color = Color3.new(0.75, 0.2, 0.2);
            u8.Frame.PurchaseButton.Main.SENSOR.Active = false;
            u8.Frame.PurchaseButton.Main.Details.RadialGradient.ImageColor3 = Color3.new(1, 1, 1);
        end;
    end,

    Start = function(p18) -- Line: 249, Name: Start
        -- upvalues: ClaimableRewards_UI (copy), GuiController (copy)
        if ClaimableRewards_UI:FindFirstChild("Frame") then
            ClaimableRewards_UI.Frame.Active = true;
        end;

        GuiController:UsePopupAnims(ClaimableRewards_UI);
    end
};
task.spawn(v19.Start, v19);

return v19;