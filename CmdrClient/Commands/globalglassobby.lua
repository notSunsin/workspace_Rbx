-- Decompiled with Potassium's decompiler.

return {
    Name = "globalglassobby",
    Description = "Spawns global glass obby event",
    Group = "GameCommands",
    Aliases = { "global glass obby", "global obby" },
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