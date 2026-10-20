-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local FairyMilestonesData = require(ReplicatedStorage.Data.Events.FairyEvent.FairyMilestonesData);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local RestartFairyTrack = ReplicatedStorage.GameEvents.Events.FairyEvent.RestartFairyTrack;
local MakeFairyWish = ReplicatedStorage.GameEvents.Events.FairyEvent.MakeFairyWish;
local OpenFairyUI = ReplicatedStorage.GameEvents.Events.FairyEvent.OpenFairyUI;
local FairyQuests_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("FairyEvent"):WaitForChild("FairyQuests_UI");
local Main = FairyQuests_UI.Frame.Main;
local Header = Main.Holder.Header;
local Tasks = Main.Holder.Tasks;
local List = Tasks.List;
local Restart = Tasks.Restart;
local RestartFairyPoints = Restart.RestartQuestsWidget.RestartButtons.RestartFairyPoints;
local RestartRobux = Restart.RestartQuestsWidget.RestartButtons.RestartRobux;
local SkipTierRobux = Header.SkipTierRobux;
local MakeAWish = Tasks.MakeAWish;
local MakeAWish2 = MakeAWish.MakeAWishWidget.RestartButtons.MakeAWish;
local SENSOR = Header.Exit.SENSOR;
local Bar = Main.Bar;
local Fill = Bar.Fill;
local Resets = Header.Resets;
local u2 = {
    Bar.PRIZE_1,
    Bar.PRIZE_2,
    Bar.PRIZE_3,
    Bar.PRIZE_4,
    Bar.FinalPrize
};
local Details = Bar.Details;
local Segment = List.UIListLayout.Segment;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};

local function IsMaxFairyLevel(p8) -- Line: 76
    -- upvalues: FairyMilestonesData (copy)
    return p8.FairyEvent.FairyQuests.WishLevel >= FairyMilestonesData.MaxWishLevel;
end;

local function DoesUnclaimedWishExist(p9) -- Line: 80
    return p9.FairyEvent.FairyQuests.CompletionSource ~= nil;
end;

local function GetProgress() -- Line: 85
    -- upvalues: DataService (copy), FairyMilestonesData (copy), QuestsController (copy)
    local Data = DataService:GetData();

    if not Data then
        return 0;
    end;

    local MaxWishLevel = FairyMilestonesData.MaxWishLevel;
    local v10 = Data.FairyEvent.FairyQuests.WishLevel / MaxWishLevel;
    local v11 = #Data.FairyEvent.FairyQuests.Containers;
    local v12 = 0;
    local v13 = true;

    for _, v in Data.FairyEvent.FairyQuests.Containers do
        local ContainerFromId = QuestsController:GetContainerFromId((tostring(v)));

        if ContainerFromId then
            for _, v2 in ContainerFromId.Quests do
                v12 = v12 + v2.Progress / v2.Target / v11;

                if v2.Completed == false then
                    v13 = false;
                end;
            end;
        end;
    end;

    if v13 then
        return v10;
    end;

    return v10 + v12 / MaxWishLevel;
end;

local function ConfigureQuestCell(p14: string, p15: any) -- Line: 123
    -- upvalues: QuestsController (copy)
    local ContainerFromId = QuestsController:GetContainerFromId(p14);

    if not ContainerFromId then
        warn((`No quest container: {p14}`));

        return;
    end;

    local v16 = ContainerFromId.Quests[1];
    local Quest = QuestsController:GetQuest(v16.Type);

    if not Quest then
        warn((`No quest info: {v16.Type}`));

        return;
    end;

    local v17 = Quest:Display(v16.Progress, v16.Target, v16.Arguments);
    local v18 = v16.Progress >= v16.Target and "Completed!" or v17.Bar;
    p15.TASK_NAME.Text = v17.Title;
    p15.Progress.ProgressBar.PROGRESS.Text = v18;
    p15.Progress.ProgressBar.PROGRESS_SHADOW.Text = v18;
    local math_clamp_ret = math.clamp(v16.Progress / v16.Target, 0, 1);
    p15.Progress.ProgressBar.Bar_Actual.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
    p15.Progress.Details.Underglow.Size = UDim2.new(math_clamp_ret * 1.296, 0, math_clamp_ret * 6.504, 0);
