-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-addpoints",
    Description = "Adds points to a player in an event.",
    Group = "GameCommands",
    Aliases = { "te-ap" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to add points to."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        }, {
            Type = "number",
            Name = "amount",
            Description = "The number of points to add."
        } }
};