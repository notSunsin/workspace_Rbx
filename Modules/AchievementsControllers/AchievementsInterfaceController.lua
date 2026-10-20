-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Spr = require(ReplicatedStorage.Code.Spr);
local DataService = require(ReplicatedStorage.Modules.DataService);
local AchievementsController = require(ReplicatedStorage.Modules.AchievementsControllers.AchievementsController);
local AchievementsData = require(ReplicatedStorage.Data.AchievementsData);
require(ReplicatedStorage.Data.AchievementsData.Types);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GardenGuideModules = ReplicatedStorage.Modules.GardenGuideModules;
local GGUI = require(GardenGuideModules.GGUI);
local GGButtonEffects = require(GardenGuideModules.GGButtonEffects);
local AchievementUICreator = require(GardenGuideModules.AchievementUICreator);
require(GardenGuideModules.DataModules.GGStaticData);
local AchievementUtils = require(GardenGuideModules.AchievementUtils);
require(ReplicatedStorage.Modules.GardenGuideController);
local GardenGuideUIController = require(GardenGuideModules.GardenGuideUIController);
local GardenGuide = Players.LocalPlayer.PlayerGui.GardenGuide;
local _ = GardenGuide.MainMenu.MainMenuFrame;
local AchievementsView = GardenGuide.MainMenu.MainMenuFrame.AchievementsView;
local SeasonsView = AchievementsView.SeasonsView;
local AchTemplates = ReplicatedStorage.Modules.GardenGuideModules.Templates.AchTemplates;
local _ = AchTemplates.SeasonCellTemplate;
local _ = AchTemplates.SeasonSetsTemplate;
local _ = AchTemplates.SetCellTemplate;
local _ = AchTemplates.SetQuestsTemplate;
local _ = AchTemplates.QuestCellTemplate;
local v1 = {};
local u2 = {};
local u3 = {};
local u4 = {};

