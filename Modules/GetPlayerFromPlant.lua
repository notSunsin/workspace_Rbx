-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return function(p1: userdata) -- Line: 4, Name: GetPlayerFromPlant
    -- upvalues: Players (copy)
    local v2 = p1:FindFirstAncestor("Important");
    local v3;

    if v2 then
        v3 = v2:FindFirstChild("Data");
    else
        v3 = nil;
    end;

    local v4;

    if v3 then
        v4 = v3:FindFirstChild("Owner");
    else
        v4 = nil;
    end;

    if v4 and v4.Value then
        return Players:FindFirstChild(v4.Value);
    end;

    return nil;
end;