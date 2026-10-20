-- Decompiled with Potassium's decompiler.

local GGUI = require(script.Parent.GGUI);
local v1 = {};
local RarityLayoutMap = require(script.Parent.DataModules.GGStaticData).RarityLayoutMap;

local function GetName(p2) -- Line: 8
    return tostring(p2.Name or "");
end;

local function GetRarityValue(p3) -- Line: 12
    -- upvalues: RarityLayoutMap (copy)
    if p3.Rarity then
        return RarityLayoutMap[p3.Rarity];
    end;

    return nil;
end;

local u30 = {
    Alphabet = function(p4, p5) -- Line: 20, Name: AlphaSort
        return tostring(p4.Name or "") < tostring(p5.Name or "");
    end,

    RarityAsc = function(p6, p7) -- Line: 24, Name: RarityAsc
        -- upvalues: RarityLayoutMap (copy)
        local v8;

        if p6.Rarity then
            v8 = RarityLayoutMap[p6.Rarity];
        else
            v8 = nil;
        end;

        local v9;

        if p7.Rarity then
            v9 = RarityLayoutMap[p7.Rarity];
        else
            v9 = nil;
        end;

        if v8 == v9 then
            return tostring(p6.Name or "") < tostring(p7.Name or "");
        end;

        if v8 == nil then
            return false;
        end;

        return v9 == nil and true or v8 < v9;
    end,

    RarityDesc = function(p10, p11) -- Line: 43, Name: RarityDesc
        -- upvalues: RarityLayoutMap (copy)
        local v12;

        if p10.Rarity then
            v12 = RarityLayoutMap[p10.Rarity];
        else
            v12 = nil;
        end;

        local v13;

        if p11.Rarity then
            v13 = RarityLayoutMap[p11.Rarity];
        else
            v13 = nil;
        end;

        if v12 == v13 then
            return tostring(p10.Name or "") < tostring(p11.Name or "");
        end;

        if v12 == nil then
            return false;
        end;

        return v13 == nil and true or v13 < v12;
    end,

    Seen = function(p14, p15) -- Line: 62, Name: SeenSort
        local v16 = p14.Seen and 1 or 0;
        local v17 = p15.Seen and 1 or 0;

        if v16 == v17 then
            return tostring(p14.Name or "") < tostring(p15.Name or "");
        end;

        return v17 < v16;
    end,

    New = function(p18, p19) -- Line: 73, Name: NewSort
        local v20 = p18.New and 1 or 0;
        local v21 = p19.New and 1 or 0;

        if v20 == v21 then
            return tostring(p18.Name or "") < tostring(p19.Name or "");
        end;

        return v21 < v20;
    end,

    MasteryAsc = function(p22, p23) -- Line: 84, Name: MasteryAsc
        local v24 = tonumber(p22.MasteryProgress) or 0;
        local v25 = tonumber(p23.MasteryProgress) or 0;

        if v24 == v25 then
            return tostring(p22.Name or "") < tostring(p23.Name or "");
        end;

        return v24 < v25;
    end,

    MasteryDesc = function(p26, p27) -- Line: 95, Name: MasteryDesc
        local v28 = tonumber(p26.MasteryProgress) or 0;
        local v29 = tonumber(p27.MasteryProgress) or 0;

        if v28 == v29 then
            return tostring(p26.Name or "") < tostring(p27.Name or "");
        end;

        return v29 < v28;
    end
};
local u31 = {};
local u48 = {
    Rarity = function(p32: table, p33: string) -- Line: 116, Name: RarityFilter
        for i = #p32, 1, -1 do
            local v34;

            if p32[i].Rarity == p33 then
                v34 = i;
            else
                table.remove(p32, i);
                v34 = i;
            end;
        end;
    end,

    Boolean = function(p35: table, p36: string) -- Line: 124, Name: BooleanFilter
        for i = #p35, 1, -1 do
            local v37;

            if p35[i][p36] then
                v37 = i;
            else
                table.remove(p35, i);
                v37 = i;
            end;
        end;
    end,

    Event = function(p38: table, p39: string) -- Line: 132, Name: EventFilter
        for i = #p38, 1, -1 do
            local v40 = tostring(p38[i].Source or "");
            local v41;

            if p39 == "NonExclusive" then
                if string.find(v40, "Exclusive") then
                    table.remove(p38, i);
                    v41 = i;
                else
                    v41 = i;
                end;
            elseif string.find(v40, "Exclusive") then
                v41 = i;
            else
                table.remove(p38, i);
                v41 = i;
            end;
        end;
    end,

    Searchbar = function(p42: table, p43: string) -- Line: 148, Name: SearchbarFilter
        local string_gsub_ret = string.gsub(p43, "[^%w%s]", "");

        for i = #p42, 1, -1 do
            local string_lower_ret = string.lower((tostring(p42[i].Name or "")));
            local v44;

            if string.find(string_lower_ret, string.lower(string_gsub_ret)) then
                v44 = i;
            else
                table.remove(p42, i);
                v44 = i;
            end;
        end;
    end,

    Trait = function(p45: table, p46: string) -- Line: 160, Name: TraitFilter
        for i = #p45, 1, -1 do
            local string_lower_ret = string.lower((tostring(p45[i].Traits or "")));
            local v47;

            if string.find(string_lower_ret, string.lower(p46)) then
                v47 = i;
            else
                table.remove(p45, i);
                v47 = i;
            end;
        end;
    end
};

function v1.SetFilterStep(p49: string, p50: function?) -- Line: 180
    -- upvalues: u31 (copy)
    u31[p49] = p50;
end;

function v1.FilterAndSort(p51: table) -- Line: 184
    -- upvalues: u31 (copy), GGUI (copy), u48 (copy), u30 (copy)
    for _, v in u31 do
        v(p51);
    end;

    if GGUI.FilterAlgo and GGUI.FilterType then
        local v52 = u48[GGUI.FilterAlgo];

        if v52 then
            v52(p51, GGUI.FilterType);
        elseif GGUI.FilterType ~= "Reset" then
            warn((`No filter algo w/ name {GGUI.FilterAlgo}`));
        end;
    end;

    local v53 = u30[GGUI.SortAlgo or "RarityAsc"];

    if v53 then
        table.sort(p51, v53);

        return;
    end;

    warn((`No sort algo w/ name {GGUI.SortAlgo}`));
    table.sort(p51, u30.RarityAsc);
end;

return v1;