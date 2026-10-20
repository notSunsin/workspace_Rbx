-- Decompiled with Potassium's decompiler.

return {
    Name = "skipcampfirecraftingwithslot",
    Description = "Instantly finish a specific campfire craft slot for a player.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The player(s) whose craft to skip."
        }, {
            Type = "integer",
            Name = "slot",
            Description = "Crafting slot (1-3)."
        } }
};