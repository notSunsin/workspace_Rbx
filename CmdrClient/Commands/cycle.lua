-- Decompiled with Potassium's decompiler.

return {
    Name = "cycle",
    Description = "Starts Cycle",
    Group = "GameCommands",
    Aliases = { "cycle" },
    Args = { {
            Type = "cycle",
            Name = "Name",
            Description = "The Cycle to trigger"
        }, {
            Type = "cycleaction",
            Name = "Action",
            Description = "Force start, force end the cycle, or clear the forced state."
        } }
};