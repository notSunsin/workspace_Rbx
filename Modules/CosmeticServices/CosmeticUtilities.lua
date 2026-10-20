-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local Manhattan2D = require(ReplicatedStorage.Code.Manhattan2D);
local GetCornersOfPart = require(ReplicatedStorage.Modules.GetCornersOfPart);

function u1.IsWithinFarm(p2: table, p3: userdata, p4) -- Line: 8
    -- upvalues: GetFarm (copy), Manhattan2D (copy)
    local v5 = GetFarm(p3);

    if v5 then
        return Manhattan2D(p4.Position, v5.PetArea);
    end;
end;

function u1.IsModelInFarm(p6: table, p7: userdata, p8, p9: userdata?) -- Line: 14
    -- upvalues: GetCornersOfPart (copy), u1 (copy)
    if not p9 then
        return false;
    end;

    local PrimaryPart = p9.PrimaryPart;

    if PrimaryPart then
        local v10 = PrimaryPart:Clone();
        v10.CFrame = p8 * CFrame.new(0, v10.Size.Y / 2, 0);
        local v11 = GetCornersOfPart(v10);
        v10:Destroy();

        for _, v in v11 do
            if not u1:IsWithinFarm(p7, v) then
                return false;
            end;
        end;

        return true;
    end;
end;

function u1.GetVariantModel(p12: table, p13: any, p14: string) -- Line: 36
    -- upvalues: u1 (copy)
    if not p13 then
        return nil;
    end;

    local Models = p13.Models;

    if Models and #Models > 0 then
        return Models[u1:GetDeterministicIndexFromUUID(p14, #Models)] or (Models[1] or p13.Model);
    end;

    return p13.Model;
end;

function u1.GetDeterministicIndexFromUUID(p15: table, p16: string, p17: number) -- Line: 48
    local v18 = 0;

    for i = 1, #p16 do
        v18 = (v18 + string.byte(p16, i) * i) % 2147483648;
        local _ = i;
    end;

    return v18 % p17 + 1;
end;

return u1;