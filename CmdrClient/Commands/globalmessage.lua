-- Decompiled with Potassium's decompiler.

return {
    Name = "globalmessage",
    Description = "Sends a cross server global message to all players in the game.",
    Group = "GameCommands",
    Aliases = { "gm" },
    Args = { {
            Type = "string",
            Name = "Message",
            Description = "Message to send to player(s)."
        } }
};