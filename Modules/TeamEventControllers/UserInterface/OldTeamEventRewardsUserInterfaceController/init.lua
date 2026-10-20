-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local TeamEventRewards_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TeamEventRewards_UI");
local TierRewards = TeamEventRewards_UI.Rewards.Main.TierRewards;
local u1 = {
    Basic = TierRewards:WaitForChild("BasicTemplate"),
    Mid = TierRewards:WaitForChild("MidTemplate"),
    Best = TierRewards:WaitForChild("BestTemplate")
};
local _ = u1.Basic;
local ProgressionContainer = TeamEventRewards_UI.Rewards.Main.ProgressHolder.ProgressionContainer;
local CloseButton = TeamEventRewards_UI.Rewards.Header.CloseButton;
local YourRewardsButton = TeamEventRewards_UI.Rewards.Header.YourRewardsButton;
local TeamRewardsButton = TeamEventRewards_UI.Rewards.Header.TeamRewardsButton;
local TitleText = TeamEventRewards_UI.Rewards.Header.TitleText;
local ProgressHolder = TeamEventRewards_UI.Rewards.Main.ProgressHolder;
local ProgressBar = TeamEventRewards_UI.Rewards.Main.ProgressHolder.ProgressBar;
local NotInTeam = TeamEventRewards_UI.Rewards.Main.NotInTeam;
local Rewards = TeamEventRewards_UI.Rewards;
local Size = Rewards.Size;
local Shadow = TeamEventRewards_UI.Rewards.Shadow;
local TeamRewardsCountdownTitle = Shadow:WaitForChild("TeamRewardsCountdownTitle");
local UIStroke = TeamRewardsCountdownTitle:WaitForChild("UIStroke");
local TeamEventController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventController);
local TeamEventHelper = require(ReplicatedStorage.Modules.TeamEventHelper);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Field_Of_View_Module = require(ReplicatedStorage.Field_Of_View_Module);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Modules.UpdateService);
local StateForGui = GuiController:GetStateForGui(TeamEventRewards_UI);
StateForGui.ChangeEnabled:Set(true);
local Color3_fromRGB_ret = Color3.fromRGB(0, 255, 21);
local Color3_fromRGB_ret2 = Color3.fromRGB(191, 107, 70);
local u2 = {
    State = {
        Visible = false,
        SelectedEvent = "CandyPackaging",
        SelectedRewardView = "YourRewards",
        LerpConnection = nil,
        CountdownConnection = nil,
        ScrollOffset = 0,
        TotalRewardsCount = 0,
        GeneratedFrames = {},
        ActivatedTiers = {},
        OddsConnections = {}
    }
};

local function GetPlayerTeamIdFromList(p3) -- Line: 85
    -- upvalues: LocalPlayer (copy)
    for i, v in p3 do
        if v.members[LocalPlayer.UserId] ~= nil then
            return i;
        end;
    end;
end;

local function UpdateCountdownText() -- Line: 95
    -- upvalues: u2 (copy), TeamEventHelper (copy), TeamRewardsCountdownTitle (copy), TeamEventController (copy), LocalPlayer (copy), NotInTeam (copy), TimeHelper (copy)
    local State = u2.State;
    local v4 = TeamEventHelper.Events[State.SelectedEvent];

    if not v4 then
        TeamRewardsCountdownTitle.Text = "";

        return;
    end;

    local v5 = v4.EndTime - workspace:GetServerTimeNow();

    if v5 > 0 then
        TeamRewardsCountdownTitle.Text = `Team rewards arrive in {TimeHelper:GetLargestTime(v5, "floor", 2)}`;

        return;
    end;

    if TeamEventController:GetTeamId(State.SelectedEvent, LocalPlayer) ~= nil then
        TeamRewardsCountdownTitle.Text = "Team rewards have been delivered!";

        return;
    end;

    TeamRewardsCountdownTitle.Text = "Rewards have been given to those in teams!";
    local Subtext = NotInTeam:FindFirstChild("Subtext");

    if Subtext then
        Subtext.Text = "Event ended: Can\'t join team anymore";
    end;
end;

