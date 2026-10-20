-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("StarterGui");
local Modules = ReplicatedStorage.Modules;
local GameEvents = ReplicatedStorage.GameEvents;
local PollingService = GameEvents.PollingService;
local PollingController = GameEvents.PollingController;
local PollingTypes = require(ReplicatedStorage.Types.PollingTypes);
local SetupRemotes = require(Modules.SetupRemotes);
local FastTween = require(Modules.FastTween);
local Shime = require(Modules.Shime);
local IsGlobalCommandAuthorized = require(Modules.IsGlobalCommandAuthorized);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Poll_UI = PlayerGui.Poll_UI;
local Teleport_UI = PlayerGui.Teleport_UI;
local Frame = Poll_UI.Frame;
local Header = Frame.Header;
local Main = Frame.Main;
local Container = Main.Container;
local Title = Header.Title;
local Close = Header.Close;
local Value = Main.TimeRemaining.Value;

local function GetBorderStroke(p2: userdata) -- Line: 46
    for _, child in p2:GetChildren() do
        if child:IsA("UIStroke") and child.BorderStrokePosition == Enum.BorderStrokePosition.Outer then
            return child;
        end;
    end;

    return nil;
end;

local Yes = Container.Yes;
local No = Container.No;
local Answer = Yes.Answer;
local Answer2 = No.Answer;
local Claim = Yes.Claim;
local Claim2 = No.Claim;
local InletTexture = Claim.InletTexture;
local InletTexture2 = Claim2.InletTexture;
local v3 = GetBorderStroke(Claim);
local v4 = GetBorderStroke(Claim2);
local Fill = Container.Fill;
local YesFill = Fill.YesFill;
local YesCount = Fill.YesCount;
local NoCount = Fill.NoCount;
local Pointer = Fill.Pointer;
local Position = Frame.Position;
local Position2 = Teleport_UI.Frame.Position;
local u5 = {
    {
        OptionIndex = 1,
        Button = Yes,
        Answer = Answer,
        Claim = Claim,
        Inlet = InletTexture,
        Stroke = v3,
        Fill = YesFill
    },
    {
        OptionIndex = 2,
        Button = No,
        Answer = Answer2,
        Claim = Claim2,
        Inlet = InletTexture2,
        Stroke = v4,
        Fill = Fill
    }
};
local u6 = nil;
local u7 = nil;
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = 0;

