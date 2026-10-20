-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TableUtils = require(ReplicatedStorage.Modules.TableUtils);
require(script.Parent);

local function IsOrderCombo(p1: table) -- Line: 15
    local v2;

    if type(p1) == "table" then
        v2 = type(p1.Order) == "table";
    else
        v2 = false;
    end;

    return v2;
end;

local function IsRequireCombo(p3: table) -- Line: 39
    local v4;

    if type(p3) == "table" then
        v4 = type(p3.Requires) == "table";
    else
        v4 = false;
    end;

    return v4;
end;

local v5 = { "Drenched", "Wet" };
local u6 = {
    BestWet = {
        Order = v5
    },
    BestAmber = {
        Order = { "AncientAmber", "OldAmber", "Amber" }
    },
    BestCooked = {
        Order = { "Cooked", "Burnt" }
    },
    BestWeeping = {
        Order = { "Desolate", "Withered", "Wilted" }
    },
    Frozen = {
        LargerArrayName = "Water Mutations",
        Requires = {
            v5,
            { "Chilled" }
        },
        Results = { "Frozen" },
        ResultsOverwrite = TableUtils:MakeTable(v5, "Chilled")
    },
    Paradisal = {
        Requires = { { "Verdant" }, { "Sundried" } },
        Results = { "Paradisal" },
        ResultsOverwrite = TableUtils:MakeTable("Verdant", "Sundried")
    },
    Clay = {
        LargerArrayName = "Water Mutations",
        Requires = {
            v5,
            { "Sandy" }
        },
        Results = { "Clay" },
        ResultsOverwrite = TableUtils:MakeTable(v5, "Sandy")
    },
    Ceramic = {
        LargerArrayName = "Heat Mutations",
        Requires = { { "Clay" }, { "Burnt", "Fried", "Cooked", "Molten", "Sundried" } },
        Results = { "Ceramic" },
        ResultsOverwrite = TableUtils:MakeTable("Burnt", "Fried", "Cooked", "Clay")
    },
    Tempestuous = {
        Requires = { { "Windstruck" }, { "Twisted" } },
        Results = { "Tempestuous" },
        ResultsOverwrite = TableUtils:MakeTable("Windstruck", "Twisted")
    },
    HarmonisedChakra = {
        Requires = { { "Chakra" }, { "CorruptChakra" } },
        Results = { "HarmonisedChakra" },
        ResultsOverwrite = TableUtils:MakeTable("Chakra", "CorruptChakra")
    },
    HarmonisedFoxfireChakra = {
        Requires = { { "FoxfireChakra" }, { "CorruptFoxfireChakra" } },
        Results = { "HarmonisedFoxfireChakra" },
        ResultsOverwrite = TableUtils:MakeTable("FoxfireChakra", "CorruptFoxfireChakra")
    },
    AscendedChakra = {
        Requires = { { "HarmonisedChakra" }, { "HarmonisedFoxfireChakra" } },
        Results = { "AscendedChakra" },
        ResultsOverwrite = TableUtils:MakeTable("HarmonisedChakra", "HarmonisedFoxfireChakra")
    },
    Spaghetti = {
        Requires = { { "Pasta" }, { "Sauce" }, { "Meatball" } },
        Results = { "Spaghetti" },
        ResultsOverwrite = TableUtils:MakeTable("Pasta", "Sauce", "Meatball")
    },
    Maelstrom = {
        Requires = { { "Tempestuous" }, { "Cyclonic" } },
        Results = { "Maelstrom" },
        ResultsOverwrite = TableUtils:MakeTable("Tempestuous", "Cyclonic")
    },
    Gloom = {
        Requires = { { "Bloom" }, { "Rot" } },
        Results = { "Gloom" },
        ResultsOverwrite = TableUtils:MakeTable("Bloom", "Rot")
    },
    Umbral = {
        Requires = { { "Blight" }, { "Pestilent" } },
        Results = { "Umbral" },
        ResultsOverwrite = TableUtils:MakeTable("Blight", "Pestilent")
    },
    Shadowbound = {
        Requires = { { "Gloom" }, { "Umbral" } },
        Results = { "Shadowbound" },
        ResultsOverwrite = TableUtils:MakeTable("Bloom", "Rot", "Blight", "Pestilent")
    },
    Corrosive = {
        Requires = { { "Toxic" }, { "Acidic" } },
        Results = { "Corrosive" },
        ResultsOverwrite = TableUtils:MakeTable("Toxic", "Acidic")
    },
    Stormcharged = {
        Requires = { { "Shocked" }, { "Static" }, { "Tempestuous" } },
        Results = { "Stormcharged" },
        ResultsOverwrite = TableUtils:MakeTable("Shocked", "Static", "Tempestuous")
    },
    Cosmic = {
        Requires = { { "Celestial" }, { "Aurora" } },
        Results = { "Cosmic" },
        ResultsOverwrite = TableUtils:MakeTable("Celestial", "Aurora")
    },
    Abyssal = {
        Requires = { { "Eclipsed" }, { "Voidtouched" } },
        Results = { "Abyssal" },
        ResultsOverwrite = TableUtils:MakeTable("Eclipsed", "Voidtouched")
    },
    Blazing = {
        Requires = { { "Molten" }, { "Flaming" } },
        Results = { "Blazing" },
        ResultsOverwrite = TableUtils:MakeTable("Molten", "Flaming")
    },
    Infernal = {
        Requires = { { "Meteoric" }, { "Blazing" } },
        Results = { "Infernal" },
        ResultsOverwrite = TableUtils:MakeTable("Meteoric", "Blazing")
    },
    Plagued = {
        Requires = { { "Zombified" }, { "Infected" } },
        Results = { "Plagued" },
        ResultsOverwrite = TableUtils:MakeTable("Zombified", "Infected")
    },
    Astral = {
        Requires = { { "Cosmic" }, { "Galactic" } },
        Results = { "Astral" },
        ResultsOverwrite = TableUtils:MakeTable("Cosmic", "Galactic")
    },
    Sizzled = {
        Requires = { { "Cooked" }, { "Fried" } },
        Results = { "Sizzled" },
        ResultsOverwrite = TableUtils:MakeTable("Cooked", "Fried")
    },
    OilBoil = {
        Requires = { { "Oil" }, { "Boil" } },
        Results = { "OilBoil" },
        ResultsOverwrite = TableUtils:MakeTable("Oil", "Boil")
    },
    Biohazard = {
        Requires = { { "Radioactive" }, { "Plagued" } },
        Results = { "Biohazard" },
        ResultsOverwrite = TableUtils:MakeTable("Radioactive", "Plagued")
    },
    Contagion = {
        Requires = { { "Corrosive" }, { "Biohazard" } },
        Results = { "Contagion" },
        ResultsOverwrite = TableUtils:MakeTable("Toxic", "Acidic", "Zombified", "Infected", "Radioactive", "Plagued", "Corrosive", "Biohazard")
    },
    Slashbound = {
        Requires = { { "Sliced" }, { "Severed" } },
        Results = { "Slashbound" },
        ResultsOverwrite = TableUtils:MakeTable("Sliced", "Severed")
    },
    Gourmet = {
        Requires = { { "Aromatic" }, { "Spaghetti" }, { "Sizzled" } },
        Results = { "Gourmet" },
        ResultsOverwrite = TableUtils:MakeTable("Aromatic", "Spaghetti", "Sizzled")
    },
    Grim = {
        Requires = { { "Shadowbound" }, { "Blackout" } },
        Results = { "Grim" },
        ResultsOverwrite = TableUtils:MakeTable("Bloom", "Rot", "Blight", "Pestilent", "Blackout", "Shadowbound", "Blackout")
    },
    SunScorched = {
        Requires = { { "Arid" }, { "Mirage" } },
        Results = { "SunScorched" },
        ResultsOverwrite = TableUtils:MakeTable("Arid", "Mirage")
    },
    Supernatural = {
        Requires = { { "Vamp" }, { "Spooky" }, { "Ghostly" } },
        Results = { "Supernatural" },
        ResultsOverwrite = TableUtils:MakeTable("Vamp", "Spooky", "Ghostly")
    },
    Riptide = {
        Requires = { { "Typhoon" }, { "Monsoon" } },
        Results = { "Riptide" },
        ResultsOverwrite = TableUtils:MakeTable("Typhoon", "Monsoon")
    },
    Stormbound = {
        Requires = { { "Riptide" }, { "Stormcharged" } },
        Results = { "Stormbound" },
        ResultsOverwrite = TableUtils:MakeTable("Typhoon", "Monsoon", "Shocked", "Static", "Tempestuous", "Riptide", "Stormcharged")
    },
    Extraterrestrial = {
        Requires = { { "Alienlike" }, { "Alienated" } },
        Results = { "Extraterrestrial" },
        ResultsOverwrite = TableUtils:MakeTable("Alienlike", "Alienated")
    },
    Mineral = {
        Requires = { { "Tempered" }, { "Geode" }, { "Charcoal" } },
        Results = { "Mineral" },
        ResultsOverwrite = TableUtils:MakeTable("Tempered", "Geode", "Charcoal")
    },
    MindBender = {
        Requires = { { "Brainrot" }, { "Warped" } },
        Results = { "MindBender" },
        ResultsOverwrite = TableUtils:MakeTable("Brainrot", "Warped")
    },
    Affluent = {
        Requires = { { "Fortune" }, { "Jackpot" }, { "Coin" } },
        Results = { "Affluent" },
        ResultsOverwrite = TableUtils:MakeTable("Fortune", "Jackpot", "Coin")
    },
    Fractured = {
        Requires = { { "Glitched" }, { "Plasma" } },
        Results = { "Fractured" },
        ResultsOverwrite = TableUtils:MakeTable("Glitched", "Plasma")
    },
    Fierywork = {
        Requires = { { "Fiery" }, { "Firework" } },
        Results = { "Fierywork" },
        ResultsOverwrite = TableUtils:MakeTable("Fiery", "Firework")
    },
    Confection = {
        Requires = { { "Choc" }, { "Gummy" }, { "Candy" } },
        Results = { "Confection" },
        ResultsOverwrite = TableUtils:MakeTable("Choc", "Gummy", "Candy")
    }
};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local v11 = {};

