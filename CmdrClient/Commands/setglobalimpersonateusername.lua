-- Decompiled with Potassium's decompiler.

return {
    Name = "setglobalimpersonateusername",
    Description = "Sets your global notify username.",
    Group = "GameCommands",
    Aliases = { "sgiu" },
    Args = { {
            Type = "string",
            Name = "Username",
            Description = "The username to impersonate."
        }, {
            Type = "boolean",
            Name = "IsVerified",
            Description = "Adds a verified suffix to the username.",
            Optional = true
        } }
};