end;

local function GetCellForQuest(p19: string) -- Line: 153
    -- upvalues: u3 (copy), Segment (copy)
    if u3[p19] then
        return u3[p19];
    end;

    local v20 = Segment:Clone();
    u3[p19] = v20;

    return v20;
end;

local function AnimatePrize(u21: userdata, p22: string) -- Line: 164
    -- upvalues: u5 (copy), TweenService (copy)
    local v23 = u5[u21];

    if not v23 then
        u5[u21] = u21.Size;
        v23 = u21.Size;
    end;

    if p22 == "ReadyToClaim" then
        local v24 = TweenService:Create(u21, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = v23
        });
        u21.Size = v23 - UDim2.new(0.05, 0, 0.05, 0);
        v24:Play();
    end;

    if p22 == "Claimed" then
        u21.Visible = true;
        local v25 = TweenService:Create(u21, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        });
        v25.Completed:Once(function() -- Line: 198
            -- upvalues: u21 (copy)
            u21.Visible = false;
        end);
        v25:Play();
    end;

    if p22 == "Locked" then
        u21.Visible = true;
        u21.Size = UDim2.new(0, 0, 0, 0);
        TweenService:Create(u21, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = v23
        }):Play();
    end;
end;

local function AnimateFinalPrize(p26: userdata, p27: string) -- Line: 218
    -- upvalues: u5 (copy)
    if not u5[p26] then
        u5[p26] = p26.Size;
        local _ = p26.Size;
    end;
end;