local function HandleOrderCombo(p12: table, p13: userdata) -- Line: 18
    local v14 = false;

    for _, v in p12.Order do
        if v14 then
            p13:SetAttribute(v, nil);
        elseif p13:GetAttribute(v) then
            v14 = true;
        end;
    end;
end;

local function HandleRequireCombo(p15: table, p16: userdata) -- Line: 42
    if p15.ResultsOverwrite then
        local v17 = true;

        for _, v in p15.Results do
            if not p16:GetAttribute(v) then
                v17 = false;
                break;
            end;
        end;

        if v17 then
            for _, v in p15.ResultsOverwrite do
                p16:SetAttribute(v, nil);
            end;

            return;
        end;
    end;

    local v18 = true;

    for _, v in p15.Requires do
        local v19 = false;

        for _, v2 in v do
            if p16:GetAttribute(v2) then
                v19 = true;
                break;
            end;
        end;

        if not v19 then
            v18 = false;
        end;
    end;

    if v18 then
        if p15.ResultsOverwrite then
            for _, v in p15.ResultsOverwrite do
                p16:SetAttribute(v, nil);
            end;
        end;

        for _, v in p15.Results do
            p16:SetAttribute(v, true);
        end;
    end;
end;

for i, v in u6 do
    local v20;

    if type(v) == "table" then
        v20 = type(v.Order) == "table";
    else
        v20 = false;
    end;

    if v20 then
        u9[i] = v;
        local v21 = i;

        for _, v2 in v.Order do
            u10[v2] = v21;
        end;
    else
        local v22;

        if type(v) == "table" then
            v22 = type(v.Requires) == "table";
        else
            v22 = false;
        end;

        if v22 then
            u7[i] = v;
            local v23 = i;

            for _, v2 in v.Requires do
                for _, v3 in v2 do
                    if not u8[v3] then
                        u8[v3] = { v23 };
                    end;

                    table.insert(u8[v3], v23);
                end;
            end;
        end;
    end;
