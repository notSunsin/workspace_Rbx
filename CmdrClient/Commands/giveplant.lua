-- Decompiled with Potassium's decompiler.

return {
    Name = "giveplant",
    Description = "Gives a plant.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "to",
            Description = "The player to give the plant to."
        }, {
            Type = "seedname",
            Name = "plant",
            Description = "Plant name"
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "Quantity of plants to give",
            Optional = true
        }, {
            Type = "strictmutations",
            Name = "mutations",
            Description = "The mutation(s)",
            Optional = true
        }, {
            Type = "integer",
            Name = "weightmultiplier",
            Description = "the weight multiplier",
            Optional = true
        }, {
            Type = "strictvariant",
            Name = "variant",
            Description = "The variant (defaults to Normal)",
            Optional = true
        } }
};