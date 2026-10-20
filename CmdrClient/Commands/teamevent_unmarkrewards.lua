-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-unmarkrewards",
    Description = "Resets a player\'s Awarded flag so they can re-claim team rewards.",
    Group = "GameCommands",
    Aliases = { "te-ur" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The player(s) to unmark."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        } }
};