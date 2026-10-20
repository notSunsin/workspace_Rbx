-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");

return function(p1) -- Line: 3, Name: CreateTagHandler
    -- upvalues: CollectionService (copy)
    local Tag = p1.Tag;
    local v2 = p1.OnInstanceAdded or function() -- Line: 5
    end;
    local v3 = p1.OnInstanceRemoved or function() -- Line: 6
    end;

    for _, v in CollectionService:GetTagged(Tag) do
        task.spawn(v2, v);
    end;

    CollectionService:GetInstanceAddedSignal(Tag):Connect(v2);
    CollectionService:GetInstanceRemovedSignal(Tag):Connect(v3);
end;