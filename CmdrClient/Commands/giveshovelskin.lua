-- Decompiled with Potassium's decompiler.

return {
    Name = "giveshovelskin",
    Description = "Gives a shovel skin to specific player(s).",
    Group = "GameCommands",
    Aliases = { "gss" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give the shovel skin to."
        }, {
            Type = "strictshovelskinname",
            Name = "shovelskinname(s)",
            Description = "The shovel skin(s) to give."
        } }
};