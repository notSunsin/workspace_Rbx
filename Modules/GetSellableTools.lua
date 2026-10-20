-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);

local function IsHalloweenEventActive() -- Line: 12
    -- upvalues: RunService (copy), ReplicatedStorage (copy)
    local success, result = pcall(function() -- Line: 13
        -- upvalues: RunService (ref), ReplicatedStorage (ref)
        if not RunService:IsServer() then
            return require(ReplicatedStorage.Modules.EventRotation.EventRotationController):IsInEvent("Halloween2026Event");
        end;

        local ServerScriptService = game:GetService("ServerScriptService");

        return require(ServerScriptService.Modules.EventRotation.EventRotationService):IsInEvent("Halloween2026Event");
    end);

    if success then
        success = result == true;
    end;

    return success;
end;

local u1 = {
    MutationHandler:GetMutations().Pollinated_Poor,
    MutationHandler:GetMutations().Pollinated_Fair,
    MutationHandler:GetMutations().Pollinated_Good,
    MutationHandler:GetMutations().Pollinated_Godly
};

return function(p2: userdata, p3: boolean?, p4: boolean?) -- Line: 38
    -- upvalues: InventoryServiceEnums (copy), u1 (copy), PlantTraitsData (copy), RunService (copy), ReplicatedStorage (copy)
    local v5 = {};

    for _, child in p2:GetChildren() do
        if child:IsA("Tool") then
            local Item_String = child:FindFirstChild("Item_String");
            local Attribute = child:GetAttribute("PET_UUID");
            local v6 = child:HasTag("FoodTool");

            if not child:GetAttribute(InventoryServiceEnums.Favorite) or p3 then
                if Item_String then
                    local v7 = child;
                    local v8 = false;

                    for _, v in u1 do
                        if v7:GetAttribute(v.Name) then
                            v8 = true;
                            break;
                        end;
                    end;

                    if not (v8 and (Item_String.Value ~= "" and PlantTraitsData.HasTrait(Item_String.Value, "Honey"))) then
                        if Item_String.Value == "" or not PlantTraitsData.HasTrait(Item_String.Value, "HalloweenSlot") then
                            table.insert(v5, v7);
                        else
                            local success, result = pcall(function() -- Line: 13
                                -- upvalues: RunService (ref), ReplicatedStorage (ref)
                                if not RunService:IsServer() then
                                    return require(ReplicatedStorage.Modules.EventRotation.EventRotationController):IsInEvent("Halloween2026Event");
                                end;

                                local ServerScriptService = game:GetService("ServerScriptService");

                                return require(ServerScriptService.Modules.EventRotation.EventRotationService):IsInEvent("Halloween2026Event");
                            end);

                            if success then
                                success = result == true;
                            end;

                            if not success then
                                table.insert(v5, v7);
                            end;
                        end;
                    end;
                elseif p4 and (Attribute or v6) then
                    table.insert(v5, child);
                end;
            end;
        end;
    end;

    return v5;
end;