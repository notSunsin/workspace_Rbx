-- Decompiled with Potassium's decompiler.

return {
    Name = "giveshard",
    Description = "Gives Spray Bottle to specified player(s) with a specified amount.",
    Group = "GameCommands",
    Aliases = { "gsh" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to give Shards to."
        }, {
            Type = "shardtype",
            Name = "shardtype(s)",
            Description = "The name of the Shard to give."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount given.",
            Optional = true
        }, {
            Type = "petmutation",
            Name = "mutation",
            Description = "The pet mutation type of the shard",
            Optional = true
        } }
};