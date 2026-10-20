-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    GetRepStorageFolder = function(p1: table, p2: string) -- Line: 7, Name: GetRepStorageFolder
        -- upvalues: ReplicatedStorage (copy)
        local EventTimingStorage = ReplicatedStorage.EventTimingStorage;
        local v3 = EventTimingStorage:FindFirstChild(p2);

        if not v3 then
            v3 = Instance.new("Folder");
            v3.Name = p2;
            v3.Parent = EventTimingStorage;
        end;

        return v3;
    end
};