-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local SocialService = game:GetService("SocialService");
local LocalPlayer = Players.LocalPlayer;
local TeamEventPartyInvite_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TeamEventPartyInvite_UI");
local TeamInvites_HarvestMoon = TeamEventPartyInvite_UI.TeamInvites_HarvestMoon;
local Size = TeamInvites_HarvestMoon.Size;
local Close = TeamInvites_HarvestMoon.Header.Close;
local Search = TeamInvites_HarvestMoon.Main.Search;
local TextBox = Search.Bar.TextBox;
local ScrollingFrame = Search.ScrollingFrame;
local PlayerTemplate = ScrollingFrame.PlayerTemplate;
local Field_Of_View_Module = require(ReplicatedStorage.Field_Of_View_Module);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local Spring = require(ReplicatedStorage.Modules.Spring);
local TeamEventController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventController);
local TeamEventPartyController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventPartyController);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.UpdateService);
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local Members = TeamInvites_HarvestMoon.Main.TeamMembers.Members;
local MemberTemplate = Members:WaitForChild("MemberTemplate");
MemberTemplate.Visible = false;
local u1 = {};
local u2 = {
    State = {
        Visible = false,
        SearchQuery = "",
        PoolSize = 0,
        ItemHeight = 0,
        ListPadding = 0,
        PlayerList = {},
        FilteredList = {},
        Pool = {},
        SpawnedMembers = {}
    }
};

local function LoadThumbnail(u3: number, u4: function) -- Line: 68
    -- upvalues: u1 (copy), Players (copy), HeadShot (copy), Size100x100 (copy)
    if u1[u3] then
        u4(u1[u3]);

        return;
    end;

    task.spawn(function() -- Line: 74
        -- upvalues: Players (ref), u3 (copy), HeadShot (ref), Size100x100 (ref), u1 (ref), u4 (copy)
        local success, result = pcall(function() -- Line: 75
            -- upvalues: Players (ref), u3 (ref), HeadShot (ref), Size100x100 (ref)
            return Players:GetUserThumbnailAsync(u3, HeadShot, Size100x100);
        end);

        if success and result then
            u1[u3] = result;
            u4(result);
        end;
    end);
end;

local function FetchPlayerList() -- Line: 86
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v5 = {};
    local v6 = {};

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            table.insert(v5, {
                InServer = true,
                UserId = v.UserId,
                DisplayName = v.DisplayName,
                Username = v.Name
            });
            v6[v.UserId] = true;
        end;
    end;

    local success, result = pcall(function() -- Line: 104
        -- upvalues: Players (ref), LocalPlayer (ref)
        return Players:GetFriendsAsync(LocalPlayer.UserId);
    end);

    if success then
        repeat
            for _, v in result:GetCurrentPage() do
                if not v6[v.Id] then
                    table.insert(v5, {
                        InServer = false,
                        UserId = v.Id,
                        DisplayName = v.DisplayName,
                        Username = v.Username
                    });
                    v6[v.Id] = true;
                end;
            end;
        until result.IsFinished or not pcall(function() -- Line: 128
            -- upvalues: result (copy)
            result:AdvanceToNextPageAsync();
        end);
    end;

    table.sort(v5, function(p7, p8) -- Line: 138
        if p7.InServer == p8.InServer then
            return p7.DisplayName < p8.DisplayName;
        end;

        return p7.InServer;
    end);

    return v5;
end;

local function FilterPlayerList(p9: any, p10: string) -- Line: 148
    if p10 == "" then
        return p9;
    end;

    local v11 = p10:lower();
    local v12 = {};

    for _, v in p9 do
        if v.DisplayName:lower():find(v11, 1, true) or v.Username:lower():find(v11, 1, true) then
            table.insert(v12, v);
        end;
    end;

    return v12;
end;

