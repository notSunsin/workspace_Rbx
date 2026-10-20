-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SeedData = require(ReplicatedStorage.Data.SeedData);
local FoodRecipeData = require(ReplicatedStorage.Data.FoodRecipeData);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.GardenGuideData);
require(ReplicatedStorage.Data.GardenGuideData.GardenGuideTypes);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local u2 = {
    Data = {},
    Total = 0,
    Unlocked = {}
};
local Data = DataService:GetData();

local function SetRecipeData(p3: string) -- Line: 24
    -- upvalues: Data (copy), FoodRecipeData (copy), SeedData (copy)
    local v4 = {
        SpecificIngr = {},
        BroadIngr = {}
    };
    local PlantData = Data.GardenGuide.PlantData;
    local v5 = FoodRecipeData.Recipes[p3];

    if not v5 then
        warn((`No recipe data for {p3}`));

        return v4;
    end;

    if v5.Requires.Ingredients then
        for i, v in v5.Requires.Ingredients do
            if #v == 1 and PlantData[i] then
                v4.SpecificIngr[i] = {
                    Name = i,
                    ImageId = SeedData[i].FruitIcon
                };
            else
                if not v4.BroadIngr[i] then
                    v4.BroadIngr[i] = {};
                end;

                local v6 = i;

                for _, v2 in v do
                    if PlantData[v2] and not v4.BroadIngr[v6][v2] then
                        v4.BroadIngr[v6][v2] = v2;
                    end;
                end;
            end;
        end;

        return v4;
    end;

    if p3 == "Soup" then
        return {
            SpecificIngr = {
                [p3] = {
                    Name = "Any Plant",
                    ImageId = ""
                }
            },
            BroadIngr = {}
        };
    end;

    warn("no ingredients in", p3);

    return v4;
end;

local function FormatData(p7, p8, p9) -- Line: 83
    -- upvalues: NumberUtil (copy), SetRecipeData (copy)
    local v10 = "(Record not set)";
    local v11;

    if p9 then
        v11 = p9.MaxScale and (`{math.round(p9.MaxScale * 100) / 100}kg` or "-") or "-";

        if p9.MaxScaleTime then
            v10 = os.date("%B %d %Y", p9.MaxScaleTime);
        elseif p9.MaxScale then
            v10 = os.date("%B %d %Y", os.time());
        end;
    else
        v11 = "-";
    end;

    local v12 = "(Record not set)";
    local v13;

    if p9 then
        v13 = p9.MostValue and (NumberUtil.FormatCompactPrice(p9.MostValue) or "-") or "-";

        if p9.MostValueTime then
            v12 = os.date("%B %d %Y", p9.MostValueTime);
        elseif p9.MostValue then
            v12 = os.date("%B %d %Y", os.time());
        end;
    else
        v13 = "-";
    end;

    local v14 = "(Record not set)";
    local v15;

    if p9 then
        v15 = p9.BestMutations or "-";

        if p9.BestMutationsTime then
            v14 = os.date("%B %d %Y", p9.BestMutationsTime);
        elseif p9.BestMutations then
            v14 = os.date("%B %d %Y", os.time());
        end;
    else
        v15 = "-";
    end;

    local v16 = {
        ImageId = p8 and (p8.ImageId or "") or "",
        Name = p7
    };
    local v17;

    if p9 then
        v17 = p9.NewFood or false;
    else
        v17 = false;
    end;

    v16.New = v17;
    v16.Seen = p9 and true or false;
    v16.HarvestedCount = p9 and (p9.CookCount or 0) or 0;
    v16.Progress = p9 and (p9.CookCount or 0) or 0;
    v16.Time = NumberUtil.compactFormat(p8.BaseTime);
    v16.RecipeData = SetRecipeData(p7);
    v16.Records = {
        {
            RecordName = "Heaviest Cooked",
            RecordData = v11,
            RecordDate = v10
        },
        {
            RecordName = "Most Valuable",
            RecordData = v13,
            RecordDate = v12
        },
        {
            RecordName = "Best Mutations",
            RecordData = v15,
            RecordDate = v14
        }
    };

    return v16;
end;

local function GatherData() -- Line: 149
    -- upvalues: FoodRecipeData (copy), u1 (copy), u2 (copy)
    for i, _ in FoodRecipeData.RecipeNames do
        if not u1.FoodBlacklist[i] then
            local v18 = u2;
            v18.Total = v18.Total + 1;

            if not u2.Data[i] then
                u2.UpdateData(i);
            end;
        end;
    end;
end;

function u2.UpdateData(p19: string) -- Line: 159
    -- upvalues: FoodRecipeData (copy), Data (copy), u1 (copy), UpdateService (copy), u2 (copy), FormatData (copy)
    local v20 = FoodRecipeData.Recipes[p19];

    if not v20 then
        warn((`FoodData | No FoodData for food {p19}`));

        return;
    end;

    local v21 = Data.GardenGuide.FoodData[p19];

    if u1.FoodBlacklist[p19] then
        return;
    end;

    if not UpdateService:IsUpdateDone() and UpdateService:IsHiddenFromUpdate(p19) then
        return;
    end;

    u2.Data[p19] = FormatData(p19, v20, v21);

    if v21 and not table.find(u2.Unlocked, p19) then
        table.insert(u2.Unlocked, p19);
    end;
end;

function u2.RegatherData() -- Line: 179
    -- upvalues: u2 (copy), GatherData (copy)
    u2.Total = 0;
    GatherData();
end;

GatherData();

return u2;