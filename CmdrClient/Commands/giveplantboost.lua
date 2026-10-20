-- Decompiled with Potassium's decompiler.

return {
    Name = "giveplantboost",
    Description = "Gives plant boost to specified player(s) with a specified boost amount.",
    Group = "GameCommands",
    Aliases = { "gpb" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give plant boost to."
        }, {
            Type = "integer",
            Name = "Boost amount",
            Description = "The name of the Friendship Pot to give."
        } }
};