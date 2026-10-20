-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-listteams",
    Description = "Lists all current teams for a given event.",
    Group = "GameCommands",
    Aliases = { "te-lt" },
    Args = { {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name to list teams for."
        } }
};