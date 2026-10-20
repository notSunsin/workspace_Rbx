-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local TeamEventRewards_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TeamEventRewards_UI");
local TierRewards = TeamEventRewards_UI.Rewards_HarvestMoon.Main.TierRewards;
local u1 = {
    Basic = TierRewards:WaitForChild("BasicTemplate"),
    Mid = TierRewards:WaitForChild("MidTemplate"),
    Best = TierRewards:WaitForChild("BestTemplate")
};
local _ = u1.Basic;
local ProgressionContainer = TeamEventRewards_UI.Rewards_HarvestMoon.Main.ProgressHolder.ProgressionContainer;
local CloseButton = TeamEventRewards_UI.Rewards_HarvestMoon.Header.CloseButton;
local YourRewardsButton = TeamEventRewards_UI.Rewards_HarvestMoon.Header.YourRewardsButton;
local TeamRewardsButton = TeamEventRewards_UI.Rewards_HarvestMoon.Header.TeamRewardsButton;
local TitleText = TeamEventRewards_UI.Rewards_HarvestMoon.Header.TitleText;
local ProgressHolder = TeamEventRewards_UI.Rewards_HarvestMoon.Main.ProgressHolder;
local ProgressBar = TeamEventRewards_UI.Rewards_HarvestMoon.Main.ProgressHolder.ProgressBar;
local NotInTeam = TeamEventRewards_UI.Rewards_HarvestMoon.Main.NotInTeam;
local Currency = TeamEventRewards_UI.Rewards_HarvestMoon.Main:FindFirstChild("Currency");

if Currency then
    Currency = Currency:FindFirstChild("Value");
end;

local Rewards_HarvestMoon = TeamEventRewards_UI.Rewards_HarvestMoon;
local Size = Rewards_HarvestMoon.Size;
local Shadow = TeamEventRewards_UI.Rewards_HarvestMoon.Shadow;
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
require(ReplicatedStorage.Modules.UpdateService);
local HarvestMoonPartyInviteUIController = require(ReplicatedStorage.Modules.TeamEventControllers.UserInterface.HarvestMoonPartyInviteUIController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local StateForGui = GuiController:GetStateForGui(TeamEventRewards_UI);
StateForGui.ChangeEnabled:Set(true);
local Color3_fromRGB_ret = Color3.fromRGB(0, 255, 21);
local Color3_fromRGB_ret2 = Color3.fromRGB(191, 107, 70);
local u2 = {
    State = {
        Visible = false,
        SelectedEvent = "HarvestMoon",
        SelectedRewardView = "TeamRewards",
        LerpConnection = nil,
        CountdownConnection = nil,
        ScrollOffset = 0,
        TotalRewardsCount = 0,
        GeneratedFrames = {},
        ActivatedTiers = {},
        OddsConnections = {}
    }
};

local function GetPlayerTeamIdFromList(p3) -- Line: 87
    -- upvalues: LocalPlayer (copy)
    for i, v in p3 do
        if v.members[LocalPlayer.UserId] ~= nil then
            return i;
        end;
    end;
end;

local function GetOwnPoints() -- Line: 97
    -- upvalues: DataService (copy), u2 (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.TeamEventData;
    end;

    local v4;

    if type(Data) == "table" then
        v4 = Data[u2.State.SelectedEvent];
    else
        v4 = false;
    end;

    return type(v4) == "table" and tonumber(v4.Points) or 0;
end;

local function UpdateCountdownText() -- Line: 104
    -- upvalues: u2 (copy), TeamEventHelper (copy), TeamRewardsCountdownTitle (copy), TeamEventController (copy), LocalPlayer (copy), NotInTeam (copy), TimeHelper (copy)
    local State = u2.State;
    local v5 = TeamEventHelper.Events[State.SelectedEvent];

    if not v5 then
        TeamRewardsCountdownTitle.Text = "";

        return;
    end;

    local v6 = v5.EndTime - workspace:GetServerTimeNow();

    if v6 > 0 then
        TeamRewardsCountdownTitle.Text = `Team rewards arrive in {TimeHelper:GetLargestTime(v6, "floor", 2)}`;

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

local function AnimateCompletedFrame(p7: userdata) -- Line: 132
    -- upvalues: TweenService (copy)
    local v8 = p7:FindFirstChildWhichIsA("Frame");
    local v9;

    if v8 then
        v9 = v8:FindFirstChildWhichIsA("ImageLabel");
    else
        v9 = v8;
    end;

    p7.BackgroundTransparency = 1;
    p7.Visible = true;
    TweenService:Create(p7, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.55
    }):Play();

    if v8 then
        v8.Size = UDim2.fromScale(0, 0);
        v8.Rotation = -15;
        TweenService:Create(v8, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = 0,
            Size = UDim2.fromScale(0.4, 0.4)
        }):Play();
    end;

    if v9 then
        v9.ImageColor3 = Color3.fromRGB(100, 255, 100);
        TweenService:Create(v9, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
    end;
end;

local function DeanimateCompletedFrame(u10: userdata) -- Line: 161
    -- upvalues: TweenService (copy)
    local v11 = u10:FindFirstChildWhichIsA("Frame");
    TweenService:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();

    if v11 then
        TweenService:Create(v11, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Rotation = 15,
            Size = UDim2.fromScale(0, 0)
        }):Play();
    end;

    task.delay(0.25, function() -- Line: 175
        -- upvalues: u10 (copy)
        u10.Visible = false;
    end);
