-- Decompiled with Potassium's decompiler.

return {
    Name = "setdungeonwave",
    Description = "Skips the active WaspWaveSurvival run to the given wave number. Clears current wasps and starts the requested wave fresh.",
    Group = "GameCommands",
    Aliases = { "sdw" },
    Args = { {
            Type = "integer",
            Name = "wave",
            Description = "Wave number to jump to (1+)"
        } }
};