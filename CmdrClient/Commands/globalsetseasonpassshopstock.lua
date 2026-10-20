-- Decompiled with Potassium's decompiler.

return {
    Name = "globalsetseasonpassshopstock",
    Description = "Restocks a specific Season Pass shop item for specified player(s)",
    Group = "GameCommands",
    Aliases = { "sspstock" },
    Args = { {
            Type = "seasonpassshopitemname",
            Name = "itemName",
            Description = "The Season Pass shop item ID to restock (e.g. \'Season 6 Crate\')."
        }, {
            Type = "integer",
            Name = "amount",
            Description = "The amount of stock to add."
        } }
};