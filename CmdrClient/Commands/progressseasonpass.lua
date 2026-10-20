-- Decompiled with Potassium's decompiler.

return {
    Name = "progressseasonpass",
    Description = "Progresses battle pass for specified player(s) with specified amount",
    Group = "GameCommands",
    Aliases = { "progbp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give exp to."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given."
        } }
};