local function SetPrizeButtonState(p28: userdata, p29: string) -- Line: 228
    -- upvalues: u4 (copy), u2 (copy), u5 (copy), AnimatePrize (copy)
    if u4[p28] ~= p29 then
        if p28 == u2[#u2] then
            if not u5[p28] then
                u5[p28] = p28.Size;
                local _ = p28.Size;
            end;
        else
            AnimatePrize(p28, p29);
        end;

        u4[p28] = p29;
    end;
end;

local function SetupAnimatedDetails() -- Line: 241
    -- upvalues: Details (copy), u6 (copy)
    local Children = Details:GetChildren();

    for i, v in ipairs(Children) do
        if v:IsA("ImageLabel") or v:IsA("Frame") then
            u6[v] = {
                RotationDir = i % 2 == 0 and -1 or 1,
                RotationPhase = math.random() * 3.141592653589793 * 2,
                ScalePhase = math.random() * 3.141592653589793 * 2,
                RotationSpeed = 10 + math.random() * 20,
                ScaleSpeed = 0.5 + math.random() * 1
            };
        end;
    end;

    for i, v in pairs(u6) do
        v.OriginalSize = i.Size;
    end;
end;

local function AnimateDetails(p30) -- Line: 263
    -- upvalues: u6 (copy)
    for i, v in pairs(u6) do
        if i and i.Parent then
            i.Rotation = (i.Rotation + v.RotationDir * v.RotationSpeed * p30) % 360;
            v.ScalePhase = v.ScalePhase + p30 * v.ScaleSpeed * 3.141592653589793 * 2;
            local v31 = math.sin(v.ScalePhase) * 0.1 + 1;
            i.Size = UDim2.new(v.OriginalSize.X.Scale * v31, v.OriginalSize.X.Offset * v31, v.OriginalSize.Y.Scale * v31, v.OriginalSize.Y.Offset * v31);
        end;
    end;
end;

local function BuildUI() -- Line: 287
    -- upvalues: DataService (copy), QuestsController (copy), u3 (copy), Segment (copy), List (copy), ConfigureQuestCell (copy), u2 (copy), u4 (copy), u5 (copy), TweenService (copy), Restart (copy), FairyMilestonesData (copy), MakeAWish (copy), SkipTierRobux (copy), Fill (copy), GetProgress (copy)
    local Data = DataService:GetData();

    if not Data.FairyEvent.FairyQuests then
        return;
    end;

    for _, v in Data.FairyEvent.FairyQuests.Containers do
        local v32 = tostring(v);

        if QuestsController:GetContainerFromId(v32) == nil then
            warn("Invalid Quest ID in Fairy Quest List. Skipping.");
        else
            local v33;

            if u3[v32] then
                v33 = u3[v32];
            else
                v33 = Segment:Clone();
                u3[v32] = v33;
            end;

            v33.Parent = List;
            ConfigureQuestCell(v32, v33);
        end;
    end;

    for i, _ in u3 do
        if table.find(Data.FairyEvent.FairyQuests.Containers, i) == nil then
            u3[i]:Destroy();
            u3[i] = nil;
        end;
    end;

    local WishLevel = Data.FairyEvent.FairyQuests.WishLevel;

    for i, v in u2 do
        if i <= WishLevel then
            if u4[v] ~= "ReadyToClaim" then
                if v == u2[#u2] then
                    if not u5[v] then
                        u5[v] = v.Size;
                        local _ = v.Size;
                    end;
                else
                    local v34 = u5[v];

                    if not v34 then
                        u5[v] = v.Size;
                        v34 = v.Size;
                    end;

                    local v35 = TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                        Size = v34
                    });
                    v.Size = v34 - UDim2.new(0.05, 0, 0.05, 0);
                    v35:Play();
                end;

                u4[v] = "ReadyToClaim";
            end;
        elseif u4[v] ~= "Locked" then
            if v == u2[#u2] then
                if not u5[v] then
                    u5[v] = v.Size;
                    local _ = v.Size;
                end;
            else
                local v36 = u5[v];

                if not v36 then
                    u5[v] = v.Size;
                    v36 = v.Size;
                end;

                v.Visible = true;
                v.Size = UDim2.new(0, 0, 0, 0);
                TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = v36
                }):Play();
            end;

            u4[v] = "Locked";
        end;
    end;

    local v37;

    if Data.FairyEvent.FairyQuests.WishLevel >= FairyMilestonesData.MaxWishLevel then
        v37 = Data.FairyEvent.FairyQuests.TrackCompleted;
    else
        v37 = false;
    end;

    Restart.Visible = v37;
    local v38;

    if Data.FairyEvent.FairyQuests.WishLevel <= FairyMilestonesData.MaxWishLevel and Data.FairyEvent.FairyQuests.CompletionSource ~= nil then
        v38 = not Data.FairyEvent.FairyQuests.TrackCompleted;
    else
        v38 = false;
    end;

    MakeAWish.Visible = v38;

    if MakeAWish.Visible then
        local CompletionSource = Data.FairyEvent.FairyQuests.CompletionSource;
        MakeAWish.MakeAWishWidget.TasksComplete.Text = CompletionSource == "Quests" and "Offerings Complete" or (CompletionSource == "Fountain" and "Fountain Power Full" or "???");
    end;

    local v39 = Data.FairyEvent.FairyQuests.WishLevel < FairyMilestonesData.MaxWishLevel and Data.FairyEvent.FairyQuests.CompletionSource == nil;
    SkipTierRobux.Interactable = v39;
    SkipTierRobux.Visible = v39;
    Fill.Size = UDim2.new(GetProgress(), 0, 1, 0);
end;

