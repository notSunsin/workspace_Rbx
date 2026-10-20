-- Decompiled with Potassium's decompiler.

return {
    Name = "setweather",
    Description = "Changes the weather to a specified type.",
    Group = "GameCommands",
    Aliases = { "w", "startweather", "startevent" },
    Args = { {
            Type = "weathers",
            Name = "weather",
            Description = "The weather to spawn."
        } }
};