local function FindAddText(p13) -- Line: 168
    local Add = p13:FindFirstChild("Add");

    if Add then
        Add = Add:FindFirstChild("ActualAddButton");
    end;

    if Add then
        Add = Add:FindFirstChild("Text");
    end;

    if Add and Add:IsA("TextLabel") then
        return Add;
    end;

    return nil;
end;

local function FindNativeInviteText(p14) -- Line: 176
    local NativeInvite = p14:FindFirstChild("NativeInvite");

    if NativeInvite then
        NativeInvite = NativeInvite:FindFirstChild("ActualInviteButton");
    end;

    if NativeInvite then
        NativeInvite = NativeInvite:FindFirstChild("Text");
    end;

    if NativeInvite and NativeInvite:IsA("TextLabel") then
        return NativeInvite;
    end;

    return nil;
end;

local function RefreshInviteState(p15: any, p16: number) -- Line: 184
    -- upvalues: TeamEventPartyController (copy)
    local Add = p15:FindFirstChild("Add");

    if Add then
        Add = Add:FindFirstChild("ActualAddButton");
    end;

    if Add then
        Add = Add:FindFirstChild("Text");
    end;

    if not (Add and Add:IsA("TextLabel")) then
        Add = nil;
    end;

    if not Add then
        return;
    end;

    Add.Text = TeamEventPartyController:HasOutboundInvite("HarvestMoon", p16) and "✓" or "+";
end;

