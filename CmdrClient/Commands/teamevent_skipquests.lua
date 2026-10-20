-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-skipquests",
    Description = "Skips team event quests.",
    Group = "GameCommands",
    Aliases = { "te-sq" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to add points to."
        }, {
            Type = "teamEventName",
            Name = "eventName",
            Description = "The event name."
        } }
};