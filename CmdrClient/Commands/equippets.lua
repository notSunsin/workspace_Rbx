-- Decompiled with Potassium's decompiler.

return {
    Name = "equippets",
    Description = "Gives and equips pets to specified player(s)",
    Group = "GameCommands",
    Aliases = { "epets" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give pets to."
        }, {
            Type = "pettype",
            Name = "petname",
            Description = "The type of pet to give."
        }, {
            Type = "number",
            Name = "amount",
            Description = "How many pets to give (max 8)."
        } }
};