local function AnimateCompletedFrame(p6: userdata) -- Line: 123
    -- upvalues: TweenService (copy)
    local v7 = p6:FindFirstChildWhichIsA("Frame");
    local v8;

    if v7 then
        v8 = v7:FindFirstChildWhichIsA("ImageLabel");
    else
        v8 = v7;
    end;

    p6.BackgroundTransparency = 1;
    p6.Visible = true;
    TweenService:Create(p6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.55
    }):Play();

    if v7 then
        v7.Size = UDim2.fromScale(0, 0);
        v7.Rotation = -15;
        TweenService:Create(v7, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = 0,
            Size = UDim2.fromScale(0.4, 0.4)
        }):Play();
    end;

    if v8 then
        v8.ImageColor3 = Color3.fromRGB(100, 255, 100);
        TweenService:Create(v8, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
    end;
end;

local function DeanimateCompletedFrame(u9: userdata) -- Line: 152
    -- upvalues: TweenService (copy)
    local v10 = u9:FindFirstChildWhichIsA("Frame");
    TweenService:Create(u9, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();

    if v10 then
        TweenService:Create(v10, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Rotation = 15,
            Size = UDim2.fromScale(0, 0)
        }):Play();
    end;

    task.delay(0.25, function() -- Line: 166
        -- upvalues: u9 (copy)
        u9.Visible = false;
    end);
end;

local function AnimateWillGetFrame(p11: userdata) -- Line: 171
    -- upvalues: TweenService (copy)
    local v12 = p11:FindFirstChildWhichIsA("ImageLabel");
    p11.BackgroundTransparency = 1;
    p11.Visible = true;
    TweenService:Create(p11, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.55
    }):Play();

    if v12 then
        v12.ImageTransparency = 1;
        TweenService:Create(v12, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
    end;
end;

local function DeanimateWillGetFrame(u13: userdata) -- Line: 189
    -- upvalues: TweenService (copy)
    TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();
    local v14 = u13:FindFirstChildWhichIsA("ImageLabel");

    if v14 then
        TweenService:Create(v14, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
    end;

    task.delay(0.25, function() -- Line: 201
        -- upvalues: u13 (copy)
        u13.Visible = false;
    end);
end;

local function ShowOverlay(p15: any, p16: string) -- Line: 207
    -- upvalues: DeanimateWillGetFrame (copy), AnimateCompletedFrame (copy), DeanimateCompletedFrame (copy), AnimateWillGetFrame (copy)
    local CompletedFrame = p15.CompletedFrame;
    local WillGetFrame = p15:FindFirstChild("WillGetFrame");

    if p16 ~= "completed" then
        if p16 == "willget" then
            DeanimateCompletedFrame(CompletedFrame);

            if WillGetFrame then
                AnimateWillGetFrame(WillGetFrame);
            end;
        end;

        return;
    end;

    if WillGetFrame then
        DeanimateWillGetFrame(WillGetFrame);
    end;

    AnimateCompletedFrame(CompletedFrame);
end;

local function HideOverlay(p17) -- Line: 221
    -- upvalues: DeanimateCompletedFrame (copy), DeanimateWillGetFrame (copy)
    DeanimateCompletedFrame(p17.CompletedFrame);
    local WillGetFrame = p17:FindFirstChild("WillGetFrame");

    if WillGetFrame then
        DeanimateWillGetFrame(WillGetFrame);
    end;
end;

local function SetOverlayInstant(p18: any, p19: string) -- Line: 228
    local CompletedFrame = p18.CompletedFrame;
    local WillGetFrame = p18:FindFirstChild("WillGetFrame");

    if p19 == "completed" then
        CompletedFrame.BackgroundTransparency = 0.55;
        CompletedFrame.Visible = true;
        local v20 = CompletedFrame:FindFirstChildWhichIsA("Frame");

        if v20 then
            v20.Size = UDim2.fromScale(0.4, 0.4);
            v20.Rotation = 0;
        end;

        if WillGetFrame then
            WillGetFrame.Visible = false;
        end;
    elseif p19 == "willget" then
        CompletedFrame.Visible = false;

        if WillGetFrame then
            WillGetFrame.BackgroundTransparency = 0.55;
            WillGetFrame.Visible = true;
            local v21 = WillGetFrame:FindFirstChildWhichIsA("ImageLabel");

            if v21 then
                v21.ImageTransparency = 0;
            end;
        end;
    else
        CompletedFrame.Visible = false;

        if WillGetFrame then
            WillGetFrame.Visible = false;
        end;
    end;
end;

local u28 = {
    YourRewards = {
        PageText = "Your Rewards",
        RewardIndexer = "PersonalRewards",
        Button = YourRewardsButton,

        AgregatePoints = function() -- Line: 260, Name: AgregatePoints
            -- upvalues: u2 (copy), DataService (copy)
            local SelectedEvent = u2.State.SelectedEvent;
            local v22 = DataService:GetData().TeamEventData[SelectedEvent] or {};

            return v22 and v22.Points or 0;
        end
    },
    TeamRewards = {
        PageText = "Team Rewards",
        RewardIndexer = "TeamRewards",
        Button = TeamRewardsButton,

        AgregatePoints = function() -- Line: 275, Name: AgregatePoints
            -- upvalues: u2 (copy), TeamEventController (copy), LocalPlayer (copy)
            local State = u2.State;
            local SelectedEvent = State.SelectedEvent;
            local _ = State.SelectedRewardView;
            local v23 = TeamEventController:GetCachedData() or {};
            local v24 = v23 and v23[SelectedEvent] or {};
            local v25 = nil;

            for i, v in v24 do
                if v.members[LocalPlayer.UserId] ~= nil then
                    v25 = i;
                    break;
                end;
            end;

            local v26 = v24 and v24[v25] or {};
            local v27 = 0;

            for _, v in v26 and v26.members or {} do
                v27 = v27 + v;
            end;

            return v27;
        end
    }
};

local function CountTotalRewards(p29) -- Line: 301
    local v30 = 0;

    for i in p29 do
        if string.match(i, "^Tier%d+$") then
            v30 = v30 + 1;
        end;
    end;

    return v30;
end;

function u2.ScrollTo(p31: table, p32: number) -- Line: 311
    -- upvalues: u2 (copy)
    local State = u2.State;
    local math_max_ret = math.max(0, State.TotalRewardsCount - 8);
    local math_clamp_ret = math.clamp(p32, 0, math_max_ret);

    if math_clamp_ret == State.ScrollOffset then
        return;
    end;

    State.ScrollOffset = math_clamp_ret;

    if State.LerpConnection then
        State.LerpConnection:Disconnect();
        State.LerpConnection = nil;
    end;

    u2:Render(true);
end;

function u2.Render(p33: table, p34: boolean?) -- Line: 326
    -- upvalues: u2 (copy), u28 (copy), TweenService (copy), TeamEventHelper (copy), CountTotalRewards (copy), Rewards (copy), TeamEventController (copy), LocalPlayer (copy), DataService (copy), NotInTeam (copy), u1 (copy), TierRewards (copy), ItemImageFinder (copy), SeedPackOddsController (copy), TeamEventRewards_UI (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), ProgressionContainer (copy), Color3_fromRGB_ret (copy), SetOverlayInstant (copy), Color3_fromRGB_ret2 (copy), ProgressHolder (copy), ProgressBar (copy), RunService (copy), ShowOverlay (copy), DeanimateCompletedFrame (copy), DeanimateWillGetFrame (copy), TitleText (copy), Shadow (copy), UpdateCountdownText (copy), TeamRewardsCountdownTitle (copy), UIStroke (copy)
    local State = u2.State;
    local SelectedEvent = State.SelectedEvent;
    local SelectedRewardView = State.SelectedRewardView;

    for i, v in u28 do
        if i ~= SelectedRewardView then
            local Claim = v.Button:FindFirstChild("Claim");

            if Claim then
                Claim = Claim:FindFirstChildWhichIsA("UIStroke");
            end;

            if Claim then
                TweenService:Create(Claim, TweenInfo.new(0.2), {
                    Color = Claim:GetAttribute("DefaultStrokeColor")
                }):Play();
            end;
        end;
    end;

    local v35 = u28[SelectedRewardView] or {};
    local Button = v35.Button;

    if Button then
        Button = Button:FindFirstChild("Claim");
    end;

    if Button then
        Button = Button:FindFirstChildWhichIsA("UIStroke");
    end;

    if Button then
        TweenService:Create(Button, TweenInfo.new(0.2), {
            Color = Button:GetAttribute("DefaultStrokeColor"):Lerp(Color3.fromRGB(255, 255, 255), 0.8)
        }):Play();
    end;

    local v36 = (TeamEventHelper.Events[SelectedEvent] or {})[v35.RewardIndexer] or {};
    local v37 = CountTotalRewards(v36);
    State.TotalRewardsCount = v37;
    local ScrollOffset = State.ScrollOffset;

    if u2.LeftArrow then
        u2.LeftArrow.Visible = ScrollOffset > 0;
    end;

    if u2.RightArrow then
        u2.RightArrow.Visible = ScrollOffset < math.max(0, v37 - 8);
    end;

    local v38 = v35.AgregatePoints and (v35.AgregatePoints() or 0) or 0;
    local v39 = TeamEventHelper:IsMaxPersonalTier(SelectedEvent, v38);

    if v39 then
        v39 = v35.RewardIndexer == "PersonalRewards";
    end;

    Rewards.Header.ResetTrack.Visible = v39;
    local v40 = SelectedRewardView == "TeamRewards";
    local v41 = TeamEventController:GetTeamId(SelectedEvent, LocalPlayer) ~= nil;
    local v42;

    if v40 then
        v42 = DataService:GetData();

        if v42 then
            v42 = v42.TeamEventData[SelectedEvent];
        end;

        if v42 then
            v42 = v42.Awarded == true;
        end;
    else
        v42 = false;
    end;

    local v43;

    if v40 then
        v43 = not v41;
    else
        v43 = v40;
    end;

    NotInTeam.Visible = v43;
    local u44 = {};
    local v45 = 0;
    local u46 = {};

    for i = 1, 8 do
        local v47 = i + ScrollOffset;
        local v48 = v36[`Tier{v47}`];
        local v49 = u1[v48 and (v48.Template or "Basic") or "Basic"] or u1.Basic;
        local v50 = State.GeneratedFrames[i];

        if v50 and v50:GetAttribute("TemplateType") ~= (v48 and (v48.Template or "Basic") or "Basic") then
            v50:Destroy();
            v50 = v49:Clone();
            v50:SetAttribute("TemplateType", v48 and (v48.Template or "Basic") or "Basic");
            v50.LayoutOrder = i;
            v50.Visible = true;
            v50.Parent = TierRewards;
            State.GeneratedFrames[i] = v50;
        end;

        local v51;

        if v50 then
            v50.Visible = v48 ~= nil;

            if v48 then
                local v52 = v48.RequiredPoints or 0;
                v50.Inner:WaitForChild("PointAmountText").Text = v52;
                v51 = i;
                local v53 = "";

                for _, v in v48.Rewards do
                    local v54;

                    if v.Variant then
                        v54 = `{v.Variant} {v.Value}`;
                    else
                        v54 = v.Value;
                    end;

                    v53 = v53 .. `x{v.Quantity or 1} {v54}, `;
                end;

                local v55 = ` {v53:sub(1, #v53 - 2)} `;
                v50.Inner:WaitForChild("RewardNameText").Text = v55;
                local Vector = v50.Inner:FindFirstChild("Vector");

                if Vector and v48.Rewards[1] then
                    local v56 = v48.Rewards[1];
                    Vector.Image = v56.CustomImage or ItemImageFinder(v56.Value, v56.Type);
                end;

                if State.OddsConnections[v51] then
                    State.OddsConnections[v51]:Disconnect();
                    State.OddsConnections[v51] = nil;
                end;

                local OddsButton = v50.Inner:FindFirstChild("OddsButton");

                if OddsButton and v48.Rewards[1] then
                    local v57 = v48.Rewards[1];
                    local Type = v57.Type;
                    local Value = v57.Value;

                    if Type == "Seed Pack" or (Type == "Egg" or Type == "Crate") then
                        OddsButton.Visible = true;
                        State.OddsConnections[v51] = OddsButton.Activated:Connect(function() -- Line: 455
                            -- upvalues: Type (copy), SeedPackOddsController (ref), Value (copy), TeamEventRewards_UI (ref), PetEggOddsController (ref), CosmeticCrateOddsController (ref)
                            if Type == "Seed Pack" then
                                SeedPackOddsController:Open(Value, TeamEventRewards_UI);

                                return;
                            end;

                            if Type == "Egg" then
                                PetEggOddsController:Open(Value, TeamEventRewards_UI);

                                return;
                            end;

                            if Type == "Crate" then
                                CosmeticCrateOddsController:Open(Value, TeamEventRewards_UI);
                            end;
                        end);
                    else
                        OddsButton.Visible = false;
                    end;
                end;

                local v58 = ProgressionContainer:FindFirstChild(v51);
                local v59 = v58 and (v58:FindFirstChildWhichIsA("TextLabel", true) or v58:FindFirstChildWhichIsA("TextButton", true));

                if v59 then
                    v59.Text = `{v47}.`;
                end;

                local v60 = v52 <= v38;
                local v61 = v60 and (v40 and not v42 and "willget" or "completed") or "none";

                if p34 then
                    if v60 then
                        if v58 then
                            v58.Dot.Container.BackgroundColor3 = Color3_fromRGB_ret;
                        end;

                        SetOverlayInstant(v50, v61);
                        State.ActivatedTiers[v51] = true;
                    else
                        if v58 then
                            v58.Dot.Container.BackgroundColor3 = Color3_fromRGB_ret2;
                        end;

                        local CompletedFrame = v50.CompletedFrame;
                        local WillGetFrame = v50:FindFirstChild("WillGetFrame");
                        CompletedFrame.Visible = false;

                        if WillGetFrame then
                            WillGetFrame.Visible = false;
                        end;

                        State.ActivatedTiers[v51] = nil;
                    end;
                else
                    local v62 = State.ActivatedTiers[v51] == true;

                    if v60 and not v62 then
                        if v58 then
                            v58.Dot.Container.BackgroundColor3 = Color3_fromRGB_ret2;
                        end;

                        local CompletedFrame = v50.CompletedFrame;
                        local WillGetFrame = v50:FindFirstChild("WillGetFrame");
                        CompletedFrame.Visible = false;

                        if WillGetFrame then
                            WillGetFrame.Visible = false;
                        end;

                        table.insert(u46, {
                            Activated = false,
                            DotHolder = v58,
                            RewardFrame = v50,
                            FrameIndex = v51,
                            OverlayType = v61
                        });
                    elseif v60 or not v62 then
                        if not v60 then
                            if v58 then
                                v58.Dot.Container.BackgroundColor3 = Color3_fromRGB_ret2;
                            end;

                            local CompletedFrame = v50.CompletedFrame;
                            local WillGetFrame = v50:FindFirstChild("WillGetFrame");
                            CompletedFrame.Visible = false;

                            if WillGetFrame then
                                WillGetFrame.Visible = false;
                            end;
                        end;
                    else
                        table.insert(u44, {
                            Deactivated = false,
                            DotHolder = v58,
                            RewardFrame = v50,
                            FrameIndex = v51
                        });
                    end;
                end;

                if v60 and v45 < v51 then
                    v45 = v51;
                end;
            else
                State.ActivatedTiers[i] = nil;
                v51 = i;
            end;
        else
            v51 = i;
        end;
    end;

    if State.LerpConnection then
        State.LerpConnection:Disconnect();
        State.LerpConnection = nil;
    end;

    local X = ProgressHolder.AbsolutePosition.X;
    local X2 = ProgressHolder.AbsoluteSize.X;
    local u63 = {};
    local v64 = {};

    for i = 1, 8 do
        local v65 = ProgressionContainer:FindFirstChild(i);

        if v65 then
            u63[i] = (v65.AbsolutePosition.X + v65.AbsoluteSize.X / 2 - X) / X2;
        end;

        local v66 = v36[`Tier{i + ScrollOffset}`];
        local v67;

        if v66 then
            v64[i] = v66.RequiredPoints or 0;
            v67 = i;
        else
            v67 = i;
        end;
    end;

    local u68;

    if math.min(8, v37 - ScrollOffset) <= v45 then
        u68 = 1;
    elseif v45 == 0 then
        u68 = math.clamp(v38 / (v64[1] or 1), 0, 1) * (u63[1] or 0);
    else
        local v69 = u63[v45] or 0;
        local v70 = v45 + 1;
        local v71 = u63[v70] or 1;
        local v72 = v64[v45] or 0;
        local v73 = (v64[v70] or v72) - v72;
        local v74 = v73 <= 0 and 1 or math.clamp((v38 - v72) / v73, 0, 1);
        u68 = v69 + (v71 - v69) * v74;
    end;

    if p34 then
        ProgressBar.Size = UDim2.fromScale(u68, 1);
    else
        local Scale = ProgressBar.Size.X.Scale;
        State.LerpConnection = RunService.RenderStepped:Connect(function(p75) -- Line: 590
            -- upvalues: Scale (ref), u68 (ref), ProgressBar (ref), u46 (copy), u63 (copy), State (copy), TweenService (ref), Color3_fromRGB_ret (ref), ShowOverlay (ref), u44 (copy), Color3_fromRGB_ret2 (ref), DeanimateCompletedFrame (ref), DeanimateWillGetFrame (ref)
            Scale = Scale + (u68 - Scale) * math.min(1, 5 * p75);
            ProgressBar.Size = UDim2.fromScale(Scale, 1);

            for _, v in u46 do
                if not v.Activated and Scale >= (u63[v.FrameIndex] or 0) - 0.005 then
                    v.Activated = true;
                    State.ActivatedTiers[v.FrameIndex] = true;
                    TweenService:Create(v.DotHolder.Dot.Container, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3_fromRGB_ret
                    }):Play();
                    ShowOverlay(v.RewardFrame, v.OverlayType);
                end;
            end;

            for _, v in u44 do
                if not v.Deactivated and Scale < (u63[v.FrameIndex] or 0) then
                    v.Deactivated = true;
                    State.ActivatedTiers[v.FrameIndex] = nil;
                    TweenService:Create(v.DotHolder.Dot.Container, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3_fromRGB_ret2
                    }):Play();
                    local RewardFrame = v.RewardFrame;
                    DeanimateCompletedFrame(RewardFrame.CompletedFrame);
                    local WillGetFrame = RewardFrame:FindFirstChild("WillGetFrame");

                    if WillGetFrame then
                        DeanimateWillGetFrame(WillGetFrame);
                    end;
                end;
            end;

            if math.abs(u68 - Scale) < 0.001 then
                ProgressBar.Size = UDim2.fromScale(u68, 1);

                for _, v in u46 do
                    if not v.Activated then
                        v.Activated = true;
                        State.ActivatedTiers[v.FrameIndex] = true;
                        TweenService:Create(v.DotHolder.Dot.Container, TweenInfo.new(0.1), {
                            BackgroundColor3 = Color3_fromRGB_ret
                        }):Play();
                        ShowOverlay(v.RewardFrame, v.OverlayType);
                    end;
                end;

                for _, v in u44 do
                    if not v.Deactivated then
                        v.Deactivated = true;
                        State.ActivatedTiers[v.FrameIndex] = nil;
                        TweenService:Create(v.DotHolder.Dot.Container, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3_fromRGB_ret2
                        }):Play();
                        local RewardFrame = v.RewardFrame;
                        DeanimateCompletedFrame(RewardFrame.CompletedFrame);
                        local WillGetFrame = RewardFrame:FindFirstChild("WillGetFrame");

                        if WillGetFrame then
                            DeanimateWillGetFrame(WillGetFrame);
                        end;
                    end;
                end;

                State.LerpConnection:Disconnect();
                State.LerpConnection = nil;
            end;
        end);
    end;

    TitleText.Text = v35 and v35.PageText or "Invalid Page";

    if State.CountdownConnection then
        State.CountdownConnection:Disconnect();
        State.CountdownConnection = nil;
    end;

    if SelectedRewardView == "TeamRewards" then
        Shadow.Visible = true;
        UpdateCountdownText();
        TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0.5
        }):Play();
        TweenService:Create(TeamRewardsCountdownTitle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0.43
        }):Play();
        local u76 = 0;
        State.CountdownConnection = RunService.Heartbeat:Connect(function() -- Line: 683
            -- upvalues: u76 (ref), UpdateCountdownText (ref)
            local os_clock_ret = os.clock();

            if os_clock_ret - u76 < 1 then
                return;
            end;

            u76 = os_clock_ret;
            UpdateCountdownText();
        end);
    else
        TweenService:Create(Shadow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(TeamRewardsCountdownTitle, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play();
        task.delay(0.25, function() -- Line: 700
            -- upvalues: u2 (ref), Shadow (ref)
            if u2.State.SelectedRewardView ~= "TeamRewards" then
                Shadow.Visible = false;
            end;
        end);
    end;
end;

function u2.Toggle(p77: table, p78: boolean?) -- Line: 708
    -- upvalues: u2 (copy), ProgressBar (copy), ProgressionContainer (copy), Color3_fromRGB_ret2 (copy), Shadow (copy), TeamRewardsCountdownTitle (copy), UIStroke (copy), ContextActionService (copy), GuiController (copy), TeamEventRewards_UI (copy)
    if p78 == nil then
        p78 = not u2.State.Visible;
    end;

    u2.State.Visible = p78;

    if not u2.State.Visible then
        if u2.State.CountdownConnection then
            u2.State.CountdownConnection:Disconnect();
            u2.State.CountdownConnection = nil;
        end;

        ContextActionService:UnbindAction("TeamEventRewardsBlockZoom");
        GuiController:Close(TeamEventRewards_UI);

        return;
    end;

    local State = u2.State;

    if State.LerpConnection then
        State.LerpConnection:Disconnect();
        State.LerpConnection = nil;
    end;

    State.ActivatedTiers = {};
    ProgressBar.Size = UDim2.fromScale(0, 1);

    for i = 1, 8 do
        local v79 = ProgressionContainer:FindFirstChild(i);
        local v80;

        if v79 then
            v79.Dot.Container.BackgroundColor3 = Color3_fromRGB_ret2;
            v80 = i;
        else
            v80 = i;
        end;
    end;

    for _, v in State.GeneratedFrames do
        local CompletedFrame = v.CompletedFrame;
        local WillGetFrame = v:FindFirstChild("WillGetFrame");
        CompletedFrame.Visible = false;

        if WillGetFrame then
            WillGetFrame.Visible = false;
        end;
    end;

    if State.CountdownConnection then
        State.CountdownConnection:Disconnect();
        State.CountdownConnection = nil;
    end;

    Shadow.Visible = false;
    Shadow.ImageTransparency = 1;
    TeamRewardsCountdownTitle.TextTransparency = 1;
    UIStroke.Transparency = 1;
    State.ScrollOffset = 0;
    ContextActionService:BindActionAtPriority("TeamEventRewardsBlockZoom", function() -- Line: 747
        return Enum.ContextActionResult.Sink;
    end, false, 3000, Enum.UserInputType.MouseWheel);
    GuiController:Open(TeamEventRewards_UI);
    task.delay(0.35, function() -- Line: 753
        -- upvalues: u2 (ref)
        u2:Render();
    end);
end;

function u2.Start(p81) -- Line: 767
    -- upvalues: u28 (copy), SetupButton (copy), u2 (copy), ProgressBar (copy), ProgressionContainer (copy), Color3_fromRGB_ret2 (copy), Rewards (copy), DevProductIds (copy), MarketController (copy), u1 (copy), Shadow (copy), TeamRewardsCountdownTitle (copy), UIStroke (copy), TierRewards (copy), TeamEventRewards_UI (copy), CloseButton (copy), StateForGui (copy), Field_Of_View_Module (copy), Blur_Module (copy), ContextActionService (copy), TweenService (copy), Size (copy), DataService (copy), TeamEventController (copy)
    for i, v in u28 do
        local Button = v.Button;
        SetupButton({
            legacy = true,
            instance = Button,

            onclick = function() -- Line: 773, Name: onclick
                -- upvalues: u2 (ref), i (copy), ProgressBar (ref), ProgressionContainer (ref), Color3_fromRGB_ret2 (ref)
                local State = u2.State;
                State.SelectedRewardView = i;
                State.ActivatedTiers = {};

                if State.LerpConnection then
                    State.LerpConnection:Disconnect();
                    State.LerpConnection = nil;
                end;

                ProgressBar.Size = UDim2.fromScale(0, 1);

                for i2 = 1, 8 do
                    local v82 = ProgressionContainer:FindFirstChild(i2);
                    local v83;

                    if v82 then
                        v82.Dot.Container.BackgroundColor3 = Color3_fromRGB_ret2;
                        v83 = i2;
                    else
                        v83 = i2;
                    end;
                end;

                for _, v2 in State.GeneratedFrames do
                    local CompletedFrame = v2.CompletedFrame;
                    local WillGetFrame = v2:FindFirstChild("WillGetFrame");
                    CompletedFrame.Visible = false;

                    if WillGetFrame then
                        WillGetFrame.Visible = false;
                    end;
                end;

                State.ScrollOffset = 0;
                u2:Render(true);
            end
        });
        local Claim = Button:FindFirstChild("Claim");

        if Claim then
            Claim = Claim:FindFirstChildWhichIsA("UIStroke");
        end;

        if Claim then
            Claim:SetAttribute("DefaultStrokeColor", Claim.Color);
        end;
    end;

    SetupButton({
        legacy = true,
        instance = Rewards.Header.ResetTrack,

        onclick = function() -- Line: 814, Name: onclick
            -- upvalues: u2 (ref), DevProductIds (ref), MarketController (ref)
            local _ = u2.State;
            MarketController:PromptPurchase(DevProductIds.ResetTeamEventPersonalPoints.PurchaseID, Enum.InfoType.Product);
        end
    });
    u2.State.SelectedRewardView = "YourRewards";

    for _, v in u1 do
        v.Visible = false;
    end;

    Shadow.Visible = false;
    Shadow.ImageTransparency = 1;
    TeamRewardsCountdownTitle.TextTransparency = 1;
    UIStroke.Transparency = 1;

    for i = 1, 8 do
        local v84 = u1.Basic:Clone();
        v84.Visible = true;
        v84.LayoutOrder = i;
        v84:SetAttribute("TemplateType", "Basic");
        v84.Parent = TierRewards;
        u2.State.GeneratedFrames[i] = v84;
        local _ = i;
    end;

    local Main = TeamEventRewards_UI.Rewards.Main;
    Main.MouseWheelForward:Connect(function() -- Line: 841
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset - 1);
    end);
    Main.MouseWheelBackward:Connect(function() -- Line: 844
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset + 1);
    end);
    local u85 = nil;
    local u86 = nil;
    Main.InputBegan:Connect(function(p87) -- Line: 850
        -- upvalues: u85 (ref), u86 (ref), u2 (ref)
        if p87.UserInputType == Enum.UserInputType.Touch then
            u85 = p87.Position.X;
            u86 = u2.State.ScrollOffset;
        end;
    end);
    Main.InputChanged:Connect(function(p88) -- Line: 856
        -- upvalues: u85 (ref), Main (copy), u2 (ref), u86 (ref)
        if p88.UserInputType == Enum.UserInputType.Touch and u85 then
            u2:ScrollTo(u86 + math.round((u85 - p88.Position.X) / (Main.AbsoluteSize.X / 8)));
        end;
    end);
    Main.InputEnded:Connect(function(p89) -- Line: 864
        -- upvalues: u85 (ref), u86 (ref)
        if p89.UserInputType == Enum.UserInputType.Touch then
            u85 = nil;
            u86 = nil;
        end;
    end);
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "ScrollLeftArrow";
    TextButton.Text = "◀";
    TextButton.Size = UDim2.fromOffset(32, 32);
    TextButton.AnchorPoint = Vector2.new(0.5, 0.5);
    TextButton.Position = UDim2.new(0, 6, 0.35, 0);
    TextButton.BackgroundColor3 = Color3.fromRGB(70, 50, 35);
    TextButton.BackgroundTransparency = 0.15;
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextButton.TextSize = 18;
    TextButton.Font = Enum.Font.GothamBold;
    TextButton.ZIndex = 10;
    TextButton.Visible = false;
    TextButton.AutoButtonColor = true;
    TextButton.Parent = Main;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = TextButton;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Name = "ScrollRightArrow";
    TextButton2.Text = "▶";
    TextButton2.Size = UDim2.fromOffset(32, 32);
    TextButton2.AnchorPoint = Vector2.new(0.5, 0.5);
    TextButton2.Position = UDim2.new(1, -6, 0.35, 0);
    TextButton2.BackgroundColor3 = Color3.fromRGB(70, 50, 35);
    TextButton2.BackgroundTransparency = 0.15;
    TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextButton2.TextSize = 18;
    TextButton2.Font = Enum.Font.GothamBold;
    TextButton2.ZIndex = 10;
    TextButton2.Visible = false;
    TextButton2.AutoButtonColor = true;
    TextButton2.Parent = Main;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0, 6);
    UICorner2.Parent = TextButton2;
    TextButton.MouseButton1Click:Connect(function() -- Line: 911
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset - 1);
    end);
    TextButton2.MouseButton1Click:Connect(function() -- Line: 914
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset + 1);
    end);
    u2.LeftArrow = TextButton;
    u2.RightArrow = TextButton2;
    SetupButton({
        legacy = true,
        instance = CloseButton,

        onclick = function() -- Line: 924, Name: onclick
            -- upvalues: u2 (ref)
            u2:Toggle(false);
        end
    });
    StateForGui.Visible:Observe(function(p90) -- Line: 929
        -- upvalues: Field_Of_View_Module (ref), Blur_Module (ref), ContextActionService (ref), TeamEventRewards_UI (ref), Rewards (ref), TweenService (ref), Size (ref)
        Field_Of_View_Module.Change_FOV(p90 and 60 or 70);
        Blur_Module.Blur(p90 and 15 or 0, 0.1);

        if not p90 then
            ContextActionService:UnbindAction("TeamEventRewardsBlockZoom");
        end;

        TeamEventRewards_UI.Enabled = p90;

        if p90 then
            Rewards.Size = UDim2.fromScale(0, 0);
            TweenService:Create(Rewards, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = Size
            }):Play();
        end;
    end);
    DataService:GetPathSignal("TeamEventData/@"):Connect(function() -- Line: 947
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    TeamEventController.DataUpdated:Connect(function() -- Line: 951
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    u2:Render();
end;

task.spawn(function() -- Line: 958
    -- upvalues: u2 (copy)
    u2:Start();
end);

return u2;