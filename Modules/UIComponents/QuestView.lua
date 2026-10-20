-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.Signal);
local Notification = require(ReplicatedStorage.Modules.Notification);
local Claim = game.ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Quests").Claim;
local u1 = {};
u1.__index = u1;

function u1.new(p2: table) -- Line: 34
    -- upvalues: u1 (copy), Trove (copy)
    local v3 = setmetatable({}, u1);
    v3._parent = p2.Parent;
    v3._template = p2.Template;
    v3._containerID = p2.ContainerID;
    v3._autoUpdate = p2.AutoUpdate == nil and true or p2.AutoUpdate;
    v3._showCompleted = p2.ShowCompleted == nil and true or p2.ShowCompleted;
    v3._IsIndividual = false;
    v3._trove = Trove.new();
    v3._refreshTrove = Trove.new();
    v3._cachedCells = {};

    if v3._autoUpdate then
        v3:_setupAutoUpdate();
    end;

    if v3._containerID then
        v3:Rebuild();
    end;

    return v3;
end;

function u1.SetContainer(p4: table, p5: string?) -- Line: 60
    p4._containerID = p5;
    p4:Rebuild();
end;

function u1.GetContainer(p6) -- Line: 66
    return p6._containerID;
end;

function u1.Rebuild(p7) -- Line: 71
    -- upvalues: QuestsController (copy)
    p7:_clearCurrentQuests();

    if not p7._containerID then
        return;
    end;

    local ContainerFromId = QuestsController:GetContainerFromId(p7._containerID);

    if not ContainerFromId then
        warn((`[QuestView] No quest container found for ID: {p7._containerID}`));

        return;
    end;

    if ContainerFromId.IsIndividual then
        p7._IsIndividual = true;
    end;

    p7._refreshTrove:Clean();

    for _, v in ContainerFromId.Quests do
        local v8 = p7:_getOrCreateCell(v.Id);
        p7:_configureCell(v.Id, v8);
        v8.Parent = p7._parent;
    end;

    local v9 = {};

    for _, v in ContainerFromId.Quests do
        v9[v.Id] = true;
    end;

    for i, v in p7._cachedCells do
        if not v9[i] then
            v:Destroy();
            p7._cachedCells[i] = nil;
        end;
    end;
end;

function u1.UpdateQuest(p10: table, p11: string) -- Line: 119
    local v12 = p10._cachedCells[p11];
    p10._refreshTrove:Clean();

    if v12 then
        p10:_configureCell(p11, v12);
    end;
end;

function u1.AreAllQuestsCompleted(p13) -- Line: 128
    -- upvalues: QuestsController (copy)
    if not p13._containerID then
        return false;
    end;

    local ContainerFromId = QuestsController:GetContainerFromId(p13._containerID);

    if not ContainerFromId then
        return false;
    end;

    for _, v in ContainerFromId.Quests do
        if not v.Completed then
            return false;
        end;
    end;

    return true;
end;

function u1.GetProgress(p14) -- Line: 148
    -- upvalues: QuestsController (copy)
    if not p14._containerID then
        return {
            Completed = 0,
            Total = 0,
            Percentage = 0
        };
    end;

    local ContainerFromId = QuestsController:GetContainerFromId(p14._containerID);

    if not ContainerFromId then
        return {
            Completed = 0,
            Total = 0,
            Percentage = 0
        };
    end;

    local v15 = #ContainerFromId.Quests;
    local v16 = 0;

    for _, v in ContainerFromId.Quests do
        if v.Completed then
            v16 = v16 + 1;
        end;
    end;

    return {
        Completed = v16,
        Total = v15,
        Percentage = v15 <= 0 and 0 or v16 / v15 * 100
    };
end;

function u1.Destroy(p17) -- Line: 177
    p17._trove:Destroy();
    p17._refreshTrove:Destroy();

    for _, v in p17._cachedCells do
        v:Destroy();
    end;

    p17._cachedCells = {};

    if p17.OnQuestCompleted then
        p17.OnQuestCompleted:Destroy();
    end;
end;

