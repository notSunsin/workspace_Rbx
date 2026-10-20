-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local ShopTabData = require(ReplicatedStorage.Data.ShopTabData);

return {
    IsTabUnlocked = function(p1: table, p2: string, p3: string) -- Line: 16, Name: IsTabUnlocked
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if not Data then
            return false;
        end;

        local v4 = Data.ShopTabData[p2];

        if not v4 then
            return false;
        end;

        for _, v in v4 do
            if table.find(v4, v) then
                return true;
            end;
        end;

        return false;
    end,

    IsItemLockedByTab = function(p5: table, p6: string, p7: string) -- Line: 43, Name: IsItemLockedByTab
        -- upvalues: ShopTabData (copy)
        local v8 = ShopTabData[p6];

        if not v8 then
            return nil;
        end;

        local v9 = {};

        for i, v in v8 do
            local v10 = i;

            for _, v2 in v.TabItems do
                if v2 == p7 then
                    table.insert(v9, v10);
                end;
            end;
        end;

        if #v9 > 0 then
            return v9;
        end;

        return nil;
    end
};