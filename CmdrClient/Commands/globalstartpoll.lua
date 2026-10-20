-- Decompiled with Potassium's decompiler.

return {
    Name = "globalstartpoll",
    Description = "Create a community poll across all servers. Provide a title, 2 options, optional duration, and optional hex colors.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "title",
            Description = "The poll question."
        }, {
            Type = "string",
            Name = "option 1"
        }, {
            Type = "string",
            Name = "option 2"
        }, {
            Type = "number",
            Name = "duration",
            Description = "How long the poll lasts in seconds (default 60).",
            Optional = true
        }, {
            Type = "string",
            Name = "color 1",
            Description = "Hex color for option 1 (e.g. 4CAF50). Defaults to green.",
            Optional = true
        }, {
            Type = "string",
            Name = "color 2",
            Description = "Hex color for option 2 (e.g. F44336). Defaults to red.",
            Optional = true
        } }
};