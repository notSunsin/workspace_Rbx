-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-setpoints",
    Description = "Sets a player\'s points to an exact value in an event.",
    Group = "GameCommands",
    Aliases = { "te-sp" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to set points for."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        }, {
            Type = "number",
            Name = "points",
            Description = "The exact point value to set."
        } }
};