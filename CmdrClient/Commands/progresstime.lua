-- Decompiled with Potassium's decompiler.

return {
    Name = "progresstime",
    Description = "Progresses time in the server in seconds.",
    Group = "GameCommands",
    Aliases = { "pt" },
    Args = { {
            Type = "player",
            Name = "to",
            Description = "The player(s) to progress held plants."
        }, {
            Type = "integer",
            Name = "Seconds",
            Description = "Time time progressed.",
            Optional = true
        } }
};