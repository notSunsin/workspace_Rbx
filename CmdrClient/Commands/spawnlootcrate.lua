-- Decompiled with Potassium's decompiler.

return {
    Name = "spawnlootcrate",
    Description = "Spawns wasp-death loot crates near the target player(s). Same rewards a wasp would have dropped.",
    Group = "GameCommands",
    Aliases = { "slc" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to spawn loot crate(s) near."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "How many loot crates to spawn per player.",
            Optional = true
        }, {
            Type = "string",
            Name = "wasptype",
            Description = "Wasp name whose reward table to roll (Wasp, Razorsting Wasp, Acidwing Wasp, Dreadhorn Wasp, Wasp King). Default: Wasp.",
            Optional = true
        } }
};