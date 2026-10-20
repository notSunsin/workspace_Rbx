-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local SocialService = game:GetService("SocialService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local TeamEventPartyInvite_UI = PlayerGui:WaitForChild("TeamEventPartyInvite_UI");
local Gift_Notification = PlayerGui:WaitForChild("Gift_Notification");
local TeamInvites = TeamEventPartyInvite_UI.TeamInvites;
local Size = TeamInvites.Size;
local Close = TeamInvites.Header.Close;
local Search = TeamInvites.Main.Search;
local TextBox = Search.Bar.TextBox;
local ScrollingFrame = Search.ScrollingFrame;
local PlayerTemplate = ScrollingFrame.PlayerTemplate;
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Field_Of_View_Module = require(ReplicatedStorage.Field_Of_View_Module);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local Spring = require(ReplicatedStorage.Modules.Spring);
local TeamEventController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventController);
local TeamEventPartyController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventPartyController);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local TeamEventHelper = require(ReplicatedStorage.Modules.TeamEventHelper);
require(ReplicatedStorage.Modules.UpdateService);
local StateForGui = GuiController:GetStateForGui(TeamEventPartyInvite_UI);
StateForGui.ChangeEnabled:Set(true);
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local u1 = "SummerHarvest";
local Members = TeamInvites.Main.TeamMembers.Members;
local MemberTemplate = Members:WaitForChild("MemberTemplate");
MemberTemplate.Visible = false;
local PartyInvite = script:WaitForChild("PartyInvite");

local function GetConfirmationMiddleLabel() -- Line: 66
    -- upvalues: LocalPlayer (copy)
    local GenericConfirmationPrompt = LocalPlayer.PlayerGui:FindFirstChild("GenericConfirmationPrompt");

    if GenericConfirmationPrompt then
        GenericConfirmationPrompt = GenericConfirmationPrompt:FindFirstChild("Main");
    end;

    if GenericConfirmationPrompt then
        GenericConfirmationPrompt = GenericConfirmationPrompt:FindFirstChild("MiddleText");
    end;

    if GenericConfirmationPrompt and GenericConfirmationPrompt:IsA("TextLabel") then
        return GenericConfirmationPrompt;
    end;

    return nil;
end;

local u2 = {};
local u3 = {
    State = {
        Visible = false,
        SearchQuery = "",
        PoolSize = 0,
        ItemHeight = 0,
        ListPadding = 0,
        ActivePopup = nil,
        PlayerList = {},
        FilteredList = {},
        Pool = {},
        SpawnedMembers = {},
        InviteQueue = {}
    }
};

local function LoadThumbnail(u4: number, u5: function) -- Line: 96
    -- upvalues: u2 (copy), Players (copy), HeadShot (copy), Size100x100 (copy)
    if u2[u4] then
        u5(u2[u4]);

        return;
    end;

    task.spawn(function() -- Line: 102
        -- upvalues: Players (ref), u4 (copy), HeadShot (ref), Size100x100 (ref), u2 (ref), u5 (copy)
        local success, result = pcall(function() -- Line: 103
            -- upvalues: Players (ref), u4 (ref), HeadShot (ref), Size100x100 (ref)
            return Players:GetUserThumbnailAsync(u4, HeadShot, Size100x100);
        end);

        if success and result then
            u2[u4] = result;
            u5(result);
        end;
    end);
end;

local function FetchPlayerList() -- Line: 114
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v6 = {};
    local v7 = {};

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            table.insert(v6, {
                InServer = true,
                UserId = v.UserId,
                DisplayName = v.DisplayName,
                Username = v.Name
            });
            v7[v.UserId] = true;
        end;
    end;

    local success, result = pcall(function() -- Line: 132
        -- upvalues: Players (ref), LocalPlayer (ref)
        return Players:GetFriendsAsync(LocalPlayer.UserId);
    end);

    if success then
        repeat
            for _, v in result:GetCurrentPage() do
                if not v7[v.Id] then
                    table.insert(v6, {
                        InServer = false,
                        UserId = v.Id,
                        DisplayName = v.DisplayName,
                        Username = v.Username
                    });
                    v7[v.Id] = true;
                end;
            end;
        until result.IsFinished or not pcall(function() -- Line: 156
            -- upvalues: result (copy)
            result:AdvanceToNextPageAsync();
        end);
    end;

    table.sort(v6, function(p8, p9) -- Line: 166
        if p8.InServer == p9.InServer then
            return p8.DisplayName < p9.DisplayName;
        end;

        return p8.InServer;
    end);

    return v6;
