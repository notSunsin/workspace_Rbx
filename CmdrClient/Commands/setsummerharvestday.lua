-- Decompiled with Potassium's decompiler.

return {
    Name = "setsummerharvestday",
    Description = "Testing: forces the current Summer Harvest event day (shifts the event window). Use 0 to reset back to the update-drop default.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "integer",
            Name = "Day",
            Description = "Day to jump to (1..TotalDays). 0 = reset to the default (starts on update drop)."
        } }
};