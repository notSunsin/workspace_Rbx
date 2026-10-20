-- Decompiled with Potassium's decompiler.

return {
    Suffixes = { "CENT", "VIG", "NOV", "OCT", "SEP", "SXD", "QUI", "QUA", "TR", "DU", "UN", "DE", "NO", "OC", "SP", "SX", "QI", "QA", "T", "B", "M", "K" },
    TimeLengths = {
        workspace:GetServerTimeNow() - 86400,
        workspace:GetServerTimeNow() - 604800,
        workspace:GetServerTimeNow() - 2592000,
        workspace:GetServerTimeNow() - 4320000
    },
    TimeLengthDisplay = { "24 Hours", "7 Days", "30 Days", "50 Days" }
};