end;

local function FilterPlayerList(p10: any, p11: string) -- Line: 176
    if p11 == "" then
        return p10;
    end;

    local v12 = p11:lower();
    local v13 = {};

    for _, v in p10 do
        if v.DisplayName:lower():find(v12, 1, true) or v.Username:lower():find(v12, 1, true) then
            table.insert(v13, v);
        end;
    end;

    return v13;
end;

local function FindAddText(p14) -- Line: 196
    local Add = p14:FindFirstChild("Add");

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

local function FindNativeInviteText(p15) -- Line: 204
    local NativeInvite = p15:FindFirstChild("NativeInvite");

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

local function RefreshInviteState(p16: any, p17: number) -- Line: 212
    -- upvalues: TeamEventPartyController (copy), u1 (ref)
    local Add = p16:FindFirstChild("Add");

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

    Add.Text = TeamEventPartyController:HasOutboundInvite(u1, p17) and "✓" or "+";
end;

local function UpdatePoolFrame(u18, u19) -- Line: 219
    -- upvalues: TeamEventPartyController (copy), u1 (ref), TweenService (copy), u2 (copy), Players (copy), HeadShot (copy), Size100x100 (copy)
    local UserId = u19.UserId;
    local Add = u18:FindFirstChild("Add");

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
        Add.Text = TeamEventPartyController:HasOutboundInvite(u1, UserId) and "✓" or "+";
    end;

    u18.NativeInvite.Visible = not u19.InServer;
    u18.Add.Visible = u19.InServer;

    if u18:GetAttribute("CurrentUserId") == u19.UserId then
        return;
    end;

    u18:SetAttribute("CurrentUserId", u19.UserId);
    local PlayerName = u18.PlayerName;
    PlayerName.Text = u19.DisplayName;
    PlayerName.TextTransparency = 1;
    TweenService:Create(PlayerName, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play();
    local v20 = PlayerName:FindFirstChildWhichIsA("UIStroke");

    if v20 then
        v20.Transparency = 1;
        TweenService:Create(v20, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
    end;

    local ImageLabel = u18.PlayerImage.ImageLabel;
    local v21 = u2[u19.UserId];

    if v21 then
        ImageLabel.Image = v21;
        ImageLabel.ImageTransparency = 1;
        TweenService:Create(ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();

        return;
    end;

    ImageLabel.Image = "";
    ImageLabel.ImageTransparency = 1;
    local UserId2 = u19.UserId;

    local function u23(p22) -- Line: 266
        -- upvalues: u18 (copy), u19 (copy), ImageLabel (copy), TweenService (ref)
        if u18:GetAttribute("CurrentUserId") == u19.UserId then
            ImageLabel.Image = p22;
            TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
        end;
    end;

    if u2[UserId2] then
        u23(u2[UserId2]);

        return;
    end;

    task.spawn(function() -- Line: 102
        -- upvalues: Players (ref), UserId2 (copy), HeadShot (ref), Size100x100 (ref), u2 (ref), u23 (copy)
        local success, result = pcall(function() -- Line: 103
            -- upvalues: Players (ref), UserId2 (ref), HeadShot (ref), Size100x100 (ref)
            return Players:GetUserThumbnailAsync(UserId2, HeadShot, Size100x100);
        end);

        if success and result then
            u2[UserId2] = result;
            u23(result);
        end;
    end);
end;

function u3.Render(p24) -- Line: 279
    -- upvalues: u3 (copy), FilterPlayerList (copy), ScrollingFrame (copy), UpdatePoolFrame (copy)
    local State = u3.State;
    State.FilteredList = FilterPlayerList(State.PlayerList, State.SearchQuery);
    local FilteredList = State.FilteredList;
    local v25 = #FilteredList;
    local ItemHeight = State.ItemHeight;
    local ListPadding = State.ListPadding;

    if ItemHeight <= 0 then
        return;
    end;

    local v26 = ItemHeight + ListPadding;
    local v27 = v25 <= 0 and 0 or v25 * ItemHeight + (v25 - 1) * ListPadding;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, v27);
    local Y = ScrollingFrame.AbsoluteSize.Y;
    local math_max_ret = math.max(0, v27 - Y);

    if math_max_ret < ScrollingFrame.CanvasPosition.Y then
        ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X, math_max_ret);
    end;

    local Y2 = ScrollingFrame.CanvasPosition.Y;
    local v28 = math.floor(Y2 / v26) + 1 - 2;
    local math_max_ret2 = math.max(1, v28);
    local v29 = math.ceil((Y2 + Y) / v26) + 2;
    local math_min_ret = math.min(v25, v29);

    for _, v in State.Pool do
        v.Visible = false;
    end;

    for i = math_max_ret2, math_min_ret do
        local v30 = FilteredList[i];
        local v31;

        if v30 then
            local v32 = State.Pool[(i - 1) % State.PoolSize + 1];
            v32.Visible = true;
            v32.Position = UDim2.new(0.5, 0, 0, (i - 1) * v26);
            UpdatePoolFrame(v32, v30);
            v31 = i;
        else
            v31 = i;
        end;
    end;
end;

local function FindPlayerData(p33: number) -- Line: 334
    -- upvalues: u3 (copy)
    for _, v in u3.State.PlayerList do
        if v.UserId == p33 then
            return v;
        end;
    end;

    return nil;
end;

local function HandleNativeInviteClick(p34) -- Line: 341
    -- upvalues: SocialService (copy), LocalPlayer (copy)
    if not p34:GetAttribute("CurrentUserId") then
        return;
    end;

    local Attribute = p34:GetAttribute("CurrentUserId");

    if not Attribute then
        return;
    end;

    local u35 = false;
    pcall(function() -- Line: 349
        -- upvalues: u35 (ref), SocialService (ref), LocalPlayer (ref)
        u35 = SocialService:CanSendGameInviteAsync(LocalPlayer);
    end);

    if u35 then
        local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
        ExperienceInviteOptions.InviteUser = Attribute;
        pcall(function() -- Line: 355
            -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
            SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
        end);
    end;
end;

local function HandleAddClick(p36) -- Line: 361
    -- upvalues: TeamEventPartyController (copy), u1 (ref), Notification (copy), u3 (copy), SocialService (copy), LocalPlayer (copy)
    local Attribute = p36:GetAttribute("CurrentUserId");

    if not Attribute then
        return;
    end;

    if not TeamEventPartyController:CanInvite(u1) then
        Notification:CreateNotification("Only the party leader can send invites.");

        return;
    end;

    local v37 = nil;

    for _, v in u3.State.PlayerList do
        if v.UserId == Attribute then
            v37 = v;
            break;
        end;
    end;

    if v37 and not v37.InServer then
        local u38 = false;
        pcall(function() -- Line: 377
            -- upvalues: u38 (ref), SocialService (ref), LocalPlayer (ref)
            u38 = SocialService:CanSendGameInviteAsync(LocalPlayer);
        end);

        if u38 then
            local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
            ExperienceInviteOptions.InviteUser = Attribute;
            pcall(function() -- Line: 383
                -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
                SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
            end);
        end;

        return;
    end;

    local Add = p36:FindFirstChild("Add");
    local v39 = Add and Add:FindFirstChild("ActualAddButton");

    if v39 then
        v39 = v39:FindFirstChild("Text");
    end;

    if not (v39 and v39:IsA("TextLabel")) then
        v39 = nil;
    end;

    if v39 then
        v39.Text = "✓";
    end;

    TeamEventPartyController:Invite(u1, Attribute);
end;

function u3.RenderMembers(p40) -- Line: 396
    -- upvalues: u3 (copy), TeamEventPartyController (copy), u1 (ref), LocalPlayer (copy), MemberTemplate (copy), Members (copy), Players (copy), TeamEventPartyInvite_UI (copy)
    local State = u3.State;
    local TeamData = TeamEventPartyController:GetTeamData(u1);
    local v41 = TeamData and TeamData.members or {
        [LocalPlayer.UserId] = 0
    };
    local v42 = TeamData and (TeamData.metadata and TeamData.metadata.captain) or LocalPlayer.UserId;

    for i, v in State.SpawnedMembers do
        if v41[i] == nil then
            v:Destroy();
            State.SpawnedMembers[i] = nil;
        end;
    end;

    local v43 = 0;

    for i in v41 do
        v43 = v43 + 1;
        local u44 = State.SpawnedMembers[i];

        if not u44 then
            u44 = MemberTemplate:Clone();
            u44.Name = `Member_{i}`;
            u44.Visible = true;
            u44.Parent = Members;
            State.SpawnedMembers[i] = u44;
            local PlayerHeadshot = u44:FindFirstChild("PlayerHeadshot");

            if PlayerHeadshot then
                PlayerHeadshot.Image = `rbxthumb://type=AvatarHeadShot&id={i}&w=180&h=180`;
            end;

            local MemberName = u44:FindFirstChild("MemberName");

            if MemberName then
                local PlayerByUserId = Players:GetPlayerByUserId(i);

                if PlayerByUserId then
                    MemberName.Text = PlayerByUserId.DisplayName;
                else
                    MemberName.Text = "...";
                    task.spawn(function() -- Line: 433
                        -- upvalues: Players (ref), i (copy), u44 (ref), MemberName (copy)
                        local success, result = pcall(function() -- Line: 434
                            -- upvalues: Players (ref), i (ref)
                            return Players:GetNameFromUserIdAsync(i);
                        end);

                        if success and u44.Parent then
                            MemberName.Text = result;
                        end;
                    end);
                end;
            end;
        end;

        local v45 = i == v42;
        u44.LayoutOrder = v45 and 0 or 1;
        local Leader = u44:FindFirstChild("Leader");

        if Leader then
            Leader.Visible = v45;
        end;
    end;

    TeamEventPartyInvite_UI.TeamInvites.Main.TeamMembers.LeaveTeam.Visible = v43 > 1;
end;

local function AnimatePopupOut(p46: userdata) -- Line: 457
    -- upvalues: Spring (copy), Debris (copy)
    if not p46 or p46:HasTag("_fadingOut") then
        return;
    end;

    p46:AddTag("_fadingOut");
    local Canvas = p46.Wrapper.Canvas;
    Spring.target(p46.Wrapper.DropShadow, 1, 3, {
        ImageTransparency = 1
    });
    Spring.target(Canvas.UIStroke, 1, 3, {
        Transparency = 1
    });
    Spring.target(Canvas, 1, 3, {
        GroupTransparency = 1,
        Position = UDim2.fromScale(0.65, 0.5)
    });
    Debris:AddItem(p46, 1);
end;

local u47 = nil;

local function EnqueueInvite(p48: string, p49: number, p50: string, p51: number) -- Line: 472
    -- upvalues: u3 (copy), u47 (ref)
    local State = u3.State;

    if State.ActivePopup and (State.ActivePopup.inviterUid == p49 and State.ActivePopup.eventName == p48) then
        return;
    end;

    for _, v in State.InviteQueue do
        if v.inviterUid == p49 and v.eventName == p48 then
            return;
        end;
    end;

    table.insert(State.InviteQueue, {
        eventName = p48,
        inviterUid = p49,
        displayName = p50,
        expiresAt = p51
    });
    u47();
end;

u47 = function() -- Line: 486, Name: ShowNextInvite
    -- upvalues: u3 (copy), u47 (ref), PartyInvite (copy), TeamEventHelper (copy), TweenService (copy), Spring (copy), ConfirmationPromptController (copy), AnimatePopupOut (copy), SetupButton (copy), LocalPlayer (copy), TeamEventPartyController (copy), Gift_Notification (copy)
    local State = u3.State;

    if State.ActivePopup then
        return;
    end;

    local table_remove_ret = table.remove(State.InviteQueue, 1);

    if not table_remove_ret then
        return;
    end;

    local v52 = table_remove_ret.expiresAt - workspace:GetServerTimeNow();

    if v52 <= 0 then
        u47();

        return;
    end;

    local u53 = PartyInvite:Clone();
    local Canvas = u53.Wrapper.Canvas;
    local Main = Canvas.Segment.Main;
    local DropShadow = u53.Wrapper.DropShadow;
    local PLAYER_IMAGE = Main.Profile.Holder.PLAYER_IMAGE;
    local Timeout = Main.Timeout;
    Timeout.Size = UDim2.fromScale(0, 1);
    PLAYER_IMAGE.Image = `rbxthumb://type=AvatarHeadShot&id={table_remove_ret.inviterUid}&w=180&h=180`;
    Main.SENDER_NAME.Text = table_remove_ret.displayName;
    Main.SENDER_NAME_SHADOW.Text = table_remove_ret.displayName;
    local v54 = TeamEventHelper.Events[table_remove_ret.eventName];
    local v55 = `has invited you to join their {v54 and v54.DisplayName or "Event"} team!`;

    if Main:FindFirstChild("PromptText") then
        Main.PromptText.Text = v55;
    end;

    if Main:FindFirstChild("PromptTextShadow") then
        Main.PromptTextShadow.Text = v55;
    end;

    Canvas.GroupTransparency = 1;
    u53.Wrapper.Position = UDim2.fromScale(0.65, 0.5);
    Canvas.UIStroke.Transparency = 1;
    DropShadow.ImageTransparency = 1;
    Timeout.Size = UDim2.fromScale(1, 0.05);
    local BackgroundColor3 = Timeout.BackgroundColor3;
    TweenService:Create(Timeout, TweenInfo.new(v52, Enum.EasingStyle.Exponential), {
        BackgroundColor3 = BackgroundColor3:Lerp(Color3.new(1, 0, 0), 0.75),
        Size = UDim2.fromScale(0, 0.05)
    }):Play();
    Spring.target(DropShadow, 1, 3, {
        ImageTransparency = 0.6
    });
    Spring.target(Canvas.UIStroke, 1, 3, {
        Transparency = 0
    });
    Spring.target(Canvas, 1, 3, {
        GroupTransparency = 0
    });
    Spring.target(u53.Wrapper, 1, 3, {
        Position = UDim2.fromScale(0.5, 0.5)
    });
    local u56 = {
        popup = u53,
        eventName = table_remove_ret.eventName,
        inviterUid = table_remove_ret.inviterUid
    };
    State.ActivePopup = u56;
    local u57 = nil;

    local function dismiss() -- Line: 540
        -- upvalues: State (copy), u56 (copy), u57 (ref), ConfirmationPromptController (ref), AnimatePopupOut (ref), u53 (copy), u47 (ref)
        if State.ActivePopup ~= u56 then
            return;
        end;

        State.ActivePopup = nil;

        if u57 then
            pcall(task.cancel, u57);
            u57 = nil;
        end;

        ConfirmationPromptController:Close("Join Party");
        AnimatePopupOut(u53);
        task.delay(0.5, u47);
    end;

    u57 = task.delay(v52, dismiss);
    SetupButton({
        instance = Canvas.Segment.Buttons.ACCEPT_BUTTON.Main.SENSOR,

        onclick = function() -- Line: 556, Name: onclick
            -- upvalues: LocalPlayer (ref), ConfirmationPromptController (ref), table_remove_ret (copy), TeamEventPartyController (ref), dismiss (copy)
            local GenericConfirmationPrompt = LocalPlayer.PlayerGui:FindFirstChild("GenericConfirmationPrompt");

            if GenericConfirmationPrompt then
                GenericConfirmationPrompt = GenericConfirmationPrompt:FindFirstChild("Main");
            end;

            if GenericConfirmationPrompt then
                GenericConfirmationPrompt = GenericConfirmationPrompt:FindFirstChild("MiddleText");
            end;

            if not (GenericConfirmationPrompt and GenericConfirmationPrompt:IsA("TextLabel")) then
                GenericConfirmationPrompt = nil;
            end;

            if GenericConfirmationPrompt then
                GenericConfirmationPrompt.RichText = true;
            end;

            ConfirmationPromptController:Open({
                Title = "Join Party",
                Middle = "<font color=\"#ffff00\">Once you join, you can leave the party from the team menu.</font>",
                Footer = "Are you sure?",
                ConfirmText = "Join",
                RejectText = "Wait",
                Header = `Join {table_remove_ret.displayName}'s party`
            }, {
                ConfirmCallback = function() -- Line: 570, Name: ConfirmCallback
                    -- upvalues: TeamEventPartyController (ref), table_remove_ret (ref), dismiss (ref)
                    TeamEventPartyController:Accept(table_remove_ret.eventName, table_remove_ret.inviterUid);
                    dismiss();
                end
            });
        end
    });
    SetupButton({
        instance = Canvas.Segment.Buttons.DECLINE_BUTTON.Main.SENSOR,

        onclick = function() -- Line: 579, Name: onclick
            -- upvalues: ConfirmationPromptController (ref), TeamEventPartyController (ref), table_remove_ret (copy), dismiss (copy)
            ConfirmationPromptController:Close("Join Party");
            TeamEventPartyController:Decline(table_remove_ret.eventName, table_remove_ret.inviterUid);
            dismiss();
        end
    });
    u53.Parent = Gift_Notification.Frame;
end;

function u3.SetEvent(p58: table, p59: string) -- Line: 593
    -- upvalues: u1 (ref)
    u1 = p59;
end;

function u3.Toggle(p60: table, p61: boolean?) -- Line: 597
    -- upvalues: u3 (copy), GuiController (copy), TeamEventPartyInvite_UI (copy)
    if p61 == nil then
        p61 = not u3.State.Visible;
    end;

    u3.State.Visible = p61;

    if u3.State.Visible then
        GuiController:Open(TeamEventPartyInvite_UI);

        return;
    end;

    GuiController:Close(TeamEventPartyInvite_UI);
end;

function u3.Start(p62) -- Line: 609
    -- upvalues: u3 (copy), SetupButton (copy), Close (copy), TeamEventPartyInvite_UI (copy), TeamInvites (copy), StateForGui (copy), Field_Of_View_Module (copy), Blur_Module (copy), TweenService (copy), Size (copy), ScrollingFrame (copy), PlayerTemplate (copy), Spring (copy), HandleAddClick (copy), HandleNativeInviteClick (copy), TeamEventPartyController (copy), u1 (ref), TeamEventController (copy), EnqueueInvite (copy), TextBox (copy), FetchPlayerList (copy), Players (copy)
    local State = u3.State;
    SetupButton({
        legacy = true,
        instance = Close,

        onclick = function() -- Line: 615, Name: onclick
            -- upvalues: u3 (ref)
            u3:Toggle(false);
        end
    });
    TeamEventPartyInvite_UI.Enabled = true;
    TeamInvites.Visible = false;
    StateForGui.Visible:Observe(function(p63) -- Line: 625
        -- upvalues: Field_Of_View_Module (ref), Blur_Module (ref), TeamInvites (ref), TweenService (ref), Size (ref)
        Field_Of_View_Module.Change_FOV(p63 and 60 or 70);
        Blur_Module.Blur(p63 and 15 or 0, 0.1);

        if p63 then
            TeamInvites.Size = UDim2.fromScale(0, 0);
            TweenService:Create(TeamInvites, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = Size
            }):Play();
        end;

        TeamInvites.Visible = p63;
    end);
    task.wait();
    local v64 = ScrollingFrame:FindFirstChildWhichIsA("UIListLayout");
    local u65, u66;

    if v64 then
        u65 = v64.Padding.Scale;
        u66 = v64.Padding.Offset;
        v64:Destroy();
    else
        u66 = 0;
        u65 = 0;
    end;

    local v67 = ScrollingFrame:FindFirstChildWhichIsA("UIPadding");

    if v67 then
        v67:Destroy();
    end;

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = false;
        end;
    end;

    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None;
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;

    local function CreatePoolFrame(p68: number) -- Line: 669
        -- upvalues: PlayerTemplate (ref), ScrollingFrame (ref), State (copy), Spring (ref), HandleAddClick (ref), HandleNativeInviteClick (ref)
        local u69 = PlayerTemplate:Clone();
        u69.Name = `PoolFrame_{p68}`;
        u69.AnchorPoint = Vector2.new(0.5, 0);
        u69.Visible = false;
        u69.Parent = ScrollingFrame;
        State.Pool[p68] = u69;
        local ActualAddButton = u69.Add.ActualAddButton;
        local u70 = ActualAddButton:FindFirstChildWhichIsA("UIScale");
        local SENSOR = ActualAddButton:FindFirstChild("SENSOR");
        SENSOR.MouseEnter:Connect(function() -- Line: 683
            -- upvalues: Spring (ref), u70 (copy)
            Spring.target(u70, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR.MouseLeave:Connect(function() -- Line: 687
            -- upvalues: Spring (ref), u70 (copy)
            Spring.target(u70, 1, 10, {
                Scale = 1
            });
        end);
        SENSOR.MouseButton1Down:Connect(function() -- Line: 691
            -- upvalues: Spring (ref), u70 (copy)
            Spring.target(u70, 1, 10, {
                Scale = 0.935
            });
        end);
        SENSOR.MouseButton1Up:Connect(function() -- Line: 695
            -- upvalues: Spring (ref), u70 (copy)
            Spring.target(u70, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR.Activated:Connect(function() -- Line: 699
            -- upvalues: HandleAddClick (ref), u69 (copy)
            HandleAddClick(u69);
        end);
        local ActualInviteButton = u69.NativeInvite.ActualInviteButton;
        local u71 = ActualInviteButton:FindFirstChildWhichIsA("UIScale");
        local SENSOR2 = ActualInviteButton:FindFirstChild("SENSOR");
        SENSOR2.MouseEnter:Connect(function() -- Line: 708
            -- upvalues: Spring (ref), u71 (copy)
            Spring.target(u71, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR2.MouseLeave:Connect(function() -- Line: 712
            -- upvalues: Spring (ref), u71 (copy)
            Spring.target(u71, 1, 10, {
                Scale = 1
            });
        end);
        SENSOR2.MouseButton1Down:Connect(function() -- Line: 716
            -- upvalues: Spring (ref), u71 (copy)
            Spring.target(u71, 1, 10, {
                Scale = 0.935
            });
        end);
        SENSOR2.MouseButton1Up:Connect(function() -- Line: 720
            -- upvalues: Spring (ref), u71 (copy)
            Spring.target(u71, 1, 10, {
                Scale = 1.065
            });
        end);
        SENSOR2.Activated:Connect(function() -- Line: 724
            -- upvalues: HandleNativeInviteClick (ref), u69 (copy)
            HandleNativeInviteClick(u69);
        end);
    end;

    local function RecomputeRowMetrics() -- Line: 733
        -- upvalues: ScrollingFrame (ref), PlayerTemplate (ref), State (copy), u65 (ref), u66 (ref), CreatePoolFrame (copy)
        local Y = ScrollingFrame.AbsoluteSize.Y;
        local Y2 = PlayerTemplate.AbsoluteSize.Y;

        if Y <= 0 or Y2 <= 0 then
            return;
        end;

        State.ItemHeight = Y2;
        State.ListPadding = Y * u65 + u66;
        local v72 = math.ceil(Y / (State.ItemHeight + State.ListPadding)) + 4;

        for i = #State.Pool + 1, v72 do
            CreatePoolFrame(i);
            local _ = i;
        end;

        State.PoolSize = #State.Pool;
    end;

    RecomputeRowMetrics();
    ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 753
        -- upvalues: RecomputeRowMetrics (copy), u3 (ref)
        RecomputeRowMetrics();
        u3:Render();
    end);
    TeamEventPartyInvite_UI.TeamInvites.Main.TeamMembers.LeaveTeam.ImageButton.Activated:Connect(function() -- Line: 760
        -- upvalues: TeamEventPartyController (ref), u1 (ref)
        TeamEventPartyController:LeaveParty(u1);
    end);
    TeamEventPartyController.OutboundChanged:Connect(function() -- Line: 765
        -- upvalues: u3 (ref)
        u3:Render();
    end);
    TeamEventController.DataUpdated:Connect(function() -- Line: 768
        -- upvalues: u3 (ref)
        u3:RenderMembers();
        u3:Render();
    end);
    TeamEventPartyController.InboundReceived:Connect(EnqueueInvite);
    u3:RenderMembers();
    ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 776
        -- upvalues: u3 (ref)
        u3:Render();
    end);
    TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 780
        -- upvalues: State (copy), TextBox (ref), ScrollingFrame (ref), u3 (ref)
        State.SearchQuery = TextBox.Text;
        ScrollingFrame.CanvasPosition = Vector2.new(0, 0);
        u3:Render();
    end);
    local u73 = 0;

    local function RefreshPlayerList() -- Line: 791
        -- upvalues: u73 (ref), FetchPlayerList (ref), State (copy), u3 (ref)
        u73 = u73 + 1;
        local u74 = u73;
        task.spawn(function() -- Line: 794
            -- upvalues: FetchPlayerList (ref), u74 (copy), u73 (ref), State (ref), u3 (ref)
            local v75 = FetchPlayerList();

            if u74 ~= u73 then
                return;
            end;

            State.PlayerList = v75;
            u3:Render();
        end);
    end;

    u73 = u73 + 1;
    local u76 = u73;
    task.spawn(function() -- Line: 794
        -- upvalues: FetchPlayerList (ref), u76 (copy), u73 (ref), State (copy), u3 (ref)
        local v77 = FetchPlayerList();

        if u76 ~= u73 then
            return;
        end;

        State.PlayerList = v77;
        u3:Render();
    end);
    Players.PlayerAdded:Connect(RefreshPlayerList);
    Players.PlayerRemoving:Connect(RefreshPlayerList);
end;

task.spawn(function() -- Line: 809
    -- upvalues: u3 (copy)
    u3:Start();
end);

return u3;