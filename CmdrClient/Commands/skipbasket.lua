-- Decompiled with Potassium's decompiler.

return {
    Name = "skipbasket",
    Description = "Advance a player\'s Beanstalk basket run without submitting the fruit.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The player(s) to advance."
        }, {
            Type = "integer",
            Name = "count",
            Description = "How many submissions to skip (default 1).",
            Optional = true
        } }
};