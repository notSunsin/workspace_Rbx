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
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Modules.MarketController);
local QuestView = require(ReplicatedStorage.Modules.UIComponents.QuestView);
local ButtercupEventQuest = require(ReplicatedStorage.Data.SharedCycleHandlerData).ButtercupEventQuest;
require(ReplicatedStorage.Data.DevProductIds);
local ButtercupEvent_QuestUI = Players.LocalPlayer.PlayerGui:WaitForChild("ButtercupEvent_QuestUI");
local Frame = ButtercupEvent_QuestUI.Main:WaitForChild("Frame");
local ScrollingFrame = Frame:WaitForChild("ScrollingFrame");
local u1 = ScrollingFrame.Template:Clone();
ScrollingFrame.Template:Destroy();
local u2 = nil;
local ButtercupEventQuestsUIController = EventService.new("ButtercupEventQuestsUIController", "Buttercup Event Quest");

local function BuildQuestsUI() -- Line: 48
    -- upvalues: DataService (copy), u2 (ref), QuestsController (copy)
    local CurrentQuestContainer = DataService:GetData().ButtercupEvent.Quests.CurrentQuestContainer;

    if not CurrentQuestContainer then
        if u2 then
            u2:SetContainer(nil);
        end;

        return;
    end;

    if not QuestsController:GetContainerFromId(CurrentQuestContainer) then
        return;
    end;

    if u2 then
        u2:SetContainer(CurrentQuestContainer);
    end;
end;

function ButtercupEventQuestsUIController.OnStarted(p3) -- Line: 73
    -- upvalues: ButtercupEventQuest (copy), Frame (copy), ButtercupEventQuestsUIController (copy), BuildQuestsUI (copy), u2 (ref), QuestView (copy), ScrollingFrame (copy), u1 (copy), DataService (copy), NumberUtil (copy)
    if not ButtercupEventQuest:IsRunning() then
        ButtercupEventQuest:Start(1769277600);
    end;

    p3:Bind(Frame.Header.CloseButton.Activated:Connect(function(p4: userdata, p5: number) -- Line: 78
        -- upvalues: ButtercupEventQuestsUIController (ref)
        ButtercupEventQuestsUIController:Close();
    end));
    p3:Bind(ButtercupEventQuest.IntervalChanged:Connect(function(p6: number, p7: number) -- Line: 83
        -- upvalues: BuildQuestsUI (ref)
        BuildQuestsUI();
    end));
    u2 = QuestView.new({
        ContainerID = nil,
        AutoUpdate = true,
        ShowCompleted = true,
        Parent = ScrollingFrame,
        Template = u1
    });

    if u2 then
        p3._trove:Add(u2);
    end;

    p3:Bind(DataService:GetPathSignal("ButtercupEvent/Quests/CurrentQuestContainer"):Connect(function() -- Line: 101
        -- upvalues: BuildQuestsUI (ref)
        BuildQuestsUI();
    end));
    p3:Bind(DataService:GetPathSignal("QuestContainers/@"):Connect(function() -- Line: 106
        -- upvalues: BuildQuestsUI (ref)
        BuildQuestsUI();
    end));
    BuildQuestsUI();
    task.spawn(function() -- Line: 114
        -- upvalues: ButtercupEventQuest (ref), Frame (ref), NumberUtil (ref)
        while task.wait(1) do
            local TimeUntilNext = ButtercupEventQuest:GetTimeUntilNext();
            Frame.Header.RefreshIn.Timer.Text = `New Quests in {NumberUtil.toHMS(TimeUntilNext or 0)}`;
        end;
    end);
end;

function ButtercupEventQuestsUIController.OnEnded(p8) -- Line: 122
    -- upvalues: u2 (ref)
    u2 = nil;
end;

function ButtercupEventQuestsUIController.Open(p9) -- Line: 126
    -- upvalues: GuiController (copy), ButtercupEvent_QuestUI (copy)
    GuiController:Open(ButtercupEvent_QuestUI);
end;

function ButtercupEventQuestsUIController.Close(p10) -- Line: 130
    -- upvalues: GuiController (copy), ButtercupEvent_QuestUI (copy)
    GuiController:Close(ButtercupEvent_QuestUI);
end;

GuiController:UsePopupAnims(ButtercupEvent_QuestUI);

return ButtercupEventQuestsUIController;