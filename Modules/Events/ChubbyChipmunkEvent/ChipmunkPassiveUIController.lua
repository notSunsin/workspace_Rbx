-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.SeedPackOddsController);
require(ReplicatedStorage.Modules.PetEggOddsController);
require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local AcornRewardData = require(ReplicatedStorage.Data.Events.ChubbyChipmunkEvent.AcornRewardData);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = Trove.new();
Item_Module.Return_All_Seed_Rarities();
local PlayerGui = Players.LocalPlayer.PlayerGui;
local ChipmunkPassiveRewards_UI = PlayerGui:WaitForChild("Events"):WaitForChild("ChubbyChipmunkEvent"):WaitForChild("ChipmunkPassiveRewards_UI");
local ChipmunkPassiveRewardOdds = PlayerGui:WaitForChild("Events"):WaitForChild("ChubbyChipmunkEvent"):WaitForChild("ChipmunkPassiveRewardOdds");
local Holder = ChipmunkPassiveRewards_UI.Frame.Main.Holder;
local u2 = Trove.new();
local u16 = {
    Open = function(p3: table, u4: userdata?, p5: boolean?) -- Line: 34, Name: Open
        -- upvalues: GuiController (copy), ChipmunkPassiveRewards_UI (copy), u2 (copy), Holder (copy), AcornRewardData (copy), ItemOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(ChipmunkPassiveRewards_UI);
        u2:Destroy();
        Holder.Header.UIGradient.Color = ColorSequence.new(Color3.fromRGB(189, 157, 39), Color3.fromRGB(91, 59, 26));
        Holder.Header.Title.Text = "Chipmunk Passive Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        for _, v in AcornRewardData.RewardSets[1] do
            local _ = #v;
            local table_clone_ret = table.clone(v);
            table.sort(table_clone_ret, function(p6, p7) -- Line: 57
                return p6.Chance > p7.Chance;
            end);
            local v8 = 0;
            local v9 = 0;

            for _, v2 in table_clone_ret do
                v8 = v8 + (v2.Chance or 0);
            end;

            for _, v2 in table_clone_ret do
                v9 = v9 + 1;
                local v10 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
                local RewardName = v10.Frame.RewardName;
                local Odds = v10.Frame.Odds;
                local ITEM_IMAGE = v10.Frame.ITEM_IMAGE;
                ItemOddsController:ConnectOddsButton(v2, v10.Frame.OddsButton, ChipmunkPassiveRewards_UI);
                local v11 = tostring(v2.Value);
                local v12 = v2.Quantity or 1;

                if v12 > 1 then
                    v11 = "x" .. v12 .. " " .. v2.Value;
                end;

                RewardName.Text = v11;

                if p5 then
                    Odds.Text = string.format("%.2f", v2.Chance / v8 * 100) .. "%";
                    Odds.Visible = true;
                else
                    Odds.Visible = false;
                end;

                ITEM_IMAGE.Image = ItemImageFinder(tostring(v2.Value), v2.Type);
                RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
                local UIStroke = v10.Frame.RewardName.UIStroke;

                if UIStroke then
                    UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
                end;

                v10.LayoutOrder = v9 + 1000 + 1;
                v10.Parent = Holder.RewardScrollingFrame;
            end;
        end;

        GuiController:Open(ChipmunkPassiveRewards_UI);

        if u4 then
            u2:Add(ChipmunkPassiveRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 114
                -- upvalues: GuiController (ref), ChipmunkPassiveRewards_UI (ref), u4 (copy), u2 (ref)
                GuiController:Close(ChipmunkPassiveRewards_UI);
                GuiController:Open(u4);
                u2:Clean();
            end));

            return;
        end;

        u2:Add(ChipmunkPassiveRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 120
            -- upvalues: GuiController (ref), ChipmunkPassiveRewards_UI (ref), u2 (ref)
            GuiController:Close(ChipmunkPassiveRewards_UI);
            u2:Clean();
        end));
    end,

    Start = function(p13) -- Line: 127, Name: Start
        -- upvalues: GuiController (copy), ChipmunkPassiveRewards_UI (copy), ChipmunkPassiveRewardOdds (copy)
        GuiController:UsePopupAnims(ChipmunkPassiveRewards_UI);
        ChipmunkPassiveRewardOdds.Enabled = true;
    end,

    OverwriteTitle = function(p14: table, p15: string) -- Line: 133, Name: OverwriteTitle
        -- upvalues: Holder (copy)
        Holder.Header.Title.Text = p15;
    end
};
EventRotationClientBinder:Bind({
    EventSet = "ChubbyChipmunkEvent",
    Script = script,

    OnStart = function() -- Line: 140, Name: OnStart
        -- upvalues: u16 (copy)
        task.spawn(u16.Start, u16);
    end,

    OnStop = function() -- Line: 141, Name: OnStop
        -- upvalues: u1 (copy), ChipmunkPassiveRewardOdds (copy)
        u1:Clean();
        ChipmunkPassiveRewardOdds.Enabled = false;
    end
});

return u16;