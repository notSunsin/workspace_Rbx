-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-createteam",
    Description = "Creates a new team for a player in an event.",
    Group = "GameCommands",
    Aliases = { "te-ct" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to create the team for."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name to create the team in."
        } }
};