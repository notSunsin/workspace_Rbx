-- Decompiled with Potassium's decompiler.

return {
    Name = "clearcosmetics",
    Description = "Clear Cosmetics to specified player(s).",
    Group = "GameCommands",
    Aliases = { "cc" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give gear to."
        }, {
            Type = "boolean",
            Name = "FarmOnly",
            Description = "Optional: delete only cosmetics on farm",
            Optional = true
        }, {
            Type = "string",
            Name = "cosmetic",
            Description = "Optional: delete only cosmetics of this type.",
            Optional = true
        } }
};