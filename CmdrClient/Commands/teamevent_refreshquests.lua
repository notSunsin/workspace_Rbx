-- Decompiled with Potassium's decompiler.

return {
    Name = "teamevent-refreshquests",
    Description = "Refreshs the quests in the team event.",
    Group = "GameCommands",
    Aliases = { "te-rq" },
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