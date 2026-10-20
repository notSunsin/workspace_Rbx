-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");

return function(p1) -- Line: 4, Name: CreateTagHandlerWithAncestry
    -- upvalues: CollectionService (copy)
    local Tag = p1.Tag;
    local u2 = p1.OnInstanceAdded or function() -- Line: 6
    end;
    local u3 = p1.OnInstanceRemoved or function() -- Line: 7
    end;
    local u4 = p1.Ancestor or workspace;
    local u5 = {};
    local u6 = {};
    local u7 = 0;

    local function IsValidAncestry(p8) -- Line: 14
        -- upvalues: u4 (copy)
        return p8:IsDescendantOf(u4);
    end;

    local function HandleInstanceAdded(u9) -- Line: 18
        -- upvalues: u5 (copy), u4 (copy), u6 (copy), u7 (ref), u2 (copy), u3 (copy)
        u5[u9] = u9.AncestryChanged:Connect(function() -- Line: 19
            -- upvalues: u9 (copy), u4 (ref), u6 (ref), u7 (ref), u2 (ref), u3 (ref)
            if u9:IsDescendantOf(u4) then
                if not u6[u9] then
                    u6[u9] = true;
                    u7 = u7 + 1;
                    u2(u9);
                end;
            elseif u6[u9] then
                u6[u9] = nil;
                u7 = u7 - 1;
                u3(u9);
            end;
        end);

        if u9:IsDescendantOf(u4) and not u6[u9] then
            u6[u9] = true;
            u7 = u7 + 1;
            u2(u9);
        end;
    end;

    local function HandleInstanceRemoved(p10) -- Line: 44
        -- upvalues: u6 (copy), u7 (ref), u3 (copy), u5 (copy)
        if u6[p10] then
            u7 = u7 - 1;
            u6[p10] = nil;
            u3(p10);
        end;

        if u5[p10] then
            u5[p10]:Disconnect();
            u5[p10] = nil;
        end;
    end;

    for _, v in CollectionService:GetTagged(Tag) do
        task.spawn(HandleInstanceAdded, v);
    end;

    CollectionService:GetInstanceAddedSignal(Tag):Connect(HandleInstanceAdded);
    CollectionService:GetInstanceRemovedSignal(Tag):Connect(HandleInstanceRemoved);

    return {
        GetCount = function() -- Line: 66, Name: GetCount
            -- upvalues: u7 (ref)
            return u7;
        end,

        GetTrackedInstances = function() -- Line: 69, Name: GetTrackedInstances
            -- upvalues: u6 (copy)
            return u6;
        end
    };
end;