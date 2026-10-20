-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local NPCLevelData = require(ReplicatedStorage.Data.NPCLevels.NPCLevelData);
local NPCLevelTypes = require(ReplicatedStorage.Data.NPCLevels.NPCLevelData.NPCLevelTypes);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local SetNPCBirthday_RE = ReplicatedStorage.GameEvents.SetNPCBirthday_RE;
local LocalPlayer = game.Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found");
local NPCLevelUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("NPCLevelUI");
local LevelText = NPCLevelUI:WaitForChild("LevelFrame"):WaitForChild("LevelText");
local TimeFrame = NPCLevelUI:WaitForChild("TimeFrame");
local TimeText = TimeFrame:WaitForChild("TimeText");
local BarFrame = NPCLevelUI:WaitForChild("BarFrame");
local Bar = BarFrame:WaitForChild("Bar");
local BarText = BarFrame:WaitForChild("BarText");
local Size = NPCLevelUI.Size;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u6 = {
    GetNPCPoints = function(p4, p5) -- Line: 50, Name: GetNPCPoints
        -- upvalues: DataService (copy), NPCLevelTypes (copy)
        local Data = DataService:GetData();

        if Data then
            return (Data.NPCPoints[p5] or NPCLevelTypes:DefaultData()).Points or 0;
        end;

        warn("No player data for local player");

        return 0;
    end
};

function u6.GetNPCLevel(p7, p8) -- Line: 66
    -- upvalues: NPCLevelData (copy), u6 (copy)
    return NPCLevelData:GetLevelFromPoints(p8, u6:GetNPCPoints(p8));
end;

function u6.GetLevelProgress(p9, p10) -- Line: 71
    -- upvalues: u6 (copy), NPCLevelData (copy)
    local NPCLevel = u6:GetNPCLevel(p10);
    local NPCPoints = u6:GetNPCPoints(p10);
    local LevelPoints = NPCLevelData:GetLevelPoints(p10, NPCLevel);
    local LevelPoints2 = NPCLevelData:GetLevelPoints(p10, NPCLevel + 1);

    if LevelPoints2 == 0 then
        return 0, 0;
    end;

    return NPCPoints - LevelPoints, LevelPoints2 - LevelPoints;
end;

function u6.HasRequiredNPCLevels(p11: table, p12: table?) -- Line: 88
    -- upvalues: DataService (copy), u6 (copy)
    if not p12 or next(p12) == nil then
        return true;
    end;

    if DataService:GetData() then
        for i, v in p12 do
            if u6:GetNPCLevel(i) < v then
                return false;
            end;
        end;

        return true;
    end;

    warn("No player data for local player");

    return false;
end;

function u6.GetLastFeedTime(p13, p14) -- Line: 110
    -- upvalues: DataService (copy), LocalPlayer (copy), NPCLevelTypes (copy)
    local Data = DataService:GetData();

    if Data then
        return (Data.NPCPoints[p14] or NPCLevelTypes:DefaultData()).LastFeedTime or 0;
    end;

    warn((`No player data for {LocalPlayer.Name}`));

    return 0;
end;

function u6.IsFeedTime(p15, p16) -- Line: 125
    -- upvalues: u6 (copy), NPCLevelData (copy)
    local LastFeedTime = u6:GetLastFeedTime(p16);
    local v17 = workspace:GetServerTimeNow() - LastFeedTime;
    local v18 = NPCLevelData.NPCEntires[p16];

    if v18 then
        return v18.FeedCooldown <= v17, v18.FeedCooldown - v17;
    end;

    warn((`Invalid NPC name: {p16}`));

    return false, 0;
end;

local function ShowLevelDisplay() -- Line: 142
    -- upvalues: NPCLevelUI (copy), u1 (ref), u2 (ref), u3 (ref), TweenService (copy), Size (copy)
    if NPCLevelUI.Enabled then
        return;
    end;

    NPCLevelUI.Enabled = true;

    if u1 then
        u1:Cancel();
        u1 = nil;
    end;

    if u2 then
        u2:Cancel();
        u2 = nil;
    end;

    if u3 then
        task.cancel(u3);
        u3 = nil;
    end;

    u1 = TweenService:Create(NPCLevelUI, TweenInfo.new(0.5), {
        Size = Size
    });

    if not u1 then
        return;
    end;

    u1:Play();
    u1.Completed:Once(function() -- Line: 159
        -- upvalues: u1 (ref)
        u1 = nil;
    end);
end;

