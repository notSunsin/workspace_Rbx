-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u2 = {};
local u3 = {};
local u4 = 0;

local function Track(p5: userdata) -- Line: 29
    -- upvalues: u3 (copy)
    if not p5:IsA("Model") then
        return;
    end;

    if u3[p5] then
        return;
    end;

    u3[p5] = p5:GetPivot();
end;

local function Untrack(p6: userdata) -- Line: 41
    -- upvalues: u3 (copy)
    if not p6:IsA("Model") then
        return;
    end;

    local v7 = u3[p6];

    if not v7 then
        return;
    end;

    u3[p6] = nil;

    if p6.Parent then
        p6:PivotTo(v7);
    end;
end;

local function Step(p8: number) -- Line: 59
    -- upvalues: u4 (ref), u3 (copy)
    u4 = u4 + p8;
    local v9 = math.sin(u4 * 2.2) * 0.35;
    local v10 = math.sin(u4 * 1.5) * 0.12217304763960307;

    for i, v in u3 do
        if i:IsDescendantOf(workspace) then
            i:PivotTo(CFrame.new(v.Position) * CFrame.Angles(0, v10, 0) * v.Rotation + Vector3.new(0, v9, 0));
        end;
    end;
end;

function u2.Start() -- Line: 81
    -- upvalues: RunService (copy), CollectionService (copy), u3 (copy), Track (copy), Untrack (copy), Step (copy)
    if not RunService:IsClient() then
        return;
    end;

    for _, v in CollectionService:GetTagged("SummerShovelIdle") do
        if v:IsA("Model") then
            if not u3[v] then
                u3[v] = v:GetPivot();
            end;
        end;
    end;

    CollectionService:GetInstanceAddedSignal("SummerShovelIdle"):Connect(Track);
    CollectionService:GetInstanceRemovedSignal("SummerShovelIdle"):Connect(Untrack);
    RunService.Heartbeat:Connect(Step);
end;

local u11 = false;
EventRotationController.EventUpdated:Connect(function(p12: string, p13: string) -- Line: 100, Name: OnEventUpdated
    -- upvalues: u1 (copy), u11 (ref), u2 (copy)
    if p13 ~= "Summer2026Event" then
        u1:Clean();
        u11 = false;

        return;
    end;

    if p12 ~= "Summer2026EventPart4" then
        return;
    end;

    if u11 then
        return;
    end;

    u11 = true;
    u1:Clean();
    task.spawn(u2.Start);
end);

return u2;