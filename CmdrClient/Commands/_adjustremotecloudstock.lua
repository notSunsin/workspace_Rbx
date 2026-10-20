-- Decompiled with Potassium's decompiler.

return {
    Name = "_adjustremotecloudstock",
    Description = "Adjusts the stock type GLOBALLY ACROSS ALL SERVERS",
    Group = "GameCommands",
    Args = { {
            Type = "string",
            Name = "Item",
            Description = "Item to stock"
        }, {
            Type = "number",
            Name = "Quantity",
            Description = "Quantity to change global stock by"
        } }
};