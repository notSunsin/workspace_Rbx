-- Decompiled with Potassium's decompiler.

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(u1) -- Line: 6
    -- upvalues: LocalPlayer (copy)
    local Util = u1.Util;
    local Window = require(script:WaitForChild("Window"));
    Window.Cmdr = u1;
    local u2 = require(script:WaitForChild("AutoComplete"))(u1);
    Window.AutoComplete = u2;

    function Window.ProcessEntry(p3) -- Line: 17
        -- upvalues: Util (copy), Window (copy), u1 (copy), LocalPlayer (ref)
        local v4 = Util.TrimString(p3);

        if #v4 == 0 then
            return;
        end;

        Window:AddLine(Window:GetLabel() .. " " .. v4, Color3.fromRGB(255, 223, 93));
        Window:AddLine(u1.Dispatcher:EvaluateAndRun(v4, LocalPlayer, {
            IsHuman = true
        }));
    end;

    function Window.OnTextChanged(p5) -- Line: 30
        -- upvalues: u1 (copy), LocalPlayer (ref), Util (copy), Window (copy), u2 (copy)
        local v6 = u1.Dispatcher:Evaluate(p5, LocalPlayer, true);
        local v7 = Util.SplitString(p5);
        local table_remove_ret = table.remove(v7, 1);
        local v8;

        if v6 then
            v7 = Util.MashExcessArguments(v7, #v6.Object.Args);

            if #v7 == #v6.Object.Args then
                v8 = true;
            else
                v8 = false;
            end;
        else
            v8 = false;
        end;

        local v9;

        if table_remove_ret then
            v9 = #v7 > 0;
        else
            v9 = table_remove_ret;
        end;

        if p5:sub(#p5, #p5):match("%s") and not v8 then
            v7[#v7 + 1] = "";
            v9 = true;
        end;

        if v6 and v9 then
            local v10, v11 = v6:Validate();
            Window:SetIsValidInput(v10, ("Validation errors: %s"):format(v11 or ""));
            local v12 = {};
            local Argument = v6:GetArgument(#v7);

            if Argument then
                local TextSegmentInProgress = Argument.TextSegmentInProgress;
                local v13 = false;

                if Argument.RawSegmentsAreAutocomplete then
                    for i, v in ipairs(Argument.RawSegments) do
                        v12[i] = { v, v };
                    end;
                else
                    local Autocomplete, v14 = Argument:GetAutocomplete();
                    v13 = (v14 or {}).IsPartial or false;

                    for i, v in pairs(Autocomplete) do
                        v12[i] = { TextSegmentInProgress, v };
                    end;
                end;

                local v15;

                if #TextSegmentInProgress > 0 then
                    v15, v11 = Argument:Validate();
                else
                    v15 = true;
                end;

                if not v8 and v15 then
                    Window:HideInvalidState();
                end;

                local v16 = {};

                if v8 then
                    v8 = #p5 - #TextSegmentInProgress + (p5:sub(#p5, #p5):match("%s") and -1 or 0);
                end;

                v16.at = v8;
                v16.prefix = #Argument.RawSegments == 1 and (Argument.Prefix or "") or "";
                local v17;

                if #v6.Arguments == #v6.ArgumentDefinitions then
                    v17 = #TextSegmentInProgress > 0;
                else
                    v17 = false;
                end;

                v16.isLast = v17;
                v16.numArgs = #v7;
                v16.command = v6;
                v16.arg = Argument;
                v16.name = Argument.Name .. (Argument.Required and "" or "?");
                v16.type = Argument.Type.DisplayName;
                v16.description = v15 == false and v11 and v11 or Argument.Object.Description;
                v16.invalid = not v15;
                v16.isPartial = v13;

                return u2:Show(v12, v16);
            end;
        elseif table_remove_ret and #v7 == 0 then
            Window:SetIsValidInput(true);
            local Command = u1.Registry:GetCommand(table_remove_ret);
            local v18 = nil;

            if Command then
                v18 = {
                    Command.Name,
                    Command.Name,
                    options = {
                        name = Command.Name,
                        description = Command.Description
                    }
                };
                local v19 = Command.Args and Command.Args[1];

                if type(v19) == "function" then
                    v19 = v19(v6);
                end;

                if v19 and (not v19.Optional and v19.Default == nil) then
                    Window:SetIsValidInput(false, "This command has required arguments.");
                    Window:HideInvalidState();
                end;
            else
                Window:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(table_remove_ret));
            end;

            local v20 = { v18 };

            for _, v in pairs(u1.Registry:GetCommandNames()) do
                if table_remove_ret:lower() == v:lower():sub(1, #table_remove_ret) and (v18 == nil or v18[1] ~= table_remove_ret) then
                    local Command2 = u1.Registry:GetCommand(v);
                    v20[#v20 + 1] = {
                        table_remove_ret,
                        v,
                        options = {
                            name = Command2.Name,
                            description = Command2.Description
                        }
                    };
                end;
            end;

            return u2:Show(v20);
        end;

        Window:SetIsValidInput(false, "Use the help command to see all available commands.");
        u2:Hide();
    end;

    Window:UpdateLabel();
    Window:UpdateWindowHeight();

    return {
        Window = Window,
        AutoComplete = u2
    };
end;