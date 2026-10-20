-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.AchievementsData.Types);
local Events = ReplicatedStorage.Data.Events;
local HarvestMoonAchievementData = require(Events.HarvestMoonEvent.HarvestMoonAchievementData);
local BeanstalkAchievementData = require(Events.BeanstalkEvent.BeanstalkAchievementData);
local HalloweenAchievementPart1Data = require(Events.HalloweenEvent.HalloweenAchievementPart1Data);
local HalloweenAchievementPart2Data = require(Events.HalloweenEvent.HalloweenAchievementPart2Data);
local Halloween2026AchievementData = require(Events.Halloween2026Event.Halloween2026AchievementData);
local FairyAchievementData = require(Events.FairyEvent.FairyAchievementData);
local FallMarketAchievementData = require(Events.FallMarketEvent.FallMarketAchievementData);
local SafariAchievementData = require(Events.SafariEvent.SafariAchievementData);
local Christmas2025AchievementData = require(Events.Christmas2025Event.Christmas2025AchievementData);
local Easter2026AchievementData = require(ReplicatedStorage.Data.EasterEvent.Easter2026AchievementData);
local BeeEventAchievementData = require(ReplicatedStorage.Data.BeeEvent.BeeEventAchievementData);

return {
    SeasonName = "Mini Achievements",
    SeasonDescription = "Complete the achievements in each set to earn their unique rewards!",
    SeasonAwardHeading = "Unique Prizes!",
    SeasonAwardSubHeading = "Complete the achievements in each set to earn their unique rewards!",
    StartTime = game.GameId == 7500518143 and 0 or 1757167200,
    Rewards = {},
    Sets = {
        ["Fairy Event"] = {
            IsBlocked = true,
            Order = 1,
            Rewards = FairyAchievementData.Rewards,
            Quests = FairyAchievementData.Quests
        },
        ["Fall Event"] = {
            IsBlocked = true,
            Order = 2,
            Rewards = FallMarketAchievementData.Rewards,
            Quests = FallMarketAchievementData.Quests
        },
        ["Halloween Event Part 1"] = {
            IsBlocked = true,
            Order = 3,
            Rewards = HalloweenAchievementPart1Data.Rewards,
            Quests = HalloweenAchievementPart1Data.Quests
        },
        ["Halloween Event Part 2"] = {
            IsBlocked = true,
            Order = 4,
            Rewards = HalloweenAchievementPart2Data.Rewards,
            Quests = HalloweenAchievementPart2Data.Quests
        },
        ["Safari Harvest"] = {
            IsBlocked = true,
            Order = 5,
            Rewards = SafariAchievementData.Rewards,
            Quests = SafariAchievementData.Quests
        },
        ["Christmas Event"] = {
            IsBlocked = true,
            Order = 6,
            Rewards = Christmas2025AchievementData.Rewards,
            Quests = Christmas2025AchievementData.Quests
        },
        ["Easter Achievements 2026"] = {
            IsBlocked = true,
            Order = 7,
            Rewards = Easter2026AchievementData.Rewards,
            Quests = Easter2026AchievementData.Quests
        },
        ["Honey Achievements 2026"] = {
            IsBlocked = false,
            Order = 100,
            Rewards = BeeEventAchievementData.Rewards,
            Quests = BeeEventAchievementData.Quests
        },
        ["Harvest Moon Event"] = {
            IsBlocked = true,
            Order = 8,
            EventRotationID = "HarvestMoonEventPart3",
            Rewards = HarvestMoonAchievementData.Rewards,
            Quests = HarvestMoonAchievementData.Quests
        },
        ["Beanstalk Event"] = {
            EventRotationID = "BeanstalkEventPart3",
            Rewards = BeanstalkAchievementData.Rewards,
            Quests = BeanstalkAchievementData.Quests
        },
        ["Halloween 2026 Event"] = {
            EventRotationID = "Halloween2026EventPart1",
            Rewards = Halloween2026AchievementData.Rewards,
            Quests = Halloween2026AchievementData.Quests
        }
    }
};