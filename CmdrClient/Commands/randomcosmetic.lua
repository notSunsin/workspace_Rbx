-- Decompiled with Potassium's decompiler.

return {
    Name = "randomcosmetic",
    Description = "Places random cosmetics on the player(s) farm.",
    Group = "GameCommands",
    Aliases = { "rc" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "Which players to spawn cosmetics for."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "How many cosmetics to place.",
            Optional = true
        }, {
            Type = "string",
            Name = "cosmetic",
            Description = "Optional: specify a cosmetic type.",
            Optional = true
        } }
};