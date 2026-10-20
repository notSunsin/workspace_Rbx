-- Decompiled with Potassium's decompiler.

return {
    Name = "givefood",
    Description = "Creates a food.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "to",
            Description = "The player to give the food to."
        }, {
            Type = "foodname",
            Name = "food",
            Description = "Food name"
        }, {
            Type = "strictmutations",
            Name = "mutations",
            Description = "The mutation(s)",
            Optional = true
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "Quantity of foods to give",
            Optional = true
        } }
};