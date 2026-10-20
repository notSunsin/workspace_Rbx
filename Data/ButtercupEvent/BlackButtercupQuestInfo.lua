-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarConfigData);
local Types = GiveServiceCommon.Types;
local u1 = {
    MaxQuestIndex = 4
};
local u2 = {
    Black = Color3.fromRGB(30, 30, 30),
    White = Color3.fromRGB(245, 245, 245),
    Red = Color3.fromRGB(255, 60, 60),
    Yellow = Color3.fromRGB(255, 230, 80),
    Green = Color3.fromRGB(60, 200, 100),
    Blue = Color3.fromRGB(80, 120, 255),
    Purple = Color3.fromRGB(180, 100, 255)
};
u1.Quests = {
    {
        Required = 3,
        Dialogue = "I need %d black buttercups! (%d/%d)",
        CompletedDialogue = "Perfect! Come back when you\'re ready for more.",
        Reward = Types.Seed:Use("Big Shadow Buttercup", 1)
    },
    {
        Required = 2,
        Dialogue = "Excellent! Now bring me %d more! (%d/%d)",
        CompletedDialogue = "Wonderful! I have more requests for you.",
        Reward = Types.Seed:Use("Bigger Shadow Buttercup", 1)
    },
    {
        Required = 4,
        Dialogue = "Great work! I need %d black buttercups this time! (%d/%d)",
        CompletedDialogue = "Amazing! One final task awaits.",
        Reward = Types.Seed:Use("Biggest Shadow Buttercup", 1)
    },
    {
        Required = 7,
        Dialogue = "One final task.. I need %d black buttercups! (%d/%d)",
        CompletedDialogue = "You\'ve done it! Thank you for all your help!",
        Reward = Types.Seed:Use("Beast Shadow Buttercup", 1)
    }
};
u1.AllCompleteDialogue = "Thank you for all your help! You\'ve completed all my requests.";
u1.NoPlantsDialogue = "I don\'t see any black buttercups..";
u1.NotEnoughDialogue = "You only have %d, but I need %d more!";
u1.EmptyInventoryDialogue = "You don\'t have any black buttercups!";

function u1.GetQuestData(p3: number) -- Line: 81
    -- upvalues: u1 (copy)
    return u1.Quests[p3];
end;

function u1.GetRequired(p4: number) -- Line: 87
    -- upvalues: u1 (copy)
    local v5 = u1.Quests[p4];

    return v5 and v5.Required or 0;
end;

function u1.IsAllComplete(p6: number) -- Line: 94
    -- upvalues: u1 (copy)
    return u1.MaxQuestIndex < p6;
end;

function u1.GetClosestQuestColor(p7) -- Line: 100
    -- upvalues: u2 (copy)
    local v8 = (1 / 0);
    local v9 = nil;

    for i, v in pairs(u2) do
        local v10 = p7.R - v.R;
        local v11 = p7.G - v.G;
        local v12 = p7.B - v.B;
        local v13 = v10 * v10 + v11 * v11 + v12 * v12;

        if v13 < v8 then
            v9 = i;
            v8 = v13;
        end;
    end;

    return v9;
end;

return u1;