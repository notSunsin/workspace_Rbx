-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = {};
local v3 = {};
local u4 = {};
local v5 = {};

for i, v in {
    Berry = require(script.Berry),
    Root = require(script.Root),
    Candy = require(script.Candy),
    Flower = require(script.Flower),
    Fruit = require(script.Fruit),
    Leafy = require(script.Leafy),
    Sour = require(script.Sour),
    Sweet = require(script.Sweet),
    Vegetable = require(script.Vegetable),
    Woody = require(script.Woody),
    Prickly = require(script.Prickly),
    Toxic = require(script.Toxic),
    Fungus = require(script.Fungus),
    Night = require(script.Night),
    Spicy = require(script.Spicy),
    Stalky = require(script.Stalky),
    Magical = require(script.Magical),
    Fall = require(script.Fall),
    Nutty = require(script.Nutty),
    Spooky = require(script.Spooky),
    Tropical = require(script.Tropical),
    Summer = require(script.Summer),
    Prehistoric = require(script.Prehistoric),
    Zen = require(script.Zen),
    Safari = require(script.Safari),
    Christmas = require(script.Christmas),
    Apple = require(script.Apple),
    Easter = require(script.Easter),
    EasterSlot = require(script.EasterSlot),
    HalloweenSlot = require(script.HalloweenSlot),
    Honey = require(script.Honey)
} do
    local v6 = i;
    local v7 = v;
    local v8 = {};

    for _, v2 in v.Plants do
        v8[v2] = true;
    end;

    v1[v6] = v7.Plants;
    u2[v6] = v8;
    v3[v6] = v6;

    if v7.Color then
        u4[v6] = v7.Color;
    end;

    v5[v6] = v8;
end;

v5.TraitNames = v3;
v5.Traits = v1;
v5.TraitColors = u4;

function v5.HasTrait(p9: string, p10: userdata) -- Line: 74
    -- upvalues: u2 (copy)
    if not p9 or p9 == "" then
        warn("PlantTraitsData.HasTrait | No plant name given!");

        return false;
    end;

    if p10 and p10 ~= "" then
        local v11 = u2[p10];

        return v11 and v11[p9] or false;
    end;

    warn("PlantTraitsData.HasTrait | No trait name given!");

    return false;
end;

function v5.GetTraits(p12: string) -- Line: 88
    -- upvalues: u2 (copy)
    if not p12 or p12 == "" then
        warn("PlantTraitsData.GetTraits | No plant name given!");

        return {};
    end;

    local v13 = {};

    for i, v in u2 do
        if v[p12] then
            table.insert(v13, i);
        end;
    end;

    return v13;
end;

function v5.GetTraitsAsString(p14: string) -- Line: 103
    -- upvalues: u2 (copy), u4 (copy)
    if not p14 or p14 == "" then
        warn("PlantTraitsData.GetTraitsAsString | No plant name given!");

        return "";
    end;

    local v15 = {};

    for i, v in u2 do
        if v[p14] then
            local v16 = u4[i] or { 255, 255, 255 };
            local v17 = `<font color="{string.format("#%02X%02X%02X", v16[1], v16[2], v16[3])}">{i}</font>`;
            table.insert(v15, v17);
        end;
    end;

    return table.concat(v15, ", ");
end;

return v5;