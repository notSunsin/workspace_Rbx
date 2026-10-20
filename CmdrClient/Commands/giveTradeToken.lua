-- Decompiled with Potassium's decompiler.

return {
    Name = "givetradetoken",
    Description = "Gives trade token to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gt$" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give trade tokens to."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};