end;

local function HandleOrderCombosFromString(p24: table, p25: boolean?) -- Line: 544
    -- upvalues: TableUtils (copy), u10 (copy), u9 (copy)
    local v26 = p25 == true and p24 and p24 or TableUtils:DeepCopy(p24);
    local v27 = {};

    for _, v in v26 do
        local v28 = u10[v];

        if v28 then
            if v27[v28] then
                table.insert(v27[v28], v);
            else
                v27[v28] = { v };
            end;
        end;
    end;

    for i, v in v27 do
        local v29 = v;
        local v30 = nil;

        for _, v2 in u9[i].Order do
            if table.find(v29, v2) then
                v30 = v2;
                break;
            end;
        end;

        for _, v2 in v29 do
            if v2 ~= v30 then
                local table_find_ret = table.find(v26, v2);

                if table_find_ret then
                    table.remove(v26, table_find_ret);
                end;
            end;
        end;
    end;

    return v26;
end;

local function HandleRequireCombosFromString(p31: table, p32: boolean?) -- Line: 605
    -- upvalues: TableUtils (copy), u8 (copy), u7 (copy)
    local v33 = p32 == true and p31 and p31 or TableUtils:DeepCopy(p31);
    local v34 = {};

    for _, v in v33 do
        local v35 = u8[v];

        if v35 then
            local v36 = v;

            for _, v2 in v35 do
                if table.find(v33, v2) then
                    local v37 = u7[v2];

                    if v37 then
                        for _, v3 in v37.ResultsOverwrite do
                            local table_find_ret = table.find(v33, v3);

                            if table_find_ret then
                                table.remove(v33, table_find_ret);
                            end;
                        end;
                    end;
                elseif v34[v2] then
                    table.insert(v34[v2], v36);
                else
                    v34[v2] = { v36 };
                end;
            end;
        end;
    end;

    for i, v in v34 do
        local v38 = u7[i];

        if v38 then
            local v39 = #v38.Requires;
            local v40 = i;
            local v41 = v;

            for _, v2 in v38.Requires do
                local v42 = v2;

                for _, v3 in v41 do
                    if table.find(v42, v3) then
                        v39 = v39 - 1;
                        break;
                    end;
                end;
            end;

            if v39 == 0 then
                for _, v2 in v38.ResultsOverwrite do
                    local table_find_ret = table.find(v33, v2);

                    if table_find_ret then
                        table.remove(v33, table_find_ret);
                    end;
                end;

                table.insert(v33, v40);
            end;
        end;
    end;

    return v33;
