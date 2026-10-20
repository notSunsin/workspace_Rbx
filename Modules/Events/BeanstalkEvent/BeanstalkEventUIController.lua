-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local NPCLevelHandler = require(ReplicatedStorage.Modules.NPCLevelHandler);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(game.ReplicatedStorage.Modules.NumberUtil);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local u1 = Trove.new();
local RE_ClientBeanStalkProgress = ReplicatedStorage.GameEvents.Events.BeanstalkEvent.RE_ClientBeanStalkProgress;
local RE_ClientBeanStalkTimer = ReplicatedStorage.GameEvents.Events.BeanstalkEvent.RE_ClientBeanStalkTimer;
local LeaderboardEntryTemplate = ReplicatedStorage.UITemplates.LeaderboardEntryTemplate;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local BeanstalkEventShop_UI = PlayerGui.Events.BeanstalkEvent.BeanstalkEventShop_UI;
local GiantsFriendShop_UI = PlayerGui.Events.BeanstalkEvent.GiantsFriendShop_UI;

local function CloseEventShopsIfOpen() -- Line: 43
    -- upvalues: BeanstalkEventShop_UI (copy), GuiController (copy), GiantsFriendShop_UI (copy)
    if BeanstalkEventShop_UI.Enabled then
        GuiController:Close(BeanstalkEventShop_UI);
    end;

    if GiantsFriendShop_UI.Enabled then
        GuiController:Close(GiantsFriendShop_UI);
    end;
end;

local u2 = {};

local function GetBeanstalkEventConfig() -- Line: 50
    -- upvalues: GameConfigController (copy)
    return GameConfigController:GetConfig("BeanstalkEventConfig");
end;

local function WaitForCollection(p3: string) -- Line: 54
    -- upvalues: CollectionService (copy)
    local v4 = CollectionService:GetTagged(p3)[1];

    if not v4 then
        local v5 = 0;

        while not v4 and v5 <= 5 do
            v4 = CollectionService:GetTagged(p3)[1];
            v5 = v5 + task.wait(0.5);

            if v5 > 5 then
                warn((`BeanstalkEventUIController | Could not find {p3}`));

                return v4;
            end;
        end;
    end;

    return v4;
end;

local function InitBeanstalkProgressBar() -- Line: 70
    -- upvalues: WaitForCollection (copy), u1 (copy), RE_ClientBeanStalkProgress (copy), BeanstalkEventShop_UI (copy), GuiController (copy), GiantsFriendShop_UI (copy), LocalPlayer (copy), Players (copy)
    local u6 = WaitForCollection("BeanstalkSprout"):FindFirstChild("BeanStalkTimer"):FindFirstChildOfClass("BillboardGui");
    local UpgradeBar = u6:FindFirstChild("UpgradeBar");
    local Fill = UpgradeBar:FindFirstChild("Fill");
    local ProgressionLabel = UpgradeBar:FindFirstChild("ProgressionLabel");

    local function UpdateProgressBarVisibility() -- Line: 78
        -- upvalues: u6 (copy)
        u6.Enabled = not workspace:GetAttribute("ActivateBeanstalk");
    end;

    u1:Add(RE_ClientBeanStalkProgress.OnClientEvent:Connect(function(p7: number, p8: number, p9: table) -- Line: 82
        -- upvalues: Fill (copy), ProgressionLabel (copy)
        Fill.Size = UDim2.new(p7 / p8, 0, 1, 0);
        ProgressionLabel.Text = tostring(p7) .. "/" .. tostring(p8);
    end));
    u1:Add(workspace.AttributeChanged:Connect(function(p10: string) -- Line: 90
        -- upvalues: u6 (copy), BeanstalkEventShop_UI (ref), GuiController (ref), GiantsFriendShop_UI (ref)
        if p10 == "ActivateBeanstalk" then
            u6.Enabled = not workspace:GetAttribute("ActivateBeanstalk");
        end;

        if not workspace:GetAttribute("ActivateBeanstalk") then
            if BeanstalkEventShop_UI.Enabled then
                GuiController:Close(BeanstalkEventShop_UI);
            end;

            if GiantsFriendShop_UI.Enabled then
                GuiController:Close(GiantsFriendShop_UI);
            end;
        end;
    end));
    u1:Add(task.spawn(function() -- Line: 100
        -- upvalues: LocalPlayer (ref), Players (ref), BeanstalkEventShop_UI (ref), GuiController (ref), GiantsFriendShop_UI (ref)
        while LocalPlayer:IsDescendantOf(Players) do
            if not workspace:GetAttribute("ActivateBeanstalk") then
                if BeanstalkEventShop_UI.Enabled then
                    GuiController:Close(BeanstalkEventShop_UI);
                end;

                if GiantsFriendShop_UI.Enabled then
                    GuiController:Close(GiantsFriendShop_UI);
                end;
            end;

            task.wait();
        end;
    end));
    u6.Enabled = not workspace:GetAttribute("ActivateBeanstalk");
