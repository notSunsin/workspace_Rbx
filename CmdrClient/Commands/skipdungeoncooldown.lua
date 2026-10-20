-- Decompiled with Potassium's decompiler.

return {
    Name = "skipdungeoncooldown",
    Description = "Skips the dungeon cooldown (ignite cooldown + post-defeat rejoin lockout) for the specified player(s).",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to skip the dungeon cooldown for."
        } }
};