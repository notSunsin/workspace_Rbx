-- Decompiled with Potassium's decompiler.

return {
    Name = "givepetboost",
    Description = "Gives pet boosts to specified player(s) with a specified arguments.",
    Group = "GameCommands",
    Aliases = { "gpb" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give a pet boost to."
        }, {
            Type = "petboosttype",
            Name = "petboosttype(s)",
            Description = "The name of the pet boost to give.",
            Optional = false
        }, {
            Type = "integer",
            Name = "Time",
            Description = "The duration of the pet boost given.",
            Optional = false
        }, {
            Type = "integer",
            Name = "Amount",
            Description = "The amount of the pet boost",
            Optional = false
        } }
};