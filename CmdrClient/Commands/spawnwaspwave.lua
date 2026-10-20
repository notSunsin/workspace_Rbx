-- Decompiled with Potassium's decompiler.

return {
    Name = "spawnwaspwave",
    Description = "Spawns an admin wasp wave. Wasps are random types.",
    Group = "GameCommands",
    Args = { {
            Type = "number",
            Name = "Count",
            Description = "Number of wasps to spawn",
            Optional = true
        }, {
            Type = "boolean",
            Name = "Boss",
            Description = "Whether to spawn a boss after minions die (default: true)",
            Optional = true
        }, {
            Type = "number",
            Name = "Duration",
            Description = "How long the wave lasts in seconds (default: normal wave duration)",
            Optional = true
        } }
};