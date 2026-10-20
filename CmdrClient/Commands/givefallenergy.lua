-- Decompiled with Potassium's decompiler.

return {
    Name = "givefallenergy",
    Description = "Gives fall energy to specified player(s)",
    Group = "GameCommands",
    Aliases = { "gfe" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give eggs to."
        }, {
            Type = "number",
            Name = "amount",
            Description = "Amount of fall energy to give."
        } }
};