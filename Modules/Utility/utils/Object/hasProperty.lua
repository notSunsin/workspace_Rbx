-- Decompiled with Potassium's decompiler.

return function(u1, u2) -- Line: 1, Name: hasProperty
    local success, _ = pcall(function() -- Line: 2
        -- upvalues: u1 (copy), u2 (copy)
        u1[u2] = u1[u2];
    end);

    return success;
end;