local function HideLevelDisplay(u19: number?) -- Line: 165
    -- upvalues: NPCLevelUI (copy), u3 (ref), u1 (ref), u2 (ref), TweenService (copy)
    if not NPCLevelUI.Enabled then
        return;
    end;

    if u3 and coroutine.status(u3) ~= "dead" then
        return;
    end;

    if u1 then
        u1:Cancel();
        u1 = nil;
    end;

    if u2 then
        u2:Cancel();
        u2 = nil;
    end;

    if u3 then
        task.cancel(u3);
        u3 = nil;
    end;

    u2 = TweenService:Create(NPCLevelUI, TweenInfo.new(0.5), {
        Size = UDim2.new(0, 0, 0, 0)
    });
    u3 = task.spawn(function() -- Line: 181
        -- upvalues: u19 (copy), u2 (ref), NPCLevelUI (ref), u3 (ref)
        task.wait(u19 or 0);

        if not u2 then
            NPCLevelUI.Enabled = false;

            return;
        end;

        u2:Play();
        u2.Completed:Once(function() -- Line: 188
            -- upvalues: NPCLevelUI (ref), u2 (ref)
            NPCLevelUI.Enabled = false;
            u2 = nil;
        end);
        u3 = nil;
    end);
end;

local function UpdateLevelDisplay() -- Line: 198
    -- upvalues: LocalPlayer (copy), HideLevelDisplay (copy), NPCLevelUI (copy), NPCLevelData (copy), UpdateService (copy), u6 (copy), TimeFrame (copy), TimeText (copy), NumberUtil (copy), BarText (copy), LevelText (copy), TweenService (copy), Bar (copy), ShowLevelDisplay (copy)
    local v20 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

    if not v20 then
        HideLevelDisplay();

        return;
    end;

    local v21 = v20:FindFirstChildWhichIsA("Tool");

    if v21 then
        v21 = v21:HasTag("FoodTool");
    end;

    if not v21 then
        HideLevelDisplay(3);

        if not NPCLevelUI.Enabled then
            return;
        end;
    end;

    local v22 = (1 / 0);
    local v23 = nil;

    for i, v in NPCLevelData:GetTrackedNPCs() do
        if not (v ~= "Sam" and UpdateService:IsHiddenFromUpdate("NPCBirthday") or NPCLevelData.NPCEntires[v].OnlyFeedBirthday) then
            local Magnitude = (i:GetPivot().Position - v20:GetPivot().Position).Magnitude;

            if Magnitude < v22 and Magnitude <= 30 then
                v23 = i;
                v22 = Magnitude;
            end;
        end;
    end;

    if not v23 then
        HideLevelDisplay();

        return;
    end;

    local v24 = NPCLevelData:TryGetNPCName(v23);

    if not v24 then
        warn((`No tracked NPC for {v23:GetFullName()}`));
        HideLevelDisplay();

        return;
    end;

    local v25 = v23:GetExtentsSize().Y / 2;
    NPCLevelUI.Adornee = v23.PrimaryPart;
    NPCLevelUI.StudsOffsetWorldSpace = Vector3.new(0, v25 + 2, 0);
    local NPCLevel = u6:GetNPCLevel(v24);
    local LevelProgress, v26 = u6:GetLevelProgress(v24);
    local v27 = LevelProgress / v26;
    local v28, v29 = u6:IsFeedTime(v24);
    TimeFrame.Visible = not v28;
    TimeText.Text = `Cooldown: {NumberUtil.compactFormat(v29)}`;

    if v26 == 0 then
        BarText.Text = "Points: MAX!";
        TimeFrame.Visible = false;
        v27 = 1;
    else
        BarText.Text = `Points: {LevelProgress}/{v26}`;
    end;

    LevelText.Text = `Friendship Level: {NPCLevel} ⭐`;
    TweenService:Create(Bar, TweenInfo.new(0.25), {
        Size = UDim2.fromScale(v27 * 0.96, 0.7)
    }):Play();
    ShowLevelDisplay();
end;

HideLevelDisplay();
task.spawn(function() -- Line: 293
    -- upvalues: UpdateLevelDisplay (copy)
    while true do
        task.wait(0.25);
        UpdateLevelDisplay();
    end;
end);
SetNPCBirthday_RE.OnClientEvent:Connect(function(p30: any, p31: number, p32: number) -- Line: 302
    -- upvalues: NPCLevelData (copy)
    local v33 = NPCLevelData.NPCEntires[p30];

    if not v33 then
        warn((`Invalid NPC name: {p30}`));

        return;
    end;

    v33.BirthdayDay = p31;
    v33.BirthdayMonth = p32;
    NPCLevelData.NPCEntires[p30] = v33;
end);

return u6;