-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local GetFarmAncestor = require(ReplicatedStorage.Modules.GetFarmAncestor);
local Value = ReplicatedFirst.DayInSeconds.Value;
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = GetFarmAsync(LocalPlayer);
LocalPlayer.CharacterAdded:Connect(function(p3) -- Line: 20
    -- upvalues: u1 (ref)
    u1 = p3;
end);
local u4 = {
    MaxPotDistance = 15,
    LinkedPotsToLocalPlayer = {},
    OwnedPots = {}
};
local LinkedPotsToLocalPlayer = u4.LinkedPotsToLocalPlayer;
local OwnedPots = u4.OwnedPots;
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local PotUI = script:WaitForChild("PotUI");
local MainFrame = PotUI.BillboardGui.MainFrame;
local STATE_TEXT = MainFrame.STATE_TEXT;
local TIMER_TEXT = MainFrame.TIMER_TEXT;
local EXPIRY_TEXT = MainFrame.EXPIRY_TEXT;
CreateTagHandler({
    Tag = "FriendshipPotServer",

    OnInstanceAdded = function(p5: userdata) -- Line: 47, Name: OnInstanceAdded
        -- upvalues: LocalPlayer (copy), LinkedPotsToLocalPlayer (copy), u2 (copy), GetFarmAncestor (copy), OwnedPots (copy)
        if p5:GetAttribute("LinkedPlayerID") == LocalPlayer.UserId then
            LinkedPotsToLocalPlayer[p5] = true;

            return;
        end;

        if u2 == GetFarmAncestor(p5) then
            OwnedPots[p5] = true;
        end;
    end,

    OnInstanceRemoved = function(p6: userdata) -- Line: 55, Name: OnInstanceRemoved
        -- upvalues: LinkedPotsToLocalPlayer (copy), OwnedPots (copy)
        LinkedPotsToLocalPlayer[p6] = nil;
        OwnedPots[p6] = nil;
    end
});

local function FindTargetPots() -- Line: 61
    -- upvalues: u1 (ref), LinkedPotsToLocalPlayer (copy), u4 (copy)
    local Position = u1:GetPivot().Position;
    local v7 = (1 / 0);
    local v8 = nil;

    for i in LinkedPotsToLocalPlayer do
        local Magnitude = (i:GetPivot().Position - Position).Magnitude;

        if v7 > Magnitude and u4.MaxPotDistance > Magnitude then
            v8 = i;
            v7 = Magnitude;
        end;
    end;

    return v8, v7;
end;

local function FindOwnedPots() -- Line: 79
    -- upvalues: u1 (ref), OwnedPots (copy), u4 (copy)
    local Position = u1:GetPivot().Position;
    local v9 = (1 / 0);
    local v10 = nil;

    for i in OwnedPots do
        local Magnitude = (i:GetPivot().Position - Position).Magnitude;

        if v9 > Magnitude and u4.MaxPotDistance > Magnitude then
            v10 = i;
            v9 = Magnitude;
        end;
    end;

    return v10, v9;
end;

local function HasLocalUserPlacedDownPlotFor(p11: userdata, p12: string) -- Line: 97
    -- upvalues: DataService (copy)
    for _, v in DataService:GetData().SavedObjects do
        if v.ObjectType == "FriendshipPot" then
            local Data = v.Data;

            if Data.PotType == p12 and Data.LinkedPlayerID == p11.UserId then
                return true;
            end;
        end;
    end;
end;

local function GetOwnerFromPot(p13: userdata) -- Line: 114
    -- upvalues: Players (copy)
    local v14 = p13:FindFirstAncestor("Farm");

    if v14 then
        v14 = v14:FindFirstChild("Important");
    end;

    if v14 then
        v14 = v14:FindFirstChild("Data");
    end;

    if v14 then
        v14 = v14:FindFirstChild("Owner");
    end;

    return Players:FindFirstChild(v14.Value);
end;

local u15 = false;

local function GetUsernameFromPot(p16) -- Line: 128
    -- upvalues: Players (copy)
    local Attribute = p16:GetAttribute("LinkedPlayerID");

    if Attribute then
        local success, result = pcall(function() -- Line: 132
            -- upvalues: Players (ref), Attribute (copy)
            return Players:GetNameFromUserIdAsync(Attribute);
        end);

        if success then
            p16:SetAttribute("LinkedPlayerID_NAME", result);
        end;
    end;

    return p16:GetAttribute("LinkedPlayerID_NAME") or "UNKNOWN";
end;

local u17 = 0;
task.spawn(function() -- Line: 147
    -- upvalues: u17 (ref)
    while true do
        u17 = workspace:GetServerTimeNow();
        task.wait(1);
    end;
end);

local function GetCurrentDay() -- Line: 154
    -- upvalues: u17 (ref), Value (copy)
    return math.floor(u17 / Value);
end;

local function CanTendToStreak(p18) -- Line: 159
    -- upvalues: Value (copy), u17 (ref)
    local v19;

    if p18 then
        local v20 = (p18:GetAttribute("LastStreakTime") or 0) / Value;
        v19 = math.floor(v20);
    else
        v19 = 0;
    end;

    return v19 ~= math.floor(u17 / Value);
end;

