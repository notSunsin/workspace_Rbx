-- Decompiled with Potassium's decompiler.

return {
    Name = "localvoteweather",
    Description = "Start a vote for players to choose the next weather type.",
    Group = "GameCommands",
    Aliases = { "lvw" },
    Args = { {
            Type = "weathers",
            Name = "weather option",
            Description = "The weather to vote."
        }, {
            Type = "duration",
            Name = "duration seconds",
            Description = "How long the vote lasts",
            Optional = true
        } }
};