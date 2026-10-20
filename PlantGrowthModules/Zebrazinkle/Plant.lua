-- Decompiled with Potassium's decompiler.

local function isFruitPart(p1: userdata) -- Line: 1
    local v2 = p1:FindFirstAncestorWhichIsA("Model");

    return game:GetService("CollectionService"):HasTag(v2, "Harvestable") and true or v2.Parent.Name == "Fruits";
end;

game:GetService("RunService"):IsServer();

return {
    Init = function(p3) -- Line: 11
        math.randomseed(p3.Item_Seed.Value);
        local Trunk = p3.Trunk;
        Trunk.Name = "1";
        local math_random_ret = math.random(3, 4);
        local v4 = math.random(2, 4) + math_random_ret;
        Trunk.Size = Vector3.new(math_random_ret + 1, v4, math_random_ret + 1);
        local v5 = { Color3.new(0, 0.666667, 0), Color3.new(0.0980392, 0.666667, 0), Color3.new(0.0666667, 0.666667, 0.0666667) };
        local v6 = v5[math.random(1, #v5)];
        local v7 = 1;
        local v8 = {};
        local v9 = {};
        table.insert(v9, Trunk);

        if math.random(1, 2) == 1 then
            local math_random_ret2 = math.random(-7, 7);
            local math_rad_ret = math.rad(math_random_ret2);
            local math_random_ret3 = math.random(-7, 7);
            local math_rad_ret2 = math.rad(math_random_ret3);

            for i = 1, math_random_ret do
                local v10 = Trunk:Clone();
                v7 = v7 + 1;
                v10.Name = tostring(v7);
                v10.Parent = p3;
                local v11 = math.random(7, 11) - math_random_ret * 0.1;
                v10.Size = Vector3.new(Trunk.Size.X * 0.7, v11, Trunk.Size.Z * 0.7);
                math_rad_ret = math_rad_ret * 1.25;
                math_rad_ret2 = math_rad_ret2 * 1.25;
                v10.CFrame = Trunk.CFrame * CFrame.new(0, Trunk.Size.Y / 2, 0) * CFrame.Angles(math_rad_ret, 0, math_rad_ret2) * CFrame.new(0, v10.Size.Y / 2, 0);
                v10.CFrame = v10.CFrame * CFrame.new(0, -0.25, 0);
                table.insert(v9, v10);
                Trunk = v10;
                local _ = i;
            end;
        else
            for i = 1, math_random_ret do
                local v12 = Trunk:Clone();
                v7 = v7 + 1;
                v12.Name = tostring(v7);
                v12.Parent = p3;
                local math_random_ret2 = math.random(7, 11);
                v12.Size = Vector3.new(Trunk.Size.X * 0.7, math_random_ret2, Trunk.Size.Z * 0.7);
                local math_random_ret3 = math.random(-7, 7);
                local math_rad_ret = math.rad(math_random_ret3);
                local math_random_ret4 = math.random(-7, 7);
                local math_rad_ret2 = math.rad(math_random_ret4);
                v12.CFrame = Trunk.CFrame * CFrame.new(0, Trunk.Size.Y / 2, 0) * CFrame.Angles(math_rad_ret, 0, math_rad_ret2) * CFrame.new(0, v12.Size.Y / 2, 0);
                v12.CFrame = v12.CFrame * CFrame.new(0, -0.25, 0);
                table.insert(v9, v12);
                Trunk = v12;
                local _ = i;
            end;
        end;

        task.spawn(function() -- Line: 123
        end);

        if Trunk then
            local math_random_ret2 = math.random(5, 7);
            local v13 = 360 / math_random_ret2;
            local math_random_ret3 = math.random(4, 5);
            local v14 = 0;

            while math_random_ret2 >= 1 do
                math_random_ret2 = math_random_ret2 - 1;
                v14 = v14 + v13;
                local v15 = math_random_ret3 * math.random(8, 12) * 0.1;
                local v16 = Trunk.CFrame * CFrame.new(0, Trunk.Size.Y / 2, 0);
                local v17 = Trunk:Clone();
                v7 = v7 + 1;
                v17.Name = tostring(v7);
                v17.Parent = p3;
                v17.Color = Color3.new(0, 0.666667, 0);
                v17.Size = Vector3.new(v15, 1, 2);
                v17.CFrame = v16;
                v17.CFrame = v17.CFrame * CFrame.Angles(0, math.rad(v14), 0.4363323129985824);
                v17.CFrame = v17.CFrame * CFrame.new(v17.Size.X / 2, 0, 0);
                v17.Color = v6;
                table.insert(v8, v17);

                for i = 1, 3 do
                    local v18 = v17:Clone();
                    v7 = v7 + 1;
                    v18.Name = tostring(v7);
                    v18.Parent = p3;
                    math.random(7, 11);
                    v18.Size = Vector3.new(v15, v17.Size.Y * 1, v17.Size.Z * 1);
                    local math_rad_ret = math.rad(v15 * 5);
                    v18.CFrame = v17.CFrame * CFrame.new(v17.Size.X / 2, 0, 0) * CFrame.Angles(0, 0, -math_rad_ret) * CFrame.new(v18.Size.X / 2, 0, 0);
                    v18.Color = v6;
                    table.insert(v8, v18);
                    v17 = v18;
                    local _ = i;
                end;
            end;
        end;

        for i, v in pairs(v8) do
            v.Size = Vector3.new(v.Size.Y, v.Size.X, v.Size.Z);
            v.CFrame = v.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
            v.CFrame = v.CFrame * CFrame.Angles(3.141592653589793, 0, 0);
            local v19 = p3.Fruit_Spawn:FindFirstChild((`Spawn_Point_{i}`)) or Instance.new("Part");
            v19.Size = Vector3.new(1, 1, 1);
            v19.Anchored = true;
            v19.CanCollide = false;
            v19.Transparency = 1;
            v19.CFrame = v.CFrame * CFrame.new(-v.Size.X / 2, 0, 0);
            v19.Name = "Spawn_Point";
            v19.Parent = p3.Fruit_Spawn;
            v19.CFrame = v19.CFrame * CFrame.Angles(0, 0, -1.5707963267948966);
        end;

        return true;
    end,

    StartListening = function(u20) -- Line: 237
        math.randomseed(u20.Item_Seed.Value);
        local v21 = require(game.ReplicatedStorage.Item_Module).Return_Data(u20.Name);
        local v22 = require(game.ReplicatedStorage.Calculate_Weight).Calculate_Weight(u20.Item_Seed.Value, u20.Name) * (u20:GetAttribute("WeightMulti") or 1);
        u20.Weight.Value = v22;
        require(game.ReplicatedStorage.Scale_Module);

        if v21 then
            u20:ScaleTo(u20.Weight.Value / v21[2]);
            u20:AddTag("PlantScaled");
        end;

        local v23 = {};

        for _, descendant in pairs(u20:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant ~= u20.PrimaryPart then
                table.insert(v23, descendant);
            end;
        end;

        local PrimaryPart = u20.PrimaryPart;
        local u24 = {};

        for _, v in pairs(v23) do
            PrimaryPart.CFrame:ToObjectSpace(v.CFrame);
        end;

        local u25 = {};

        local function GetAddedPart(p26: userdata) -- Line: 273
            -- upvalues: u24 (copy), PrimaryPart (copy), u25 (copy)
            if not p26.Parent then
                return;
            end;

            if p26.Parent.Name ~= "Fruit_Spawn" then
                p26.Transparency = 1;
                local v27 = { p26, p26.Size, PrimaryPart.CFrame:ToObjectSpace(p26.CFrame) };
                table.insert(u24, v27);
            end;

            if p26.Parent.Name == "Fruit_Spawn" then
                table.insert(u25, {
                    Part = p26,
                    CFrame = p26.CFrame
                });
            end;
        end;

        u20.DescendantAdded:Connect(function(p28) -- Line: 289
            -- upvalues: GetAddedPart (copy)
            if not p28:IsA("BasePart") then
                return;
            end;

            local v29 = p28:FindFirstAncestorWhichIsA("Model");

            if game:GetService("CollectionService"):HasTag(v29, "Harvestable") and true or v29.Parent.Name == "Fruits" then
                return;
            end;

            if p28:HasTag("Effect") then
                return;
            end;

            p28.Transparency = 1;
            GetAddedPart(p28);
        end);

        for _, v in pairs(v23) do
            if v ~= PrimaryPart then
                local v30 = v:FindFirstAncestorWhichIsA("Model");

                if not game:GetService("CollectionService"):HasTag(v30, "Harvestable") and v30.Parent.Name ~= "Fruits" then
                    GetAddedPart(v);
                end;
            end;
        end;

        local v31 = 0;

        for _, descendant in pairs(u20:GetDescendants()) do
            if descendant:IsA("BasePart") and (descendant.Parent.Name ~= "Fruit_Spawn" and (tonumber(descendant.Name) ~= nil and (tonumber(descendant.Name) and v31 <= tonumber(descendant.Name)))) then
                v31 = tonumber(descendant.Name);
            end;
        end;

        local function UPD() -- Line: 319
            -- upvalues: u20 (copy), u25 (copy), u24 (copy), PrimaryPart (copy)
            local v32 = u20.Grow.Age.Value + 1;

            for _, v in u25 do
                v.Part.CFrame = v.CFrame;
            end;

            for _, v in u24 do
                local v33 = v[1];
                local v34 = tonumber(v33.Name);

                if v34 then
                    local math_clamp_ret = math.clamp(v32 - v34, 0, 1);

                    if v[3] ~= nil and v[2] ~= nil then
                        local v35 = v[2];
                        local v36 = PrimaryPart.CFrame * v[3];

                        if math_clamp_ret >= 1 then
                            v33.Size = v35;
                            v33.CFrame = v36;
                            v33.Transparency = 0;
                            v33.CanCollide = true;
                        elseif math_clamp_ret <= 0.025 then
                            v33.Transparency = 1;
                            v33.Size = Vector3.new(v35.X, v35.Y * math_clamp_ret, v35.Z);
                            v33.CFrame = v36 * CFrame.new(0, (v33.Size.Y - v35.Y) / 2, 0);
                            v33.CanCollide = false;
                        else
                            v33.CFrame = v36 * CFrame.new(0, (v33.Size.Y - v35.Y) / 2, 0);
                            v33.Size = Vector3.new(v35.X, v35.Y * math_clamp_ret, v35.Z);
                            v33.Transparency = math.clamp(0.1 - math_clamp_ret, 0, 1);
                            v33.CanCollide = false;
                        end;

                        if v33:FindFirstChild("ClimbPart") then
                            for _, child in v33:GetChildren() do
                                local Attribute = child:GetAttribute("StudHeight");

                                if Attribute then
                                    if Attribute <= v33.Size.Y and (v33.Size.Y > 1 and v33.Transparency ~= 1) then
                                        child.CanCollide = true;
                                    else
                                        child.CanCollide = false;
                                    end;
                                else
                                    child.CanCollide = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        UPD();
        u20.Grow.Age:GetPropertyChangedSignal("Value"):Connect(UPD);
    end
};