local function CanTend(p21) -- Line: 166
    -- upvalues: Value (copy), u17 (ref)
    local v22 = not p21 and 0 or p21:GetAttribute("LastTendTime");

    return math.floor(v22 / Value) ~= math.floor(u17 / Value);
end;

local function GetTimeUntilYouCanTend(p23) -- Line: 173
    -- upvalues: u17 (ref), Value (copy), TimeHelper (copy)
    return TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17);
end;

local function IsStreakFailed(p24) -- Line: 181
    -- upvalues: u17 (ref), Value (copy)
    local math_floor_ret = math.floor(u17 / Value);
    local v25 = p24:GetAttribute("LastStreakTime") / Value;
    local math_floor_ret2 = math.floor(v25);
    local v26;

    if math_floor_ret2 > 0 then
        v26 = math_floor_ret2 + 1 < math_floor_ret;
    else
        v26 = false;
    end;

    return v26;
end;

local function GetExpiryTime() -- Line: 190
    -- upvalues: u17 (ref), Value (copy), TimeHelper (copy)
    return TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17);
end;

local function UpdatePotUserInterface() -- Line: 196
    -- upvalues: FindOwnedPots (copy), FindTargetPots (copy), Value (copy), GetOwnerFromPot (copy), HasLocalUserPlacedDownPlotFor (copy), u17 (ref), TimeHelper (copy), GetUsernameFromPot (copy), STATE_TEXT (copy), TIMER_TEXT (copy), EXPIRY_TEXT (copy), u15 (ref), PotUI (copy)
    local v27, v28 = FindOwnedPots();
    local v29, v30 = FindTargetPots();
    local v31;

    if v27 and v29 then
        if v30 <= v28 then
            v31 = v29;
        else
            v31 = v27;
        end;
    else
        v31 = v27 or v29;
    end;

    if v31 then
        local v32 = (v31:GetAttribute("LastStreakTime") or 0) / Value;
        math.floor(v32);
    end;

    local v33;

    if v31 then
        v33 = GetOwnerFromPot(v31);
    else
        v33 = v31;
    end;

    local v34;

    if v27 then
        v34 = true;
    elseif v33 then
        v34 = HasLocalUserPlacedDownPlotFor(v33, v31:GetAttribute("PotType"));
    else
        v34 = v33;
    end;

    local v35 = TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17);
    local v36;

    if v31 then
        v36 = GetUsernameFromPot(v31);
    else
        v36 = v31;
    end;

    local v37;

    if v31 then
        local v38 = (v31:GetAttribute("LastStreakTime") or 0) / Value;
        v37 = math.floor(v38);
    else
        v37 = 0;
    end;

    local v39 = v37 ~= math.floor(u17 / Value);
    local v40;

    if v31 then
        local math_floor_ret = math.floor(u17 / Value);
        local v41 = v31:GetAttribute("LastStreakTime") / Value;
        local math_floor_ret2 = math.floor(v41);

        if math_floor_ret2 > 0 then
            v40 = math_floor_ret2 + 1 < math_floor_ret;
        else
            v40 = false;
        end;
    else
        v40 = v31;
    end;

    STATE_TEXT.Text = not v34 and "You haven\'t placed down your friend\'s pot yet!" or ("[%s Pot]: %s ❤️  "):format(`{v33.Name} & {v36}'s`, v31:GetAttribute("CurrentStreak") or 0);

    if v27 then
        local v42;

        if v34 then
            local v43 = not v31 and 0 or v31:GetAttribute("LastTendTime");

            if math.floor(v43 / Value) ~= math.floor(u17 / Value) then
                v42 = `Get {v36} to tend to your pot within {TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17)}`;
            elseif v34 and v39 then
                v42 = `Tend {v36}'s pot within {TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17)} to keep your streak!`;
            else
                v42 = `{v35} until your friend can tend!`;
            end;
        elseif v34 and v39 then
            v42 = `Tend {v36}'s pot within {TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17)} to keep your streak!`;
        else
            v42 = `{v35} until your friend can tend!`;
        end;

        TIMER_TEXT.Text = v42;
    elseif v29 then
        local v44;

        if v34 then
            local v45 = not v31 and 0 or v31:GetAttribute("LastTendTime");

            if math.floor(v45 / Value) ~= math.floor(u17 / Value) then
                v44 = `Tend this pot within {TimeHelper:GenerateColonFormatFromTime((math.floor(u17 / Value) + 1) * Value - u17)}!`;
            else
                v44 = `{v35} until you can tend!`;
            end;
        else
            v44 = `{v35} until you can tend!`;
        end;

        TIMER_TEXT.Text = v44;
    end;

    TIMER_TEXT.Visible = not v40 and v34;
    EXPIRY_TEXT.Visible = v40;
    EXPIRY_TEXT.Text = "STREAK FAILED!";
    u15 = v31;

    if not v31 then
        PotUI.Parent = script;

        return;
    end;

    PotUI:PivotTo(v31:GetPivot());
    PotUI.Parent = workspace;
end;

task.spawn(function() -- Line: 245
    -- upvalues: UpdatePotUserInterface (copy)
    while true do
        task.wait(0.25);
        UpdatePotUserInterface();
    end;
end);

return u4;