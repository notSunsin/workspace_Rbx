-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("PirateQuestConfig");
workspace:GetAttributeChangedSignal("PirateQuestConfig"):Connect(function() -- Line: 23
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("PirateQuestConfig");
end);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.NPCDialogueController);
require(ReplicatedStorage.Top_Text);
local GlobalUpdateTime = game:GetService("ReplicatedFirst"):WaitForChild("GlobalUpdateTime");

local function EndHighTideTime() -- Line: 41
    -- upvalues: GlobalUpdateTime (copy)
    local Value = GlobalUpdateTime.Value;

    return Value > 1785616200 and 1785616200 or Value;
end;

local function HighTideDisabled() -- Line: 48
    -- upvalues: GlobalUpdateTime (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Value = GlobalUpdateTime.Value;

    return (Value > 1785616200 and 1785616200 or Value) <= ServerTimeNow;
end;

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local SFX = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("PirateQuest"):WaitForChild("SFX");
local PirateQuest_UI = PlayerGui:WaitForChild("PirateQuest_UI");
GuiController:GetStateForGui(PirateQuest_UI).ChangeEnabled:Set(true);
local Quests2 = PirateQuest_UI:WaitForChild("Quests");
local Slots = Quests2.Main.Main.Slots;
local Title = Quests2.Main.Main.Timer.Fill.Title;
local skipQuestsButton = Quests2.Main.Main.skipQuestsButton;
local Close = Quests2.Main.Header.Close;
local QuestTemplate = script:WaitForChild("QuestTemplate");
local u1 = {};
local u2 = nil;
local u3 = {};
local u4 = { "Easy", "Medium", "Hard" };

local function getSecondsUntilRefresh() -- Line: 78
    -- upvalues: Config (ref)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v5 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;

    return math.max(v5, 0);
end;

local function formatTime(p6: number) -- Line: 84
    local math_floor_ret = math.floor(p6 + 0.5);
    local math_max_ret = math.max(math_floor_ret, 0);
    local math_floor_ret2 = math.floor(math_max_ret / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
    local v7 = math_max_ret % 60;

    if math_floor_ret2 > 0 then
        return string.format("%d:%02d:%02d", math_floor_ret2, math_floor_ret3, v7);
    end;

    return string.format("%d:%02d", math_floor_ret3, v7);
end;

local function getQuestData() -- Line: 95
    -- upvalues: u2 (ref)
    return u2 and u2.PirateQuestData or nil;
end;

local function getContainer() -- Line: 99
    -- upvalues: u2 (ref)
    local v8 = u2 and u2.PirateQuestData or nil;

    if not (v8 and (v8.ContainerId and v8.ContainerId ~= "")) then
        return nil;
    end;

    if u2.QuestContainers then
        return u2.QuestContainers[v8.ContainerId];
    end;

    return nil;
end;

local function questTitle(p9) -- Line: 107
    -- upvalues: Quests (copy)
    local v10 = Quests[p9.Type];

    if v10 and v10.Display then
        local success, result = pcall(v10.Display, v10, p9.Progress, p9.Target, p9.Arguments);

        if success and (result and result.Title) then
            return result.Title;
        end;
    end;

    return p9.Type;
end;

local function questBar(p11) -- Line: 118
    -- upvalues: Quests (copy)
    local v12 = Quests[p11.Type];

    if v12 and v12.Display then
        local success, result = pcall(v12.Display, v12, p11.Progress, p11.Target, p11.Arguments);

        if success and (result and result.Bar) then
            return result.Bar;
        end;
    end;

    return `{p11.Progress}/{p11.Target}`;
end;

local function tierRewardForIndex(p13: number) -- Line: 129
    -- upvalues: Config (ref), u4 (copy)
    local v14 = Config.TIER_REWARDS or {};
    local v15 = u4[p13];

    return v15 and v14[v15] or 0;
end;

local function allComplete() -- Line: 135
    -- upvalues: u2 (ref)
    local v16 = u2 and u2.PirateQuestData or nil;
    local v17;

    if v16 and (v16.ContainerId and v16.ContainerId ~= "") and u2.QuestContainers then
        v17 = u2.QuestContainers[v16.ContainerId];
    else
        v17 = nil;
    end;

    if not (v17 and (v17.Quests and #v17.Quests ~= 0)) then
        return false;
    end;

    for _, v in v17.Quests do
        if not v.Completed then
            return false;
        end;
    end;

    return true;
end;

function u1.PromptSkip(p18) -- Line: 148
    -- upvalues: Config (ref), MarketController (copy)
    local SKIP_QUESTS_PRODUCT_ID = Config.SKIP_QUESTS_PRODUCT_ID;

    if SKIP_QUESTS_PRODUCT_ID and SKIP_QUESTS_PRODUCT_ID > 0 then
        MarketController:PromptPurchase(SKIP_QUESTS_PRODUCT_ID, Enum.InfoType.Product);

        return;
    end;

    warn("PirateQuestController | SKIP_QUESTS_PRODUCT_ID not configured");
end;

local function removeQuest(p19) -- Line: 157
    -- upvalues: u3 (copy)
    local v20 = u3[p19];

    if v20 then
        v20:Destroy();
        u3[p19] = nil;
    end;
end;

local function updateButton() -- Line: 165
    -- upvalues: u2 (ref), skipQuestsButton (copy)
    local v21 = u2 and u2.PirateQuestData or nil;
    local v22;

    if v21 and (v21.ContainerId and v21.ContainerId ~= "") and u2.QuestContainers then
        v22 = u2.QuestContainers[v21.ContainerId];
    else
        v22 = nil;
    end;

    local v23;

    if v22 == nil or v22.Quests == nil then
        v23 = false;
    else
        v23 = #v22.Quests > 0;
    end;

    local v24 = u2 and u2.PirateQuestData or nil;
    local v25;

    if v24 and (v24.ContainerId and v24.ContainerId ~= "") and u2.QuestContainers then
        v25 = u2.QuestContainers[v24.ContainerId];
    else
        v25 = nil;
    end;

    local v26;

    if v25 and (v25.Quests and #v25.Quests ~= 0) then
        v26 = true;

        for _, v in v25.Quests do
            if not v.Completed then
                v26 = false;
                break;
            end;
        end;
    else
        v26 = false;
    end;

    if v23 then
        v23 = not v26;
    end;

    skipQuestsButton.Visible = v23;
end;

local function updateQuests() -- Line: 173
    -- upvalues: u2 (ref), u3 (copy), skipQuestsButton (copy), Quests (copy), QuestTemplate (copy), Slots (copy), Config (ref), u4 (copy)
    local v27 = u2 and u2.PirateQuestData or nil;
    local v28;

    if v27 and (v27.ContainerId and v27.ContainerId ~= "") and u2.QuestContainers then
        v28 = u2.QuestContainers[v27.ContainerId];
    else
        v28 = nil;
    end;

    if not (v28 and v28.Quests) then
        for i in u3 do
            local v29 = u3[i];

            if v29 then
                v29:Destroy();
                u3[i] = nil;
            end;
        end;

        local v30 = u2 and u2.PirateQuestData or nil;
        local v31;

        if v30 and (v30.ContainerId and v30.ContainerId ~= "") and u2.QuestContainers then
            v31 = u2.QuestContainers[v30.ContainerId];
        else
            v31 = nil;
        end;

        local v32;

        if v31 == nil or v31.Quests == nil then
            v32 = false;
        else
            v32 = #v31.Quests > 0;
        end;

        local v33 = u2 and u2.PirateQuestData or nil;
        local v34;

        if v33 and (v33.ContainerId and v33.ContainerId ~= "") and u2.QuestContainers then
            v34 = u2.QuestContainers[v33.ContainerId];
        else
            v34 = nil;
        end;

        local v35;

        if v34 and (v34.Quests and #v34.Quests ~= 0) then
            v35 = true;

            for _, v in v34.Quests do
                if not v.Completed then
                    v35 = false;
                    break;
                end;
            end;
        else
            v35 = false;
        end;

        if v32 then
            v32 = not v35;
        end;

        skipQuestsButton.Visible = v32;

        return;
    end;

    for i, v in v28.Quests do
        if Quests[v.Type] then
            local v36 = u3[v.Id];

            if not v36 then
                v36 = QuestTemplate:Clone();
                v36.Visible = true;
                v36.Parent = Slots;
                u3[v.Id] = v36;
            end;

            v36.LayoutOrder = i;
            local Title2 = v36.Title;
            local v37 = Quests[v.Type];
            local v38;

            if v37 and v37.Display then
                local success, result = pcall(v37.Display, v37, v.Progress, v.Target, v.Arguments);

                if success and (result and result.Title) then
                    v38 = result.Title;
                else
                    v38 = v.Type;
                end;
            else
                v38 = v.Type;
            end;

            Title2.Text = v38;
            v36.Bar.Loader.Size = UDim2.fromScale(math.clamp(v.Progress / v.Target, 0, 1), 1);
            local Progress = v36.Bar.Progress;
            local v39;

            if v.Completed then
                v39 = "Completed!";
            else
                local v40 = Quests[v.Type];

                if v40 and v40.Display then
                    local success, result = pcall(v40.Display, v40, v.Progress, v.Target, v.Arguments);

                    if success and (result and result.Bar) then
                        v39 = result.Bar;
                    else
                        v39 = `{v.Progress}/{v.Target}`;
                    end;
                else
                    v39 = `{v.Progress}/{v.Target}`;
                end;
            end;

            Progress.Text = v39;
            local TideToken = v36:FindFirstChild("TideToken");

            if TideToken then
                local Title3 = TideToken:FindFirstChild("Title");

                if Title3 then
                    local v41 = Config.TIER_REWARDS or {};
                    local v42 = u4[i];
                    Title3.Text = "x" .. `{v42 and v41[v42] or 0}`;
                end;
            end;
        end;
    end;

    for i in u3 do
        local v43 = i;
        local v44 = false;

        for _, v in v28.Quests do
            if v.Id == v43 then
                v44 = true;
                break;
            end;
        end;

        if not v44 then
            local v45 = u3[v43];

            if v45 then
                v45:Destroy();
                u3[v43] = nil;
            end;
        end;
    end;

    local v46 = u2 and u2.PirateQuestData or nil;
    local v47;

    if v46 and (v46.ContainerId and v46.ContainerId ~= "") and u2.QuestContainers then
        v47 = u2.QuestContainers[v46.ContainerId];
    else
        v47 = nil;
    end;

    local v48;

    if v47 == nil or v47.Quests == nil then
        v48 = false;
    else
        v48 = #v47.Quests > 0;
    end;

    local v49 = u2 and u2.PirateQuestData or nil;
    local v50;

    if v49 and (v49.ContainerId and v49.ContainerId ~= "") and u2.QuestContainers then
        v50 = u2.QuestContainers[v49.ContainerId];
    else
        v50 = nil;
    end;

    local v51;

    if v50 and (v50.Quests and #v50.Quests ~= 0) then
        v51 = true;

        for _, v in v50.Quests do
            if not v.Completed then
                v51 = false;
                break;
            end;
        end;
    else
        v51 = false;
    end;

    if v48 then
        v48 = not v51;
    end;

    skipQuestsButton.Visible = v48;
end;

local function updateTimerLabel() -- Line: 220
    -- upvalues: Title (copy), formatTime (copy), Config (ref)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v52 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
    Title.Text = `Refreshes in {formatTime((math.max(v52, 0)))}`;
end;

function u1.OpenUI(p53) -- Line: 224
    -- upvalues: updateQuests (copy), Title (copy), formatTime (copy), Config (ref), GuiController (copy), PirateQuest_UI (copy)
    updateQuests();
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v54 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
    Title.Text = `Refreshes in {formatTime((math.max(v54, 0)))}`;
    GuiController:Open(PirateQuest_UI);
end;

function u1.CloseUI(p55) -- Line: 230
    -- upvalues: GuiController (copy), PirateQuest_UI (copy)
    GuiController:Close(PirateQuest_UI);
end;

function u1.Start() -- Line: 234
    -- upvalues: GlobalUpdateTime (copy), u2 (ref), DataService (copy), PirateQuest_UI (copy), Quests2 (copy), SetupButton (copy), skipQuestsButton (copy), u1 (copy), Close (copy), updateQuests (copy), Title (copy), formatTime (copy), Config (ref), SFX (copy), CollectionService (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Value = GlobalUpdateTime.Value;

    if (Value > 1785616200 and 1785616200 or Value) <= ServerTimeNow then
        return;
    end;

    u2 = DataService:GetData();
    PirateQuest_UI.Enabled = false;
    Quests2.Visible = true;
    SetupButton({
        legacy = true,
        instance = skipQuestsButton,

        onclick = function() -- Line: 247, Name: onclick
            -- upvalues: u1 (ref)
            u1:PromptSkip();
        end
    });
    SetupButton({
        legacy = true,
        instance = Close,

        onclick = function() -- Line: 249, Name: onclick
            -- upvalues: u1 (ref)
            u1:CloseUI();
        end
    });

    local function onDataChanged() -- Line: 252
        -- upvalues: updateQuests (ref), PirateQuest_UI (ref), Title (ref), formatTime (ref), Config (ref)
        updateQuests();

        if PirateQuest_UI.Enabled then
            local ServerTimeNow2 = workspace:GetServerTimeNow();
            local v56 = (math.floor(ServerTimeNow2 / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow2;
            Title.Text = `Refreshes in {formatTime((math.max(v56, 0)))}`;
        end;
    end;

    DataService:GetPathSignal("PirateQuestData/@"):Connect(onDataChanged);
    DataService:GetPathSignal("QuestContainers/@"):Connect(onDataChanged);
    updateQuests();
    task.spawn(function() -- Line: 262
        -- upvalues: PirateQuest_UI (ref), Title (ref), formatTime (ref), Config (ref)
        while true do
            if PirateQuest_UI.Enabled then
                local ServerTimeNow2 = workspace:GetServerTimeNow();
                local v57 = (math.floor(ServerTimeNow2 / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow2;
                Title.Text = `Refreshes in {formatTime((math.max(v57, 0)))}`;
            end;

            task.wait(0.5);
        end;
    end);
    SFX.OnClientEvent:Connect(function(p58) -- Line: 270
        if not p58 then
            return;
        end;

        local v59 = script:FindFirstChild(p58);

        if v59 then
            v59:Play();
        end;
    end);
    local v60 = CollectionService:GetTagged(Config.TIMER_TAG)[1];

    if not v60 then
        return;
    end;

    local u61 = v60 and v60:FindFirstChild("Attachment") and v60.Attachment:FindFirstChild("BillboardGui");
    local u62;

    if u61 then
        u62 = u61:FindFirstChild("Timer");
    else
        u62 = u61;
    end;

    local function StartTime() -- Line: 288
        local Value2 = game.ReplicatedFirst.GlobalUpdateTime.Value;

        return Value2 > 1785011400 and 1785011400 or Value2;
    end;

    local function IsUpdatePassed() -- Line: 295
        local ServerTimeNow2 = workspace:GetServerTimeNow();
        local Value2 = game.ReplicatedFirst.GlobalUpdateTime.Value;

        return (Value2 > 1785011400 and 1785011400 or Value2) <= ServerTimeNow2;
    end;

    if u62 then
        task.spawn(function() -- Line: 301
            -- upvalues: u61 (copy), u62 (copy), formatTime (ref), Config (ref)
            while true do
                while true do
                    local ServerTimeNow2 = workspace:GetServerTimeNow();
                    local Value2 = game.ReplicatedFirst.GlobalUpdateTime.Value;

                    if (Value2 > 1785011400 and 1785011400 or Value2) <= ServerTimeNow2 then
                        break;
                    end;

                    u61.Enabled = false;
                    task.wait(0.5);
                end;

                local ServerTimeNow2 = workspace:GetServerTimeNow();
                local v63 = (math.floor(ServerTimeNow2 / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow2;
                u62.Text = "Quests refresh in " .. formatTime((math.max(v63, 0)));
                u61.Enabled = true;
                task.wait(0.5);
            end;
        end);
    end;
end;

return u1;