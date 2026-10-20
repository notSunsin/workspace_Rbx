-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Spr = require(ReplicatedStorage.Code.Spr);
local AchievementsData = require(ReplicatedStorage.Data.AchievementsData);
local AchievementsController = require(ReplicatedStorage.Modules.AchievementsControllers.AchievementsController);
require(ReplicatedStorage.Data.FenceSkinRegistry);
require(ReplicatedStorage.Data.AchievementsData.Types);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local GardenGuideModules = ReplicatedStorage.Modules.GardenGuideModules;
local ImageCycle = require(GardenGuideModules.ImageCycle);
local GGButtonEffects = require(GardenGuideModules.GGButtonEffects);
require(GardenGuideModules.GGUI);
local GGStaticData = require(GardenGuideModules.DataModules.GGStaticData);
local AchievementUtils = require(GardenGuideModules.AchievementUtils);
local AchTemplates = ReplicatedStorage.Modules.GardenGuideModules.Templates.AchTemplates;
local SeasonCellTemplate = AchTemplates.SeasonCellTemplate;
local SeasonSetsTemplate = AchTemplates.SeasonSetsTemplate;
local SetCellTemplate = AchTemplates.SetCellTemplate;
local SetQuestsTemplate = AchTemplates.SetQuestsTemplate;
local QuestCellTemplate = AchTemplates.QuestCellTemplate;
local GardenGuide = Players.LocalPlayer.PlayerGui.GardenGuide;
local MainMenuFrame = GardenGuide.MainMenu.MainMenuFrame;
local SeasonsView = GardenGuide.MainMenu.MainMenuFrame.AchievementsView.SeasonsView;
local u35 = {
    CreateSeasonCell = function(p1, p2) -- Line: 34, Name: CreateSeasonCell
        -- upvalues: SeasonCellTemplate (copy), AchTemplates (copy), SeasonsView (copy), AchievementsData (copy), AchievementUtils (copy)
        local SeasonName = p2.SeasonName;
        local v3 = SeasonCellTemplate:Clone();
        v3.Name = SeasonName;
        v3.Main.TITLE.Text = `{SeasonName}`;
        v3.Main.TITLE_SHADOW.Text = `{SeasonName}`;
        v3.Main.SUB_TEXT.Text = `{p2.SeasonDescription}`;
        local v4 = AchTemplates.SeasonBackgrounds:FindFirstChild((`{p1}Background`)):Clone();

        if v4 then
            v4.Parent = v3.Main;
        else
            warn((`No season background for Season {p1}`));
        end;

        local SELECT_BUTTON = v3.SELECT_BUTTON;
        SELECT_BUTTON.TEXT.Text = "Explore";
        SELECT_BUTTON.TEXT_SHADOW.Text = "Explore";
        v3.Parent = SeasonsView.ScrollingFrame.Content;

        for i, _ in AchievementsData.Seasons[p1].Sets do
            local v5 = AchievementUtils.CheckForUnclaimed(p1, i);

            if v5 then
                v3.Main:FindFirstChild("NotifMark").Visible = v5;

                return v3;
            end;
        end;

        return v3;
    end,

    CreateSeasonSets = function(u6, p7, u8, p9) -- Line: 70, Name: CreateSeasonSets
        -- upvalues: SeasonSetsTemplate (copy), AchievementsData (copy), ImageCycle (copy), MainMenuFrame (copy), GGButtonEffects (copy), AchievementsController (copy), Spr (copy)
        local v10 = SeasonSetsTemplate:Clone();
        v10.Name = p7.SeasonName;
        local TITLE_SHADOW = v10.SeasonReward.Main.TITLE_SHADOW;
        v10.SeasonReward.Main.TITLE.Text = p7.SeasonAwardHeading or "Grand Prize!";
        TITLE_SHADOW.Text = p7.SeasonAwardHeading or "Grand Prize!";
        v10.SeasonReward.Main.SUB_TEXT.Text = p7.SeasonAwardSubHeading or "Sub Text Placeholder";
        local SeasonRewardFrame = v10.SeasonReward.Main.Rewards.SeasonRewardFrame;
        local REWARD_IMAGE = SeasonRewardFrame.REWARD_IMAGE;
        local REWARD_NAME = SeasonRewardFrame.ITEM_NAME.REWARD_NAME;
        local REWARD_NAME_SHADOW = SeasonRewardFrame.ITEM_NAME.REWARD_NAME_SHADOW;
        local Rewards = AchievementsData.Seasons[u6].Rewards;

        if #Rewards == 0 then
            SeasonRewardFrame.Visible = false;
        else
            ImageCycle.CycleRewardImages(REWARD_IMAGE, REWARD_NAME, REWARD_NAME_SHADOW, v10, Rewards);
        end;

        if tonumber(u6) == 3 then
            v10.SeasonReward.Visible = false;
            v10.Progress.Visible = false;
            local Size = v10.Sets.Size;
            v10.Sets.Position = UDim2.fromScale(v10.Sets.Position.X.Scale, 0.2);
            v10.Sets.Size = UDim2.fromScale(Size.X.Scale, 0.75);
            local UIGridLayout = v10.Sets.ScrollingFrame.Content.UIGridLayout;
            UIGridLayout.CellSize = UDim2.fromScale(UIGridLayout.CellSize.X.Scale, 0.4);
        end;

        v10.Parent = MainMenuFrame;
        local ClaimSeason = v10.ClaimSeason;
        local u11 = ClaimSeason.Activated:Connect(function() -- Line: 113
            -- upvalues: GGButtonEffects (ref), AchievementsController (ref), u6 (copy), ClaimSeason (copy)
            GGButtonEffects.Click();
            AchievementsController:Claim("Season", { u6 });
            ClaimSeason.Visible = false;
        end);
        ClaimSeason.Destroying:Once(function() -- Line: 118
            -- upvalues: u8 (copy), u6 (copy), u11 (ref)
            u8[u6] = nil;
            u11:Disconnect();
            u11 = nil;
        end);
        local Sets = AchievementsData.Seasons[u6].Sets;

        if Sets then
            local v12 = 0;

            for _, v in Sets do
                for _, _ in v.Quests do
                    v12 = v12 + 1;
                end;
            end;

            local math_clamp_ret = math.clamp(p9 / v12, 0, 1);
            local v13 = math_clamp_ret == 1 and "Completed" or `{p9} / {v12}`;

            if AchievementsController:IsCompleted("Season", { u6 }) then
                local ClaimSeason2 = v10.ClaimSeason;

                if AchievementsController:IsClaimed("Season", { u6 }) then
                    ClaimSeason2.Interactable = false;
                    ClaimSeason2.Visible = false;
                    ClaimSeason2.RARITY.Text = "Completed";
                    ClaimSeason2.RARITY_SHADOW.Text = "Completed";
                elseif tonumber(u6) ~= 3 then
                    ClaimSeason2.Interactable = true;
                    ClaimSeason2.Visible = true;
                end;
            end;

            local ProgressBar = v10.Progress.ProgressBar;
            ProgressBar.PROGRESS.Text = v13;
            ProgressBar.PROGRESS_SHADOW.Text = v13;
            Spr.target(ProgressBar.Bar_Actual, 0.9, 1, {
                Size = UDim2.fromScale(math_clamp_ret, 1)
            });

            return v10;
        end;

        warn((`No AchievementData for season ({u6}) sets`));
    end,

    CreateSetCell = function(u14: string, u15: string, p16: any, p17: number) -- Line: 161, Name: CreateSetCell
        -- upvalues: SetCellTemplate (copy), GGStaticData (copy), AchievementsData (copy), AchievementUtils (copy), GGButtonEffects (copy), AchievementsController (copy)
        local v18 = SetCellTemplate:Clone();
        v18.Name = `{u14}{u15}Set`;
        v18.LayoutOrder = GGStaticData.RarityLayoutMap[u15] or (AchievementsData.Seasons[u14].Sets[u15].Order and (-AchievementsData.Seasons[u14].Sets[u15].Order or -1) or -1);
        local v19 = `{u15}`;

        if not string.find(u15, "Achievement") then
            v19 = `{u15} Achievements`;
        end;

        v18.SET_TEXT.Text = v19;
        v18.SET_TEXT_SHADOW.Text = v19;

        if AchievementsData.Seasons[u14].Sets[u15].IsBlocked then
            v18.Expired.Visible = true;
        end;

        local RewardString = AchievementUtils.GetRewardString(AchievementsData.Seasons[u14].Sets[u15].Rewards);
        v18.REWARD_TEXT.Text = `Rewards: {RewardString}`;
        v18.Background.Image = GGStaticData.RarityBackground[u15] or "rbxassetid://87011838248935";
        local v20 = AchievementUtils.CheckForUnclaimed(u14, u15);
        v18:FindFirstChild("NotifMark").Visible = v20;
        local v21 = AchievementsData.Seasons[u14].Sets[u15];

        if v21 then
            local math_clamp_ret = math.clamp(p17 / #v21.Quests, 0, 1);

            if math_clamp_ret == 1 then
                v18.CLAIM_BUTTON.Visible = true;
                v18.PROGRESS.PROGRESS.Text = "Completed";
                v18.PROGRESS.PROGRESS_SHADOW.Text = "Completed";
            else
                v18.CLAIM_BUTTON.Visible = false;
                local v22 = math_clamp_ret == 1 and "Completed" or `{p17} / {#v21.Quests}`;
                local PROGRESS = v18.PROGRESS;
                local v23;

                if math_clamp_ret == 1 then
                    v23 = Color3.fromRGB(129, 129, 129);
                else
                    v23 = Color3.fromRGB(255, 255, 255);
                end;

                PROGRESS.BackgroundColor3 = v23;
                v18.PROGRESS.PROGRESS.Text = v22;
                v18.PROGRESS.PROGRESS_SHADOW.Text = v22;
            end;

            v18.Parent = p16.Sets.ScrollingFrame.Content;
            local SENSOR = v18.CLAIM_BUTTON.SENSOR;
            local u24 = SENSOR.Activated:Connect(function() -- Line: 215
                -- upvalues: GGButtonEffects (ref), AchievementsController (ref), u14 (copy), u15 (copy), SENSOR (copy)
                GGButtonEffects.Click();
                AchievementsController:Claim("Set", { u14, u15 });
                SENSOR.Visible = false;
            end);
            SENSOR.Destroying:Once(function() -- Line: 220
                -- upvalues: u24 (ref)
                u24:Disconnect();
                u24 = nil;
            end);

            return v18;
        end;

        warn((`No AchievementData for season ({u14}) sets`));
    end,

    CreateSetQuests = function(u25, u26, p27, p28, p29) -- Line: 228, Name: CreateSetQuests
        -- upvalues: SetQuestsTemplate (copy), AchievementsData (copy), ImageCycle (copy), GGButtonEffects (copy), AchievementsController (copy), Spr (copy), MainMenuFrame (copy)
        local v30 = SetQuestsTemplate:Clone();
        v30.Name = `{u25}{u26}Quests`;
        local Main = v30.TitleFrame.Main;
        local v31 = `{u26} Achievements`;
        Main.TITLE.Text = v31;
        Main.TITLE_SHADOW.Text = v31;

        if AchievementsData.Seasons[u25].Sets[u26].IsBlocked then
            v30.TitleFrame.Expired.Visible = true;
        end;

        v30.Visible = false;
        local RewardFrame = Main.Rewards.RewardFrame;
        local REWARD_IMAGE = RewardFrame.REWARD_IMAGE;
        local REWARD_NAME = RewardFrame.ITEM_NAME.REWARD_NAME;
        local REWARD_NAME_SHADOW = RewardFrame.ITEM_NAME.REWARD_NAME_SHADOW;
        local Rewards = AchievementsData.Seasons[u25].Sets[u26].Rewards;

        if #Rewards == 0 then
            RewardFrame.Visible = false;
        else
            ImageCycle.CycleRewardImages(REWARD_IMAGE, REWARD_NAME, REWARD_NAME_SHADOW, v30, Rewards);
        end;

        local CLAIM_BUTTON = p27.Sets.ScrollingFrame.Content[`{u25}{u26}Set`].CLAIM_BUTTON;
        local u32 = CLAIM_BUTTON.SENSOR.Activated:Connect(function() -- Line: 254
            -- upvalues: GGButtonEffects (ref), AchievementsController (ref), u25 (copy), u26 (copy), CLAIM_BUTTON (copy)
            GGButtonEffects.Click();
            AchievementsController:Claim("Set", { u25, u26 });
            CLAIM_BUTTON.Visible = false;
        end);
        CLAIM_BUTTON.Destroying:Once(function() -- Line: 259
            -- upvalues: u32 (ref)
            u32:Disconnect();
            u32 = nil;
        end);
        GGButtonEffects.AddHoverEffect(CLAIM_BUTTON.SENSOR);
        local v33 = AchievementsData.Seasons[u25].Sets[u26];

        if v33 then
            local math_clamp_ret = math.clamp(p29 / #v33.Quests, 0, 1);
            local v34 = math_clamp_ret == 1 and "Completed" or `{p29} / {#v33.Quests}`;
            local ProgressBar = v30.TitleFrame.Main.Progress.ProgressBar;
            ProgressBar.PROGRESS.Text = v34;
            ProgressBar.PROGRESS_SHADOW.Text = v34;
            Spr.target(ProgressBar.Bar_Actual, 0.9, 1, {
                Size = UDim2.fromScale(math_clamp_ret, 1)
            });
            v30.Parent = MainMenuFrame;

            return v30;
        end;

        warn((`No AchievementData for season ({u25}) sets`));
    end
};

function u35.PopulateSetQuests(u36, u37, u38, u39) -- Line: 283
    -- upvalues: AchievementsController (copy), AchievementsData (copy), u35 (copy), GGButtonEffects (copy), GGStaticData (copy), NumberUtil (copy), Spr (copy)
    local SeasonData = AchievementsController:GetSeasonData(u36);

    if not SeasonData then
        warn((`No season data for {u36} found!`));

        return;
    end;

    local v40 = AchievementsData.Seasons[u36].Sets[u37];

    if v40 then
        for i, v in v40.Quests do
            local v41 = SeasonData.Sets[u37];

            if v41 then
                local v42 = v41.Quests[v.Id];
                local u43 = `{u36}_{u37}_{v.Id}`;
                local u44 = u39[u43];

                if not u44 then
                    u44 = u35.CreateQuestCell(u36, u37, v, u38);
                    u39[u43] = u44;
                    local SENSOR = u44.CLAIM_BUTTON.SENSOR;
                    local u45 = SENSOR.Activated:Connect(function() -- Line: 314
                        -- upvalues: GGButtonEffects (ref), AchievementsController (ref), u36 (copy), u37 (copy), i (copy), u44 (ref)
                        GGButtonEffects.Click();
                        AchievementsController:Claim("Quest", { u36, u37, i });
                        u44.CLAIM_BUTTON.Visible = false;
                    end);
                    SENSOR.Destroying:Once(function() -- Line: 319
                        -- upvalues: u38 (copy), u36 (copy), u37 (copy), u39 (copy), u43 (copy), u45 (ref)
                        u38[`{u36}{u37}`] = nil;
                        u39[u43] = nil;
                        u45:Disconnect();
                        u45 = nil;
                    end);
                    GGButtonEffects.AddHoverEffect(SENSOR);
                end;

                local PROGRESS = u44.PROGRESS;
                local v46 = not v42 and 0 or v42.Progress;
                local Target = v.Target;

                if Target <= v46 then
                    u44.CLAIM_BUTTON.Visible = not v42.Claimed;

                    if AchievementsController:IsClaimed("Quest", { u36, u37, i }) then
                        u44:FindFirstChild("UIGradient").Color = GGStaticData.GoldColorSequence;
                        u44.Details.GoldenFrame.Visible = true;
                        u44.Details.NormalFrame.Visible = false;
                    else
                        u44:FindFirstChild("UIGradient").Color = GGStaticData.NormalColorSequence;
                        u44.Details.GoldenFrame.Visible = false;
                        u44.Details.NormalFrame.Visible = true;
                    end;

                    u44.PROGRESS.PROGRESS.Text = "Completed";
                    u44.PROGRESS.PROGRESS_SHADOW.Text = "Completed";
                else
                    u44.CLAIM_BUTTON.Visible = false;
                    local v47 = `{NumberUtil.RoundToDP(v46, 2)} / {Target}`;
                    PROGRESS.PROGRESS.Text = v47;
                    PROGRESS.PROGRESS_SHADOW.Text = v47;
                    Spr.target(PROGRESS.Bar_Actual, 0.9, 1, {
                        Size = UDim2.fromScale(math.clamp(v46 / Target, 0, 1), 1)
                    });
                end;
            else
                warn((`No set data for {u37} found!`));
            end;
        end;

        return;
    end;

    warn((`No AchievementData for season ({u36}) sets`));
end;

function u35.UpdateSetPage(p48, p49, p50, p51, p52) -- Line: 357
    -- upvalues: AchievementsData (copy), Spr (copy), AchievementUtils (copy), AchievementsController (copy)
    local v53 = AchievementsData.Seasons[p48].Sets[p49];

    if not v53 then
        warn((`No AchievementData for season ({p48}) sets`));

        return;
    end;

    if p51[`{p48}{p49}`] then
        local v54 = p51[`{p48}{p49}`];
        local math_clamp_ret = math.clamp(p52 / #v53.Quests, 0, 1);
        local v55 = math_clamp_ret == 1 and "Completed" or `{p52} / {#v53.Quests}`;
        local ProgressBar = v54.TitleFrame.Main.Progress.ProgressBar;
        ProgressBar.PROGRESS.Text = v55;
        ProgressBar.PROGRESS_SHADOW.Text = v55;
        Spr.target(ProgressBar.Bar_Actual, 0.9, 1, {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        });
    end;

    for _, child in p50[p48].Sets.ScrollingFrame.Content:GetChildren() do
        if child:IsA("Frame") and child.Name == `{p48}{p49}Set` then
            child:FindFirstChild("NotifMark").Visible = AchievementUtils.CheckForUnclaimed(p48, p49);
            local v56 = AchievementsController:IsCompleted("Set", { p48, p49 });

            if v56 then
                local PROGRESS = child.PROGRESS;
                local v57;

                if v56 then
                    v57 = Color3.fromRGB(129, 129, 129);
                else
                    v57 = Color3.fromRGB(255, 255, 255);
                end;

                PROGRESS.BackgroundColor3 = v57;
            end;
        end;
    end;
end;

function u35.CreateQuestCell(p58, p59, p60, p61) -- Line: 394
    -- upvalues: QuestCellTemplate (copy), GGStaticData (copy)
    local v62 = QuestCellTemplate:Clone();
    v62.Name = `{p58}_{p59}_{p60.Id}`;
    v62.SET.Text = p60.Display;
    v62.SET_SHADOW.Text = p60.Display;
    v62.Background.Image = GGStaticData.RarityBackground[p59] or "rbxassetid://87011838248935";
    v62.Parent = p61[`{p58}{p59}`].QuestGridView.ScrollingFrame.QuestGridHolder;

    return v62;
end;

function u35.UpdateQuestCells(p63, p64, p65, p66, p67, p68) -- Line: 407
    -- upvalues: AchievementsData (copy), NumberUtil (copy), AchievementsController (copy), GGStaticData (copy), Spr (copy)
    for i, v in AchievementsData.Seasons[p63].Sets[p64].Quests do
        local Id = v.Id;
        local Target = v.Target;

        if p67[`{p63}_{p64}_{Id}`] and p68[Id] then
            local v69 = NumberUtil.RoundToDP(p68[Id].Progress, 2);
            local math_clamp_ret = math.clamp(v69 / Target, 0, 1);
            local v70 = math_clamp_ret == 1 and "Completed" or `{v69} / {Target}`;
            local v71 = p67[`{p63}_{p64}_{Id}`];
            local PROGRESS = v71.PROGRESS;
            PROGRESS.PROGRESS.Text = v70;
            PROGRESS.PROGRESS_SHADOW.Text = v70;

            if math_clamp_ret == 1 then
                if AchievementsController:IsClaimed("Quest", { p63, p64, i }) then
                    v71.CLAIM_BUTTON.Visible = false;
                    PROGRESS:FindFirstChild("Bar_Actual").Visible = false;
                    v71:FindFirstChild("UIGradient").Color = GGStaticData.GoldColorSequence;
                    v71.Details.GoldenFrame.Visible = true;
                    v71.Details.NormalFrame.Visible = false;
                else
                    v71.CLAIM_BUTTON.Visible = true;
                    PROGRESS:FindFirstChild("Bar_Actual").Visible = false;
                    v71:FindFirstChild("UIGradient").Color = GGStaticData.NormalColorSequence;
                    v71.Details.GoldenFrame.Visible = false;
                    v71.Details.NormalFrame.Visible = true;
                end;
            else
                Spr.target(PROGRESS.Bar_Actual, 0.9, 1, {
                    Size = UDim2.fromScale(math_clamp_ret, 1)
                });
            end;
        end;
    end;
end;

return u35;