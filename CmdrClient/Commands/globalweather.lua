-- Decompiled with Potassium's decompiler.

return {
    Name = "globalweather",
    Description = "Sends a cross server global weather event to all players in the game.",
    Group = "GameCommands",
    Aliases = { "gw", "globalstartweather", "globalstartevent" },
    Args = { {
            Type = "weathers",
            Name = "weather",
            Description = "Weather to send to all server(s)."
        } }
};