end;

local function InitBeanstalkLeaderboard() -- Line: 116
    -- upvalues: WaitForCollection (copy), LeaderboardEntryTemplate (copy), u1 (copy), RE_ClientBeanStalkProgress (copy), Players (copy)
    local ScoreList = WaitForCollection("BeanstalkLeaderboardModel"):FindFirstChild("LeaderboardPanel"):FindFirstChildOfClass("SurfaceGui"):FindFirstChild("Root"):FindFirstChild("ScoreList");
    local u11 = {};

    local function BuildLeaderboard(p12: table) -- Line: 125
        -- upvalues: ScoreList (copy), u11 (ref), LeaderboardEntryTemplate (ref)
        for _, child in ScoreList:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        u11 = p12;

        if u11 == nil then
            return;
        end;

        local v13 = #u11;

        for _, v in u11 do
            local v14 = LeaderboardEntryTemplate:Clone();
            v14.PlayerName.Text = v.Player.Name;
            v14.PlayerScore.Text = `{v.Contribution}`;
            v14.LayoutOrder = -v.Contribution;
            v14.Size = UDim2.new(1, 0, math.min(0.2, 1 / v13), 0);
            v14.Parent = ScoreList;
        end;
    end;

    u1:Add(RE_ClientBeanStalkProgress.OnClientEvent:Connect(function(p15: number, p16: number, p17: table) -- Line: 151
        -- upvalues: BuildLeaderboard (copy)
        BuildLeaderboard(p17);
    end));
    u1:Add(Players.PlayerAdded:Connect(function(p18: userdata) -- Line: 156
        -- upvalues: u11 (ref), BuildLeaderboard (copy)
        table.insert(u11, {
            Contribution = 0,
            Player = p18
        });
        BuildLeaderboard(u11);
    end));
    u1:Add(Players.PlayerRemoving:Connect(function(p19: userdata) -- Line: 166
        -- upvalues: u11 (ref), BuildLeaderboard (copy)
        for i, v in u11 do
            if v.Player == p19 then
                table.remove(u11, i);
                break;
            end;
        end;

        BuildLeaderboard(u11);
    end));
end;

local function InitBeanstalkDecayTimer() -- Line: 178
    -- upvalues: WaitForCollection (copy), Chalk (copy), u1 (copy), RE_ClientBeanStalkTimer (copy), TimeHelper (copy), Notification (copy)
    local DecayTimerBillboard = WaitForCollection("BeanstalkEventModel"):FindFirstChild("BeanstalkTimer"):FindFirstChild("DecayTimerBillboard");
    local Timer = DecayTimerBillboard:FindFirstChild("Timer");
    local Title = DecayTimerBillboard:FindFirstChild("Title");
    local u20 = -1;
    local u21 = {
        [600] = "Beanstalk decays in " .. Chalk.green("10 minutes"),
        [300] = "Beanstalk decays in " .. Chalk.yellow("5 minutes"),
        [60] = "Beanstalk decays in " .. Chalk.orange("1 minute"),
        [30] = "Beanstalk decays in " .. Chalk.red("30 seconds")
    };
    u1:Add(RE_ClientBeanStalkTimer.OnClientEvent:Connect(function(p22: number) -- Line: 194
        -- upvalues: u20 (ref)
        u20 = p22;
    end));
    u1:Add(task.spawn(function() -- Line: 198
        -- upvalues: u20 (ref), Timer (copy), Title (copy), TimeHelper (ref), u21 (copy), Notification (ref)
        while task.wait(1) do
            if u20 <= 0 then
                Timer.Text = "";
                Title.Visible = false;
            else
                Title.Visible = true;
                local v23 = u20 - workspace:GetServerTimeNow();
                Timer.Text = TimeHelper:GenerateTextFromTime(v23);

                if u21[v23] then
                    Notification:CreateNotification(u21[v23]);
                end;
            end;
        end;
    end));
end;

