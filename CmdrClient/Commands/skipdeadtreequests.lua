-- Decompiled with Potassium's decompiler.

return {
    Name = "skipdeadtreequests",
    Description = "Skips dead tree quests for a specified player(s).",
    Group = "GameCommands",
    Aliases = { "skipdeadtree" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to complete the achievement for."
        } }
};