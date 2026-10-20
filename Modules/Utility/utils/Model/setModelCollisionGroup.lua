-- Decompiled with Potassium's decompiler.

return function(p1, p2) -- Line: 1, Name: setModelCollisionGroup
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = p2;
        end;
    end;
end;