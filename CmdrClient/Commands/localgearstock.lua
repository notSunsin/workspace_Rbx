-- Decompiled with Potassium's decompiler.

return {
    Name = "localgearstock",
    Description = "Restocks locally the gear for the server",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "gearshopgearname",
            Name = "gearname(s)",
            Description = "The gears to restock"
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount to set stock",
            Optional = true
        } }
};