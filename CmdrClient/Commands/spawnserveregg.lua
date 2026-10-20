-- Decompiled with Potassium's decompiler.

return {
    Description = "Testing command",
    Group = "GameCommands",
    Name = script.Name,
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give eggs to."
        }, {
            Type = "eggname",
            Name = "eggname(s)",
            Description = "The name of the egg to give."
        } }
};