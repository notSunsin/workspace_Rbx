-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Trove = require(ReplicatedStorage.Modules.Trove);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DataService = require(ReplicatedStorage.Modules.DataService);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DinoMilestonesData = require(ReplicatedStorage.Data.Events.PrehistoricEvent.DinoMilestonesData);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local u1 = Trove.new();
local Config = GameConfigController:GetConfig("PrehistoricEventConfig");
workspace:GetAttributeChangedSignal("PrehistoricEventConfig"):Connect(function() -- Line: 22
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("PrehistoricEventConfig");
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local RestartDinoTrack = GameEvents.Events.PrehistoricEvent.RestartDinoTrack;
local ClaimDinoQuest = GameEvents.Events.PrehistoricEvent.ClaimDinoQuest;
local PlayerGui = Players.LocalPlayer.PlayerGui;
local DinoQuests_UI = PlayerGui.Events.PrehistoricEvent:WaitForChild("DinoQuests_UI");
local AnimationUI = PlayerGui.Events.PrehistoricEvent:WaitForChild("AnimationUI");
local Holder = DinoQuests_UI.Frame.Main.Holder;
local WeeklyPrize = DinoQuests_UI.Frame.Main.WeeklyPrize;
local Segment = Holder.UIListLayout.Segment;
local FreqSegment = Holder.UIListLayout.FreqSegment;
local u2 = {};

local function toV3(p3) -- Line: 47
    return vector.create(p3.X, p3.Y);
end;

local function quadraticBezier(p4: number, p5: vector, p6: vector, p7: vector) -- Line: 51
    return (1 - p4) ^ 2 * p5 + (1 - p4) * 2 * p4 * p6 + p4 ^ 2 * p7;
end;

local function getCurrentDay(p8: number) -- Line: 55
    return (p8 + 14400) // 43200;
end;

local function getResetTime(p9: number) -- Line: 59
    return ((p9 + 14400) // 43200 + 1) * 43200 - 14400;
end;

function u2.Start(p10) -- Line: 63
    -- upvalues: GuiController (copy), DinoQuests_UI (copy), u1 (copy), MarketController (copy), WeeklyPrize (copy), Comma_Module (copy), DinoMilestonesData (copy), Config (ref), RestartDinoTrack (copy), DataService (copy), FastTween (copy), QuestsController (copy), FreqSegment (copy), Segment (copy), Holder (copy), ClaimDinoQuest (copy), SoundService (copy), AnimationUI (copy), RunService (copy), NumberUtil (copy)
    GuiController:UsePopupAnims(DinoQuests_UI);
    u1:Add(DinoQuests_UI.Frame.Main.Header.Exit.SENSOR.Activated:Connect(function() -- Line: 66
        -- upvalues: GuiController (ref), DinoQuests_UI (ref)
        GuiController:Close(DinoQuests_UI);
    end));
    u1:Add(DinoQuests_UI.Frame.Main.Header.Skip.Activated:Connect(function() -- Line: 70
        -- upvalues: MarketController (ref)
        MarketController:PromptPurchase(3322837511, Enum.InfoType.Product);
    end));
    WeeklyPrize.Restart.Frame.SkipRobux.Txt.Text = `{utf8.char(57346)}{Comma_Module.Comma((`{DinoMilestonesData.RestartRobuxPrice}`))}`;
    u1:Add(WeeklyPrize.Restart.Frame.SkipRobux.Activated:Connect(function() -- Line: 75
        -- upvalues: MarketController (ref), DinoMilestonesData (ref)
        MarketController:PromptPurchase(DinoMilestonesData.RestartRobuxProduct, Enum.InfoType.Product);
    end));
    WeeklyPrize.Restart.Frame.SkipSheckles.Txt.Text = `{Comma_Module.Comma((`{Config.RestartQuestTrackPrice}`))}¢`;
    u1:Add(WeeklyPrize.Restart.Frame.SkipSheckles.Activated:Connect(function() -- Line: 80
        -- upvalues: RestartDinoTrack (ref)
        RestartDinoTrack:FireServer();
    end));
    local u11 = {};

    local function removeQuestFromRender(p12) -- Line: 86
        -- upvalues: u11 (copy)
        local v13 = u11[p12];

        if v13 then
            v13:Destroy();
            u11[p12] = nil;
        end;
    end;

    local u14 = true;
    local u15 = nil;
    local u16 = nil;

    local function updateMilestones() -- Line: 99
        -- upvalues: DataService (ref), DinoMilestonesData (ref), u16 (ref), u15 (ref), FastTween (ref), WeeklyPrize (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local Progress = Data.PrehistoricEventData.DinoQuests.Milestone.Progress;
        local v17 = math.floor(Progress) / DinoMilestonesData.MaxProgress;
        local math_clamp_ret = math.clamp(v17, 0, 1);

        if u16 == math_clamp_ret then
            return;
        end;

        u16 = math_clamp_ret;
        local v18 = u15 ~= Progress;
        u15 = Progress;
        FastTween(WeeklyPrize.Bar.Fill, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        });
        local u19 = v18 and WeeklyPrize.Bar:FindFirstChild((`PRIZE_{Progress}`));

        if u19 then
            local Position = u19.Position;
            task.delay(0.1, function() -- Line: 122
                -- upvalues: FastTween (ref), u19 (copy), Position (copy)
                FastTween(u19, TweenInfo.new(0.03), {
                    Position = Position - UDim2.fromScale(0, 0.4)
                }).Completed:Wait();
                FastTween(u19, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = Position
                });
            end);
        end;

        task.wait(0.5);
        local v20 = Data.PrehistoricEventData.DinoQuests.Milestone.Progress >= DinoMilestonesData.MaxProgress;
        WeeklyPrize.Main.Visible = not v20;
        WeeklyPrize.Restart.Visible = v20;
    end;

    local function updateQuests() -- Line: 141
        -- upvalues: DataService (ref), u11 (copy), QuestsController (ref), FreqSegment (ref), Segment (ref), Holder (ref), u14 (ref), ClaimDinoQuest (ref), WeeklyPrize (ref), SoundService (ref), AnimationUI (ref), RunService (ref), FastTween (ref), updateMilestones (copy), DinoQuests_UI (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local DinoQuests = Data.PrehistoricEventData.DinoQuests;

        if not DinoQuests then
            for i in u11 do
                local v21 = u11[i];

                if v21 then
                    v21:Destroy();
                    u11[i] = nil;
                end;
            end;

            table.clear(u11);

            return;
        end;

        local v22 = {};
        local v23 = false;

        for i, v in DinoQuests.Containers do
            local ContainerFromId = QuestsController:GetContainerFromId(v);

            if ContainerFromId then
                local v24 = ContainerFromId.Rewards[1];
                local v25;

                if v24 then
                    v25 = QuestsController:GetRewardInfo(v24.Type);
                else
                    v25 = nil;
                end;

                local u26 = i;

                for i2, v2 in ContainerFromId.Quests do
                    local Quest = QuestsController:GetQuest(v2.Type);

                    if Quest then
                        local v27 = u11[v2.Id];

                        if not v27 then
                            local u28;

                            if ContainerFromId.Container == "DinoFrequent" then
                                u28 = FreqSegment:Clone();
                            else
                                u28 = Segment:Clone();
                            end;

                            if v25 and v25.DisplayIcon then
                                u28.IconHolder.ImageLabel.Image = v25:DisplayIcon(v24) or "";
                            else
                                u28.IconHolder.ImageLabel.Image = "";
                            end;

                            u28.LayoutOrder = i2 + 1;
                            u28.Parent = Holder;
                            local u29 = true;
                            u28.Claim.Activated:Connect(function() -- Line: 189
                                -- upvalues: u29 (ref), u14 (ref), ClaimDinoQuest (ref), u26 (copy), u28 (ref), WeeklyPrize (ref), SoundService (ref), AnimationUI (ref), RunService (ref), FastTween (ref), updateMilestones (ref)
                                if not u29 then
                                    return;
                                end;

                                u29 = false;
                                u14 = false;
                                local success, result = pcall(function() -- Line: 195
                                    -- upvalues: ClaimDinoQuest (ref), u26 (ref)
                                    return ClaimDinoQuest:InvokeServer(u26);
                                end);
                                u29 = true;

                                if not (success and result) then
                                    u14 = true;

                                    return;
                                end;

                                local CHECKMARK_ICON = u28.CHECKMARK_ICON;
                                local CheckmarkIcon = WeeklyPrize.Bar.CheckmarkIcon;
                                u28.Claim.Visible = false;
                                CHECKMARK_ICON.Visible = true;
                                SoundService.Purchase:Play();
                                local u30 = CHECKMARK_ICON:Clone();
                                u30.Name = "_animation";
                                u30.Visible = false;
                                u30.Position = UDim2.fromOffset(0, 0);
                                u30.Size = UDim2.fromOffset(0, 0);
                                u30.Parent = AnimationUI;
                                RunService.PreRender:Wait();
                                local u31 = 0;
                                local u32 = nil;
                                u32 = RunService.PreRender:Connect(function(p33: number) -- Line: 225
                                    -- upvalues: u31 (ref), CHECKMARK_ICON (copy), CheckmarkIcon (copy), u30 (copy), u32 (ref), FastTween (ref), u14 (ref), updateMilestones (ref)
                                    u31 = u31 + p33;
                                    local math_clamp_ret = math.clamp(u31 / 1.5, 0, 1);
                                    local AbsoluteSize = CHECKMARK_ICON.AbsoluteSize;
                                    local vector_create_ret = vector.create(AbsoluteSize.X, AbsoluteSize.Y);
                                    local AbsoluteSize2 = CheckmarkIcon.AbsoluteSize;
                                    local vector_create_ret2 = vector.create(AbsoluteSize2.X, AbsoluteSize2.Y);
                                    local AbsolutePosition = CHECKMARK_ICON.AbsolutePosition;
                                    local v34 = vector.create(AbsolutePosition.X, AbsolutePosition.Y) + vector_create_ret * 0.5;
                                    local AbsolutePosition2 = CheckmarkIcon.AbsolutePosition;
                                    local v35 = vector.create(AbsolutePosition2.X, AbsolutePosition2.Y) + vector_create_ret2 * 0.5 + vector.create(0, vector_create_ret2.y * 1.25);
                                    local vector_create_ret3 = vector.create(v34.x + (v35.x - v34.x) * 0.5, v34.y - CHECKMARK_ICON.AbsoluteSize.Y * 5);
                                    local v36 = vector_create_ret * (1 - math_clamp_ret * math_clamp_ret);
                                    local v37 = (1 - math_clamp_ret) ^ 2 * v34 + (1 - math_clamp_ret) * 2 * math_clamp_ret * vector_create_ret3 + math_clamp_ret ^ 2 * v35;
                                    u30.Size = UDim2.fromOffset(v36.x, v36.y);
                                    u30.Position = UDim2.fromOffset(v37.x + v36.x * 0.5, v37.y + v36.y * 0.5);
                                    u30.Visible = true;

                                    if math_clamp_ret >= 1 and (u32 and u32.Connected) then
                                        u30:Destroy();
                                        CheckmarkIcon.UIScale.Scale = 1.25;
                                        FastTween(CheckmarkIcon.UIScale, TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                            Scale = 1
                                        });
                                        u32:Disconnect();
                                        u32 = nil;
                                        u14 = true;
                                        updateMilestones();
                                    end;
                                end);
                            end);
                            v27 = u28;
                            u11[v2.Id] = v27;
                        end;

                        v22[v2.Id] = true;
                        local v38 = Quest:Display(v2.Progress, v2.Target, v2.Arguments);
                        v27.TASK_NAME.Text = v38.Title;

                        if ContainerFromId.Container == "DinoFrequent" then
                            v27.TASK_NAME.Text = `<i>Bonus Quest:</i> {v38.Title}`;
                        end;

                        v27.PROGRESS.Text = v2.Completed and "Completed!" or v38.Bar;
                        v27.CHECKMARK_ICON.Visible = v2.Completed and ContainerFromId.Redeemed;
                        v27.Claim.Visible = v2.Completed and not ContainerFromId.Redeemed;

                        if not v2.Completed then
                            v23 = true;
                        end;
                    end;
                end;
            end;
        end;

        for i in u11 do
            if v22[i] ~= true then
                local v39 = u11[i];

                if v39 then
                    v39:Destroy();
                    u11[i] = nil;
                end;
            end;
        end;

        DinoQuests_UI.Frame.Main.Header.Skip.Visible = v23;
    end;

    local function update() -- Line: 292
        -- upvalues: u14 (ref), updateMilestones (copy), updateQuests (copy)
        if u14 then
            updateMilestones();
        end;

        updateQuests();
    end;

    task.spawn(function() -- Line: 299
        -- upvalues: DataService (ref), DinoMilestonesData (ref), QuestsController (ref), WeeklyPrize (ref)
        if not DataService:GetData() then
            return;
        end;

        for i, v in DinoMilestonesData.Rewards do
            local RewardInfo = QuestsController:GetRewardInfo(v.Type);

            if RewardInfo then
                local v40 = WeeklyPrize.Bar:FindFirstChild((`PRIZE_{i}`));

                if not v40 then
                    if i == DinoMilestonesData.MaxProgress then
                        v40 = WeeklyPrize.Bar.FinalPrize.InnerDetail.FINAL_PRIZE_ICON;
                    else
                        v40 = nil;
                    end;
                end;

                if v40 then
                    v40.Image = RewardInfo.DisplayIcon and (RewardInfo:DisplayIcon(v) or "") or "";

                    if type(v.Data) == "table" and type(v.Data.Amount) == "number" then
                        local Quantity = v40:FindFirstChild("Quantity");

                        if Quantity then
                            Quantity.Text = `x{v.Data.Amount}`;
                            Quantity.Visible = v.Data.Amount > 1;
                        end;
                    end;
                end;
            end;
        end;
    end);
    task.spawn(update);
    local PathSignal = DataService:GetPathSignal("PrehistoricEventData/@");
    u1:Add(assert(PathSignal, "Failed to listen for Dino Quests"):Connect(update));
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    u1:Add(assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(update));
    u1:Add(task.spawn(function() -- Line: 329
        -- upvalues: DinoQuests_UI (ref), NumberUtil (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            DinoQuests_UI.Frame.Main.Header.Resets.Text = `Resets in {NumberUtil.compactFormat(((ServerTimeNow + 14400) // 43200 + 1) * 43200 - 14400 - ServerTimeNow)}`;
            task.wait(1);
        end;
    end));
end;

local u41 = false;
EventRotationController.EventUpdated:Connect(function(p42: string, p43: string) -- Line: 340, Name: OnEventUpdated
    -- upvalues: u1 (copy), u41 (ref), u2 (copy)
    if p43 ~= "PrehistoricEvent" then
        u1:Clean();
        u41 = false;

        return;
    end;

    if u41 then
        return;
    end;

    u41 = true;
    u1:Clean();
    task.spawn(u2.Start, u2);
end);

return u2;