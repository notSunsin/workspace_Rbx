-- Decompiled with Potassium's decompiler.

local u3 = {
    FilterInput = function(p1: any, p2: number) -- Line: 9, Name: FilterInput
        return type(p1) ~= "string" and "" or p1:sub(1, 200):gsub("[^%w%s_%-]", ""):gsub("%s+", " "):sub(1, p2);
    end
};

function u3.Sanitize(p4: any, p5: number) -- Line: 20
    -- upvalues: u3 (copy)
    return u3.FilterInput(p4, p5):match("^%s*(.-)%s*$") or "";
end;

return u3;