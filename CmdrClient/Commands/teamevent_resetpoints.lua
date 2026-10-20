-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-resetpoints",
    Description = "Resets a player\'s points and claimed tiers in an event.",
    Group = "GameCommands",
    Aliases = { "te-rp" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to reset points for."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        } }
};