function u1._setupAutoUpdate(u18) -- Line: 191
    -- upvalues: DataService (copy)
    u18._trove:Add(DataService:GetPathSignal("QuestContainers/@"):Connect(function() -- Line: 193
        -- upvalues: u18 (copy)
        u18:Rebuild();
    end));
end;

function u1._configureCellIndividual(u19: table, u20: string, p21: userdata) -- Line: 199
    -- upvalues: QuestsController (copy), Notification (copy), Claim (copy)
    local QuestFromId = QuestsController:GetQuestFromId(u20);

    if not QuestFromId then
        return;
    end;

    local u22 = QuestsController:GetQuest(QuestFromId.Type):Display(QuestFromId.Progress, QuestFromId.Target, QuestFromId.Arguments);
    local u23 = QuestFromId.Progress >= QuestFromId.Target;
    local u24 = QuestFromId.Claimed or false;
    local v25 = QuestFromId.ImageId and p21.Contents:FindFirstChild("QuestImage");

    if v25 then
        v25.Image = QuestFromId.ImageId;
    end;

    local ClaimButton = p21.Contents:FindFirstChild("ClaimButton");

    if ClaimButton and QuestFromId.Rewards then
        ClaimButton.ImageRectOffset = u23 and Vector2.new(0, 258) or Vector2.new(0, 602);
        ClaimButton.Amount.TextLabel.UIStroke.Color = u23 and Color3.fromRGB(28, 58, 21) or Color3.fromRGB(56, 56, 57);
        ClaimButton.Amount.TextLabel.Text = `x{QuestFromId.Rewards[1].Data.Amount}`;

        if u24 then
            ClaimButton.Visible = false;
        end;

        u19._refreshTrove:Add(ClaimButton.Activated:Connect(function() -- Line: 238
            -- upvalues: u23 (copy), Notification (ref), u22 (copy), u24 (copy), u19 (copy), Claim (ref), u20 (copy)
            if u23 then
                if u23 and (not u24 and u19._containerID) then
                    Claim:FireServer(u19._containerID, u20);
                end;

                return;
            end;

            Notification:CreateNotification((`{u22.Title}`));
        end));
    end;

    local ClaimedDisplay = p21.Contents:FindFirstChild("ClaimedDisplay");

    if ClaimedDisplay then
        ClaimedDisplay.Visible = u24 or false;
    end;
end;

function u1._configureCell(p26: table, p27: string, p28: userdata) -- Line: 262
    -- upvalues: QuestsController (copy)
    local QuestFromId = QuestsController:GetQuestFromId(p27);

    if not QuestFromId then
        return;
    end;

    local v29 = QuestsController:GetQuest(QuestFromId.Type):Display(QuestFromId.Progress, QuestFromId.Target, QuestFromId.Arguments);
    local v30 = QuestFromId.Progress >= QuestFromId.Target;
    local v31 = v30 and "Completed!" or v29.Bar;
    p28.Contents.TASK_NAME.Text = v29.Title;
    p28.Contents.Progress.ProgressBar.PROGRESS.Text = v31;
    p28.Contents.Progress.ProgressBar.PROGRESS_SHADOW.Text = v31;
    local math_clamp_ret = math.clamp(QuestFromId.Progress / QuestFromId.Target, 0, 1);
    p28.Contents.Progress.ProgressBar.Bar_Actual.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
    p28.Contents.Progress.Details.Underglow.Size = UDim2.new(math_clamp_ret * 1.296, 0, math_clamp_ret * 6.504, 0);

    if p26._IsIndividual then
        p26:_configureCellIndividual(p27, p28);
    end;

    if p26._showCompleted or not v30 then
        p28.Visible = true;

        return;
    end;

    p28.Visible = false;
end;

function u1._getOrCreateCell(p32: table, p33: string) -- Line: 297
    if p32._cachedCells[p33] then
        return p32._cachedCells[p33];
    end;

    local v34 = p32._template:Clone();
    p32._cachedCells[p33] = v34;

    return v34;
end;

function u1._clearCurrentQuests(p35) -- Line: 307
    for _, v in p35._cachedCells do
        v.Parent = nil;
    end;
end;

return u1;