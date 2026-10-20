-- Decompiled with Potassium's decompiler.

return {
    Name = "mutateplant",
    Description = "Changes specified player(s) currently held plant to a specified mutation.",
    Group = "GameCommands",
    Aliases = { "mp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to mutate held plants."
        }, {
            Type = "mutation",
            Name = "mutation",
            Description = "The mutation type!"
        } }
};