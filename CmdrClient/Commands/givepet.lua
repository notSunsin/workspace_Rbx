-- Decompiled with Potassium's decompiler.

return {
    Name = "givepet",
    Description = "Gives pet to specified player(s)",
    Group = "GameCommands",
    Aliases = { "gp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give eggs to."
        }, {
            Type = "pettype",
            Name = "petname",
            Description = "The name of the pet to give."
        }, {
            Type = "number",
            Name = "level",
            Description = "Level of the pet.",
            Optional = true
        }, {
            Type = "number",
            Name = "weight",
            Description = "Base Weight of the pet.",
            Optional = true
        } }
};