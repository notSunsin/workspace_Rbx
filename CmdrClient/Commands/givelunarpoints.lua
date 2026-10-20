-- Decompiled with Potassium's decompiler.

return {
    Name = "givelunarpoints",
    Description = "Gives Lunar Points to a specified player(s).",
    Group = "GameCommands",
    Aliases = { "givelp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to complete the track for."
        }, {
            Type = "number",
            Name = "amount",
            Description = "The amount of Lunar Points to give"
        } }
};