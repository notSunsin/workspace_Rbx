-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

return {
    Name = "bind",
    Description = "Binds a command string to a key or mouse input.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "userInput ! bindableResource @ player",
            Name = "Input",
            Description = "The key or input type you\'d like to bind the command to."
        }, {
            Type = "command",
            Name = "Command",
            Description = "The command you want to run on this input"
        }, {
            Type = "string",
            Name = "Arguments",
            Description = "The arguments for the command",
            Default = ""
        } },

    ClientRun = function(u1, u2, p3, p4) -- Line: 27, Name: ClientRun
        -- upvalues: UserInputService (copy)
        local Store = u1:GetStore("CMDR_Binds");
        local u5 = p3 .. " " .. p4;

        if Store[u2] then
            Store[u2]:Disconnect();
        end;

        local Name = u1:GetArgument(1).Type.Name;

        if Name == "userInput" then
            Store[u2] = UserInputService.InputBegan:Connect(function(p6, p7) -- Line: 39
                -- upvalues: u2 (copy), u1 (copy), u5 (ref)
                if p7 then
                    return;
                end;

                if p6.UserInputType == u2 or p6.KeyCode == u2 then
                    u1:Reply(u1.Dispatcher:EvaluateAndRun(u1.Cmdr.Util.RunEmbeddedCommands(u1.Dispatcher, u5)));
                end;
            end);
        else
            if Name == "bindableResource" then
                return "Unimplemented...";
            end;

            if Name == "player" then
                Store[u2] = u2.Chatted:Connect(function(p8) -- Line: 51
                    -- upvalues: u1 (copy), u5 (ref), u2 (copy)
                    local v9 = u1.Cmdr.Util.RunEmbeddedCommands(u1.Dispatcher, u1.Cmdr.Util.SubstituteArgs(u5, { p8 }));
                    u1:Reply(("%s $ %s : %s"):format(u2.Name, v9, u1.Dispatcher:EvaluateAndRun(v9)), Color3.fromRGB(244, 92, 66));
                end);
            end;
        end;

        return "Bound command to input.";
    end
};