-- Decompiled with Potassium's decompiler.

return {
    Scale = function(p1, p2) -- Line: 3, Name: Scale
        debug.profilebegin("PlantScale1");

        if p1:FindFirstChild("PlantModel") then
            p1:FindFirstChild("PlantModel"):ScaleTo(p2);

            return;
        end;

        for _, descendant in pairs(p1:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if descendant:GetAttribute("OG_SIZE") == nil then
                    descendant:SetAttribute("OG_SIZE", descendant.Size);
                end;

                descendant.Size = descendant:GetAttribute("OG_SIZE") * p2;
                descendant:IsA("MeshPart");
                local v3 = descendant:FindFirstChildOfClass("SpecialMesh");

                if v3 then
                    if v3:GetAttribute("OG_SCALE") == nil then
                        v3:SetAttribute("OG_SCALE", v3.Scale);
                    end;

                    v3.Scale = v3:GetAttribute("OG_SCALE") * p2;
                end;
            elseif descendant:IsA("Motor6D") then
                if descendant:GetAttribute("OG_C0") == nil and descendant:GetAttribute("OG_C1") == nil then
                    descendant:SetAttribute("OG_C0", descendant.C0);
                    descendant:SetAttribute("OG_C1", descendant.C1);
                end;

                local Attribute = descendant:GetAttribute("OG_C0");
                local Attribute2 = descendant:GetAttribute("OG_C1");
                descendant.C0 = CFrame.new(Attribute.Position * p2) * (Attribute - Attribute.Position);
                descendant.C1 = CFrame.new(Attribute2.Position * p2) * (Attribute2 - Attribute2.Position);
            end;
        end;

        debug.profileend();
    end
};