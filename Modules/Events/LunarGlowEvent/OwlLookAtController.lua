-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Observers = require(ReplicatedStorage.Modules.Observers);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = nil;
local CFrame_Angles_ret = CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
local u5 = 0;
local u6 = nil;
local u7 = 0;

function u3.UpdateTranslation(p8: table, p9: number) -- Line: 40
    -- upvalues: u2 (copy), u4 (ref), u6 (ref), u5 (ref), u7 (ref), CFrame_Angles_ret (copy), TweenService (copy)
    local math_exp_ret = math.exp(p9 * -25);

    for i, v in next, u2 do
        local Head = i:FindFirstChild("Head");

        if Head then
            local v10;

            if v.TargetPart then
                v10 = v.TargetPart:GetPivot();
            else
                v10 = nil;
            end;

            if u4 == nil then
                u4 = Head.CFrame.YVector;
            end;

            if u6 ~= nil then
                local YVector = Head.CFrame.YVector;
                local XVector = Head.CFrame.XVector;
                local v11 = u6:Dot(YVector);
                local math_clamp_ret = math.clamp(v11, -1, 1);
                local math_acos_ret = math.acos(math_clamp_ret);
                local v12 = u6:Cross(YVector):Dot(XVector);
                local v13 = math_acos_ret * math.sign(v12);
                u5 = u5 + math.deg(v13);
            end;

            Head.Anchored = true;

            if u5 > 270 or u7 == 1 then
                u7 = u5 <= 75 and 0 or 1;
                v10 = CFrame.new(Head.Position.X - Head.CFrame.ZVector.X, Head.Position.Y - Head.CFrame.ZVector.Y, Head.Position.Z - Head.CFrame.ZVector.Z);
                math_exp_ret = math_exp_ret * 0.4;
            end;

            if u5 < -270 or u7 == 2 then
                u7 = u5 >= -75 and 0 or 2;
                v10 = CFrame.new(Head.Position.X + Head.CFrame.ZVector.X, Head.Position.Y + Head.CFrame.ZVector.Y, Head.Position.Z + Head.CFrame.ZVector.Z);
                math_exp_ret = math_exp_ret * 0.4;
            end;

            if v10 then
                local CFrame_lookAt_ret = CFrame.lookAt(Head.Position, v10.Position);
                local math_asin_ret = math.asin(CFrame_lookAt_ret.Rotation.LookVector.Y);
                local v14 = math.deg(math_asin_ret) - -15;

                if math.deg(math_asin_ret) < -15 then
                    CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame.Angles(-math.rad(v14), 0, 0);
                end;

                local v15 = {
                    CFrame = CFrame_lookAt_ret * CFrame_Angles_ret
                };
                TweenService:Create(Head, TweenInfo.new(math_exp_ret, Enum.EasingStyle.Linear), v15):Play();
            else
                local v16 = {
                    CFrame = CFrame.lookAt(Head.Position, Head.Position + u4) * CFrame_Angles_ret
                };
                TweenService:Create(Head, TweenInfo.new(math_exp_ret, Enum.EasingStyle.Linear), v16):Play();
            end;

            u6 = Head.CFrame.YVector;
        end;
    end;
end;

function u3.Update(p17) -- Line: 120
    -- upvalues: LocalPlayer (copy), u2 (copy)
    local Character = LocalPlayer.Character;
    local v18;

    if Character then
        v18 = Character:FindFirstChild("Head");
    else
        v18 = nil;
    end;

    local v19;

    if v18 then
        v19 = v18:GetPivot();
    else
        v19 = nil;
    end;

    for i, v in next, u2 do
        if v.Neck then
            local v20 = false;

            if v19 then
                local v21 = v19.Position - i:GetPivot().Position;
                v20 = vector.magnitude(v21) <= 100 and true or v20;
            end;

            if v20 then
                v.TargetPart = v18;
            else
                v.TargetPart = nil;
            end;
        end;
    end;
end;

function u3.AddNPC(p22: table, p23: userdata) -- Line: 145
    -- upvalues: u2 (copy)
    local Torso = p23:WaitForChild("Torso");

    if not Torso then
        warn((`Failed to find Torso for npc "{p23:GetFullName()}"`));

        return;
    end;

    local Head = p23:WaitForChild("Head");

    if not Head then
        warn((`Failed to find Head for npc "{p23:GetFullName()}"`));

        return;
    end;

    local Neck = Torso:WaitForChild("Neck");

    if Neck then
        u2[p23] = {
            Torso = Torso,
            Head = Head,
            Neck = Neck,
            InitialNeckC0 = Neck.C0
        };

        return;
    end;

    warn((`Failed to find Neck for npc "{p23:GetFullName()}"`));
end;

function u3.RemoveNPC(p24: table, p25: userdata) -- Line: 173
    -- upvalues: u2 (copy)
    u2[p25] = nil;
end;

function u3.Start(p26) -- Line: 177
    -- upvalues: Observers (copy), u3 (copy), u1 (copy), RunService (copy)
    Observers.observeTag("LunarGlowOwlLookAt", function(u27) -- Line: 178
        -- upvalues: u3 (ref)
        u3:AddNPC(u27);

        return function() -- Line: 181
            -- upvalues: u3 (ref), u27 (copy)
            u3:RemoveNPC(u27);
        end;
    end, { workspace });
    local u28 = 0;
    u1:Add(RunService.PostSimulation:Connect(function(p29: number) -- Line: 187
        -- upvalues: u3 (ref), u28 (ref)
        u3:UpdateTranslation(p29);
        u28 = u28 + p29;

        if u28 < 0.05 then
            return;
        end;

        u28 = 0;
        u3:Update();
    end));
end;

local u30 = false;
EventRotationController.EventUpdated:Connect(function(p31: string, p32: string) -- Line: 199, Name: OnEventUpdated
    -- upvalues: u1 (copy), u30 (ref), u3 (copy)
    if p32 ~= "LunarGlowEvent" then
        u1:Clean();
        u30 = false;

        return;
    end;

    if u30 then
        return;
    end;

    u30 = true;
    u1:Clean();
    task.spawn(u3.Start, u3);
end);

return u3;