local function updateSets(u5: number, u6: string, p7: any) -- Line: 46
    -- upvalues: UpdateService (copy), AchievementsData (copy), u4 (copy), DataService (copy), AchievementUtils (copy), AchievementUICreator (copy), u3 (copy), u2 (copy), GGUI (copy), GGButtonEffects (copy), AchievementsController (copy)
    if not p7 then
        return;
    end;

    if UpdateService:IsHiddenFromUpdate(u6) then
        return;
    end;

    local _ = AchievementsData.Seasons[u5].SeasonName;
    local u8 = u4[u5];

    if not u8 then
        return;
    end;

    local v9 = AchievementsData.Seasons[u5].Sets[u6];

    if not v9 then
        warn((`No AchievementData for season ({u5}) sets`));

        return;
    end;

    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local Quests = Data.Achievements.Seasons[`Season_{u5}`].Sets[u6].Quests;
    local v10 = AchievementUtils.CalculateSetProgress(u5, u6, Quests);
    local v11 = u8.Sets.ScrollingFrame.Content:FindFirstChild((`{u5}{u6}Set`));

    if v11 then
        local math_clamp_ret = math.clamp(v10 / #v9.Quests, 0, 1);
        local v12 = math_clamp_ret == 1 and "Completed" or `{v10} / {#v9.Quests}`;
        local PROGRESS = v11.PROGRESS;
        local v13;

        if math_clamp_ret == 1 then
            v13 = Color3.fromRGB(129, 129, 129);
        else
            v13 = Color3.fromRGB(255, 255, 255);
        end;

        PROGRESS.BackgroundColor3 = v13;
        v11.PROGRESS.PROGRESS.Text = v12;
        v11.PROGRESS.PROGRESS_SHADOW.Text = v12;
    else
        v11 = AchievementUICreator.CreateSetCell(u5, u6, u8, v10);
        v11.SENSOR.Activated:Connect(function() -- Line: 74
            -- upvalues: u3 (ref), u5 (copy), u6 (copy), Data (copy), AchievementUtils (ref), AchievementUICreator (ref), u8 (copy), u2 (ref), GGUI (ref)
            local v14 = u3[`{u5}{u6}`];

            if not v14 then
                local Quests2 = Data.Achievements.Seasons[`Season_{u5}`].Sets[u6].Quests;
                local v15 = AchievementUtils.CalculateSetProgress(u5, u6, Quests2);
                v14 = AchievementUICreator.CreateSetQuests(u5, u6, u8, u3, v15);
                u3[`{u5}{u6}`] = v14;
            end;

            AchievementUICreator.PopulateSetQuests(u5, u6, u3, u2);
            GGUI.CurrentDetail = v14;
            GGUI.ChangeTopBar(`{u6} Achievements`, false);
            GGUI.GoNextPage(v14, u8);
        end);
        GGButtonEffects.AddHoverEffect(v11.SENSOR);
    end;

    if AchievementsController:IsCompleted("Set", { u5, u6 }) then
        local CLAIM_BUTTON = v11.CLAIM_BUTTON;

        if AchievementsController:IsClaimed("Set", { u5, u6 }) then
            CLAIM_BUTTON.SENSOR.Interactable = false;
            CLAIM_BUTTON.Visible = false;
            v11.Effect.Visible = false;
            v11.Underglow.Visible = false;
        else
            CLAIM_BUTTON.SENSOR.Interactable = true;
            CLAIM_BUTTON.Visible = true;
            v11.Effect.Visible = true;
            v11.Underglow.Visible = true;
        end;
    end;

    AchievementUICreator.UpdateSetPage(u5, u6, u4, u3, v10);
    AchievementUICreator.UpdateQuestCells(u5, u6, u4, u3, u2, Quests);
end;

local function OpenSeasonPage(p16: number) -- Line: 127
    -- upvalues: DataService (copy), AchievementsData (copy), u4 (copy), AchievementUtils (copy), AchievementUICreator (copy), updateSets (copy), GGUI (copy), AchievementsView (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local v17 = AchievementsData.Seasons[p16];
    local v18 = u4[p16];
    local Sets = Data.Achievements.Seasons[`Season_{p16}`].Sets;
    local v19 = AchievementUtils.CalculateSeasonProgress(p16, Sets);

    if not v18 then
        v18 = AchievementUICreator.CreateSeasonSets(p16, v17, u4, v19);
        u4[p16] = v18;
    end;

    for i in v17.Sets do
        updateSets(p16, i, v17);
    end;

    GGUI.CurrentDetail = v18;
    GGUI.ChangeTopBar(`{v17.SeasonName}`, false);
    GGUI.GoNextPage(v18, AchievementsView, true);
end;

local function OpenSetPage(p20: number, p21: string) -- Line: 154
    -- upvalues: DataService (copy), AchievementsData (copy), u4 (copy), AchievementUtils (copy), AchievementUICreator (copy), updateSets (copy), u3 (copy), u2 (copy), GGUI (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local v22 = AchievementsData.Seasons[p20];
    local v23 = u4[p20];
    local Sets = Data.Achievements.Seasons[`Season_{p20}`].Sets;
    local v24 = AchievementUtils.CalculateSeasonProgress(p20, Sets);

    if not v23 then
        v23 = AchievementUICreator.CreateSeasonSets(p20, v22, u4, v24);
        u4[p20] = v23;
    end;

    for i in v22.Sets do
        updateSets(p20, i, v22);
    end;

    local v25 = u3[`{p20}{p21}`];

    if not v25 then
        local Quests = Data.Achievements.Seasons[`Season_{p20}`].Sets[p21].Quests;
        local v26 = AchievementUtils.CalculateSetProgress(p20, p21, Quests);
        v25 = AchievementUICreator.CreateSetQuests(p20, p21, v23, u3, v26);
        u3[`{p20}{p21}`] = v25;
    end;

    AchievementUICreator.PopulateSetQuests(p20, p21, u3, u2);
    GGUI.CurrentDetail = v25;
    GGUI.ChangeTopBar(`{p21} Achievements`, false);
    GGUI.GoNextPage(v25, v23, true);
end;

function v1.OpenAchievementPage(p27: table, p28: number, p29: string?) -- Line: 195
    -- upvalues: GardenGuideUIController (copy), OpenSeasonPage (copy), OpenSetPage (copy)
    GardenGuideUIController:OpenGGOnPage("Achievements");

    if not p29 then
        OpenSeasonPage(p28);

        return;
    end;

    OpenSeasonPage(p28);
    OpenSetPage(p28, p29);
end;

function v1.Start(p30) -- Line: 205
    -- upvalues: DataService (copy), AchievementsData (copy), u4 (copy), AchievementsController (copy), Spr (copy), AchievementsView (copy), UpdateService (copy), SeasonsView (copy), AchievementUICreator (copy), AchievementUtils (copy), updateSets (copy), GGUI (copy), GGButtonEffects (copy)
    local Data = DataService:GetData();

    local function updateSeason(p31: number, p32: any) -- Line: 212
        -- upvalues: AchievementsData (ref), u4 (ref), AchievementsController (ref), Spr (ref)
        if not p32 then
            return;
        end;

        local _ = AchievementsData.Seasons[p31].SeasonName;
        local v33 = u4[p31];

        if not v33 then
            return;
        end;

        local v34 = AchievementsController:IsCompleted("Season", { p31 });

        if v34 then
            local ClaimSeason = v33.ClaimSeason;

            if AchievementsController:IsClaimed("Season", { p31 }) then
                ClaimSeason.Interactable = false;
                ClaimSeason.Visible = false;
                ClaimSeason.RARITY.Text = "Completed";
                ClaimSeason.RARITY_SHADOW.Text = "Completed";
            elseif tonumber(p31) ~= 3 then
                ClaimSeason.Interactable = true;
                ClaimSeason.Visible = true;
            end;
        end;

        local v35 = 0;
        local v36 = 0;

        for i, v in p32.Sets do
            local v37 = AchievementsData.Seasons[p31].Sets[i];

            if v37 then
                local v38 = v;

                for _, v2 in v37.Quests do
                    v35 = v35 + 1;

                    if (v38.Quests[v2.Id] and (v38.Quests[v2.Id].Progress or 0) or 0) >= v2.Target then
                        v36 = v36 + 1;
                    end;
                end;
            else
                warn(`AchievementsInterfaceController | No AchData for {i}:`, v37);
            end;
        end;

        local ProgressBar = v33.Progress.ProgressBar;
        local Bar_Actual = ProgressBar.Bar_Actual;
        local PROGRESS = ProgressBar.PROGRESS;
        local PROGRESS_SHADOW = ProgressBar.PROGRESS_SHADOW;
        local v39 = `{v36} / {v35}`;
        PROGRESS.Text = v39;
        PROGRESS_SHADOW.Text = v39;

        if v34 and AchievementsController:IsClaimed("Season", { p31 }) then
            PROGRESS.Text = "Completed";
            PROGRESS_SHADOW.Text = "Completed";
        end;

        Spr.target(Bar_Actual, 0.9, 1, {
            Size = UDim2.fromScale(math.clamp(v36 / v35, 0, 1), 1)
        });
    end;

    AchievementsView:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 273
        -- upvalues: AchievementsView (ref), AchievementsData (ref), UpdateService (ref), SeasonsView (ref), AchievementUICreator (ref), u4 (ref), Data (copy), AchievementUtils (ref), updateSets (ref), GGUI (ref), GGButtonEffects (ref)
        if AchievementsView.Visible then
            for i, v in AchievementsData.Seasons do
                if not (UpdateService:IsHiddenFromUpdate(v.SeasonName) or SeasonsView.ScrollingFrame.Content:FindFirstChild(v.SeasonName)) then
                    local SENSOR = AchievementUICreator.CreateSeasonCell(i, v).SELECT_BUTTON.SENSOR;
                    SENSOR.Activated:Connect(function() -- Line: 283
                        -- upvalues: u4 (ref), i (copy), Data (ref), AchievementUtils (ref), AchievementUICreator (ref), v (copy), updateSets (ref), GGUI (ref), AchievementsView (ref)
                        local v40 = u4[i];
                        local Sets = Data.Achievements.Seasons[`Season_{i}`].Sets;
                        local v41 = AchievementUtils.CalculateSeasonProgress(i, Sets);

                        if not v40 then
                            v40 = AchievementUICreator.CreateSeasonSets(i, v, u4, v41);
                            u4[i] = v40;
                        end;

                        for i2 in v.Sets do
                            updateSets(i, i2, v);
                        end;

                        GGUI.CurrentDetail = v40;
                        GGUI.ChangeTopBar(`{v.SeasonName}`, false);
                        GGUI.GoNextPage(v40, AchievementsView);
                    end);
                    GGButtonEffects.AddHoverEffect(SENSOR);
                end;
            end;

            return;
        end;

        for _, child in SeasonsView.ScrollingFrame.Content:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;
    end);

    for i, v in AchievementsData.Seasons do
        local u42 = nil;
        AchievementsController:Observe("Season", { i }, function(p43) -- Line: 316
            -- upvalues: u42 (ref), updateSeason (copy), i (copy), v (copy), AchievementsController (ref), updateSets (ref)
            if type(u42) == "function" then
                u42();
            end;

            updateSeason(i, p43);
            local u44 = {};

            for i2 in v.Sets do
                table.insert(u44, AchievementsController:Observe("Set", { i, i2 }, function(p45) -- Line: 325
                    -- upvalues: updateSets (ref), i (ref), i2 (copy)
                    updateSets(i, i2, p45);
                end));
            end;

            u42 = function() -- Line: 330
                -- upvalues: u44 (copy)
                for _, v2 in u44 do
                    if type(v2) == "function" then
                        v2();
                    end;
                end;
            end;
        end);
    end;
end;

task.spawn(v1.Start, v1);

return v1;