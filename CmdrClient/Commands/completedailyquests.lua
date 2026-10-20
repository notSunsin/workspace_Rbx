-- Decompiled with Potassium's decompiler.

return {
    Name = "completedailyquests",
    Description = "Completes all daily quests for a specified player(s).",
    Group = "GameCommands",
    Aliases = { "comday" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to complete the achievement for."
        } }
};