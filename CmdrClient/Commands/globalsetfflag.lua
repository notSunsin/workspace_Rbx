-- Decompiled with Potassium's decompiler.

return {
    Group = "DefaultAdmin",
    Name = script.Name,
    Aliases = { "sff" },
    Description = script.Name,
    Args = { {
            Type = "flagnames",
            Name = "ConfigName",
            Description = "Config to set!"
        }, {
            Type = "string",
            Name = "ConfigValue",
            Description = "Config to set!"
        } }
};