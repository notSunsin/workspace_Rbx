-- Decompiled with Potassium's decompiler.

return {
    Name = "adjustbeehealth",
    Description = "Adjusts health of all active bees and wasps by amount. Positive heals, negative damages.",
    Group = "GameCommands",
    Args = { {
            Type = "number",
            Name = "Amount",
            Description = "Amount to adjust health by (positive = heal, negative = damage)"
        } }
};