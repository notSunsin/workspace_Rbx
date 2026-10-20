-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Freeze = require(ReplicatedStorage.FFlags.Packages.Freeze);
require(script.Parent.Types);

return table.freeze({
    SerializedNone = "\0",
    ShouldMock = RunService:IsStudio() and not RunService:IsRunning() or _G.NOCOLOR,

    getValue = function(p1) -- Line: 30, Name: getValue
        -- upvalues: Freeze (copy)
        if p1 == Freeze.None or p1 == "\0" then
            return nil;
        end;

        return p1;
    end,

    getPathTable = function(p2) -- Line: 10, Name: getPathTable
        if type(p2) == "table" then
            return table.clone(p2);
        end;

        return type(p2) ~= "string" and { p2 } or string.split(p2, ".");
    end,

    getPathString = function(p3) -- Line: 20, Name: getPathString
        if type(p3) == "string" then
            return p3;
        end;

        if type(p3) == "table" then
            return table.concat(p3, ".");
        end;

        return tostring(p3);
    end,

    safeCancelThread = function(p4: thread) -- Line: 34, Name: safeCancelThread
        if coroutine.status(p4) ~= "dead" then
            pcall(task.cancel, p4);
        end;
    end,

    trimString = function(p5: string) -- Line: 40, Name: trimString
        return string.gsub(p5, "^%s*(.-)%s*$", "%1");
    end,

    checkForTrimmedString = function(p6: string) -- Line: 44, Name: checkForTrimmedString
        return p6 ~= string.gsub(p6, "^%s*(.-)%s*$", "%1");
    end
});