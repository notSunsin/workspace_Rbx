-- Decompiled with Potassium's decompiler.

return {
    Name = "clearinventory",
    Description = "Clears the specified player(s) inventory.",
    Group = "GameCommands",
    Aliases = { "ci" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to clear inventory."
        } }
};