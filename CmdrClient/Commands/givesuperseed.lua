-- Decompiled with Potassium's decompiler.

return {
    Name = "givesuperseed",
    Description = "Gives super seed(s) to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gss" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give super seed(s) to."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};