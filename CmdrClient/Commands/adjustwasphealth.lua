-- Decompiled with Potassium's decompiler.

return {
    Name = "adjustwasphealth",
    Description = "Adjusts health of all active wasps by amount. Positive heals, negative damages.",
    Group = "GameCommands",
    Args = { {
            Type = "number",
            Name = "Amount",
            Description = "Amount to adjust health by (positive = heal, negative = damage)"
        } }
};