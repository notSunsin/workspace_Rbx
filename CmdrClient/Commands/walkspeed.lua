-- Decompiled with Potassium's decompiler.

return {
    Name = "walkspeed",
    Description = "Teleports a player or set of players to one target.",
    Group = "GameCommands",
    Aliases = { "speed" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The players to change the speed"
        }, {
            Type = "number",
            Name = "Speed",
            Description = "The speed to set"
        } }
};