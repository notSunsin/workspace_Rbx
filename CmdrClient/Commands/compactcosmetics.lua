-- Decompiled with Potassium's decompiler.

return {
    Name = "compactcosmetics",
    Description = "Folds surplus identical cosmetics into CosmeticData.Pool now and reports profile size before/after.",
    Group = "GameCommands",
    Aliases = { "compc" },
    Args = { {
            Type = "players",
            Name = "to",
            Description = "The player(s) to compact."
        } }
};