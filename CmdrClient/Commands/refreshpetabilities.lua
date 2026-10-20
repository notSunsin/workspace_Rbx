-- Decompiled with Potassium's decompiler.

return {
    Name = "refreshpetabilities",
    Description = "Refreshes all pet abilities for the specified player",
    Group = "GameCommands",
    Aliases = { "rfa" },
    Args = { {
            Type = "player",
            Name = "to",
            Description = "The player to refresh pet abilities for."
        } }
};