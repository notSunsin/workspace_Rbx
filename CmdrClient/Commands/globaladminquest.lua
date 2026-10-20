-- Decompiled with Potassium's decompiler.

return {
    Name = "globaladminquest",
    Description = "Modify admin quests across all servers for all players.",
    Group = "GameCommands",
    Aliases = { "globaladminquest" },
    Args = { {
            Type = "adminquestaction",
            Name = "action",
            Description = "Action to take. CLEAR will DELETE the quest for ALL online players. BEWARE"
        }, {
            Type = "adminquest",
            Name = "quest",
            Description = "The Admin Quest name",
            Optional = true
        } }
};