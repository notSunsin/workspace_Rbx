-- Decompiled with Potassium's decompiler.

return {
    Name = "mutatepet",
    Description = "Changes specified player(s) currently held pet to a specified PetMutation.",
    Group = "GameCommands",
    Aliases = { "mpt" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to mutate held pet."
        }, {
            Type = "petmutation",
            Name = "PetMutation",
            Description = "The PetMutation type!"
        } }
};