-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return function(p1: userdata) -- Line: 3, Name: GetPlayerFromFarm
    -- upvalues: Players (copy)
    if not p1 then
        return;
    end;

    local Owner = p1:FindFirstChild("Owner", true);

    if Owner then
        return Players:FindFirstChild(Owner.Value);
    end;
end;