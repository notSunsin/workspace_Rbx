-- Decompiled with Potassium's decompiler.

return {
    Name = "giveitemsnessacarrytocraft",
    Description = "Give a player the items needed to craft a campfire recipe.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The player(s) to give ingredients to."
        }, {
            Type = "recipes",
            Name = "recipes",
            Description = "Campfire recipe(s) by result item — comma-separate for multiple."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "How many crafts\' worth of ingredients to give (default 1).",
            Optional = true
        } }
};