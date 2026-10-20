-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Observers = require(ReplicatedStorage.Modules.Observers);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u18 = {
    UpdateTranslation = function(p2: table, p3: number) -- Line: 26, Name: UpdateTranslation
        -- upvalues: u1 (copy)
        local math_exp_ret = math.exp(p3 * -15);

        for i, v in next, u1 do
            local v4;

            if v.TargetPart then
                v4 = v.TargetPart:GetPivot();
            else
                v4 = nil;
            end;

            if v4 and i:GetPivot():ToObjectSpace(v4).Z < 0 then
                local v5 = v.Head.CFrame.Position - v4.Position;
                local C0 = v.Neck.C0;
                local InitialNeckC0 = v.InitialNeckC0;
                local CFrame_Angles = CFrame.Angles;
                local v6 = v5.Y / vector.magnitude(v5);
                local v7 = math.atan(v6) * 0.5;
                local vector_normalize_ret = vector.normalize(v5);
                local v8 = InitialNeckC0 * CFrame_Angles(v7, 0, vector.cross(vector_normalize_ret, v.Torso.CFrame.LookVector).y * 0.8);
                v.Neck.C0 = v8:Lerp(C0, math_exp_ret);
            else
                v.Neck.C0 = v.InitialNeckC0:Lerp(v.Neck.C0, math_exp_ret);
            end;
        end;
    end,

    Update = function(p9) -- Line: 53, Name: Update
        -- upvalues: LocalPlayer (copy), u1 (copy)
        local Character = LocalPlayer.Character;
        local v10;

        if Character then
            v10 = Character:FindFirstChild("Head");
        else
            v10 = nil;
        end;

        local v11;

        if v10 then
            v11 = v10:GetPivot();
        else
            v11 = nil;
        end;

        for i, v in next, u1 do
            if v.Neck then
                local v12 = false;

                if v11 then
                    local v13 = v11.Position - i:GetPivot().Position;
                    v12 = vector.magnitude(v13) <= 30 and true or v12;
                end;

                if v12 then
                    v.TargetPart = v10;
                else
                    v.TargetPart = nil;
                end;
            end;
        end;
    end,

    AddNPC = function(p14: table, p15: userdata) -- Line: 78, Name: AddNPC
        -- upvalues: u1 (copy)
        local Torso = p15:WaitForChild("Torso");

        if not Torso then
            warn((`Failed to find Torso for npc "{p15:GetFullName()}"`));

            return;
        end;

        local Head = p15:WaitForChild("Head");

        if not Head then
            warn((`Failed to find Head for npc "{p15:GetFullName()}"`));

            return;
        end;

        local Neck = Torso:WaitForChild("Neck");

        if Neck then
            u1[p15] = {
                Torso = Torso,
                Head = Head,
                Neck = Neck,
                InitialNeckC0 = Neck.C0
            };

            return;
        end;

        warn((`Failed to find Neck for npc "{p15:GetFullName()}"`));
    end,

    RemoveNPC = function(p16: table, p17: userdata) -- Line: 106, Name: RemoveNPC
        -- upvalues: u1 (copy)
        u1[p17] = nil;
    end
};

function u18.Start(p19) -- Line: 110
    -- upvalues: Observers (copy), u18 (copy), RunService (copy)
    Observers.observeTag("NPCLookAt", function(u20) -- Line: 111
        -- upvalues: u18 (ref)
        u18:AddNPC(u20);

        return function() -- Line: 114
            -- upvalues: u18 (ref), u20 (copy)
            u18:RemoveNPC(u20);
        end;
    end, { workspace });
    local u21 = 0;
    RunService.PostSimulation:Connect(function(p22: number) -- Line: 120
        -- upvalues: u18 (ref), u21 (ref)
        u18:UpdateTranslation(p22);
        u21 = u21 + p22;

        if u21 < 0.05 then
            return;
        end;

        u21 = 0;
        u18:Update();
    end);
end;

task.spawn(u18.Start, u18);

return u18;