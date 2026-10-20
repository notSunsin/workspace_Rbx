-- Decompiled with Potassium's decompiler.

return {
    Name = "notify",
    Description = "Notify player(s) with a specific message.",
    Group = "GameCommands",
    Aliases = { "not" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to clear inventory."
        }, {
            Type = "string",
            Name = "Message",
            Description = "Message to send to player(s)."
        } }
};