end;

function v11.HandleCombos(p43: table, p44: userdata) -- Line: 679
    -- upvalues: u6 (copy), HandleOrderCombo (copy), HandleRequireCombo (copy)
    if p44 then
        for i, v in u6 do
            if v then
                local v45;

                if type(v) == "table" then
                    v45 = type(v.Order) == "table";
                else
                    v45 = false;
                end;

                if v45 then
                    HandleOrderCombo(v, p44);
                else
                    local v46;

                    if type(v) == "table" then
                        v46 = type(v.Requires) == "table";
                    else
                        v46 = false;
                    end;

                    if v46 then
                        HandleRequireCombo(v, p44);
                    end;
                end;
            else
                warn((`No comboData for {i}`));
            end;
        end;

        return;
    end;

    warn("No Plant");
end;

function v11.GetRandomAssortmentOfValidMutations(p47: table, p48: table, p49: number, p50: boolean?) -- Line: 707
    -- upvalues: TableUtils (copy), HandleOrderCombosFromString (copy), HandleRequireCombosFromString (copy)
    local Random_new_ret = Random.new();
    local v51 = TableUtils:DeepCopy(p48);
    Random_new_ret:Shuffle(v51);
    local v52 = {};

    for i = 1, p49 do
        local table_remove_ret = table.remove(v51, 1);

        if not table_remove_ret then
            break;
        end;

        table.insert(v52, table_remove_ret);
        local _ = i;
    end;

    return HandleRequireCombosFromString((HandleOrderCombosFromString(v52)));
end;

local function IsOrderComboFromMutName(p53: string) -- Line: 775
    -- upvalues: u9 (copy)
    for i, v in u9 do
        if table.find(v.Order, p53) then
            return i;
        end;
    end;

    return nil;
end;

function v11.GetComboData(p54: string) -- Line: 785
    -- upvalues: u9 (copy), u6 (copy)
    local v55 = {
        Type = nil,
        Data = nil
    };
    local v56 = nil;

    for i, v in u9 do
        if table.find(v.Order, p54) then
            v56 = i;
            break;
        end;
    end;

    local v57 = u6[p54];

    if not (v57 or v56) then
        return v55;
    end;

    if v56 then
        v55.Type = "Chain Combo";
    else
        local v58;

        if type(v57) == "table" then
            v58 = type(v57.Requires) == "table";
        else
            v58 = false;
        end;

        if v58 then
            v55.Type = "Fusion Combo";
        end;
    end;

    v55.Data = v57 or u6[v56];

    return v55;
end;

return v11;