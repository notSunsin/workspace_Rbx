-- Decompiled with Potassium's decompiler.

return {
    Option = function(p1: table, p2: table) -- Line: 19, Name: Option
        return p2;
    end,

    PollType = {
        Single = "single",
        Multi = "multi",
        Tally = "tally"
    },
    PollStatus = {
        Pending = "pending",
        Active = "active",
        Closing = "closing",
        Closed = "closed"
    },

    Poll = function(p3: table, p4: table) -- Line: 53, Name: Poll
        return p4;
    end,

    ToString = function(p5: table, p6: table?) -- Line: 57, Name: ToString
        return not p6 and "nil" or `Id: {p6.Id}, Title: {p6.Title}, Status: {p6.Status}, Mode: {p6.Mode}, StartsAt: {p6.StartsAt}, EndsAt: {p6.EndsAt}`;
    end,

    Result = function(p7: table, p8: table) -- Line: 72, Name: Result
        return p8;
    end,

    PollConfig = function(p9: table, p10: table) -- Line: 85, Name: PollConfig
        return p10;
    end
};