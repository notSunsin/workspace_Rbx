-- Decompiled with Potassium's decompiler.

return {
    Name = "globalstopweather",
    Description = "Sends a cross server stop weather event to all servers.",
    Group = "GameCommands",
    Aliases = { "gsw", "globalendweather", "globalendevent", "globalstopevent" },
    Args = { {
            Type = "weathers",
            Name = "weather",
            Description = "The weather(s) to stop."
        } }
};