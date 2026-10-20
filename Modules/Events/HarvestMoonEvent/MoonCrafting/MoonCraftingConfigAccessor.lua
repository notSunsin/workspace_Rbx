-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local MoonCraftingConfig = require(ReplicatedStorage.Data.Events.HarvestMoonEvent.MoonCraftingConfig);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local u1 = {};

local function IsArray(p2) -- Line: 96
    if type(p2) ~= "table" then
        return false;
    end;

    local v3 = 0;

    for i in p2 do
        if type(i) ~= "number" then
            return false;
        end;

        v3 = v3 + 1;
    end;

    for i = 1, v3 do
        if p2[i] == nil then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local function ValidateItemEntry(p4: any, p5: string) -- Line: 119
    -- upvalues: IsArray (copy)
    if type(p4) ~= "table" then
        return false, `{p5} is not a table`;
    end;

    if type(p4.ItemType) ~= "string" or p4.ItemType == "" then
        return false, `{p5}.ItemType must be a non-empty string`;
    end;

    if type(p4.ItemData) ~= "table" then
        return false, `{p5}.ItemData must be a table`;
    end;

    if type(p4.ItemData.ItemName) ~= "string" or p4.ItemData.ItemName == "" then
        return false, `{p5}.ItemData.ItemName must be a non-empty string`;
    end;

    if p4.ItemData.Quantity ~= nil and type(p4.ItemData.Quantity) ~= "number" then
        return false, `{p5}.ItemData.Quantity must be a number when present`;
    end;

    if p4.ItemData.AcceptedNames ~= nil then
        if not IsArray(p4.ItemData.AcceptedNames) then
            return false, `{p5}.ItemData.AcceptedNames must be an array when present`;
        end;

        for i, v in p4.ItemData.AcceptedNames do
            if type(v) ~= "string" or v == "" then
                return false, `{p5}.ItemData.AcceptedNames[{i}] must be a non-empty string`;
            end;
        end;
    end;

    return true;
end;

function u1.Validate(p6) -- Line: 154
    -- upvalues: IsArray (copy), ValidateItemEntry (copy)
    if type(p6) ~= "table" then
        return false, `config is a {typeof(p6)}, expected a table`;
    end;

    if p6.SchemaVersion ~= 1 then
        return false, `SchemaVersion is {tostring(p6.SchemaVersion)}, this build expects {1}`;
    end;

    if type(p6.Enabled) ~= "boolean" then
        return false, "Enabled must be a boolean";
    end;

    if p6.Station ~= nil then
        if type(p6.Station) ~= "table" then
            return false, "Station must be a table when present";
        end;

        local Capacity = p6.Station.Capacity;

        if Capacity ~= nil and (type(Capacity) ~= "number" or Capacity < 1) then
            return false, "Station.Capacity must be a number >= 1 when present";
        end;
    end;

    if not IsArray(p6.Recipes) then
        return false, "Recipes must be an array";
    end;

    local v7 = {};

    for i, v in p6.Recipes do
        local v8 = `Recipes[{i}]`;

        if type(v) ~= "table" then
            return false, `{v8} is not a table`;
        end;

        if type(v.Id) ~= "string" or v.Id == "" then
            return false, `{v8}.Id must be a non-empty string`;
        end;

        if v7[v.Id] then
            return false, `duplicate recipe Id "{v.Id}"`;
        end;

        v7[v.Id] = true;

        if type(v.TimeToCraft) ~= "number" or v.TimeToCraft < 0 then
            return false, `{v8}.TimeToCraft must be a number >= 0`;
        end;

        if not IsArray(v.Inputs) or #v.Inputs == 0 then
            return false, `{v8}.Inputs must be a non-empty array`;
        end;

        local v9 = v;

        for i2, v2 in v.Inputs do
            local v10, v11 = ValidateItemEntry(v2, (`{v8}.Inputs[{i2}]`));

            if not v10 then
                return false, v11;
            end;
        end;

        if not IsArray(v9.Outputs) or #v9.Outputs == 0 then
            return false, `{v8}.Outputs must be a non-empty array`;
        end;

        for i2, v2 in v9.Outputs do
            local v12, v13 = ValidateItemEntry(v2, (`{v8}.Outputs[{i2}]`));

            if not v12 then
                return false, v13;
            end;
        end;

        local RequiredSummonContributions = v9.RequiredSummonContributions;

        if RequiredSummonContributions ~= nil and (type(RequiredSummonContributions) ~= "number" or RequiredSummonContributions < 0) then
            return false, `{v8}.RequiredSummonContributions must be a number >= 0 when present`;
        end;

        if v9.Cost ~= nil then
            if type(v9.Cost) ~= "table" then
                return false, `{v8}.Cost must be a table when present`;
            end;

            if type(v9.Cost.CurrencyType) ~= "string" or v9.Cost.CurrencyType == "" then
                return false, `{v8}.Cost.CurrencyType must be a non-empty string`;
            end;

            if type(v9.Cost.Amount) ~= "number" or v9.Cost.Amount < 0 then
                return false, `{v8}.Cost.Amount must be a number >= 0`;
            end;
        end;
    end;

    return true;
end;

local u14 = setmetatable({}, {
    __mode = "k"
});
local u15 = setmetatable({}, {
    __mode = "k"
});
local u16 = setmetatable({}, {
    __mode = "k"
});

local function BuildIndexes(p17: table) -- Line: 264
    local v18 = {};
    local v19 = {};

    for _, v in p17.Recipes do
        v18[v.Id] = v;
        table.insert(v19, v);
    end;

    table.sort(v19, function(p20: table, p21: table) -- Line: 275
        local v22 = p20.LayoutOrder or 0;
        local v23 = p21.LayoutOrder or 0;

        if v22 == v23 then
            return p20.Id < p21.Id;
        end;

        return v22 < v23;
    end);

    return {
        RecipesById = v18,
        SortedRecipes = v19
    };
