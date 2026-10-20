-- Decompiled with Potassium's decompiler.

return {
    Name = "setnpcpoints",
    Description = "Sets specified NPC points to amount for player(s)",
    Group = "GameCommands",
    Aliases = { "snp" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to set NPC Points for."
        }, {
            Type = "npcnametype",
            Name = "for",
            Description = "The NPC to set points for."
        }, {
            Type = "integer",
            Name = "quantity",
            Description = "The amount to set to.",
            Optional = true
        } }
};