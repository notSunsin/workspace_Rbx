-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);

return function(p1) -- Line: 5, Name: CreateTagArray
    -- upvalues: CreateTagHandler (copy)
    local u2 = {};
    CreateTagHandler({
        Tag = p1,

        OnInstanceAdded = function(p3) -- Line: 9, Name: OnInstanceAdded
            -- upvalues: u2 (copy)
            if table.find(u2, p3) then
                return;
            end;

            table.insert(u2, p3);
        end,

        OnInstanceRemoved = function(p4) -- Line: 13, Name: OnInstanceRemoved
            -- upvalues: u2 (copy)
            local table_find_ret = table.find(u2, p4);

            if not table_find_ret then
                return;
            end;

            table.remove(u2, table_find_ret);
        end
    });

    return u2;
end;