-- Decompiled with Potassium's decompiler.

return {
    Name = "growbeanstalk",
    Description = "Grows the giants beanstalk",
    Group = "GameCommands",
    Aliases = { "gbs" },
    Args = { {
            Type = "boolean",
            Name = "don\'t active portals",
            Description = "Dont give contributions to activate the portals",
            Optional = true
        }, {
            Type = "number",
            Name = "beanstalk model num",
            Description = "The model number of the beanstalk you want to grow",
            Optional = true
        } }
};