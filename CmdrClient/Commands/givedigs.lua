-- Decompiled with Potassium's decompiler.

return {
    Name = "givedigs",
    Description = "Gives egg to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gdigs" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give eggs to."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};