-- Decompiled with Potassium's decompiler.

return {
    Init = function(p1) -- Line: 2
    end,

    StartListening = function(u2) -- Line: 3
        math.randomseed(u2.Item_Seed.Value);
        local v3 = require(game.ReplicatedStorage.Item_Module).Return_Data(u2.Name);
        local v4 = require(game.ReplicatedStorage.Calculate_Weight).Calculate_Weight(u2.Item_Seed.Value, u2.Name) * (u2:GetAttribute("WeightMulti") or 1);
        u2.Weight.Value = v4;
        require(game.ReplicatedStorage.Scale_Module);
        local u5 = nil;

        for _, descendant in pairs(u2:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                u5 = descendant;
            end;
        end;

        local MaxActivationDistance = u5.MaxActivationDistance;

        if v3 then
            local math_sqrt_ret = math.sqrt(u2.Weight.Value / v3[2] * 3);
            u2:ScaleTo((math.clamp(math_sqrt_ret, 0.1, 2.5)));
            u5.MaxActivationDistance = MaxActivationDistance;
            u2:AddTag("PlantScaled");
        end;

        local v6 = {};

        for _, descendant in pairs(u2:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant ~= u2.PrimaryPart then
                table.insert(v6, descendant);
            end;
        end;

        local u7 = {};
        local PrimaryPart = u2.PrimaryPart;

        if not u2:GetAttribute("NotRan") then
            u2:SetAttribute("NotRan", true);

            for _, v in pairs(v6) do
                PrimaryPart.CFrame:ToObjectSpace(v.CFrame);
            end;
        end;

        for _, v in pairs(v6) do
            local v8 = { v, v.Size, PrimaryPart.CFrame:ToObjectSpace(v.CFrame) };
            table.insert(u7, v8);
        end;

        task.wait(1);
        game:GetService("TweenService");
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
        local u9 = 0;

        for _, descendant in pairs(u2:GetDescendants()) do
            if not descendant:HasTag("Effect") and (descendant:IsA("BasePart") and (tonumber(descendant.Name) ~= nil and (tonumber(descendant.Name) and u9 <= tonumber(descendant.Name)))) then
                u9 = tonumber(descendant.Name);
            end;
        end;

        function UPD()
            -- upvalues: u2 (copy), u9 (ref), u5 (ref), u7 (copy), PrimaryPart (copy)
            local v10 = {};
            local v11 = u2.Grow.Age.Value + 1;

            if u9 + 1 <= v11 then
                u5.Enabled = true;
            else
                u5.Enabled = false;
            end;

            for i, v in u7 do
                local v12 = v[1];
                local v13 = tonumber(v12.Name);

                if v13 then
                    local math_clamp_ret = math.clamp(v11 - v13, 0, 1);

                    if math_clamp_ret >= 1 then
                        v12.Size = v[2];
                        v12.CFrame = PrimaryPart.CFrame * v[3];
                        v12.Transparency = 0;
                        v12.CanCollide = true;
                        table.insert(v10, i);
                    elseif math_clamp_ret <= 0.025 then
                        v12.Transparency = 1;
                        v12.Size = Vector3.new(v[2].X, v[2].Y * math_clamp_ret, v[2].Z);
                        v12.CFrame = PrimaryPart.CFrame * v[3] * CFrame.new(0, (v12.Size.Y - v[2].Y) / 2, 0);
                        v12.CanCollide = false;
                    else
                        v12.CFrame = PrimaryPart.CFrame * v[3] * CFrame.new(0, (v12.Size.Y - v[2].Y) / 2, 0);
                        v12.Size = Vector3.new(v[2].X, v[2].Y * math_clamp_ret, v[2].Z);
                        v12.Transparency = math.clamp(0.1 - math_clamp_ret, 0, 1);
                        v12.CanCollide = false;
                    end;
                end;
            end;

            for _, v in v10 do
                table.remove(u7, v);
            end;
        end;

        UPD();
        u2.Grow.Age:GetPropertyChangedSignal("Value"):Connect(UPD);
    end
};