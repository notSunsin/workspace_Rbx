-- Decompiled with Potassium's decompiler.

return {
    Name = "giveegg",
    Description = "Gives egg to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "ge" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give eggs to."
        }, {
            Type = "eggname",
            Name = "eggname(s)",
            Description = "The name of the egg to give."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};