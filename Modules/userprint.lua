-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return function(u1) -- Line: 3, Name: userprint
    -- upvalues: Players (copy)
    return function(...) -- Line: 4, Name: perthprint
        -- upvalues: Players (ref), u1 (copy)
        if Players:FindFirstChild(u1) then
            return print(...);
        end;
    end;
end;