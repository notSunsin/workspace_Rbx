-- Decompiled with Potassium's decompiler.

return {
    Name = "globalvoteweather",
    Description = "Start a vote for players to choose the next weather type globally.",
    Group = "GameCommands",
    Aliases = { "gvw" },
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