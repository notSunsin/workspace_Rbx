-- Decompiled with Potassium's decompiler.

return {
    Name = "givefertilizer",
    Description = "Gives Fertilizer to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gfr" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give Sprays to."
        }, {
            Type = "fertilizertype",
            Name = "fertilizertype(s)",
            Description = "The name of the Fertilizer to give."
        }, {
            Type = "strictvariant",
            Name = "variant",
            Description = "The variant type of the fertilizer",
            Optional = true
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        } }
};