-- Decompiled with Potassium's decompiler.

return {
    Name = "setstreak",
    Description = "Sets a streak to X days",
    Group = "GameCommands",
    Aliases = { "ss" },
    Args = { {
            Type = "player",
            Name = "FirstPlayer",
            Description = "The first player"
        }, {
            Type = "player",
            Name = "SecondPlayer",
            Description = "The second player"
        }, {
            Type = "number",
            Name = "DaysToBe",
            Description = "Days to be",
            Optional = true
        } }
};