local function InitBeanstalkGrowTimer() -- Line: 218
    -- upvalues: DataService (copy), NPCLevelHandler (copy), GameConfigController (copy), WaitForCollection (copy), Chalk (copy), u1 (copy), TimeHelper (copy), Notification (copy)
    local function getRemainingTime() -- Line: 219
        -- upvalues: DataService (ref), NPCLevelHandler (ref), GameConfigController (ref)
        local Data = DataService:GetData();

        if not Data then
            return 0;
        end;

        local v24 = NPCLevelHandler:GetNPCLevel("Jack") or 1;
        local v25 = GameConfigController:GetConfig("BeanstalkEventConfig").NPCBeanstalkCooldown[v24];

        return GameConfigController:GetConfig("BeanstalkEventConfig").BeanstalkRefreshInterval * v25 - (workspace:GetServerTimeNow() - Data.BeanstalkEvent.LastRewardClaimedTime);
    end;

    local BeanstalkTimer = WaitForCollection("BeanstalkEventModel"):FindFirstChild("BeanstalkTimer");
    local GrowTimerBillboard = BeanstalkTimer:FindFirstChild("GrowTimerBillboard");
    local Timer = GrowTimerBillboard:FindFirstChild("Timer");
    local Title = GrowTimerBillboard:FindFirstChild("Title");
    local Title2 = BeanstalkTimer:FindFirstChild("DecayTimerBillboard"):FindFirstChild("Title");
    local u26 = {
        [600] = "Beanstalk is growable in " .. Chalk.green("10 minutes"),
        [300] = "Beanstalk is growable in " .. Chalk.yellow("5 minutes"),
        [60] = "Beanstalk is growable in " .. Chalk.orange("1 minute"),
        [30] = "Beanstalk is growable in " .. Chalk.red("30 seconds")
    };
    u1:Add(task.spawn(function() -- Line: 250
        -- upvalues: getRemainingTime (copy), Title2 (copy), Timer (copy), Title (copy), TimeHelper (ref), u26 (copy), Notification (ref)
        while task.wait(1) do
            local v27 = getRemainingTime();

            if v27 <= 0 or Title2.Visible then
                Timer.Text = "";
                Title.Visible = false;
            else
                Title.Visible = true;
                Timer.Text = TimeHelper:GenerateTextFromTime(v27);

                if u26[v27] then
                    Notification:CreateNotification(u26[v27]);
                end;
            end;
        end;
    end));
end;

local function InitJackThoughtBubble() -- Line: 276
    -- upvalues: WaitForCollection (copy)
    local v28 = WaitForCollection("BeanstalkGrowerNPC");

    if not v28 then
        return;
    end;

    local BeanstalkBubblePart = v28:FindFirstChild("BeanstalkBubblePart");

    if not BeanstalkBubblePart then
        return;
    end;

    local BubbleBillboard = BeanstalkBubblePart:FindFirstChild("BubbleBillboard");

    if not BubbleBillboard then
        return;
    end;

    local BG = BubbleBillboard:FindFirstChild("BG");

    if not BG then
        return;
    end;

    if BG:FindFirstChild("TextLabel") then
    end;
end;

function u2.Start(p29) -- Line: 323
    -- upvalues: InitBeanstalkProgressBar (copy), InitBeanstalkLeaderboard (copy), InitBeanstalkDecayTimer (copy), InitBeanstalkGrowTimer (copy), InitJackThoughtBubble (copy)
    task.spawn(InitBeanstalkProgressBar);
    task.spawn(InitBeanstalkLeaderboard);
    task.spawn(InitBeanstalkDecayTimer);
    task.spawn(InitBeanstalkGrowTimer);
    task.spawn(InitJackThoughtBubble);
end;

local u30 = false;
EventRotationController.EventUpdated:Connect(function(p31: string, p32: string) -- Line: 339, Name: OnEventUpdated
    -- upvalues: u1 (copy), u30 (ref), u2 (copy)
    if p32 ~= "BeanstalkEvent" then
        u1:Clean();
        u30 = false;

        return;
    end;

    if u30 then
        return;
    end;

    u30 = true;
    u1:Clean();
    task.spawn(u2.Start, u2);
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "BeanstalkEvent" then
    local _ = LoadedEvent.EventID;

    if LoadedEvent.EventSet == "BeanstalkEvent" then
        if not u30 then
            u30 = true;
            u1:Clean();
            task.spawn(u2.Start, u2);
        end;
    else
        u1:Clean();
        u30 = false;
    end;
end;

return u2;