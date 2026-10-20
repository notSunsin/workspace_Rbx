-- Decompiled with Potassium's decompiler.

return {
    Name = "localseedstock",
    Description = "Restocks locally the seed for the server",
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