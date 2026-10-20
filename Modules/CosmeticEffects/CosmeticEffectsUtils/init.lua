-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local script_CosmeticEffectProcessors = require(script.CosmeticEffectProcessors);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);

return {
    CollectAllTagged = function(p1: string, p2: string, p3: userdata) -- Line: 13, Name: CollectAllTagged
        -- upvalues: CollectionService (copy), script_CosmeticEffectProcessors (copy)
        local v4 = {};
        local Tagged = CollectionService:GetTagged(p1);
        local v5 = script_CosmeticEffectProcessors[p1];

        if v5 then
            for _, v in Tagged do
                if v:IsA(p2) and v:IsDescendantOf(p3) then
                    local v6 = v5(v);

                    if v6 then
                        table.insert(v4, v6);
                    end;
                end;
            end;

            return v4;
        end;

        warn((`No processor defined for {p1}`));

        return v4;
    end,

    IsPlayerOnFarm = function(p7: userdata) -- Line: 42, Name: IsPlayerOnFarm
        -- upvalues: GetFarmAsync (copy)
        local Character = p7.Character;

        if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
            return false;
        end;

        local v8 = GetFarmAsync(p7);

        if not v8 then
            return false;
        end;

        local PetArea = v8:FindFirstChild("PetArea", true);

        if not PetArea then
            return false;
        end;

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v9 = PetArea.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
        local v10 = PetArea.Size / 2;
        local v11;

        if math.abs(v9.X) <= v10.X then
            v11 = math.abs(v9.Z) <= v10.Z;
        else
            v11 = false;
        end;

        return v11;
    end,

    CreateCosmeticHighlight = function(p12: table, u13: userdata, u14: number) -- Line: 65, Name: CreateCosmeticHighlight
        -- upvalues: TweenService (copy)
        task.spawn(function() -- Line: 66
            -- upvalues: u13 (copy), u14 (copy), TweenService (ref)
            local Highlight = Instance.new("Highlight");
            Highlight.Adornee = u13;
            Highlight.FillColor = Color3.fromRGB(255, 255, 255);
            Highlight.FillTransparency = 0.85;
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
            Highlight.OutlineTransparency = 0.2;
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.Parent = u13;
            local v15 = TweenService:Create(Highlight, TweenInfo.new(u14, Enum.EasingStyle.Quad), {
                FillTransparency = 1,
                OutlineTransparency = 1
            });
            v15:Play();
            v15.Completed:Wait();
            Highlight:Destroy();
        end);
        task.delay(u14 - 0.5, function() -- Line: 87
            -- upvalues: u13 (copy), TweenService (ref)
            local Highlight = Instance.new("Highlight");
            Highlight.Adornee = u13;
            Highlight.FillColor = Color3.fromRGB(255, 255, 255);
            Highlight.FillTransparency = 1;
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
            Highlight.OutlineTransparency = 1;
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.Parent = u13;
            local v16 = Highlight:Clone();
            v16.FillTransparency = 0.25;
            v16.OutlineTransparency = 0.25;
            v16.Parent = u13;
            local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad);
            local v17 = TweenService:Create(Highlight, TweenInfo_new_ret, {
                FillTransparency = 0.25,
                OutlineTransparency = 0.25
            });
            local v18 = TweenService:Create(v16, TweenInfo_new_ret, {
                FillTransparency = 1,
                OutlineTransparency = 1
            });
            v17:Play();
            v17.Completed:Wait();
            Highlight:Destroy();
            v18:Play();
            v18.Completed:Wait();
            v16:Destroy();
        end);
    end
};