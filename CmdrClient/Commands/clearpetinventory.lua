-- Decompiled with Potassium's decompiler.

return {
    Name = "clearpetinventory",
    Description = "Clears the specified player(s) pet inventory.",
    Group = "GameCommands",
    Aliases = { "cpi" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to clear pet inventory."
        } }
};