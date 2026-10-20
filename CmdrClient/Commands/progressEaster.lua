-- Decompiled with Potassium's decompiler.

return {
    Description = "Adds progress to a player\'s Easter event progression",
    Group = "GameCommands",
    Name = script.Name,
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to progress."
        }, {
            Type = "number",
            Name = "amount",
            Description = "How much progression to add."
        } }
};