-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Data.QuestData.Types);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.IsDev);
require(ReplicatedStorage.Data.DevProductIds);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.Notification);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local FallQuests_UI = Players.LocalPlayer.PlayerGui.Events.FallMarketEvent:WaitForChild("FallQuests_UI");
local Main = FallQuests_UI.Frame.Main;
local Header = Main.Holder.Header;
local List = Main.Holder.Tasks.List;
local RerollQuestsButton = Header.RerollQuestsButton;
local RerollQuests = ReplicatedStorage.GameEvents.Events.FallMarketEvent.Activities.RerollQuests;
local SENSOR = Header.Exit.SENSOR;
local Resets = Header.Resets;
local Segment = List.UIListLayout.Segment;
local u2 = {};
local u3 = {};

local function GetRerollCost(p4: number) -- Line: 55
    -- upvalues: GameConfigController (copy)
    local BaseRerollCost = GameConfigController:GetConfig("FallMarketEventConfig").BaseRerollCost;

    return math.max(BaseRerollCost, BaseRerollCost * 2 ^ p4);
end;

local function ConfigureQuestCell(p5: string, p6: any) -- Line: 63
    -- upvalues: QuestsController (copy)
    local ContainerFromId = QuestsController:GetContainerFromId(p5);

    if not ContainerFromId then
        return;
    end;

    local v7 = ContainerFromId.Quests[1];
    local v8 = QuestsController:GetQuest(v7.Type):Display(v7.Progress, v7.Target, v7.Arguments);
    local v9 = v7.Progress >= v7.Target;
    local v10 = v9 and "Completed!" or v8.Bar;
    p6.TASK_NAME.Text = v8.Title;
    p6.Progress.ProgressBar.PROGRESS.Text = v10;
    p6.Progress.ProgressBar.PROGRESS_SHADOW.Text = v10;
    local math_clamp_ret = math.clamp(v7.Progress / v7.Target, 0, 1);
    p6.Progress.ProgressBar.Bar_Actual.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
    p6.Progress.Details.Underglow.Size = UDim2.new(math_clamp_ret * 1.296, 0, math_clamp_ret * 6.504, 0);
    p6.CHECKMARK_ICON.Visible = v9;
    p6.Visible = true;
end;

local function GetCellForQuest(p11: string) -- Line: 90
    -- upvalues: u2 (copy), Segment (copy)
    if u2[p11] then
        return u2[p11];
    end;

    local v12 = Segment:Clone();
    u2[p11] = v12;

    return v12;
end;

local function BuildUI() -- Line: 104
    -- upvalues: DataService (copy), QuestsController (copy), u2 (copy), Segment (copy), ConfigureQuestCell (copy), List (copy), GameConfigController (copy), NumberUtil (copy), RerollQuestsButton (copy)
    local Data = DataService:GetData();

    for _, v in Data.FallMarket.FallQuests.Containers do
        local v13 = tostring(v);

        if QuestsController:GetContainerFromId(v13) == nil then
            warn("Invalid Quest ID in Fall Quest List. Skipping.");
        else
            local v14;

            if u2[v13] then
                v14 = u2[v13];
            else
                v14 = Segment:Clone();
                u2[v13] = v14;
            end;

            ConfigureQuestCell(v13, v14);
            v14.Parent = List;
        end;
    end;

    for i, _ in u2 do
        if table.find(Data.FallMarket.FallQuests.Containers, i) == nil then
            u2[i]:Destroy();
            u2[i] = nil;
        end;
    end;

    local Rerolled = Data.FallMarket.FallQuests.Rerolled;
    local BaseRerollCost = GameConfigController:GetConfig("FallMarketEventConfig").BaseRerollCost;
    local math_max_ret = math.max(BaseRerollCost, BaseRerollCost * 2 ^ Rerolled);
    local v15 = NumberUtil.FormatCompactPrice(math_max_ret, "1");
    RerollQuestsButton.TextLabel.Text = `Reroll: {v15}`;
end;

function u3.Start(p16) -- Line: 135
    -- upvalues: u1 (copy), SENSOR (copy), GuiController (copy), FallQuests_UI (copy), RerollQuestsButton (copy), RerollQuests (copy), DataService (copy), BuildUI (copy), Resets (copy), NumberUtil (copy)
    u1:Add(SENSOR.Activated:Connect(function() -- Line: 137
        -- upvalues: GuiController (ref), FallQuests_UI (ref)
        GuiController:Close(FallQuests_UI);
    end));
    u1:Add(RerollQuestsButton.Activated:Connect(function() -- Line: 141
        -- upvalues: RerollQuests (ref)
        RerollQuests:FireServer();
    end));
    local PathSignal = DataService:GetPathSignal("FallMarket/@");
    u1:Add(assert(PathSignal, "Failed to listen for Fall Quests"):Connect(BuildUI));
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    u1:Add(assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(BuildUI));
    u1:Add(task.spawn(function() -- Line: 150
        -- upvalues: Resets (ref), NumberUtil (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local math_max_ret = math.max(((ServerTimeNow + 86400) // 86400 + 1) * 86400 - 86400 - ServerTimeNow, 0);
            Resets.Text = "Resets in " .. NumberUtil.toHMS(math_max_ret);
            task.wait(1);
        end;
    end));
    u1:Add(task.spawn(function() -- Line: 164
        -- upvalues: BuildUI (ref)
        while true do
            task.wait(3);
            BuildUI();
        end;
    end));
    task.spawn(BuildUI);
end;

EventRotationClientBinder:Bind({
    EventSet = "FallMarketEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 179, Name: OnStart
        -- upvalues: u3 (copy)
        task.spawn(u3.Start, u3);
    end,

    OnStop = function() -- Line: 180, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u3;