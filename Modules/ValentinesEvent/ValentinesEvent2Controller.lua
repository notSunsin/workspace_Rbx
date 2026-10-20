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
require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.UIComponents.QuestView);
local _ = require(ReplicatedStorage.Data.SharedCycleHandlerData).HeartstruckRain;
require(ReplicatedStorage.Data.DevProductIds);
local RewardsData2 = require(ReplicatedStorage.Data.ValentinesEvent.RewardsData2);
local ValentinesEvent2_UI = Players.LocalPlayer.PlayerGui:WaitForChild("ValentinesEvent2_UI");
local Main = ValentinesEvent2_UI.Frame:WaitForChild("Main");
local Content = Main:WaitForChild("Content");
local List = Content:WaitForChild("SmallRewards"):WaitForChild("List");
local Progress = Content:WaitForChild("Progress");
local ClaimButton = Content:WaitForChild("ClaimButton");
local ValentinesEvent2Controller = EventService.new("ValentinesEvent2Controller", "Valentines Event 2 2025");
local _ = ReplicatedStorage.GameEvents.ValentinesEvent.ClaimValentineReward;
local ClaimValentineReward2 = ReplicatedStorage.GameEvents.ValentinesEvent.ClaimValentineReward2;

local function GetRewardPrice(p1: any, p2: number) -- Line: 52
    -- upvalues: RewardsData2 (copy)
    local v3 = RewardsData2.Rewards[p2];

    return not v3 and 0 or v3.Price * (p1.ValentinesEvent.Reward2PriceMultiplier or 1);
end;

local function InitializeRewardsUI() -- Line: 60
    -- upvalues: DataService (copy), RewardsData2 (copy), List (copy), NumberUtil (copy), ValentinesEvent2Controller (copy)
    local Data = DataService:GetData();
    local v4 = 0;

    for i = 1, 10 do
        local v5;

        if RewardsData2.Rewards[i] then
            local v6 = RewardsData2.Rewards[i];
            local v7 = List:FindFirstChild((`Reward{i}`));

            if v7 then
                local Content2 = v7:FindFirstChild("Content");
                local ITEM_IMAGE = Content2:FindFirstChild("ITEM_IMAGE");
                local RewardName = Content2:FindFirstChild("RewardName");
                local ClaimButton2 = Content2:FindFirstChild("ClaimButton");
                local ClaimedDisplay = Content2:FindFirstChild("ClaimedDisplay");
                local Price = Content2:FindFirstChild("Price");

                local function Update() -- Line: 88
                    -- upvalues: Data (copy), i (copy), ClaimedDisplay (copy), Price (copy), ClaimButton2 (copy), NumberUtil (ref), RewardsData2 (ref)
                    if Data.ValentinesEvent.Completed2[i] then
                        ClaimedDisplay.Visible = true;
                        Price.Visible = false;
                        ClaimButton2.Visible = false;
                    else
                        Price.Visible = true;
                        ClaimedDisplay.Visible = false;
                        ClaimButton2.Visible = false;
                    end;

                    local v8 = RewardsData2.Rewards[i];
                    Price.Counter.Text = `{NumberUtil.DisplaySheckles(not v8 and 0 or v8.Price * (Data.ValentinesEvent.Reward2PriceMultiplier or 1))}`;
                end;

                ValentinesEvent2Controller:Bind(DataService:GetPathSignal("Sheckles"):Connect(Update));
                ValentinesEvent2Controller:Bind(DataService:GetPathSignal("ValentinesEvent/Completed2"):Connect(Update));
                ValentinesEvent2Controller:Bind(DataService:GetPathSignal("ValentinesEvent/Reward2PriceMultiplier"):Connect(Update));

                if Data.ValentinesEvent.Completed2[i] then
                    ClaimedDisplay.Visible = true;
                    Price.Visible = false;
                    ClaimButton2.Visible = false;
                else
                    Price.Visible = true;
                    ClaimedDisplay.Visible = false;
                    ClaimButton2.Visible = false;
                end;

                local v9 = RewardsData2.Rewards[i];
                Price.Counter.Text = `{NumberUtil.DisplaySheckles(not v9 and 0 or v9.Price * (Data.ValentinesEvent.Reward2PriceMultiplier or 1))}`;
                ITEM_IMAGE.Image = v6.ImageId;
                RewardName.RewardName.Text = v6.ItemName;
                v7.LayoutOrder = v4;
                v4 = v4 + 100;
                v5 = i;
            else
                v5 = i;
            end;
        else
            v5 = i;
        end;
    end;