local function FormatNumber(p15: number) -- Line: 118
    local math_floor_ret = math.floor(p15);
    local v16 = tostring(math_floor_ret);
    local v17;

    repeat
        v16, v17 = string.gsub(v16, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v17 == 0;

    return v16;
end;

local function FormatTime(p18: number) -- Line: 128
    local math_floor_ret = math.floor(p18);
    local math_max_ret = math.max(0, math_floor_ret);

    return string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
end;

local function CleanupShimes() -- Line: 133
    -- upvalues: u7 (ref)
    if u7 then
        for _, v in u7 do
            v:Cancel();
        end;

        table.clear(u7);
    end;

    u7 = nil;
end;

local function GetPollCountdownText(p19) -- Line: 144
    -- upvalues: PollingTypes (copy), u7 (ref)
    local os_time_ret = os.time();

    if p19.Status == PollingTypes.PollStatus.Pending then
        if not p19.StartsAt then
            return "Poll starting soon...";
        end;

        local math_floor_ret = math.floor(p19.StartsAt.UnixTimestamp - os_time_ret);
        local math_max_ret = math.max(0, math_floor_ret);

        return `Poll starting in {string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60)}...`;
    end;

    if p19.Status ~= PollingTypes.PollStatus.Active and p19.Status ~= PollingTypes.PollStatus.Closing then
        if u7 then
            for _, v in u7 do
                v:Cancel();
            end;

            table.clear(u7);
        end;

        u7 = nil;

        return "The poll has ended!";
    end;

    if not p19.EndsAt then
        return "Voting open!";
    end;

    local math_floor_ret = math.floor(p19.EndsAt.UnixTimestamp - os_time_ret);
    local math_max_ret = math.max(0, math_floor_ret);

    return `{string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60)} Remaining`;
end;

local function InitShimes() -- Line: 163
    -- upvalues: u7 (ref), u5 (copy), Shime (copy)
    if u7 then
        for _, v in u7 do
            v:Cancel();
        end;

        table.clear(u7);
    end;

    u7 = nil;
    u7 = {};

    for _, v in u5 do
        local v20 = Shime.new(v.Claim);
        v20:Play();
        table.insert(u7, v20);
    end;
end;

local function HasSelected(p21: string, p22: number) -- Line: 175
    -- upvalues: u8 (copy)
    local v23 = u8[p21];
    local v24;

    if v23 == nil then
        v24 = false;
    else
        v24 = table.find(v23, p22) ~= nil;
    end;

    return v24;
end;

local function SetButtonInteractable(p25: userdata, p26: boolean) -- Line: 180
    p25.Active = p26;
    p25.AutoButtonColor = p26;
    p25.Interactable = p26;
end;

local u27 = false;

local function SyncPollVisibility() -- Line: 187
    -- upvalues: u27 (ref), Frame (copy), Teleport_UI (copy)
    if not u27 then
        return;
    end;

    Frame.Visible = Teleport_UI.Enabled;
end;

local function SetOpen(p28: boolean) -- Line: 195
    -- upvalues: u27 (ref), Frame (copy), Position2 (copy), Position (copy), Poll_UI (copy), Teleport_UI (copy), InitShimes (copy), FastTween (copy), u7 (ref)
    if u27 == p28 then
        return;
    end;

    local math_ceil_ret = math.ceil(Frame.AbsoluteSize.Y);

    if p28 then
        local UDim2_new_ret = UDim2.new(Position2.X, UDim.new(Position2.Y.Scale + Position.Y.Scale, math_ceil_ret));
        Poll_UI.Enabled = true;
        Frame.Visible = Teleport_UI.Enabled;
        Frame.Position = UDim2.new(0.5, 0, 0, -math_ceil_ret);
        InitShimes();
        FastTween(Frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = Position
        });
        FastTween(Teleport_UI.Frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2_new_ret
        });
    else
        FastTween(Frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0, -math_ceil_ret)
        });
        FastTween(Teleport_UI.Frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = Position2
        });
        task.wait(0.15);
        Frame.Visible = false;

        if u7 then
            for _, v in u7 do
                v:Cancel();
            end;

            table.clear(u7);
        end;

        u7 = nil;
    end;

    u27 = p28;
end;

local function StopCountdown() -- Line: 233
    -- upvalues: u14 (ref), u13 (ref)
    u14 = u14 + 1;
    u13 = nil;
end;

local function StartCountdown() -- Line: 238
    -- upvalues: u13 (ref), u14 (ref), u6 (ref), Value (copy), GetPollCountdownText (copy), PollingTypes (copy), u11 (ref), u9 (ref), u10 (ref), u12 (ref), SetOpen (copy)
    if u13 then
        return;
    end;

    u14 = u14 + 1;
    local u29 = u14;
    u13 = task.spawn(function() -- Line: 246
        -- upvalues: u14 (ref), u29 (copy), u6 (ref), Value (ref), GetPollCountdownText (ref), PollingTypes (ref), u11 (ref), u9 (ref), u10 (ref), u12 (ref), u13 (ref), SetOpen (ref)
        while true do
            local v30 = u14 == u29 and u6;

            if not v30 then
                break;
            end;

            Value.Text = GetPollCountdownText(v30);

            if v30.Status == PollingTypes.PollStatus.Closed and (u11 and u11 <= os.time()) then
                u9 = v30.Id;
                u10 = v30.Status;
                u6 = nil;
                u11 = nil;
                u12 = nil;
                u14 = u14 + 1;
                u13 = nil;
                SetOpen(false);
                break;
            end;

            task.wait(1);
        end;

        if u14 == u29 then
            u13 = nil;
        end;
    end);
