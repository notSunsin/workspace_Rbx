-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1, Name: findFirstChildOfClassAndName
    for _, child in pairs(p1:GetChildren()) do
        if child.Name == p3 and child:IsA(p2) then
            return child;
        end;
    end;

    return nil;
end;