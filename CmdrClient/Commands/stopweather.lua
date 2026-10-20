-- Decompiled with Potassium's decompiler.

return {
    Name = "stopweather",
    Description = "Stops a specific weather event, or all if none specified.",
    Group = "GameCommands",
    Aliases = { "sw", "endweather", "endevent", "stopevent" },
    Args = { {
            Type = "weathers",
            Name = "weather",
            Description = "The weather(s) to stop."
        } }
};