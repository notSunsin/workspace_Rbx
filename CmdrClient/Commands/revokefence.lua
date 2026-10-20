-- Decompiled with Potassium's decompiler.

return {
    Name = "revokefence",
    Description = "Revoke a fence from specific player(s).",
    Group = "GameCommands",
    Aliases = { "rf" },
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