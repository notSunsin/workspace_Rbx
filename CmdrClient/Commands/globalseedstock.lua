-- Decompiled with Potassium's decompiler.

return {
    Name = "globalseedstock",
    Description = "Restocks globally the seed for the server",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "seedshopseedname",
            Name = "seedname(s)",
            Description = "The seed to restock"
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount to set stock"
        } }
};