local function UpdatePoolFrame(u17, u18) -- Line: 191
    -- upvalues: TeamEventPartyController (copy), TweenService (copy), u1 (copy), Players (copy), HeadShot (copy), Size100x100 (copy)
    local UserId = u18.UserId;
    local Add = u17:FindFirstChild("Add");

    if Add then
        Add = Add:FindFirstChild("ActualAddButton");
    end;

    if Add then
        Add = Add:FindFirstChild("Text");
    end;

    if not (Add and Add:IsA("TextLabel")) then
        Add = nil;
    end;

    if Add then
        Add.Text = TeamEventPartyController:HasOutboundInvite("HarvestMoon", UserId) and "✓" or "+";
    end;

    u17.NativeInvite.Visible = not u18.InServer;
    u17.Add.Visible = u18.InServer;

    if u17:GetAttribute("CurrentUserId") == u18.UserId then
        return;
    end;

    u17:SetAttribute("CurrentUserId", u18.UserId);
    local PlayerName = u17.PlayerName;
    PlayerName.Text = u18.DisplayName;
    PlayerName.TextTransparency = 1;
    TweenService:Create(PlayerName, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play();
    local v19 = PlayerName:FindFirstChildWhichIsA("UIStroke");

    if v19 then
        v19.Transparency = 1;
        TweenService:Create(v19, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
    end;

    local ImageLabel = u17.PlayerImage.ImageLabel;
    local v20 = u1[u18.UserId];

    if v20 then
        ImageLabel.Image = v20;
        ImageLabel.ImageTransparency = 1;
        TweenService:Create(ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();

        return;
    end;

    ImageLabel.Image = "";
    ImageLabel.ImageTransparency = 1;
    local UserId2 = u18.UserId;

    local function u22(p21) -- Line: 238
        -- upvalues: u17 (copy), u18 (copy), ImageLabel (copy), TweenService (ref)
        if u17:GetAttribute("CurrentUserId") == u18.UserId then
            ImageLabel.Image = p21;
            TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
        end;
    end;

    if u1[UserId2] then
        u22(u1[UserId2]);

        return;
    end;

    task.spawn(function() -- Line: 74
        -- upvalues: Players (ref), UserId2 (copy), HeadShot (ref), Size100x100 (ref), u1 (ref), u22 (copy)
        local success, result = pcall(function() -- Line: 75
            -- upvalues: Players (ref), UserId2 (ref), HeadShot (ref), Size100x100 (ref)
            return Players:GetUserThumbnailAsync(UserId2, HeadShot, Size100x100);
        end);

        if success and result then
            u1[UserId2] = result;
            u22(result);
        end;
    end);
end;

function u2.Render(p23) -- Line: 251
    -- upvalues: u2 (copy), FilterPlayerList (copy), ScrollingFrame (copy), UpdatePoolFrame (copy)
    local State = u2.State;
    State.FilteredList = FilterPlayerList(State.PlayerList, State.SearchQuery);
    local FilteredList = State.FilteredList;
    local v24 = #FilteredList;
    local ItemHeight = State.ItemHeight;
    local ListPadding = State.ListPadding;

    if ItemHeight <= 0 then
        return;
    end;

    local v25 = ItemHeight + ListPadding;
    local v26 = v24 <= 0 and 0 or v24 * ItemHeight + (v24 - 1) * ListPadding;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, v26);
    local Y = ScrollingFrame.AbsoluteSize.Y;
    local math_max_ret = math.max(0, v26 - Y);

    if math_max_ret < ScrollingFrame.CanvasPosition.Y then
        ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X, math_max_ret);
    end;

    local Y2 = ScrollingFrame.CanvasPosition.Y;
    local v27 = math.floor(Y2 / v25) + 1 - 2;
    local math_max_ret2 = math.max(1, v27);
    local v28 = math.ceil((Y2 + Y) / v25) + 2;
    local math_min_ret = math.min(v24, v28);

    for _, v in State.Pool do
        v.Visible = false;
    end;

    for i = math_max_ret2, math_min_ret do
        local v29 = FilteredList[i];
        local v30;

        if v29 then
            local v31 = State.Pool[(i - 1) % State.PoolSize + 1];
            v31.Visible = true;
            v31.Position = UDim2.new(0.5, 0, 0, (i - 1) * v25);
            UpdatePoolFrame(v31, v29);
            v30 = i;
        else
            v30 = i;
        end;
    end;
end;

local function FindPlayerData(p32: number) -- Line: 306
    -- upvalues: u2 (copy)
    for _, v in u2.State.PlayerList do
        if v.UserId == p32 then
            return v;
        end;
    end;

    return nil;
end;

local function HandleNativeInviteClick(p33) -- Line: 313
    -- upvalues: SocialService (copy), LocalPlayer (copy)
    if not p33:GetAttribute("CurrentUserId") then
        return;
    end;

    local Attribute = p33:GetAttribute("CurrentUserId");

    if not Attribute then
        return;
    end;

    local u34 = false;
    pcall(function() -- Line: 321
        -- upvalues: u34 (ref), SocialService (ref), LocalPlayer (ref)
        u34 = SocialService:CanSendGameInviteAsync(LocalPlayer);
    end);

    if u34 then
        local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
        ExperienceInviteOptions.InviteUser = Attribute;
        pcall(function() -- Line: 327
            -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
            SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
        end);
    end;
end;

local function HandleAddClick(p35) -- Line: 333
    -- upvalues: TeamEventPartyController (copy), Notification (copy), u2 (copy), SocialService (copy), LocalPlayer (copy)
    local Attribute = p35:GetAttribute("CurrentUserId");

    if not Attribute then
        return;
    end;

    if not TeamEventPartyController:CanInvite("HarvestMoon") then
        Notification:CreateNotification("Only the party leader can send invites.");

        return;
    end;

    local v36 = nil;

    for _, v in u2.State.PlayerList do
        if v.UserId == Attribute then
            v36 = v;
            break;
        end;
    end;

    if v36 and not v36.InServer then
        local u37 = false;
        pcall(function() -- Line: 349
            -- upvalues: u37 (ref), SocialService (ref), LocalPlayer (ref)
            u37 = SocialService:CanSendGameInviteAsync(LocalPlayer);
        end);

        if u37 then
            local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
            ExperienceInviteOptions.InviteUser = Attribute;
            pcall(function() -- Line: 355
                -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
                SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
            end);
        end;

        return;
    end;

    local Add = p35:FindFirstChild("Add");
    local v38 = Add and Add:FindFirstChild("ActualAddButton");

    if v38 then
        v38 = v38:FindFirstChild("Text");
    end;

    if not (v38 and v38:IsA("TextLabel")) then
        v38 = nil;
    end;

    if v38 then
        v38.Text = "✓";
    end;

    TeamEventPartyController:Invite("HarvestMoon", Attribute);
end;

function u2.RenderMembers(p39) -- Line: 368
    -- upvalues: u2 (copy), TeamEventPartyController (copy), LocalPlayer (copy), MemberTemplate (copy), Members (copy), Players (copy), TeamInvites_HarvestMoon (copy)
    local State = u2.State;
    local TeamData = TeamEventPartyController:GetTeamData("HarvestMoon");
    local v40 = TeamData and TeamData.members or {
        [LocalPlayer.UserId] = 0
    };
    local v41 = TeamData and (TeamData.metadata and TeamData.metadata.captain) or LocalPlayer.UserId;

    for i, v in State.SpawnedMembers do
        if v40[i] == nil then
            v:Destroy();
            State.SpawnedMembers[i] = nil;
        end;
    end;

    local v42 = 0;

    for i in v40 do
        v42 = v42 + 1;
        local u43 = State.SpawnedMembers[i];

        if not u43 then
            u43 = MemberTemplate:Clone();
            u43.Name = `Member_{i}`;
            u43.Visible = true;
            u43.Parent = Members;
            State.SpawnedMembers[i] = u43;
            local PlayerHeadshot = u43:FindFirstChild("PlayerHeadshot");

            if PlayerHeadshot then
                PlayerHeadshot.Image = `rbxthumb://type=AvatarHeadShot&id={i}&w=180&h=180`;
            end;

            local MemberName = u43:FindFirstChild("MemberName");

            if MemberName then
                local PlayerByUserId = Players:GetPlayerByUserId(i);

                if PlayerByUserId then
                    MemberName.Text = PlayerByUserId.DisplayName;
                else
                    MemberName.Text = "...";
                    task.spawn(function() -- Line: 405
                        -- upvalues: Players (ref), i (copy), u43 (ref), MemberName (copy)
                        local success, result = pcall(function() -- Line: 406
                            -- upvalues: Players (ref), i (ref)
                            return Players:GetNameFromUserIdAsync(i);
                        end);

                        if success and u43.Parent then
                            MemberName.Text = result;
                        end;
                    end);
                end;
            end;
        end;

        local v44 = i == v41;
        u43.LayoutOrder = v44 and 0 or 1;
        local Leader = u43:FindFirstChild("Leader");

        if Leader then
            Leader.Visible = v44;
        end;
    end;

    TeamInvites_HarvestMoon.Main.TeamMembers.LeaveTeam.Visible = v42 > 1;
end;

function u2.Toggle(p45: table, p46: boolean?) -- Line: 427
    -- upvalues: u2 (copy), TeamEventPartyInvite_UI (copy), TeamInvites_HarvestMoon (copy), Field_Of_View_Module (copy), Blur_Module (copy), TweenService (copy), Size (copy)
    local State = u2.State;

    if p46 == nil then
        p46 = not State.Visible;
    end;

    State.Visible = p46;

    if not State.Visible then
        TeamInvites_HarvestMoon.Visible = false;
        Field_Of_View_Module.Change_FOV(70);
        Blur_Module.Blur(0, 0.1);

        return;
    end;

    TeamEventPartyInvite_UI.Enabled = true;
    local TeamInvites = TeamEventPartyInvite_UI:FindFirstChild("TeamInvites");

    if TeamInvites then
        TeamInvites.Visible = false;
    end;

    TeamInvites_HarvestMoon.Visible = true;
    Field_Of_View_Module.Change_FOV(60);
    Blur_Module.Blur(15, 0.1);
    TeamInvites_HarvestMoon.Size = UDim2.fromScale(0, 0);
    TweenService:Create(TeamInvites_HarvestMoon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Size
    }):Play();
    u2:RenderMembers();
    u2:Render();
