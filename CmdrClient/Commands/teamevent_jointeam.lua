-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-jointeam",
    Description = "Joins a player to an existing team in an event.",
    Group = "GameCommands",
    Aliases = { "te-jt" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to join the team."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        }, {
            Type = "string",
            Name = "teamId",
            Description = "The team ID to join."
        } }
};