end;

local function GetIndexes(p24: table) -- Line: 289
    -- upvalues: u14 (copy), BuildIndexes (copy)
    local v25 = u14[p24];

    if v25 then
        return v25;
    end;

    local v26 = BuildIndexes(p24);
    u14[p24] = v26;

    return v26;
end;

function u1.Get(p27) -- Line: 301
    -- upvalues: GameConfigController (copy), MoonCraftingConfig (copy), u15 (copy), u1 (copy), u16 (copy)
    local Config = GameConfigController:GetConfig("MoonCraftingConfig");

    if Config == MoonCraftingConfig then
        return MoonCraftingConfig;
    end;

    if Config == nil then
        return MoonCraftingConfig;
    end;

    local v28 = u15[Config];

    if v28 ~= nil then
        if v28 then
            return Config;
        end;

        return MoonCraftingConfig;
    end;

    local v29, v30 = u1.Validate(Config);
    u15[Config] = v29;

    if v29 then
        return Config;
    end;

    if not u16[Config] then
        u16[Config] = true;
        warn((`[MoonCrafting] Live "MoonCraftingConfig" rejected ({v30}); falling back to the baked default.`));
    end;

    return MoonCraftingConfig;
end;

function u1.IsEnabled(p31) -- Line: 336
    return p31:Get().Enabled == true;
end;

function u1.GetUIText(p32: table, p33: string, p34: string) -- Line: 340
    local UI = p32:Get().UI;

    if UI then
        UI = UI[p33];
    end;

    if type(UI) == "string" then
        return UI;
    end;

    return p34;
end;

function u1.GetStationSettings(p35) -- Line: 347
    local Station = p35:Get().Station;

    return type(Station) ~= "table" and {} or Station;
end;

function u1.GetCapacity(p36) -- Line: 353
    local Capacity = p36:GetStationSettings().Capacity;

    return (type(Capacity) ~= "number" or Capacity < 1) and 1 or Capacity;
end;

function u1.GetPromptObjectText(p37) -- Line: 358
    local PromptObjectText = p37:GetStationSettings().PromptObjectText;

    return (type(PromptObjectText) ~= "string" or PromptObjectText == "") and "Moon Crafting" or PromptObjectText;
end;

function u1.GetRecipe(p38: table, p39: string) -- Line: 363
    -- upvalues: u14 (copy), BuildIndexes (copy)
    if type(p39) ~= "string" then
        return nil;
    end;

    local v40 = p38:Get();
    local v41 = u14[v40];

    if not v41 then
        v41 = BuildIndexes(v40);
        u14[v40] = v41;
    end;

    return v41.RecipesById[p39];
end;

function u1.GetRecipes(p42) -- Line: 374
    -- upvalues: u14 (copy), BuildIndexes (copy)
    local v43 = p42:Get();
    local v44 = u14[v43];

    if not v44 then
        v44 = BuildIndexes(v43);
        u14[v43] = v44;
    end;

    return v44.SortedRecipes;
end;

function u1.GetSkipProductId(p45) -- Line: 386
    -- upvalues: DevProductIds (copy)
    local SkipProductId = p45:Get().SkipProductId;

    if type(SkipProductId) == "number" then
        return SkipProductId;
    end;

    local SkipMoonCrafting = DevProductIds.SkipMoonCrafting;

    return SkipMoonCrafting and SkipMoonCrafting.PurchaseID or 0;
end;

function u1.GetRequiredSummonContributions(p46: table, p47: table) -- Line: 401
    if type(p47) ~= "table" then
        return 0;
    end;

    local RequiredSummonContributions = p47.RequiredSummonContributions;

    return (type(RequiredSummonContributions) ~= "number" or RequiredSummonContributions <= 0) and 0 or RequiredSummonContributions;
end;

function u1.GetRemainingSummonContributions(p48: table, p49: table, p50: number?) -- Line: 411
    local RequiredSummonContributions = p48:GetRequiredSummonContributions(p49);

    return RequiredSummonContributions == 0 and 0 or math.max(RequiredSummonContributions - (p50 or 0), 0);
end;

function u1.IsRecipeUnlocked(p51: table, p52: table, p53: number?) -- Line: 420
    return p51:GetRemainingSummonContributions(p52, p53) == 0;
end;

function u1.GetLockedText(p54: table, p55: number) -- Line: 428
    local v56;

    if p55 == 1 then
        v56 = p54:GetUIText("LockedTextSingular", "Summon Harvest Moon [COUNT] time<br/>to unlock");
    else
        v56 = p54:GetUIText("LockedText", "Summon Harvest Moon [COUNT] times<br/>to unlock");
    end;

    return string.gsub(v56, "%[COUNT%]", (tostring(p55)));
end;

function u1.GetRecipeDisplayName(p57: table, p58: table) -- Line: 446
    if type(p58) ~= "table" then
        return "?";
    end;

    if type(p58.DisplayName) == "string" and p58.DisplayName ~= "" then
        return p58.DisplayName;
    end;

    local v59 = p58.Outputs and p58.Outputs[1];
    local v60 = v59 and v59.ItemData and v59.ItemData.ItemName;

    if type(v60) == "string" and v60 ~= "" then
        return v60;
    end;

    return tostring(p58.Id);
end;

local v61, v62 = u1.Validate(MoonCraftingConfig);

if not v61 and RunService:IsStudio() then
    warn((`[MoonCrafting] Baked MoonCraftingConfig is INVALID: {v62}`));
end;

return u1;