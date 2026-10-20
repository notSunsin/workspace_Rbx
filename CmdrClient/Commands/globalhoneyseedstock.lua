-- Decompiled with Potassium's decompiler.

return {
    Name = "globalhoneyseedstock",
    Description = "Restocks globally a honey seed for all players",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "honeyseedshopname",
            Name = "seedname(s)",
            Description = "The honey seed to restock"
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount to set stock"
        } }
};