end;

function ValentinesEvent2Controller.OnStarted(p10) -- Line: 163
    -- upvalues: Main (copy), ValentinesEvent2Controller (copy), InitializeRewardsUI (copy), DataService (copy), RewardsData2 (copy), Progress (copy), NumberUtil (copy), ClaimButton (copy), ClaimValentineReward2 (copy)
    p10:Bind(Main.Header.CloseButton.Activated:Connect(function(p11: userdata, p12: number) -- Line: 168
        -- upvalues: ValentinesEvent2Controller (ref)
        ValentinesEvent2Controller:Close();
    end));
    InitializeRewardsUI();

    local function UpdateProgress() -- Line: 176
        -- upvalues: DataService (ref), RewardsData2 (ref), Progress (ref), NumberUtil (ref), ClaimButton (ref)
        local Data = DataService:GetData();
        local v13 = 1;

        for i = 1, 10 do
            if not Data.ValentinesEvent.Completed2[i] then
                v13 = i;
                break;
            end;

            local _ = i;
        end;

        local v14 = RewardsData2.Rewards[v13];
        local v15 = not v14 and 0 or v14.Price * (Data.ValentinesEvent.Reward2PriceMultiplier or 1);
        local math_clamp_ret = math.clamp(Data.Sheckles / v15, 0, 1);
        Progress.ProgressBar.Bar_Actual:TweenSize(UDim2.fromScale(math_clamp_ret, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true);
        Progress.ProgressBar.PROGRESS.Text = tostring(NumberUtil.DisplaySheckles(Data.Sheckles)) .. "<font transparency=\".4\">/" .. tostring(NumberUtil.DisplaySheckles(v15)) .. "</font>";
        Progress.ProgressBar.PROGRESS_SHADOW.Text = tostring(NumberUtil.DisplaySheckles(Data.Sheckles)) .. "<font transparency=\".4\">/" .. tostring(NumberUtil.DisplaySheckles(v15)) .. "</font>";
        ClaimButton.Visible = v15 <= Data.Sheckles;
    end;

    p10:Bind(DataService:GetPathSignal("Sheckles"):Connect(UpdateProgress));
    p10:Bind(DataService:GetPathSignal("ValentinesEvent/Reward2PriceMultiplier"):Connect(UpdateProgress));
    p10:Bind(ClaimButton.Activated:Connect(function() -- Line: 213
        -- upvalues: ClaimValentineReward2 (ref)
        ClaimValentineReward2:FireServer();
    end));
    UpdateProgress();
    task.spawn(function() -- Line: 222
        -- upvalues: Main (ref), NumberUtil (ref)
        while task.wait(1) do
            local v16 = game.ReplicatedFirst.GlobalUpdateTime.Value + 604800 - game.Workspace:GetServerTimeNow();
            Main.Header.RefreshIn.Timer.Text = `Ends in {NumberUtil.toDHMS(v16 or 0)}`;
        end;
    end);
end;

function ValentinesEvent2Controller.OnEnded(p17) -- Line: 231
end;

function ValentinesEvent2Controller.Open(p18) -- Line: 235
    -- upvalues: GuiController (copy), ValentinesEvent2_UI (copy)
    GuiController:Open(ValentinesEvent2_UI);
end;

function ValentinesEvent2Controller.Close(p19) -- Line: 239
    -- upvalues: GuiController (copy), ValentinesEvent2_UI (copy)
    GuiController:Close(ValentinesEvent2_UI);
end;

GuiController:UsePopupAnims(ValentinesEvent2_UI);

return ValentinesEvent2Controller;