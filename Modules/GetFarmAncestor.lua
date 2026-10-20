-- Decompiled with Potassium's decompiler.

local Farm = workspace:WaitForChild("Farm");

return function(p1: userdata) -- Line: 3, Name: GetFarmAncestor
    -- upvalues: Farm (copy)
    for _, child in Farm:GetChildren() do
        if child:IsAncestorOf(p1) then
            return child;
        end;
    end;

    return nil;
end;