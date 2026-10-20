-- Decompiled with Potassium's decompiler.

return {
    Name = "globalrsvp",
    Description = "Sends a RSVP Prompt to all servers",
    Group = "GameCommands",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "eventId",
            Description = "Id of the event"
        }, {
            Type = "string",
            Name = "platform",
            Description = "Target platforms to show RSVP example: pc/mobile/console or just pc/console. Defaults to pc/mobile/console",
            Optional = true
        } }
};