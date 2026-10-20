-- Decompiled with Potassium's decompiler.

local function ErrorHandler(p1) -- Line: 20
    warn((`{tostring(p1)}\nStack Begin\n{debug.traceback(nil, 3)}Stack End`));
end;

local function Handle(p2: function, p3: boolean, ...) -- Line: 24
    -- upvalues: ErrorHandler (copy)
    xpcall(p2, ErrorHandler);

    if not p3 then
        error((select(1, ...)));
    end;

    return ...;
end;

return function(p4: function, p5: function, ...) -- Line: 32, Name: Finally
    -- upvalues: Handle (copy), ErrorHandler (copy)
    return Handle(p5, xpcall(p4, ErrorHandler, ...));
end;