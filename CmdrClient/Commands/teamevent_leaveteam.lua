-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-leaveteam",
    Description = "Removes a player from their current team in an event.",
    Group = "GameCommands",
    Aliases = { "te-lvt" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to remove from their team."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        } }
};