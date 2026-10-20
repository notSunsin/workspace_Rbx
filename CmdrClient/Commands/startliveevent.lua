-- Decompiled with Potassium's decompiler.

return {
    Name = "startliveevent",
    Description = "Starts a live event. Local to this server by default, pass global to broadcast to all servers.",
    Group = "GameCommands",
    Aliases = { "sle", "startliveevent" },
    Args = { {
            Type = "liveevent",
            Name = "event",
            Description = "The live event to start."
        }, {
            Type = "boolean",
            Name = "global",
            Description = "If true, broadcasts to all servers. Defaults to false (local only).",
            Optional = true
        } }
};