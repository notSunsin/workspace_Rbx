-- Decompiled with Potassium's decompiler.

return {
    Name = "adminquest",
    Description = "Modify Admin Quest for specified player(s).",
    Group = "GameCommands",
    Aliases = { "adminquest" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to complete the achievement for."
        }, {
            Type = "adminquestaction",
            Name = "action",
            Description = "The action to take"
        }, {
            Type = "adminquest",
            Name = "quest",
            Description = "(Optional) Admin Quest name",
            Optional = true
        } }
};