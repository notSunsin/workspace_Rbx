-- Decompiled with Potassium's decompiler.

return function(p1: userdata, p2: string, p3: boolean?) -- Line: 3, Name: findFirstAncestorWithTag
    if not p1 then
        return nil;
    end;

    if not p1:IsA("Instance") then
        return nil;
    end;

    if not p2 or p2 == "" then
        return nil;
    end;

    if p3 ~= true then
        p1 = p1.Parent;
    end;

    while p1 do
        if p1:HasTag(p2) then
            return p1;
        end;

        p1 = p1.Parent;
    end;

    return nil;
end;