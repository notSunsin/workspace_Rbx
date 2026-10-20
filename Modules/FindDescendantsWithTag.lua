-- Decompiled with Potassium's decompiler.

return function(p1, p2) -- Line: 1, Name: GetDescendantsWithTag
    local v3 = {};

    for _, descendant in p1:GetDescendants() do
        if descendant:HasTag(p2) then
            table.insert(v3, descendant);
        end;
    end;

    return v3;
end;