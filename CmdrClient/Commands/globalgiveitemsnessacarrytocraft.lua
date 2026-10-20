-- Decompiled with Potassium's decompiler.

return {
    Name = "globalgiveitemsnessacarrytocraft",
    Description = "Give EVERY player on ALL servers the items to craft a campfire recipe.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
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