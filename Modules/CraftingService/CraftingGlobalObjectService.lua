-- Decompiled with Potassium's decompiler.

game:GetService("ServerScriptService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CraftingGlobalObjectService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService");
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);
local CraftingObjectRegistry = require(ReplicatedStorage.Data.CraftingData.CraftingObjectRegistry);
local CraftingRecipeRegistry = require(ReplicatedStorage.Data.CraftingData.CraftingRecipeRegistry);
local DumpTable = require(ReplicatedStorage.Modules.DumpTable);
local u3 = {
    GetCraftingObjectData = function(p1: table, p2: userdata) -- Line: 20, Name: GetCraftingObjectData
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();
        local Attribute = p2:GetAttribute("CraftingObjectId");

        if not Attribute then
            error((`CraftingService:GetCraftingDataForModel passed CraftingObject: {p2:GetFullName()} does not have associated CraftingObjectId Attribute.`));

            return;
        end;

        if p2:GetAttribute("CraftingObjectType") then
            return Data.CraftingData.GlobalCraftingObjectData[Attribute];
        end;

        error((`CraftingService:GetCraftingDataForModel passed CraftingObject: {p2:GetFullName()} does not have associated CraftingObjectType Attribute.`));
    end
};

function u3.GetIndividualCraftingMachineData(p4: table, p5: userdata, p6: string) -- Line: 41
    -- upvalues: u3 (copy), CraftingRecipeRegistry (copy), CraftingObjectRegistry (copy), DumpTable (copy)
    local CraftingObjectData = u3:GetCraftingObjectData(p5);

    if not CraftingObjectData then
        return;
    end;

    local _ = CraftingRecipeRegistry.ItemRecipes[CraftingObjectData.RecipeId];

    if not CraftingRecipeRegistry then
        error((`CraftingService:GetIndividualCraftingMachineData passed RecipeId {p6} does not have associated CraftingRecipeRegistryData.`));

        return;
    end;

    if not p5:GetAttribute("CraftingObjectId") then
        error("CraftingService:GetIndividualCraftingMachineData passed CraftingObject: ", p5, "does not have associated CraftingObjectId Attribute.");

        return;
    end;

    local Attribute = p5:GetAttribute("CraftingObjectType");

    if Attribute then
        local v7 = CraftingObjectRegistry[Attribute];

        if v7.Slots[p6] then
            return CraftingObjectData.MachineData[p6];
        end;

        return warn("Could not get data cause foundslot does not exist for", p6, Attribute, DumpTable(v7.Slots));
    end;

    error("CraftingService:GetIndividualCraftingMachineData passed CraftingObject: ", p5, "does not have associated CraftingObjectType Attribute.");
end;

function u3.SetRecipe(p8: table, p9: userdata, p10: string, p11: string) -- Line: 54
    -- upvalues: CraftingGlobalObjectService (copy)
    return CraftingGlobalObjectService:FireServer("SetRecipe", p9, p10, p11);
end;

function u3.InputItem(p12: table, p13: userdata, p14: string, p15: number, p16: any) -- Line: 58
    -- upvalues: CraftingGlobalObjectService (copy)
    return CraftingGlobalObjectService:FireServer("InputItem", p13, p14, p15, p16);
end;

function u3.Craft(p17: table, p18: userdata, p19: string) -- Line: 62
    -- upvalues: CraftingGlobalObjectService (copy)
    return CraftingGlobalObjectService:FireServer("Craft", p18, p19);
end;

function u3.Claim(p20: table, p21: userdata, p22: string, p23: number) -- Line: 66
    -- upvalues: CraftingGlobalObjectService (copy)
    return CraftingGlobalObjectService:FireServer("Claim", p21, p22, p23);
end;

function u3.Skip(p24: table, p25: userdata, p26: string, p27: number) -- Line: 70
    -- upvalues: CraftingGlobalObjectService (copy)
    return CraftingGlobalObjectService:FireServer("AuthoriseSkip", p25, p26, p27);
end;

function u3.Cancel(p28: table, p29: userdata, p30: string) -- Line: 74
    -- upvalues: CraftingGlobalObjectService (copy)
    return CraftingGlobalObjectService:FireServer("Cancel", p29, p30);
end;

return u3;