-- Decompiled with Potassium's decompiler.

local v1 = {};
require(game.ReplicatedStorage.Code.SolveIK);
local LocalPlayer = game.Players.LocalPlayer;
local u2 = {};
local u3 = false;

local function ShakeBody(p4) -- Line: 9
    -- upvalues: LocalPlayer (copy), u3 (ref)
    local v5 = p4 or LocalPlayer.Character;

    repeat
        task.wait();
    until v5:IsDescendantOf(workspace);

    if v5:GetAttribute("Shaking") then
        return;
    end;

    v5:SetAttribute("Shaking", true);
    local Torso = v5:WaitForChild("Torso");
    local Neck = Torso:WaitForChild("Neck");
    local v6 = Torso:WaitForChild("Left Shoulder");
    local v7 = Torso:WaitForChild("Right Shoulder");
    local v8 = Torso:WaitForChild("Left Hip");
    local v9 = Torso:WaitForChild("Right Hip");
    local C0 = v6.C0;
    local C02 = v7.C0;
    local C03 = v8.C0;
    local C04 = v9.C0;
    local C05 = Neck.C0;
    local v10 = 0;

    while v5:IsDescendantOf(workspace) and u3 do
        task.wait(0);
        v10 = v10 + 1;
        local CFrame_Angles = CFrame.Angles;
        local v11 = math.sin(v10) * 1;
        v6.C0 = C0 * CFrame_Angles(0, math.rad(v11), 0);
        local CFrame_Angles2 = CFrame.Angles;
        local v12 = math.sin(v10) * -1;
        v7.C0 = C02 * CFrame_Angles2(0, math.rad(v12), 0);
        local CFrame_Angles3 = CFrame.Angles;
        local v13 = math.sin(v10) * -1;
        v9.C0 = C04 * CFrame_Angles3(0, math.rad(v13), 0);
        local CFrame_Angles4 = CFrame.Angles;
        local v14 = math.sin(v10) * 1;
        v8.C0 = C03 * CFrame_Angles4(0, math.rad(v14), 0);
        local CFrame_Angles5 = CFrame.Angles;
        local v15 = math.sin(v10) * 1;
        Neck.C0 = C05 * CFrame_Angles5(0, 0, (math.rad(v15)));
    end;

    v6.C0 = C0;
    v7.C0 = C02;
    v8.C0 = C03;
    v9.C0 = C04;
    Neck.C0 = C05;
    v5:SetAttribute("Shaking", false);
end;

function v1.EnableShaking() -- Line: 65
    -- upvalues: LocalPlayer (copy), ShakeBody (copy), u2 (copy), u3 (ref)
    if LocalPlayer.Character then
        task.spawn(ShakeBody);
    end;

    table.insert(u2, LocalPlayer.CharacterAdded:Connect(ShakeBody));
    u3 = true;
end;

function v1.DisableShaking() -- Line: 74
    -- upvalues: u2 (copy), u3 (ref)
    for _, v in u2 do
        v:Disconnect();
    end;

    u3 = false;
end;

return v1;