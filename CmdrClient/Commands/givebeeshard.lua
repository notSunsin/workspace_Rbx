-- Decompiled with Potassium's decompiler.

return {
    Name = "givebeeshard",
    Description = "Gives a bee enchantment shard to specific player(s) with a specified number of uses.",
    Group = "GameCommands",
    Aliases = { "gbshard" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give the shard to."
        }, {
            Type = "beeenchantment",
            Name = "enchantment",
            Description = "The enchantment the shard applies."
        }, {
            Type = "number",
            Name = "quantity",
            Description = "Number of uses on the shard.",
            Optional = true
        } }
};