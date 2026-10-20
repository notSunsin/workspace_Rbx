-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.SeedData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.SeedPackOddsController);
require(ReplicatedStorage.Modules.PetEggOddsController);
require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
require(ReplicatedStorage.Modules.ColorHelper);
local GameEvents = ReplicatedStorage.GameEvents;
local FoodRewardsService_RE = GameEvents.FoodRewardsService_RE;
local ChooseRewardsUI = GameEvents.ChooseRewardsUI;
Item_Module.Return_All_Seed_Rarities();
local ChooseRewards_UI = Players.LocalPlayer.PlayerGui.ChooseRewards_UI;
local Items = ChooseRewards_UI.Frame.Main.Items;
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local UDim2_new_ret = UDim2.new(0.3, 0, 0.825, 0);
local UDim2_new_ret2 = UDim2.new(0.4, 0, 0.95, 0);
local u1 = Trove.new();
local u2 = Trove.new();
local u10 = {
    Open = function(p3: table, u4: userdata?) -- Line: 52, Name: Open
        -- upvalues: GuiController (copy), ChooseRewards_UI (copy), u1 (copy), DataService (copy), Notification (copy), Items (copy), SoundService (copy), ItemImageFinder (copy), FoodRewardsService_RE (copy), TweenService (copy), TweenInfo_new_ret (copy), UDim2_new_ret2 (copy), UDim2_new_ret (copy)
        GuiController:GetStateForGui(ChooseRewards_UI);
        u1:Destroy();

        for _, v in { "RerollButton", "TierOddsButton" } do
            local v5 = ChooseRewards_UI.Frame:FindFirstChild(v);

            if v5 then
                v5.Visible = false;
            end;
        end;

        local Data = DataService:GetData();

        if not Data then
            GuiController:Close(ChooseRewards_UI);

            return;
        end;

        local PendingRewards = Data.FoodConnoisseurEventData.PendingRewards;

        if #PendingRewards == 0 then
            Notification:CreateNotification("You have no rewards to claim!");
            GuiController:Close(ChooseRewards_UI);

            return;
        end;

        for _, child in Items:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        SoundService:PlayLocalSound(SoundService.Click);
        local v6 = 0;

        for _, v in PendingRewards do
            v6 = v6 + 1;
            local v7 = u1:Clone(Items.UIListLayout.Template);
            v7.Visible = true;
            local Title = v7:FindFirstChild("Title");
            local Vector = v7:FindFirstChild("Vector");
            Title.Text = v.ItemName;
            Vector.Image = ItemImageFinder(v.ItemName, v.ItemType);
            u1:Add(v7.Activated:Once(function() -- Line: 105
                -- upvalues: SoundService (ref), FoodRewardsService_RE (ref), v (copy), GuiController (ref), ChooseRewards_UI (ref), u1 (ref)
                SoundService:PlayLocalSound(SoundService.Click);
                FoodRewardsService_RE:FireServer(v.UUID);
                GuiController:Close(ChooseRewards_UI);
                u1:Clean();
            end));
            local u8 = TweenService:Create(v7, TweenInfo_new_ret, {
                Size = UDim2_new_ret2
            });
            local u9 = TweenService:Create(v7, TweenInfo_new_ret, {
                Size = UDim2_new_ret
            });
            u1:Add(u8);
            u1:Add(u9);
            u1:Add(v7.MouseEnter:Connect(function() -- Line: 124
                -- upvalues: SoundService (ref), u8 (copy)
                SoundService:PlayLocalSound(SoundService.Hover);
                u8:Play();
            end));
            u1:Add(v7.MouseLeave:Connect(function() -- Line: 130
                -- upvalues: u9 (copy)
                u9:Play();
            end));
            v7.Parent = Items;
            v7.LayoutOrder = v6;
        end;

        GuiController:Open(ChooseRewards_UI);

        if u4 then
            u1:Add(ChooseRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 236
                -- upvalues: GuiController (ref), ChooseRewards_UI (ref), u4 (copy), u1 (ref)
                GuiController:Close(ChooseRewards_UI);
                GuiController:Open(u4);
                u1:Clean();
            end));

            return;
        end;

        u1:Add(ChooseRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 242
            -- upvalues: GuiController (ref), ChooseRewards_UI (ref), u1 (ref)
            GuiController:Close(ChooseRewards_UI);
            u1:Clean();
        end));
    end
};

function u10.Start(p11) -- Line: 249
    -- upvalues: GuiController (copy), ChooseRewards_UI (copy), ChooseRewardsUI (copy), u10 (copy)
    GuiController:UsePopupAnims(ChooseRewards_UI);
    ChooseRewardsUI.OnClientEvent:Connect(function() -- Line: 252
        -- upvalues: u10 (ref)
        u10:Open();
    end);
end;

local u12 = false;
EventRotationController.EventUpdated:Connect(function(p13: string, p14: string) -- Line: 258, Name: OnEventUpdated
    -- upvalues: u2 (copy), u12 (ref), u10 (copy)
    if p14 ~= "CookingEvent" then
        u2:Clean();
        u12 = false;

        return;
    end;

    if u12 then
        return;
    end;

    u12 = true;
    u2:Clean();
    task.spawn(u10.Start, u10);
end);

return u10;