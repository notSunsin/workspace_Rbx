-- Decompiled with Potassium's decompiler.

return {
    Name = "globalnotify",
    Description = "Sends a cross server global notification to all players in the game.",
    Group = "GameCommands",
    Aliases = { "gn" },
    Args = { {
            Type = "string",
            Name = "Message",
            Description = "Message to send to player(s)."
        } }
};