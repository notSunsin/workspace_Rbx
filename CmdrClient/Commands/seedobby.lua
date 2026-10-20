-- Decompiled with Potassium's decompiler.

return {
    Name = "seedobby",
    Description = "Spawns obby event",
    Group = "GameCommands",
    Aliases = { "seed obby", "obby" },
    Args = { {
            Type = "seedname",
            Name = "seedname",
            Description = "The Seed to give at the end of the obby."
        }, {
            Type = "strictvariant",
            Name = "variant",
            Description = "The variant",
            Optional = true
        } }
};