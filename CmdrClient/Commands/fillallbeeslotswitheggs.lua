-- Decompiled with Potassium's decompiler.

return {
    Name = "fillallbeeslotswitheggs",
    Description = "Fills all empty bee slots with eggs of the given type",
    Group = "GameCommands",
    Aliases = { "fillbees" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to fill slots for."
        }, {
            Type = "beeeggtype",
            Name = "eggtype",
            Description = "The bee egg type to place."
        } }
};