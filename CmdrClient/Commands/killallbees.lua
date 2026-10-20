-- Decompiled with Potassium's decompiler.

return {
    Name = "killallbees",
    Description = "Sets every active bee for the specified player(s) to 0 HP. Triggers normal death paths (WaspWaveSurvival defeat detection, etc).",
    Group = "GameCommands",
    Aliases = { "kab" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) whose bees to kill"
        } }
};