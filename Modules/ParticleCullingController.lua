-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local IsBadDeviceHeuristic = require(ReplicatedStorage.Modules.OptimisationControllers.IsBadDeviceHeuristic);
local IsMobile = require(ReplicatedStorage.Modules.OptimisationControllers.IsMobile);
local _ = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local v15 = {
    Start = function(p1) -- Line: 19, Name: Start
        -- upvalues: UserInputService (copy), IsBadDeviceHeuristic (copy), IsMobile (copy), RunService (copy), workspace_CurrentCamera (copy), CollectionService (copy)
        UserInputService.InputBegan:Wait();
        task.wait(3);
        local u2 = IsBadDeviceHeuristic();
        local u3 = IsMobile();
        local table_create_ret = table.create(6);

        local function updateParticle(p4: boolean, p5: userdata) -- Line: 31
            p5.Enabled = p4;

            if not p4 and p5.ClassName ~= "Beam" then
                p5:Clear();
            end;
        end;

        local u6 = {};
        local u7 = u3 and 40 or 80;

        for _, child in workspace.Farm:GetChildren() do
            local Value = child.Important.Data.Farm_Number.Value;
            local Center_Point = child:WaitForChild("Center_Point", 5);

            if Center_Point then
                table_create_ret[Value] = Center_Point:GetPivot();

                local function onDescendantAdded(p8: userdata) -- Line: 50
                    -- upvalues: u2 (copy), u3 (copy), Value (copy), u6 (copy)
                    if p8:IsA("ParticleEmitter") or (p8:IsA("Trail") or p8:IsA("Beam")) then
                        if u2 or u3 and math.random() <= 0.5 then
                            task.delay(0, p8.Destroy, p8);

                            return;
                        end;

                        p8:AddTag((`{Value}_Particle`));
                        local v9 = u6[Value] == true;
                        p8.Enabled = v9;

                        if not v9 and p8.ClassName ~= "Beam" then
                            p8:Clear();
                        end;
                    end;
                end;

                local Plants_Physical = child.Important.Plants_Physical;
                Plants_Physical.DescendantAdded:Connect(onDescendantAdded);

                for _, descendant in Plants_Physical:GetDescendants() do
                    task.spawn(onDescendantAdded, descendant);
                end;
            else
                print("Center point part not found for farm", child);
            end;
        end;

        if u2 then
            return;
        end;

        local u10 = 0;
        local u11 = nil;
        RunService.PostSimulation:Connect(function(p12: number) -- Line: 77
            -- upvalues: u10 (ref), workspace_CurrentCamera (ref), u11 (ref), table_create_ret (copy), u7 (copy), u6 (copy), CollectionService (ref)
            u10 = u10 + p12;

            if u10 <= 0.1 then
                return;
            end;

            u10 = 0;
            local Position = workspace_CurrentCamera.CFrame.Position;
            local v13 = Position // 5;

            if u11 == nil or u11 ~= v13 then
                u11 = v13;

                for i, v in table_create_ret do
                    local v14 = vector.magnitude(Position - v.Position) <= u7;

                    if u6[i] ~= v14 then
                        u6[i] = v14;

                        for _, v2 in CollectionService:GetTagged((`{i}_Particle`)) do
                            v2.Enabled = v14;

                            if not v14 and v2.ClassName ~= "Beam" then
                                v2:Clear();
                            end;
                        end;
                    end;
                end;
            end;
        end);
    end
};
task.spawn(v15.Start, v15);

return v15;