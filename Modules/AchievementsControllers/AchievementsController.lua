-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Data.AchievementsData);
local AchievementsShared = require(ReplicatedStorage.Modules.AchievementsControllers.AchievementsShared);
local LocalPlayer = Players.LocalPlayer;

return {
    Claim = function(p1: table, p2: string, p3: table) -- Line: 19, Name: Claim
        -- upvalues: ReplicatedStorage (copy)
        ReplicatedStorage.GameEvents.AchievementService.Claim:FireServer(p2, p3);
    end,

    IsClaimed = function(p4: table, p5: string, p6: table) -- Line: 23, Name: IsClaimed
        -- upvalues: AchievementsShared (copy), LocalPlayer (copy)
        return AchievementsShared:IsClaimed(LocalPlayer, p5, p6);
    end,

    IsCompleted = function(p7: table, p8: string, p9: table) -- Line: 27, Name: IsCompleted
        -- upvalues: AchievementsShared (copy), LocalPlayer (copy)
        return AchievementsShared:IsCompleted(LocalPlayer, p8, p9);
    end,

    Observe = function(p10: table, p11: string, p12: table, p13: function) -- Line: 31, Name: Observe
        -- upvalues: AchievementsShared (copy), LocalPlayer (copy)
        return AchievementsShared:Observe(LocalPlayer, p11, p12, p13);
    end,

    GetSeasonData = function(p14: table, p15: number) -- Line: 35, Name: GetSeasonData
        -- upvalues: AchievementsShared (copy), LocalPlayer (copy)
        return AchievementsShared:GetSeasonData(LocalPlayer, p15);
    end
};