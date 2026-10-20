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
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
require(ReplicatedStorage.Modules.DataService);
local DeepClone = require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
Item_Module.Return_All_Seed_Rarities();
local AdminQuestRewards_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("AdminQuestRewards_UI");
local Holder = AdminQuestRewards_UI.Frame.Main.Holder;
local PossibleRewards = require(ReplicatedStorage.Data.QuestData.QuestContainers.AdminQuest01).CustomData.PossibleRewards;
local u1 = Trove.new();
local v17 = {
    Open = function(p2: table, u3: userdata?, p4: boolean?) -- Line: 39, Name: Open
        -- upvalues: GuiController (copy), AdminQuestRewards_UI (copy), u1 (copy), Holder (copy), PossibleRewards (copy), DeepClone (copy), SeedPackOddsController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
        GuiController:GetStateForGui(AdminQuestRewards_UI);
        u1:Destroy();
        Holder.Header.Title.Text = "Admin Quest Rewards";

        for _, child in Holder.RewardScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local v5 = PossibleRewards;
        local _ = #v5;
        local v6 = DeepClone(v5);
        table.sort(v6, function(p7, p8) -- Line: 65
            return (p7.Chance or 1) > (p8.Chance or 1);
        end);
        local v9 = 0;
        local v10 = 0;

        for _, v in v6 do
            v9 = v9 + (v.Chance or 1);
        end;

        for _, v in v6 do
            v10 = v10 + 1;
            local v11 = u1:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
            local RewardName = v11.Frame.RewardName;
            local Odds = v11.Frame.Odds;
            local ITEM_IMAGE = v11.Frame.ITEM_IMAGE;

            if v.Type == "Seed Pack" then
                v11.Frame.OddsButton.Visible = true;
                v11.Frame.OddsButton.Activated:Connect(function() -- Line: 86
                    -- upvalues: SeedPackOddsController (ref), v (copy), AdminQuestRewards_UI (ref)
                    SeedPackOddsController:Open(v.Value, AdminQuestRewards_UI);
                end);
            elseif v.Type == "Egg" then
                v11.Frame.OddsButton.Visible = true;
                v11.Frame.OddsButton.Activated:Connect(function() -- Line: 91
                    -- upvalues: PetEggOddsController (ref), v (copy), AdminQuestRewards_UI (ref)
                    PetEggOddsController:Open(v.Value, AdminQuestRewards_UI);
                end);
            elseif v.Type == "Crate" then
                v11.Frame.OddsButton.Visible = true;
                v11.Frame.OddsButton.Activated:Connect(function() -- Line: 96
                    -- upvalues: CosmeticCrateOddsController (ref), v (copy), AdminQuestRewards_UI (ref)
                    CosmeticCrateOddsController:Open(v.Value, AdminQuestRewards_UI);
                end);
            else
                v11.Frame.OddsButton.Visible = false;
            end;

            local v12 = tostring(v.Data.Type);
            local v13 = v.Data.Amount or 1;

            if v13 > 1 then
                v12 = "x" .. v13 .. " " .. v.Value;
            end;

            RewardName.Text = v12;

            if p4 then
                Odds.Text = string.format("%.2f", (v.Chance or 1 / v9) * 100) .. "%";
                Odds.Visible = true;
            else
                Odds.Visible = false;
            end;

            ITEM_IMAGE.Image = ItemImageFinder(tostring(v.Data.Type), v.Type);
            RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
            local UIStroke = v11.Frame.RewardName.UIStroke;

            if UIStroke then
                UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
            end;

            v11.LayoutOrder = v10 + 1000 + 1;
            v11.Parent = Holder.RewardScrollingFrame;
        end;

        GuiController:Open(AdminQuestRewards_UI);

        if u3 then
            u1:Add(AdminQuestRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 139
                -- upvalues: GuiController (ref), AdminQuestRewards_UI (ref), u3 (copy), u1 (ref)
                GuiController:Close(AdminQuestRewards_UI);
                GuiController:Open(u3);
                u1:Clean();
            end));

            return;
        end;

        u1:Add(AdminQuestRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 145
            -- upvalues: GuiController (ref), AdminQuestRewards_UI (ref), u1 (ref)
            GuiController:Close(AdminQuestRewards_UI);
            u1:Clean();
        end));
    end,

    Start = function(p14) -- Line: 152, Name: Start
        -- upvalues: AdminQuestRewards_UI (copy), GuiController (copy)
        if AdminQuestRewards_UI:FindFirstChild("Frame") then
            AdminQuestRewards_UI.Frame.Active = true;
        end;

        GuiController:UsePopupAnims(AdminQuestRewards_UI);
    end,

    OverwriteTitle = function(p15: table, p16: string) -- Line: 160, Name: OverwriteTitle
        -- upvalues: Holder (copy)
        Holder.Header.Title.Text = p16;
    end
};
task.spawn(v17.Start, v17);

return v17;