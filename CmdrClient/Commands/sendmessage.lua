-- Decompiled with Potassium's decompiler.

return {
    Name = "sendmessage",
    Description = "Send a specific message to specified player(s) in chat.",
    Group = "GameCommands",
    Aliases = { "sm" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to send message."
        }, {
            Type = "string",
            Name = "Message",
            Description = "Message to send to player(s)."
        } }
};