-- Decompiled with Potassium's decompiler.

return {
    Name = "_setremotecloudstock",
    Description = "Restocks the stock type GLOBALLY ACROSS ALL SERVERS",
    Group = "GameCommands",
    Args = { {
            Type = "string",
            Name = "Item",
            Description = "Item to stock"
        }, {
            Type = "number",
            Name = "Quantity",
            Description = "Quantity to set global stock to"
        } }
};