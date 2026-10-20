-- Decompiled with Potassium's decompiler.

return {
    Name = "raffle",
    Description = "Manage raffles: draw, reset, status, flush.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "subcommand",
            Description = "Action to perform: draw, reset, status, flush."
        }, {
            Type = "string",
            Name = "args",
            Description = "Subcommand arguments (space-separated). See usage below.",
            Optional = true,
            Default = ""
        } }
};