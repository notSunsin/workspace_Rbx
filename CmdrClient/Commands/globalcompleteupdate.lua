-- Decompiled with Potassium's decompiler.

return {
    Name = "globalcompleteupdate",
    Description = "Force-complete the update timer on ALL servers. Requires double confirmation.",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "boolean",
            Name = "AreYouSure",
            Description = "Confirm you want to complete the update everywhere."
        }, {
            Type = "boolean",
            Name = "AreYouDoubleSure",
            Description = "Confirm AGAIN - this drops the update on every server."
        } }
};