end;

local function RenderResults(p31) -- Line: 275
    -- upvalues: YesCount (copy), FormatNumber (copy), NoCount (copy), FastTween (copy), YesFill (copy), Pointer (copy)
    local v32 = p31.Votes[1] or 0;
    local v33 = p31.Votes[2] or 0;
    local v34 = v32 + v33;
    local v35 = v34 <= 0 and 0.5 or math.clamp(v32 / v34, 0, 1);
    YesCount.Text = FormatNumber(v32);
    NoCount.Text = FormatNumber(v33);
    FastTween(YesFill, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(v35, 1)
    });
    FastTween(Pointer, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(v35, 0.5)
    });
end;

local function RenderPoll(p36) -- Line: 292
    -- upvalues: u9 (ref), u10 (ref), PollingTypes (copy), u14 (ref), u13 (ref), SetOpen (copy), u6 (ref), u8 (copy), u12 (ref), u11 (ref), Title (copy), Value (copy), GetPollCountdownText (copy), u5 (copy), RenderResults (copy)
    if u9 == p36.Id then
        if u10 == PollingTypes.PollStatus.Closed or p36.Status ~= PollingTypes.PollStatus.Closed then
            u14 = u14 + 1;
            u13 = nil;
            SetOpen(false);

            return;
        end;

        u9 = nil;
        u10 = nil;
    end;

    u6 = p36;
    local v37 = u8[p36.Id] ~= nil;
    local v38;

    if p36.Status == PollingTypes.PollStatus.Active or p36.Status == PollingTypes.PollStatus.Closing then
        v38 = not v37;
    else
        v38 = false;
    end;

    local v39 = p36.Status == PollingTypes.PollStatus.Closed;

    if v39 then
        if u12 ~= p36.Id then
            u12 = p36.Id;
            u11 = os.time() + 0;
        end;
    else
        u11 = nil;
        u12 = nil;
    end;

    Title.Text = p36.Title;
    Value.Text = GetPollCountdownText(p36);
    local math_max_ret = math.max(p36.Votes[1] or 0, p36.Votes[2] or 0);

    for _, v in u5 do
        local v40 = p36.Options[v.OptionIndex];
        v.Answer.Text = v40.Label;

        if v40.Color then
            v.Button.BackgroundColor3 = v40.Color;
            v.Button.ImageColor3 = v40.Color;
            v.Claim.ImageColor3 = v40.Color;
            v.Inlet.ImageColor3 = v40.Color;
            v.Fill.BackgroundColor3 = v40.Color;
            local Stroke = v.Stroke;

            if Stroke then
                Stroke.Color = v40.Color:Lerp(Color3.new(0, 0, 0), 0.7);
            end;
        end;

        v.Button.Visible = true;
        local Button = v.Button;
        Button.Active = v38;
        Button.AutoButtonColor = v38;
        Button.Interactable = v38;
        local OptionIndex = v.OptionIndex;
        local v41 = u8[p36.Id];
        local v42;

        if v41 == nil then
            v42 = false;
        else
            v42 = table.find(v41, OptionIndex) ~= nil;
        end;

        local v43;

        if v39 then
            if math_max_ret > 0 then
                v43 = (p36.Votes[v.OptionIndex] or 0) == math_max_ret;
            else
                v43 = false;
            end;
        else
            v43 = v39;
        end;

        v.Claim.Visible = not (v39 or v37) or (v42 or v43);
    end;

    RenderResults(p36);
    SetOpen(true);

    if u13 then
        return;
    end;

    u14 = u14 + 1;
    local u44 = u14;
    u13 = task.spawn(function() -- Line: 246
        -- upvalues: u14 (ref), u44 (copy), u6 (ref), Value (ref), GetPollCountdownText (ref), PollingTypes (ref), u11 (ref), u9 (ref), u10 (ref), u12 (ref), u13 (ref), SetOpen (ref)
        while true do
            local v45 = u14 == u44 and u6;

            if not v45 then
                break;
            end;

            Value.Text = GetPollCountdownText(v45);

            if v45.Status == PollingTypes.PollStatus.Closed and (u11 and u11 <= os.time()) then
                u9 = v45.Id;
                u10 = v45.Status;
                u6 = nil;
                u11 = nil;
                u12 = nil;
                u14 = u14 + 1;
                u13 = nil;
                SetOpen(false);
                break;
            end;

            task.wait(1);
        end;

        if u14 == u44 then
            u13 = nil;
        end;
    end);
