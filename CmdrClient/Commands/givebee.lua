-- Decompiled with Potassium's decompiler.

return {
    Name = "givebee",
    Description = "Gives bee to specified player(s)",
    Group = "GameCommands",
    Aliases = { "gb" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give eggs to."
        }, {
            Type = "beetype",
            Name = "beename",
            Description = "The name of the bee to give."
        } }
};