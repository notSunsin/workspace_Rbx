-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
require(ReplicatedStorage.Data.Events.FairyEvent.FairyMilestonesData);
local FairyMilestonesData = require(ReplicatedStorage.Data.Events.FairyEvent.FairyMilestonesData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local u1 = Trove.new();
Item_Module.Return_All_Seed_Rarities();
local FairyWishRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("FairyEvent"):WaitForChild("FairyWishRewards_UI");
local Holder = FairyWishRewards_UI.Frame.Main.Holder;
local u2 = Trove.new();
local u32 = {
    OpenTier = function(p3: table, u4: userdata?, p5: number, p6: boolean?) -- Line: 40, Name: OpenTier
        -- upvalues: GuiController (copy), FairyWishRewards_UI (copy), u2 (copy), Holder (copy), FairyMilestonesData (copy), SeedPackOddsController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(FairyWishRewards_UI);
        u2:Destroy();
        Holder.Header.UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 192, 255), Color3.fromRGB(32, 103, 255));
        Holder.Header.Title.Text = `Tier {p5} Rewards`;

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local v7 = FairyMilestonesData.Rewards[p5];

        if not v7 then
            warn("No rewards found for tier " .. tostring(p5));

            return;
        end;

        local _ = #v7;
        local table_clone_ret = table.clone(v7);
        table.sort(table_clone_ret, function(p8, p9) -- Line: 68
            return p8.Chance > p9.Chance;
        end);
        local v10 = 0;
        local v11 = 0;

        for _, v in table_clone_ret do
            v10 = v10 + (v.Chance or 0);
        end;

        for _, v in table_clone_ret do
            v11 = v11 + 1;
            local Reward = v.Reward;
            local v12 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
            local RewardName = v12.Frame.RewardName;
            local Odds = v12.Frame.Odds;
            local ITEM_IMAGE = v12.Frame.ITEM_IMAGE;

            if Reward.Type == "Seed Pack" then
                v12.Frame.OddsButton.Visible = true;
                v12.Frame.OddsButton.Activated:Connect(function() -- Line: 90
                    -- upvalues: SeedPackOddsController (ref), Reward (copy), FairyWishRewards_UI (ref)
                    SeedPackOddsController:Open(Reward.Value, FairyWishRewards_UI);
                end);
            elseif Reward.Type == "Egg" then
                v12.Frame.OddsButton.Visible = true;
                v12.Frame.OddsButton.Activated:Connect(function() -- Line: 95
                    -- upvalues: PetEggOddsController (ref), Reward (copy), FairyWishRewards_UI (ref)
                    PetEggOddsController:Open(Reward.Value, FairyWishRewards_UI);
                end);
            elseif Reward.Type == "Crate" then
                v12.Frame.OddsButton.Visible = true;
                v12.Frame.OddsButton.Activated:Connect(function() -- Line: 100
                    -- upvalues: CosmeticCrateOddsController (ref), Reward (copy), FairyWishRewards_UI (ref)
                    CosmeticCrateOddsController:Open(Reward.Value, FairyWishRewards_UI);
                end);
            else
                v12.Frame.OddsButton.Visible = false;
            end;

            local v13 = tostring(Reward.Value);
            local v14 = Reward.Quantity or 1;

            if v14 > 1 then
                v13 = "x" .. v14 .. " " .. Reward.Value;
            end;

            RewardName.Text = v13;

            if p6 then
                Odds.Text = string.format("%.2f", v.Chance / v10 * 100) .. "%";
                Odds.Visible = true;
            else
                Odds.Visible = false;
            end;

            ITEM_IMAGE.Image = ItemImageFinder(tostring(Reward.Value), Reward.Type);
            RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
            local UIStroke = v12.Frame.RewardName.UIStroke;

            if UIStroke then
                UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
            end;

            v12:AddTag("ItemInfoHoverTag");
            v12:SetAttribute("UUID", (`FairyRewardsUI_{Reward.Type}_{Reward.Value}`));
            v12.Parent = Holder.RewardScrollingFrame;
            v12.LayoutOrder = v11;
        end;

        GuiController:Open(FairyWishRewards_UI);

        if u4 then
            u2:Add(FairyWishRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 145
                -- upvalues: GuiController (ref), FairyWishRewards_UI (ref), u4 (copy), u2 (ref)
                GuiController:Close(FairyWishRewards_UI);
                GuiController:Open(u4);
                u2:Clean();
            end));

            return;
        end;

        u2:Add(FairyWishRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 151
            -- upvalues: GuiController (ref), FairyWishRewards_UI (ref), u2 (ref)
            GuiController:Close(FairyWishRewards_UI);
            u2:Clean();
        end));
    end,

    Open = function(p15: table, u16: userdata?, p17: boolean?) -- Line: 158, Name: Open
        -- upvalues: GuiController (copy), FairyWishRewards_UI (copy), u2 (copy), Holder (copy), FairyMilestonesData (copy), SeedPackOddsController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(FairyWishRewards_UI);
        u2:Destroy();
        Holder.Header.UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 192, 255), Color3.fromRGB(32, 103, 255));
        Holder.Header.Title.Text = "Fountain Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        for i, v in FairyMilestonesData.Rewards do
            local _ = #v;
            local table_clone_ret = table.clone(v);
            table.sort(table_clone_ret, function(p18, p19) -- Line: 181
                return p18.Chance > p19.Chance;
            end);
            local v20 = i;
            local v21 = 0;
            local v22 = 0;

            for _, v2 in table_clone_ret do
                v21 = v21 + (v2.Chance or 0);
            end;

            local v23 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.TIER_TEMPLATE);
            v23.Title.Text = `Tier {v20}`;
            v23.LayoutOrder = v20 * 1000;
            v23.Parent = Holder.RewardScrollingFrame;

            for _, v2 in table_clone_ret do
                v22 = v22 + 1;
                local Reward = v2.Reward;
                local v24 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
                local RewardName = v24.Frame.RewardName;
                local Odds = v24.Frame.Odds;
                local ITEM_IMAGE = v24.Frame.ITEM_IMAGE;

                if Reward.Type == "Seed Pack" then
                    v24.Frame.OddsButton.Visible = true;
                    v24.Frame.OddsButton.Activated:Connect(function() -- Line: 208
                        -- upvalues: SeedPackOddsController (ref), Reward (copy), FairyWishRewards_UI (ref)
                        SeedPackOddsController:Open(Reward.Value, FairyWishRewards_UI);
                    end);
                elseif Reward.Type == "Egg" then
                    v24.Frame.OddsButton.Visible = true;
                    v24.Frame.OddsButton.Activated:Connect(function() -- Line: 213
                        -- upvalues: PetEggOddsController (ref), Reward (copy), FairyWishRewards_UI (ref)
                        PetEggOddsController:Open(Reward.Value, FairyWishRewards_UI);
                    end);
                elseif Reward.Type == "Crate" then
                    v24.Frame.OddsButton.Visible = true;
                    v24.Frame.OddsButton.Activated:Connect(function() -- Line: 218
                        -- upvalues: CosmeticCrateOddsController (ref), Reward (copy), FairyWishRewards_UI (ref)
                        CosmeticCrateOddsController:Open(Reward.Value, FairyWishRewards_UI);
                    end);
                else
                    v24.Frame.OddsButton.Visible = false;
                end;

                local v25 = tostring(Reward.Value);
                local v26 = Reward.Quantity or 1;

                if v26 > 1 then
                    v25 = "x" .. v26 .. " " .. Reward.Value;
                end;

                RewardName.Text = v25;

                if p17 then
                    Odds.Text = string.format("%.2f", v2.Chance / v21 * 100) .. "%";
                    Odds.Visible = true;
                else
                    Odds.Visible = false;
                end;

                ITEM_IMAGE.Image = ItemImageFinder(tostring(Reward.Value), Reward.Type);
                RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
                local UIStroke = v24.Frame.RewardName.UIStroke;

                if UIStroke then
                    UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
                end;

                v24:AddTag("ItemInfoHoverTag");
                v24:SetAttribute("UUID", (`FairyRewardsUI_{Reward.Type}_{Reward.Value}`));
                v24.LayoutOrder = v20 * 1000 + v22 + 1;
                v24.Parent = Holder.RewardScrollingFrame;
            end;
        end;

        GuiController:Open(FairyWishRewards_UI);

        if u16 then
            u2:Add(FairyWishRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 264
                -- upvalues: GuiController (ref), FairyWishRewards_UI (ref), u16 (copy), u2 (ref)
                GuiController:Close(FairyWishRewards_UI);
                GuiController:Open(u16);
                u2:Clean();
            end));

            return;
        end;

        u2:Add(FairyWishRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 270
            -- upvalues: GuiController (ref), FairyWishRewards_UI (ref), u2 (ref)
            GuiController:Close(FairyWishRewards_UI);
            u2:Clean();
        end));
    end,

    Start = function(p27) -- Line: 277, Name: Start
        -- upvalues: GuiController (copy), FairyWishRewards_UI (copy), FairyMilestonesData (copy), ItemInfoHover (copy)
        GuiController:UsePopupAnims(FairyWishRewards_UI);
        local v28 = {};
        local v29 = {};

        for _, v in FairyMilestonesData.Rewards do
            for _, v2 in v do
                if not v28[`{v2.Reward.Value}`] then
                    table.insert(v29, v2.Reward);
                end;
            end;
        end;

        ItemInfoHover:AddRewardTable("FairyRewardsUI", v29);
    end,

    OverwriteTitle = function(p30: table, p31: string) -- Line: 294, Name: OverwriteTitle
        -- upvalues: Holder (copy)
        Holder.Header.Title.Text = p31;
    end
};
EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    Script = script,

    OnStart = function() -- Line: 301, Name: OnStart
        -- upvalues: u32 (copy)
        task.spawn(u32.Start, u32);
    end,

    OnStop = function() -- Line: 302, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u32;