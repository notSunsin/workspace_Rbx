-- Decompiled with Potassium's decompiler.

return {
    Name = "randomfarm",
    Description = "Spawns in completely random plants (or a specific crop) on the player(s) farm",
    Group = "GameCommands",
    Aliases = { "rf" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to spawn plants for."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount of plants to add.",
            Optional = true
        }, {
            Type = "seedname",
            Name = "seedname(s)",
            Description = "Optional: specify a crop type to only spawn that.",
            Optional = true
        } }
};