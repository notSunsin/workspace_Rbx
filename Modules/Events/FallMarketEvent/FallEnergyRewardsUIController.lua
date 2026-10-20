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
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local FallMarketRewardsData = require(ReplicatedStorage.Data.Events.FallMarketEvent.FallMarketRewardsData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
Item_Module.Return_All_Seed_Rarities();
local FallEnergyRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("FallMarketEvent"):WaitForChild("FallEnergyRewards_UI");
local Holder = FallEnergyRewards_UI.Frame.Main.Holder;
local u1 = Trove.new();
local u2 = Trove.new();
local u3 = {
    [50] = "COMMON",
    [100] = "UNCOMMON",
    [150] = "RARE",
    [200] = "LEGENDARY",
    [250] = "MYTHICAL",
    [350] = "DIVINE",
    [500] = "PRISMATIC"
};
local u13 = {
    Open = function(p4) -- Line: 46, Name: Open
        -- upvalues: GuiController (copy), FallEnergyRewards_UI (copy), u2 (copy), Holder (copy), FallMarketRewardsData (copy), u3 (copy), ItemOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(FallEnergyRewards_UI);
        u2:Destroy();
        Holder.Header.Title.Text = "Potential Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        for i, v in FallMarketRewardsData:GetFallEnergyRewards() do
            local _ = #v;
            local v5 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.TIER_TEMPLATE);
            v5.Title.Text = `{u3[i]}: {i} Fall Energy - One of the following:`;
            v5.LayoutOrder = i * 1000;
            v5.Parent = Holder.RewardScrollingFrame;
            local v6 = i;
            local v7 = 0;

            for _, v2 in v do
                v7 = v7 + 1;
                local v8 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
                local RewardName = v8.Frame.RewardName;
                local _ = v8.Frame.Odds;
                local ITEM_IMAGE = v8.Frame.ITEM_IMAGE;
                ItemOddsController:ConnectOddsButton(v2, v8.Frame.OddsButton, FallEnergyRewards_UI);
                local v9 = tostring(v2.Value);
                local v10 = v2.Quantity or 1;

                if v10 > 1 then
                    v9 = "x" .. v10 .. " " .. v2.Value;
                end;

                RewardName.Text = v9;
                ITEM_IMAGE.Image = ItemImageFinder(tostring(v2.Value), v2.Type);
                RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
                local UIStroke = v8.Frame.RewardName.UIStroke;

                if UIStroke then
                    UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
                end;

                v8.LayoutOrder = v6 * 1000 + v7 + 1;
                v8.Parent = Holder.RewardScrollingFrame;
                v8:SetAttribute("UUID", (`FallEnergy_{v2.Type}_{v2.Value}`));
                v8:AddTag("ItemInfoHoverTag");
            end;
        end;
    end,

    OverwriteTitle = function(p11: table, p12: string) -- Line: 107, Name: OverwriteTitle
        -- upvalues: Holder (copy)
        Holder.Header.Title.Text = p12;
    end
};

function u13.Start(p14) -- Line: 111
    -- upvalues: GuiController (copy), FallEnergyRewards_UI (copy), u13 (copy), u1 (copy), ItemInfoHover (copy), FallMarketRewardsData (copy)
    GuiController:UsePopupAnims(FallEnergyRewards_UI);
    u13:Open();
    u1:Add(FallEnergyRewards_UI.Frame.ExitButton.Activated:Connect(function() -- Line: 115
        -- upvalues: GuiController (ref), FallEnergyRewards_UI (ref)
        GuiController:Close(FallEnergyRewards_UI);
    end));
    ItemInfoHover:AddRewardTable("FallEnergy", FallMarketRewardsData:GetFallEnergyRewardsTierless());
end;

EventRotationClientBinder:Bind({
    EventSet = "FallMarketEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 126, Name: OnStart
        -- upvalues: u13 (copy)
        task.spawn(u13.Start, u13);
    end,

    OnStop = function() -- Line: 127, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u13;