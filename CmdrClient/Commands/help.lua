-- Decompiled with Potassium's decompiler.

return {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Group = "Help",
    Args = { {
            Type = "command",
            Name = "Command",
            Description = "The command to view information on",
            Optional = true
        } },

    ClientRun = function(p1, p2) -- Line: 31, Name: ClientRun
        if p2 then
            local Command = p1.Cmdr.Registry:GetCommand(p2);
            p1:Reply(`Command: {Command.Name}`, Color3.fromRGB(230, 126, 34));

            if Command.Aliases and #Command.Aliases > 0 then
                p1:Reply(`Aliases: {table.concat(Command.Aliases, ", ")}`, Color3.fromRGB(230, 230, 230));
            end;

            p1:Reply(Command.Description, Color3.fromRGB(230, 230, 230));

            for i, v in ipairs(Command.Args) do
                p1:Reply((`#{i} {v.Name}{v.Optional == true and "?" or ""}: {v.Type} - {v.Description}`));
            end;
        else
            p1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n");
            p1:Reply("Tips\n----\n• Utilize the Tab key to automatically complete commands\n• Easily select and copy command output\n");
            local Commands = p1.Cmdr.Registry:GetCommands();
            table.sort(Commands, function(p3, p4) -- Line: 49
                if p3.Group and p4.Group then
                    return p3.Group < p4.Group;
                end;

                return p3.Group;
            end);
            local v5 = nil;

            for _, v in ipairs(Commands) do
                v.Group = v.Group or "No Group";

                if v5 ~= v.Group then
                    p1:Reply((`\n{v.Group}\n{string.rep("-", #v.Group)}`));
                    v5 = v.Group;
                end;

                local v6;

                if v.Description then
                    v6 = `{v.Name} - {v.Description}`;
                else
                    v6 = v.Name;
                end;

                p1:Reply(v6);
            end;
        end;

        return "";
    end
};