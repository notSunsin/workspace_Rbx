-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.ItemImageFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local EventService = require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.QuestsController);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.UIComponents.QuestView);
local _ = require(ReplicatedStorage.Data.SharedCycleHandlerData).HeartstruckRain;
require(ReplicatedStorage.Data.DevProductIds);
local RewardsData = require(ReplicatedStorage.Data.ValentinesEvent.RewardsData);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local ValentinesEvent_UI = PlayerGui:WaitForChild("ValentinesEvent_UI");
local Shop_UI = PlayerGui:WaitForChild("Shop_UI");
local Main = ValentinesEvent_UI.Frame:WaitForChild("Main");
local Content = Main:WaitForChild("Content");
local SmallRewards = Content:WaitForChild("SmallRewards");
local Progress = Content:WaitForChild("Progress");
local ValentinesEventController = EventService.new("ValentinesEventController", "Valentines Event 2025");
local ClaimValentineReward = ReplicatedStorage.GameEvents.ValentinesEvent.ClaimValentineReward;

local function InitializeRewardsUI() -- Line: 52
    -- upvalues: DataService (copy), RewardsData (copy), SmallRewards (copy), ValentinesEventController (copy), ClaimValentineReward (copy), Comma_Module (copy)
    local Data = DataService:GetData();
    local v1 = 0;

    for i = 1, 5 do
        local v2;

        if RewardsData.Rewards[i] then
            local u3 = RewardsData.Rewards[i];
            local v4 = SmallRewards:FindFirstChild((`Reward{i}`));

            if v4 then
                local Content2 = v4:FindFirstChild("Content");
                local ITEM_IMAGE = Content2:FindFirstChild("ITEM_IMAGE");
                local RewardName = Content2:FindFirstChild("RewardName");
                local ClaimButton = Content2:FindFirstChild("ClaimButton");
                local ClaimedDisplay = Content2:FindFirstChild("ClaimedDisplay");
                local Price = Content2:FindFirstChild("Price");

                local function Update() -- Line: 80
                    -- upvalues: Data (copy), u3 (copy), i (copy), ClaimButton (copy), Price (copy), ClaimedDisplay (copy)
                    if Data.SpecialCurrency.HeartCoins >= u3.Price and not Data.ValentinesEvent.Completed[i] then
                        ClaimButton.Visible = true;
                        Price.Visible = false;
                        ClaimedDisplay.Visible = false;

                        return;
                    end;

                    if Data.ValentinesEvent.Completed[i] then
                        ClaimedDisplay.Visible = true;
                        Price.Visible = false;
                        ClaimButton.Visible = false;

                        return;
                    end;

                    Price.Visible = true;
                    ClaimedDisplay.Visible = false;
                    ClaimButton.Visible = false;
                end;

                ValentinesEventController:Bind(DataService:GetPathSignal("SpecialCurrency/HeartCoins"):Connect(Update));
                ValentinesEventController:Bind(DataService:GetPathSignal("ValentinesEvent/Completed"):Connect(Update));

                if Data.SpecialCurrency.HeartCoins >= u3.Price and not Data.ValentinesEvent.Completed[i] then
                    ClaimButton.Visible = true;
                    Price.Visible = false;
                    ClaimedDisplay.Visible = false;
                elseif Data.ValentinesEvent.Completed[i] then
                    ClaimedDisplay.Visible = true;
                    Price.Visible = false;
                    ClaimButton.Visible = false;
                else
                    Price.Visible = true;
                    ClaimedDisplay.Visible = false;
                    ClaimButton.Visible = false;
                end;

                ValentinesEventController:Bind(ClaimButton.Activated:Connect(function() -- Line: 118
                    -- upvalues: ClaimValentineReward (ref), i (copy)
                    ClaimValentineReward:FireServer(i);
                end));
                ITEM_IMAGE.Image = u3.ImageId;
                RewardName.RewardName.Text = u3.ItemName;
                Price.Counter.Text = `{Comma_Module.Comma(u3.Price)}`;
                v4.LayoutOrder = v1;
                v1 = v1 + 100;
                v2 = i;
            else
                v2 = i;
            end;
        else
            v2 = i;
        end;
    end;
end;

function ValentinesEventController.OnStarted(p5) -- Line: 137
    -- upvalues: Shop_UI (copy), Main (copy), ValentinesEventController (copy), InitializeRewardsUI (copy), DataService (copy), Progress (copy), Comma_Module (copy), NumberUtil (copy)
    task.spawn(function() -- Line: 142
        -- upvalues: Shop_UI (ref)
        local ValentinesFrame = Shop_UI:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("ValentinesFrame", 30);

        if ValentinesFrame then
            ValentinesFrame.Visible = true;
        end;
    end);
    p5:Bind(Main.Header.CloseButton.Activated:Connect(function(p6: userdata, p7: number) -- Line: 150
        -- upvalues: ValentinesEventController (ref)
        ValentinesEventController:Close();
    end));
    InitializeRewardsUI();

    local function UpdateProgress() -- Line: 158
        -- upvalues: DataService (ref), Progress (ref), Comma_Module (ref)
        local Data = DataService:GetData();
        local math_clamp_ret = math.clamp(Data.SpecialCurrency.HeartCoins / 10000, 0, 1);
        Progress.ProgressBar.Bar_Actual:TweenSize(UDim2.fromScale(math_clamp_ret, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true);
        Progress.ProgressBar.PROGRESS.Text = tostring(Comma_Module.Comma(Data.SpecialCurrency.HeartCoins)) .. "❤️<font transparency=\".4\">/10,000❤️</font>";
        Progress.ProgressBar.PROGRESS_SHADOW.Text = tostring(Comma_Module.Comma(Data.SpecialCurrency.HeartCoins)) .. "❤️<font transparency=\".4\">/10,000❤️</font>";
    end;

    p5:Bind(DataService:GetPathSignal("SpecialCurrency/HeartCoins"):Connect(UpdateProgress));
    UpdateProgress();
    task.spawn(function() -- Line: 178
        -- upvalues: Main (ref), NumberUtil (ref)
        while task.wait(1) do
            local v8 = game.ReplicatedFirst.GlobalUpdateTime.Value + 604800 - game.Workspace:GetServerTimeNow();
            Main.Header.RefreshIn.Timer.Text = `Ends in {NumberUtil.toDHMS(v8 or 0)}`;
        end;
    end);
end;

function ValentinesEventController.OnStopped(p9) -- Line: 187
    -- upvalues: Shop_UI (copy)
    local ValentinesFrame = Shop_UI:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("ValentinesFrame", 30);

    if ValentinesFrame then
        ValentinesFrame.Visible = false;
    end;
end;

function ValentinesEventController.Open(p10) -- Line: 194
    -- upvalues: GuiController (copy), ValentinesEvent_UI (copy)
    GuiController:Open(ValentinesEvent_UI);
end;

function ValentinesEventController.Close(p11) -- Line: 198
    -- upvalues: GuiController (copy), ValentinesEvent_UI (copy)
    GuiController:Close(ValentinesEvent_UI);
end;

GuiController:UsePopupAnims(ValentinesEvent_UI);

return ValentinesEventController;