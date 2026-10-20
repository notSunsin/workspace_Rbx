-- Decompiled with Potassium's decompiler.

return {
    Name = "refreshegghunt",
    Description = "Refreshes the egg hunt for the specified player(s).",
    Group = "GameCommands",
    Aliases = { "reh" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to refresh for."
        }, {
            Type = "boolean",
            Name = "server-wide",
            Description = "Whether the serverwide egg hunt should run."
        } }
};