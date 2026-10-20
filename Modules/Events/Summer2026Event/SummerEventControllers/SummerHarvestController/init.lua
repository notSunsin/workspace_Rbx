-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local SoundService = game:GetService("SoundService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local TeamEventController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventController);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local GlobalUpdateTime = game:GetService("ReplicatedFirst"):WaitForChild("GlobalUpdateTime");

local function EndHighTideTime() -- Line: 31
    -- upvalues: GlobalUpdateTime (copy)
    local Value = GlobalUpdateTime.Value;

    return Value > 1785616200 and 1785616200 or Value;
end;

local function HighTideDisabled() -- Line: 38
    -- upvalues: GlobalUpdateTime (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Value = GlobalUpdateTime.Value;

    return (Value > 1785616200 and 1785616200 or Value) <= ServerTimeNow;
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 75, 75);

local function PlayUiSound(p2: string) -- Line: 49
    -- upvalues: SoundService (copy)
    local v3 = SoundService:FindFirstChild(p2);

    if v3 and v3:IsA("Sound") then
        v3.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        v3.TimePosition = 0;
        v3.Playing = true;
    end;
end;

local function Commas(p4: number) -- Line: 59
    local math_floor_ret = math.floor(p4);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local script_SummerHarvestTeamConfigAccessor = require(script.SummerHarvestTeamConfigAccessor);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
PlayerGui:WaitForChild("BackpackGui");
local SummerHarvestUI = PlayerGui.SummerHarvestUI;
local Progression = SummerHarvestUI:WaitForChild("Progression");
local Header = Progression.Header;
local Main = Progression.Main;
local Finale = Main.Finale;
local Bar = Finale.Bar;
local ScrollingFrame = Main.ScrollClipper.ScrollingFrame;
local LevelTemplate = ScrollingFrame.LevelTemplate;
local u5 = {};
local u6 = {};
local u7 = false;
local u8 = nil;
local u9 = nil;
local u10 = nil;

local function GetEventData() -- Line: 100
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    return Data;
end;

local function DayKey(p11: number) -- Line: 107
    return `Day{p11}`;
end;

local function GetDayPoints(p12: number) -- Line: 111
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    if Data then
        Data = Data.DayPoints;
    end;

    if type(Data) ~= "table" then
        return 0;
    end;

    local v13 = Data[`Day{p12}`];

    return tonumber(v13) or 0;
end;

local function GetTeamCurrentDayTotal(p14: number) -- Line: 123
    -- upvalues: TeamEventController (copy), script_SummerHarvestTeamConfigAccessor (copy), LocalPlayer (copy), DataService (copy)
    local TeamId = TeamEventController:GetTeamId(script_SummerHarvestTeamConfigAccessor.EventName, LocalPlayer);

    if TeamId then
        TeamId = TeamEventController:GetTeamData(script_SummerHarvestTeamConfigAccessor.EventName, TeamId);
    end;

    if TeamId and type(TeamId.members) == "table" then
        local v15 = 0;

        for _, v in TeamId.members do
            v15 = v15 + (tonumber(v) or 0);
        end;

        return v15;
    end;

    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    if Data then
        Data = Data.DayPoints;
    end;

    if type(Data) ~= "table" then
        return 0;
    end;

    local v16 = Data[`Day{p14}`];

    return tonumber(v16) or 0;
end;

local function IsDayCompleted(p17: number) -- Line: 136
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    if Data then
        Data = Data.CompletedDays;
    end;

    if type(Data) == "table" then
        return Data[`Day{p17}`] == true;
    end;

    return false;
end;

local function IsGrandPrizeAwarded() -- Line: 145
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    local v18;

    if type(Data) == "table" then
        v18 = Data.GrandPrizeAwarded == true;
    else
        v18 = false;
    end;

    return v18;
end;

local function CountCompletedDays() -- Line: 150
    -- upvalues: script_SummerHarvestTeamConfigAccessor (copy), DataService (copy)
    local v19 = 0;

    for i = 1, script_SummerHarvestTeamConfigAccessor.TotalDays do
        local Data = DataService:GetData();

        if Data then
            Data = Data.SummerHarvestTeamData;
        end;

        if Data then
            Data = Data.CompletedDays;
        end;

        local v20;

        if type(Data) == "table" then
            v20 = Data[`Day{i}`] == true;
        else
            v20 = false;
        end;

        local v21;

        if v20 then
            v19 = v19 + 1;
            v21 = i;
        else
            v21 = i;
        end;
    end;

    return v19;
end;

local function GetCurrentDay() -- Line: 161
    -- upvalues: script_SummerHarvestTeamConfigAccessor (copy)
    local v22 = (workspace:GetServerTimeNow() - script_SummerHarvestTeamConfigAccessor.EventStartTime) / script_SummerHarvestTeamConfigAccessor.DayLength;

    return math.floor(v22) + 1;
end;

local function GetDayStartTime(p23: number) -- Line: 166
    -- upvalues: script_SummerHarvestTeamConfigAccessor (copy)
    return script_SummerHarvestTeamConfigAccessor.EventStartTime + (p23 - 1) * script_SummerHarvestTeamConfigAccessor.DayLength;
end;

local function FormatTimeLeft(p24: number) -- Line: 172
    local math_floor_ret = math.floor(p24);
    local math_max_ret = math.max(0, math_floor_ret);
    local v25 = math_max_ret // 86400;
    local v26 = math_max_ret % 86400 // 3600;
    local v27 = math_max_ret % 3600 // 60;

    if v25 > 0 then
        return `{v25}d {v26}h`;
    end;

    if v26 > 0 then
        return `{v26}h {v27}m`;
    end;

    return `{v27}m {math_max_ret % 60}s`;
end;

local function GetRewardDisplayName(p28) -- Line: 186
    if not p28 then
        return "";
    end;

    local v29 = tostring(p28.Value or "?");
    local v30 = tonumber(p28.Quantity) or 1;

    if v30 > 1 then
        return `{v30}x {v29}`;
    end;

    return v29;
end;

local function SetItemReward(p31: userdata?, p32: any) -- Line: 198
    -- upvalues: ItemImageFinder (copy)
    if not (p31 and p32) then
        return;
    end;

    local ITEM_IMAGE = p31:FindFirstChild("ITEM_IMAGE");

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        ITEM_IMAGE.Image = ItemImageFinder(p32.Value, p32.Type) or ITEM_IMAGE.Image;
    end;

    local ITEM_NAME = p31:FindFirstChild("ITEM_NAME");

    if ITEM_NAME and ITEM_NAME:IsA("TextLabel") then
        local v33;

        if p32 then
            v33 = tostring(p32.Value or "?");
            local v34 = tonumber(p32.Quantity) or 1;

            if v34 > 1 then
                v33 = `{v34}x {v33}`;
            end;
        else
            v33 = "";
        end;

        ITEM_NAME.Text = v33;
        local ITEM_NAME_SHADOW = ITEM_NAME:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = ITEM_NAME.Text;
        end;
    end;

    local NewBanner = p31:FindFirstChild("NewBanner");

    if NewBanner and NewBanner:IsA("GuiObject") then
        NewBanner.Visible = false;
    end;
end;

local function SetItemObtained(p35: userdata?, p36: boolean) -- Line: 224
    if not p35 then
        return;
    end;

    local OBTAINED_IMAGE = p35:FindFirstChild("OBTAINED_IMAGE");

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = p36;
    end;

    local Cover = p35:FindFirstChild("Cover");

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = false;
    end;
end;

local function SetBar(p37: userdata?, p38: number, p39: number, p40: string?) -- Line: 240
    if not p37 then
        return;
    end;

    local v41 = p39 <= 0 and 0 or math.clamp(p38 / p39, 0, 1);
    local Bar_Actual = p37:FindFirstChild("Bar_Actual");

    if Bar_Actual and Bar_Actual:IsA("GuiObject") then
        Bar_Actual.Size = UDim2.fromScale(v41, 1);
    end;

    local v42 = p40 or `{math.floor(p38)} / {math.floor(p39)}`;
    local PROGRESS = p37:FindFirstChild("PROGRESS");

    if PROGRESS and PROGRESS:IsA("TextLabel") then
        PROGRESS.Text = v42;
    end;

    local PROGRESS_SHADOW = p37:FindFirstChild("PROGRESS_SHADOW");

    if PROGRESS_SHADOW and PROGRESS_SHADOW:IsA("TextLabel") then
        PROGRESS_SHADOW.Text = v42;
    end;
end;

local u43 = false;

local function Build() -- Line: 265
    -- upvalues: u43 (ref), LevelTemplate (copy), u8 (ref), script_SummerHarvestTeamConfigAccessor (copy), Chalk (copy), SetItemReward (copy), ScrollingFrame (copy), u6 (copy), Finale (copy), Bar (copy), u9 (ref), u10 (ref)
    if u43 then
        return;
    end;

    u43 = true;
    LevelTemplate.Visible = false;
    local Locked = LevelTemplate:FindFirstChild("Locked");

    if Locked then
        Locked = Locked:FindFirstChild("TimeLeft");
    end;

    if Locked and Locked:IsA("TextLabel") then
        u8 = Locked.TextColor3;
    end;

    for i = 1, script_SummerHarvestTeamConfigAccessor.TotalDays do
        local v44 = LevelTemplate:Clone();
        v44.Name = `Day{i}`;
        v44.LayoutOrder = i;
        local QuesteIndex = v44:FindFirstChild("QuesteIndex");

        if QuesteIndex and QuesteIndex:IsA("TextLabel") then
            QuesteIndex.Text = `Day {i}`;
        end;

        local QuestName = v44:FindFirstChild("QuestName");

        if QuestName and QuestName:IsA("TextLabel") then
            QuestName.RichText = true;
            local bold = Chalk.bold;
            local DailyPointGoal = script_SummerHarvestTeamConfigAccessor.GetDailyPointGoal(i);
            local math_floor_ret = math.floor(DailyPointGoal);
            local v45 = bold((tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
            QuestName.Text = Chalk.color("#FFCF5C")((`Earn {v45} Harvest Points`));
        end;

        SetItemReward(v44:FindFirstChild("ITEM_TEMPLATE"), script_SummerHarvestTeamConfigAccessor.DailyRewards[i]);
        v44.Visible = true;
        v44.Parent = ScrollingFrame;
        u6[i] = v44;
        local _ = i;
    end;

    local Requirement = Finale:FindFirstChild("Requirement");

    if Requirement and Requirement:IsA("TextLabel") then
        Requirement.Text = "Complete daily goals to fill the bar and get the Lagoon Lily Seed!";
    end;

    SetItemReward(Finale:FindFirstChild("ITEM_TEMPLATE"), script_SummerHarvestTeamConfigAccessor.GrandPrize);
    local DividerHolder = Bar:FindFirstChild("DividerHolder");

    if DividerHolder then
        local v46 = DividerHolder:FindFirstChildWhichIsA("UIListLayout");

        if v46 then
            v46:Destroy();
        end;

        local v47 = {};

        for _, child in DividerHolder:GetChildren() do
            if child:IsA("Frame") then
                table.insert(v47, child);
            end;
        end;

        local DaysRequiredForGrandPrize = script_SummerHarvestTeamConfigAccessor.DaysRequiredForGrandPrize;

        for i, v in v47 do
            if i <= DaysRequiredForGrandPrize - 1 then
                v.AnchorPoint = Vector2.new(0.5, 0.5);
                v.Position = UDim2.fromScale(i / DaysRequiredForGrandPrize, 0.5);
                v.BackgroundTransparency = 0.2;
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end;

    local function LeftEdge(p48: userdata) -- Line: 346
        return p48.Position.X.Scale - p48.Size.X.Scale * p48.AnchorPoint.X;
    end;

    local function RightEdge(p49: userdata) -- Line: 349
        return p49.Position.X.Scale + p49.Size.X.Scale * (1 - p49.AnchorPoint.X);
    end;

    u9 = Bar.Position.X.Scale;
    local ITEM_TEMPLATE = Finale:FindFirstChild("ITEM_TEMPLATE");
    local Tick = Finale:FindFirstChild("Tick");

    if ITEM_TEMPLATE and ITEM_TEMPLATE:IsA("GuiObject") then
        u10 = (ITEM_TEMPLATE.Position.X.Scale - ITEM_TEMPLATE.Size.X.Scale * ITEM_TEMPLATE.AnchorPoint.X) / 2;

        if Tick and Tick:IsA("GuiObject") then
            u9 = (Tick.Position.X.Scale + Tick.Size.X.Scale * (1 - Tick.AnchorPoint.X) + (ITEM_TEMPLATE.Position.X.Scale - ITEM_TEMPLATE.Size.X.Scale * ITEM_TEMPLATE.AnchorPoint.X)) / 2;
        end;
    end;
end;

local function RenderDay(p50: number) -- Line: 366
    -- upvalues: u6 (copy), script_SummerHarvestTeamConfigAccessor (copy), DataService (copy), GetTeamCurrentDayTotal (copy), SetBar (copy), SetItemObtained (copy), u8 (ref), Color3_fromRGB_ret (copy)
    local v51 = u6[p50];

    if not v51 then
        return;
    end;

    local v52 = (workspace:GetServerTimeNow() - script_SummerHarvestTeamConfigAccessor.EventStartTime) / script_SummerHarvestTeamConfigAccessor.DayLength;
    local v53 = math.floor(v52) + 1;
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    if Data then
        Data = Data.CompletedDays;
    end;

    local v54;

    if type(Data) == "table" then
        v54 = Data[`Day{p50}`] == true;
    else
        v54 = false;
    end;

    local DailyPointGoal = script_SummerHarvestTeamConfigAccessor.GetDailyPointGoal(p50);
    local v55;

    if v54 then
        v55 = DailyPointGoal;
    elseif p50 == v53 then
        v55 = GetTeamCurrentDayTotal(p50);
    else
        local Data2 = DataService:GetData();

        if Data2 then
            Data2 = Data2.SummerHarvestTeamData;
        end;

        if Data2 then
            Data2 = Data2.TeamDayTotals;
        end;

        if type(Data2) == "table" then
            local v56 = Data2[`Day{p50}`];
            v55 = tonumber(v56);
        else
            v55 = nil;
        end;

        if not v55 then
            local Data3 = DataService:GetData();

            if Data3 then
                Data3 = Data3.SummerHarvestTeamData;
            end;

            if Data3 then
                Data3 = Data3.DayPoints;
            end;

            if type(Data3) == "table" then
                local v57 = Data3[`Day{p50}`];
                v55 = tonumber(v57) or 0;
            else
                v55 = 0;
            end;
        end;
    end;

    SetBar(v51:FindFirstChild("Bar"), v55, DailyPointGoal, v54 and "Completed!" or `{math.floor(v55)} / {DailyPointGoal}`);
    SetItemObtained(v51:FindFirstChild("ITEM_TEMPLATE"), v54);
    local Locked = v51:FindFirstChild("Locked");

    if Locked and Locked:IsA("GuiObject") then
        local v58 = v53 < p50;
        local v59;

        if p50 < v53 then
            v59 = not v54;
        else
            v59 = false;
        end;

        Locked.Visible = v58 or v59;
        local TimeLeft = Locked:FindFirstChild("TimeLeft");
        local UnlockTime = Locked:FindFirstChild("UnlockTime");

        if v58 then
            local v60 = script_SummerHarvestTeamConfigAccessor.EventStartTime + (p50 - 1) * script_SummerHarvestTeamConfigAccessor.DayLength - workspace:GetServerTimeNow();

            if TimeLeft and TimeLeft:IsA("TextLabel") then
                local math_floor_ret = math.floor(v60);
                local math_max_ret = math.max(0, math_floor_ret);
                local v61 = math_max_ret // 86400;
                local v62 = math_max_ret % 86400 // 3600;
                local v63 = math_max_ret % 3600 // 60;
                local v64 = math_max_ret % 60;
                local v65;

                if v61 > 0 then
                    v65 = `{v61}d {v62}h`;
                elseif v62 > 0 then
                    v65 = `{v62}h {v63}m`;
                else
                    v65 = `{v63}m {v64}s`;
                end;

                TimeLeft.Text = v65;

                if u8 then
                    TimeLeft.TextColor3 = u8;
                end;
            end;

            if UnlockTime and UnlockTime:IsA("TextLabel") then
                UnlockTime.Text = "Unlocks in";
            end;
        elseif v59 then
            if TimeLeft and TimeLeft:IsA("TextLabel") then
                TimeLeft.Text = "EXPIRED";
                TimeLeft.TextColor3 = Color3_fromRGB_ret;
            end;

            if UnlockTime and UnlockTime:IsA("TextLabel") then
                local v66 = v53 - p50;
                UnlockTime.Text = v66 == 1 and "1 day ago" or `{v66} days ago`;
            end;
        end;
    end;
end;

local u67 = nil;

local function Render() -- Line: 443
    -- upvalues: script_SummerHarvestTeamConfigAccessor (copy), u67 (ref), u6 (copy), SetItemReward (copy), Finale (copy), RenderDay (copy), DataService (copy), SetBar (copy), Bar (copy), SetItemObtained (copy), u9 (ref), u10 (ref)
    local v68 = tonumber(script_SummerHarvestTeamConfigAccessor.EventSeason) or 1;

    if v68 ~= u67 then
        u67 = v68;

        for i = 1, script_SummerHarvestTeamConfigAccessor.TotalDays do
            local v69 = u6[i];
            local v70;

            if v69 then
                SetItemReward(v69:FindFirstChild("ITEM_TEMPLATE"), script_SummerHarvestTeamConfigAccessor.DailyRewards[i]);
                v70 = i;
            else
                v70 = i;
            end;
        end;

        SetItemReward(Finale:FindFirstChild("ITEM_TEMPLATE"), script_SummerHarvestTeamConfigAccessor.GrandPrize);
    end;

    for i = 1, script_SummerHarvestTeamConfigAccessor.TotalDays do
        RenderDay(i);
        local _ = i;
    end;

    local v71 = 0;

    for i = 1, script_SummerHarvestTeamConfigAccessor.TotalDays do
        local Data = DataService:GetData();

        if Data then
            Data = Data.SummerHarvestTeamData;
        end;

        if Data then
            Data = Data.CompletedDays;
        end;

        local v72;

        if type(Data) == "table" then
            v72 = Data[`Day{i}`] == true;
        else
            v72 = false;
        end;

        local v73;

        if v72 then
            v71 = v71 + 1;
            v73 = i;
        else
            v73 = i;
        end;
    end;

    SetBar(Bar, v71, script_SummerHarvestTeamConfigAccessor.DaysRequiredForGrandPrize, (`{v71} / {script_SummerHarvestTeamConfigAccessor.DaysRequiredForGrandPrize} Days`));
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerHarvestTeamData;
    end;

    local v74;

    if type(Data) == "table" then
        v74 = Data.GrandPrizeAwarded == true;
    else
        v74 = false;
    end;

    SetItemObtained(Finale:FindFirstChild("ITEM_TEMPLATE"), v74);
    local Tick = Finale:FindFirstChild("Tick");

    if Tick and Tick:IsA("GuiObject") then
        Tick.Visible = v74;
    end;

    local v75;

    if v74 then
        v75 = u9;
    else
        v75 = u10;
    end;

    if v75 then
        local Position = Bar.Position;
        Bar.Position = UDim2.new(v75, Position.X.Offset, Position.Y.Scale, Position.Y.Offset);
    end;
end;

local u76 = false;

local function HookGuiController() -- Line: 490
    -- upvalues: u76 (ref), GuiController (copy), SummerHarvestUI (copy), Header (copy), SoundService (copy), PlayerGui (copy), UserInputService (copy), u7 (ref), Build (copy), Render (copy)
    if u76 then
        return;
    end;

    u76 = true;
    GuiController:UsePopupAnims(SummerHarvestUI);
    local StateForGui = GuiController:GetStateForGui(SummerHarvestUI);
    StateForGui.ChangeEnabled:Set(true);
    StateForGui.Visible:Observe(function(p77) -- Line: 500
    end);
    local Close = Header:FindFirstChild("Close");

    if Close and Close:IsA("GuiButton") then
        Close.Activated:Connect(function() -- Line: 506
            -- upvalues: GuiController (ref), SummerHarvestUI (ref)
            GuiController:Close(SummerHarvestUI);
        end);
    end;

    local ViewTeam = Header:FindFirstChild("ViewTeam");

    if ViewTeam and ViewTeam:IsA("GuiButton") then
        ViewTeam.Activated:Connect(function() -- Line: 514
            -- upvalues: SoundService (ref), PlayerGui (ref), GuiController (ref)
            local Click = SoundService:FindFirstChild("Click");

            if Click and Click:IsA("Sound") then
                Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                Click.TimePosition = 0;
                Click.Playing = true;
            end;

            local TeamEventPartyInvite_UI = PlayerGui:FindFirstChild("TeamEventPartyInvite_UI");

            if TeamEventPartyInvite_UI and TeamEventPartyInvite_UI:IsA("ScreenGui") then
                GuiController:Open(TeamEventPartyInvite_UI);
            end;
        end);

        if not UserInputService.TouchEnabled then
            ViewTeam.MouseEnter:Connect(function() -- Line: 522
                -- upvalues: SoundService (ref)
                local Hover = SoundService:FindFirstChild("Hover");

                if Hover and Hover:IsA("Sound") then
                    Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    Hover.TimePosition = 0;
                    Hover.Playing = true;
                end;
            end);
        end;
    end;

    StateForGui.Visible:Observe(function(p78: boolean) -- Line: 528
        -- upvalues: u7 (ref), Build (ref), Render (ref)
        u7 = p78;

        if not p78 then
            return;
        end;

        Build();
        Render();
    end);
end;

local function ConnectDataSignal(u79: string, p80: any) -- Line: 538
    -- upvalues: DataService (copy)
    local success, result = pcall(function() -- Line: 539
        -- upvalues: DataService (ref), u79 (copy)
        return DataService:GetPathSignal(u79);
    end);

    if success and result then
        result:Connect(p80);
    end;
end;

local u81 = false;

local function QueueRender() -- Line: 554
    -- upvalues: u81 (ref), Render (copy)
    if u81 then
        return;
    end;

    u81 = true;
    task.defer(function() -- Line: 559
        -- upvalues: u81 (ref), Render (ref)
        u81 = false;
        Render();
    end);
end;

function u5.Start() -- Line: 565
    -- upvalues: GlobalUpdateTime (copy), Build (copy), HookGuiController (copy), Render (copy), QueueRender (copy), DataService (copy), u81 (ref), TeamEventController (copy), u7 (ref), LocalPlayer (copy), UserInputService (copy), GuiController (copy), SummerHarvestUI (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Value = GlobalUpdateTime.Value;

    if (Value > 1785616200 and 1785616200 or Value) <= ServerTimeNow then
        return;
    end;

    Build();
    HookGuiController();
    Render();
    local v82 = QueueRender;
    local u83 = "SummerHarvestTeamData";
    local success, result = pcall(function() -- Line: 539
        -- upvalues: DataService (ref), u83 (copy)
        return DataService:GetPathSignal(u83);
    end);

    if success and result then
        result:Connect(v82);
    end;

    local v84 = QueueRender;
    local u85 = "SummerHarvestTeamData/@";
    local success2, result2 = pcall(function() -- Line: 539
        -- upvalues: DataService (ref), u85 (copy)
        return DataService:GetPathSignal(u85);
    end);

    if success2 and result2 then
        result2:Connect(v84);
    end;

    local v86 = QueueRender;
    local u87 = "SummerHarvestTeamData/DayPoints/@";
    local success3, result3 = pcall(function() -- Line: 539
        -- upvalues: DataService (ref), u87 (copy)
        return DataService:GetPathSignal(u87);
    end);

    if success3 and result3 then
        result3:Connect(v86);
    end;

    local v88 = QueueRender;
    local u89 = "SummerHarvestTeamData/CompletedDays/@";
    local success4, result4 = pcall(function() -- Line: 539
        -- upvalues: DataService (ref), u89 (copy)
        return DataService:GetPathSignal(u89);
    end);

    if success4 and result4 then
        result4:Connect(v88);
    end;

    local Receiver = DataService.Receiver;

    if Receiver and Receiver.GlobalChanged then
        Receiver.GlobalChanged:Connect(function(p90, p91, p92, p93) -- Line: 582
            -- upvalues: u81 (ref), Render (ref)
            if type(p93) == "string" and p93:find("SummerHarvestTeamData", 1, true) == 1 then
                if u81 then
                    return;
                end;

                u81 = true;
                task.defer(function() -- Line: 559
                    -- upvalues: u81 (ref), Render (ref)
                    u81 = false;
                    Render();
                end);
            end;
        end);
    end;

    if TeamEventController.DataUpdated then
        TeamEventController.DataUpdated:Connect(QueueRender);
    end;

    task.spawn(function() -- Line: 597
        -- upvalues: u7 (ref), Render (ref)
        while true do
            repeat
                task.wait(1);
            until u7;

            Render();
        end;
    end);

    if LocalPlayer.Name == "Luaappp" then
        UserInputService.InputBegan:Connect(function(p94, p95) -- Line: 608
            -- upvalues: GuiController (ref), SummerHarvestUI (ref)
            if p95 then
                return;
            end;

            if p94.KeyCode == Enum.KeyCode.X then
                GuiController:Open(SummerHarvestUI);
            end;
        end);
    end;
end;

local u96 = false;
EventRotationController.EventUpdated:Connect(function(p97: string, p98: string) -- Line: 620, Name: OnEventUpdated
    -- upvalues: u1 (copy), u96 (ref), u5 (copy)
    if p98 ~= "Summer2026Event" then
        u1:Clean();
        u96 = false;

        return;
    end;

    if u96 then
        return;
    end;

    u96 = true;
    u1:Clean();
    task.spawn(u5.Start, u5);
end);

return u5;