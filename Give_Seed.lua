-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Item_Module = require(ReplicatedStorage.Item_Module);
local u1 = RunService:IsServer();

return {
    Give_Seed = function(p2: userdata, u3: string, p4: number?, p5: string?) -- Line: 14, Name: Give_Seed
        -- upvalues: u1 (copy), Item_Module (copy)
        assert(u1);
        local ServerScriptService = game:GetService("ServerScriptService");
        local ServerStorage = game:GetService("ServerStorage");
        local InventoryService = require(ServerScriptService.Modules.InventoryService);
        local u6 = p5 == nil and "Normal" or p5;

        if not table.find(Item_Module.VariantNames, u6) then
            warn((`Invalid variation given in Give_Seed, got "{u6}"\n{debug.traceback()}`));
            u6 = "Normal";
        end;

        if p4 ~= nil and (type(p4) ~= "number" or (p4 <= 0 or p4 ~= p4)) then
            return nil;
        end;

        if not ServerStorage.Seed_Models:FindFirstChild(u3) then
            warn((`Seed "{u3}" does not exists\n{debug.traceback()}`));

            return nil;
        end;

        local v7 = p4 or 1;
        local v10 = InventoryService:Find(p2, "Seed", function(p8: table) -- Line: 42
            -- upvalues: u3 (copy), u6 (ref)
            local v9;

            if p8.ItemName == u3 then
                v9 = p8.Variant == u6;
            else
                v9 = false;
            end;

            return v9;
        end);
        local v11, v12 = next(v10);

        if not v12 then
            return InventoryService:CreateItem(p2, "Seed", {
                ItemName = u3,
                Quantity = v7,
                Variant = u6
            });
        end;

        local ItemData = v12.ItemData;
        ItemData.Quantity = ItemData.Quantity + v7;

        return v11;
    end
};