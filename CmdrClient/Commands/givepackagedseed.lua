-- Decompiled with Potassium's decompiler.

return {
    Name = "givepackagedseed",
    Description = "Gives a packaged seed to specific player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give seed to."
        }, {
            Type = "seedname",
            Name = "seedname(s)",
            Description = "The Seeds to give."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};