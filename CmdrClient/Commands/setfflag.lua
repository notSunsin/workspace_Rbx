-- Decompiled with Potassium's decompiler.

return {
    Name = "setfflag",
    Description = "set fflag!",
    Group = "GameCommands",
    Aliases = { "setfflag" },
    Args = { {
            Type = "fflag",
            Name = "fflag",
            Description = "The fflag to set."
        }, {
            Type = "string",
            Name = "Value",
            Description = "Set any arbitrary value! Numbers and Booleans will be auto serialized into proper data types!"
        } }
};