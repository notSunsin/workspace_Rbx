-- Decompiled with Potassium's decompiler.

return {
    Name = "givespray",
    Description = "Gives Spray Bottle to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gsp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give Sprays to."
        }, {
            Type = "spraybottletype",
            Name = "spraybottletype(s)",
            Description = "The name of the Spray to give."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        }, {
            Type = "strictmutation",
            Name = "mutation",
            Description = "The mutation type of the spray",
            Optional = true
        } }
};