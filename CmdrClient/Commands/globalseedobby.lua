-- Decompiled with Potassium's decompiler.

return {
    Name = "globalseedobby",
    Description = "Spawns global seed obby event",
    Group = "GameCommands",
    Aliases = { "global seed obby", "global obby" },
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