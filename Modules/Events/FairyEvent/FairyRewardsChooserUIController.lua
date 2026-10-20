-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Modules.GiveServiceCommon);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.SeedPackOddsController);
require(ReplicatedStorage.Modules.PetEggOddsController);
require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local FairyOddsUIController = require(ReplicatedStorage.Modules.Events.FairyEvent.FairyOddsUIController);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local Trove = require(ReplicatedStorage.Modules.Trove);
local StringUtils = require(ReplicatedStorage.Modules.StringUtils);
require(ReplicatedStorage.Modules.ColorHelper);
local u1 = Trove.new();
local GameEvents = ReplicatedStorage.GameEvents;
local ClaimFairyReward = GameEvents.Events.FairyEvent.ClaimFairyReward;
local ChooseRewardsUI = GameEvents.ChooseRewardsUI;
local RerollFairyRewards = GameEvents.Events.FairyEvent.RerollFairyRewards;
local FairyMilestonesData = require(ReplicatedStorage.Data.Events.FairyEvent.FairyMilestonesData);
Item_Module.Return_All_Seed_Rarities();
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local ChooseFairyRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("FairyEvent"):WaitForChild("ChooseFairyRewards_UI");
local Items = ChooseFairyRewards_UI.Frame.Main.Items;
local RerollButton = ChooseFairyRewards_UI.Frame.RerollButton;
local OddsButton = ChooseFairyRewards_UI.Frame.OddsButton;
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local UDim2_new_ret = UDim2.new(0.3, 0, 0.825, 0);
local UDim2_new_ret2 = UDim2.new(0.4, 0, 0.95, 0);
local u2 = Trove.new();
local u3 = {};

local function UpdateRerollUI() -- Line: 59
    -- upvalues: DataService (copy), RerollButton (copy), FairyMilestonesData (copy)
    local Data = DataService:GetData();
    RerollButton.Visible = true;
    local v4 = FairyMilestonesData.MaxRerolls - Data.FairyEvent.FairyQuests.RerollsUsed;
    RerollButton.Price.Text = `Reroll: {v4}`;

    if v4 <= 0 then
        RerollButton.RobuxPrice.Visible = true;
        RerollButton.Price.Visible = false;

        return;
    end;

    RerollButton.RobuxPrice.Visible = false;
    RerollButton.Price.Visible = true;
end;

function u3.Open(p5: table, u6: userdata?) -- Line: 77
    -- upvalues: GuiController (copy), ChooseFairyRewards_UI (copy), u2 (copy), DataService (copy), Notification (copy), Items (copy), RerollButton (copy), FairyMilestonesData (copy), SoundService (copy), StringUtils (copy), ItemImageFinder (copy), ClaimFairyReward (copy), TweenService (copy), TweenInfo_new_ret (copy), UDim2_new_ret2 (copy), UDim2_new_ret (copy)
    GuiController:GetStateForGui(ChooseFairyRewards_UI);
    u2:Destroy();
    local Data = DataService:GetData();

    if not Data then
        GuiController:Close(ChooseFairyRewards_UI);

        return;
    end;

    local PendingRewards = Data.FairyEvent.FairyQuests.PendingRewards;

    if #PendingRewards == 0 then
        Notification:CreateNotification("You have no rewards to claim!");
        GuiController:Close(ChooseFairyRewards_UI);

        return;
    end;

    for _, child in Items:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    local Data2 = DataService:GetData();
    RerollButton.Visible = true;
    local v7 = FairyMilestonesData.MaxRerolls - Data2.FairyEvent.FairyQuests.RerollsUsed;
    RerollButton.Price.Text = `Reroll: {v7}`;

    if v7 <= 0 then
        RerollButton.RobuxPrice.Visible = true;
        RerollButton.Price.Visible = false;
    else
        RerollButton.RobuxPrice.Visible = false;
        RerollButton.Price.Visible = true;
    end;

    SoundService:PlayLocalSound(SoundService.Click);
    local v8 = 0;

    for _, v in PendingRewards do
        v8 = v8 + 1;
        local v9 = u2:Clone(Items.UIListLayout.Template);
        v9.Visible = true;
        local Title = v9:FindFirstChild("Title");
        local Vector = v9:FindFirstChild("Vector");
        Title.Text = StringUtils:SplitWordWithSpace((tostring(v.Value)));
        Vector.Image = ItemImageFinder(tostring(v.Value), v.Type);
        u2:Add(v9.Activated:Once(function() -- Line: 123
            -- upvalues: SoundService (ref), ClaimFairyReward (ref), v (copy), GuiController (ref), ChooseFairyRewards_UI (ref), u2 (ref)
            SoundService:PlayLocalSound(SoundService.Click);
            ClaimFairyReward:FireServer(v.UUID);
            GuiController:Close(ChooseFairyRewards_UI);
            u2:Clean();
        end));
        local u10 = TweenService:Create(v9, TweenInfo_new_ret, {
            Size = UDim2_new_ret2
        });
        local u11 = TweenService:Create(v9, TweenInfo_new_ret, {
            Size = UDim2_new_ret
        });
        u2:Add(u10);
        u2:Add(u11);
        u2:Add(v9.MouseEnter:Connect(function() -- Line: 142
            -- upvalues: SoundService (ref), u10 (copy)
            SoundService:PlayLocalSound(SoundService.Hover);
            u10:Play();
        end));
        u2:Add(v9.MouseLeave:Connect(function() -- Line: 148
            -- upvalues: u11 (copy)
            u11:Play();
        end));
        v9.Parent = Items;
        v9.LayoutOrder = v8;
    end;

    GuiController:Open(ChooseFairyRewards_UI);

    if u6 then
        u2:Add(ChooseFairyRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 159
            -- upvalues: GuiController (ref), ChooseFairyRewards_UI (ref), u6 (copy), u2 (ref)
            GuiController:Close(ChooseFairyRewards_UI);
            GuiController:Open(u6);
            u2:Clean();
        end));

        return;
    end;

    u2:Add(ChooseFairyRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 165
        -- upvalues: GuiController (ref), ChooseFairyRewards_UI (ref), u2 (ref)
        GuiController:Close(ChooseFairyRewards_UI);
        u2:Clean();
    end));
