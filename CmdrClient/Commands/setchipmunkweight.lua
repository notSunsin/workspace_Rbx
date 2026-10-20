-- Decompiled with Potassium's decompiler.

return {
    Name = "setchipmunkweight",
    Description = "Sets the players Chubby Chipmunk weight",
    Group = "GameCommands",
    Aliases = { "chip" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to clear pet inventory."
        }, {
            Type = "number",
            Name = "weight",
            Description = "Desired weight"
        } }
};