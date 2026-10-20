-- Decompiled with Potassium's decompiler.

local v1 = {};

if game:GetService("RunService"):IsClient() then
    require(game.ReplicatedStorage.Modules.Maid);
    local Item_Module = require(game.ReplicatedStorage.Item_Module);
    local SeedData = require(game.ReplicatedStorage.Data.SeedData);

    local function WeldAllToPrimary(p2: userdata) -- Line: 15
        if not (p2 and p2:IsA("Model")) then
            return;
        end;

        local PrimaryPart = p2.PrimaryPart;

        if not PrimaryPart then
            return;
        end;

        local Descendants = p2:GetDescendants();

        for _, v in pairs(Descendants) do
            v.Anchored = false;
            v.CanCollide = false;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = PrimaryPart;
            WeldConstraint.Part1 = v;
            WeldConstraint.Parent = PrimaryPart;
        end;

        PrimaryPart.Anchored = false;
    end;

    local function GetRarityColor(p3: string) -- Line: 35
        -- upvalues: SeedData (copy), Item_Module (copy)
        local v4 = SeedData[p3];

        if not v4 then
            return Color3.fromRGB(255, 255, 255);
        end;

        local v5 = Item_Module.Return_Rarity_Data(v4.SeedRarity);

        if v5 then
            return Color3.new(v5[2]);
        end;

        return Color3.fromRGB(255, 255, 255);
    end;

    local function SetBoundingBox(p6: userdata) -- Line: 44
        local BoundingBox, v7 = p6:GetBoundingBox();
        local Part = Instance.new("Part");
        Part.Name = "PrimaryPart";
        Part.Size = v7;
        Part.CFrame = BoundingBox;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.Transparency = 1;
        Part.Parent = p6;
        p6.PrimaryPart = Part;
        p6:SetAttribute("ActualSize", v7.Magnitude);
    end;

    local function CreateTrail(p8: userdata) -- Line: 60
        -- upvalues: GetRarityColor (copy)
        local v9 = GetRarityColor(p8.Name);
        local v10 = script.Trails.Trail:Clone();
        local v11 = script.Trails.Trail2:Clone();
        local v12 = script.Trails.A1:Clone();
        local v13 = script.Trails.A0:Clone();
        local v14 = script.Trails.Stars:Clone();
        local v15 = {};
        local v16 = 0;

        for _, descendant in pairs(p8:GetDescendants()) do
            if descendant:IsA("BasePart") then
                local Color = descendant.BrickColor.Color;
                v15[Color] = (v15[Color] or 0) + 1;
                v16 = v16 + 1;
            end;
        end;

        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);

        if next(v15) then
            local v17 = 0;

            for i, v in pairs(v15) do
                if v17 < v then
                    Color3_fromRGB_ret = i;
                    v17 = v;
                end;
            end;
        else
            p8:GetAttribute("Rarity");
            Color3_fromRGB_ret = Color3_fromRGB_ret or Color3.new(v9);
        end;

        v10.Color = ColorSequence.new(Color3_fromRGB_ret);
        v11.Color = ColorSequence.new(Color3_fromRGB_ret);
        v14.Color = ColorSequence.new(Color3_fromRGB_ret);
        v13.Parent = p8.PrimaryPart;
        v12.Parent = p8.PrimaryPart;
        v10.Attachment0 = v13;
        v10.Attachment1 = v12;
        v11.Attachment0 = v13;
        v11.Attachment1 = v12;
        v10.Parent = p8.PrimaryPart;
        v11.Parent = p8.PrimaryPart;
        v14.Parent = p8.PrimaryPart;
    end;

    local function FlyingFruit(u18: userdata) -- Line: 115
        local Bezier_2 = require(game.ReplicatedStorage.Code.Bezier_2);
        local PrimaryPart = game.Players.LocalPlayer.Character.PrimaryPart;

        local function getRandomXZOffset() -- Line: 119
            local math_random_ret = math.random(-25, 25);

            return Vector3.new(math_random_ret, 0, math.random(-25, 25));
        end;

        local Position = u18.PrimaryPart.Position;
        local Position2 = PrimaryPart.Position;
        local math_random_ret = math.random(8, 12);
        local v19 = Position2 + Vector3.new(0, math_random_ret, 0);
        local math_random_ret2 = math.random(-25, 25);
        local v20 = v19 + Vector3.new(math_random_ret2, 0, math.random(-25, 25));
        local Position3 = PrimaryPart.Position;
        local math_random_ret3 = math.random(4, 6);
        local v21 = Position3 + Vector3.new(0, math_random_ret3, 0);
        local math_random_ret4 = math.random(-25, 25);
        local v22 = v21 + Vector3.new(math_random_ret4, 0, math.random(-25, 25));
        local v23 = Bezier_2.new(Position, v20, v22, PrimaryPart);
        u18.Parent = game.Workspace;
        local TweenInfo_new_ret = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0);
        local v24 = v23:CreateCFrameTween(u18.PrimaryPart, { "CFrame" }, TweenInfo_new_ret);

        if u18:GetAttribute("ActualSize") > 5 then
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = u18:GetScale();
            NumberValue.Parent = u18;
            NumberValue.Changed:Connect(function() -- Line: 144
                -- upvalues: u18 (copy), NumberValue (copy)
                u18:ScaleTo(NumberValue.Value);
            end);
            game:GetService("TweenService"):Create(NumberValue, TweenInfo_new_ret, {
                Value = 0.2
            }):Play();
        end;

        v24:Play();

        local function EmitAll(p25: table) -- Line: 155
            for _, v in next, p25 do
                if v.ClassName == "ParticleEmitter" then
                    v:Emit(v:GetAttribute("EmitCount"));
                end;
            end;
        end;

        v24.Completed:Connect(function() -- Line: 163
            -- upvalues: u18 (copy)
            for _, descendant in u18:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                    descendant.Anchored = true;
                elseif descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            game:GetService("Debris"):AddItem(u18, 1.2);
        end);
    end;

    function v1.StartCollection(p26: table, p27: userdata) -- Line: 178
        -- upvalues: WeldAllToPrimary (copy), CreateTrail (copy), FlyingFruit (copy)
        game:GetService("Debris"):AddItem(p27, 5);
        local BoundingBox, v28 = p27:GetBoundingBox();
        local Part = Instance.new("Part");
        Part.Name = "PrimaryPart";
        Part.Size = v28;
        Part.CFrame = BoundingBox;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.Transparency = 1;
        Part.Parent = p27;
        p27.PrimaryPart = Part;
        p27:SetAttribute("ActualSize", v28.Magnitude);
        WeldAllToPrimary(p27);
        p27.Parent = game.Workspace;
        CreateTrail(p27);
        FlyingFruit(p27);
    end;
end;

return v1;