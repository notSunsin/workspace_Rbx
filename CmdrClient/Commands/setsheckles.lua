-- Decompiled with Potassium's decompiler.

return {
    Name = "setsheckles",
    Description = "Set sheckles to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "s$" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to set sheckles to."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount set.",
            Optional = true
        } }
};