function u7.Start(p40) -- Line: 359
    -- upvalues: u1 (copy), SENSOR (copy), GuiController (copy), FairyQuests_UI (copy), RestartFairyPoints (copy), DataService (copy), FairyMilestonesData (copy), Notification (copy), RestartFairyTrack (copy), MakeAWish2 (copy), MakeFairyWish (copy), RestartRobux (copy), MarketController (copy), DevProductIds (copy), SkipTierRobux (copy), OpenFairyUI (copy), BuildUI (copy), RunService (copy), AnimateDetails (copy), Resets (copy), NumberUtil (copy), ItemImageFinder (copy), SetupAnimatedDetails (copy)
    u1:Add(SENSOR.Activated:Connect(function() -- Line: 361
        -- upvalues: GuiController (ref), FairyQuests_UI (ref)
        GuiController:Close(FairyQuests_UI);
    end));
    u1:Add(RestartFairyPoints.Activated:Connect(function() -- Line: 366
        -- upvalues: DataService (ref), FairyMilestonesData (ref), Notification (ref), RestartFairyTrack (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if Data.FairyEvent.FairyQuests.WishLevel < FairyMilestonesData.MaxWishLevel or Data.FairyEvent.FairyQuests.CompletionSource ~= nil then
            error("Cannot restart Fairy questline when player is not max level or has unclaimed rewards.");
        end;

        if FairyMilestonesData.RestartFairyPointsPrice > Data.SpecialCurrency.FairyPoints then
            Notification:CreateNotification("Not enough Fairy Points!");

            return;
        end;

        RestartFairyTrack:FireServer();
    end));
    u1:Add(MakeAWish2.Activated:Connect(function() -- Line: 381
        -- upvalues: DataService (ref), GuiController (ref), FairyQuests_UI (ref), MakeFairyWish (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if Data.FairyEvent.FairyQuests.CompletionSource == nil then
            error("Cannot make a wish when player has no rewards to claim");

            return;
        end;

        GuiController:Close(FairyQuests_UI);
        MakeFairyWish:FireServer();
    end));
    u1:Add(RestartRobux.Activated:Connect(function() -- Line: 395
        -- upvalues: DataService (ref), FairyMilestonesData (ref), MarketController (ref), DevProductIds (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if Data.FairyEvent.FairyQuests.WishLevel >= FairyMilestonesData.MaxWishLevel then
            MarketController:PromptPurchase(DevProductIds.ResetFairyQuests.PurchaseID, Enum.InfoType.Product);

            return;
        end;

        error("Cannot restart Fairy questline when player is not max fairy level or has unclaimed rewards.");
    end));
    u1:Add(SkipTierRobux.Activated:Connect(function() -- Line: 408
        -- upvalues: DataService (ref), FairyMilestonesData (ref), MarketController (ref), DevProductIds (ref)
        local Data = DataService:GetData();

        if Data.FairyEvent.FairyQuests.WishLevel >= FairyMilestonesData.MaxWishLevel or Data.FairyEvent.FairyQuests.CompletionSource ~= nil then
            error("Cannot use skip Fairy tier when player is max level or has unclaimed rewards.");

            return;
        end;

        MarketController:PromptPurchase(DevProductIds.SkipFairyQuests.PurchaseID, Enum.InfoType.Product);
    end));
    u1:Add(OpenFairyUI.OnClientEvent:Connect(function() -- Line: 420
        -- upvalues: BuildUI (ref), GuiController (ref), FairyQuests_UI (ref)
        task.wait(0.2);
        BuildUI();
        GuiController:Open(FairyQuests_UI);
    end));
    u1:Add(RunService.RenderStepped:Connect(AnimateDetails));
    local PathSignal = DataService:GetPathSignal("FairyEvent/FairyQuests/@");
    u1:Add(assert(PathSignal, "Failed to listen for Fairy Quests"):Connect(BuildUI));
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    u1:Add(assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(BuildUI));
    u1:Add(task.spawn(function() -- Line: 433
        -- upvalues: FairyMilestonesData (ref), Resets (ref), NumberUtil (ref)
        while true do
            local v41 = FairyMilestonesData:TimeUntilReset();
            local math_max_ret = math.max(0, v41);
            Resets.Text = "Resets in " .. NumberUtil.toHMS(math_max_ret);
            task.wait(1);
        end;
    end));
    u1:Add(task.spawn(function() -- Line: 445
        -- upvalues: BuildUI (ref)
        while true do
            task.wait(3);
            BuildUI();
        end;
    end));
    RestartFairyPoints.In_Stock.Cost_Text.Text = `{FairyMilestonesData.RestartFairyPointsPrice}`;
    RestartFairyPoints.In_Stock.CurrencyIcon.Image = ItemImageFinder("FairyPoints", "Currency");
    RestartRobux.Price.Text = tostring(FairyMilestonesData.RestartRobuxPrice) .. "";
    SkipTierRobux.Price.Text = "Skip: " .. tostring(FairyMilestonesData.SkipTierRobuxPrice) .. "";
    SetupAnimatedDetails();
    BuildUI();
    FairyQuests_UI.Enabled = false;
end;

EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    Script = script,

    OnStart = function() -- Line: 469, Name: OnStart
        -- upvalues: u7 (copy)
        task.spawn(u7.Start, u7);
    end,

    OnStop = function() -- Line: 470, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u7;