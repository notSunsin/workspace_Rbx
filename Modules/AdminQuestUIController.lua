-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
game:GetService("TweenService");
game:GetService("RunService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Data.QuestData.Types);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.ItemImageFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.IsDev);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
require(ReplicatedStorage.Modules.UpdateService);
local AdminQuestRewardsUIController = require(ReplicatedStorage.Modules.AdminQuestRewardsUIController);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Data.SharedCycleHandlerData);
local AdminQuests_UI = game.Players.LocalPlayer.PlayerGui:WaitForChild("AdminQuests_UI");
local Main = AdminQuests_UI.Frame.Main;
local Header = Main.Holder.Header;
local Tasks = Main.Holder.Content.Tasks;
local SkipQuestsButton = Header.SkipQuestsButton;
local OddsButton = Header.OddsButton;
local SENSOR = Header.Exit.SENSOR;
local Resets = Header.Resets;
local Segment = Tasks.UIListLayout.Segment;
local u1 = {};
local u2 = {
    Notif = false,
    OnNotifStateChanged = Signal.new()
};
local u3 = {
    ContainerID = nil,
    AllComplete = false,
    Claimed = false,
    CompletedQuests = {}
};

local function SetNotif(p4: boolean) -- Line: 72
    -- upvalues: u2 (copy)
    if p4 ~= u2.Notif then
        u2.Notif = p4;
        u2.OnNotifStateChanged:Fire(p4);
    end;
end;

local function ConfigureQuestCell(p5: string, p6: any) -- Line: 82
    -- upvalues: QuestsController (copy)
    local QuestFromId = QuestsController:GetQuestFromId(p5);

    if not QuestFromId then
        return;
    end;

    local v7 = QuestsController:GetQuest(QuestFromId.Type):Display(QuestFromId.Progress, QuestFromId.Target, QuestFromId.Arguments);
    local v8 = QuestFromId.Progress >= QuestFromId.Target and "Completed!" or v7.Bar;
    p6.Contents.TASK_NAME.Text = v7.Title;
    p6.Contents.Progress.ProgressBar.PROGRESS.Text = v8;
    p6.Contents.Progress.ProgressBar.PROGRESS_SHADOW.Text = v8;
    local math_clamp_ret = math.clamp(QuestFromId.Progress / QuestFromId.Target, 0, 1);
    p6.Contents.Progress.ProgressBar.Bar_Actual.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
    p6.Contents.Progress.Details.Underglow.Size = UDim2.new(math_clamp_ret * 1.296, 0, math_clamp_ret * 6.504, 0);
    p6.Visible = true;
end;

local function GetCellForQuest(p9: string) -- Line: 107
    -- upvalues: u1 (copy), Segment (copy)
    if u1[p9] then
        return u1[p9];
    end;

    local v10 = Segment:Clone();
    u1[p9] = v10;

    return v10;
end;

local function AreQuestsCompleted() -- Line: 119
    -- upvalues: DataService (copy), QuestsController (copy)
    local Data = DataService:GetData();

    if not Data then
        return false;
    end;

    local AdminQuest = Data.AdminQuest;

    if not AdminQuest then
        return false;
    end;

    local ContainerFromId = QuestsController:GetContainerFromId(AdminQuest.ContainerID);

    if not ContainerFromId then
        return false;
    end;

    for _, v in ContainerFromId.Quests do
        if not v.Completed then
            return false;
        end;
    end;

    return true;
end;

local function ShouldShowNotif() -- Line: 143
    -- upvalues: GuiController (copy), AdminQuests_UI (copy), DataService (copy), QuestsController (copy), u3 (copy), AreQuestsCompleted (copy)
    if GuiController:GetStateForGui(AdminQuests_UI).Visible:Get() then
        return false;
    end;

    local Data = DataService:GetData();

    if not (Data and Data.AdminQuest) then
        return false;
    end;

    local AdminQuest = Data.AdminQuest;
    local ContainerID = AdminQuest.ContainerID;
    local ContainerFromId = QuestsController:GetContainerFromId(ContainerID);

    if not ContainerFromId then
        return false;
    end;

    if u3.ContainerID and u3.ContainerID ~= ContainerID then
        return true;
    end;

    for _, v in ContainerFromId.Quests do
        if v.Completed and not u3.CompletedQuests[v.Id] then
            return true;
        end;
    end;

    local v11 = AreQuestsCompleted() and not AdminQuest.Claimed;

    return v11 and not u3.AllComplete and true or false;
end;

local function UpdatePreviousState() -- Line: 189
    -- upvalues: DataService (copy), QuestsController (copy), u3 (copy), AreQuestsCompleted (copy)
    local Data = DataService:GetData();

    if not (Data and Data.AdminQuest) then
        return;
    end;

    local AdminQuest = Data.AdminQuest;
    local ContainerID = AdminQuest.ContainerID;
    local ContainerFromId = QuestsController:GetContainerFromId(ContainerID);

    if not (ContainerID and ContainerFromId) then
        return;
    end;

    u3.ContainerID = ContainerID;
    u3.Claimed = AdminQuest.Claimed or false;
    u3.AllComplete = AreQuestsCompleted();
    u3.CompletedQuests = {};

    for _, v in ContainerFromId.Quests do
        u3.CompletedQuests[v.Id] = v.Completed;
    end;
end;

local function UpdateNotifState() -- Line: 215
    -- upvalues: ShouldShowNotif (copy), u2 (copy), UpdatePreviousState (copy)
    if ShouldShowNotif() and u2.Notif ~= true then
        u2.Notif = true;
        u2.OnNotifStateChanged:Fire(true);
    end;

    UpdatePreviousState();
end;

