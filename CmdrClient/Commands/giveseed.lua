-- Decompiled with Potassium's decompiler.

return {
    Name = "giveseed",
    Description = "Gives a seed to specific player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gs" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give seed to."
        }, {
            Type = "seedname",
            Name = "seedname(s)",
            Description = "The Seeds to give."
        }, {
            Type = "number",
            Name = "quantity",
            Description = "Quantity of foods to give",
            Optional = true
        }, {
            Type = "strictvariant",
            Name = "variants",
            Description = "The variant(s)",
            Optional = true
        } }
};