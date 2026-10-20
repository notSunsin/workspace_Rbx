-- Decompiled with Potassium's decompiler.

return {
    Name = "resetweeklyquesttrack",
    Description = "Resets all weekly quest track progress for a specified player(s).",
    Group = "GameCommands",
    Aliases = { "resetdaily" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to reset the quests for."
        } }
};