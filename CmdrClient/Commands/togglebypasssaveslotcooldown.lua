-- Decompiled with Potassium's decompiler.

return {
    Name = "togglebypasssaveslotcooldown",
    Description = "Toggle bypassing the save-slot load cooldown for a player.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "user",
            Description = "The player to toggle the save-slot cooldown bypass for."
        }, {
            Type = "boolean",
            Name = "bypass",
            Description = "Whether to bypass the cooldown (defaults to true).",
            Default = true
        } }
};