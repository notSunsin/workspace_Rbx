-- Decompiled with Potassium's decompiler.

return {
    Name = "giveseedpack",
    Description = "Gives seed pack(s) to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gsp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give seed pack to."
        }, {
            Type = "seedpack",
            Name = "seedpack",
            Description = "Seed pack name"
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount to give.",
            Optional = true
        } }
};