end;

function u3.Start(p12) -- Line: 172
    -- upvalues: GuiController (copy), ChooseFairyRewards_UI (copy), u1 (copy), DataService (copy), RerollButton (copy), FairyMilestonesData (copy), ChooseRewardsUI (copy), u3 (copy), OddsButton (copy), FairyOddsUIController (copy), MarketController (copy), DevProductIds (copy), RerollFairyRewards (copy)
    GuiController:UsePopupAnims(ChooseFairyRewards_UI);
    u1:Add(DataService:GetPathSignal("FairyEvent/FairyQuests/RerollsUsed"):Connect(function() -- Line: 175
        -- upvalues: DataService (ref), RerollButton (ref), FairyMilestonesData (ref)
        local Data = DataService:GetData();
        RerollButton.Visible = true;
        local v13 = FairyMilestonesData.MaxRerolls - Data.FairyEvent.FairyQuests.RerollsUsed;
        RerollButton.Price.Text = `Reroll: {v13}`;

        if v13 <= 0 then
            RerollButton.RobuxPrice.Visible = true;
            RerollButton.Price.Visible = false;

            return;
        end;

        RerollButton.RobuxPrice.Visible = false;
        RerollButton.Price.Visible = true;
    end));
    u1:Add(ChooseRewardsUI.OnClientEvent:Connect(function() -- Line: 179
        -- upvalues: u3 (ref)
        u3:Open();
    end));
    u1:Add(OddsButton.Activated:Connect(function() -- Line: 184
        -- upvalues: DataService (ref), FairyOddsUIController (ref), ChooseFairyRewards_UI (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        FairyOddsUIController:OpenTier(ChooseFairyRewards_UI, Data.FairyEvent.FairyQuests.WishLevel, true);
    end));
    u1:Add(RerollButton.Activated:Connect(function() -- Line: 192
        -- upvalues: DataService (ref), FairyMilestonesData (ref), MarketController (ref), DevProductIds (ref), RerollFairyRewards (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if #Data.FairyEvent.FairyQuests.PendingRewards <= 0 then
            warn("Player tried to reroll rewards when none are pending!");

            return;
        end;

        if Data.FairyEvent.FairyQuests.RerollsUsed >= FairyMilestonesData.MaxRerolls then
            MarketController:PromptPurchase(DevProductIds.FairyWishReroll.PurchaseID, Enum.InfoType.Product);

            return;
        end;

        RerollFairyRewards:FireServer();
    end));
end;

EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    Script = script,

    OnStart = function() -- Line: 214, Name: OnStart
        -- upvalues: u3 (copy)
        task.spawn(u3.Start, u3);
    end,

    OnStop = function() -- Line: 215, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u3;