-- Decompiled with Potassium's decompiler.

return {
    Name = "clearachievements",
    Description = "Clears the specified player(s) achievements.",
    Group = "GameCommands",
    Aliases = { "cach" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to clear all achievements."
        } }
};