end;

local function HidePoll() -- Line: 350
    -- upvalues: u6 (ref), u11 (ref), u12 (ref), u14 (ref), u13 (ref), SetOpen (copy)
    u6 = nil;
    u11 = nil;
    u12 = nil;
    u14 = u14 + 1;
    u13 = nil;
    SetOpen(false);
end;

function u1.OnPollsUpdated(p46, p47, p48, p49) -- Line: 358
    -- upvalues: IsGlobalCommandAuthorized (copy), LocalPlayer (copy), u6 (ref), u11 (ref), u12 (ref), u14 (ref), u13 (ref), SetOpen (copy), RenderPoll (copy)
    local v50 = p48 or p49;

    if v50 or not p47 then
        p47 = v50;
    elseif not IsGlobalCommandAuthorized(LocalPlayer) then
        p47 = v50;
    end;

    if p47 then
        RenderPoll(p47);

        return;
    end;

    u6 = nil;
    u11 = nil;
    u12 = nil;
    u14 = u14 + 1;
    u13 = nil;
    SetOpen(false);
end;

local function Vote(p51: number) -- Line: 373
    -- upvalues: u6 (ref), PollingTypes (copy), u8 (copy), u7 (ref), PollingService (copy), RenderPoll (copy)
    local v52 = u6;

    if not v52 then
        return;
    end;

    if v52.Status ~= PollingTypes.PollStatus.Active and v52.Status ~= PollingTypes.PollStatus.Closing then
        return;
    end;

    if u8[v52.Id] ~= nil then
        return;
    end;

    if u7 then
        for _, v in u7 do
            v:Cancel();
        end;

        table.clear(u7);
    end;

    u7 = nil;
    local table_create_ret = table.create(#v52.Options, 0);
    table_create_ret[p51] = 1;
    u8[v52.Id] = { p51 };
    PollingService.Vote:FireServer(table_create_ret);
    RenderPoll(v52);
end;

local function InitUI() -- Line: 398
    -- upvalues: Frame (copy), Poll_UI (copy), Teleport_UI (copy), SyncPollVisibility (copy), Close (copy), u6 (ref), u9 (ref), u10 (ref), u14 (ref), u13 (ref), SetOpen (copy), Yes (copy), Vote (copy), No (copy)
    Frame.Visible = false;
    Poll_UI.Enabled = true;
    Teleport_UI:GetPropertyChangedSignal("Enabled"):Connect(SyncPollVisibility);
    Close.Activated:Connect(function() -- Line: 403
        -- upvalues: u6 (ref), u9 (ref), u10 (ref), u14 (ref), u13 (ref), SetOpen (ref)
        local v53 = u6;

        if v53 then
            u9 = v53.Id;
            u10 = v53.Status;
        end;

        u14 = u14 + 1;
        u13 = nil;
        SetOpen(false);
    end);
    Yes.Activated:Connect(function() -- Line: 414
        -- upvalues: Vote (ref)
        Vote(1);
    end);
    No.Activated:Connect(function() -- Line: 418
        -- upvalues: Vote (ref)
        Vote(2);
    end);
end;

function u1.Start(p54) -- Line: 423
    -- upvalues: InitUI (copy), SetupRemotes (copy), PollingController (copy), u1 (copy)
    InitUI();
    SetupRemotes(PollingController, u1);
end;

task.spawn(u1.Start, u1);

return u1;