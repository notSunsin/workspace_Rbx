-- Decompiled with Potassium's decompiler.

return {
    Name = "tutorialvariant",
    Description = "Sets the tutorial variant for the target user",
    Group = "GameCommands",
    Args = { {
            Type = "players",
            Name = "users",
            Description = "The player(s) to start tutorial for"
        }, {
            Type = "string",
            Name = "Variant",
            Description = "The variant to use"
        } }
};