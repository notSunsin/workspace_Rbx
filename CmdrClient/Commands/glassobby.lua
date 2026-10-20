-- Decompiled with Potassium's decompiler.

return {
    Name = "glassobby",
    Description = "Spawns local glass obby event",
    Group = "GameCommands",
    Aliases = { "glass obby", "obby" },
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