-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent_clearcooldown",
    Description = "Resets a player\'s claim cooldown in an event.",
    Group = "GameCommands",
    Aliases = { "te-cc" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to reset cooldown for."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        } }
};