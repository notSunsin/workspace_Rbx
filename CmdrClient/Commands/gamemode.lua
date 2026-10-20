-- Decompiled with Potassium's decompiler.

return {
    Name = "gamemode",
    Description = "This sets the player\'s gamemode.",
    Group = "GameCommands",
    Aliases = { "gm" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give the gamemode to."
        }, {
            Type = "gamemode",
            Name = "gamemode",
            Description = "The gamemode you want the player(s) to be set to."
        } }
};