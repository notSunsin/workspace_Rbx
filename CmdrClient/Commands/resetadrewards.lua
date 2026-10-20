-- Decompiled with Potassium's decompiler.

return {
    Name = "resetadrewards",
    Description = "Resets the ad rewards depth for the specified player(s) so they can test ad reward slots from the beginning",
    Group = "GameCommands",
    Aliases = { "rar" },
    Args = { {
            Type = "players",
            Name = "for",
            Description = "The player(s) to reset ad rewards depth for."
        } }
};