end;

function u2.Start(p47) -- Line: 452
    -- upvalues: u2 (copy), SetupButton (copy), Close (copy), TeamInvites_HarvestMoon (copy), ReplicatedStorage (copy), ScrollingFrame (copy), PlayerTemplate (copy), Spring (copy), HandleAddClick (copy), HandleNativeInviteClick (copy), TeamEventPartyController (copy), TeamEventController (copy), TextBox (copy), FetchPlayerList (copy), Players (copy)
    local State = u2.State;
    SetupButton({
        legacy = true,
        instance = Close,

        onclick = function() -- Line: 458, Name: onclick
            -- upvalues: u2 (ref)
            u2:Toggle(false);
        end
    });
    local ViewRewardsButton = TeamInvites_HarvestMoon.Header:FindFirstChild("ViewRewardsButton");

    if ViewRewardsButton then
        SetupButton({
            legacy = true,
            instance = ViewRewardsButton,

            onclick = function() -- Line: 468, Name: onclick
                -- upvalues: u2 (ref), ReplicatedStorage (ref)
                u2:Toggle(false);
                local HarvestMoonRewardsUIController = require(ReplicatedStorage.Modules.TeamEventControllers.UserInterface.HarvestMoonRewardsUIController);
                HarvestMoonRewardsUIController.State.SelectedEvent = "HarvestMoon";
                HarvestMoonRewardsUIController:Toggle(true);
            end
        });
    end;

    TeamInvites_HarvestMoon.Visible = false;
    task.wait();
    local v48 = ScrollingFrame:FindFirstChildWhichIsA("UIListLayout");
    local u49, u50;

    if v48 then
        u49 = v48.Padding.Scale;
        u50 = v48.Padding.Offset;
        v48:Destroy();
    else
        u49 = 0;
        u50 = 0;
    end;

    local v51 = ScrollingFrame:FindFirstChildWhichIsA("UIPadding");

    if v51 then
        v51:Destroy();
    end;

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = false;
        end;
    end;

    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None;
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;

    local function CreatePoolFrame(p52: number) -- Line: 509
        -- upvalues: PlayerTemplate (ref), ScrollingFrame (ref), State (copy), Spring (ref), HandleAddClick (ref), HandleNativeInviteClick (ref)
        local u53 = PlayerTemplate:Clone();
        u53.Name = `PoolFrame_{p52}`;
        u53.AnchorPoint = Vector2.new(0.5, 0);
        u53.Visible = false;
        u53.Parent = ScrollingFrame;
        State.Pool[p52] = u53;
        local ActualAddButton = u53.Add.ActualAddButton;
        local u54 = ActualAddButton:FindFirstChildWhichIsA("UIScale");
        local SENSOR = ActualAddButton:FindFirstChild("SENSOR");
        SENSOR.MouseEnter:Connect(function() -- Line: 523
            -- upvalues: Spring (ref), u54 (copy)
            Spring.target(u54, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR.MouseLeave:Connect(function() -- Line: 527
            -- upvalues: Spring (ref), u54 (copy)
            Spring.target(u54, 1, 10, {
                Scale = 1
            });
        end);
        SENSOR.MouseButton1Down:Connect(function() -- Line: 531
            -- upvalues: Spring (ref), u54 (copy)
            Spring.target(u54, 1, 10, {
                Scale = 0.935
            });
        end);
        SENSOR.MouseButton1Up:Connect(function() -- Line: 535
            -- upvalues: Spring (ref), u54 (copy)
            Spring.target(u54, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR.Activated:Connect(function() -- Line: 539
            -- upvalues: HandleAddClick (ref), u53 (copy)
            HandleAddClick(u53);
        end);
        local ActualInviteButton = u53.NativeInvite.ActualInviteButton;
        local u55 = ActualInviteButton:FindFirstChildWhichIsA("UIScale");
        local SENSOR2 = ActualInviteButton:FindFirstChild("SENSOR");
        SENSOR2.MouseEnter:Connect(function() -- Line: 548
            -- upvalues: Spring (ref), u55 (copy)
            Spring.target(u55, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR2.MouseLeave:Connect(function() -- Line: 552
            -- upvalues: Spring (ref), u55 (copy)
            Spring.target(u55, 1, 10, {
                Scale = 1
            });
        end);
        SENSOR2.MouseButton1Down:Connect(function() -- Line: 556
            -- upvalues: Spring (ref), u55 (copy)
            Spring.target(u55, 1, 10, {
                Scale = 0.935
            });
        end);
        SENSOR2.MouseButton1Up:Connect(function() -- Line: 560
            -- upvalues: Spring (ref), u55 (copy)
            Spring.target(u55, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR2.Activated:Connect(function() -- Line: 564
            -- upvalues: HandleNativeInviteClick (ref), u53 (copy)
            HandleNativeInviteClick(u53);
        end);
    end;

    local function RecomputeRowMetrics() -- Line: 573
        -- upvalues: ScrollingFrame (ref), PlayerTemplate (ref), State (copy), u49 (ref), u50 (ref), CreatePoolFrame (copy)
        local Y = ScrollingFrame.AbsoluteSize.Y;
        local Y2 = PlayerTemplate.AbsoluteSize.Y;

        if Y <= 0 or Y2 <= 0 then
            return;
        end;

        State.ItemHeight = Y2;
        State.ListPadding = Y * u49 + u50;
        local v56 = math.ceil(Y / (State.ItemHeight + State.ListPadding)) + 4;

        for i = #State.Pool + 1, v56 do
            CreatePoolFrame(i);
            local _ = i;
        end;

        State.PoolSize = #State.Pool;
    end;

    RecomputeRowMetrics();
    ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 593
        -- upvalues: RecomputeRowMetrics (copy), u2 (ref)
        RecomputeRowMetrics();
        u2:Render();
    end);
    TeamInvites_HarvestMoon.Main.TeamMembers.LeaveTeam.ImageButton.Activated:Connect(function() -- Line: 600
        -- upvalues: TeamEventPartyController (ref)
        TeamEventPartyController:LeaveParty("HarvestMoon");
    end);
    TeamEventPartyController.OutboundChanged:Connect(function() -- Line: 605
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    TeamEventController.DataUpdated:Connect(function() -- Line: 608
        -- upvalues: u2 (ref)
        u2:RenderMembers();
        u2:Render();
    end);
    u2:RenderMembers();
    ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 615
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 619
        -- upvalues: State (copy), TextBox (ref), ScrollingFrame (ref), u2 (ref)
        State.SearchQuery = TextBox.Text;
        ScrollingFrame.CanvasPosition = Vector2.new(0, 0);
        u2:Render();
    end);
    local u57 = 0;

    local function RefreshPlayerList() -- Line: 630
        -- upvalues: u57 (ref), FetchPlayerList (ref), State (copy), u2 (ref)
        u57 = u57 + 1;
        local u58 = u57;
        task.spawn(function() -- Line: 633
            -- upvalues: FetchPlayerList (ref), u58 (copy), u57 (ref), State (ref), u2 (ref)
            local v59 = FetchPlayerList();

            if u58 ~= u57 then
                return;
            end;

            State.PlayerList = v59;
            u2:Render();
        end);
    end;

    u57 = u57 + 1;
    local u60 = u57;
    task.spawn(function() -- Line: 633
        -- upvalues: FetchPlayerList (ref), u60 (copy), u57 (ref), State (copy), u2 (ref)
        local v61 = FetchPlayerList();

        if u60 ~= u57 then
            return;
        end;

        State.PlayerList = v61;
        u2:Render();
    end);
    Players.PlayerAdded:Connect(RefreshPlayerList);
    Players.PlayerRemoving:Connect(RefreshPlayerList);
end;

task.spawn(function() -- Line: 648
    -- upvalues: u2 (copy)
    u2:Start();
end);

return u2;