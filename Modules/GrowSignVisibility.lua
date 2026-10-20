-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observers = require(ReplicatedStorage.Modules.Observers);

return Observers.observeTag("GrowSign", function(u1: userdata) -- Line: 6
    -- upvalues: Observers (copy)
    local Pivot = u1:GetPivot();

    return Observers.observeAttribute(u1, "Visible", function(p2) -- Line: 8
        -- upvalues: u1 (copy), Pivot (copy)
        if p2 then
            u1:PivotTo(Pivot);
        else
            u1:PivotTo(Pivot - Vector3.new(0, 100, 0));
        end;

        return nil;
    end);
end);