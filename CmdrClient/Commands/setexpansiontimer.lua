-- Decompiled with Potassium's decompiler.

return {
    Name = "setexpansiontimer",
    Description = "Sets expansion timer",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "to",
            Description = "The player(s)"
        }, {
            Type = "integer",
            Name = "Expansion",
            Description = "The expansion number you want to skip the timer"
        }, {
            Type = "integer",
            Name = "Timer",
            Description = "The time you want"
        } }
};