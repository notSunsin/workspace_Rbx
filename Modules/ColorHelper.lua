-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local v1 = {};

local function NormalizeColor3(p2) -- Line: 9
    local G = p2.G;
    local B = p2.B;

    return Color3.new(math.clamp(p2.R, 0, 1), math.clamp(G, 0, 1), (math.clamp(B, 0, 1)));
end;

function v1.BlendColorsHSV(p3: table, p4, p5, p6: number) -- Line: 22
    local G = p4.G;
    local B = p4.B;
    local Color3_new_ret = Color3.new(math.clamp(p4.R, 0, 1), math.clamp(G, 0, 1), (math.clamp(B, 0, 1)));
    local G2 = p5.G;
    local B2 = p5.B;
    local Color3_new_ret2 = Color3.new(math.clamp(p5.R, 0, 1), math.clamp(G2, 0, 1), (math.clamp(B2, 0, 1)));
    local v7, v8, v9 = Color3_new_ret:ToHSV();
    local v10, v11, v12 = Color3_new_ret2:ToHSV();

    if math.abs(v7 - v10) > 0.5 then
        if v10 < v7 then
            v10 = v10 + 1;
        else
            v7 = v7 + 1;
        end;
    end;

    return Color3.fromHSV((v7 + (v10 - v7) * p6) % 1, v8 + (v11 - v8) * p6, v9 + (v12 - v9) * p6);
end;

function v1.GetTraitColor(p13: table, p14: string) -- Line: 52
    -- upvalues: PlantTraitsData (copy)
    local v15 = PlantTraitsData.TraitColors[p14] or { 255, 255, 255 };

    return string.format("#%02X%02X%02X", v15[1], v15[2], v15[3]) or Color3.fromRGB(255, 255, 255):ToHex(), v15;
end;

function v1.Darken(p16: table, p17) -- Line: 59
    local v18, v19, v20 = p17:ToHSV();

    return Color3.fromHSV(v18, v19, v20 / 2);
end;

return v1;