end;

local function AnimateWillGetFrame(p12: userdata) -- Line: 180
    -- upvalues: TweenService (copy)
    local v13 = p12:FindFirstChildWhichIsA("ImageLabel");
    p12.BackgroundTransparency = 1;
    p12.Visible = true;
    TweenService:Create(p12, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.55
    }):Play();

    if v13 then
        v13.ImageTransparency = 1;
        TweenService:Create(v13, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
    end;
end;

local function DeanimateWillGetFrame(u14: userdata) -- Line: 198
    -- upvalues: TweenService (copy)
    TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();
    local v15 = u14:FindFirstChildWhichIsA("ImageLabel");

    if v15 then
        TweenService:Create(v15, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
    end;

    task.delay(0.25, function() -- Line: 210
        -- upvalues: u14 (copy)
        u14.Visible = false;
    end);
end;

local function ShowOverlay(p16: any, p17: string) -- Line: 216
    -- upvalues: DeanimateWillGetFrame (copy), AnimateCompletedFrame (copy), DeanimateCompletedFrame (copy), AnimateWillGetFrame (copy)
    local CompletedFrame = p16.CompletedFrame;
    local WillGetFrame = p16:FindFirstChild("WillGetFrame");

    if p17 ~= "completed" then
        if p17 == "willget" then
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

local function HideOverlay(p18) -- Line: 230
    -- upvalues: DeanimateCompletedFrame (copy), DeanimateWillGetFrame (copy)
    DeanimateCompletedFrame(p18.CompletedFrame);
    local WillGetFrame = p18:FindFirstChild("WillGetFrame");

    if WillGetFrame then
        DeanimateWillGetFrame(WillGetFrame);
    end;
end;

local function SetOverlayInstant(p19: any, p20: string) -- Line: 237
    local CompletedFrame = p19.CompletedFrame;
    local WillGetFrame = p19:FindFirstChild("WillGetFrame");

    if p20 == "completed" then
        CompletedFrame.BackgroundTransparency = 0.55;
        CompletedFrame.Visible = true;
        local v21 = CompletedFrame:FindFirstChildWhichIsA("Frame");

        if v21 then
            v21.Size = UDim2.fromScale(0.4, 0.4);
            v21.Rotation = 0;
        end;

        if WillGetFrame then
            WillGetFrame.Visible = false;
        end;
    elseif p20 == "willget" then
        CompletedFrame.Visible = false;

        if WillGetFrame then
            WillGetFrame.BackgroundTransparency = 0.55;
            WillGetFrame.Visible = true;
            local v22 = WillGetFrame:FindFirstChildWhichIsA("ImageLabel");

            if v22 then
                v22.ImageTransparency = 0;
            end;
        end;
    else
        CompletedFrame.Visible = false;

        if WillGetFrame then
            WillGetFrame.Visible = false;
        end;
    end;
end;

local u30 = {
    TeamRewards = {
        PageText = "Team Rewards",
        RewardIndexer = "TeamRewards",
        Button = TeamRewardsButton,

        AgregatePoints = function() -- Line: 269, Name: AgregatePoints
            -- upvalues: u2 (copy), TeamEventController (copy), LocalPlayer (copy), DataService (copy)
            local SelectedEvent = u2.State.SelectedEvent;
            local v23 = TeamEventController:GetCachedData() or {};
            local v24 = v23 and v23[SelectedEvent] or {};
            local v25 = nil;

            for i, v in v24 do
                if v.members[LocalPlayer.UserId] ~= nil then
                    v25 = i;
                    break;
                end;
            end;

            if v25 then
                local v26 = v24 and v24[v25] or {};
                local v27 = 0;

                for i, v in v26 and v26.members or {} do
                    if i == LocalPlayer.UserId then
                        local Data = DataService:GetData();

                        if Data then
                            Data = Data.TeamEventData;
                        end;

                        local v28;

                        if type(Data) == "table" then
                            v28 = Data[u2.State.SelectedEvent];
                        else
                            v28 = false;
                        end;

                        v27 = v27 + (type(v28) == "table" and (tonumber(v28.Points) or 0) or 0);
                    else
                        v27 = v27 + (tonumber(v) or 0);
                    end;
                end;

                return v27;
            end;

            local Data = DataService:GetData();

            if Data then
                Data = Data.TeamEventData;
            end;

            local v29;

            if type(Data) == "table" then
                v29 = Data[u2.State.SelectedEvent];
            else
                v29 = false;
            end;

            return type(v29) == "table" and tonumber(v29.Points) or 0;
        end
    }
};

local function CountTotalRewards(p31) -- Line: 300
    local v32 = 0;

    for i in p31 do
        if string.match(i, "^Tier%d+$") then
            v32 = v32 + 1;
        end;
    end;

    return v32;
end;

local function FormatShort(p33: number) -- Line: 310
    if p33 >= 1000000 then
        local v34 = math.floor(p33 / 100000) / 10;

        if v34 % 1 == 0 then
            return string.format("%dM", v34);
        end;

        return string.format("%.1fM", v34);
    end;

    if p33 < 1000 then
        local math_floor_ret = math.floor(p33);

        return tostring(math_floor_ret);
    end;

    local v35 = math.floor(p33 / 100) / 10;

    if v35 % 1 == 0 then
        return string.format("%dK", v35);
    end;

    return string.format("%.1fK", v35);
end;

function u2.ScrollTo(p36: table, p37: number) -- Line: 321
    -- upvalues: u2 (copy)
    local State = u2.State;
    local math_max_ret = math.max(0, State.TotalRewardsCount - 6);
    local math_clamp_ret = math.clamp(p37, 0, math_max_ret);

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

function u2.Render(p38: table, p39: boolean?) -- Line: 336
    -- upvalues: u2 (copy), u30 (copy), TweenService (copy), GameConfigController (copy), CountTotalRewards (copy), Currency (copy), FormatShort (copy), TeamEventHelper (copy), Rewards_HarvestMoon (copy), NotInTeam (copy), u1 (copy), TierRewards (copy), ItemImageFinder (copy), SeedPackOddsController (copy), TeamEventRewards_UI (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), ProgressionContainer (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), SetOverlayInstant (copy), ProgressHolder (copy), ProgressBar (copy), RunService (copy), ShowOverlay (copy), DeanimateCompletedFrame (copy), DeanimateWillGetFrame (copy), TitleText (copy), Shadow (copy), TeamRewardsCountdownTitle (copy), UIStroke (copy)
    local State = u2.State;
    local SelectedEvent = State.SelectedEvent;
    local SelectedRewardView = State.SelectedRewardView;

    for i, v in u30 do
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

    local v40 = u30[SelectedRewardView] or {};
    local Button = v40.Button;

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

    local v41 = GameConfigController:GetConfig("HarvestMoonTeamRewards") or {};
    local v42 = CountTotalRewards(v41);
    State.TotalRewardsCount = v42;
    local ScrollOffset = State.ScrollOffset;

    if u2.LeftArrow then
        u2.LeftArrow.Visible = ScrollOffset > 0;
    end;

    if u2.RightArrow then
        u2.RightArrow.Visible = ScrollOffset < math.max(0, v42 - 6);
    end;

    local v43 = v40.AgregatePoints and (v40.AgregatePoints() or 0) or 0;

    if Currency then
        Currency.Text = FormatShort(v43);
    end;

    TeamEventHelper:IsMaxPersonalTier(SelectedEvent, v43);
    Rewards_HarvestMoon.Header.ResetTrack.Visible = false;
    NotInTeam.Visible = false;
    local v44 = 0;
    local u45 = {};
    local u46 = {};

    for i = 1, 6 do
        local v47 = v41[`Tier{i + ScrollOffset}`];
        local v48 = u1[v47 and (v47.Template or "Basic") or "Basic"] or u1.Basic;
        local v49 = State.GeneratedFrames[i];

        if v49 and v49:GetAttribute("TemplateType") ~= (v47 and (v47.Template or "Basic") or "Basic") then
            v49:Destroy();
            v49 = v48:Clone();
            v49:SetAttribute("TemplateType", v47 and (v47.Template or "Basic") or "Basic");
            v49.LayoutOrder = i;
            v49.Visible = true;
            v49.Parent = TierRewards;
            State.GeneratedFrames[i] = v49;
        end;

        local v50;

        if v49 then
            v49.Visible = v47 ~= nil;

            if v47 then
                local v51 = v47.RequiredPoints or 0;
                local v52 = v47.Rewards[1] and (v47.Rewards[1].Quantity or 1) or 1;
                v49.Inner:WaitForChild("PointAmountText").Text = `x{v52}`;
                v50 = i;
                local v53 = "";

                for _, v in v47.Rewards do
                    local v54;

                    if v.Variant then
                        v54 = `{v.Variant} {v.Value}`;
                    else
                        v54 = v.Value;
                    end;

                    v53 = v53 .. `{v54}, `;
                end;

                local v55 = ` {v53:sub(1, #v53 - 2)} `;
                v49.Inner:WaitForChild("RewardNameText").Text = v55;
                local Vector = v49.Inner:FindFirstChild("Vector");

                if Vector and v47.Rewards[1] then
                    local v56 = v47.Rewards[1];
                    Vector.Image = v56.CustomImage or ItemImageFinder(v56.Value, v56.Type);
                end;

                if State.OddsConnections[v50] then
                    State.OddsConnections[v50]:Disconnect();
                    State.OddsConnections[v50] = nil;
                end;

                local OddsButton = v49.Inner:FindFirstChild("OddsButton");

                if OddsButton and v47.Rewards[1] then
                    local v57 = v47.Rewards[1];
                    local Type = v57.Type;
                    local Value = v57.Value;

                    if Type == "Seed Pack" or (Type == "Egg" or Type == "Crate") then
                        OddsButton.Visible = true;
                        State.OddsConnections[v50] = OddsButton.Activated:Connect(function() -- Line: 459
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

                local v58 = ProgressionContainer:FindFirstChild(v50);
                local v59 = v58 and (v58:FindFirstChildWhichIsA("TextLabel", true) or v58:FindFirstChildWhichIsA("TextButton", true));

                if v59 then
                    v59.Text = FormatShort(v51);
                end;

                local v60 = v51 <= v43;

                if v58 then
                    local v61;

                    if v60 then
                        v61 = Color3_fromRGB_ret;
                    else
                        v61 = Color3_fromRGB_ret2;
                    end;

                    v58.Dot.Container.BackgroundColor3 = v61;
                end;

                SetOverlayInstant(v49, not v60 and "none" or (v60 and "completed" or "none"));
                State.ActivatedTiers[v50] = v60 and true or nil;

                if v60 and v44 < v50 then
                    v44 = v50;
                end;
            else
                State.ActivatedTiers[i] = nil;
                v50 = i;
            end;
        else
            v50 = i;
        end;
    end;

    if State.LerpConnection then
        State.LerpConnection:Disconnect();
        State.LerpConnection = nil;
    end;

    local X = ProgressHolder.AbsolutePosition.X;
    local X2 = ProgressHolder.AbsoluteSize.X;
    local u62 = {};
    local v63 = {};

    for i = 1, 6 do
        local v64 = ProgressionContainer:FindFirstChild(i);

        if v64 then
            u62[i] = (v64.AbsolutePosition.X + v64.AbsoluteSize.X / 2 - X) / X2;
        end;

        local v65 = v41[`Tier{i + ScrollOffset}`];
        local v66;

        if v65 then
            v63[i] = v65.RequiredPoints or 0;
            v66 = i;
        else
            v66 = i;
        end;
    end;

    local u67;

    if math.min(6, v42 - ScrollOffset) <= v44 then
        u67 = 1;
    elseif v44 == 0 then
        u67 = math.clamp(v43 / (v63[1] or 1), 0, 1) * (u62[1] or 0);
    else
        local v68 = u62[v44] or 0;
        local v69 = v44 + 1;
        local v70 = u62[v69] or 1;
        local v71 = v63[v44] or 0;
        local v72 = (v63[v69] or v71) - v71;
        local v73 = v72 <= 0 and 1 or math.clamp((v43 - v71) / v72, 0, 1);
        u67 = v68 + (v70 - v68) * v73;
    end;

    if p39 then
        ProgressBar.Size = UDim2.fromScale(u67, 1);
    else
        local Scale = ProgressBar.Size.X.Scale;
        State.LerpConnection = RunService.RenderStepped:Connect(function(p74) -- Line: 552
            -- upvalues: Scale (ref), u67 (ref), ProgressBar (ref), u46 (copy), u62 (copy), State (copy), TweenService (ref), Color3_fromRGB_ret (ref), ShowOverlay (ref), u45 (copy), Color3_fromRGB_ret2 (ref), DeanimateCompletedFrame (ref), DeanimateWillGetFrame (ref)
            Scale = Scale + (u67 - Scale) * math.min(1, 5 * p74);
            ProgressBar.Size = UDim2.fromScale(Scale, 1);

            for _, v in u46 do
                if not v.Activated and Scale >= (u62[v.FrameIndex] or 0) - 0.005 then
                    v.Activated = true;
                    State.ActivatedTiers[v.FrameIndex] = true;
                    TweenService:Create(v.DotHolder.Dot.Container, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3_fromRGB_ret
                    }):Play();
                    ShowOverlay(v.RewardFrame, v.OverlayType);
                end;
            end;

            for _, v in u45 do
                if not v.Deactivated and Scale < (u62[v.FrameIndex] or 0) then
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

            if math.abs(u67 - Scale) < 0.001 then
                ProgressBar.Size = UDim2.fromScale(u67, 1);

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

                for _, v in u45 do
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

    TitleText.Text = v40 and v40.PageText or "Invalid Page";

    if State.CountdownConnection then
        State.CountdownConnection:Disconnect();
        State.CountdownConnection = nil;
    end;

    Shadow.Visible = false;
    Shadow.ImageTransparency = 1;
    TeamRewardsCountdownTitle.TextTransparency = 1;
    UIStroke.Transparency = 1;
end;

function u2.Toggle(p75: table, p76: boolean?) -- Line: 634
    -- upvalues: u2 (copy), TeamEventRewards_UI (copy), Rewards_HarvestMoon (copy), ProgressBar (copy), ProgressionContainer (copy), Color3_fromRGB_ret2 (copy), Shadow (copy), TeamRewardsCountdownTitle (copy), UIStroke (copy), ContextActionService (copy), GuiController (copy)
    if p76 == nil then
        p76 = not u2.State.Visible;
    end;

    u2.State.Visible = p76;

    if not u2.State.Visible then
        Rewards_HarvestMoon.Visible = false;

        if u2.State.CountdownConnection then
            u2.State.CountdownConnection:Disconnect();
            u2.State.CountdownConnection = nil;
        end;

        ContextActionService:UnbindAction("TeamEventRewardsBlockZoom");
        GuiController:Close(TeamEventRewards_UI);

        return;
    end;

    local State = u2.State;
    local v77 = TeamEventRewards_UI;

    for _, v in { "RewardsWithQuests", "Rewards", "Rewards_HarvestMoon_OLD", "Quests", "Quests_Old" } do
        local v78 = v77:FindFirstChild(v);

        if v78 then
            v78.Visible = false;
        end;
    end;

    Rewards_HarvestMoon.Visible = true;

    if State.LerpConnection then
        State.LerpConnection:Disconnect();
        State.LerpConnection = nil;
    end;

    State.ActivatedTiers = {};
    ProgressBar.Size = UDim2.fromScale(0, 1);

    for i = 1, 6 do
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
    ContextActionService:BindActionAtPriority("TeamEventRewardsBlockZoom", function() -- Line: 680
        return Enum.ContextActionResult.Sink;
    end, false, 3000, Enum.UserInputType.MouseWheel);
    GuiController:Open(TeamEventRewards_UI);
    task.delay(0.35, function() -- Line: 686
        -- upvalues: u2 (ref)
        u2:Render();
    end);
end;

function u2.Start(p81) -- Line: 702
    -- upvalues: u30 (copy), SetupButton (copy), u2 (copy), ProgressBar (copy), ProgressionContainer (copy), Color3_fromRGB_ret2 (copy), YourRewardsButton (copy), HarvestMoonPartyInviteUIController (copy), TeamRewardsButton (copy), Rewards_HarvestMoon (copy), u1 (copy), Shadow (copy), TeamRewardsCountdownTitle (copy), UIStroke (copy), TierRewards (copy), TeamEventRewards_UI (copy), CloseButton (copy), StateForGui (copy), Field_Of_View_Module (copy), Blur_Module (copy), ContextActionService (copy), TweenService (copy), Size (copy), DataService (copy), TeamEventController (copy)
    for i, v in u30 do
        local Button = v.Button;
        SetupButton({
            legacy = true,
            instance = Button,

            onclick = function() -- Line: 708, Name: onclick
                -- upvalues: u2 (ref), i (copy), ProgressBar (ref), ProgressionContainer (ref), Color3_fromRGB_ret2 (ref)
                local State = u2.State;
                State.SelectedRewardView = i;
                State.ActivatedTiers = {};

                if State.LerpConnection then
                    State.LerpConnection:Disconnect();
                    State.LerpConnection = nil;
                end;

                ProgressBar.Size = UDim2.fromScale(0, 1);

                for i2 = 1, 6 do
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

    local v84 = YourRewardsButton:FindFirstChild("Claim") and YourRewardsButton.Claim:FindFirstChild("Label");

    if v84 then
        v84.Text = "View Team";
    end;

    SetupButton({
        legacy = true,
        instance = YourRewardsButton,

        onclick = function() -- Line: 752, Name: onclick
            -- upvalues: u2 (ref), HarvestMoonPartyInviteUIController (ref)
            u2:Toggle(false);
            HarvestMoonPartyInviteUIController:Toggle(true);
        end
    });
    YourRewardsButton.Position = TeamRewardsButton.Position;
    TeamRewardsButton.Visible = false;
    Rewards_HarvestMoon.Header.ResetTrack.Visible = false;
    u2.State.SelectedRewardView = "TeamRewards";

    for _, v in u1 do
        v.Visible = false;
    end;

    Shadow.Visible = false;
    Shadow.ImageTransparency = 1;
    TeamRewardsCountdownTitle.TextTransparency = 1;
    UIStroke.Transparency = 1;

    for i = 1, 6 do
        local v85 = u1.Basic:Clone();
        v85.Visible = true;
        v85.LayoutOrder = i;
        v85:SetAttribute("TemplateType", "Basic");
        v85.Parent = TierRewards;
        u2.State.GeneratedFrames[i] = v85;
        local _ = i;
    end;

    local Main = TeamEventRewards_UI.Rewards_HarvestMoon.Main;
    Main.MouseWheelForward:Connect(function() -- Line: 783
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset - 1);
    end);
    Main.MouseWheelBackward:Connect(function() -- Line: 786
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset + 1);
    end);
    local u86 = nil;
    local u87 = nil;
    Main.InputBegan:Connect(function(p88) -- Line: 792
        -- upvalues: u86 (ref), u87 (ref), u2 (ref)
        if p88.UserInputType == Enum.UserInputType.Touch then
            u86 = p88.Position.X;
            u87 = u2.State.ScrollOffset;
        end;
    end);
    Main.InputChanged:Connect(function(p89) -- Line: 798
        -- upvalues: u86 (ref), Main (copy), u2 (ref), u87 (ref)
        if p89.UserInputType == Enum.UserInputType.Touch and u86 then
            u2:ScrollTo(u87 + math.round((u86 - p89.Position.X) / (Main.AbsoluteSize.X / 6)));
        end;
    end);
    Main.InputEnded:Connect(function(p90) -- Line: 806
        -- upvalues: u86 (ref), u87 (ref)
        if p90.UserInputType == Enum.UserInputType.Touch then
            u86 = nil;
            u87 = nil;
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
    TextButton.MouseButton1Click:Connect(function() -- Line: 853
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset - 1);
    end);
    TextButton2.MouseButton1Click:Connect(function() -- Line: 856
        -- upvalues: u2 (ref)
        u2:ScrollTo(u2.State.ScrollOffset + 1);
    end);
    u2.LeftArrow = TextButton;
    u2.RightArrow = TextButton2;
    SetupButton({
        legacy = true,
        instance = CloseButton,

        onclick = function() -- Line: 866, Name: onclick
            -- upvalues: u2 (ref)
            u2:Toggle(false);
        end
    });
    StateForGui.Visible:Observe(function(p91) -- Line: 871
        -- upvalues: Field_Of_View_Module (ref), Blur_Module (ref), ContextActionService (ref), TeamEventRewards_UI (ref), u2 (ref), Rewards_HarvestMoon (ref), TweenService (ref), Size (ref)
        Field_Of_View_Module.Change_FOV(p91 and 60 or 70);
        Blur_Module.Blur(p91 and 15 or 0, 0.1);

        if not p91 then
            ContextActionService:UnbindAction("TeamEventRewardsBlockZoom");
        end;

        TeamEventRewards_UI.Enabled = p91;

        if p91 and u2.State.Visible then
            local v92 = TeamEventRewards_UI;

            for _, v in { "RewardsWithQuests", "Rewards", "Rewards_HarvestMoon_OLD", "Quests", "Quests_Old" } do
                local v93 = v92:FindFirstChild(v);

                if v93 then
                    v93.Visible = false;
                end;
            end;

            Rewards_HarvestMoon.Visible = true;
            Rewards_HarvestMoon.Size = UDim2.fromScale(0, 0);
            TweenService:Create(Rewards_HarvestMoon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = Size
            }):Play();
        end;
    end);
    DataService:GetPathSignal("TeamEventData/@"):Connect(function() -- Line: 896
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    workspace:GetAttributeChangedSignal("HarvestMoonTeamRewards"):Connect(function() -- Line: 900
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    TeamEventController.DataUpdated:Connect(function() -- Line: 904
        -- upvalues: u2 (ref)
        u2:Render();
    end);
    u2:Render();
end;

task.spawn(function() -- Line: 911
    -- upvalues: u2 (copy)
    u2:Start();
end);

return u2;