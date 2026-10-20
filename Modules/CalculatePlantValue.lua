-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Item_Module = require(ReplicatedStorage.Item_Module);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local u1 = { {
        X = 0,
        Y = 0
    }, {
        X = 1000000000000,
        Y = 1000000000000
    }, {
        X = 20000000000000,
        Y = 12000000000000
    }, {
        X = 50000000000000,
        Y = 28000000000000
    }, {
        X = 100000000000000,
        Y = 50000000000000
    }, {
        X = 750000000000000,
        Y = 310000000000000
    } };
local u2 = { 0, 1000000000000, 10000000000000, 25000000000000, 40000000000000, 280000000000000 };
local u3 = DateTime.fromUniversalTime(2025, 10, 11, 14).UnixTimestamp // 86400;
local u4 = DateTime.fromUniversalTime(2025, 10, 18, 14).UnixTimestamp // 86400;
local u5 = u4 - u3;

local function GetCurrentCurvePoints() -- Line: 31
    -- upvalues: u3 (copy), u4 (copy), u5 (copy), u1 (copy), u2 (copy)
    local v6 = workspace:GetServerTimeNow() // 86400;
    local v7 = (math.clamp(v6, u3, u4) - u3) / u5;
    local math_clamp_ret = math.clamp(v7, 0, 1);
    local table_clone_ret = table.clone(u1);

    for i = 1, #table_clone_ret do
        table_clone_ret[i] = {
            X = table_clone_ret[i].X,
            Y = math.lerp(table_clone_ret[i].Y, u2[i], math_clamp_ret) // 1
        };
        local _ = i;
    end;

    return table_clone_ret;
end;

local function GetCurveValue(p8) -- Line: 45
    -- upvalues: GetCurrentCurvePoints (copy)
    local v9 = GetCurrentCurvePoints();

    for i = 2, #v9 do
        local v10 = v9[i - 1];
        local v11 = v9[i];

        if v10.X <= p8 and p8 <= v11.X then
            return (v11.Y - v10.Y) / (v11.X - v10.X) * (p8 - v10.X) + v10.Y;
        end;

        local _ = i;
    end;

    local v12 = v9[#v9 - 1];
    local v13 = v9[#v9];

    return (v13.Y - v12.Y) / (v13.X - v12.X) * (p8 - v12.X) + v12.Y;
end;

local function CalculateFromValues(p14: string, p15: string, p16: number, p17: number, p18: number?) -- Line: 60
    -- upvalues: Item_Module (copy), PlantTraitsData (copy), GetCurveValue (copy)
    local v19 = Item_Module.Return_Data(p14);

    if not v19 or #v19 < 3 then
        warn("CalculatePlantValueFromData | ItemData is invalid for plant:", p14);

        return 0;
    end;

    local v20 = v19[3];
    local v21 = v19[2];
    local v22 = Item_Module.Return_Variant_Multiplier(p15);

    if PlantTraitsData.HasTrait(p14, "Honey") then
        v22 = math.log10(10 + v22);
    end;

    local math_clamp_ret = math.clamp(p16 / v21, 0.95, 100000000);
    local v23 = v20 * p17 * v22 * (math_clamp_ret * math_clamp_ret);

    if (p18 or 0) >= 1 then
        local v24 = GetCurveValue(v23);
        v23 = math.max(v24, 0);
    end;

    return math.round(v23);
end;

local function CalculateFromPlant(p25: userdata) -- Line: 97
    -- upvalues: MutationHandler (copy), InventoryServiceEnums (copy), CalculateFromValues (copy)
    local Item_String = p25:FindFirstChild("Item_String");
    local v26 = Item_String and Item_String.Value or p25.Name;
    local Variant = p25:FindFirstChild("Variant");

    if not Variant then
        return 0;
    end;

    local Weight = p25:FindFirstChild("Weight");

    if not Weight then
        return 0;
    end;

    local v27 = MutationHandler:CalcValueMulti(p25);
    local v28 = p25:GetAttribute("FruitVersion") or (p25:GetAttribute(InventoryServiceEnums.FruitVersion) or 0);

    return CalculateFromValues(v26, Variant.Value, Weight.Value, v27, v28);
end;

return function(p29) -- Line: 113, Name: CalculatePlantValue
    -- upvalues: CalculateFromPlant (copy), CalculateFromValues (copy)
    if not p29 then
        warn("No plant or Values given!");

        return 0;
    end;

    if typeof(p29) == "Instance" then
        return CalculateFromPlant(p29);
    end;

    if typeof(p29) == "table" then
        return CalculateFromValues(p29.name, p29.variant, p29.weight, p29.mutationMultiplier, p29.fruitVersion);
    end;

    warn((`CalculatePlantValue | Invalid plant/value type: {typeof(p29)}`));

    return 0;
end;