local function BuildUI() -- Line: 227
    -- upvalues: DataService (copy), QuestsController (copy), u1 (copy), Segment (copy), ConfigureQuestCell (copy), Tasks (copy), AreQuestsCompleted (copy), Main (copy)
    local AdminQuest = DataService:GetData().AdminQuest;

    if not AdminQuest then
        return;
    end;

    local ContainerFromId = QuestsController:GetContainerFromId((tostring(AdminQuest.ContainerID)));

    if ContainerFromId == nil then
        return;
    end;

    for _, v in ContainerFromId.Quests do
        local Id = v.Id;
        local v12;

        if u1[Id] then
            v12 = u1[Id];
        else
            v12 = Segment:Clone();
            u1[Id] = v12;
        end;

        ConfigureQuestCell(v.Id, v12);
        v12.Parent = Tasks;
    end;

    local v13 = {};

    for _, v in ContainerFromId.Quests do
        v13[v.Id] = true;
    end;

    for i, _ in u1 do
        if not v13[i] then
            u1[i]:Destroy();
            u1[i] = nil;
        end;
    end;

    local v14 = AreQuestsCompleted();
    local Claimed = AdminQuest.Claimed;
    Main.TasksCompleteOverlay.Visible = v14 or Claimed;

    if v14 then
        v14 = not Claimed;
    end;

    Main.TasksCompleteOverlay.Complete.Visible = v14;
    Main.TasksCompleteOverlay.Claimed.Visible = Claimed;
end;

function u2.Open(p15) -- Line: 268
    -- upvalues: GuiController (copy), AdminQuests_UI (copy), u2 (copy), UpdatePreviousState (copy)
    GuiController:Open(AdminQuests_UI);

    if u2.Notif ~= false then
        u2.Notif = false;
        u2.OnNotifStateChanged:Fire(false);
    end;

    UpdatePreviousState();
end;

function u2.Close(p16) -- Line: 274
    -- upvalues: GuiController (copy), AdminQuests_UI (copy)
    GuiController:Close(AdminQuests_UI);
end;

function u2.Toggle(p17) -- Line: 278
    -- upvalues: GuiController (copy), AdminQuests_UI (copy)
    if GuiController:GetStateForGui(AdminQuests_UI).Visible:Get() then
        p17:Close();

        return;
    end;

    p17:Open();
end;

function u2.Start(u18) -- Line: 287
    -- upvalues: GuiController (copy), AdminQuests_UI (copy), SENSOR (copy), SkipQuestsButton (copy), AreQuestsCompleted (copy), Notification (copy), MarketController (copy), DevProductIds (copy), OddsButton (copy), AdminQuestRewardsUIController (copy), DataService (copy), BuildUI (copy), ShouldShowNotif (copy), u2 (copy), UpdatePreviousState (copy), Resets (copy), NumberUtil (copy), Main (copy), ReplicatedStorage (copy)
    GuiController:GetStateForGui(AdminQuests_UI);
    SENSOR.Activated:Connect(function() -- Line: 292
        -- upvalues: u18 (copy)
        u18:Close();
    end);
    SkipQuestsButton.Activated:Connect(function() -- Line: 296
        -- upvalues: AreQuestsCompleted (ref), Notification (ref), MarketController (ref), DevProductIds (ref)
        if AreQuestsCompleted() then
            Notification:CreateNotification("You\'ve already completed the quests!");

            return;
        end;

        MarketController:PromptPurchase(DevProductIds.SkipAdminQuest.PurchaseID, Enum.InfoType.Product);
    end);
    OddsButton.Activated:Connect(function() -- Line: 305
        -- upvalues: AdminQuestRewardsUIController (ref), AdminQuests_UI (ref)
        AdminQuestRewardsUIController:Open(AdminQuests_UI, true);
    end);
    local PathSignal = DataService:GetPathSignal("AdminQuest/@");
    assert(PathSignal, "Failed to listen for Admin Quests"):Connect(function() -- Line: 310
        -- upvalues: BuildUI (ref), ShouldShowNotif (ref), u2 (ref), UpdatePreviousState (ref)
        BuildUI();

        if ShouldShowNotif() and u2.Notif ~= true then
            u2.Notif = true;
            u2.OnNotifStateChanged:Fire(true);
        end;

        UpdatePreviousState();
    end);
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    assert(PathSignal2, "Failed to listen for Admin Quest Containers"):Connect(function() -- Line: 315
        -- upvalues: BuildUI (ref), ShouldShowNotif (ref), u2 (ref), UpdatePreviousState (ref)
        BuildUI();

        if ShouldShowNotif() and u2.Notif ~= true then
            u2.Notif = true;
            u2.OnNotifStateChanged:Fire(true);
        end;

        UpdatePreviousState();
    end);
    task.spawn(function() -- Line: 321
        -- upvalues: DataService (ref), Resets (ref), NumberUtil (ref)
        while true do
            local Data = DataService:GetData();

            if Data.AdminQuest then
                local v19 = (Data.AdminQuest.EndTime or 0) - os.time();
                local math_max_ret = math.max(0, v19);
                Resets.Text = "Ends in " .. NumberUtil.toHMS(math_max_ret or 0);
            else
                Resets.Text = "No Admin Quest active!";
            end;

            task.wait(1);
        end;
    end);
    Main.TasksCompleteOverlay.Complete.ClaimButton.Activated:Connect(function(p20: userdata, p21: number) -- Line: 336
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.GameEvents.ClaimAdminQuestReward:FireServer();
    end);
    task.spawn(function() -- Line: 341
        -- upvalues: UpdatePreviousState (ref)
        task.wait(0.5);
        UpdatePreviousState();
    end);
    task.spawn(BuildUI);
end;

task.spawn(u2.Start, u2);

return u2;