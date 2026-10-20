-- Decompiled with Potassium's decompiler.

return {
    Name = "history",
    Description = "Displays previous commands from history.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = { "alias \"!|Displays previous command from history.\" run ${history $1{number|Line Number}}", "alias \"^|Runs the previous command, replacing all occurrences of A with B.\" run ${run replace ${history -1} $1{string|A} $2{string|B}}", "alias \"!!|Reruns the last command.\" ! -1" },
    Args = { {
            Type = "integer",
            Name = "Line Number",
            Description = "Command line number (can be negative to go from end)"
        } },

    ClientRun = function(p1, p2) -- Line: 19, Name: ClientRun
        local History = p1.Dispatcher:GetHistory();

        if p2 <= 0 then
            p2 = #History + p2;
        end;

        return History[p2] or "";
    end
};