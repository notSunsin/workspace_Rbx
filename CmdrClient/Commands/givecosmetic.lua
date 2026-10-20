-- Decompiled with Potassium's decompiler.

return {
    Name = "givecosmetic",
    Description = "Gives cosmetic to specified player(s).",
    Group = "GameCommands",
    Aliases = { "gc" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give gear to."
        }, {
            Type = "cosmeticname",
            Name = "cosmeticname",
            Description = "The gear to give."
        }, {
            Type = "integer",
            Name = "Quantity",
            Optional = true,
            Description = "Quantity"
        } }
};