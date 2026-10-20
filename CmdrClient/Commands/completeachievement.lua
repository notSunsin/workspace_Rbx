-- Decompiled with Potassium's decompiler.

return {
    Name = "completeachievement",
    Description = "Completes a specified achievement for the specified player(s).",
    Group = "GameCommands",
    Aliases = { "comach" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to complete the achievement for."
        }, {
            Type = "achievementseason",
            Name = "seasonId",
            Description = "The season that the achievement is in."
        }, {
            Type = "achievementset",
            Name = "setId",
            Description = "The achievement set that the achievement is in.",
            Optional = true
        }, {
            Type = "achievementquest",
            Name = "questId",
            Description = "The quest id to complete.",
            Optional = true
        } }
};