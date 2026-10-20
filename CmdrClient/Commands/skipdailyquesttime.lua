-- Decompiled with Potassium's decompiler.

return {
    Name = "skipdailyquesttime",
    Description = "Skips daily quest regen time for a specified player(s).",
    Group = "GameCommands",
    Aliases = { "skipdaily" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to complete the achievement for."
        } }
};