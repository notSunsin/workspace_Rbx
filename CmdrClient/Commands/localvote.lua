-- Decompiled with Potassium's decompiler.

return {
    Name = "localvote",
    Description = "Start a vote for players to choose from.",
    Group = "GameCommands",
    Aliases = { "lv" },
    Args = { {
            Type = "string",
            Name = "vote topic",
            Description = "The topic to vote."
        }, {
            Type = "strings",
            Name = "vote options",
            Description = "The options to vote."
        }, {
            Type = "duration",
            Name = "duration seconds",
            Description = "How long the vote lasts",
            Optional = true
        } }
};