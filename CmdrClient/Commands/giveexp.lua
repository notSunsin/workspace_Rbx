-- Decompiled with Potassium's decompiler.

return {
    Name = "giveexp",
    Description = "Gives exp to specified player(s) with specified amount",
    Group = "GameCommands",
    Aliases = { "xp", "exp" },
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