-- Decompiled with Potassium's decompiler.

return {
    Name = "givegear",
    Description = "Gives gear to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gg" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give gear to."
        }, {
            Type = "gearname",
            Name = "gearname(s)",
            Description = "The gear to give."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};