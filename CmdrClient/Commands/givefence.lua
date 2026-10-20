-- Decompiled with Potassium's decompiler.

return {
    Name = "givefence",
    Description = "Gives a fence to specific player(s).",
    Group = "GameCommands",
    Aliases = { "gf" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give seed to."
        }, {
            Type = "strictfencename",
            Name = "fencename(s)",
            Description = "The Seeds to give."
        } }
};