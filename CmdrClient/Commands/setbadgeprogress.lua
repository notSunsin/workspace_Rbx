-- Decompiled with Potassium's decompiler.

return {
    Name = "setbadgeprogress",
    Description = "Sets a badge progress counter (PlayerData.BadgeData[key]) for the specified player(s). 0 resets it.",
    Group = "GameCommands",
    Aliases = { "sbp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to set the progress for."
        }, {
            Type = "badgeprogresskey",
            Name = "key",
            Description = "The badge progress counter, e.g. Halloween2026SweetFortune or SeedpackConnoisseur."
        }, {
            Type = "integer",
            Name = "progress",
            Description = "The new progress. 0 resets it."
        } }
};