-- Decompiled with Potassium's decompiler.

return {
    Name = "globaleggstock",
    Description = "Restocks globally an specific egg",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "peteggshopname",
            Name = "egg(s)",
            Description = "The egg to restock"
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount to set stock",
            Optional = true
        } }
};