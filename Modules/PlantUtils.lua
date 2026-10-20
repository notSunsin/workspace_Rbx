-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");

return {
    GetPlantKeyFromModel = function(p1: userdata, p2: string) -- Line: 9, Name: GetPlantKeyFromModel
        local Attribute = p1:GetAttribute(p2);

        if Attribute then
            return Attribute;
        end;

        local Item_Seed = p1:FindFirstChild("Item_Seed");

        if Item_Seed then
            Item_Seed = Item_Seed.Value;
        end;

        if not Item_Seed then
            warn((`PlantUtils.GetPlantKeyFromModel | No seed found on {p1}!`));

            return nil;
        end;

        local Item_String = p1:FindFirstChild("Item_String");
        local v3 = Item_String and Item_String.Value or p1.Name;

        if v3 then
            return `{Item_Seed}-{v3}`;
        end;

        warn((`PlantUtils.GetPlantKeyFromModel | No type found on {p1}!`));

        return nil;
    end,

    IsPlantGrown = function(p4: userdata) -- Line: 37, Name: IsPlantGrown
        local Grow = p4:FindFirstChild("Grow");

        if not Grow then
            warn((`PlantUtils.IsPlantGrown | No "Grow" child found in {p4.Name} model!`));

            return false;
        end;

        local Attribute = p4:GetAttribute("MaxAge");

        if not Attribute then
            warn((`PlantUtils.IsPlantGrown | No "MaxAge" child found in {p4.Name} model!`));

            return false;
        end;

        local Age = Grow:FindFirstChild("Age");

        if Age then
            return Attribute <= Age.Value;
        end;

        warn((`PlantUtils.IsPlantGrown | No "Age" child found in {p4.Name} model!`));

        return false;
    end,

    GetPlayerFromPlantModel = function(p5: userdata) -- Line: 59, Name: GetPlayerFromPlantModel
        -- upvalues: Players (copy)
        local Attribute = p5:GetAttribute("Owner");

        if Attribute and Players:GetPlayerByUserId(Attribute) then
            return Players:GetPlayerByUserId(Attribute);
        end;

        local Parent = p5.Parent;

        if not Parent then
            warn("PlantUtils.GetPlayerFromPlantModel | \"Plants_Physical\" folder not found!");

            return nil;
        end;

        local Parent2 = Parent.Parent;

        if not Parent2 then
            warn("PlantUtils.GetPlayerFromPlantModel | \"Important\" folder not found!");

            return nil;
        end;

        local Data = Parent2:FindFirstChild("Data");

        if not Data then
            warn("PlantUtils.GetPlayerFromPlantModel | \"Data\" folder not found!");

            return nil;
        end;

        local Owner = Data:FindFirstChild("Owner");

        if not Owner then
            warn("PlantUtils.GetPlayerFromPlantModel | Owner StringValue not found!");

            return nil;
        end;

        local v6 = Players:FindFirstChild(Owner.Value);

        if v6 then
            return v6;
        end;

        warn("PlantUtils.GetPlayerFromPlantModel | Player not found!");

        return nil;
    end
};