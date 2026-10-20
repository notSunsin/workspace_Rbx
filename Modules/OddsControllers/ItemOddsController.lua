-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    ConnectOddsButton = function(p1: table, p2: any, p3: userdata, u4: userdata?) -- Line: 17, Name: ConnectOddsButton
        -- upvalues: SeedPackOddsController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy)
        local Type = p2.Type;
        local Value = p2.Value;

        if Type == "Seed Pack" then
            p3.Visible = true;
            p3.Activated:Connect(function() -- Line: 23
                -- upvalues: SeedPackOddsController (ref), Value (copy), u4 (copy)
                SeedPackOddsController:Open(Value, u4);
            end);

            return;
        end;

        if Type == "Egg" then
            p3.Visible = true;
            p3.Activated:Connect(function() -- Line: 28
                -- upvalues: PetEggOddsController (ref), Value (copy), u4 (copy)
                PetEggOddsController:Open(Value, u4);
            end);

            return;
        end;

        if Type ~= "Crate" then
            p3.Visible = false;

            return;
        end;

        p3.Visible = true;
        p3.Activated:Connect(function() -- Line: 33
            -- upvalues: CosmeticCrateOddsController (ref), Value (copy), u4 (copy)
            CosmeticCrateOddsController:Open(Value, u4);
        end);
    end
};