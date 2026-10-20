-- Decompiled with Potassium's decompiler.

return {
    Name = "globalimpersonatenotify",
    Description = "Sends a cross server global notification to all players in the game as a user you\'ve set to impersonate.",
    Group = "GameCommands",
    Aliases = { "gn" },
    Args = { {
            Type = "string",
            Name = "Message",
            Description = "Message to send to player(s) a user that you\'ve set to impersonate."
        } }
};