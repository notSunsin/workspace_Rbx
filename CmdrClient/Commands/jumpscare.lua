-- Decompiled with Potassium's decompiler.

return {
    Name = "jumpscare",
    Description = "Pull a funny on a player :)",
    Group = "GameCommands",
    Aliases = { "js" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to jumpscare"
        }, {
            Type = "jumpscaretype",
            Name = "Type",
            Description = "Type of jumpscare."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount of delay in seconds before the jumpscare happens",
            Optional = true
        } }
};