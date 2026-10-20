-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local u5 = {
    GetOwnedSkin = function(p1: table, p2: string, p3: string) -- Line: 11, Name: GetOwnedSkin
        -- upvalues: DataService (copy)
        local v4 = nil;
        local Data = DataService:GetData();

        if not Data then
            return v4;
        end;

        if p2 == "Fence" then
            return Data.FenceSkinData.OwnedFences[p3];
        end;

        if p2 == "Shovel" then
            return Data.ShovelSkinData.OwnedShovels[p3];
        end;

        if p2 == "TradeBooth" then
            v4 = Data.TradeBoothSkinData.OwnedSkins[p3];
        end;

        return v4;
    end
};

function u5.GetFrameVisibility(p6: table, p7: boolean, p8: any, p9: string, p10: string) -- Line: 29
    -- upvalues: u5 (copy)
    local v11 = p8.HiddenByDefault and not u5:GetOwnedSkin(p10, p9);

    if v11 then
        return false;
    end;

    return p7;
end;

return u5;