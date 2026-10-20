-- Decompiled with Potassium's decompiler.

return {
    Name = "resetskilltree",
    Description = "Resets the skill tree for player(s)",
    Group = "GameCommands",
    Aliases = { "rst" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to reset skill tree for"
        } }
};