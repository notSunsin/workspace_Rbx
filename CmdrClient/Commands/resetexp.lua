-- Decompiled with Potassium's decompiler.

return {
    Name = "resetexp",
    Description = "Resets exp of specified player(s)",
    Group = "GameCommands",
    Aliases = { "rxp", "rexp" },
    Args = { {
            Type = "players",
            Name = "for",
            Description = "The player(s) to reset exp on."
        } }
};