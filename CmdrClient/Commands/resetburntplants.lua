-- Decompiled with Potassium's decompiler.

return {
    Name = "resetburntplants",
    Description = "Resets the specified player(s) BurntPlants count to 0.",
    Group = "GameCommands",
    Aliases = { "rbp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to reset burnt plants for."
        } }
};