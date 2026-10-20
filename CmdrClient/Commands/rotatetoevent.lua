-- Decompiled with Potassium's decompiler.

return {
    Name = "rotatetoevent",
    Description = "Rotates to the next specified event or the next event in the event rotation",
    Group = "GameCommands",
    Args = { {
            Type = "scheduledEvent",
            Name = "EventID",
            Description = "The event to move to",
            Optional = true
        }, {
            Type = "number",
            Name = "Transition Time",
            Description = "Amount of time before the target event appears. (Note: The event before the target will appear during this transition time)",
            Optional = true
        } }
};