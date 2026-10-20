-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Remote = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("MoonCrafting"):WaitForChild("Remote");
local DataService = require(ReplicatedStorage.Modules.DataService);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local MoonCraftingConfigAccessor = require(ReplicatedStorage.Modules.Events.HarvestMoonEvent.MoonCrafting.MoonCraftingConfigAccessor);
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);

return {
    GetMoonData = function(p1) -- Line: 47, Name: GetMoonData
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if Data then
            return Data.MoonCraftingData;
        end;

        return nil;
    end,

    GetSummonsContributed = function(p2) -- Line: 62, Name: GetSummonsContributed
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if Data then
            Data = Data.HarvestMoonData;
        end;

        return Data and Data.SummonsContributed or 0;
    end,

    IsRecipeUnlocked = function(p3, p4) -- Line: 69, Name: IsRecipeUnlocked
        -- upvalues: MoonCraftingConfigAccessor (copy)
        return MoonCraftingConfigAccessor:IsRecipeUnlocked(p4, p3:GetSummonsContributed());
    end,

    GetSelectedRecipe = function(p5) -- Line: 74, Name: GetSelectedRecipe
        -- upvalues: MoonCraftingConfigAccessor (copy)
        local MoonData = p5:GetMoonData();

        if not (MoonData and MoonData.RecipeId) then
            return nil, nil;
        end;

        local Recipe = MoonCraftingConfigAccessor:GetRecipe(MoonData.RecipeId);

        if Recipe then
            return Recipe, MoonData.RecipeId;
        end;

        return nil, nil;
    end,

    GetSubmittedSlots = function(p6) -- Line: 92, Name: GetSubmittedSlots
        local v7 = {};
        local MoonData = p6:GetMoonData();

        if not (MoonData and MoonData.InputItems) then
            return v7;
        end;

        for i in MoonData.InputItems do
            v7[tostring(i)] = true;
        end;

        return v7;
    end,

    GetCraftingSlot = function(p8: table, p9: number) -- Line: 107, Name: GetCraftingSlot
        local MoonData = p8:GetMoonData();

        if MoonData and MoonData.CraftingItems then
            return MoonData.CraftingItems[p9];
        end;

        return nil;
    end,

    GetActiveCraftCount = function(p10) -- Line: 116, Name: GetActiveCraftCount
        local MoonData = p10:GetMoonData();

        return MoonData and MoonData.CraftingItems and #MoonData.CraftingItems or 0;
    end,

    IsReadyToCraft = function(p11) -- Line: 126, Name: IsReadyToCraft
        -- upvalues: CountDictionary (copy)
        local SelectedRecipe = p11:GetSelectedRecipe();

        if SelectedRecipe then
            return CountDictionary(p11:GetSubmittedSlots()) >= #SelectedRecipe.Inputs;
        end;

        return false;
    end,

    FindOpenSlotFor = function(p12: table, p13: string?, p14: string?) -- Line: 139, Name: FindOpenSlotFor
        if not (p13 and p14) then
            return nil;
        end;

        local SelectedRecipe = p12:GetSelectedRecipe();

        if not SelectedRecipe then
            return nil;
        end;

        local SubmittedSlots = p12:GetSubmittedSlots();

        for i, v in SelectedRecipe.Inputs do
            if not SubmittedSlots[tostring(i)] and v.ItemType == p13 then
                if v.ItemData.AcceptAllTypes or v.ItemData.ItemName == p14 then
                    return i;
                end;

                if v.ItemData.AcceptedNames then
                    local v15 = i;

                    for _, v2 in v.ItemData.AcceptedNames do
                        if v2 == p14 then
                            return v15;
                        end;
                    end;
                end;
            end;
        end;

        return nil;
    end,

    SetRecipe = function(p16: table, p17: string) -- Line: 178, Name: SetRecipe
        -- upvalues: Remote (copy)
        Remote:FireServer("SetRecipe", p17);
    end,

    InputItem = function(p18: table, p19: number, p20: any) -- Line: 182, Name: InputItem
        -- upvalues: Remote (copy)
        Remote:FireServer("InputItem", p19, p20);
    end,

    Craft = function(p21) -- Line: 186, Name: Craft
        -- upvalues: Remote (copy)
        Remote:FireServer("Craft");
    end,

    Claim = function(p22: table, p23: number) -- Line: 190, Name: Claim
        -- upvalues: Remote (copy)
        Remote:FireServer("Claim", p23);
    end,

    Cancel = function(p24) -- Line: 194, Name: Cancel
        -- upvalues: Remote (copy)
        Remote:FireServer("Cancel");
    end,

    AuthoriseSkip = function(p25: table, p26: number) -- Line: 198, Name: AuthoriseSkip
        -- upvalues: Remote (copy)
        Remote:FireServer("AuthoriseSkip", p26);
    end
};